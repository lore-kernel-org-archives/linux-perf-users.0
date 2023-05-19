Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62628C77B7A
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 May 2023 11:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjESLxw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 May 2023 07:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjESLxv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 May 2023 07:53:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D217DE60;
        Fri, 19 May 2023 04:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F8356570B;
        Fri, 19 May 2023 11:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF4BC433EF;
        Fri, 19 May 2023 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684497226;
        bh=IpYMvm+1Pvf+LMMwLEDhubWBBc1bK/NQ0YjTQqFP6NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMpbEyWtSyImp+/hVn3+dvIAax2bCQKZsQvMpcCofBrhSaQkhGFPE6qYGDEuwdU5W
         d5NZpCPUIQ6om9Ky9jEhlTi7N3nDZjwGeoMTlKmVDJNGDLz/IIreTJGkXzN/LrNgsO
         fKs4Difc/BLRa01s35tFkvBAV4mAd0y2IzeU/teBFxLCGH/JEkd0gceD2tdLoeqeUY
         GC+3R8UOsjMMtNMW6u2SNE/UqIlWqpu5lxJC1Gr9s+0CwMK023LvtQz0Ej0YVzcQsS
         ppBm9cmpLzJPxl5NlW0QnKWP81ld+rlV6jNSNL3wIUfKnqWw3EyYPF3HM7iATj7VAR
         k5slRsoV5E7hQ==
Date:   Fri, 19 May 2023 12:53:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v6 4/5] perf: CXL Performance Monitoring Unit driver
Message-ID: <20230519115339.GA2637@willie-the-truck>
References: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
 <20230413142617.15995-5-Jonathan.Cameron@huawei.com>
 <6444603653882_1b41629414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20230423144801.00006efd@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423144801.00006efd@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Apr 23, 2023 at 02:48:01PM +0100, Jonathan Cameron wrote:
> On Sat, 22 Apr 2023 15:31:18 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > CXL rev 3.0 introduces a standard performance monitoring hardware
> > > block to CXL. Instances are discovered using CXL Register Locator DVSEC
> > > entries. Each CXL component may have multiple PMUs.
> > > 
> > > This initial driver supports a subset of types of counter.
> > > It supports counters that are either fixed or configurable, but requires
> > > that they support the ability to freeze and write value whilst frozen.
> > > 
> > > Development done with QEMU model which will be posted shortly.
> > > 
> > > Example:
> > > 
> > > $ perf stat -e cxl_pmu_mem0.0/h2d_req_snpcur/ -e cpmu0/h2d_req_snpdata/ -e cpmu0/clock_ticks/ sleep 1
> > > 
> > > Performance counter stats for 'system wide':
> > > 
> > > 96,757,023,244,321      cxl_pmu_mem0.0/h2d_req_snpcur/
> > > 96,757,023,244,365      cxl_pmu_mem0.0/h2d_req_snpdata/
> > > 193,514,046,488,653      cxl_pmu_mem0.0/clock_ticks/
> > > 
> > >        1.090539600 seconds time elapsed
> > > 
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > Jonathan, I was awaiting a "perf maintainer ack" before applying this,
> > only to now realize there is no maintainer entry for drivers/perf/ in
> > general, only "ARM PMU PROFILING AND DEBUGGING". Were you waiting on any
> > additional acks from perf folks for this?
> 
> I'm always hopeful.  For everything similar we've done in the past in
> drivers/perf, Will Deacon has taken a look and ultimately taken the series
> (often Mark has as well), but then those drivers could be very loosely
> termed ARM PMU on basis they happen to be PMUs on an ARM architecture
> system even if they have nothing at all to do with the ARM architecture
> itself (e.g. our PCI PMUs).
> 
> I see the riscv stuff has been going in drivers/perf without an Ack from
> them though so there is precedent for non ARM stuff in this directory
> going in through other trees despite the catch all maintainers entry.
> 
> So, Will / Mark do you consider this in your maintainer scope? 
> 
> Your input is welcome either way but as you might be very busy I
> don't want to commit you to taking a look at this CXL driver.

We try to review and merge as much as we can under drivers/perf/, but where
there's another subsystem which is tightly coupled with the driver (e.g.
riscv) then we're more than happy for the code to be handled via the other
tree.  We don't want to bottleneck changes here and I don't think we can
reasonably keep up with every perf driver.

So please feel free to take this via cxl.

Will
