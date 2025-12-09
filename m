Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D52F60B2
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765298290; cv=none; b=eogyxeea5DGM4swWfhBRyJhSIzPKb0RF0lRjTibXrQmGFbDiT4D0f1qR6LcxBxR8qhaDkIM/NfLsY8pPk9QalVHLM9mdolFOWMroBriZMo0LZKy2OGX+UsE/P23PS15oAXx0gJ6zK5jvyteIksVGHE0zs7zM33zBJm2DJMT6J+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765298290; c=relaxed/simple;
	bh=5qxTfRCkrTQwTgP0+Suhf69T7G/k1B+m3f5XbjtvZxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hL+GDV4eEK5Ref5Cmd7/0QkrGFPtJeGHH98MmC4bTou3uwo6/bjB1cAvXcJeWnUbzhcOH07dRSrSAf5/glmX/uC+e90UHtcwQjbT0fMBaTFf9/wp5F+RsbR6GZoxg7Ncc04xZzxUio92ncToWH17n8lcU5KurrlFjmlWCul3fuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y37M3Wj1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y37M3Wj1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2980343d9d1so179285ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765298286; x=1765903086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBgYLc4dHTUCm5+EvXIsl9wHNAAqlHLzqTyDnR8Tov4=;
        b=y37M3Wj1cNCyuQ0+ueXuGR6rAwgTL8jQlm3NfQmnqGdryfNiEq6d4jyQD2kC1U+UJk
         v2f7ms/VcNqKuEkk02b9VHj2q/c3nQSsE1qgNm+gVlWO2wBgTzfHILSVIg/r0SuCzWeD
         /dmCbIlqoSugnpA5IOwruBk9PT3CFxsFQKRut1NTO7GDVmv54y1cF6zyTH7wZ/oeFMrf
         Pvtx4o0mM8OQQQHYCSJzO7pF3nRBjJkfstiWDmxVPQlWjTBLQ5pzXdfmOTKYur+XBdx0
         fBhx0D8VdH4sCK3CDW054E150EhBJxAdPHur7N/LbdRgKoI0a3u61mzPMXjLzWUGiE8h
         JKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765298286; x=1765903086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XBgYLc4dHTUCm5+EvXIsl9wHNAAqlHLzqTyDnR8Tov4=;
        b=OepbTu4m/2trRUYyRduUgqnJZm5lZoqNkGEIlUfFyUhf2jNUOyfEQIA0YrurcDqxrT
         5qRbfMK/UJzYWOY7P7VDYKHFn9SngKwTeyK9dQRp7LYlT4ygTPMZt3mKCTM61w6wfNBd
         PZMWs0Q+n+mO3XwyVX96G3Bjc9LnC/1ufk++j88C9shGTC8bU+F0YKi44jZ48pTdot8m
         zI5HrIzmElEswhBr+dGNzsUowqj1LcP8H6cKkNdch9MQ0vfutlRCKL2e1nOVPuTbHe8N
         r9YjvdERB5nRq2rjBPbd1l/wevN9NSLaulc59ImXiG6EycrBF/DJGuk9Ee/UM0Suv4nn
         we4g==
X-Forwarded-Encrypted: i=1; AJvYcCUcAt193+s+Ig3cUz8yyw1O3H7CNFExfZYz86xCrss5kEky3tJ2gNiKo0YCLGrm6CEI4ugz6Ab76S+Q2pTrt3iq@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvilWGVxOC0ix9V+7GfYN5KQTGvP6qVfzh8O9j3XtvYoXQ6hO
	MNI2XoXlSmASfzSSGjcZCmnnob3/0dtD31Y/3kjwccat5XbGx1r3nlwhxqteufp3XmWpd5l1yYu
	sGPuNWylSvAlIh+s7/SjH2oiTpp3NgyGJt4fbtNYi
X-Gm-Gg: AY/fxX4B3z1zNKtMw533vud6oI8VaTEAoVHs+vr96LRdHd4kiaJn5B78T9YAW9zmwnv
	ji4R/R+WcFP6x//sygSgV6zbfV2yHJqba5+Jro69MBgFoGSAqLucmbh+89izBecEeJwAEQTYIMI
	FwknaJICLHK3b43sV9HeuZneowifdbUmOlq2+Y/WlIJAb9H/nIJEYJLdaAeaX7J55b16DEzdoAW
	GiMoCVhe9yJ+qROF9WZpi+l8UFqoy2UcsnZkfh8rSoT1b/4ezdaV5TjN/pQdba3cjj5Wc8jrtp8
	fnKgbLEx2IJkJ87nnvvFg+yy
X-Google-Smtp-Source: AGHT+IHBsjQxT88tRPwn/EmKsG/QmCYNkJTRikxQrZjnY3qRCNu5chCV1+7UrMru7W4ruwLw17nt+6insoteRMgUggM=
X-Received: by 2002:a17:903:2286:b0:297:f0aa:d466 with SMTP id
 d9443c01a7336-29e9427f5fdmr3813875ad.8.1765298286261; Tue, 09 Dec 2025
 08:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com>
 <20251204-perf_fix_syscall_header-v1-2-b8e27f74ed6a@arm.com>
 <CAP-5=fV-d_X1uFYACEOJOxOY43+fj9aEm0_bp7NGSo9kZVMJ4Q@mail.gmail.com>
 <20251205162147.GR724103@e132581.arm.com> <CAP-5=fW3ZVfTU-=3WJny6KuD+DC7fzNzAehUscztr8Zhhfwrmw@mail.gmail.com>
 <20251209104926.GS724103@e132581.arm.com>
