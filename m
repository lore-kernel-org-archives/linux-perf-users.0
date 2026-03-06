Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C537CD25
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796468; cv=none; b=o3Rn5xYMpWMMokwi6Duls0tgdgdEpsbSVMbaMSJ1axgHCHUW3NyK5O/HksYFIfnSDdt82qq+ndEddnTYlqpx9o2gkWAMnd3FlUqxRsvP8J9xBuS+TpC5mdsVPxRD78Loj46aVqLdj9GMVqXHlAnCJ7tlOIAHkIpDI2OrlWz9C3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796468; c=relaxed/simple;
	bh=9o0CnNEEpRcWyU8vPLQVvp9NQ89fFOZowCHZCWI1G+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWHQ+DmVYqRO8FCPRjKfyDWGrqthjR0QXTF3bd6rs4EP1fnZKCZXoOpzcFTat/l0NZJ4PrN5MUKQC0qwC6gokVU561qPjn8fl+L+o3UJqfTxNIFF+UiEYHX7VWGvEOCRT58Ha8Cu3uCdVBg67m1C4sfczhb3P0XpnbSgo+UUx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ec25TkPD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ec25TkPD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b7c2788dso3939419f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 03:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772796466; x=1773401266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpvzU01k3DVDMfnP12TQ8nzX3bCfGsyylsruBZSY0NI=;
        b=Ec25TkPDpQSzkva6s1hvj+uWaL6FztndADqE5jWTqsPDX0UjTfSjOQ1mLPyluu5+g+
         F+QxMuOKyjAMaDdcVcpnwl84VWjjcw0c26LJ2KyIeMeTypeMoN9QQi1NKVlFypGQqk11
         m5KTpkxfS6EmjHA0wnlmN12A8PsPmm54oZ3nAuEzaHL4q45pVBd3WBngMW0fmsvBM3Mq
         h8H9Q2rlfEBOJKgVBQh0dlC7C/h2CnSqx6aoNrs7zyjhWtbd7VobRyaJU/k5iYrY/rbv
         hgSQWW1xV9umYaZq9+tq5kbipDu3/k86fqKLCevcDfnh3gbnpifgOWINZZFe3anYkeY4
         YLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772796466; x=1773401266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpvzU01k3DVDMfnP12TQ8nzX3bCfGsyylsruBZSY0NI=;
        b=bUqemAFCFBEnELMqX8xhGfsvA8OK3kCWgACYw48+DBXLaZu+OZhxyWJ+jFIDmOMczp
         vhbPxsKoKteqVm4TvIr0XysDYscGY9H469CrjQVIqln7qiSn1DWrd3TpWiIHfzfCsFY1
         EPGr9jgiJJ2ajZH9WouFfHS4Jv4ma1euBN6G6dZOg7NpKKZJzYSSRRGoTPL6AS91vUyq
         AGgskVMDKKI9Z1SvYXPYtXhZkJjsZ/BrE3JmxoG15eg7bK1GjC8BRQ62pfENS7pPN6Me
         sHLkhi04wyTDWkO3G1QQRjexXajk+jnXKnTamyl+TPWRlRjCt2vSEAT1wFRLANezPt93
         9Aag==
X-Forwarded-Encrypted: i=1; AJvYcCUM1hgv7JfPjetZisa2gdK1CdVqFhXeki7bFFhAjM5P3+7n3zMLYR2zYaWGpFkjzAJ+8DrumMJse8bejevGFpfH@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqdluIQ8LKnVRO2IvfI9Qual9PJ7R8bBaWlvUtzUEkfEHVGUO
	YFvbtkR+vajAjBtYHg0ZG8L7F1Q8KGc0nVHJL4eOxQlM8Z3p2IpE4fjNVytF7pqugvc=
