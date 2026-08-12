Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38307265623;
	Wed, 12 Aug 2026 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786511273; cv=none; b=Alw0jzk5yffIpX6di9/XFXNuw4sz4Bj0JuJ142IDKK5XxofdgQrFkI7flhc7EgLNPRFuRun11MV2814/aNLOxrYlwWu9ZW/ha5Ghu7QmvWek+DCFhofjcFZOhnAx8d8Z5GyGz2JtgM/bZmr2BjnsZXpS0GwiA8QvLMHiNG+PEJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786511273; c=relaxed/simple;
	bh=eYnllZOFcKKEnhe1ZNG7zuu8dk2eWZv7Zh6nW7SLorQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdQC/j5vXj7HA0ElECre5tTDUyV9QU6cHrFEaCnrgpL9wbcBNGO7P/+68lNMdxSPo4NeZvqdIeD1ZO5g2M2jQ1XXx1M+DpVCvUO+xs14c6RLThFZ0MR/9jb9r7zmlzy8Eq11URV8kVUTwdcDteZceh+l07WDEnBvfSlKjfYaFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLkqmC+6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLkqmC+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786511271; x=1818047271;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eYnllZOFcKKEnhe1ZNG7zuu8dk2eWZv7Zh6nW7SLorQ=;
  b=LLkqmC+6RvVeCd5N6RyKTl9bKkTkk8cpbTuzNO90mPQU4GS1TZspug3H
   WuxaSBQgIMIPmQaTm8BhfTE3vtAMJpyiT4Ok15KZKMzNe4M4b7qSThFXe
   7AoMyeBU2tEJp7h6SKxWlnpVm9v6QBM1M1zGFn/6pHQMHbjlGwO6hjJD/
   dFz61KLhJgb50BTfSfboF0YpGWKiEwpJxjN3ZA5GTXpr6O/YLv9iJus8l
   mrQgKpx2XgXKD21ZfVrCWE7z12CpfMfVJoXmCjC9LsGafjTPJYkOJCKwD
   UK50l4daTNtClxlJyzi8RRrotnRoBVzX9END7p7ueCEJlBBzzME1XbIBW
   Q==;
X-CSE-ConnectionGUID: XB7lqdWdTFKKyiti3Xbx0A==
X-CSE-MsgGUID: agdbaGTtSV296KddqS8K/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98199567"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="98199567"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 22:07:50 -0700
X-CSE-ConnectionGUID: 8foD9iP1S924MPgxqyQlSg==
X-CSE-MsgGUID: Xj7MJY6BS86yoB84mfdeiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="301771248"
Received: from unknown (HELO [10.238.3.58]) ([10.238.3.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 22:07:46 -0700
Message-ID: <6c6e55c5-8275-4cb5-9f86-8770cc7ad19b@linux.intel.com>
Date: Wed, 12 Aug 2026 13:07:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] perf/x86/intel/uncore: Use sysfs_emit() in
 uncore_event_show()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260726094120.331668-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260726094120.331668-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 7/26/2026 5:41 PM, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
> is preferred for formatting sysfs output because it provides safer
> bounds checking.
>
> Add a terminating newline as suggested by checkpatch.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Add a terminating newline as suggested by checkpatch
> - Link to v1: https://lore.kernel.org/r/20260206194254.36105-2-thorsten.blum@linux.dev/
> ---
>  arch/x86/events/intel/uncore.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 7857959c6e82..1ef4b4a5f545 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/module.h>
> +#include <linux/sysfs.h>
>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> @@ -153,7 +154,7 @@ ssize_t uncore_event_show(struct device *dev,
>  {
>  	struct uncore_event_desc *event =
>  		container_of(attr, struct uncore_event_desc, attr);
> -	return sprintf(buf, "%s", event->config);
> +	return sysfs_emit(buf, "%s\n", event->config);
>  }
>  
>  struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
>
