Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D93CCFAA
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236521; cv=none; b=h8PWL1zkFadx1quZGG588yxCAnMYCvLXTSkIMy6FsNQTI5EwmuBrWD4KNpISZ3JBpQnHlTk6kJnOS1xczRN3HLRh1ZJ1YRQ65zhKHnuK/4pKWHZxqIXM1Do30mNQxxVGA3cQW1+E/+gE+BXmUW841unVf/lWEkZARzVP5Itq138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236521; c=relaxed/simple;
	bh=JQK3hrovNbDqyQGBikNRDHaNzQIOvGOdnrM1d/6jyMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=uZChWRCKw1bFuiyKIZ1KjywaYmG9VBH3pJerctZePUUo2UsbRPQ38mvcbmovd0iUG3hsjJI8vHc0r8wlgKRUC2XitgBKegnIoFLjVxIp0By1608gdg7ttZpQ92hpLa6mt4aJb1GrwDkNryF7nu9DUnMGVSUOg3vysQxEEHqcQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zAQ+m8Zj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAQ+m8Zj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so15813775e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778236518; x=1778841318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXxVR9ktw+abbKoY0TaVXtuKQhdeigQeA3fCn9vNJLQ=;
        b=zAQ+m8ZjJjZYVgAQtC0bxFiPmpxwE6pWkGkZVR3I8Hks6IO3y7R07doZiUXbTtEJGy
         ScGMRmwP7xl3xDD6daPijA3wju1FIBsUkAJjBSLT3huT4WNjd+ggB6B6Bh/9ByEwZZL2
         eVSAzuNwuoRdu5Vd5eSexQPoC+Rd444lKUsfJpVRWCP5aKvoLXL07fuOqn7stEihgUG+
         mkHbevfL5GZeT1sPJ5jpiZcZehEdyFhUNbLeo2X0/rtBOipvst0Rc110GBv08Q9GxJJm
         Omz1WH68RMOUh5c3wIXkR7xefiFinws5RWC600sXCtEfKPfrvTLpEhDhX21DTGfGw4W4
         ERsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236518; x=1778841318;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXxVR9ktw+abbKoY0TaVXtuKQhdeigQeA3fCn9vNJLQ=;
        b=cG7WBtNkRjz4bgTt75X761HCkkBopg2GM0ofjMiVynI3PtdoBBhiP0jManTJIqo7ag
         i7QHIVoKhPKVQSljC6loQFhv6rLC2okNqVa3LzqMbe0USr0LhnyVGEQV50O827vYHM7y
         o4fx5f2iyYt4slRLuLcJ8J5c09N0tczWNCplzzQN1qLmCjFa87DALYPFriOe/i6vOwn+
         cJVckl2OfC7hg9FqFWNm9qXxIZPpTymFgEyy9PxYS4Fg02YFl0qgxw9jDOlcoKUUOU7Q
         flhJ24xOAKvbmkHvlJrW9DELR5skFkhaH79rRdgh3PZxzKzKoGqpjnaSkSIDkbpRtrB6
         zBIg==
X-Forwarded-Encrypted: i=1; AFNElJ+U1GzRm0bzYNL21QJlGllEa++3MKeXcAwRScaifBRU/ONkyTqwDDOaWzpQ3FSWPqa9+nQAzy90d9Vfyda6sF1K@vger.kernel.org
X-Gm-Message-State: AOJu0YzHe8eMr3zAikgRBympobobFoPP1+YT1NAwCODC4pZA13aQ/Iqo
	qgoHYkY5gaNdCGWtADAD04P8X97mnDj0pvWbr5OlopTN9g31NVxf0USCr8oPhHIc8d4=
X-Gm-Gg: AeBDietZHzF4b4mYHqr0Gf6xy1DINjcyihqICDw1AxxdWGORDZFN4B0FoVguqQNy2ki
	nSZ8f4vpe9vR9igLeEHoiCBjQ/Yb+L5b5Z1EoRDreE1NfqjiFQM9lcZIx/GZwdQ9fLCtdkEhIq2
	B3XGMX0M5kiyPy7RcoeaEB11H3zzRpkn0kwiWwEfs5CgxSqOB2EMom2YFC8R0Y3UoG6h2gUaLap
	sppJCFAlvowbbjWZw/O7N2SIjJth6yCjbyuKdR8cP1Nbua35jQNqiWiLnAW0BkcAWxKcV397keP
	S5l5dW63W6uFkXexd+uXJdhwPPx3NHaaWeMQzIsMeHvS55/skvXlHa/kzdQbwNd6tPhJuGDRJ8f
	Nq1D0AUHwUY3/dqBKiyA6026XyHfs1VYX060ExEx1RHo/u5GX92yuPoA3fICRQfuqDpNSfaxie2
	L8YeegCEoXb6xuh2A1kNsRv3uh6H78
X-Received: by 2002:a05:600c:c4a3:b0:48a:6fd4:d3d4 with SMTP id 5b1f17b1804b1-48e51f46e38mr191476395e9.29.1778236518261;
        Fri, 08 May 2026 03:35:18 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68ed0f4csm51135635e9.3.2026.05.08.03.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:35:17 -0700 (PDT)
