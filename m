Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E8EC7112B
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Aug 2023 06:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356584AbjHRGhn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 02:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357861AbjHRGhY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Aug 2023 02:37:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A233A94
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Aug 2023 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692340642; x=1723876642;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JVZqqvYSxnUl7+Lt2ADVesustEsvMqn9GTN4V1oOVwQ=;
  b=YGJegR1SzLTs9gTce0mCONrim042Iwv3oVjLlghxSFIInulBg9HoQZWc
   Rbn4iYYcqaXTVXhRtbGNFV0EV9iACZl8poCEKdgI9hy2MsTO+mKTtLIWo
   cYdlyX2zydcFqWS82NtPMX0QOsaEeHSijaO5gUDeYBP8ueo6qzMFVrjJl
   LMqBiok2KcYnhf5HSNUKTHPVv7Pqj0de96LhzpAXCz61wNvHcS6cLQJo7
   j3mpaaVlD89AatXVND//lrkHrip4NJPpw1YwgCgxJ5bILC5AvY0LzHrHf
   +pciHsKL5iI8liRqBuEXckK2Bm3PXaLX8RBOkP2R7P4H+yw6m4PLoU9c2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="404010330"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="404010330"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 23:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="711875474"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="711875474"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.27])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 23:37:17 -0700
Message-ID: <a407d3fd-6d40-060d-eb0c-c880e09b2a5f@intel.com>
Date:   Fri, 18 Aug 2023 09:37:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH V2 1/2] tools/perf: Add text_end to "struct dso" to save
 .text section size
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, Disha Goel <disgoel@linux.ibm.com>
References: <20230817171852.55629-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230817171852.55629-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 17/08/23 20:18, Athira Rajeev wrote:
> Update "struct dso" to include new member "text_end".
> This new field will represent the offset for end of text
> section for a dso. This value is derived as:
> sh_size (Size of section in byes) + sh_offset (Section file
> offst) of the elf header for text.
> 
> To resolve the address from a sample, perf looks at the
> DSO maps. In case of address from a kernel module, there
> were some address found to be not resolved. This was
> observed while running perf test for "Object code reading".
> Though the ip falls beteen the start address of the loaded
> module (perf map->start ) and end address ( perf map->end),
> it was unresolved.
> 
> Example:
> 
>     Reading object code for memory address: 0xc008000007f0142c
>     File is: /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
>     On file address is: 0x1114cc
>     Objdump command is: objdump -z -d --start-address=0x11142c --stop-address=0x1114ac /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
>     objdump read too few bytes: 128
>     test child finished with -1
> 
> Here, module is loaded at:
>     # cat /proc/modules | grep xfs
>     xfs 2228224 3 - Live 0xc008000007d00000
> 
> From objdump for xfs module, text section is:
>     text 0010f7bc  0000000000000000 0000000000000000 000000a0 2**4
> 
> Here the offset for 0xc008000007f0142c ie  0x112074 falls out
> .text section which is up to 0x10f7bc.
> 
> In this case for module, the address 0xc008000007e11fd4 is pointing
> to stub instructions. This address range represents the module stubs
> which is allocated on module load and hence is not part of DSO offset.
> 
> To identify such  address, which falls out of text
> section and within module end, added the new field "text_end" to
> "struct dso".
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
>    v1 -> v2:
>    Changed commit message to explain need for "text_end"
> 
>  tools/perf/util/dso.h        | 1 +
>  tools/perf/util/symbol-elf.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index b41c9782c754..70fe0fe69bef 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -181,6 +181,7 @@ struct dso {
>  	u8		 rel;
>  	struct build_id	 bid;
>  	u64		 text_offset;
> +	u64		 text_end;
>  	const char	 *short_name;
>  	const char	 *long_name;
>  	u16		 long_name_len;
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 8bd466d1c2bd..252d26a59e64 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1512,8 +1512,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	}
>  
>  	if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshdr,
> -				".text", NULL))
> +				".text", NULL)) {
>  		dso->text_offset = tshdr.sh_addr - tshdr.sh_offset;
> +		dso->text_end = tshdr.sh_offset + tshdr.sh_size;
> +	}
>  
>  	if (runtime_ss->opdsec)
>  		opddata = elf_rawdata(runtime_ss->opdsec, NULL);

Should probably amend dso__load_bfd_symbols() also


