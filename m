Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5A184558;
	Mon, 12 Aug 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481862; cv=none; b=GsYJWCpPjnkAyt/O60TptVcAgypdfEpYTqJSdMys9iw5/dTovENFSweeP0AXxGSSoAKkZyxLSXySEOLX0pzvP7DZkStwp8f37UehADcGRrr+Ofci1r2A6zC8Sydl5ELu+X7GwUAmd5cNpeiAMJvj+DYYWfKwJaNu7w1xasfpzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481862; c=relaxed/simple;
	bh=PFOeBR7DEWkdt/jQdta5OhkaVmv7rjz82/c3N9bXu5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwKs53HtS0miyN3zdU3hKjZfIDWeWdU7k2grbJLtLijhz9OOY8CTyz9tag/USH0zV/T61ETkN4mI9wBY/REfAO+vj3R05WyPA81asaztyeHdJXvDodSioCVIra3LJs00oM2jvVaNIXVe1PRMiIhUWvZgtC/iNPvyyi9F34+0UGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb4c4de4cbso2925215a91.1;
        Mon, 12 Aug 2024 09:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481860; x=1724086660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBT6GUroxASOGIZcaDGkgoB7aJF/nxAzTjccxRYF0yA=;
        b=HftjBlctT9vSmeEwXaZX1IkTUMazo3HI0MlTEINiSzIeAxtYVv14eeK4aPwyI/4iEp
         fKTqQe2ExIVxxsUAdo0aTyI+hJOZoUaKY4AWc8d2aOaNtVZFKtMH1HpAQqNnXB2pF3RV
         eFPNIe71GyH/QHHamzUJuPwbvkiZq81zVKHnz559ecsT6om26/mru3fRi1zkZEXfnV4C
         8XOTf4hpyXAKtVYIflsltth/faTGxuBoYFAvX2OiJCAmguYVr43N2mEkLdfOHCxGQM9M
         qVrd5v7SwiOt8aio9+0KmOSahOA5oaSwt7gyHwCl4Jaom0nNFkXEUn+7S7pMu3h6HT0c
         /9/A==
X-Forwarded-Encrypted: i=1; AJvYcCXuQuDlAt597UW7PC8bLs4rwkr8BnxxWeshMl0QqGAnOG+dDh601YDY5Fcz2+r6PD4eKfkxtp/th/dxwIVUw85KzzYmqx1vuerbwfzyLT5bIxi2QvMG8TAkoW51m3Jq1BDCqpbrTebo53oDgaWqiA==
X-Gm-Message-State: AOJu0YzpcHCQ1YRGbfGLCJgQlu1omD4p0Md1DCr5IxYbwASdJ3G0VXUX
	NG56sQxsi81Nrb5swnWUgT+me2N09uYlgEdy0oXwa5kpqiyJ1FQ/q5q5zmFrknYpsyoL+tGn2Kk
	+kpOV7BkH5oPU8ybLwjsM/eKC0d0=
X-Google-Smtp-Source: AGHT+IHWp42ThEM9dW+KrJQ0c4HyecKzjeMkYed6s9Ndqys32WZ9fNaZLY3ER+aplHGMgQImA7IjNNuaAO89dP+kRog=
X-Received: by 2002:a17:90a:ea0a:b0:2cb:5654:8367 with SMTP id
 98e67ed59e1d1-2d3926407bcmr946152a91.26.1723481860169; Mon, 12 Aug 2024
 09:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <909abbc8-efca-40df-9876-8c36b6942a83@stanley.mountain>
 <20240810191704.1948365-1-namhyung@kernel.org> <ZrozwIQcB_viRsKt@x1> <Zro90YPyLCB9PsfL@x1>
In-Reply-To: <Zro90YPyLCB9PsfL@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 12 Aug 2024 09:57:27 -0700
Message-ID: <CAM9d7ch1ESEhJW-1j0O-0xxr-w1we+opD1xWTs4Eq=u7Gg7unQ@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Change stack_id type to s32
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Aug 12, 2024 at 01:09:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sat, Aug 10, 2024 at 12:17:04PM -0700, Namhyung Kim wrote:
> > > The bpf_get_stackid() helper returns a signed type to check whether i=
t
> > > failed to get a stacktrace or not.  But it saved the result in u32 an=
d
> > > checked if the value is negative.
> > >
> > >       376         if (needs_callstack) {
> > >       377                 pelem->stack_id =3D bpf_get_stackid(ctx, &s=
tacks,
> > >       378                                                   BPF_F_FAS=
T_STACK_CMP | stack_skip);
> > >   --> 379                 if (pelem->stack_id < 0)
> > >
> > >   ./tools/perf/util/bpf_skel/lock_contention.bpf.c:379 contention_beg=
in()
> > >   warn: unsigned 'pelem->stack_id' is never less than zero.
> > >
> > > Let's change the type to s32 instead.
> > >
> > > Fixes: 6d499a6b3d90 ("perf lock: Print the number of lost entries for=
 BPF")
> >
> > Thanks, applied to perf-tools-next,
>
> I'll try to fix this later, but now it fails the first 'make -C
> tools/perf build-test' target, that you can run directly as:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ tools/perf/tests/perf-targz-src-=
pkg tools/perf
> <SNIP>
>   CLANG   /tmp/tmp.FRZLVEwqdz/perf-6.11.0-rc2/tools/perf/util/bpf_skel/.t=
mp/augmented_raw_syscalls.bpf.o
> In file included from util/bpf_skel/lock_contention.bpf.c:9:
> util/bpf_skel/lock_data.h:10:2: error: unknown type name 's32'; did you m=
ean 'u32'?
>    10 |         s32 stack_id;
>       |         ^~~
>       |         u32
> util/bpf_skel/vmlinux.h:17:15: note: 'u32' declared here
>    17 | typedef __u32 u32;
>       |               ^

Oops, sorry about this.  There was a kernel test robot report.
It seems we need 'typedef __s32 s32;' too.

Thanks,
Namhyung


> In file included from util/bpf_skel/lock_contention.bpf.c:9:
> util/bpf_skel/lock_data.h:14:2: error: unknown type name 's32'; did you m=
ean 'u32'?
>    14 |         s32 stack_id;
>       |         ^~~
>       |         u32
> util/bpf_skel/vmlinux.h:17:15: note: 'u32' declared here
>    17 | typedef __u32 u32;
>       |               ^
> 2 errors generated.
> make[2]: *** [Makefile.perf:1247: /tmp/tmp.FRZLVEwqdz/perf-6.11.0-rc2/too=
ls/perf/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:292: sub-make] Error 2
> make: *** [Makefile:76: all] Error 2
> make: Leaving directory '/tmp/tmp.FRZLVEwqdz/perf-6.11.0-rc2/tools/perf'
> =E2=AC=A2[acme@toolbox perf-tools-next]$
