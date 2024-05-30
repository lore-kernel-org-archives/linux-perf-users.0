Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCF3B1A1;
	Thu, 30 May 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088302; cv=none; b=KMiRTqZaRR23yLcg2bHlj6vltr9lDcUH8N+UUfgg08Q0/ZFurbrst3aS2NqsZl5KGwA2AMmu7/bCpUQM0dQVSvm3QW3DJ9PYy9qASPhNRDH8dg/OaKJsb2BaZKomnV23OJ3sUqzbvf0KjbHbICpJD3bZI+3/3Yl0Pss6O7Dtu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088302; c=relaxed/simple;
	bh=nGniF+ZxbkeA08p1wBi3GKXVXWHnzS5tHPO2sdTapbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLAuid2RoRUFtf5NUMHG1L+A/Z9+Yp1dMcjq0WU/qDsYMffRpgCMKdDkwcdtGfVnIJDR2WgM6IRtK4m4TIUyleyCiTdgSKyxJWNCbnPQ7z/AJNWsPPzEp8pNaCrah3tBp9dwbvsyBiZazzBbQ58T2s98tgOnCKrEQqGmbQWlh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c1b542ae9eso149477a91.1;
        Thu, 30 May 2024 09:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088300; x=1717693100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzdgKKffBNXcGsHhjOs/htIADO3pk29gIqnhuYRO1xs=;
        b=wxiHlNy5xruarDAjCq20aOB+YurgQPyisi91pPF5F8mNdXUOPAFqyQNH5iQqNSsQhV
         /JL/pPjmCTWkxWNzjojRx54h9V4JZz2KXdOxpYKpAeIMQuFrKpafsWlprSYsI2tsjYwK
         JMC6Pu51Udu5SRYtcEqZcDrEIGi4p/ynC7U5NuC+5Iq0nK9o9PoDZu2YsBKtNLOeCpSF
         5o54mXZP8dt39D1dlNe5lXlBQeREGZGUWEFtF5I9J/UAcfemPBG99P2ZUZ3O0Bbs7SK9
         Sa3S3S2cryWf7rDOhDVvU+sAa4VGa3RfxhX88AqgqHTrYE8xVWxR57gwop8Aa1aZWPtp
         nm6g==
X-Forwarded-Encrypted: i=1; AJvYcCWofBUyYBrz2aZwydF7ag6wFyhQqoNKF24nf/ri0XX7YX05puywF/O+gltLVZqm4I5EO6Qw+vLqz1Mrc6wxv780B87341HrBETmv9s7M+fgNo0QcN+NQE+s6Znpfx5hd1lohN5GpjQIlfuotv5TBQ==
X-Gm-Message-State: AOJu0YxRGzb1MlYJsNtOqk4kj58qUsEcjw48CnTUKDmAL3Eu1NoStytr
	sMWYl8O0Y4HlKcX6Bqchik+dJaFvzyTjVDWYx70Ma4n07ivQjN/cDHbs4BAHax8JMpeRNePrmuE
	8ft1PGWtjz/tGu4iz11BeaCOkkAA=
X-Google-Smtp-Source: AGHT+IFLxUN6AkOo66qINgFittTKX7kE6K3ovcfTueTJljdRLHbXHPNvnlruIkuSPzVkbkyT+Vg0T4Cvldg9ydck7oQ=
X-Received: by 2002:a17:90a:c798:b0:2ae:7f27:82cd with SMTP id
 98e67ed59e1d1-2c1ab9e39a3mr2595189a91.7.1717088300306; Thu, 30 May 2024
 09:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526182212.544525-1-sesse@google.com>
In-Reply-To: <20240526182212.544525-1-sesse@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 30 May 2024 09:58:09 -0700
Message-ID: <CAM9d7cgf1ZqGGCHU=g8ksfigWhL-XPL4qJiHzz+EQ6vo5c8DyQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] perf report: Support LLVM for addr2line()
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, irogers@google.com, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 11:22=E2=80=AFAM Steinar H. Gunderson <sesse@google=
.com> wrote:
>
> In addition to the existing support for libbfd and calling out to
> an external addr2line command, add support for using libllvm directly.
> This is both faster than libbfd, and can be enabled in distro builds
> (the LLVM license has an explicit provision for GPLv2 compatibility).
> Thus, it is set as the primary choice if available.
>
> As an example, running perf report on a medium-size profile with
> DWARF-based backtraces took 58 seconds with LLVM, 78 seconds with
> libbfd, 153 seconds with external llvm-addr2line, and I got tired
> and aborted the test after waiting for 55 minutes with external
> bfd addr2line (which is the default for perf as compiled by distributions
> today). Evidently, for this case, the bfd addr2line process needs
> 18 seconds (on a 5.2 GHz Zen 3) to load the .debug ELF in question,
> hits the 1-second timeout and gets killed during initialization,
> getting restarted anew every time. Having an in-process addr2line
> makes this much more robust.
>
> As future extensions, libllvm can be used in many other places where
> we currently use libbfd or other libraries:
>
>  - Symbol enumeration (in particular, for PE binaries).
>  - Demangling (including non-Itanium demangling, e.g. Microsoft
>    or Rust).
>  - Disassembling (perf annotate).
>
> However, these are much less pressing; most people don't profile
> PE binaries, and perf has non-bfd paths for ELF. The same with
> demangling; the default _cxa_demangle path works fine for most
> users. Disassembling is coming in a later patch in the series;
> however do note that while bfd objdump can be slow on large binaries,
> it is possible to use --objdump=3Dllvm-objdump to get the speed benefits.
> (It appears LLVM-based demangling is very simple, should we want
> that.)
>
> Tested with LLVM 14, 15, 16, 18 and 19. For some reason, LLVM 12 was not
> correctly detected using feature_check, and thus was not tested.
>
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/Makefile.feature       |   1 +
>  tools/perf/Makefile.config         |  15 ++++
>  tools/perf/builtin-version.c       |   1 +
>  tools/perf/util/Build              |   1 +
>  tools/perf/util/llvm-c-helpers.cpp | 134 +++++++++++++++++++++++++++++
>  tools/perf/util/llvm-c-helpers.h   |  49 +++++++++++
>  tools/perf/util/srcline.c          |  57 +++++++++++-
>  7 files changed, 257 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/util/llvm-c-helpers.cpp
>  create mode 100644 tools/perf/util/llvm-c-helpers.h

Can you please add something to tests/mask so that
we can test the build with and without libllvm easily?

Thanks,
Namhyung
