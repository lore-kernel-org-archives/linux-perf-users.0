Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4232428A3EF
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773496; cv=none; b=RJ1WvtYlWOSFr0v97BJypAyS5IW3ZXgxn8z0WkiPEf3DX49awA4yRhojzgpzkTZIYuoSpAekxy8ufcnWvHSRb6OxsRpY/Xtio0lef+zLiIEFJm5t1TPeFv1LXjg1WbwreWFKVm6FtWxGpjlo7BT3OJt3yGiaFa6k697MsamXn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773496; c=relaxed/simple;
	bh=tbNDizQJ2zyUA7wsvDpvh0QyrNwTk3QKIZUW3QSZmP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mu0gJcqjWUSk1YHH+Kj89YVpOKc9Ga0UYAjFZ4aiR82C1IEj+iWXYDisTcgeuz10i+1tw49bXOqHwf2I70DMXpREWV6uluwNIsJMkcXp6oPKETyq0TWlNv7OElH7Jhv6TZtndqUa0rrLCtBgutH8pKwNJxPjiLu4D/ll8r+SYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TiXBy2WO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TiXBy2WO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2681645b7b6so17285ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759773492; x=1760378292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3x04bgHMffZUkhfD5CkZWiF7pEEXN8/PUcw8ocaPMU=;
        b=TiXBy2WOOzSfcrk1fHzvBeowvmfa94Hd262gIRUkZFcADz/G4I6spp5Le8SC0Fo3dX
         QmBedO3rPSn+xrUVK+Bk2dIiSXoUr7yaa2nbMPvefEcR1Q7YhPNCBlwmim3xENll0dKE
         tQTmhHaoiOOCq4vY+u3BEJ0vzqoCdSAEmibbzpcAUGJwelW4GJ2pU4LgbSO7KML417nj
         G+04eB2eYAYM7pX2yfPAROEgaeggF/UzlnCVPZH0tBS8uGPdL4278I2MvWX2jY4VLZmV
         Rln6+rezJENEj0uSdZzdimE0QYj5hjKRo2SVOxHkJaJdKKjmUBzy0J76rW5GLaindl/5
         OKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773492; x=1760378292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3x04bgHMffZUkhfD5CkZWiF7pEEXN8/PUcw8ocaPMU=;
        b=WFvvy6i2Kk86eoMneFqwVwbfOO/en70A+Hd5SZ6Yo5Ye0nk1KiQt+EnvPEFoG3EuL5
         AIfqbxSiI+bfe/079z4ue/BMXVASvuKGHWgbFvKeO5RN5dCzBE3NNQIQIOVkbHWW2elA
         0U8ppCpLf91aYs7B9wXdwlqX/BklCjwf4m0/Z7peJYY+WemVJq1taMew4YGh0O4SQPS1
         VKcjmoXF5WAhcxrjdYvGRM2aPX5LJsANMQobknAEYlrWvBP/1MUUSd2m+5rxOBcj/rax
         sv7tMxLaqYFp2RyMC7Gy0yFeQ3H351VW6IkU3D11EeltQcxoUB7A+9JQIC/5lt8BhI34
         rrxg==
X-Forwarded-Encrypted: i=1; AJvYcCVqfcs4RbtRA73j9ejseTLqX0GCyTFHFyG6K7J3jic4/8evBruCvBJo0R/Niiy0ntCUyW+BFWUcwn17b9NYMDvG@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoVjjI2KbH9+N5Ok3+IiXyohck+eTxrNlApiC/tP3k2bKXB2i
	pLGxt4pcUAbZKP1vLDdAN+XcZ+m1i6c/ic/ZcNJJalhxBW8ocxwKzJctdsmxC2l6zOgVhrqAzOb
	5AuFb/0zJxvB4bsQ/YO+KSvl8hVesHaGXf4XhFDzv
X-Gm-Gg: ASbGnctWGKqteMPCuqqxh1IruCWiQDqwC09UR/96+7plppPbyWBBVqKeAiLubx4zA2v
	Mk0xtznZ1ggWH4heRX/2mxi2+4S6TQDK0NCbHiTMyZTbuqnakyydFJtFuAB1IKGPvcv4oNJm+X2
	CtsqlIrqJeUCoZWtcnK7InfVSxPxmeU2mp2CT9tM5z3+VT7koiPLkgAzREQS3xrUBtlMkF9eJP0
	Z+nkVr3L4CCA8cXYp4IBdyyVDoosKUlBwVVULvZvIORi8DYEIXp1jcR6BiqQlv6XYOQ
X-Google-Smtp-Source: AGHT+IGYbPJl2j5l0oAPa/RC3IlbC1VYYkiNWl9DSNPXXtvE5lHDEm0dfVWKAW4BAHdKzLB9eH4R7T7iaJJRtOAAJ/w=
X-Received: by 2002:a17:903:3d07:b0:268:cc5:5e3c with SMTP id
 d9443c01a7336-28eca40ef40mr362585ad.10.1759773491707; Mon, 06 Oct 2025
 10:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
