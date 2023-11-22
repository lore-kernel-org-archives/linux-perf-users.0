Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DW8JvvFo"
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E2109
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AbU2ywlnhxG18H71Npk5cLri3wlU5L1cESsC7FGp4Tc=; b=DW8JvvFo4LkmWN5URqdMdvZZFb
	5y1GlR6PGifaRRaqNlnGKgJqWynLQHHHod2F6V3jVwv6rvEWE1Bc/kAcJzpBaqnIA+7liqSKl+FLu
	nJg3CQzRJ68wciSCYFa0XvrQXpVkzcV9b8QoZlusKxn5g+pT8+92A/J2ofbIHtlE1MWfpz463u0Lo
	EzXnOrnWN9VLw3hVfaIjpYv9IQfQVSTivzoKrAaCWfBQhaUCmCWQHIm29og3OSQE6/AwhiGqzbGeO
	jED62NRE7cwquxmbeptue8zIdGlSdcC52Lzj5AIiDoO9mm2X+3I4VGzVroRSASOzqXC2d6BHmdjRt
	xXMiKlMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r5p9z-006eLS-OX; Wed, 22 Nov 2023 15:29:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6715C3005AA; Wed, 22 Nov 2023 16:29:02 +0100 (CET)
Date: Wed, 22 Nov 2023 16:29:02 +0100
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
Message-ID: <20231122152902.GJ3818@noisy.programming.kicks-ass.net>
References: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>
 <20231122100756.GP8262@noisy.programming.kicks-ass.net>
 <375537e9-1382-4e27-88df-3c636e72f69d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <375537e9-1382-4e27-88df-3c636e72f69d@linux.ibm.com>

On Wed, Nov 22, 2023 at 03:38:36PM +0100, Thomas Richter wrote:
> On 11/22/23 11:07, Peter Zijlstra wrote:
> > On Wed, Nov 22, 2023 at 08:38:28AM +0100, Thomas Richter wrote:
> >> perf tool fails on linux-next since Nov 16th on s390 when invoking perf on
> >> any PMU event, as in
> >>
> >>   # perf stat -e cycles -- true
> >>
> >>    Performance counter stats for 'true':
> >>
> >>      <not supported>      cycles                                                               
> >>
> >>        0.000598399 seconds time elapsed
> >>
> >>        0.000055000 seconds user
> >>        0.000567000 seconds sys
> >>
> >>   # perf stat -e pai_ext/NNPA_ALL/ -C0 -- true
> >>   event syntax error: 'pai_ext/NNPA_ALL/'
> >>                        \___ Bad event or PMU
> >>
> >>   Unable to find PMU or event on a PMU of 'pai_ext'
> >>
> >>   Initial error:
> >>   event syntax error: 'pai_ext/NNPA_ALL/'
> >>                        \___ Cannot find PMU `pai_ext'. Missing kernel support?
> >>   #
> >>
> >> This error is caused by following commit, which got into linux-next around November 15th:
> >>
> >> commit 652ffc2104ec1f69dd4a46313888c33527145ccf
> >> Author: Greg KH <gregkh@linuxfoundation.org>
> >> Date:   Mon Jun 12 15:09:09 2023 +0200
> >>
> >>     perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file
> >>
> >>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>     Link: https://lkml.kernel.org/r/2023061204-decal-flyable-6090@gregkh
> >>
> >> This commit adds function pmu_dev_is_visible() as the PMU bus function
> >> to make sysfs attribute files visible.
> >> On a failing system these sysfs attribute files are exported:
> > 
> > Does this help? I'm not entirely sure on the is_visible thing, but the
> > way I understand it, it was only supposed to hide the nr_filters thing,
> > not the entire group and @n helps select the attribute.
> > 
> > Greg, did I get that right?
> 
> Yes, the is_visible call back function hides whole group, not just this
> one attribute.
> 
> static struct attribute *pmu_dev_attrs[] = {    <--- This group controlled by is_visibly                              
>         &dev_attr_type.attr,                                                  
>         &dev_attr_perf_event_mux_interval_ms.attr,                            
>         &dev_attr_nr_addr_filters.attr,                                       
>         NULL,                                                                 
> };    
> static struct attribute_group pmu_dev_attr_group = {                          
>         .is_visible = pmu_dev_is_visible,                                     
>         .attrs = pmu_dev_attrs,                                               
> };
> 
> So is_visible call back hides whole pmu_dev_attrs group with all 3 files.

Right, so patchlet I send should only result in hiding n==2, which is
that nr_addr_filters thing IIUC.