In-Reply-To: <20251209104926.GS724103@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Dec 2025 08:37:55 -0800
X-Gm-Features: AQt7F2phnAjZfVpvy-ELRRAy9n2sfAfoK1Y4Q_JzZpxnijs0SZjB14a6-LXG96o
Message-ID: <CAP-5=fV-miOrYn+xNVAjZZsa3hPYncZoB6-ZtsMP2n9Zhm2sAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "perf tools: Fix arm64 build by generating unistd_64.h"
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 2:49=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Ian,
>
> On Fri, Dec 05, 2025 at 09:16:32AM -0800, Ian Rogers wrote:
>
> [...]
>
> > > For a neat fix, I think we can remove all unistd.h headers:
> > >
> > >   $ ls tools/arch/*/include/uapi/asm/unistd*
> > >   tools/arch/arc/include/uapi/asm/unistd.h
> > >   tools/arch/hexagon/include/uapi/asm/unistd.h
> > >   tools/arch/riscv/include/uapi/asm/unistd.h
> > >   tools/arch/x86/include/uapi/asm/unistd_64.h
> > >   tools/arch/arm64/include/uapi/asm/unistd.h
> > >   tools/arch/loongarch/include/uapi/asm/unistd.h
> > >   tools/arch/x86/include/uapi/asm/unistd_32.h
> > >   tools/arch/x86/include/uapi/asm/unistd.h
> > >
> > > Any concern?  I would get maintainers's confirmation before proceedin=
g.
> >
> > Thanks Leo! The tools/include directory is a concern for me as the use
> > of it is pretty unstructured. For example, what does <linux/types.h>
> > refer to?
>
> I understand your concern.
>
> For my current work, I would like to constraint to unistd.h headers
> only, now this is breaking BPF skeleton building on Arm64.
>
> I did not observe other building failures, so we can polish other
> headers later.
>
> > Thanks for doing the build testing! Doing a simpler grep:
> > ```
> > $ grep -r "asm/unistd" tools/include tools/perf tools/lib
> > tools/perf/check-headers.sh:  "arch/x86/include/uapi/asm/unistd.h"
> > tools/perf/check-headers.sh:  "arch/arm64/include/uapi/asm/unistd.h"
> > tools/lib/bpf/bpf.c:#include <asm/unistd.h>
> > tools/lib/bpf/libbpf.c:#include <asm/unistd.h>
> > ```
> > I think unistd.h is needed to make things hermetic for libbpf :-( ...
> > Anyway, I think getting rid of unistd.h is a good
> > thing but it will probably break perf's build that invokes libbpf's
> > build because libbpf will be mixing kernel and old libc headers on one
> > of the maintainers build test platforms (likely an old one) where the
> > type collisions yield compile time errors. To avoid that I'd suggest
> > making libbpf not use asm/unistd.h as a first step. We could get lucky
> > with something non-hermetic, but it wouldn't be my preference.
>
> Based on my test, perf (including libbpf) builds successfully without
> relying on the unistd.h headers under tools/arch.
>
> To verify which "unistd.h" headers are actually included, I searched
> dependencies recorded in .cmd files:
>
>   grep -r --include=3D"*.cmd" "unistd.h" /data_nvme1n1/niayan01/upstream/=
build/
>
> See the complete log: https://termbin.com/9w85
>
> The mentioned libbpf building includes "unistd.h" headers from the toolch=
ain
> and can build successfully.  I verified with two GCC toolchains:
>
>   # aarch64-linux-gnu-gcc --version
>   aarch64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0
>   Copyright (C) 2019 Free Software Foundation, Inc.
>   This is free software; see the source for copying conditions.  There is=
 NO
>   warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.
>
>   # aarch64-linux-gnu-gcc --version
>   aarch64-linux-gnu-gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
>   Copyright (C) 2023 Free Software Foundation, Inc.
>   This is free software; see the source for copying conditions.  There is=
 NO
>   warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.
>
> As a side topic, given libbpf is maintained on github and can support
> standalone build [1], we should have confidence that it is not dependent =
on
> tools' headers.

The github project does things differently and has copied headers into
itself to make things work. It doesn't copy unistd.h:
https://github.com/libbpf/libbpf/tree/master/include/asm
but I'm not sure that means anything beyond the BPF buildbot not needing it=
.

> I still think removing the unistd.h headers from tools is the right thing=
 to
> do, and based on test, it does not break perf building.

I think this is the getting lucky case I referred to :-) I can imagine
in the build environment I'm in, needing to revert the change to make
sure the headers remain hermetic. I suspect the perf on old Linux
build checks will also face a similar problem.

Thanks,
Ian

> Thanks,
> Leo
>
> [1] https://github.com/libbpf/libbpf?tab=3Dreadme-ov-file#building-libbpf