In-Reply-To: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 10:57:59 -0700
X-Gm-Features: AS18NWB_eZWaxb9LRqFQD6gCk5f127ECpR9TL09do_aPGYIscYin6JqKzL8Qe-E
Message-ID: <CAP-5=fWiivp_zFdos_4VC7RUuzd5NqYrtLH2DR2LKj9Qp9h5BQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] perf build: Support building with Clang
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

On Mon, Oct 6, 2025 at 9:21=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> This series adds support for building perf with Clang, following the
> discussion in [1]. Because the Android NDK uses Clang by default,
> enabling Clang builds naturally covers Android as well.
>
> The series is organized as follows:
>
>   - Patches 1~2: Fix two bugs found with Clang.
>   - Patches 3~7: Correct CROSS_ARCH, Disable thread safety analysis for
>                  perl header, and dismiss Clang build warnings.
>   - Patches 8~9: Enable Clang in the Makefile and update the
>                  documentation.
>
> Testing:
>
> Tested with linux-tools-container-builds [2], which based on Arnaldo's
> build test container but with several fixes for cross building with
> Clang:
>
>   - All clang native builds on x86_64 have passed.
>   - The cross builds for arm64/mips/mips64/mipsel/riscv64 have passed.
>
> Only a pity thing is I cannot build successfully with clang for
> ubuntu:20.04-x-powerpc64el (in below log, it only builds with GCC).
> The cross config does not work well on Ubuntu 20.04 due to failure
> "No gnu/libc-version.h found, please install glibc-dev[el]". I confirmed
> that powerpc64el cross build can make success on Ubuntu 24.04, the
> failure on Ubuntu 20.04 should not be caused by perf build.
>
>   Subject: tools build test for http://localhost/perf/perf-6.17.0-rc6.tar=
.xz
>
>      1   201.44 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_g=
it20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
>      2   154.82 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_g=
it20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
>      3   136.07 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_g=
it20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
>      4   150.21 alpine:3.19                   : Ok   gcc (Alpine 13.2.1_g=
it20231014) 13.2.1 20231014 , Alpine clang version 17.0.5 flex 2.6.4
>      5   143.50 alpine:3.20                   : Ok   gcc (Alpine 13.2.1_g=
it20240309) 13.2.1 20240309 , Alpine clang version 17.0.6 flex 2.6.4
>      6   146.08 amazonlinux:2023              : Ok   gcc (GCC) 11.5.0 202=
40719 (Red Hat 11.5.0-5) , clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4)=
 flex 2.6.4
>      7   147.19 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 202=
21121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn=
2023.0.2) flex 2.6.4
>      8   117.92 debian:11                     : Ok   gcc (Debian 10.2.1-6=
) 10.2.1 20210110 , Debian clang version 13.0.1-6~deb11u1 flex 2.6.4
>      9   121.54 debian:12                     : Ok   gcc (Debian 12.2.0-1=
4+deb12u1) 12.2.0 , Debian clang version 14.0.6 flex 2.6.4
>     10   128.64 debian:experimental           : Ok   gcc (Debian 15.2.0-4=
) 15.2.0 , Debian clang version 19.1.7 (7) flex 2.6.4
>     11    96.47 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gc=
c (Debian 15.2.0-4) 15.2.0 , Debian clang version 19.1.7 (7) flex 2.6.4
>     12    72.89 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (=
Debian 14.2.0-13) 14.2.0 , Debian clang version 19.1.7 (7) flex 2.6.4
>     13    73.31 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi6=
4-gcc (Debian 14.2.0-13) 14.2.0 , Debian clang version 19.1.7 (7) flex 2.6.=
4
>     14    71.69 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc=
 (Debian 14.2.0-13) 14.2.0 , Debian clang version 19.1.7 (7) flex 2.6.4
>     15   151.92 fedora:35                     : Ok   gcc (GCC) 11.3.1 202=
20421 (Red Hat 11.3.1-3) , clang version 13.0.1 (Fedora 13.0.1-1.fc35) flex=
 2.6.4
>     16   146.99 fedora:36                     : Ok   gcc (GCC) 12.2.1 202=
21121 (Red Hat 12.2.1-4) , clang version 14.0.5 (Fedora 14.0.5-2.fc36) flex=
 2.6.4
>     17   139.58 fedora:37                     : Ok   gcc (GCC) 12.3.1 202=
30508 (Red Hat 12.3.1-1) , clang version 15.0.7 (Fedora 15.0.7-2.fc37) flex=
 2.6.4
>     18   142.00 fedora:38                     : Ok   gcc (GCC) 13.2.1 202=
40316 (Red Hat 13.2.1-7) , clang version 16.0.6 (Fedora 16.0.6-4.fc38) flex=
 2.6.4
>     19   140.18 fedora:39                     : Ok   gcc (GCC) 13.3.1 202=
40913 (Red Hat 13.3.1-3) , clang version 17.0.6 (Fedora 17.0.6-2.fc39) flex=
 2.6.4
