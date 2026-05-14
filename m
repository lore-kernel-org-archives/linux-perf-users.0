Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F04332614
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780302; cv=pass; b=G6XBoFJOrlNAgkRC7dVp4TqeqxJLD87lUUk3dZ1vUAuwV3pPP7d/PgrDqte+Zk16xRum0LbDicD5mlXpgzTX1IzyH+jR5nP/qWrvDQo0JXF3np/hqBYBNGb+TPJifL+soq++6teo3T+M9Gy1PfhR1iovuNIRp6I4mbF5y/jq/Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780302; c=relaxed/simple;
	bh=1Y2wg0UM/Iz8wHz2RrlGJx+2d9jgcg0jemE2AbRW/oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfHwHKO3kDDMZzM6xhL2E2z4jJCcmIKud7SYx76Ee5evEidewexM+qLEUK5hhsy7odd14ikdqLOaPPMN5ft1Iud5wwvq/mS3btibZOPvoSx37SMQ1Fvr0vSxYR1llFHqRg4maC3tAz/aQ4HYI9T/TtKzqt4k9SHGL/2gTTYc8cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UibVc8js; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UibVc8js"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-133362c30cfso39c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 10:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780300; cv=none;
        d=google.com; s=arc-20240605;
        b=IQb40iKGIj46r4X2QeEYi4aoHvwWynwJaDwxljOqBkmTankHeZ5n4EXFimo3sg94cZ
         +MXgXhKseYACtgcPu/ts2DHZvUvatrQTvYCbsP38YgQzr0kMRtyCQXc5nTksmm2c3zT1
         QypyNbIY7AQM7XDlIYIwZIYpstwk1ovwts+3WKz9fWpT0kDSs1hkw+tAhe8ow7dvFSqE
         koiHAjSoIQj39AzfGsNpAWyq10a9ildQqQricdzUi8ralwBib/FFVKhkX7NIS+2H/EWJ
         dKEna+laepNi5MRIBBI1kZ8HzvA2Z6QbqZyOFdwHRK731/RNl84uNGaMV+JY4C4p85kP
         IGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MCebIUvWdek9ffLsdYCTbu7+qSMezZEeZA0ykXUFeOs=;
        fh=+t+Nq5xBI3WKaoTUNPOUYTMNbFyiswPhSLPaB/O5lHA=;
        b=ApEvqpVd4ZTw86eetYrRqcHv0lHqUhc9iMyhx8z4llriVqu7IH78cHoKRQgqHc3Gud
         sub0EdlCo1FKCxTpB9IrNHRHakysN78SLeZA3NA28KNAUUVHteG6DpRGrs/iv+qTw4Ab
         jslbBxrBZCwkLB8B5MQU4xcUffEkxR3jCeW8lSR84k+3/NKZlp8OcKDxefIFydDjjsNB
         yt2f0EShBm+RCh2BFQki3AGYmO1E/aQpbZnoMc3K6+JTFpS0N6ZtDjm94tHU4nHuhnyn
         4UtMXZBiECoVr26OtIR+Tj0EBXt1C4nlP3IavI7+SkPohxarqJQ8k/GCjeaWgA5J0eHW
         lyvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778780300; x=1779385100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCebIUvWdek9ffLsdYCTbu7+qSMezZEeZA0ykXUFeOs=;
        b=UibVc8jsLUDtsGlSXA1BUsgr/jENsyfsv6XB/xLvSYc6t8gfMf0KBDMuqSOC0sb8D0
         k5XUHh1ywf0nPhAovDz1BGkA/9ccunK/9BQKFxy5/YfpjBE7zxuIsROn4brebVOn7Bmn
         7LyEBlOGUt2Lv3Ut/okrEE7Wrw2bO1Cv2CvHc+mxbHle8/6qic2/KQLPum3pQNFC1Jpg
         OjwPVMOBrTyf04+qJgAvYrvF5zuytjlcBGZwGykHTHch+6hup233LbJPQEJx8rwcihpq
         LhFyfh3cDJ37PuQLuXH1Nj5n0t9RiE+Sd7V7dWMwAl3d4GV3kOM/LDVuxuLlCr349jkc
         bAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780300; x=1779385100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MCebIUvWdek9ffLsdYCTbu7+qSMezZEeZA0ykXUFeOs=;
        b=JoVfdTQBWyJiTwHhIXtEkn/pOojwd/xRTbz5fNcY6U8BQb0g4pZ7Mmt8lQh3MyEuop
         q0WaHjxI8c2FfyXuRoG51I7qrbFNd7QSbK31x2tZP00URVNot18KgCVB0XmnkfT0Ic90
         9TAjZoc6o8RxW8kvRjDx9/HzwK3mYtDP/u0rjH78XxO5m0w6mBhpVsgZn5o5a+F2WZov
         9grwskosFNyrUpxv4Yp/CKctVWKzkVjcPHEBvWuKawSv8kOqt9UbZgGdHmuWInsOPYOR
         ucz/Uv55qwSt+7E4WDHAhYtJIqiEbspDR5wwSbfX30ko+0ZlxguD0YHQdLgNaIlo4Eov
         96YA==
