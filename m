Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC531F9B4;
	Wed, 23 Sep 2026 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129838; cv=none; b=YdqrtRdiinmFDthJNqY69L3eeoBf0UZKsUOZECTC2xt3xsZzCfRe1PUd2r9YEO38U68bJ35/1mvbJVYWapczqKKAKImzNM7bXR39f97frzclqX33V0sn+nFU2PfzICnJ243wUAK9OCiBdlrNWnqOZuuXDf35wm1gIc1u92FTngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129838; c=relaxed/simple;
	bh=o2ChluBE/4Fwa5nS12cY6ZuCjs5TyhlXL3NEnVfPuNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l5Vojkj5PpCk8fXibvtxwLsI6+2V2psGGb1q76Z7s/7S18ZwvqROH5lhB0kWdA/pH09Y5b+Zy2Ab/mMm+w0ylJQgR3LZifHszEdHgn9vJSiuag5rN466HSBxv+XrzUWYIHZ0JlYAnZ/tEurnE1NqhUn+Wibw/+2tJy8n8Auo6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hqLFM6Z0DzTSdm;
	Wed, 23 Sep 2026 10:16:55 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hqLFM2QFXzTSdm;
	Wed, 23 Sep 2026 10:16:55 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 019FC102A;
	Wed, 23 Sep 2026 10:16:50 +0800 (CST)
Received: from [127.0.0.1] (10.0.235.124) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 23 Sep
 2026 10:16:54 +0800
Message-ID: <f72c91f6-c32f-4b5e-a6d0-f828a3e19675@hygon.cn>
Date: Wed, 23 Sep 2026 10:16:53 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] perf/x86/amd/uncore: Add Hygon uncore PMU and JSON
 events
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<sandipan.das@amd.com>, <ravi.bangoria@amd.com>, <irogers@google.com>,
	<x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>
References: <20260818100118.12944-1-liuqi@hygon.cn>
Content-Language: en-US
From: Qi Liu <liuqi@hygon.cn>
In-Reply-To: <20260818100118.12944-1-liuqi@hygon.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

Gentle ping for this patch. Any comments would be appreciated. :)

Thanks,
Qi


On 8/18/2026 6:01 PM, Qi Liu wrote:
> This series adds initial uncore PMU support for Hygon Family 18h
> processors.
> 
> Hygon uncore PMUs use a programming model similar to AMD's, but
> differ in MSR base addresses, event encodings, and counter allocation
> semantics. Rather than embedding Hygon support in the AMD uncore
> driver with vendor checks, a dedicated driver is introduced to keep
> both drivers clean and independently maintainable.
> 
> The new driver provides hygon_df and hygon_df_iod PMUs covering the
> Data Fabric on both the CPU die and the IO Die, together with perf
> JSON events and metrics for three processor models. A per-context
> hrtimer handles counter reads, and CPU hotplug callbacks manage
> context lifecycle.
> 
> Changes since RFC:
>    - Address sashiko bot review.
> Changes since v1:
>    - Rename the helper namespace to amd_uncore_common_* to avoid
>      an generic uncore_common_* prefix, and to keep it distinct
>      from the existing amd_uncore_* names.
> Changes since v2:
>    - Drop the common helpers refactoring. Keep the Hygon driver
>      self-contained instead, avoiding unnecessary changes in the AMD
>      uncore driver.
> Changes since v3:
>    - Address sashiko bot review.
> Changes since v4:
>    - Improve Hygon Data Fabric PMU event naming, descriptions, and scaling.
> 
> Qi Liu (2):
>    perf/x86/amd/uncore: Add Hygon uncore PMU support
>    perf vendor events hygon: Add Hygon Data Fabric PMU events and metrics
> 
>   arch/x86/events/Kconfig                       |  11 +
>   arch/x86/events/amd/Makefile                  |   2 +
>   arch/x86/events/amd/hygon_uncore.c            | 872 ++++++++++++++++++
>   arch/x86/events/amd/uncore.c                  |  11 +-
>   arch/x86/include/asm/msr-index.h              |   2 +
>   arch/x86/include/asm/perf_event.h             |  20 +
>   include/linux/cpuhotplug.h                    |   3 +
>   tools/perf/pmu-events/Build                   |   2 +-
>   .../arch/x86/hygonm1/data-fabric.json         |  95 ++
>   .../arch/x86/hygonm4/data-fabric.json         | 134 +++
>   .../arch/x86/hygonm6/data-fabric.json         | 170 ++++
>   tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +
>   tools/perf/pmu-events/jevents.py              |   2 +
>   13 files changed, 1318 insertions(+), 9 deletions(-)
>   create mode 100644 arch/x86/events/amd/hygon_uncore.c
>   create mode 100644 tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
>   create mode 100644 tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
>   create mode 100644 tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
> 


