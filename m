Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841C285073
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Mar 2026 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328431; cv=pass; b=L74E/YMjmCLgpkfh6w7ByFtGOKVKrBFj2NGCxGiK1FF7u8jPKoyL/h2A/qqDOkJSXdbPaN8X5BNwvv12BaIXKkGWECn2kGHIkw9HznuVyEDWeBib8NCj4xbZ6umH2bwqqFIZqgeFJ+TSAOFc+LizHTU9h7zyaYDuhTdQtTI07d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328431; c=relaxed/simple;
	bh=e/Q6ub0zyTjY21fLbL0q+R2Qx/2I/sI1QrAXBl/lvPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSbM0Sjj2+b3hheTmLKyqKsi5kAbNSwkT2CxSYAJ/FLDzowUMaoawt1PqXoYzYN+bWds6gKsVn3ry8vsO41W43NAm+IxBRGBTcmIFhr+ud80g2NgVLod+o1PIMdW8+7dPuRtKb0KU+jUf+vcmFqln/9eCBAx27dhJEM92u8XmYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3834TrT; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3834TrT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae49120e97so8135ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 17:27:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772328427; cv=none;
        d=google.com; s=arc-20240605;
        b=dE9Lvl4yTnepZ6BvUBWLo51XhZU8miC721130Fq//nSIQun5O3FIdEPcfHMNu+gWJB
         eMBtVtNr0R2fpMdBlIjZSMS+bZruYuLgatAND2IzUAv3LwJXGHuSg62k8Ddv0/iFxRTK
         7aMqldbWgfvaulmYs9rSB7B/Rbx3AIF7qQYsPqvuoRu0po99OifJgidFiapW3K9lYtJ+
         BqRjkzyCJ7IcRQRAW1wS8cKkqhnIi6jPTpb6sq928r0kFfoBNEL/Dz1l03CkN5sIIIMW
         AtHGDRTNI00ClSE7D9JA3iLIlR820EhEgsi2ZDhQPS7Uf0ILKkUbMV4pq07flkz9zYvH
         Mp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2nTkX6uH7D9JnB8tG0aWoc/T91dLcJApINTMfwczCzE=;
        fh=Tv+o4Ex8+nKuY76E726Phd5ZaB5T8USocK1jNONzz8o=;
        b=fwOb5+SpwoDn1BJ7599G/f3dpcN3idBIFoVnvSoHy9JJ1RKvx6wtsA+y03VBJKBy0X
         iQWgB3C+Dnz3ytq+5M8Q4LtHRCkt83jbWJWNUoJGReIUf6G9t17cXk2aktNnQVqnMQN1
         96668pqzoR6Gjjt8dJHEq9XCrTdf8Ipu1cPrWiMHpii8XvCIpcRfyFHOSlN9LDAxZkGh
         tIokEQpM+jxNmswZc9BtarNvMMhW3qZUrPYGEtz+KHc/M56pmiaeherLDxbspiLWtMfx
         R6R840dyFsSCyKAmiHI7Mw88v7yIHWutqtAcdXgqexrDqzIHaC11MJ9QgiYS2kLxTzb7
         X4Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772328427; x=1772933227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nTkX6uH7D9JnB8tG0aWoc/T91dLcJApINTMfwczCzE=;
        b=D3834TrT04UUSxj88QU4d8eJWKZtMGNzfPpd6mrTPu7ik0pf0F7M6fcYlupU/0V3xp
         iW0P/JehpoLtIEs7tw/3XsvdsW0vzdNBP9R6oe6nlyIrRELRwgCSY0BhfJT2W5ipgIOB
         wjZ4SZBET5m1t38I5ew6P23P53TmhiNPyDpsUwmKnlPuTsCTenJQuaE+S5qSt2/95lPx
         PE79DCsioCSJzbPyQPsrqTIIv7teBSX4V6WGsL0kl09QzlXFMDTEaFt/c2xxmG/8+LEv
         WxCHN+TmIHv636AxT5G4mHHZ+RVK/fkNDaf9NdYU54L4W+Pjs8VOU8ibzXJEKA8wMbdo
         wyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772328427; x=1772933227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2nTkX6uH7D9JnB8tG0aWoc/T91dLcJApINTMfwczCzE=;
        b=ptE4OOM27ASZl8rCaIipSRYzXyXc0F6891T+ubmnwvOB9y8R8JZrd5ZbZgHpENGKSe
         g82lF9Z78aNha/ycrxrdxV5jXyVuh6KAflSLSiAvGeZVcHxjmvc4Y1zSNZs+UCHFnSmk
         ZHQLXYcnr5LJUnqKYjMBUrgIP6NyXVhCom1n10p3eP5BW80ZW7CiFL34/lwNfbSUHBjA
         EHNg92aJ9s9omj/sKeZ0XbSbyWio7vYiupv9/Yr9QjZ9v6xGWuXm7WovqvgfghRa3WAc
         8SFOxKj72ie+e3DkkGm8xwp6VjCIUOCUyapQ9uosejohLWvCw7M/I+lxZDQ8/hZgOI1o
         k9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVSpWAbVndoA0JYnMJX5xkCjUPfFayf4cxAoJda/Zeek1mVlZplynCsK24heV6nT/oio1MNVg2l32eOVuRrzZxG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81jxZl8C9wQ7zOt1cT2TjazGJDFmms8+1o6LaCnWooKp2fPVQ
	PFhaJhsliBufZneGoosVLuh42CqSwFYfca2xCG9ftMMcilzxGkJiq1HtbDshk4rRYRfo1BcdR9K
	XpwsrcPE7eiP1w74mJ4GZO6K3IvrfE5dap7pZGGFt
