Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9B30F7EF
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166132; cv=none; b=LqRExVUk6DQM2B71l6u5pIQ8nG5qhQ0oFke3qGsbIlwua78grr7kUuDMj+N+PSnkkS221Y3xw8P/PMg24k1GSWyot8MabZCUzatUB49RfxeE2IPKliUUxog52diBBkPTrx8yBgln1AhlfjHWIzj7ofTcCf6O6HYsY5/kfvWPUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166132; c=relaxed/simple;
	bh=0S+gKCrPbxtirnk/Ccuh+PNkyRgckcD8JV/5mLWPC2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=VuUWaz7fnTONNiZWJ5yJhlpU4Ae4EH7eALNghOyy2ndVbbFXeJFrxBQWOQNpUi2RiX3hRLkdn8bW0ANmLDGyqAsiA74s/6MKEY+LBnN04sQvc7QpGOoM7nF9IrUdcPjf0dk5PsnyVfZnVRzR/pELIbBOe1u/ZOEFBVnJwY4q8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bJCkcKmp; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJCkcKmp"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso10136465e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 03:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769166128; x=1769770928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jv/G1MGb+4f8ZIWOhwVSNcothLIoyDDC/IvXUwLAuxo=;
        b=bJCkcKmpe2nbG1SMolyOEpGihnmsq5POJ4jUtf1vBc9hFXDGRD+2xlBjHLW94XkYsX
         O0pq9WPdfVmVA5imeFDk2rndMYTQAeRTgk75x3U2Zurp6yGRCfIDzybF3cTI7orfnrEP
         eI1D9tXuO3pColJtIOHBJQVcBbVUgw01Dgszx2V5OA6lCKfi0Bfr5Iuf6ny850XwsiGK
         zmfnhrhv8LOXolOBqrfYpFWqd9NmBNEYlt/xOGwIvF21MfyWDn3zlRskzMMKx1Fj0yMb
         caA4YXMZT0ydKx9GMgBuBrhYKFvyloIfbxfC5Ys9ghZSRvpVoiVE/zLgUQqPvTPe8+uC
         g7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769166128; x=1769770928;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv/G1MGb+4f8ZIWOhwVSNcothLIoyDDC/IvXUwLAuxo=;
        b=IGbt/MiTH0KKZpGRc5PXFJ+V1eBNPcdFr1tI/Anvq2cW29ZKpjMDSkTHrCLOpI3l+V
         OGXJ7BV2MiY2YtzGm/0cqwrp1hdCtPyMtj4G+u9yMOYEnZrWKvO6ZEn4p7FzRmixGEcf
         6eCAMdpT18r8UVPaDVkS2IvEgMsjiqDYXGXaOxBTuW850ZN9IcDEcKOfhi8SvSNfc4QP
         B6VEctSLFclmR9kCLwcF6UVMC2NikEEpAaID2PNBBkcI/M+3rDBncz3HqxmFWQLLgFOG
         TDvd7o/jgFCs6/zf7O74F/g0SWdahHXfLZiuNWZeyqGRFdFTqYB8gilVR33nTlAD+xwD
         TaPA==
X-Forwarded-Encrypted: i=1; AJvYcCVYOCVzCn2CUpAXpFCwYt26RPO31esH2sj8rbzhJQnj5OLDcaqrLvIfCC0DmN2xJ24VGzbh94LeWoiZftjiF++7@vger.kernel.org
X-Gm-Message-State: AOJu0YzOD9PP5kSKBmSSzTEA1Z1UwNhUHipR3QcHGys8UovAOj18LhK+
	st9X/+lL/4s4WhtGisKps+Wv9imxSHZHPq0WwzaNokJ70tXN+Nr3F0C13LZw27Wlad0=