X-Forwarded-Encrypted: i=1; AFNElJ/EQIH2CvARYdx0gg1Kzwb3o/b8Che3mIb/nKbmdWDb2KOQW/xuEqJziuDAqVNqmPB9d+s1VvHCyfeIK7rRd4F8@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBYoB5WPRl2zBq947KRURurTUA2JRFYIlYiE9SgOVl+51hhxZ
	vWul52mDcndaFzLYFSF5MAiOGuOtvHqib/wQvqNxkKDhOE7Ju5BcJk3ajgU0GjHc5VwM2HVjhik
	ZFoisYiaj5zFp3DZwbx/IZF6Hnf2IOnv7z3ONQd9G
X-Gm-Gg: Acq92OE20gdbyZ+WFBd/t9EVppVjuSCcETUHa6mgX38rHs7f99wEhDNV9hxG9CvXQKP
	ZPcpQsioMnYN1Nb7CMHTjDvatvgGqA57NOW+/2cD8d7qg1UKOf7xf6L4B24pxlbW/Rb6ziAhZT7
	sPK/XzwVLgaKYixPcb+b0Wx6ZbYOSE46jxOGeGctU8NnHnIdB9ToRLzyVXtZVLzbqD8RPPILe8L
	Ov0xJP3g2551isGDdvAfE+DLWtB46pnGEtnWjG7cp5BWrOKQE1HecXIv7dNelyX27ttqZ5Mn1j4
	lTWFaYr85GdSK8lr4xZWsy/Ho1+w8T5OT66pst//xdvDPt0=
X-Received: by 2002:a05:7022:45a7:b0:133:3bc1:bf2e with SMTP id
 a92af1059eb24-1350451547amr5152c88.5.1778780299123; Thu, 14 May 2026 10:38:19
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507170622.611933-1-irogers@google.com> <20260512054140.3427725-1-irogers@google.com>
In-Reply-To: <20260512054140.3427725-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 May 2026 10:38:07 -0700
X-Gm-Features: AVHnY4I4k6mz_Wz1zIKPWAsdKjgNaTco1O5-EZ3IibJ6wzdRapr07F3AxY1iqt8
Message-ID: <CAP-5=fU7Y5b2KERuYJuKBK0nqD6GAo_r_QhxesbVw6T3bqrgQQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf record: Refactor ARM64 leaf caller setup out of arch
To: acme@kernel.org, james.clark@linaro.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	dapeng1.mi@linux.intel.com, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mike.leach@arm.com, mingo@redhat.com, 
	peterz@infradead.org, shimin.guo@skydio.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:41=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Code in tools/perf/arch causes portability issues/opaqueness and LTO
