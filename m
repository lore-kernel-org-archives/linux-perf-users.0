Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D5215075
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Oct 2025 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761454335; cv=none; b=JbRYsrBWXwP8y0N19cC5Jmiy7B2A6r1X4qqaraypSVwLJvwPCRgnYWIGMTGJuRJCVL/+OrkpRtqDrAIo8eGwc1xh83q8XAjN92p7U1wonZEYYXaRCfononbU4UIo58Oz3gnlZigcdhoLI9IVPQqMOB/gGUjGR3V8LSttxuXiIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761454335; c=relaxed/simple;
	bh=4Dc4N3qbwwcxA9ZMSvZPe7OTp9wp9wL3+2BXKP94uic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFP04fU2oqNE9AVKBHcr4XtgL2QcfK+2AJeZtotqBrnBj/tIA9MSk+pA2Maz5Imd2fYc+fuZOjuGMnTb9XcFOznQxY/YahCAbAKQDGdzp76fkpBB6Uq4jTw1f5EuR5JcnN9L9jjud4/Bz3u5oE6loLb/UcRwJcpBhInVnKudUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWFfD9U/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWFfD9U/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eeafd4882so188815ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Oct 2025 21:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761454333; x=1762059133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P6mxq6VtzZxcoez1LoW+qD/3rCdmW7jgaATYRcM+ME=;
        b=jWFfD9U/UvcJzF4JkNY3u6vHuHgE5Agz/VHpB5mBcJsNUkJ0CnFM2SvZ3Q9JrIC2Hd
         jnA+TceXcDdGedYaaftpSIGhkyaVXf6gSroUaFLWw3zCgt0u9i8wI2DIHHycLO+WXQ8O
         3MAWp1EIAXdPyIcDMUJxajjB+7ZDiZpOFWnHobR2cRX1Vmd7DGkhvrK9l0aeRIyPg8Iw
         UTNHnwi9EhTZn2UUlDvNuZkFTEV+f6NryCrnOIvMxE62c5KtHmXtkzF02UWvTAMgfQrJ
         A50ezmDDxPf4KPP2ryc+C2Xar+AxiFHratyNQYGvCr8OUEqtju9GUzhF0kCPyc9CTHGe
         ikrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761454333; x=1762059133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P6mxq6VtzZxcoez1LoW+qD/3rCdmW7jgaATYRcM+ME=;
        b=Blq7gySvhiBPxq0hHPuSsVV8CCmnh4lai8wsIs+toO89slr9RtiUWuQOS2h/OHz2W3
         AoV7SKCqjQml6MNrGmmfuISz4eOys7DPTILjkTPsOmPFHlPIXPr4JgWH5UNW4iKuI1Ak
         9jbPv14K+St0eKOPw4/CAcpvnrlMyQtBasCbAMMeys9mZgY4p71lqf1OR+2ovhPQ6/ZS
         BL4Cf9bW8KMMB98eHfRXCpyezIXClierFtJk1kfHjVpCLWGwT1H0xLf8QgNBplZSq4LM
         PMAI7XPRmp9GhTaqmFP2g5BYAsgt6CJwcqrUhXgb4qL6tOL79F/E4prQLU/iO20lRrd6
         6z3A==
X-Forwarded-Encrypted: i=1; AJvYcCXNNstcD1UXpf6XqDSgeumvpNasO/UwUR2HoByGSFxf4aulGgBqzRfWhhS3PY4KnGXM58NY/3mOWoFBJRuuCUf7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4A267EhFXMGWd44YteeeOnb5HSPnUWe9Fm7mk6rM9E0IoOiot
	jHUJeLAGl2Jx34lcPip5oKfdcF2clhN4kVOK8rKF/AIbpRYfSfbEMluvJExGoNkFzL+Hpydpacq
	pXLA83gAVSnc4lMrvSjbCQcexawR7g4b4YKIJvN/r
X-Gm-Gg: ASbGnctAimvleUSSgyxFif0JDHEvbCu5Izt/FVdmoiNqDfdayeMdhcjPLz24Erj7OpB
	yAcDwKW55QoVpH7fONulqh8neiyndGwfor+prnLJSc5NQGOoDBDu3EJw5ytUBBIlVzE8iBeyCbk
	ybi5ItIr8wNecpRC86x6javptXuVKqKduS42/hY5jWPlg+ZKbzBqjhw+KCTTWoeSOv7rCOPlKax
	Bkg/7NOpf2TEufvQw8qaGJb8wdDyJD3LfQlqXEz86IbrZC1cw/Js0h1WBK6