X-Gm-Gg: ATEYQzwrVbhsWqvIM5DWg9zMkgf+mKydE8pNpe7vOArgWwD5ualA6E44QrVipppVMhv
	+UuiNZ6o0e2x9JpqxsbLsD/ENbXuRTSU71vHIjdZL0bPIamyPJ/eAMQZwxOPvlTrcsxC08IFcVm
	mKKotHHawr2drlK32qvEa2k5X7MOxnvVQhu67eVcaopeLJ/W8vVMTH7czH9iEeg42flSu+lZ5Sl
	11eflnSLQcMkTEctmi722QzpVT8z6PK3ViSsfm5ki9GfTex62h9ZTUIrxITR7yNY2WNynfB639X
	Rhg9f+io
X-Received: by 2002:a17:902:ea07:b0:2ad:6f9b:3b2d with SMTP id
 d9443c01a7336-2ae397988b5mr1970765ad.22.1772328426318; Sat, 28 Feb 2026
 17:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227111340.1019144-1-changbin.du@huawei.com> <4d226c6fdba8420a87fa27ea5e6520b5@huawei.com>
In-Reply-To: <4d226c6fdba8420a87fa27ea5e6520b5@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 28 Feb 2026 17:26:54 -0800
X-Gm-Features: AaiRm52SJHGZYjs_l54RgzS1Yjw0xbVg9TRsGP0XNuMQPQs6DXJBa12WLR5M0r4
Message-ID: <CAP-5=fUr7V7=5CPyW2qm+m6B3NNYqvJ46pKvqQpn4kwWgMzOZQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Add match_mode support for --symfs option
To: duchangbin <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 2:06=E2=80=AFAM duchangbin <changbin.du@huawei.com>=
 wrote:
>
> After careful consideration, naming the new option as 'layout' is more
> appropriate than 'match_mode', as it better aligns with the conventions
> of technical terminology.
>
> I'll send patch V2 for this change.

Sgtm, some nits below.