> issues due to the use of weak symbols. Move the adding of LR to the
> sample_user_regs into arm64-frame-pointer-unwind-support.c conditional
> on EM_HOST =3D=3D EM_AARCH64 (false on all non-ARM64 builds). This also
> better encapsulates the use of the sampled registers by
> get_leaf_frame_caller_aarch64 and the set up by the new
> add_leaf_frame_caller_opts_aarch64, exposing opportunities for
> possibly sampling PC and SP to help the unwinder.
>
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/arch/arm64/util/Build                     |  1 -
>  tools/perf/arch/arm64/util/machine.c                 | 12 ------------
>  tools/perf/builtin-record.c                          | 11 +++++------
>  tools/perf/util/arm64-frame-pointer-unwind-support.c |  6 ++++++
>  tools/perf/util/arm64-frame-pointer-unwind-support.h |  2 ++
>  tools/perf/util/callchain.h                          |  2 --
>  6 files changed, 13 insertions(+), 21 deletions(-)
>  delete mode 100644 tools/perf/arch/arm64/util/machine.c
>
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/uti=
l/Build
> index 4e06a08d281a..638aa6948ab5 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -5,7 +5,6 @@ perf-util-y +=3D ../../arm/util/pmu.o
>  perf-util-y +=3D arm-spe.o
>  perf-util-y +=3D header.o
>  perf-util-y +=3D hisi-ptt.o
> -perf-util-y +=3D machine.o
>  perf-util-y +=3D mem-events.o
>  perf-util-y +=3D pmu.o
>  perf-util-y +=3D tsc.o
> diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64=
/util/machine.c
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
> -       opts->sample_user_regs |=3D SMPL_REG_MASK(PERF_REG_ARM64_LR);
> -}
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4a5eba498c02..272bba7f4b9e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -14,6 +14,7 @@
>  #include "util/parse-events.h"
>  #include "util/config.h"
>
> +#include "util/arm64-frame-pointer-unwind-support.h"
>  #include "util/callchain.h"
>  #include "util/cgroup.h"
>  #include "util/header.h"
> @@ -3230,10 +3231,6 @@ static int record__parse_off_cpu_thresh(const stru=
ct option *opt,
>         return 0;
>  }
>
> -void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __=
maybe_unused)
> -{
> -}
> -
>  static int parse_control_option(const struct option *opt,
>                                 const char *str,
>                                 int unset __maybe_unused)
> @@ -4319,8 +4316,10 @@ int cmd_record(int argc, const char **argv)
>
>         evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cp=
u_list);
>
> -       if (callchain_param.enabled && callchain_param.record_mode =3D=3D=
 CALLCHAIN_FP)
> -               arch__add_leaf_frame_record_opts(&rec->opts);
> +       if (callchain_param.enabled && callchain_param.record_mode =3D=3D=
 CALLCHAIN_FP) {
> +               if (EM_HOST =3D=3D EM_AARCH64)
> +                       add_leaf_frame_caller_opts_aarch64(&rec->opts);
> +       }
>
>         err =3D -ENOMEM;
>         if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0) {
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools=
/perf/util/arm64-frame-pointer-unwind-support.c
> index 858ce2b01812..3af8c7a466e0 100644
> --- a/tools/perf/util/arm64-frame-pointer-unwind-support.c
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> @@ -2,6 +2,7 @@
>  #include "arm64-frame-pointer-unwind-support.h"
>  #include "callchain.h"
>  #include "event.h"
> +#include "record.h"
>  #include "unwind.h"
>  #include <string.h>
>
> @@ -16,6 +17,11 @@ struct entries {
>
>  #define SMPL_REG_MASK(b) (1ULL << (b))
>
> +void add_leaf_frame_caller_opts_aarch64(struct record_opts *opts)
> +{
> +       opts->sample_user_regs |=3D SMPL_REG_MASK(PERF_REG_ARM64_LR);
> +}
> +
>  static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
>  {
>         struct regs_dump *regs;
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.h b/tools=
/perf/util/arm64-frame-pointer-unwind-support.h
> index 42d3a45490f5..ba35b295bfcd 100644
> --- a/tools/perf/util/arm64-frame-pointer-unwind-support.h
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.h
> @@ -5,8 +5,10 @@
>  #include <linux/types.h>
>
>  struct perf_sample;
> +struct record_opts;
>  struct thread;
>
> +void add_leaf_frame_caller_opts_aarch64(struct record_opts *opts);
>  u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thr=
ead *thread, int user_idx);
>
>  #endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 06d463ccc7a0..b7702d65ad60 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -277,8 +277,6 @@ static inline int arch_skip_callchain_idx(struct thre=
ad *thread __maybe_unused,
>  }
>  #endif
>
> -void arch__add_leaf_frame_record_opts(struct record_opts *opts);
> -
>  char *callchain_list__sym_name(struct callchain_list *cl,
>                                char *bf, size_t bfsize, bool show_dso);
>  char *callchain_node__scnprintf_value(struct callchain_node *node,
> --
> 2.54.0.563.g4f69b47b94-goog
>
