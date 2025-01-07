Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7311F3D47
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268381; cv=none; b=pmyq3+FQbn86dUJhPbpyaz63001oLrkbP1tCUP4YMaLVIu5D2WxkX4eQXadENIeWBNgZqS7X6FS2de78SsAXtkHGzvAd9af+MGcvt8htrjSrSXn++64lNttV45RJf0FKt0J7PAZEP3S4nufv7IjuMb0LryQbmTI+M9SO40jbFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268381; c=relaxed/simple;
	bh=nfj1Xu0XyTzOR1EBQLnUAw0M9/aU2Erg5Oxt4JQaDcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INXf+2FOXTiWouiYXTIGfpQtDP3s8alnrCuSO4PNOpB+ohcZ1wKIohDWnN2ZJg1dlWVLERvw/QQt8jjtivrMGll9akKslGQncYqc162+cfJctdUH14A9MfI3CHhNe39wHvBoVbRDveFOIQGVOVoXwd3ZMGHsLiHokKMWU/Nd7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YoqLU3Da; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YoqLU3Da"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so161475ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 08:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736268374; x=1736873174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoUuinTnp1TfqZ89odKqiLTAxaKLAJJ7QZ1djcwttHM=;
        b=YoqLU3DaEUykQdGcrk1YrC/W/nOm4wp6yXiimvjmCfqCzCgKgmAzK7pTMYHLFGEzBn
         5aCZF3RYwnqUvS6vaL9S+ubmQx6/ez/pczKFzyXlwOXNlaQb57Wc4t7c1F7+yPhth/7c
         pyUOP69ks1mMaFdvdiDPUwN/MvM/fkt2V8FUBxcI0sIgNwOEUXfW4Bl5UAJvDyRUYD/5
         7cTpBdh/r0kYQL38Xi7UDzfYGtrbrmvBdgrbAEGyuYtros2Vll7oGc99vHJbFeTRtXUj
         Gls8QBg01XvrnW3Rcs0dsoahHdD9hrIqUMxo7Mzth4dAxGz01RhIbuJLWFjhuVOti4+l
         FvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268374; x=1736873174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoUuinTnp1TfqZ89odKqiLTAxaKLAJJ7QZ1djcwttHM=;
        b=aQ77DOZS0+Jkq6vcUdqGB1amU2un5MRiucTLxHlvMjIHAUryrtiUFRXEvOk0sA0Yfv
         LpiQDEFFylWwxl+VnGMDhrsuNxh4fbOgkKBOYmImOo/m4n0suExh5Px3WqW2Zairjcb4
         9vKq6b6xK7PyZ7W99lvxktjneIXvIuUvVsVEoo02zQ6zp+/rdzAZPDvpKSVlDfoMpg1b
         UC4WByByYNZFr56b4SFPxzCfSLs28gBWYI1nGbUTux+4fU1vyuDvjeuGGs4PUA+vfvl/
         F1IZcjTOT4K7AqIQXDjRQgmHzRgXTzAJxwfVC8I/PhlL3rAoy2cRQTj7WLrG9+wmLk41
         tusA==
X-Forwarded-Encrypted: i=1; AJvYcCUuYFNZ5+8RkgUzA/KXqfahWLvO+Zr0V5HcXRXmD/V/iI52JM0KpW0sQUdWKOom+5HyVuDIo7WaFkGmj7uB2pZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YyKi7q+9vNcfbJqeuqeVCNBxknfiF68lPlxoH0kcuzZISqe5/71
	jgz5kNNQcEj+6reYk6v+FOBAxfCMNW4FeR8Tt081DURpk4gYO6EkPXvvNJm6IgN1GPLUAdGZ51Z
	IA75DmbKsUe1aEQXi3e8IyNnjhs/5TLgsMrD5
X-Gm-Gg: ASbGncuXM8yWORAsd4kpq4Kig2S2+dQIgSM8siFUV2UO9kprSHAMt5o5t23t5vF+WtK
	o8HldSYjdG3IOqVVeHGhdHA1GuyHzvuo2bRanOKRBY4xV8AadU8asYtDovagDAvnD+O+q2w==
X-Google-Smtp-Source: AGHT+IGYqdVgN1EdwmgZAtasWmScjV/71wD/8mw0DQ3R4SGAwfv0GvcTdE9fmx/zsZP2KBHTC6eNPVcC2/eTAyJEsKE=
X-Received: by 2002:a05:6e02:1fe8:b0:3a7:dea7:87a6 with SMTP id
 e9e14a558f8ab-3ce333ae611mr3363625ab.29.1736268373922; Tue, 07 Jan 2025
 08:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu>
 <CAP-5=fWVHaVpJbDf=afn5MhZ972uEq=sGEmsULoD=LRff2Vouw@mail.gmail.com> <fa5dfd6d-3b8d-4086-9604-e5abddd324c9@csgroup.eu>
