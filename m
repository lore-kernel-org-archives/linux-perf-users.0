Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342129BDBB
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519945; cv=none; b=U6t6MRvJR+rEes3B7hwl0gVNcbR7meC5j4ICx8sYXF1TLHt/ScLnZWo8Igm3BgMUEjBvR6oRv4NSN3eZJmn+ssVheANCkn16cDRYdVDnkqEbkMf3PErb2vartu6k9iNxUuxLg/a6EHUnrkOEh0l0P6FOOItppsFm0WX9L/R6yzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519945; c=relaxed/simple;
	bh=d69YZdJ/BUQQBkDebcfmqrU+4NIapAmIjsIzp09J79I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJx8RqeeFwOjLsm1AS8vlIJcltw3nG0tzRLaHV+B6UvNKFuP6xVzUyq3wRoHrEzO8L4gP3XQljF18SRUIMbcETyk9rpKZI6UkwOlfFCqmTCyhXk9Pm8VR1Kcb5JLie4OrLy5GHnwZ3p5dhZt4BOb33MEYcPz6vLw0HheXshkOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E79mNqhM; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E79mNqhM"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-596ba05aaecso977319e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Dec 2025 22:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765519942; x=1766124742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPG+oJyJ51CqyOKi/jP0aYHEK/VBoQyuZ8gOFkO/zdU=;
        b=E79mNqhMf5Jn22fC+h6MMeulQZQ+OHZ9OZZYsMKAdSVAqyf13e/c10FbY41whOta2y
         x6y4Jj8F/bLNXr8mmraN/QrgirEuIG4UEJD+tVUjkM8Ry0HrrVTOTV2kBPUKGleLYw18
         KIgjm5UeHZH2K7MV3YZ/58jNX57w3pZldJ3RxOkP2XaPqHvTkPK03BrgBhYfmYZFECjZ
         G3W5A1Zf6cfI+L7/vaO3QOkIHK8Q2fdr89yG/8pFVAmQCCehtnAYKXTRhtAM6y6uTFlU
         sYhSUf0+Tp279WtGDIIaVGctdjNYlv97Sf9x7Tn6uvZxa8hqu9W/zzno2hmw3Sgti2Sy
         XlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765519942; x=1766124742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPG+oJyJ51CqyOKi/jP0aYHEK/VBoQyuZ8gOFkO/zdU=;
        b=pT2kvIiauOGzqG75cugXbmkd+6ih0iIWIeMGT5l3/MWbOK29ZkOSzWbdGcCeSdbpLA
         sljuUG9kNw5fg8dZpMG6EigDTJC1QxVuqLM4PndARCbB8TCC+9DHpBVNlO8foObu8x0j
         zed5DZsWHFBcpr7c+7WE0eFgrPczA6LIFNIKzdz1LXZJSIjP3s6PTf9V6g5IpweBPuyv
         W9Do4IjWZiIQuuYVPjrfICkJ/Fd4JqiQrNcZFT3J0fRe4rzYhW5UaYDCwUzr9UUfnPkr
         oipVlX6kGIHehRS4I8QmJwxw6qa11YWAyshKjIoMHsKJm4gVLFtqC4VO7L673X9fMh/y
         oxnA==
X-Forwarded-Encrypted: i=1; AJvYcCXbdUtyNbkomtZYLO84SzefLXtsuvO/09VlJZRvsjxoHotbdWL7u2zWmFHhJXaBDFiWpx+YU48nSzcpAHu+qiPj@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIrDPzuyFeCWSITARrqXn2qPaotIHRzlX7pP1GCowd5b0t9Ez
	FXWJJPNlkgPRN343tJIx55ovicPtkRaOmGNHdpc0BP9pYz86VdTPlOuim+/Fccaw5w7o3BnvJrq
	Lrp0SBX/o8C9idek/Fy2QweHV1d+SOnQ=
X-Gm-Gg: AY/fxX54HFYkNWTqwm1X4KPyVRzXwyEGl2Bd7j6PUxPbcwTasj1Y7yIjx1YRGP4bT3w
	rmBauxAieZomqDtuLivIcHVjhlC65cnGaF5V1UwuzA1KMR5jyigDt6V1NM2O8cf56JkiAfmypJD
	Wm3NMs7tj6KWrZEhjvJRaM9jAVYj2dkz5Gx2WUxfzAGg5qBdeQp+Ie4qfRNzbz0+1ZGmw3Hydsl
	tIUpNJRPwh7EPt8DvaYPlnLf+AGBmxQKyDK3YmkLZOhTJfzavCdCaGunLYii0aof+FJVb1H9XyR
	ZX9pZok=
X-Google-Smtp-Source: AGHT+IG3uOibHSDfqg35guOnmiU1LmomHVbNwN35P++dtAoYrMlYXpPFqWK+7uQAx4ZW47SCNcYXe6aE6pmZxVcHAWo=
X-Received: by 2002:a05:6512:b91:b0:594:7703:dc5a with SMTP id
 2adb3069b0e04-598faa78f31mr267639e87.40.1765519941557; Thu, 11 Dec 2025
 22:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com> <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
 <20251125161026.GF724103@e132581.arm.com> <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
 <20251211103957.GA4048253@e132581.arm.com>