X-Gm-Gg: ATEYQzxf932VqSmej8JL1ESaYxB9hcRT22/K8IVbjlKWG6WnfcZSu7Fgn7hy0zz7Xa7
	Qb1RbDv60Ud/ZrSVfqrvIC+951DzVzRDYUimHZ9ty0zTGAq/3sit+Zlb2hZwiMxUHfBlGogExdw
	Anx2RTZuKS3ROAvHXs/acb+ak4MmM8sj1rkauemvjZGWOn61f5R9ZxzhIlWvM9Q5DSsHjRdciej
	zI8SjIm8KZGNGd4GyuyGwvPOECh/pyTCJwJlAFeHbNBBJnfZw5CnFJURKNu8PFSb1KeXTSk+opK
	faiNTUolCDerFpIUtcigSKBUgTNSHo9BmzvqHEkrJnTJ9IyJAbVj1RpEPeGgmMKV3ujb+arZcbE
	HQ88WQWk6aUImom3a0s75sYwP8uLfh54GxKUb+fOjA1O+oaADkkXHwMLDTUrIfAKxEOB0BbS/L0
	hI0HFHUZ5cje5GhVHbexjvbaq72eB+
X-Received: by 2002:a05:6000:609:b0:439:cb10:dfcd with SMTP id ffacd0b85a97d-439da67982fmr2952968f8f.39.1772796465552;
        Fri, 06 Mar 2026 03:27:45 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8dbb3sm2911017f8f.4.2026.03.06.03.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 03:27:45 -0800 (PST)
Message-ID: <557db631-aef8-43b1-9f45-fae75910ccb4@linaro.org>
Date: Fri, 6 Mar 2026 11:27:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Syncing include/linux/coresight-pmu.h with its copy in tools/perf
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <aanm4oUxeJ4U34FO@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aanm4oUxeJ4U34FO@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/03/2026 8:26 pm, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Right now we have this perf build warning:
> 
>    diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
> 
> But when I try to update it it explodes, can someone in the ARM front
> take a look at it?
> 
> Thanks,
> 
> - Arnaldo
> 

Sent "[PATCH 0/2] perf cs-etm: Finish removal of ETM_OPT_*" to fix that 
and update the header.

Thanks
James