In-Reply-To: <fa5dfd6d-3b8d-4086-9604-e5abddd324c9@csgroup.eu>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 08:46:02 -0800
X-Gm-Features: AbW1kvYoxlBjLdxTV6GwL0H9rcNGGfYrfdbGog2kgceMTlrqNVfpEr6b_qO8KVM
Message-ID: <CAP-5=fU_NCohskhq=rh1wLPxWmSuZcTw-hzwOhBSPBn4cfg4MA@mail.gmail.com>
Subject: Re: [PATCH] libperf: Add back guard on MAX_NR_CPUS
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:50=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Le 06/01/2025 =C3=A0 21:05, Ian Rogers a =C3=A9crit :
> > On Mon, Jan 6, 2025 at 11:38=E2=80=AFAM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >> Building perf with EXTRA_CFLAGS=3D"-DMAX_NR_CPUS=3D1" fails:
> >>
> >>            CC      /home/chleroy/linux-powerpc/tools/perf/libperf/cpum=
ap.o
> >>          cpumap.c:16: error: "MAX_NR_CPUS" redefined [-Werror]
> >>             16 | #define MAX_NR_CPUS 4096
> >>                |
> >>          <command-line>: note: this is the location of the previous de=
finition
> >>
> >> Commit e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS=
")
> >> moved definition of MAX_NR_CPUS from lib/perf/include/internal/cpumap.=
h
> >> to lib/perf/cpumap.c but the guard surrounding that definition got los=
t
> >> in the move.
> >>
> >> See commit 21b8732eb447 ("perf tools: Allow overriding MAX_NR_CPUS at
> >> compile time") to see why it is needed.
> >>
> >> Note that MAX_NR_CPUS was initialy defined in perf/perf.h and a
> >> redundant definition was added by commit 9c3516d1b850 ("libperf:
> >> Add perf_cpu_map__new()/perf_cpu_map__read() functions").
> >>
> >> A cleaner fix would be to remove that duplicate but for the time
> >> being fix the problem by bringing back the guard for when MAX_NR_CPUS
> >> is already defined.
> >>
> >> Fixes: e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS=
")
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Hello,
> >
> > I believe this change might be unnecessary. The only use of
> > MAX_NR_CPUS is in a warning message within perf_cpu_map__new, which
> > takes a string and produces a perf_cpu_map. Other similar functions
> > like cpu_map__new_sysconf don't check MAX_NR_CPUS. Therefore,
> > specifying a -DMAX_NR_CPUS value on the build command line has little
> > effect=E2=80=94it only impacts a warning message for certain kinds of
> > perf_cpu_map creation. It's also unclear what the intended outcome is
> > on the build command line.
> >
> > Given that specifying the value doesn't seem to have a clear purpose,
> > allowing the build to break might be the best option. This would alert
> > the person building perf that they are doing something that doesn't
> > make sense.
> >
>
> Ok so I looked at it once more and indeed it looks like it has changed
> since 2017. See commit 21b8732eb447 ("perf tools: Allow overriding
> MAX_NR_CPUS at compile time") to understand why it was required at that
> time.
>
> Now I don't have much size difference anymore between a build with
> MAX_NR_CPUS=3D1 and the default MAX_NR_CPUS=3D4096:
>
> $ size perf perf-1cpu
>     text           data     bss     dec     hex filename
> 3415908  104164   17148 3537220  35f944 perf
> 3415904  104164   16124 3536192  35f540 perf-1cpu
>
> Apparently that was changed by commit 6a1e2c5c2673 ("perf stat: Remove a
> set of shadow stats static variables")
>
> So I agree with you, it is apparently not worth reducing MAX_NR_CPUS
> anymore, I'll give it a try.

Thanks for figuring this out and the explanation. Fwiw, the shadow
stats should be gone. Perf obviously reads counters, as there may be
counters on multiple CPUs then it aggregates these counts together.
The shadow stats were another aggregation mechanism used for metrics
and being a simple person I managed to land just having the single
aggregation approach although there's some cleanup in this area hiding
as tech debt in perf script. The support was removed around 12 minor
versions ago, iirc.

As a heads up given the interest in binary size, most of perf's binary
size comes from the json events. Off the top of my head I'd say it is
like 70% on x86. We avoid string relocations on those by storing
constant offsets and at some point I'd like to get compression going -
although I'd like to compress across files, something 7-zip's format
at least attempts but there was recent 7-zip security news which may
mean a dependency is a bad thing. Anyway, most of the json events
likely aren't needed by the platform you are building for and I added
some build support for only including the ones you are. As you may not
know your CPU's model name I added a mechanism to use CPUIDs:
https://lore.kernel.org/r/20240904044351.712080-1-irogers@google.com
But perhaps we can use x86-64 version levels to make this a more
automated approach, if we see say a "-march=3Dx86-64-v4" in the CFLAGS -
the idea being that say nehalem doesn't support x86-64-v4 so we can
safely drop the nehalem json data. That said x86-64 version levels
have been described as, "some crazy glibc artifact and is stupid and
needs to die":
https://lore.kernel.org/lkml/CAHk-=3Dwh_b8b1qZF8_obMKpF+xfYnPZ6t38F1+5pK-eX=
NyCdJ7g@mail.gmail.com/
For metrics I have a similar problem, knowing which models support
which events, but to handle that I use the json and see if it has an
event, if not the metric isn't created. This causes issues when new
models rename events. Anyway, those patches haven't landed, here are
the Intel versions:
https://lore.kernel.org/lkml/20240926175035.408668-1-irogers@google.com/

Thanks,
Ian