X-Gm-Gg: AZuq6aLs9ncEbZe3X80i4YGzzuaq3rw8kvIAbOfTa9467kRQOcMpPj8lNAJPFNCNMV9
	IMe4C7X32IiGucZx/2fJUo787Qww7oeW9Ifj3KxWkJAti8snNRsx1GtvIiAJKNHGarWobtjCFUh
	61zFhjBxSJRLL7/nnOmRyIGlp4dhdq4BYUpa77kBGB+F9GNk0CLkCWS4c+9WxmNK9KnNKYUpsTv
	ch9mIUB2755v5GBB2KmbvyxkQVzzMMQp1XNRShYdyY13M6EG8e615R3FTQt5opCzZdzBTtwny3m
	DWkOFurEAvhCxOWNhQ976d0vuw8vcGnKdQZ2KdPmCKRZzvfIMqW3sYqOO8BlBx8r6Is24l3cLQH
	iSFReBQ10WuM7QVyAU1/FQfiMHjpnySGRVVu65vvuuhlucY3Z2ZXyInuSGCmMYwk9N8WVU0G5gE
	HF5bhmePu7naaQi3M1
X-Received: by 2002:a05:600c:3b18:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-4804c94c4c4mr36618455e9.11.1769166127961;
        Fri, 23 Jan 2026 03:02:07 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbc0d84sm18454735e9.6.2026.01.23.03.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 03:02:07 -0800 (PST)
Message-ID: <1310a240-077a-49f6-b83a-a8a4fd52127b@linaro.org>
Date: Fri, 23 Jan 2026 11:02:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] perf annotate arch clean up
To: Ian Rogers <irogers@google.com>
References: <20260122213516.671089-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Zecheng Li <zecheng@google.com>, Tianyou Li <tianyou.li@intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Julia Lawall
 <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>,
 Athira Rajeev <atrajeev@linux.ibm.com>,
 Aditya Bodkhe <aditya.b1@linux.ibm.com>, Howard Chu <howardchu95@gmail.com>,
 =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Shimin Guo <shimin.guo@skydio.com>, Sergei Trofimovich <slyich@gmail.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-riscv@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260122213516.671089-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/01/2026 9:35 pm, Ian Rogers wrote:
> 3 initial memory leak fix patches for perf annotate.
> 
> Move the disasm.c #included arch files into a new util/annotate-arch
> directory. Make the code compile standalone. Try to better encapsulate
> architecture specific code within the files and with a
> arch__new_<arch> function that allows additional data to be associated
> with the struct arch using the standard container_of trick.
> 
> Make the lookup of struct arch use the ELF machine gather from a
> thread rather than an evsel. For example, the evsel can't determine
> the difference between EM_386 and EM_X86_64 so generally the latter
> has currently been used. This means the dwarf registers are off as
> register 1 is CX with EM_386 and DX with EM_X86_64. To facilitate this
> change map_symbol is refactored to use a struct thread rather than a
> struct maps, the maps being obtainable from the thread.
> 
> To make in and out arguments clearer, for safety, etc. try to constify
> struct arch and its related structs.
> 
> v3: Fix arch initialization on arm, arm64, powerpc and sparc as spotted by Suchit
>      Karunakaranw.
> 
> v2: Add a patch to fix a domain info memory leak that was blocking
>      leak sanitizer analysis. Fix more map_symbol leaks or uses after
>      reference count put (Suchit Karunakaranw
>      <suchitkarunakaran@gmail.com>).  Try to repro annotate test crash
>      (James Clark) but suspect it was addressed in the other reference
>      count fixes.
>      https://lore.kernel.org/lkml/20260122165407.561888-1-irogers@google.com/
> 
> v1: https://lore.kernel.org/lkml/20260122073127.375139-1-irogers@google.com/
> 
> Ian Rogers (12):
>    perf header: Fix memory leaks in process_cpu_domain_info
>    perf annotate: Fix args leak of map_symbol
>    perf maps: Fix reference count leak in maps__find_ams
>    perf disasm: Constify use of struct arch
>    perf disasm: Constify use of struct ins_op
>    perf disasm: Constify use of struct ins
>    perf disasm: Rework the string arch__is to use the ELF machine
>    perf disasm: Don't include C files from the arch directory
>    perf disasm: Refactor ins__is_call/jump to avoid exposing arch ins_ops
>    perf map_symbol: Switch from holding maps to holding thread
>    perf disasm: Refactor arch__find and initialization of arch structs
>    perf disasm: Minor layout tweaks for struct arch
> 
>   tools/perf/arch/arc/annotate/instructions.c   |  11 -
>   .../perf/arch/riscv64/annotate/instructions.c |  36 --
>   tools/perf/ui/browsers/annotate.c             |   6 +-
>   tools/perf/ui/browsers/hists.c                |   3 +-
>   tools/perf/util/Build                         |   1 +
>   tools/perf/util/addr_location.c               |   4 -
>   tools/perf/util/addr_location.h               |   1 -
>   tools/perf/util/annotate-arch/Build           |  11 +
>   tools/perf/util/annotate-arch/annotate-arc.c  |  18 +
>   .../annotate-arch/annotate-arm.c}             |  50 +-
>   .../annotate-arch/annotate-arm64.c}           |  59 +--
>   .../annotate-arch/annotate-csky.c}            |  29 +-
>   .../annotate-arch/annotate-loongarch.c}       |  71 +--
>   .../annotate-arch/annotate-mips.c}            |  29 +-
>   .../annotate-arch/annotate-powerpc.c}         | 127 +++++-
>   .../util/annotate-arch/annotate-riscv64.c     |  41 ++
>   .../annotate-arch/annotate-s390.c}            |  70 +--
>   .../annotate-arch/annotate-sparc.c}           |  28 +-
>   .../annotate-arch/annotate-x86.c}             |  89 ++--
>   tools/perf/util/annotate-data.c               |  12 +-
>   tools/perf/util/annotate-data.h               |   2 +-
>   tools/perf/util/annotate.c                    |  88 ++--
>   tools/perf/util/annotate.h                    |  10 +-
>   tools/perf/util/callchain.c                   |  12 +-
>   tools/perf/util/capstone.c                    |  18 +-
>   tools/perf/util/db-export.c                   |   1 -
>   tools/perf/util/disasm.c                      | 428 +++++++-----------
>   tools/perf/util/disasm.h                      |  95 ++--
>   tools/perf/util/event.c                       |   2 -
>   tools/perf/util/header.c                      |  17 +-
>   tools/perf/util/hist.c                        |  18 +-
>   tools/perf/util/llvm.c                        |   8 +-
>   tools/perf/util/machine.c                     |  13 +-
>   tools/perf/util/map_symbol.c                  |   5 +-
>   tools/perf/util/map_symbol.h                  |   3 +-
>   tools/perf/util/maps.c                        |   1 +
>   tools/perf/util/sort.c                        |   2 +-
>   tools/perf/util/unwind-libdw.c                |   2 +-
>   tools/perf/util/unwind-libunwind-local.c      |   2 +-
>   39 files changed, 775 insertions(+), 648 deletions(-)
>   delete mode 100644 tools/perf/arch/arc/annotate/instructions.c
>   delete mode 100644 tools/perf/arch/riscv64/annotate/instructions.c
>   create mode 100644 tools/perf/util/annotate-arch/Build
>   create mode 100644 tools/perf/util/annotate-arch/annotate-arc.c
>   rename tools/perf/{arch/arm/annotate/instructions.c => util/annotate-arch/annotate-arm.c} (59%)
>   rename tools/perf/{arch/arm64/annotate/instructions.c => util/annotate-arch/annotate-arm64.c} (70%)
>   rename tools/perf/{arch/csky/annotate/instructions.c => util/annotate-arch/annotate-csky.c} (67%)
>   rename tools/perf/{arch/loongarch/annotate/instructions.c => util/annotate-arch/annotate-loongarch.c} (60%)
>   rename tools/perf/{arch/mips/annotate/instructions.c => util/annotate-arch/annotate-mips.c} (59%)
>   rename tools/perf/{arch/powerpc/annotate/instructions.c => util/annotate-arch/annotate-powerpc.c} (73%)
>   create mode 100644 tools/perf/util/annotate-arch/annotate-riscv64.c
>   rename tools/perf/{arch/s390/annotate/instructions.c => util/annotate-arch/annotate-s390.c} (66%)
>   rename tools/perf/{arch/sparc/annotate/instructions.c => util/annotate-arch/annotate-sparc.c} (85%)
>   rename tools/perf/{arch/x86/annotate/instructions.c => util/annotate-arch/annotate-x86.c} (93%)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

