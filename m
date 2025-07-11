Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB82ED859;
	Fri, 11 Jul 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250127; cv=none; b=ppOq+igogLqvU4Z8zTAFMXwZ8odA0q++m5kR9D9T9GU0hh4hqYvLLg0rRDxCLb04AD0VqTTdoZBLNDUsWXvsxoI4jS41GqWwmDTeltiRl1Q9onadG8O6HLp7B2iFB+doRWomIqO4jCVoDdBPmINJlAfNNH5Y/WGI5WjwzFXx/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250127; c=relaxed/simple;
	bh=6tEO9X1L4/fS17NKECopBhl3MciyVNfnGz1gRoGwBmg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gD07VgO6EOccp3cvwmlcWJFtrR64LdbnHsy6tTD/OydC0Vt0H5YnWshqYkWtsJdAaJ+FyHhkGfGL0ELVHlDDwyrsE5+d9w3QwEjGPIOMPNH888ImiDk1zSfmsnyOi/aX0HfUd/lQeKTLDQRRA44jSZusc6QVwTXLQr2QkcZLMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdxPt6dkMz6L56p;
	Sat, 12 Jul 2025 00:05:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 670101400D3;
	Sat, 12 Jul 2025 00:08:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 18:08:40 +0200
Date: Fri, 11 Jul 2025 17:08:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mike Leach <mike.leach@linaro.org>
CC: Alireza Sanaee <alireza.sanaee@huawei.com>, <krzk@kernel.org>,
	<robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <ruanjinjie@huawei.com>,
	<saravanak@google.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 3/5] coresight: cti: Use of_cpu_phandle_to_id for
 grabbing CPU id
Message-ID: <20250711170839.0000688c@huawei.com>
In-Reply-To: <CAJ9a7VhfW2RYXv6ZO28m65C75iyJUqTYos1tFXs8gAG5gx9yDA@mail.gmail.com>
References: <20250708151502.561-1-alireza.sanaee@huawei.com>
	<20250708151502.561-4-alireza.sanaee@huawei.com>
	<CAJ9a7VhfW2RYXv6ZO28m65C75iyJUqTYos1tFXs8gAG5gx9yDA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 16:55:15 +0100
Mike Leach <mike.leach@linaro.org> wrote:

> Hi,
> 
> On Tue, 8 Jul 2025 at 16:16, Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
> >
> > Use the newly created API to grab CPU id.
> >
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >  .../hwtracing/coresight/coresight-cti-platform.c   | 14 +-------------
> >  1 file changed, 1 insertion(+), 13 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> > index d0ae10bf6128..e1dc559d54aa 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> > @@ -41,20 +41,8 @@
> >   */
> >  static int of_cti_get_cpu_at_node(const struct device_node *node)
> >  {
> > -       int cpu;
> > -       struct device_node *dn;
> > +       int cpu = of_cpu_phandle_to_id(node, NULL, 0);
> >
> > -       if (node == NULL)
> > -               return -1;
> > -
> > -       dn = of_parse_phandle(node, "cpu", 0);
> > -       /* CTI affinity defaults to no cpu */
> > -       if (!dn)
> > -               return -1;
> > -       cpu = of_cpu_node_to_id(dn);
> > -       of_node_put(dn);
> > -
> > -       /* No Affinity  if no cpu nodes are found */  
> 
> Leave the above comment in place.
> 
> >         return (cpu < 0) ? -1 : cpu;
> >  }
> >
> > --
> > 2.43.0
> >  
> 
> With that
> 
> Reviewed-by: Mike Leach <mike.leach@linro.org>
Just in case Ali doesn't notice - typo in your address Mike!
(usually it is me who manages that ;)


