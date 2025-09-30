Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081824EF76
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256084; cv=none; b=YRKf3B+KbimbR4Gan6QD3UlzlNt5s6OehFMAA2/XkEaGn02tUhyfs1Hz9WELtcPgBtPlsUBBrgLczA4BTWxmzRlK4J/bsCG7SVzokwPpU+1s/GOoousMpSeMNbpLE7n4HpPxfRnfO2tiNkDHZmWpDMiuV6f0A/7RzJp65rrc0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256084; c=relaxed/simple;
	bh=YzBT4QfCAMuUeKIwP1bi+4/6lvol7Da7Md1BMJ+VHY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4RCoNnc3cRKAN9lS687uECt/PcypWON0QNEu1GiWbQOFjOhrcaPa6NU6/JmLiCRlT4XMkmgKkDkqSUI2i729KSp05eg9Ed/o+dxdoSprL+pwnsskcppiYN/a53ha08HtKRhvF+AESUSY5cjFn9CponCAtTdsr1vw9gSS0SRgNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYim7wje; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYim7wje"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d67abd215so28635ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759256082; x=1759860882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JhHQw6uDnIpZGqNLt8rg/euuDEf1NIeByJWbMKA7f0=;
        b=vYim7wjeR1q4gXxXGaoqRTR4xDS6GU4Iqd5skZh8FWkIcE8YiHaZeLoxx9tOJJSUss
         LxInW01nUWJtQ7m0Fa3kiwkFuopCzfsKyfcSw0chc4arxbucfHRiGFJ3BIDPvQXreye6
         b3aOPM7Ca7MJycvYBfQlqPfUmm4dEl7utHfjk52SEtorHxBdfQbfwwBmvEYyk3zqIqe6
         lmb7lrrqMcK82RubbngXV82jKRSKZMB2uRMXv/IzPlG/iPW7Sh405qhoxNx/wsan9v4E
         qKcOvi3o9fzACfZadI6UrFwlUVxKBIlvt3BTFf8xR1oZM9X7DVPhloN/OhpsdWO90ho0
         JcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759256082; x=1759860882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JhHQw6uDnIpZGqNLt8rg/euuDEf1NIeByJWbMKA7f0=;
        b=OhsB9Xuw0EMcZJMBLpUxLz1PYyNGMzLc8qhP0ppHMJY0MLQBxcX9ceTb14fJjcOrkx
         K8ozw3vC6nRDlj1PqT0ED/jGnDr9470HnfeIDyCMPS6s+Px39/eYUwuq0LolF5HRabgK
         2uTf76nbG9P/PiIl5uQxqAv3eJPl+ePyoWC3MzZxN3ZxyMsShLgTPTIdxKxyxoLqffpN
         5HyoIfvMEpJHO+PPdS5tZ9yApJpgjF2Lro5wUpcU1XmS0741e8A9vHWjVONqfLcXavRq
         McQ2AYRqTI9QwYiTHumGSZ55yqQrpR2CFttlOH84djwBtTTuef2BdIQeq0YiZ4f005In
         3wug==
X-Forwarded-Encrypted: i=1; AJvYcCVn5/+CqNbk+FfYlQKv1bITmgijhgTpz1Vgtv4xh7IUo/wBL3dyDWLJlzPQJUew1qBgeobTjrDLwRVn6uDkfyS0@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7rzE/OPRO75nwOlujjike/leZyC6qqTTZXqXLL2ntLyFQsKj
	ODmWgH2RN6+6F8Qioy1Wi+oFB4D7muZe4Be2phoj9PEGgX8VHyFYAbzGn5KEaWvh5oi/aoCSIy2
	zQvzdAluIgW+22g99k+G/qoQBJgDB+Dang6SzZEgz
