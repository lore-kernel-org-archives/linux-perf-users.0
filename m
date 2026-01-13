Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91DD352FBA;
	Tue, 13 Jan 2026 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341892; cv=none; b=Hjoyz3Wxf6Smv7dG6QUAWSzWZPPG0rWGC+37zDlNA5HrFBfQ6eqXkKxazXkXRy2gPPdNvnwMNUley+bhNwpB10l3MyNcHYslKiKLFWwA8WWTkGn4+SxrwgdFN3JHPTiw3hTEshlk0X/vsfMLj3ehJ7bCrQbPChbn/9nOBQyE7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341892; c=relaxed/simple;
	bh=8a7kAR66TZL7uosSBdR42lYTp0PPuWjX+5II5tRv1Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhRq4dKJElX0zU5Go07UpOyjwh/BcsedKV2CVTvcvgwY8spac/psQ945Jpjv/p9pqdiTITyZwS6+XjIzC5E9j2Ug6v1iHUyQllscFapCvLFfKgB8HhyaD3l79Ovvwb4Qr7EQ+Hq9ZSmwFFefIbYL3NcoDcyJeiTfGOdDZ5K4mnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP784Clz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP784Clz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768341891; x=1799877891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8a7kAR66TZL7uosSBdR42lYTp0PPuWjX+5II5tRv1Us=;
  b=BP784Clzwc3PODol1gr2etBROdHIB2ZqW2n03CTBSISAi0KTTmJXefrL
   /7kdP/16YHXecy8ygBsZbc7OOa6EGBwPxiq+l/yQMrT8yqwX9pIG3j4Wt
   qoIgNes/ndOuTM2V74XpRFDOS6o08KbPsZnocfOnR83llRRqEGjxo9Iqw
   Spk5hKX2gUgZL25acl17kaKmMEIGR9HmpgQXPSrQgYq8jSS46PjRkvPmG
   v5hlfNparcImNRHKvbf/nI5xI7C7SC6ldi6eRt8TTb3vIaAYU/wv7Yk2X
   I4SH7qQz7DyDK/4K5erYFGZnPeAjv1qtScU3IurO4hs/YskY9AS9P7cFQ
   A==;
X-CSE-ConnectionGUID: QMG4xAuRTX6r60TApW5/qw==
X-CSE-MsgGUID: MHSrZ3VWRlKkjrLRktfAKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73479303"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="73479303"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:04:50 -0800
X-CSE-ConnectionGUID: iSyVdJIoTXaKeeq0ULDiYQ==
X-CSE-MsgGUID: 0T1diwbPQpyX2m+YkWZ3+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209027945"
Received: from unknown (HELO [10.241.241.64]) ([10.241.241.64])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:04:50 -0800
Message-ID: <fc565620-a3ef-4a28-bfb8-87bb5ce135f5@intel.com>
Date: Tue, 13 Jan 2026 14:04:49 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
To: Markus Elfring <Markus.Elfring@web.de>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Eranian Stephane
 <eranian@google.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 Thomas Falcon <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260113002539.408943-1-zide.chen@intel.com>
 <6213d28c-7377-44c2-92c6-0dc34cfdf60a@web.de>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <6213d28c-7377-44c2-92c6-0dc34cfdf60a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/13/2026 8:21 AM, Markus Elfring wrote:
>> If domain->global_init() fails in __parse_discovery_table(), the
>> mapped MMIO region is not released before returning, resulting in
>> an iounmap() leak.
> 
> How do you think about to avoid a bit of duplicate source code here?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc5#n526
> 

Thank you for the suggestion!

Yes, I agree this is better. In V1 I followed the existing style in this
API.

I will post a v2 with this change:

@@ -264,6 +264,7 @@ static int __parse_discovery_table(struct
uncore_discovery_domain *domain,
        struct uncore_unit_discovery unit;
        void __iomem *io_addr;
        unsigned long size;
+       int ret = 0;
        int i;

        size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
@@ -273,21 +274,23 @@ static int __parse_discovery_table(struct
uncore_discovery_domain *domain,

        /* Read Global Discovery State */
        memcpy_fromio(&global, io_addr, sizeof(struct
uncore_global_discovery));
+       iounmap(io_addr);
+
        if (uncore_discovery_invalid_unit(global)) {
                pr_info("Invalid Global Discovery State: 0x%llx 0x%llx
0x%llx\n",
                        global.table1, global.ctl, global.table3);
-               iounmap(io_addr);
                return -EINVAL;
        }
-       iounmap(io_addr);

        size = (1 + global.max_units) * global.stride * 8;
        io_addr = ioremap(addr, size);
        if (!io_addr)
                return -ENOMEM;

-       if (domain->global_init && domain->global_init(global.ctl))
-               return -ENODEV;
+       if (domain->global_init && domain->global_init(global.ctl)) {
+               ret = -ENODEV;
+               goto out;
+       }

        /* Parsing Unit Discovery State */
        for (i = 0; i < global.max_units; i++) {
@@ -307,8 +310,10 @@ static int __parse_discovery_table(struct
uncore_discovery_domain *domain,
        }

        *parsed = true;
+
+out:
        iounmap(io_addr);
-       return 0;
+       return ret;
 }

 static int parse_discovery_table(struct uncore_discovery_domain

> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n94

Are you suggesting that I add a Closes tag?
This issue was reported by Intel internal LKP, and there is no public
URL available.


> Regards,
> Markus

