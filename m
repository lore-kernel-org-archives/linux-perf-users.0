Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5E2D23B8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965385; cv=none; b=tG/7WFun0NDgMuw2DYG4wnqeOwC9uBY9SFnHGaStMerBm5NC2CsT6eWcmPfI7PrlHcICTib7UCNiYPb1zwY4HbUL/AMsI9A2PTYgJwAJjTPPLtNo+nLjESI8Pu8FCgU95rAG8WGV478p+wJwPAMVQcpN/fgt7q9OLD/B+tw3m5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965385; c=relaxed/simple;
	bh=arJAKr/SK39xaCcVSfKhVwWPNXJ1iZVUEoDaCay7IWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQcIOvSypG9sFTVo/2gemmgNlC91CHgobrakOTFzvfLm0R8Y0h2GOALueq/aBIbdnwJBRY3D8ctjWsbhVY5fr1WIeKe+3adEvmn5m6NtuSGWqgAvqp9r7lK6TdYbyPo4q7gPjbfQ2HcOTL+klFT0D04zvCt5EJFJSeIY4x3F0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecawvBXZ; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecawvBXZ"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-36d77de259bso32745371fa.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760965382; x=1761570182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uuEa1GizUQ74028zo19sko0RSacd2iUgNo//+4ytRk=;
        b=ecawvBXZSGR/OtjAilQ5YAGyyRzKd9OeIpY7Fa2NfTN920e7TZfagaAXbT5urJ4ovP
         9sD6rOgC/eIUHqLJPkKsdVNeC1AX9E1ak/p75Ti8X4/6vv82qV65w7MEh5hz9dzbxMNJ
         wvmk9yud1MzCLX9jMg0MoQSZr7jh33u6pOOgxI2dnyVZXUT7udQ+Y9WGy9MFnFDw8+Po
         0Ui6Jpua+2aqyNQHwKJ/bz+OU5gZUhYlrxMLprk7NkCO3P0JLYkkXNAFlDFc++tZW2wT
         xnHVlbp1HLi63rQlWHnDTroy1hlAj62IzudsHW4wHt6xzB+z90oLhdc6QV7rA0cd2rcw
         /0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965382; x=1761570182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uuEa1GizUQ74028zo19sko0RSacd2iUgNo//+4ytRk=;
        b=FaMW2n/SP+J7du+TWkR3BiHr0/gXlCt5MxM2gMgjy9n2/BpibcqgsXP5PGF4DmZ1i/
         hSbVaPDzBEvqlJHRawzOnOUgdiPIQ927gb9mpHRztOs93ZtWj4GTW2Gji5RRJMzaHDjK
         QBasaBgY2H5ns796QTrwFk1vdBYnYJiLL1XdGGwop9oqQKCOJQXOp5ABuZCQ+KQ+Hp9T
         BIHJnTJIzIQpG4ukPLwrf/eTUWNwO8CgUJtE6PuyM7xGLhOGMUFXYRAVroRhpxiWb+EP
         prA/8NGbdVYv2hIxM+kIgDg9ewMDyujwrwbRXBqWJdKJTBufSJAtAdQWuGD+G591+WVo
         tbNA==
X-Forwarded-Encrypted: i=1; AJvYcCWlFkiLnHFmYhPUdsQzNCJrqHOAdeRPn+FxHrOASUzULI1ktKDKhknqTl+DTc1CXL+g5JYCpVdrQBcqoHW/iKsY@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZXiqvRDNR7pKu84SHqob9sjML9V/RyUZr39NRD9/a7zCwNMT
	yIvF1/Wb8ZwRre2w/4ra+lBUq+sacPtImidJH6LJYCl9V0FxF4oWiZ3Uf8koDmjjoeZxMGeH/fE
	GKZokUvjlFgV8/PTkiHALwfpb/3KiSlo=
X-Gm-Gg: ASbGnctH/Py3obyhnXCVUW9d0X6jXahXszPdtNwYPXQ1gifaK211y240vgkRafETz3t
	1ua3hHtSxgxSSMrCcFXynS20PB2rDzZB18hmaUzvnNtM1FN9/jT/sSjUOsJoM5fB70GY9kcboi5
	ynjT5zz51ffR7W4DaBB51i5Rb2Xhb+PDAgz0XNPjdov5wPHtt+ZHKfP3jMsHAEVwjtHfuv4bBxp
	yqm16jusXrYn6wch9TreSlWZq0eRMAot8fVj+MbzZ2M8QHmyjDDsWuBEgRKY/zIUR9vs8E=