In-Reply-To: <20251211103957.GA4048253@e132581.arm.com>
From: hupu <hupu.gm@gmail.com>
Date: Fri, 12 Dec 2025 14:12:09 +0800
X-Gm-Features: AQt7F2odryKHIBnWJy6rOr93x449htqbjr-uJO0UQOn8JjaXNLW8-SEoDFqad_U
Message-ID: <CADHxFxRayyDK5qO3j-GtQAuWruk8UtQ-6EcvYb-3iKtE8ooJUQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo,
On Thu, Dec 11, 2025 at 6:40=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Nov 26, 2025 at 09:44:02PM +0800, hupu wrote:
>
> Please don't spam on mailing list as you did. It is really bad practice.
> You could find resources [1][2] to learn upstreaming and co-work on the
> ML.
>

I apologize for the inconvenience caused by my frequent emails. I only
hoped to bring this nearly two-month-long discussion to a conclusion
sooner.


> > The eBPF skeleton is compiled via clang --target=3Dbpf, and its header
> > file search paths mainly come from BPF_INCLUDE and TOOLS_UAPI_INCLUDE.
> > It also uses '-idirafter' to include the host=E2=80=99s /usr/local/incl=
ude and
> > /usr/include directories in the search path. This process is not
> > directly coupled with cross-compilation managed via pkg-config, which
> > means PKG_CONFIG_SYSROOT_DIR does not affect how the skeleton resolves
> > its headers.
>
> Based on my limited knowledge, Clang does not provide its own headers.
> It needs to rely on GCC's headers for compilation.  I do see the
> Makefile does right thing for finding headers:
>
>   Makefile.perf:1203: ***
>   CLANG_SYS_INCLUDES=3D-idirafter /usr/lib/llvm-18/lib/clang/18/include
>   -idirafter /usr/local/include
>   -idirafter /usr/bin/../lib/gcc-cross/aarch64-linux-gnu/14/../../../../a=
arch64-linux-gnu/include
>   -idirafter /usr/include/aarch64-linux-gnu
>   -idirafter /usr/include
>
> It is mess to add some random include paths and feed to clang.  We
> already have provided a reliable way for building eBPF skelton program
> - keep in mind, eBPF skeleton program is not any aarch64 cross
> compilation, we just use clang for building bpf target.
>
> My understanding is you don't have a sane setting up on your local
> building env.
>

Although I have explained my view in earlier emails, it seems the
discussion has returned to the initial state.

Indeed, as you mentioned in the early discussion, running the
following commands on the host to install certain packages can
successfully compile perf:
> $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cro=
ss
> $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross


However, I don=E2=80=99t think relying on the host build environment is the
best approach, for several reasons:

a) These commands install UAPI header files on the host, especially
`linux-libc-dev-aarch64-cross` and `linux-libc-dev-arm64-cross`. These
headers originate from the kernel source tree=E2=80=99s `include/uapi/` and
`arch/arm64/include/uapi/` directories, and their versions are tied to
the *HOST* kernel version. If the target kernel version is different,
mismatches may cause compilation errors or even runtime failures.

b) Even if `perf` can be compiled and run successfully now, there is
no guarantee that the kernel source headers will always match the
host-installed UAPI headers as the upstream kernel evolves.

c) In scenarios where the host acts as a general build server and
needs to build multiple target kernel versions, it is not possible to
ensure that the host UAPI headers are compatible with all target
versions.

d) As you pointed out, `CLANG_SYS_INCLUDES` does include host headers,
but it uses `-idirafter` instead of `-I`. This means the host headers
have lower priority. This change was introduced in commit a2af0f6b8ef7
("perf build: Add system include paths to BPF builds"); as noted in
the commit message, the preferred approach is to use kernel source
headers rather than potentially older ones from the system.


Based on this, I propose the following include order:
- Prefer kernel source headers
  [RFC] perf build: Use self-contained headers from kernel source when comp=
iling
  https://lore.kernel.org/all/20251124072310.3592-1-hupu.gm@gmail.com/

- Allow users to specify header search paths matching the target
kernel version (eg. via `EXTRA_BPF_FLAGS`)
  [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLA=
GS
  https://lore.kernel.org/all/20251013080609.2070555-1-hupu.gm@gmail.com/

- Fall back to the host build environment only if necessary


In summary, while relying on the host build environment can fix the
current build issue, I believe it is not the optimal solution.

Anyway, regardless of the final decision, I will respect it. Before
concluding, I hope we can explore this further and involve more
maintainers in the discussion. As for your comment, "you don't have a
sane setting up on your local building env", I am not yet fully
convinced by this reason.

Lastly, I once again apologize for any disturbance caused by my
frequent emails, and I sincerely thank both you and Namhyung for your
involvement throughout this process. I also hope this discussion will
attract more attention so that additional maintainers can participate.

Thanks,
hupu