> On Fri, Feb 27, 2026 at 11:13:40AM +0000, Changbin Du wrote:
> > Add support for parsing an optional match_mode parameter in the --symfs
> > command line option. The format is:
> >
> >   --symfs <directory[,match_mode]>
> >
> > Where match_mode can be:
> >   - 'path': matches full path (default)
> >   - 'basename': only matches base name
> >
> > When debugging symbol files from a copy of the filesystem (e.g., from a
> > container or remote machine), the debug files are often stored in a
> > flat directory structure with only filenames, not the full original
> > paths. In this case, using 'basename' mode allows perf to find debug
> > symbols by matching only the filename rather than the full path.
> >
> > For example, given a binary path like:
> >   /build/output/lib/foo.so
> >
> > With
> > $ perf report --symfs /debug/files,basename
> >
> > perf will look for:
> >   /debug/files/foo.so
> >
> > Instead of:
> >   /debug/files/build/output/lib/foo.so
> >
> > This is particularly useful when:
> > - Extracting debug files from containers with different directory layou=
ts
> > - Using pre-processed debug file collections (e.g., debugfgs)
> > - Working with build systems that flatten directory structures
> >
> > Changes:
> > - Add symfs_match_basename field to symbol_conf struct.
> > - Parse optional match_mode in symbol__config_symfs().
> > - Modify __symbol__join_symfs() to use basename() when match_mode
> >   is 'basename'.
> > - Update documentation in Documentation/ folder.
> >
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/Documentation/perf-annotate.txt  |  7 +++--
> >  tools/perf/Documentation/perf-diff.txt      |  7 +++--
> >  tools/perf/Documentation/perf-kwork.txt     |  7 +++--
> >  tools/perf/Documentation/perf-probe.txt     |  6 ++++
> >  tools/perf/Documentation/perf-report.txt    |  7 +++--
> >  tools/perf/Documentation/perf-sched.txt     |  7 +++--
> >  tools/perf/Documentation/perf-script.txt    |  7 +++--
> >  tools/perf/Documentation/perf-timechart.txt |  7 +++--
> >  tools/perf/Documentation/tips.txt           |  3 +-
> >  tools/perf/builtin-annotate.c               |  3 +-
> >  tools/perf/builtin-diff.c                   |  3 +-
> >  tools/perf/builtin-kwork.c                  |  4 +--
> >  tools/perf/builtin-probe.c                  |  4 +--
> >  tools/perf/builtin-report.c                 |  3 +-
> >  tools/perf/builtin-sched.c                  |  4 +--
> >  tools/perf/builtin-script.c                 |  3 +-
> >  tools/perf/builtin-timechart.c              |  3 +-
> >  tools/perf/util/symbol.c                    | 34 ++++++++++++++++++---
> >  tools/perf/util/symbol.h                    | 18 +++++++++++
> >  tools/perf/util/symbol_conf.h               |  1 +
> >  20 files changed, 103 insertions(+), 35 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Do=
cumentation/perf-annotate.txt
> > index 547f1a268018..f064cab431db 100644
> > --- a/tools/perf/Documentation/perf-annotate.txt
> > +++ b/tools/perf/Documentation/perf-annotate.txt
> > @@ -110,8 +110,11 @@ include::itrace.txt[]
> >       Interleave source code with assembly code. Enabled by default,
> >       disable with --no-source.
> >
> > ---symfs=3D<directory>::
> > -        Look for files with symbols relative to this directory.
> > +--symfs=3D<directory[,match_mode]>::
> > +        Look for files with symbols relative to this directory. The op=
tional
> > +        match_mode can be 'path' (default, matches full path) or 'base=
name'
> > +        (only matches base name). This is useful when debug files are =
stored
> > +        in a flat directory structure.
> >
> >  -M::
> >  --disassembler-style=3D:: Set disassembler style for objdump.
> > diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Docume=
ntation/perf-diff.txt
> > index 58efab72d2e5..5a46f97e2688 100644
> > --- a/tools/perf/Documentation/perf-diff.txt
> > +++ b/tools/perf/Documentation/perf-diff.txt
> > @@ -81,8 +81,11 @@ OPTIONS
> >  --force::
> >          Don't do ownership validation.
> >
> > ---symfs=3D<directory>::
> > -        Look for files with symbols relative to this directory.
> > +--symfs=3D<directory[,match_mode]>::
> > +        Look for files with symbols relative to this directory. The op=
tional
> > +        match_mode can be 'path' (default, matches full path) or 'base=
name'
> > +        (only matches base name). This is useful when debug files are =
stored
> > +        in a flat directory structure.
> >
> >  -b::
> >  --baseline-only::
> > diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Docum=
entation/perf-kwork.txt
> > index 21e607669d78..3b7a8adf4b74 100644
> > --- a/tools/perf/Documentation/perf-kwork.txt
> > +++ b/tools/perf/Documentation/perf-kwork.txt
> > @@ -169,8 +169,11 @@ OPTIONS for 'perf kwork timehist'
> >  --max-stack::
> >       Maximum number of functions to display in backtrace, default 5.
> >
> > ---symfs=3D<directory>::
> > -    Look for files with symbols relative to this directory.
> > +--symfs=3D<directory[,match_mode]>::
> > +        Look for files with symbols relative to this directory. The op=
tional
> > +        match_mode can be 'path' (default, matches full path) or 'base=
name'
> > +        (only matches base name). This is useful when debug files are =
stored
> > +        in a flat directory structure.
> >
> >  --time::
> >       Only analyze samples within given time window: <start>,<stop>. Ti=
mes
> > diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Docum=
entation/perf-probe.txt
> > index 5c43a6edc0e5..1d754c2a5736 100644
> > --- a/tools/perf/Documentation/perf-probe.txt
> > +++ b/tools/perf/Documentation/perf-probe.txt
> > @@ -50,6 +50,12 @@ OPTIONS
> >  --source=3DPATH::
> >       Specify path to kernel source.
> >
> > +--symfs=3D<directory[,match_mode]>::
> > +     Look for files with symbols relative to this directory. The optio=
nal
> > +     match_mode can be 'path' (default, matches full path) or 'basenam=
e'
> > +     (only matches base name). This is useful when debug files are sto=
red
> > +     in a flat directory structure.
> > +
> >  -v::
> >  --verbose::
> >          Be more verbose (show parsed arguments, etc).
> > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Docu=
mentation/perf-report.txt
> > index acef3ff4178e..ff5ec9a15040 100644
> > --- a/tools/perf/Documentation/perf-report.txt
> > +++ b/tools/perf/Documentation/perf-report.txt
> > @@ -368,8 +368,11 @@ OPTIONS
> >  --force::
> >          Don't do ownership validation.
> >
> > ---symfs=3D<directory>::
> > -        Look for files with symbols relative to this directory.
> > +--symfs=3D<directory[,match_mode]}::
> > +        Look for files with symbols relative to this directory. The op=
tional
> > +        match_mode can be 'path' (default, matches full path) or 'base=
name'
> > +        (only matches base name). This is useful when debug files are =
stored
> > +        in a flat directory structure.
> >
> >  -C::
> >  --cpu:: Only report samples for the list of CPUs provided. Multiple CP=
Us can
> > diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Docum=
entation/perf-sched.txt
> > index 4d9981609c04..5c17bc11556e 100644
> > --- a/tools/perf/Documentation/perf-sched.txt
> > +++ b/tools/perf/Documentation/perf-sched.txt
> > @@ -437,8 +437,11 @@ OPTIONS for 'perf sched timehist'
> >      Show all scheduling events followed by a summary by thread with mi=
n,
> >      max, and average run times (in sec) and relative stddev.
> >
> > ---symfs=3D<directory>::
> > -    Look for files with symbols relative to this directory.
> > +--symfs=3D<directory[,match_mode]>::
> > +        Look for files with symbols relative to this directory. The op=
tional
> > +        match_mode can be 'path' (default, matches full path) or 'base=
name'
> > +        (only matches base name). This is useful when debug files are =
stored
> > +        in a flat directory structure.
> >
> >  -V::
> >  --cpu-visual::
> > diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docu=
mentation/perf-script.txt
> > index ddf92f9c7821..be5b1835330f 100644
> > --- a/tools/perf/Documentation/perf-script.txt
> > +++ b/tools/perf/Documentation/perf-script.txt
> > @@ -307,8 +307,11 @@ OPTIONS
> >  --kallsyms=3D<file>::
> >          kallsyms pathname
> >
> > ---symfs=3D<directory>::
> > -        Look for files with symbols relative to this directory.
> > +--symfs=3D<directory[,match_mode]>::
> > +        Look for files with symbols relative to this directory. The op=
tional
> > +        match_mode can be 'path' (default, matches full path) or 'base=
name'
> > +        (only matches base name). This is useful when debug files are =
stored
> > +        in a flat directory structure.
> >
> >  -G::
> >  --hide-call-graph::
> > diff --git a/tools/perf/Documentation/perf-timechart.txt b/tools/perf/D=
ocumentation/perf-timechart.txt
> > index ef2281c56743..bb1e9325638e 100644
> > --- a/tools/perf/Documentation/perf-timechart.txt
> > +++ b/tools/perf/Documentation/perf-timechart.txt
> > @@ -53,8 +53,11 @@ TIMECHART OPTIONS
> >  -f::
> >  --force::
> >       Don't complain, do it.
> > ---symfs=3D<directory>::
> > -        Look for files with symbols relative to this directory.
> > +--symfs=3D<directory[,match_mode]>::
> > +        Look for files with symbols relative to this directory. The op=
tional
> > +        match_mode can be 'path' (default, matches full path) or 'base=
name'
> > +        (only matches base name). This is useful when debug files are =
stored
> > +        in a flat directory structure.
> >  -n::
> >  --proc-num::
> >          Print task info for at least given number of tasks.
> > diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentati=
on/tips.txt
> > index 3fee9b2a88ea..268316596ba0 100644
> > --- a/tools/perf/Documentation/tips.txt
> > +++ b/tools/perf/Documentation/tips.txt
> > @@ -11,7 +11,8 @@ Search options using a keyword: perf report -h <keywo=
rd>
> >  Use parent filter to see specific call path: perf report -p <regex>
> >  List events using substring match: perf list <keyword>
> >  To see list of saved events and attributes: perf evlist -v
> > -Use --symfs <dir> if your symbol files are in non-standard locations
> > +Use --symfs <dir>[,basename] if your symbol files are in non-standard =
locations.
> > + Use ',basename' when debug files are in a flat directory structure.

