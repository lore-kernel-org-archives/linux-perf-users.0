Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffrPuI6A"
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A336E100
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 02:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RNEwfbDbJ86pvqZWuQNi9RT+2L+t/+EiesqSiaL5nqY=; b=ffrPuI6Al9WkfuAguq/vI9Dr5B
	k8E1pGyEFOmxpMVjfU5/5UM12RXhSj8miFxN0N1TFLQfmD4BO9NHEb6HEALth6CIArMMlPeZ1Rdf8
	kRBjPOzyXv124DFXtimoje57MUwb91PM36WV7YcpBUHcGmFEu/UdMp1ulHotSdosEpwR/2Nvs7TlE
	a+0HtJfOuguhtq8Dw9rPEmJXwpLRUG6GmNmpaUEulL3k2zzN7GAFE2dWPqGnvS2V2ulS1+1VM4oi9
	BihhqZCoR0ugROn7zhBmPwI3VCYxHsSY9H5XDdQBqYNYE8ZiXVwkSnTFvyJfTxifYXfCvc79nhgHa
	syVikdlg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r5k9E-00CH9m-1V;
	Wed, 22 Nov 2023 10:07:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 266223005AA; Wed, 22 Nov 2023 11:07:56 +0100 (CET)
Date: Wed, 22 Nov 2023 11:07:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: REGRESSION linux-next since Nov 16th, perf tool broken (at least
 on s390)
Message-ID: <20231122100756.GP8262@noisy.programming.kicks-ass.net>
References: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>

On Wed, Nov 22, 2023 at 08:38:28AM +0100, Thomas Richter wrote:
> perf tool fails on linux-next since Nov 16th on s390 when invoking perf on
> any PMU event, as in
> 
>   # perf stat -e cycles -- true
> 
>    Performance counter stats for 'true':
> 
>      <not supported>      cycles                                                               
> 
>        0.000598399 seconds time elapsed
> 
>        0.000055000 seconds user
>        0.000567000 seconds sys
> 
>   # perf stat -e pai_ext/NNPA_ALL/ -C0 -- true
>   event syntax error: 'pai_ext/NNPA_ALL/'
>                        \___ Bad event or PMU
> 
>   Unable to find PMU or event on a PMU of 'pai_ext'
> 
>   Initial error:
>   event syntax error: 'pai_ext/NNPA_ALL/'
>                        \___ Cannot find PMU `pai_ext'. Missing kernel support?
>   #
> 
> This error is caused by following commit, which got into linux-next around November 15th:
> 
> commit 652ffc2104ec1f69dd4a46313888c33527145ccf
> Author: Greg KH <gregkh@linuxfoundation.org>
> Date:   Mon Jun 12 15:09:09 2023 +0200
> 
>     perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file
> 
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Link: https://lkml.kernel.org/r/2023061204-decal-flyable-6090@gregkh
> 
> This commit adds function pmu_dev_is_visible() as the PMU bus function
> to make sysfs attribute files visible.
> On a failing system these sysfs attribute files are exported:

Does this help? I'm not entirely sure on the is_visible thing, but the
way I understand it, it was only supposed to hide the nr_filters thing,
not the entire group and @n helps select the attribute.

Greg, did I get that right?

Also, spurious return... clearly I should've woken up before merging
that patch... oh well.

---

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f0c45ab8d7d..59b332cce9e7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11417,12 +11417,10 @@ static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int
 	struct device *dev = kobj_to_dev(kobj);
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	if (!pmu->nr_addr_filters)
+	if (n == 2 && !pmu->nr_addr_filters)
 		return 0;
 
 	return a->mode;
-
-	return 0;
 }
 
 static struct attribute_group pmu_dev_attr_group = {