X-Google-Smtp-Source: AGHT+IHNzJ3XEsHXRJSlfkxjznD/AZG9sa0VCqsJ/c+5smyHDA2MMKoazPIgSqVAn/23mNld9KJoxvJPzTG+I4zGvjc=
X-Received: by 2002:a2e:9a0d:0:b0:362:b98f:edec with SMTP id
 38308e7fff4ca-37797a28204mr45253401fa.23.1760965381415; Mon, 20 Oct 2025
 06:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com> <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
In-Reply-To: <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 20 Oct 2025 21:02:49 +0800
X-Gm-Features: AS18NWCDclAgKEGbog6wTtTC1zhcEOa3aSTen8VqnfyTBuzuEw3Omsl0Mvc1NlQ
Message-ID: <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It is worth noting that this is not a special requirement unique to my
case, but rather a common need in embedded development scenarios.

Thanks,
hupu

On Mon, Oct 20, 2025 at 8:51=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Leo,
> Thank you for your reply and for taking the time to discuss this in detai=
l.
>
> On Mon, Oct 20, 2025 at 6:15=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
> >
> > On Mon, Oct 20, 2025 at 01:16:46PM +0900, Namhyung Kim wrote:
> >
> > [...]
> >
> > > On Mon, Oct 20, 2025 at 10:40:49AM +0800, hupu wrote:
> > > > When cross-compiling perf with BPF enabled, Clang is invoked during=
 the
> > > > build. Some cross-compilation environments require additional compi=
ler
> > > > options, such as `--sysroot` or custom include paths.
> >
> > [...]
> >
> > > Leo, are you ok with this?
> >
> > To be clear, now we are not talking cross build for perf program or any
> > targeting a CPU arch, it is a build failure for eBPF program.
> >
>
> I=E2=80=99d like to clarify the background and scenario once more:
> I=E2=80=99m building an SDK that includes a cross-compilation toolchain f=
or
> the target architecture along with a copy of the kernel source tree.
> The goal is to make this SDK usable on any host system to build
> software, including perf with eBPF enabled, without requiring the host
> to install any additional packages. This is a common requirement in
> embedded environments, where we often cannot control or modify the
> host system setup.
>
>
> On Wed, Oct 15, 2025 at 5:30=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Have you installed the GCC cross packages ?
> >
> >  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> >  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-=
cross
> >  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cros=
s
> >
> > My understanding is arm64 cross compilation tries to find headers in th=
e
> > path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
> > distros).  After install GCC cross packages, the headers should appear
> > in the folder.
> >
>
> As you mentioned earlier, installing the GCC cross packages on the
> host does allow perf to be cross-built successfully. This works in my
> current setup (Ubuntu host kernel 6.14, SDK kernel source 6.18).
>
> However, this approach has two key drawbacks:
> a) Limited portability
> If the SDK is moved to a different host, these packages must be
> installed again for it to work, breaking the =E2=80=9Cplug-and-play=E2=80=
=9D goal and
> increasing deployment complexity.
> b) Kernel version mismatch risk
> The headers from these packages are determined by the kernel version
> in the host=E2=80=99s distribution repository, not the kernel version in =
the
> SDK. For example, the host apt repository might ship headers from
> kernel 5.0 while the SDK contains kernel 6.18; differences in UAPI
> files (e.g., linux/bpf.h) could cause eBPF programs to fail to build
> due to missing APIs or structure changes. This risk is greater with
> fast-evolving subsystems like eBPF, even if it does not happen in my
> current environment.
>
> This is why I don=E2=80=99t consider relying on host-installed packages a=
s an
> optimal solution for my case.
>
>
> > This patch does not make clear why we cannot build eBPF program in
> > self-contained way. E.g., after installed kernel headers, why Makefile
> > misses to include installed headers when build eBPF program.
> >
>
> I may not have explained myself clearly. As noted above, installing
> the headers you mentioned does allow perf to build successfully, but
> this is not the approach I ideally want, and it is not the most
> suitable option for my current context.
>
> The aim of my patch is to explicitly direct the build system to use
> the SDK=E2=80=99s own header files (via --sysroot or an additional -I pat=
h),
> ensuring that:
> a) The build works without installing any host packages;
> b) The headers used always match the SDK=E2=80=99s kernel version, elimin=
ating
> potential version mismatch problems.
>
> I believe this approach meets the principle of self-contained builds
> and aligns well with real-world embedded development needs.
>
> In addition, allowing additional parameters to be passed to clang via
> EXTRA_BPF_FLAGS would provide greater flexibility in the build
> process.
>
> Looking forward to further discussion.
>
> Thanks,
> hupu
