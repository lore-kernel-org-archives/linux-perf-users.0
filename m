Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF6C6FA99
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Mar 2023 13:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCJNcb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCJNca (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Mar 2023 08:32:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5D01009F7
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678455149; x=1709991149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SlTCNa2nP2U/Kzm/Cyorbm09dG95DZ1u59Q2WQx58kk=;
  b=JlWh5ZbfAdqzA+PIoqct5ka6Bk3pnPOgWBnbdcD5ebNPjyrbEss1MV5t
   IWwcVHWKyqxf9Hx7pliJ2jrwBm5lZOp2fw1i302RHmt4TtQnASxUbruqh
   SiurBEszN54PsLzR7wpLqdUIeNsG25AdIXBylqIJK0nvoAtGWlAmOipQQ
   ZMA5Ql++ThnvaNBjCGAWxt6GB7cYhAsALpG79rK2nUQ7IDqRKa7abxz2K
   5zLy0SVGI7KngFTj9kSOdaVKjOFxlxA+7bdn1Ou+WJf9al946wtokpJIz
   MebprzTnkhMGTFZ4oNcXgxye8sy3boVLC+kT0a90XyZFNEdOW8XB8TaW/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335423423"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="335423423"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 05:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="741971819"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="741971819"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 05:32:28 -0800
Message-ID: <01f16399-f600-2b45-766f-0b5e5f868345@intel.com>
Date:   Fri, 10 Mar 2023 15:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] fix IPC output in perf intel-pt-events script
Content-Language: en-US
To:     Roman Lozko <lozko.roma@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
References: <20230310111001.2836295-1-lozko.roma@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230310111001.2836295-1-lozko.roma@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/03/23 13:10, Roman Lozko wrote:
> Integers are not converted to floats during division in Python 2
> which results in incorrect IPC values, convert to float explicitly.

Thanks for finding this.  Obviously Python 3 is preferred nowadays
but Python 2 seems to be still a thing.

AFAICT, it would be better to fix this by adding:

from __future__ import division

at the top of the script, next to from __future__ import print_function

Also the patch subject should be:

perf scripts: intel-pt-events.py: Fix IPC output for Python 2

Also a Fixes tag could be added i.e.

Fixes: a483e64c0b62 ("perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace")

> 
> Signed-off-by: Roman Lozko <lozko.roma@gmail.com>
> ---
>  tools/perf/scripts/python/intel-pt-events.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> index 08862a2582f4..26e840e17062 100644
> --- a/tools/perf/scripts/python/intel-pt-events.py
> +++ b/tools/perf/scripts/python/intel-pt-events.py
> @@ -269,7 +269,7 @@ def print_common_ip(param_dict, sample, symbol, dso):
>  	if "cyc_cnt" in sample:
>  		cyc_cnt = sample["cyc_cnt"]
>  		insn_cnt = get_optional_zero(sample, "insn_cnt")
> -		ipc_str = "  IPC: %#.2f (%u/%u)" % (insn_cnt / cyc_cnt, insn_cnt, cyc_cnt)
> +		ipc_str = "  IPC: %#.2f (%u/%u)" % (float(insn_cnt) / cyc_cnt, insn_cnt, cyc_cnt)
>  	else:
>  		ipc_str = ""
>  	if glb_insn and glb_disassembler is not None:

