Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C6EB64D7
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 01:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjFVBj6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 21:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjFVBjw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 21:39:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA54107
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 18:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687397991; x=1718933991;
  h=date:from:to:subject:message-id:mime-version;
  bh=xOjmHlCBHbbGYMMEWJOBszjNLG4xAJWzYfpyNl11VNA=;
  b=m20MtV7ExVLtLYiz9nX1gmLj79mzwk3xAFVzAjS3pNF/YvsLBzxkE+oH
   gw/GVLasW+u6HIAhIm8pksNRLQp6eWQxNOiT0I0jGoRuf6AIvnWbwIkT1
   afJfz1GnH/01Rp7iYYcSDKPSHM+ix1XKjB9o735/JlJzl9ljRHYzc767S
   AIYfY6WxSe/ThJkwMaC2Tfxmio8dFVTDXegJBW0X+ebCmuNlB8owg/BRT
   ouyKeJJOXjA9ZS6ysrSbHaROiUxhdTQuUrxiAv9qgUnUx5s5eq+YBC+OI
   WovZg0Q/gr5Gp9n3N/zDa7kp2X08mHx9J7wuP2kqOKK9tx+Ql6487LtYF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="340701094"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="340701094"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 18:39:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="714718961"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="714718961"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 18:39:45 -0700
Date:   Wed, 21 Jun 2023 18:39:41 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Perf stat regression from d15480a3d67
Message-ID: <ZJOmXU/41HMzanM9@tassilo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,

I have a tool (toplev in pmu-tools) that parses the perf stat output
for generated command lines. It expects that the output contains the
events in the same order as specified with -e.

Unfortunately this broke for uncore events. 
I bisected it down to the following commit.

I believe just arbitrarily hiding events will break any tool that parses
the perf stat output and expect the input order.

Can the original problem be fixed without hiding events?

Thanks,

-Andi

commit dd15480a3d67b9cf04a1f6f5d60f1c0dc018e22f
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Wed Jan 25 11:24:31 2023 -0800

    perf stat: Hide invalid uncore event output for aggr mode

    The current display code for perf stat iterates given cpus and build the
    aggr map to collect the event data for the aggregation mode.




