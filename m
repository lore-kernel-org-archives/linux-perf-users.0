Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34444217F2E
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Oct 2024 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729922464; cv=none; b=qBVZZ41GnUZyLfJzaQXoVj8X9bfKbmAnLsXVWz8dbGSMtedFusXjzVzqxBTaRm5U0kcQX3MCxnMAylTJ0aWaLV8srNhP3Qt/DJFNELdbDW0qXfm6ygZ9tceVXdHy0hG0RNDQot8SOjK7dt6LDP2gliSr6C/uydLiZQb93hLKZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729922464; c=relaxed/simple;
	bh=7JvFWgVmMfRj8QJwNhEkHE3aZfXZVob8aXaoiQRG/1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUEHzWrS7Q7r2mKRccPmwmLiBPo+KxtD2o4XwHFutcwoM+VrK7+WboJfKaJdGqeBpB+unv24uH2fUVUrIrCo2dMAivhI0P35jWokLs8kdYArKEp+GU7aLaI5CeC11ciOns1Je2BHyvT/XsWICMaoueigIv+fZ9uehKe60eQDPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REgNS7Mp; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REgNS7Mp"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso151595ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729922461; x=1730527261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+zM/o1HPfVNQxE5xJxVZGYmV9NlUYpQZjG/tkj+oJE=;
        b=REgNS7Mp8k9CaIw8c6r85QLrIyuZ8IyVG0L3NlYf1hK41Z79EYiG5S3xihEMVC8Pcj
         RbxYYuU1jiAMNcdAfWgmBqONCfNbzxEl/IeZPnZ1OyOW2zJovmQvdNTEjEGkMZvSl7kI
         Zz7M64LsNLx+1GIvMic5vK/5AMtMB5v9Ysoqgu07cnN/IYeBgu+tkyYyAitClLy/Fwa+
         gkEzKFMkPniOZaobD3VS4QOkWRmzmrGd9dbvy65NBlQ/F2CJBoMejZX0Ot7wtZffezl1
         WIugJF2GLEN1IVrH96PW+ghh7zxXyxOmMvEomUsab6EWQdTAjCYv6Q2II1WTFg9zax0/
         RpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729922461; x=1730527261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+zM/o1HPfVNQxE5xJxVZGYmV9NlUYpQZjG/tkj+oJE=;
        b=eJVkDXCruSg14I3tyBgG0Bx7eaE5PVVxko67+TEKGfHbV/yX6V4ojZ4LAtUGgJF9DF
         P0uWnp+y+DOYLGXIuNHwx0OaZBYlJMrm5QH/OI5SZ4rkOL6k9PU0SFdueLXR5+83DV6X
         /8M0G7tUrvGEr+s3r4tvK3ZPyTNvJ1vsE2/EDZJBoU1y9t4WqlZV5cAyT3Jqh2YhdQLL
         swQViCrlFgzvrNr4G1a7BemWfabV+M8EyYtev30KyNx3FoepTuPQsly4qPe8rWiQcL68
         HJbthxxuq1ETJ7SqVr4LbJgvBFi+UaBNlCkCYZWUXarSDnGjbFfKLRNosTg/2kAPVwYV
         ahCw==
X-Forwarded-Encrypted: i=1; AJvYcCUYcWCag8PcaMO+XHowMuXhctvjKpe8k2oDglDNkO+kaS8VzfrLK+HyxcQ88gd/rfrP/KVuFJ6bqncHBAhU7x6G@vger.kernel.org
X-Gm-Message-State: AOJu0YyLryoLVAlGIAmWChBf7u/s/UAzS6gMZVc8Y4CGAjUp4BfTlJCW
	t9P7HpzXSItTT8tT3r7omOfzoWTbeSBCu40LaqZecWk9ZrORff7j0LFsZvu9tIBqJpbEljK3KYk
	QD9lF1V/PuAWmDOdBb+PJg6piEEXAHc5/+9rk
X-Google-Smtp-Source: AGHT+IF8XBaFLLBsLaAIhRDGMNkDGbjpTa9ux2fdc1a/xhLMT5aG7FYFFsHx2L0Ja+nE8hh+E7j8zwedqyui8XmvBfk=
X-Received: by 2002:a05:6e02:1c26:b0:3a2:6d54:33f1 with SMTP id
 e9e14a558f8ab-3a4ed2cf72dmr2086155ab.16.1729922461172; Fri, 25 Oct 2024
 23:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026055448.312247-1-irogers@google.com>
In-Reply-To: <20241026055448.312247-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Oct 2024 23:00:50 -0700
Message-ID: <CAP-5=fXLL1dB4MEfe7Z+fhp_RzC9DV91gBLBHjjywW-_RXmM-Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf cap: Add __NR_capget to arch/x86 unistd
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:54=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> As there are duplicated kernel headers in tools/include libc can pick
> up the wrong definitions. This was causing the wrong system call for
> capget in perf.
>
> Closes: https://lore.kernel.org/lkml/cc7d6bdf-1aeb-4179-9029-4baf50b59342=
@intel.com/
> Signed-off-by: Ian Rogers <irogers@google.com>

Forgot:
Fixes: e25ebda78e23 ("perf cap: Tidy up and improve capability testing")

Thanks,
Ian

> ---
>  tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
>  tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
>  tools/perf/util/cap.c                       | 10 +++-------
>  3 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86=
/include/uapi/asm/unistd_32.h
> index 9de35df1afc3..63182a023e9d 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> @@ -11,6 +11,9 @@
>  #ifndef __NR_getpgid
>  #define __NR_getpgid 132
>  #endif
> +#ifndef __NR_capget
> +#define __NR_capget 184
> +#endif
>  #ifndef __NR_gettid
>  #define __NR_gettid 224
>  #endif
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86=
/include/uapi/asm/unistd_64.h
> index d0f2043d7132..77311e8d1b5d 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
> @@ -11,6 +11,9 @@
>  #ifndef __NR_getpgid
>  #define __NR_getpgid 121
>  #endif
> +#ifndef __NR_capget
> +#define __NR_capget 125
> +#endif
>  #ifndef __NR_gettid
>  #define __NR_gettid 186
>  #endif
> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> index 7574a67651bc..69d9a2bcd40b 100644
> --- a/tools/perf/util/cap.c
> +++ b/tools/perf/util/cap.c
> @@ -7,13 +7,9 @@
>  #include "debug.h"
>  #include <errno.h>
>  #include <string.h>
> -#include <unistd.h>
>  #include <linux/capability.h>
>  #include <sys/syscall.h>
> -
> -#ifndef SYS_capget
> -#define SYS_capget 90
> -#endif
> +#include <unistd.h>
>
>  #define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
>
> @@ -21,9 +17,9 @@ bool perf_cap__capable(int cap, bool *used_root)
>  {
>         struct __user_cap_header_struct header =3D {
>                 .version =3D _LINUX_CAPABILITY_VERSION_3,
> -               .pid =3D getpid(),
> +               .pid =3D 0,
>         };
> -       struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
> +       struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S] =3D=
 {};
>         __u32 cap_val;
>
>         *used_root =3D false;
> --
> 2.47.0.163.g1226f6d8fa-goog
>
