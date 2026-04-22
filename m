Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BB33F598;
	Wed, 22 Apr 2026 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841615; cv=none; b=Jy39g5WDCev5Oflrl6lOB7tdmKTO///kq4fJRCrRUz8fKFH78LHC4VXo5IuDXzg+7aGZ5+NnGyczKrDGEIT3EBbiYribo1unh0RmcnkKANcagey5OjvDj326PVh8eMTtS8YfqhM7mD7XZ3rrbUgHL/WW8xa/hLQxZANvv3r67QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841615; c=relaxed/simple;
	bh=0BDJEkGSZLVW/7ecvl5BnNy211tmrSCMQcJXOuzy4GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrY6YiJwk6WOm4MBoNc3u3s1yZmTEE7q8C7bXI0MWJ9rnmbykiTt2MvB6VzHFO5F98SJlKrl5Amk9a+TE1cIaRFPx7Lck6a+gK/HONRpq1/DhVAHXuKixy9lljlqyJzvpxR0baR/7VuONzzhKCWukNljQ9ZRjebz+RsptQVjdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRZknDCX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRZknDCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516BCC19425;
	Wed, 22 Apr 2026 07:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776841614;
	bh=0BDJEkGSZLVW/7ecvl5BnNy211tmrSCMQcJXOuzy4GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRZknDCXYVqe3l7/3At82Y0XXAZ4mktvgjn/I/rP9AI/cUsiIWpUAvHGceWW/3xo0
	 TzlkDXnozu8JMhN/yqLbss0wLk3/MYrKTcedUd1MvsH/pu2xE1+fAj2MgzZyZIyXT2
	 LcJURe0dgQo9s3WQeaFJR8wzWpGXW0jrcY0r6C61KXWoJdb8jCscMbkbgED2B63S+h
	 /hAoEXIr0n7MDXtRG7SeB4pPGGrDEgG4GTdeZu0PPqPxCVpw5rAaS21Ftdg/PaVR9u
	 5D4Eeif8kc4h1XVL88RXhfAwNv04urLoyxMUsteI8/n/TWmjuZqhfZ1GUeDtT4XqD4
	 NP73Fyv3JOM6w==
Date: Wed, 22 Apr 2026 00:06:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/x86/intel/uncore: Use sysfs_emit() in
 uncore_event_show()
Message-ID: <aehzjFpaSp6bwp7k@google.com>
References: <20260421150449.59720-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421150449.59720-2-thorsten.blum@linux.dev>

On Tue, Apr 21, 2026 at 05:04:50PM +0200, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
> is preferred for formatting sysfs output because it provides safer
> bounds checking.
> 
> Add a terminating newline as suggested by checkpatch.

I'm ok with adding it but it may cause a compatibility problem..
But I think perf tools can handle it as other PMUs already emit a
newline at the end.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Add a terminating newline as suggested by checkpatch
> - Link to v1: https://lore.kernel.org/lkml/20260206194254.36105-2-thorsten.blum@linux.dev/
> ---
>  arch/x86/events/intel/uncore.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 4684649109d9..86bc1c03b64a 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/module.h>
> +#include <linux/sysfs.h>
>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> @@ -133,7 +134,7 @@ ssize_t uncore_event_show(struct device *dev,
>  {
>  	struct uncore_event_desc *event =
>  		container_of(attr, struct uncore_event_desc, attr);
> -	return sprintf(buf, "%s", event->config);
> +	return sysfs_emit(buf, "%s\n", event->config);
>  }
>  
>  struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
