Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C8CC001B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Aug 2023 09:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjHKJtz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 05:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjHKJtp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2023 05:49:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0098E30CA
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2023 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691747384; x=1723283384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4OvXogAMzq1MUbx9QUPRVTXSgzW8v3KRMM78CixHbJY=;
  b=TSQ8W3izSGagV/b22FpmXa2wPFyu/wOHTmDpfNM//tVQBeTzqL8FhLVD
   cPEZOE+JLOCWs/Ie6Z0tWplFYZOMpBimknQUQDNJIi3TNlA0beyVaSnu+
   i6Sv+TYUUGTZ2AxQRS/Hg7LX9HnMjozfKOA7R4f11grYyapuoTUUjfMnW
   f3ck4hVMlxiWAimzC/aYCpqfkDT57g1ykYwZ5dD5UgHuLhQOQuyJ2jw80
   lKlPs+R7k8gYvobKm4hkooGU+raAv0D2ekHMd0npUmIrIgFBXfmr6AvE7
   zGL3H1uyG1mDOiJg3B4WehkPkBOm7JmEHGCxbdSZ9bIOGG9sraV+JWLhX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351962819"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351962819"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="767614654"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="767614654"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.13])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:49:40 -0700
Message-ID: <f21cbbed-8e51-fae1-9e77-56b5d239bafd@intel.com>
Date:   Fri, 11 Aug 2023 12:49:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH] tools/perf: Fix dso kernel load and symbol process to
 correctly map dso to its long_name, type and adjust_symbols
Content-Language: en-US
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20230811051546.70039-1-atrajeev@linux.vnet.ibm.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230811051546.70039-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/08/23 08:15, Athira Rajeev wrote:
> Test "object cocde reading" fails sometimes for kernel address
> as below:
> 
>     Reading object code for memory address: 0xc000000000004c3c
>     File is: [kernel.kallsyms]
>     On file address is: 0x14c3c
>     dso__data_read_offset failed
>     test child finished with -1
>     ---- end ----
>     Object code reading: FAILED!
> 
> Here the dso__data_read_offset fails for symbol address
> 0xc000000000004c3c. This is because, the dso long_name here
> is [kernel.kallsyms] and hence open_dso fails to open this
> file. There is an incorrect dso to map handling here. The
> key points here is:
> - dso long_name is set to [kernel.kallsyms]. This file is
>   not present and hence returns error
> - DSO binary type is set to DSO_BINARY_TYPE__NOT_FOUND
> - dso adjust_symbols is set to zero
> 
> In the end dso__data_read_offset() returns -1 and the address
> 0x14c3c can not be resolved. Hence the test fails. But the
> address actually maps to kernel dso
> 
>     # objdump -z -d --start-address=0xc000000000004c3c --stop-address=0xc000000000004cbc /home/athira/linux/vmlinux
> 
>     /home/athira/linux/vmlinux:     file format elf64-powerpcle
> 
>     Disassembly of section .head.text:
> 
>     c000000000004c3c <exc_virt_0x4c00_system_call+0x3c>:
>     c000000000004c3c:	a6 02 9b 7d 	mfsrr1  r12
>     c000000000004c40:	78 13 42 7c 	mr      r2,r2
>     c000000000004c44:	18 00 4d e9 	ld      r10,24(r13)
>     c000000000004c48:	60 c6 4a 61 	ori     r10,r10,50784
>     c000000000004c4c:	a6 03 49 7d 	mtctr   r10
> 
> Fix the dso__process_kernel_symbol function to set the
> binary_type and adjust_symbols. adjust_symbols is used by
> function "map__rip_2objdump" which converts symbol start
> address to objdump address. Also set the dso long_name during
> dso__load_vmlinux function.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Note: Found similar discussion here in thread:
>       https://www.spinics.net/lists/linux-perf-users/msg06337.html
>       where Adrian proposed the fix, but looks like this was
>       not added to the perf. Hence addeed Suggested-by from Adrian.
> 
>       Additional to the fix proposed by Adrian, the patch also
>       adds setting of adjust_symbols which is needed for
>       map__rip_2objdump to convert symbol start to objdump address.
> 
>  tools/perf/util/symbol-elf.c |  2 ++
>  tools/perf/util/symbol.c     | 15 ++++++++++-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 252d26a59e64..9e7eeaf616b8 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1440,6 +1440,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  		curr_dso->kernel = dso->kernel;
>  		curr_dso->long_name = dso->long_name;
>  		curr_dso->long_name_len = dso->long_name_len;
> +		curr_dso->binary_type = dso->binary_type;
> +		curr_dso->adjust_symbols = dso->adjust_symbols;
>  		curr_map = map__new2(start, curr_dso);
>  		dso__put(curr_dso);
>  		if (curr_map == NULL)
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index f849f9ef68e6..3f36675b7c8f 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2204,15 +2204,20 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
>  	if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type))
>  		return -1;
>  
> +	/*
> +	 * dso__load_sym() may copy 'dso' which will result in the copies having
> +	 * an incorrect long name unless we set it here first.
> +	 */
> +	dso__set_long_name(dso, vmlinux, vmlinux_allocated);
> +	if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
> +		dso->binary_type = DSO_BINARY_TYPE__GUEST_VMLINUX;
> +	else
> +		dso->binary_type = DSO_BINARY_TYPE__VMLINUX;
> +
>  	err = dso__load_sym(dso, map, &ss, &ss, 0);
>  	symsrc__destroy(&ss);
>  
>  	if (err > 0) {
> -		if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
> -			dso->binary_type = DSO_BINARY_TYPE__GUEST_VMLINUX;
> -		else
> -			dso->binary_type = DSO_BINARY_TYPE__VMLINUX;
> -		dso__set_long_name(dso, vmlinux, vmlinux_allocated);
>  		dso__set_loaded(dso);
>  		pr_debug("Using %s for symbols\n", symfs_vmlinux);
>  	}

