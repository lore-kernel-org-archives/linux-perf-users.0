Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6D1990BD;
	Thu, 25 Jul 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914672; cv=none; b=R40jaz7yFVI4wz8sOqqxDxndVJiqWCk4B/2iVa/FX37QZVxS1qbEg39xzoskPSr9pTkevtsIJ/8hxfSD7MSOqE4d0qLMUqSxyexi0n9lK4Gf8NJzVphs0jp/EIxPjx9Kv3jbCf+yIJPsP9yKOy3sPDpaUmde0oPfGT0q6rAO+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914672; c=relaxed/simple;
	bh=AQDx2WxeMwX7hj1IiTrpYJEr1zM3iBN7u57aWHySSpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fTRMeyZR172hW2vzX7uqDuR7JwHNKb+rr5ux+64hU+IARSrrsewCPlReRyALD/Nejsq5rKZactxEQ+OcMr7SMQS0zd3nu3ZtYBaQ7M27tNFcQBJCKc72HtCb4jWdIAo6bWnFORIcCjD73YxK+nga9oUOmUYq/+Y8XF381D/j8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3XvqavC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3XvqavC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721914671; x=1753450671;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=AQDx2WxeMwX7hj1IiTrpYJEr1zM3iBN7u57aWHySSpw=;
  b=c3XvqavCCBhgZNf69pWO6RXljG+x2oLmO4XOqnExrCwfh3Cm1+MwTb/S
   8ZTTZQm/EKKga/9Xf9Xf+v0XKthZjqVcbIM2a80HsafeBp9ETmndqm5EL
   6eYXmhSwgEQQ+6itGLYO0lMRMQDlRn5Jji8Y/2l3pKznKQiDMFOleYiCY
   g4xvx4f/lo5HegPxf7Wcgp8Wm9TixFWOGyw1k1DCqci45zYC8m0J7Hjl5
   bFsnnXgTxBq9iDZTeLXOBz/MugX794RRa20aVStQL9fIVrbh/o6PDjJyn
   R0pxIVSefQA66deW1l99DO0enIgFc7Xmp8L8Y6A2EEhNfRafRE2KbbKRY
   Q==;
X-CSE-ConnectionGUID: kJxIGWvRTbCIEIeYxFSskQ==
X-CSE-MsgGUID: mOe3CvwmTx+6KxhhSLRfBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="31039001"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="31039001"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 06:37:51 -0700
X-CSE-ConnectionGUID: 8ojz+UyJSgiR2x/NcnzXAQ==
X-CSE-MsgGUID: G6ttf1CTRiOjCsyJS9F5Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="57726812"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 06:37:51 -0700
Received: from [10.212.31.239] (kliang2-mobl1.ccr.corp.intel.com [10.212.31.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 172A720CFEE1;
	Thu, 25 Jul 2024 06:37:48 -0700 (PDT)
Message-ID: <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com>
Date: Thu, 25 Jul 2024 09:37:47 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Some unc_cha_tor_* events appear to be "not supported"?
To: Song Liu <song@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 jonesz@meta.com
References: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-24 6:39 p.m., Song Liu wrote:
> Hi folks,
> 
> We noticed that some unc_cha_tor_occupancy and unc_cha_tor_inserts events
> appear to be "not supported" and always counting zero (see an example below).
> Is this a known issue? We are testing with 6.10 kernel and perf.
> 
> Thanks,
> Song
> 
> 
> [root@kerneltest008.05.atn6 ~]# ./perf list | grep
> unc_cha_tor_occupancy.ia_hit_llcprefdrd
>   unc_cha_tor_occupancy.ia_hit_llcprefdrd
> [root@kerneltest008.05.atn6 ~]# ./perf stat -e
> unc_cha_tor_occupancy.ia_hit_llcprefdrd -a -- sleep 1
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'


The value '4b433' is for the 'Filter1', according to the original event
list.

https://github.com/intel/perfmon/blob/main/SKX/events/skylakex_uncore.json#L4634

      "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
      "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
      "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
      "Counter": "0",
      "MSRValue": "0x00",
      "ELLC": "0",
      "Filter": "Filter1",
      "ExtSel": "0",
      "Deprecated": "0",
      "FILTER_VALUE": "0x4b433"

There are two filters for CHA on SKX. Each filter is 32 bits wide.
So the Linux kernel driver uses config1 (64 bits wide) to represent both
of them. The low 32 bits are for filter0 and high 32 bits are for filter1.

It should be an issue of the convert script, which set the filter1 value
to the low 32 bits.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json#n4489

Can you please try the below event?
uncore_cha/event=0x35,umask=0x11,config1=0x4b43300000000/

Thanks,
Kan
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
> not supported by kernel)!
> 
>  Performance counter stats for 'system wide':
> 
>                  0      unc_cha_tor_occupancy.ia_hit_llcprefdrd
> 
>        1.001680312 seconds time elapsed
> 
> [root@kerneltest008.05.atn6 ~]# grep "model name" -m 1 /proc/cpuinfo
> model name      : Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz
> [root@kerneltest008.05.atn6 ~]# uname -r
> 6.10.0
> [root@kerneltest008.05.atn6 ~]# ./perf -vv
> perf version 6.10.g0c3836482481
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>             debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ OFF ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>            libcapstone: [ OFF ]  # HAVE_LIBCAPSTONE_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ OFF ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>   dwarf-unwind-support: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>             libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
> 