> ⬢ [acme@toolbx perf-tools]$ m
> make: Entering directory '/home/acme/git/perf-tools/tools/perf'
>    BUILD:   Doing 'make -j32' parallel build
> Warning: Kernel ABI header differences:
>    diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
>    diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
>    diff -u tools/arch/x86/include/asm/amd/ibs.h arch/x86/include/asm/amd/ibs.h
>    diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> 
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                               libpython: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> ...                              libopenssl: [ on  ]
> ...                                    rust: [ on  ]
> 
>    INSTALL libsubcmd_headers
>    INSTALL libapi_headers
>    INSTALL libperf_headers
>    INSTALL libsymbol_headers
>    INSTALL libbpf_headers
>    INSTALL binaries
>    INSTALL tests
>    INSTALL libperf-jvmti.so
>    INSTALL libexec
>    INSTALL perf-archive
>    INSTALL perf-iostat
>    INSTALL python-scripts
>    INSTALL dlfilters
>    INSTALL perf_completion-script
>    INSTALL perf-tip
> make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
> ⬢ [acme@toolbx perf-tools]$   diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
> --- tools/include/linux/coresight-pmu.h	2025-06-16 13:19:13.119223002 -0300
> +++ include/linux/coresight-pmu.h	2026-02-21 18:08:24.737530149 -0300
> @@ -22,30 +22,6 @@
>   #define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
> 
>   /*
> - * Below are the definition of bit offsets for perf option, and works as
> - * arbitrary values for all ETM versions.
> - *
> - * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
> - * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
> - * directly use below macros as config bits.
> - */
> -#define ETM_OPT_BRANCH_BROADCAST 8
> -#define ETM_OPT_CYCACC		12
> -#define ETM_OPT_CTXTID		14
> -#define ETM_OPT_CTXTID2		15
> -#define ETM_OPT_TS		28
> -#define ETM_OPT_RETSTK		29
> -
> -/* ETMv4 CONFIGR programming bits for the ETM OPTs */
> -#define ETM4_CFG_BIT_BB         3
> -#define ETM4_CFG_BIT_CYCACC	4
> -#define ETM4_CFG_BIT_CTXTID	6
> -#define ETM4_CFG_BIT_VMID	7
> -#define ETM4_CFG_BIT_TS		11
> -#define ETM4_CFG_BIT_RETSTK	12
> -#define ETM4_CFG_BIT_VMID_OPT	15
> -
> -/*
>    * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
>    * Used to associate a CPU with the CoreSight Trace ID.
>    * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
> ⬢ [acme@toolbx perf-tools]$ cp include/linux/coresight-pmu.h tools/include/linux/coresight-pmu.h
> ⬢ [acme@toolbx perf-tools]$ m
> make: Entering directory '/home/acme/git/perf-tools/tools/perf'
>    BUILD:   Doing 'make -j32' parallel build
> Warning: Kernel ABI header differences:
>    diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
>    diff -u tools/arch/x86/include/asm/amd/ibs.h arch/x86/include/asm/amd/ibs.h
>    diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> 
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                               libpython: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> ...                              libopenssl: [ on  ]
> ...                                    rust: [ on  ]
> 
>    INSTALL libsubcmd_headers
>    INSTALL libperf_headers
>    INSTALL libapi_headers
>    INSTALL libsymbol_headers
>    INSTALL libbpf_headers
>    CC      /tmp/build/perf-tools/util/cs-etm-decoder/cs-etm-decoder.o
>    CC      /tmp/build/perf-tools/util/cs-etm.o
>    LD      /tmp/build/perf-tools/util/cs-etm-decoder/perf-util-in.o
> In file included from /home/acme/git/perf-tools/tools/include/linux/bits.h:5,
>                   from /home/acme/git/perf-tools/tools/include/linux/bitops.h:14,
>                   from util/cs-etm.c:10:
> util/cs-etm.c: In function ‘cs_etm__init_pid_fmt’:
> util/cs-etm.c:213:31: error: ‘ETM_OPT_CTXTID’ undeclared (first use in this function)
>    213 |                 if (val & BIT(ETM_OPT_CTXTID))
>        |                               ^~~~~~~~~~~~~~
> /home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
>      7 | #define BIT(nr)                 (UL(1) << (nr))
>        |                                            ^~
> util/cs-etm.c:213:31: note: each undeclared identifier is reported only once for each function it appears in
>    213 |                 if (val & BIT(ETM_OPT_CTXTID))
>        |                               ^~~~~~~~~~~~~~
> /home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
>      7 | #define BIT(nr)                 (UL(1) << (nr))
>        |                                            ^~
> util/cs-etm.c:218:32: error: ‘ETM4_CFG_BIT_VMID’ undeclared (first use in this function)
>    218 |                 if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
>        |                                ^~~~~~~~~~~~~~~~~
> /home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
>      7 | #define BIT(nr)                 (UL(1) << (nr))
>        |                                            ^~
> util/cs-etm.c:218:57: error: ‘ETM4_CFG_BIT_VMID_OPT’ undeclared (first use in this function)
>    218 |                 if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
>        |                                                         ^~~~~~~~~~~~~~~~~~~~~
> /home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
>      7 | #define BIT(nr)                 (UL(1) << (nr))
>        |                                            ^~
> util/cs-etm.c:221:36: error: ‘ETM4_CFG_BIT_CTXTID’ undeclared (first use in this function)
>    221 |                 else if (val & BIT(ETM4_CFG_BIT_CTXTID))
>        |                                    ^~~~~~~~~~~~~~~~~~~
> /home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
>      7 | #define BIT(nr)                 (UL(1) << (nr))
>        |                                            ^~
> util/cs-etm.c: In function ‘cs_etm__setup_timeless_decoding’:
> util/cs-etm.c:2934:65: error: ‘ETM_OPT_TS’ undeclared (first use in this function)
>   2934 |                                 !(evsel->core.attr.config & BIT(ETM_OPT_TS));
>        |                                                                 ^~~~~~~~~~
> /home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
>      7 | #define BIT(nr)                 (UL(1) << (nr))
>        |                                            ^~
> make[4]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:95: /tmp/build/perf-tools/util/cs-etm.o] Error 1
> make[3]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:158: util] Error 2
> make[2]: *** [Makefile.perf:797: /tmp/build/perf-tools/perf-util-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:289: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
> ⬢ [acme@toolbx perf-tools]$
> 
> 

