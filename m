Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDACC6FA82
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 20:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIVUln (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIVUlm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 16:41:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDE610FE0F;
        Thu, 22 Sep 2022 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663879301; x=1695415301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D6yUnrY2M8EW+DGeUBJpNdMW0BxKMc78VDaRnOgbaWU=;
  b=RwnUoBWPojPt/iMrpQnpryejn6knWyh9PxQ4wAeRn9oFpsolV5KNVoon
   ZLJoyAYUvBCq+FoLt1Xp1gEfrK1Sll8p3Wj2c27a48ngwAib7EF8oLEHj
   zvaabeMdCBwEWTz8knScopINK1jugNqubaOjIjg1Xy7J5c+2dfw3vCNJS
   yYZ65Vot+tR2pmCgik430gbdkl9XjtoJXmgxwU+K27SySyNp4RiukxXhd
   rHHUAZlPuJKDHMilVaByXrtjHBdP48w8JZOWN6Wlbc3kJuLZiWGbD3z/j
   tS4BczZ7u80cjMFDhwtfTkewVyS+QiGkKUhYKwqzaPlxBshArMSWgF7N/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287537028"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="287537028"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:41:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="615366023"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.80.137]) ([10.212.80.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:41:40 -0700
Message-ID: <60048f0f-eb51-99bc-14fc-1974442ab454@intel.com>
Date:   Thu, 22 Sep 2022 13:41:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v2 4/4] docs: perf: Minimal introduction the the CXL
 PMU device and driver.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linuxarm@huawei.com
References: <20220824103617.21781-1-Jonathan.Cameron@huawei.com>
 <20220824103617.21781-5-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220824103617.21781-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 8/24/2022 3:36 AM, Jonathan Cameron wrote:
> Very basic introduction to the device and the current driver support
> provided. I expect to expand on this in future versions of this patch
> set.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> --
> RFC:
> - I'll post separately about this shortly, but it seems very odd
>    to me that there is no way to assign a parent to an event_sources
>    device.  As a result we get the messy approach of playing match
>    the name to figure out what the CPMU instance is connected to.
> ---
>   Documentation/admin-guide/perf/cxl.rst   | 60 ++++++++++++++++++++++++
>   Documentation/admin-guide/perf/index.rst |  1 +
>   2 files changed, 61 insertions(+)
>
> diff --git a/Documentation/admin-guide/perf/cxl.rst b/Documentation/admin-guide/perf/cxl.rst
> new file mode 100644
> index 000000000000..6ffc057591fb
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/cxl.rst
> @@ -0,0 +1,60 @@
> +======================================
> +CXL Performance Monitoring Unit (CPMU)
> +======================================
> +
> +The CXL rev 3.0 specification provides a definition of CXL Performance
> +Monitoring Unit in section 13.2: Performance Monitoring.
> +
> +CXL components (e.g. Root Port, Switch Upstream Port, End Point) may have
> +any number of CPMU instances. CPMU capabilities are fully discoverable from
> +the devices. The specification provides event definitions for all CXL protocol
> +message types and a set of additional events for things commonly counted on
> +CXL devices (e.g. DRAM events).
> +
> +CPMU driver
> +===========
> +
> +The CPMU driver register a perf PMU with the name cpmu<id> on the CXL bus.
> +
> +    /sys/bus/cxl/device/cpmu<id>
> +
> +The associated PMU is registered as
> +
> +   /sys/bus/event_sources/devices/cpmu<id>
> +
> +In common with other CXL bus devices, the id has no specific meaning and the
> +relationship to specific CXL device should be established via the device parent
> +of the device on the CXL bus.
> +
> +PMU driver provides description of available events and filter options in sysfs.
> +
> +The "format" directory describes all formats of the config (event vendor id,
> +group id and mask) config1 (threshold, filter enables) and config2 (filter
> +parameters) fields of the perf_event_attr structure.  The "events" directory
> +describes all documented events show in perf list.

"all the documented events shown in perf list."

DJ

> +
> +The events shown in perf list are the most fine grained events with a single
> +bit of the event mask set. More general events may be enable by setting
> +multiple mask bits in config. For example, all Device to Host Read Requests
> +may be captured on a single counter by setting the bits for all of
> +
> +* d2h_req_rdcurr
> +* d2h_req_rdown
> +* d2h_req_rdshared
> +* d2h_req_rdany
> +* d2h_req_rdownnodata
> +
> +Example of usage::
> +
> +  $#perf list
> +  cpmu0/clock_ticks/                                 [Kernel PMU event]
> +  cpmu0/d2h_req_itomwr/                              [Kernel PMU event]
> +  cpmu0/d2h_req_rdany/                               [Kernel PMU event]
> +  cpmu0/d2h_req_rdcurr/                              [Kernel PMU event]
> +  -----------------------------------------------------------
> +
> +  $# perf stat -e cpmu0/clock_ticks/ -e cpmu0/d2h_req_itowrm/
> +
> +The driver does not support sampling. So "perf record" and attaching to
> +a task are unsupported.
> +
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 9c9ece88ce53..f12cfe76e1f0 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -18,3 +18,4 @@ Performance monitor support
>      xgene-pmu
>      arm_dsu_pmu
>      thunderx2-pmu
> +   cxl
