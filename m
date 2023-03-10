Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1B7C64EC4
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Mar 2023 16:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjCJQyc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCJQyN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Mar 2023 11:54:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00218F4DB8
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678467071; x=1710003071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bSCf0uiUESgdcZiOjLfLwolUNNREGRVL/MWrXQL0hXo=;
  b=Fy9R744cZ4Mx9xnqsGSs/uhUpN1SYd8np964U3jabsILu22GLvaIhMLR
   xtGPpgufsvTWd8VAM/MRxGTUsiV1mrDMAsY0Ko8g1bT8XN950yocT9WDM
   O4wP4KZ2aNzKM+lQVAM5umKZyDSqdfqSSp1B6X247Gp+J20JeAAHg8hSt
   I1Fi50XWFUIT08/dFrvpCMudbjdCZN05V/UHMEChHJNg8MGlJ0lmS2f57
   W1DOtkEn1cLzhr1wXc5/eJ4X7BSeEtQWMa2X0HHcHXO56CMtI1yfLyXN6
   1A33Su0Lh9E3KQ8X7zKXKz/lomtjW7k0BCzRFwp0CRpgUtfr0UrNq7Ge7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="364428152"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="364428152"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:50:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="821129962"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="821129962"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:50:54 -0800
Message-ID: <19a697ba-9520-92a0-1419-07c5a66481b1@intel.com>
Date:   Fri, 10 Mar 2023 18:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2] perf scripts: intel-pt-events.py: Fix IPC output for
 Python 2
Content-Language: en-US
To:     Roman Lozko <lozko.roma@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <01f16399-f600-2b45-766f-0b5e5f868345@intel.com>
 <20230310150445.2925841-1-lozko.roma@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230310150445.2925841-1-lozko.roma@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/03/23 17:04, Roman Lozko wrote:
> Integers are not converted to floats during division in Python 2
> which results in incorrect IPC values. Fix by switching to new division
> behavior.

There is usually a blank line here

> Fixes: a483e64c0b62 ("perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace")
> Signed-off-by: Roman Lozko <lozko.roma@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/scripts/python/intel-pt-events.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> index 08862a2582f4..1c76368f13c1 100644
> --- a/tools/perf/scripts/python/intel-pt-events.py
> +++ b/tools/perf/scripts/python/intel-pt-events.py
> @@ -11,7 +11,7 @@
>  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>  # more details.
>  
> -from __future__ import print_function
> +from __future__ import division, print_function
>  
>  import io
>  import os