X-Google-Smtp-Source: AGHT+IHMVzaofhA3wIWgJzuesVEgvKeAV/oywnPC1Wtd2m/CFKkObi3QC/tc5kGCRAJqfBC3EoGMG53nIMZgRHAgQ+U=
X-Received: by 2002:a17:902:e749:b0:290:dd42:eb5f with SMTP id
 d9443c01a7336-29497bce346mr4445765ad.12.1761454332725; Sat, 25 Oct 2025
 21:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
 <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com> <aP1kSdZJKYIpnRia@google.com>
In-Reply-To: <aP1kSdZJKYIpnRia@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 25 Oct 2025 21:52:01 -0700
X-Gm-Features: AWmQ_blBTg1noq0xZtV_gKrDwKOg3MyceopTwyck3emeMmrFAVlTFDdLFl7juGY
Message-ID: <CAP-5=fUiO1uypnsw=G-FFj0xE=uCowG5FetaC9JGygOxybuGGA@mail.gmail.com>
Subject: Re: [PATCH] perf dsos: Don't block when reading build IDs
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 4:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Fri, Oct 24, 2025 at 11:26:18AM -0700, Ian Rogers wrote:
> > On Wed, Oct 22, 2025 at 8:46=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> > >
> > > The following command will hang consistently when the GPU is being us=
ed
> > > due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2)
> > > being opened to read build IDs:
> > >
> > >  $ perf record -asdg -e cpu-clock -- true
> > >
> > > Change to non blocking reads to avoid the hang here:
> > >
> > >   #0  __libc_pread64 (offset=3D<optimised out>, count=3D0, buf=3D0x7f=
ffffffa4a0, fd=3D237) at ../sysdeps/unix/sysv/linux/pread64.c:25
> > >   #1  __libc_pread64 (fd=3D237, buf=3D0x7fffffffa4a0, count=3D0, offs=
et=3D0) at ../sysdeps/unix/sysv/linux/pread64.c:23
> > >   #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
> > >   #3  read_build_id (filename=3D0x5555562df333 "/dev/dri/card2", bid=
=3D0x7fffffffb680, block=3Dtrue) at util/symbol-elf.c:880
> > >   #4  filename__read_build_id (filename=3D0x5555562df333 "/dev/dri/ca=
rd2", bid=3D0x7fffffffb680, block=3Dtrue) at util/symbol-elf.c:924
> > >   #5  dsos__read_build_ids_cb (dso=3D0x5555562df1d0, data=3D0x7ffffff=
fb750) at util/dsos.c:84
> > >   #6  __dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x5555557e703=
0 <dsos__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:59
> > >   #7  dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x5555557e7030 =
<dsos__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:503
> > >   #8  dsos__read_build_ids (dsos=3D0x55555623de68, with_hits=3Dtrue) =
at util/dsos.c:107
> > >   #9  machine__read_build_ids (machine=3D0x55555623da58, with_hits=3D=
true) at util/build-id.c:950
> > >   #10 perf_session__read_build_ids (session=3D0x55555623d840, with_hi=
ts=3Dtrue) at util/build-id.c:956
> > >   #11 write_build_id (ff=3D0x7fffffffb958, evlist=3D0x5555562323d0) a=
t util/header.c:327
> > >   #12 do_write_feat (ff=3D0x7fffffffb958, type=3D2, p=3D0x7fffffffb95=
0, evlist=3D0x5555562323d0, fc=3D0x0) at util/header.c:3588
> > >   #13 perf_header__adds_write (header=3D0x55555623d840, evlist=3D0x55=
55562323d0, fd=3D3, fc=3D0x0) at util/header.c:3632
> > >   #14 perf_session__do_write_header (session=3D0x55555623d840, evlist=
=3D0x5555562323d0, fd=3D3, at_exit=3Dtrue, fc=3D0x0, write_attrs_after_data=
=3Dfalse) at util/header.c:3756
> > >   #15 perf_session__write_header (session=3D0x55555623d840, evlist=3D=
0x5555562323d0, fd=3D3, at_exit=3Dtrue) at util/header.c:3796
> > >   #16 record__finish_output (rec=3D0x5555561838d8 <record>) at builti=
n-record.c:1899
> > >   #17 __cmd_record (rec=3D0x5555561838d8 <record>, argc=3D2, argv=3D0=
x7fffffffe320) at builtin-record.c:2967
> > >   #18 cmd_record (argc=3D2, argv=3D0x7fffffffe320) at builtin-record.=
c:4453
> > >   #19 run_builtin (p=3D0x55555618cbb0 <commands+288>, argc=3D9, argv=
=3D0x7fffffffe320) at perf.c:349
> > >   #20 handle_internal_command (argc=3D9, argv=3D0x7fffffffe320) at pe=
rf.c:401
> > >   #21 run_argv (argcp=3D0x7fffffffe16c, argv=3D0x7fffffffe160) at per=
f.c:445
> > >   #22 main (argc=3D9, argv=3D0x7fffffffe320) at perf.c:553
> > >
> > > Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > > I'm not actually sure if this is the right fix for this. Commit
> > > 2c369d91d093 ("perf symbol: Add blocking argument to
> > > filename__read_build_id") which added the blocking argument says that=
 it
> > > should be non-blocking reads for event synthesis, but the callstack h=
ere
> > > is when writing the header out.
> > >
> > > There was also an is_regular_file() check added in commit c21986d33d6=
b
> > > ("perf unwind-libdw: skip non-regular files"), which presumably falls
> > > afoul of the "which unfortunately fails for symlinks" part of the oth=
er
> > > linked commit message?
> > >
> > > So I can't tell if we should add the is_regular_file() check here too=
,
> > > or just set it to non-blocking, or it needs some extra state to be
> > > passed all the way down to dsos__read_build_ids_cb() to do different
> > > things.
> >
> > The fix lgtm but I worry about making all the build ID reading
> > non-blocking meaning build IDs getting lost.
>
> I'm not sure what non-blocking means for regular file system operations
> on a block device.  But it may have some impact on regular files on a
> network filesystem.

Agreed. Prior to using blocking we tried to imply from the file type
from stat, but that skipped things like symlinks :-/

> > It seems that generating
> > the build ID feature table is unnecessary if we have build ID mmap
> > events, including synthesized ones that will have read the build IDs.
> > I wonder if a better "fix" is:
> > ```
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index cb52aea9607d..15f75c70eb76 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1842,7 +1842,7 @@ static void record__init_features(struct record *=
rec)
> >        for (feat =3D HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; =
feat++)
> >                perf_header__set_feat(&session->header, feat);
> >
> > -       if (rec->no_buildid)
> > +       if (rec->no_buildid || rec->buildid_mmap)
> >                perf_header__clear_feat(&session->header, HEADER_BUILD_I=
D);
> >
> >        if (!have_tracepoints(&rec->evlist->core.entries))
> > ```
> > that should disable the build ID feature table generation when build
> > ID mmaps are in use (the default). Having the build IDs twice in the
> > data file feels redundant. Or we could do your fix or both, wdyt?
>
> I'm ok to remove the header feature but I think it should update
> build-ID cache even with this change.

Yeah, dropping the feature writing also impacts updating the build ID
cache because:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/header.c?h=3Dperf-tools-next#n338
It is kind of strange that writing a header feature does this. What if
I want to write a header with build IDs but not update the cache? It'd
make more sense, I think, for perf_session__cache_build_ids to be
called explicitly. There is also the global no_buildid_cache
controlling behavior:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/build-id.c?h=3Dperf-tools-next#n43
But that's kind of a hack as we may have >1 session such as with TPEBS.

> I'm also curious if the device has samples actually.  It should be
> checked by dso->hit.

In this case the header writing is happening after the samples have
been processed, but it looks like marking of samples doesn't consider
data addresses:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/build-id.c?h=3Dperf-tools-next#n55
just sample->ip and the callchain. If the marking was updated for data
pages then just writing build IDs for marked dsos would make sense.
There could be callers not marking dsos so they'd need altering, or
two versions of the code.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/util/dsos.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> > > index 64c1d65b0149..5e1c815d7cb0 100644
> > > --- a/tools/perf/util/dsos.c
> > > +++ b/tools/perf/util/dsos.c
> > > @@ -81,13 +81,14 @@ static int dsos__read_build_ids_cb(struct dso *ds=
o, void *data)
> > >                 return 0;
> > >         }
> > >         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> > > -       if (filename__read_build_id(dso__long_name(dso), &bid, /*bloc=
k=3D*/true) > 0) {
> > > +       /* Don't block in case path isn't for a regular file. */
> > > +       if (filename__read_build_id(dso__long_name(dso), &bid, /*bloc=
k=3D*/false) > 0) {
> > >                 dso__set_build_id(dso, &bid);
> > >                 args->have_build_id =3D true;
> > >         } else if (errno =3D=3D ENOENT && dso__nsinfo(dso)) {
> > >                 char *new_name =3D dso__filename_with_chroot(dso, dso=
__long_name(dso));
> > >
> > > -               if (new_name && filename__read_build_id(new_name, &bi=
d, /*block=3D*/true) > 0) {
> > > +               if (new_name && filename__read_build_id(new_name, &bi=
d, /*block=3D*/false) > 0) {
> > >                         dso__set_build_id(dso, &bid);
> > >                         args->have_build_id =3D true;
> > >                 }
> > >
> > > ---
> > > base-commit: a1d8548c23076c66d96647f5f6f25aa43567f247
> > > change-id: 20251022-james-perf-fix-dso-block-ca1d8437bbc0
> > >
> > > Best regards,
> > > --
> > > James Clark <james.clark@linaro.org>
> > >
