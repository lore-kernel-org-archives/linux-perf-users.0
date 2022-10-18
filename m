Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815A3C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Oct 2022 11:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJRL0N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Oct 2022 07:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJRL0M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2022 07:26:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29FFA99DF;
        Tue, 18 Oct 2022 04:26:11 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MsBNh4CW2z687L9;
        Tue, 18 Oct 2022 19:25:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 18 Oct 2022 13:26:09 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 12:26:09 +0100
Date:   Tue, 18 Oct 2022 12:26:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-perf-users@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v2 3/4] cxl: CXL Performance Monitoring Unit driver
Message-ID: <20221018122608.0000476e@huawei.com>
In-Reply-To: <a0465d07-8f64-fb55-f184-d7e7e0a6b5e9@intel.com>
References: <20220824103617.21781-1-Jonathan.Cameron@huawei.com>
        <20220824103617.21781-4-Jonathan.Cameron@huawei.com>
        <a0465d07-8f64-fb55-f184-d7e7e0a6b5e9@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 22 Sep 2022 13:19:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 8/24/2022 3:36 AM, Jonathan Cameron wrote:
> > CXL rev 3.0 introduces a standard performance monitoring hardware
> > block to CXL. Instances are discovered using CXL Register Locator DVSEC
> > entries. Each CXL component may have multiple PMUs.
> >
> > This initial driver supports on a subset of types of counter.
> > It support counters that are either fixed or configurable, but requires
> > that they support the ability to freeze and write value whilst frozen.
> >
> > Development done with QEMU model which will be posted shortly.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> Besides couple nits in comments below, Reviewed-by: Dave Jiang 
> <dave.jiang@intel.com>
Thanks,

> >> > +/*
> > + * Reset ensures no possibility of any information leaking to wrong
> > + * counter. Note that all fields written during start()
> > + */
> > +static void cpmu_reset_counter(struct cpmu_info *info, int idx)
> > +{
> > +	void __iomem *base = info->base;
> > +
> > +	/* Much of this register is read only */
> > +	writeq(0, base + CPMU_EVENT_CAP_REG(idx));
> > +	/* Filters are not per counter, so not reset here */  
> 
> s/not/no/

Good point. I went with 'so do not reset here'

I also did a scrub for consistent punctuation of those comments
that were full sentences.

> 
> DJ
> 
> > +	writeq(0, base + CPMU_COUNTER_REG(idx));
> > +}
> > +
