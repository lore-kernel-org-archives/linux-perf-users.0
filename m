Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47590C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Dec 2021 09:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhLUJcz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:32:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhLUJcz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Dec 2021 04:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640079174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mCyMBqsx0+T4QPyEd7ZrYXkaRKnsvvoRPD3qaSvMqhM=;
        b=ELm1koxtnuHus6M6iGK2nKnLPHQSx0LrQY9buPC4WqF9j4QHM6EDcNCOiUrmn5ULOsW2wB
        WDkq8ywUxDCadKw20hHz1QCxQA4x5qKF7UFRJOCfSXiUVhrm399DvgMTveXJjKFEMiMhQd
        SSsLhDYGLf2ZO5FNwxpzdxhzygpjgs4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-Rz__G_DVOwiZk28TVsFGdQ-1; Tue, 21 Dec 2021 04:32:53 -0500
X-MC-Unique: Rz__G_DVOwiZk28TVsFGdQ-1
Received: by mail-wm1-f69.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so2654239wme.6
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Dec 2021 01:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mCyMBqsx0+T4QPyEd7ZrYXkaRKnsvvoRPD3qaSvMqhM=;
        b=L6vv6RMeb2KTuDd7pYU/jfktw5EstoV1TEJEW8G8LCz74xuEAIQBtE+FhME/mmKi/7
         pgELnmS+sVrJMTM0mLuXC2+wzsIus0+JamAJ50EwglyVdMtLbRdFZQ+3ejCaatNG/KnP
         8OHSFAMfJ3wuPfLSAq8XRbBkZQOTjIFlfTb36YSwQGwWuysQZY8M6cOYiGJbSp9+fNup
         oS50TEgp61y+Bl1q9Y3o1KEG4XQCrFIOXQeG57MFZTPx3+A4PstW1b2OxpcWkEowKkDt
         5q1dn/0TeuoT6M7TENgwMS/aTZt466UUe5QzKwrHTGb+qKhgDdPrjUlUQeoIFNpzHDDV
         yyUQ==
X-Gm-Message-State: AOAM533y6yXLfA1jRp8B78FUTb5QKypOsIwsA2ODlVoZWlqiwPwkPBC1
        im3Jdn5c8XwNkOg/O487lZWL9O6s541B4V/qxjwTRJDmlYSoII9UA+88L6k7mmApxuR4mIoU+6U
        IY92Bz0s4Mn9wv6/7MoJ6QfuVxEjudg==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr1852398wrm.173.1640079172356;
        Tue, 21 Dec 2021 01:32:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw29r3qkxa9w0B+yxSrJLReP5KQO3o4hOC/ypoOMuLMXQBGmoYWNMIbo1P2Y3OJrR5jfeFQyQ==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr1852377wrm.173.1640079172099;
        Tue, 21 Dec 2021 01:32:52 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d4sm8881844wrx.102.2021.12.21.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:32:51 -0800 (PST)
Date:   Tue, 21 Dec 2021 10:32:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 6/6] perf arm64: inject missing frames if perf-record
 used "--call-graph=fp"
Message-ID: <YcGfQr43ChIgtacC@krava>
References: <20211217154521.80603-1-german.gomez@arm.com>
 <20211217154521.80603-7-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217154521.80603-7-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Dec 17, 2021 at 03:45:20PM +0000, German Gomez wrote:

SNIP

> +}
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int usr_idx)
> +{
> +	int ret;
> +	struct entries entries = {};
> +	struct regs_dump old_regs = sample->user_regs;
> +
> +	if (!get_leaf_frame_caller_enabled(sample))
> +		return 0;
> +
> +	/*
> +	 * If PC and SP are not recorded, get the value of PC from the stack
> +	 * and set its mask. SP is not used when doing the unwinding but it
> +	 * still needs to be set to prevent failures.
> +	 */
> +
> +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_PC))) {
> +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_PC);
> +		sample->user_regs.cache_regs[PERF_REG_ARM64_PC] = sample->callchain->ips[usr_idx+1];
> +	}
> +
> +	if (!(sample->user_regs.mask & SMPL_REG_MASK(PERF_REG_ARM64_SP))) {
> +		sample->user_regs.cache_mask |= SMPL_REG_MASK(PERF_REG_ARM64_SP);
> +		sample->user_regs.cache_regs[PERF_REG_ARM64_SP] = 0;
> +	}
> +
> +	ret = unwind__get_entries(add_entry, &entries, thread, sample, 2);

just curious, did you try this with both unwinders libunwind/libdw?

any chance you could add arm specific test for this?

otherwise it looks good to me

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> +	sample->user_regs = old_regs;
> +
> +	if (ret || entries.length != 2)
> +		return ret;
> +
> +	return callchain_param.order == ORDER_CALLER ? entries.stack[0] : entries.stack[1];
> +}
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.h b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> new file mode 100644
> index 000000000000..32af9ce94398
> --- /dev/null
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +#define __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +
> +#include "event.h"
> +#include "thread.h"
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int user_idx);
> +
> +#endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3eddad009f78..a00fd6796b35 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -34,6 +34,7 @@
>  #include "bpf-event.h"
>  #include <internal/lib.h> // page_size
>  #include "cgroup.h"
> +#include "arm64-frame-pointer-unwind-support.h"
>  
>  #include <linux/ctype.h>
>  #include <symbol/kallsyms.h>
> @@ -2710,10 +2711,13 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
>  	return err;
>  }
>  
> -static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
> -		struct thread *thread __maybe_unused, int usr_idx __maybe_unused)
> +static u64 get_leaf_frame_caller(struct perf_sample *sample,
> +		struct thread *thread, int usr_idx)
>  {
> -	return 0;
> +	if (machine__normalize_is(thread->maps->machine, "arm64"))
> +		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
> +	else
> +		return 0;
>  }
>  
>  static int thread__resolve_callchain_sample(struct thread *thread,
> @@ -3114,14 +3118,19 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
>  }
>  
>  /*
> - * Compares the raw arch string. N.B. see instead perf_env__arch() if a
> - * normalized arch is needed.
> + * Compares the raw arch string. N.B. see instead perf_env__arch() or
> + * machine__normalize_is() if a normalized arch is needed.
>   */
>  bool machine__is(struct machine *machine, const char *arch)
>  {
>  	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
>  }
>  
> +bool machine__normalize_is(struct machine *machine, const char *arch)
> +{
> +	return machine && !strcmp(perf_env__arch(machine->env), arch);
> +}
> +
>  int machine__nr_cpus_avail(struct machine *machine)
>  {
>  	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index a143087eeb47..665535153411 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -208,6 +208,7 @@ static inline bool machine__is_host(struct machine *machine)
>  }
>  
>  bool machine__is(struct machine *machine, const char *arch);
> +bool machine__normalize_is(struct machine *machine, const char *arch);
>  int machine__nr_cpus_avail(struct machine *machine);
>  
>  struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
> -- 
> 2.25.1
> 