X-Gm-Gg: ASbGncvP92NaLZ1NzNDAU/QartftAl5IODZpN5PL86fOW0IIlgHHwnQ9ngAzusp3s7u
	YvqW6gCvwulkLcS4Qx1giep9qMrVj2G4Bv1k4T9L5ERfp+Yavt4VsOGQrbiuxHR4Inq01FL6bCF
	uivo5qoEUw2vjwcXL4sTUUb5ZOKxA9GtwAvwlQeL8nmH7NLak+ffVGg8Tvg+FW6N02leL509WHL
	y+k+u9QhVgpMurSiAiABClA7ydoYJoGt9RV+RmfEm7tf9+X57SGNskf6pkuzdTLLrtAQVdOrSpJ
	7dQ=
X-Google-Smtp-Source: AGHT+IEhDpKOzk1V76VOHcN+llC8N2LBlKYGHUrdZNNKDJH5D89iF4L3nfYy1fwm1qWHrVShZ3D5tqaGnLS187GjSew=
X-Received: by 2002:a17:902:ce07:b0:266:b8a2:f5d8 with SMTP id
 d9443c01a7336-28e80054fc2mr385095ad.14.1759256081883; Tue, 30 Sep 2025
 11:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
In-Reply-To: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 11:14:30 -0700
X-Gm-Features: AS18NWBjMfrHGB5lKU8Vu2vvk7TM7-6lS4GVzlRhAcGcul5zXgxYKOUicYvXdBY
Message-ID: <CAP-5=fUdk-EEDz2p__UJAcmkO=bA143dOUpGRcnW7_5FhZT71Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] perf build: Support building with Clang
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:55=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> This series adds support for building perf with Clang, following the
> discussion in [1]. Because the Android NDK uses Clang by default,
> enabling Clang builds naturally covers Android as well.
>
> The series is organized as follows:
>
>   - Patches 1=E2=80=932: Fix two bugs found with Clang.
>   - Patches 3=E2=80=936: Correct CROSS_ARCH and dismiss Clang build warni=
ngs.
>   - Patches 7=E2=80=938: Enable Clang in the Makefile and update the
>     documentation.
>
> Testing:
>
>   - Clang 15.0.7 on Ubuntu 22.04.5: native and cross-compiling (aarch64)
>   - Clang 18.1.3 on Ubuntu 24.04.2: native and cross-compiling (aarch64)
>   - Android NDK r27d (latest LTS): cross-compiling (aarch64)
>
> [1] https://lore.kernel.org/linux-perf-users/20240715143342.52236-1-leo.y=
an@arm.com/
>
> ---
> Changes in v2:
> - Dropped the patch for dismissing warning in bpftool.
> - Refined the document. (Ian)
> - Link to v1: https://lore.kernel.org/r/20250925-perf_build_android_ndk-v=
1-0-8b35aadde3dc@arm.com

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Leo Yan (8):
>       tools build: Align warning options with perf
>       perf python: split Clang options when invoking Popen
>       perf: build: Correct CROSS_ARCH for clang
>       perf test coresight: Dismiss clang warning for memcpy thread
>       perf test coresight: Dismiss clang warning for thread loop
>       perf test coresight: Dismiss clang warning for unroll loop thread
>       perf build: Support build with clang
>       perf docs: Document building with Clang
>
>  tools/build/feature/Makefile                       |  6 +-
>  tools/perf/Documentation/Build.txt                 | 15 ++++
>  tools/perf/Documentation/android.txt               | 80 ++--------------=
------
>  tools/perf/Makefile.config                         | 32 ++++++++-
>  tools/perf/Makefile.perf                           |  2 +-
>  .../shell/coresight/memcpy_thread/memcpy_thread.c  |  2 +
>  .../shell/coresight/thread_loop/thread_loop.c      |  4 +-
>  .../unroll_loop_thread/unroll_loop_thread.c        |  4 +-
>  tools/perf/util/setup.py                           |  5 +-
>  9 files changed, 67 insertions(+), 83 deletions(-)
> ---
> base-commit: c17dda8013495d8132c976cbf349be9949d0fbd1
> change-id: 20250915-perf_build_android_ndk-500b53bea895
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