Message-ID: <7667abfd-aa06-43e7-b699-0fbf6606f64d@linaro.org>
Date: Fri, 8 May 2026 11:35:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf record: Refactor ARM64 leaf caller setup out of
 arch
To: Ian Rogers <irogers@google.com>
References: <20260507170622.611933-1-irogers@google.com>
Content-Language: en-US
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Shimin Guo <shimin.guo@skydio.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260507170622.611933-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/05/2026 6:06 pm, Ian Rogers wrote:
> Code in tools/perf/arch causes portability issues/opaqueness and LTO
> issues due to the use of weak symbols. Move the adding of LR to the
> sample_user_regs into arm64-frame-pointer-unwind-support.c conditional
> on EM_HOST == EM_AARCH64 (false on all non-ARM64 builds). This also
> better encapsulates the use of the sampled registers by
> get_leaf_frame_caller_aarch64 and the set up by the new
> add_leaf_frame_caller_opts_aarch64, exposing opportunities for
> possibly sampling PC and SP to help the unwinder.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/arch/arm64/util/Build                     |  1 -
>   tools/perf/arch/arm64/util/machine.c                 | 12 ------------
>   tools/perf/builtin-record.c                          | 11 +++++------
>   tools/perf/util/arm64-frame-pointer-unwind-support.c |  6 ++++++
>   tools/perf/util/arm64-frame-pointer-unwind-support.h |  2 ++
>   5 files changed, 13 insertions(+), 19 deletions(-)
>   delete mode 100644 tools/perf/arch/arm64/util/machine.c
> 
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 4e06a08d281a..638aa6948ab5 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -5,7 +5,6 @@ perf-util-y += ../../arm/util/pmu.o
>   perf-util-y += arm-spe.o
>   perf-util-y += header.o
>   perf-util-y += hisi-ptt.o
> -perf-util-y += machine.o
>   perf-util-y += mem-events.o
>   perf-util-y += pmu.o
>   perf-util-y += tsc.o
> diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
> deleted file mode 100644
> index 80fb13c958d9..000000000000
> --- a/tools/perf/arch/arm64/util/machine.c
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -#include "callchain.h" // prototype of arch__add_leaf_frame_record_opts
> -#include "perf_regs.h"
> -#include "record.h"
> -
> -#define SMPL_REG_MASK(b) (1ULL << (b))
> -
> -void arch__add_leaf_frame_record_opts(struct record_opts *opts)
> -{
> -	opts->sample_user_regs |= SMPL_REG_MASK(PERF_REG_ARM64_LR);
> -}
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4a5eba498c02..272bba7f4b9e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -14,6 +14,7 @@
>   #include "util/parse-events.h"
>   #include "util/config.h"
>   
> +#include "util/arm64-frame-pointer-unwind-support.h"
>   #include "util/callchain.h"
>   #include "util/cgroup.h"
>   #include "util/header.h"
> @@ -3230,10 +3231,6 @@ static int record__parse_off_cpu_thresh(const struct option *opt,
>   	return 0;
>   }
>   
> -void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
> -{
> -}
> -
>   static int parse_control_option(const struct option *opt,
>   				const char *str,
>   				int unset __maybe_unused)
> @@ -4319,8 +4316,10 @@ int cmd_record(int argc, const char **argv)
>   
>   	evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cpu_list);
>   
> -	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP)
> -		arch__add_leaf_frame_record_opts(&rec->opts);
> +	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP) {
> +		if (EM_HOST == EM_AARCH64)
> +			add_leaf_frame_caller_opts_aarch64(&rec->opts);
> +	}
>   
>   	err = -ENOMEM;
>   	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0) {
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> index 858ce2b01812..3af8c7a466e0 100644
> --- a/tools/perf/util/arm64-frame-pointer-unwind-support.c
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> @@ -2,6 +2,7 @@
>   #include "arm64-frame-pointer-unwind-support.h"
>   #include "callchain.h"
>   #include "event.h"
> +#include "record.h"
>   #include "unwind.h"
>   #include <string.h>
>   
> @@ -16,6 +17,11 @@ struct entries {
>   
>   #define SMPL_REG_MASK(b) (1ULL << (b))
>   
> +void add_leaf_frame_caller_opts_aarch64(struct record_opts *opts)
> +{
> +	opts->sample_user_regs |= SMPL_REG_MASK(PERF_REG_ARM64_LR);
> +}
> +
>   static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
>   {
>   	struct regs_dump *regs;
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.h b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> index 42d3a45490f5..ba35b295bfcd 100644
> --- a/tools/perf/util/arm64-frame-pointer-unwind-support.h
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> @@ -5,8 +5,10 @@
>   #include <linux/types.h>
>   
>   struct perf_sample;
> +struct record_opts;
>   struct thread;
>   
> +void add_leaf_frame_caller_opts_aarch64(struct record_opts *opts);
>   u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int user_idx);
>   
>   #endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */

Reviewed-by: James Clark <james.clark@linaro.org>