Should the documentation also mention ",path" ?

> >  To see callchains in a more compact form: perf report -g folded
> >  To see call chains by final symbol taking CPU time (bottom up) use per=
f report -G
> >  Show individual samples with: perf script
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotat=
e.c
> > index 9c27bb30b708..f4ce70998423 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -744,8 +744,7 @@ int cmd_annotate(int argc, const char **argv)
> >                       &annotate.group_set,
> >                       "Show event group information together"),
> >       OPT_STRING('C', "cpu", &annotate.cpu_list, "cpu", "list of cpus t=
o profile"),
> > -     OPT_CALLBACK(0, "symfs", NULL, "directory",
> > -                  "Look for files with symbols relative to this direct=
ory",
> > +     OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HE=
LP,
> >                    symbol__config_symfs),
> >       OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
> >                   "Interleave source code with assembly code (default)"=
),
> > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > index 59bf1f72d12e..7b7cc3c80dfd 100644
> > --- a/tools/perf/builtin-diff.c
> > +++ b/tools/perf/builtin-diff.c
> > @@ -1280,8 +1280,7 @@ static const struct option options[] =3D {
> >       OPT_STRING_NOEMPTY('t', "field-separator", &symbol_conf.field_sep=
, "separator",
> >                  "separator for columns, no spaces will be added betwee=
n "
> >                  "columns '.' is reserved."),
> > -     OPT_CALLBACK(0, "symfs", NULL, "directory",
> > -                  "Look for files with symbols relative to this direct=
ory",
> > +     OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HE=
LP,
> >                    symbol__config_symfs),
> >       OPT_UINTEGER('o', "order", &sort_compute, "Specify compute sortin=
g."),
> >       OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
> > diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> > index 7f3068264568..838471edb9e5 100644
> > --- a/tools/perf/builtin-kwork.c
> > +++ b/tools/perf/builtin-kwork.c
> > @@ -2423,8 +2423,8 @@ int cmd_kwork(int argc, const char **argv)
> >                   "Display call chains if present"),
> >       OPT_UINTEGER(0, "max-stack", &kwork.max_stack,
> >                  "Maximum number of functions to display backtrace."),
> > -     OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
> > -                 "Look for files with symbols relative to this directo=
ry"),
> > +     OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HE=
LP,
> > +                  symbol__config_symfs),
> >       OPT_STRING(0, "time", &kwork.time_str, "str",
> >                  "Time span for analysis (start,stop)"),
> >       OPT_STRING('C', "cpu", &kwork.cpu_list, "cpu",
> > diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> > index 1b4ba85ee019..e2912217153a 100644
> > --- a/tools/perf/builtin-probe.c
> > +++ b/tools/perf/builtin-probe.c
> > @@ -597,8 +597,8 @@ __cmd_probe(int argc, const char **argv)
> >       OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
> >                   "Enable kernel symbol demangling"),
> >       OPT_BOOLEAN(0, "cache", &probe_conf.cache, "Manipulate probe cach=
e"),
> > -     OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
> > -                "Look for files with symbols relative to this director=
y"),
> > +     OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HE=
LP,
> > +                  symbol__config_symfs),
> >       OPT_CALLBACK(0, "target-ns", NULL, "pid",
> >                    "target pid for namespace contexts", opt_set_target_=
ns),
> >       OPT_BOOLEAN(0, "bootconfig", &probe_conf.bootconfig,
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 3b81f4b3dc49..e0d81a8cc3bb 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1416,8 +1416,7 @@ int cmd_report(int argc, const char **argv)
> >                  "columns '.' is reserved."),
> >       OPT_BOOLEAN('U', "hide-unresolved", &symbol_conf.hide_unresolved,
> >                   "Only display entries resolved to a symbol"),
> > -     OPT_CALLBACK(0, "symfs", NULL, "directory",
> > -                  "Look for files with symbols relative to this direct=
ory",
> > +     OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HE=
LP,
> >                    symbol__config_symfs),
> >       OPT_STRING('C', "cpu", &report.cpu_list, "cpu",
> >                  "list of cpus to profile"),
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 3f509cfdd58c..741e9894490c 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -4879,8 +4879,8 @@ int cmd_sched(int argc, const char **argv)
> >                   "Display call chains if present (default on)"),
> >       OPT_UINTEGER(0, "max-stack", &sched.max_stack,
> >                  "Maximum number of functions to display backtrace."),
> > -     OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
> > -                 "Look for files with symbols relative to this directo=
ry"),
> > +     OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HE=
LP,
> > +                  symbol__config_symfs),
> >       OPT_BOOLEAN('s', "summary", &sched.summary_only,
> >                   "Show only syscall summary with statistics"),
> >       OPT_BOOLEAN('S', "with-summary", &sched.summary,
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 7c743a303507..4fe79971c97f 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -4074,8 +4074,7 @@ int cmd_script(int argc, const char **argv)
> >                  "file", "kallsyms pathname"),
> >       OPT_BOOLEAN('G', "hide-call-graph", &no_callchain,
> >                   "When printing symbols do not display call chain"),
> > -     OPT_CALLBACK(0, "symfs", NULL, "directory",
> > -                  "Look for files with symbols relative to this direct=
ory",
> > +     OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HE=
LP,
> >                    symbol__config_symfs),
> >       OPT_CALLBACK('F', "fields", NULL, "str",
> >                    "comma separated output fields prepend with 'type:'.=
 "
> > diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timech=
art.c
> > index f8b49d69e9a5..b071c66b8dc4 100644
> > --- a/tools/perf/builtin-timechart.c
> > +++ b/tools/perf/builtin-timechart.c
> > @@ -1951,8 +1951,7 @@ int cmd_timechart(int argc, const char **argv)
> >       OPT_CALLBACK('p', "process", NULL, "process",
> >                     "process selector. Pass a pid or process name.",
> >                      parse_process),
> > -     OPT_CALLBACK(0, "symfs", NULL, "directory",
> > -                  "Look for files with symbols relative to this direct=
ory",
> > +     OPT_CALLBACK(0, "symfs", NULL, "directory[,match_mode]", SYMFS_HE=
LP,
> >                    symbol__config_symfs),
> >       OPT_INTEGER('n', "proc-num", &tchart.proc_num,
> >                   "min. number of tasks to print"),
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 8662001e1e25..0cafa6e630e8 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -66,6 +66,7 @@ struct symbol_conf symbol_conf =3D {
> >       .time_quantum           =3D 100 * NSEC_PER_MSEC, /* 100ms */
> >       .show_hist_headers      =3D true,
> >       .symfs                  =3D "",
> > +     .symfs_match_basename   =3D false,
> >       .event_group            =3D true,
> >       .inline_name            =3D true,
> >       .res_sample             =3D 0,
> > @@ -2491,16 +2492,41 @@ int symbol__config_symfs(const struct option *o=
pt __maybe_unused,
> >                        const char *dir, int unset __maybe_unused)
> >  {
> >       char *bf =3D NULL;
> > +     char *match_mode_str;
> >       int ret;
> >
> > -     symbol_conf.symfs =3D strdup(dir);
> > -     if (symbol_conf.symfs =3D=3D NULL)
> > -             return -ENOMEM;
> > +     match_mode_str =3D strchr(dir, ',');

I wonder if using `strstr` or `ends_with` for ",basename" and ",path"
would work better than `strchr` for ','. That way if a path contains a
comma (which is very unusual), the old behavior will happen.

Thanks,
Ian

> > +     if (match_mode_str) {
> > +             size_t dir_len =3D match_mode_str - dir;
> > +             char *dir_copy =3D strndup(dir, dir_len);
> > +
> > +             if (dir_copy =3D=3D NULL)
> > +                     return -ENOMEM;
> > +
> > +             symbol_conf.symfs =3D dir_copy;
> > +
> > +             match_mode_str++;
> > +             if (!strcmp(match_mode_str, "basename"))
> > +                     symbol_conf.symfs_match_basename =3D true;
> > +             else if (!strcmp(match_mode_str, "path"))
> > +                     symbol_conf.symfs_match_basename =3D false;
> > +             else {
> > +                     pr_err("Invalid match_mode: '%s', use 'path' or '=
basename'\n",
> > +                            match_mode_str);
> > +                     free(dir_copy);
> > +                     return -EINVAL;
> > +             }
> > +     } else {
> > +             symbol_conf.symfs =3D strdup(dir);
> > +             if (symbol_conf.symfs =3D=3D NULL)
> > +                     return -ENOMEM;
> > +             symbol_conf.symfs_match_basename =3D false;
> > +     }
> >
> >       /* skip the locally configured cache if a symfs is given, and
> >        * config buildid dir to symfs/.debug
> >        */
> > -     ret =3D asprintf(&bf, "%s/%s", dir, ".debug");
> > +     ret =3D asprintf(&bf, "%s/%s", symbol_conf.symfs, ".debug");
> >       if (ret < 0)
> >               return -ENOMEM;
> >
> > diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> > index 3fb5d146d9b1..5afac63d5e06 100644
> > --- a/tools/perf/util/symbol.h
> > +++ b/tools/perf/util/symbol.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/list.h>
> >  #include <linux/rbtree.h>
> >  #include <stdio.h>
> > +#include <errno.h>
> >  #include "addr_location.h"
> >  #include "path.h"
> >  #include "symbol_conf.h"
> > @@ -96,6 +97,18 @@ struct intlist;
> >
> >  static inline int __symbol__join_symfs(char *bf, size_t size, const ch=
ar *path)
> >  {
> > +     if (symbol_conf.symfs_match_basename) {
> > +             char *path_copy =3D strdup(path);
> > +             char *base;
> > +             int ret;
> > +
> > +             if (!path_copy)
> > +                     return -ENOMEM;
> > +             base =3D basename(path_copy);
> > +             ret =3D path__join(bf, size, symbol_conf.symfs, base);
> > +             free(path_copy);
> > +             return ret;
> > +     }
> >       return path__join(bf, size, symbol_conf.symfs, path);
> >  }
> >
> > @@ -169,6 +182,11 @@ size_t symbol__fprintf_symname(const struct symbol=
 *sym, FILE *fp);
> >  size_t symbol__fprintf(struct symbol *sym, FILE *fp);
> >  bool symbol__restricted_filename(const char *filename,
> >                                const char *restricted_filename);
> > +
> > +#define SYMFS_HELP "setup root directory which contains debug files:\n=
" \
> > +     "\t\t\t\t" "directory:\tLook for files with symbols relative to t=
his directory.\n" \
> > +     "\t\t\t\t" "match_mode:\tMode to match files, 'path' matches full=
 path (default), 'basename' only matches base name.\n"
> > +
> >  int symbol__config_symfs(const struct option *opt __maybe_unused,
> >                        const char *dir, int unset __maybe_unused);
> >
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_con=
f.h
> > index 71bb17372a6c..39c4425d51ea 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -93,6 +93,7 @@ struct symbol_conf {
> >                       *tid_list,
> >                       *addr_list;
> >       const char      *symfs;
> > +     bool            symfs_match_basename;
> >       int             res_sample;
> >       int             pad_output_len_dso;
> >       int             group_sort_idx;
> > --
> > 2.43.0
> >
>
> --
> Cheers,
> Changbin Du