>     20   139.38 fedora:40                     : Ok   gcc (GCC) 14.2.1 202=
40912 (Red Hat 14.2.1-3) , clang version 18.1.8 (Fedora 18.1.8-2.fc40) flex=
 2.6.4
>     21   136.26 fedora:41                     : Ok   gcc (GCC) 14.3.1 202=
50808 (Red Hat 14.3.1-3) , clang version 19.1.7 (Fedora 19.1.7-5.fc41) flex=
 2.6.4
>     22   135.38 fedora:42                     : Ok   gcc (GCC) 15.2.1 202=
50808 (Red Hat 15.2.1-1) , clang version 20.1.8 (Fedora 20.1.8-4.fc42) flex=
 2.6.4
>     23   127.55 fedora:rawhide                : Ok   gcc (GCC) 15.2.1 202=
50924 (Red Hat 15.2.1-2) , clang version 21.1.2 (Fedora 21.1.2-1.fc44) flex=
 2.6.4
>     24   180.17 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5=
.0 , clang version 15.0.7 flex 2.6.4
>     25   169.40 opensuse:15.5                 : Ok   gcc (SUSE Linux) 7.5=
.0 , clang version 15.0.7 flex 2.6.4
>     26   167.36 opensuse:15.6                 : Ok   gcc (SUSE Linux) 7.5=
.0 , clang version 17.0.6 flex 2.6.4
>     27   154.82 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 15.=
2.0 , clang version 21.1.2 flex 2.6.4
>     28   145.89 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 2021=
0514 (Red Hat 8.5.0-28.0.1) , clang version 19.1.7 ( 19.1.7-2.module+el8.10=
.0+90583+7e562d96) flex 2.6.1
>     29   139.68 oraclelinux:9                 : Ok   gcc (GCC) 11.5.0 202=
40719 (Red Hat 11.5.0-5.0.1) , clang version 19.1.7 ( 19.1.7-2.el9) flex 2.=
6.4
>     30    40.17 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.4.0-1u=
buntu1~20.04.2) 9.4.0  flex 2.6.4
>     31    20.83 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gn=
u-gcc (Ubuntu 10.5.0-1ubuntu1~20.04) 10.5.0  flex 2.6.4
>     32   127.75 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.4.0-1=
ubuntu1~22.04.2) 11.4.0 , Ubuntu clang version 14.0.0-1ubuntu1.1 flex 2.6.4
>     33    92.25 ubuntu:22.04-x-riscv64        : Ok   riscv64-linux-gnu-gc=
c (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0 , Ubuntu clang version 14.0.0-1ubun=
tu1.1 flex 2.6.4
>     34   126.64 ubuntu:24.04                  : Ok   gcc (Ubuntu 13.3.0-6=
ubuntu2~24.04) 13.3.0 , Ubuntu clang version 18.1.3 (1ubuntu1) flex 2.6.4
>     35   130.95 ubuntu:25.04                  : Ok   gcc (Ubuntu 14.2.0-1=
9ubuntu2) 14.2.0 , Ubuntu clang version 20.1.2 (0ubuntu1) flex 2.6.4
>
> [1] https://lore.kernel.org/linux-perf-users/20240715143342.52236-1-leo.y=
an@arm.com/
> [2] https://github.com/Leo-Yan/linux-tools-container-builds/tree/fix-risc=
v64-cross-build
>
> ---
> Changes in v3:
> - Fixed build failure with musl lib.
> - Disabled thread safety analysis for perl head.
> - Link to v2: https://lore.kernel.org/r/20250930-perf_build_android_ndk-v=
2-0-2ea440b7ef01@arm.com
>
> Changes in v2:
> - Dropped the patch for dismissing warning in bpftool.
> - Refined the document. (Ian)
> - Link to v1: https://lore.kernel.org/r/20250925-perf_build_android_ndk-v=
1-0-8b35aadde3dc@arm.com

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Leo Yan (9):
>       tools build: Align warning options with perf
>       perf python: split Clang options when invoking Popen
>       perf build: Correct CROSS_ARCH for clang
>       perf build: Disable thread safety analysis for perl header
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
>  tools/perf/Makefile.config                         | 33 ++++++++-
>  tools/perf/Makefile.perf                           |  2 +-
>  tools/perf/scripts/perl/Perf-Trace-Util/Build      |  2 +-
>  .../shell/coresight/memcpy_thread/memcpy_thread.c  |  2 +
>  .../shell/coresight/thread_loop/thread_loop.c      |  4 +-
>  .../unroll_loop_thread/unroll_loop_thread.c        |  4 +-
>  tools/perf/util/scripting-engines/Build            |  2 +-
>  tools/perf/util/setup.py                           |  5 +-
>  11 files changed, 70 insertions(+), 85 deletions(-)
> ---
> base-commit: c17dda8013495d8132c976cbf349be9949d0fbd1
> change-id: 20250915-perf_build_android_ndk-500b53bea895
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
