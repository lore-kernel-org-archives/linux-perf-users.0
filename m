Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462F8562A
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Apr 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537671; cv=none; b=FeGNWQmVflsBTwBP/sSGan45bhl3AhU/D+3sFIgHrOCU1MK3r9MZ1Ytf+j+0BxYTt79bkxHJZ2lEo6KQYLZEl0hMTvakjsGN++00wSMictikwORUbPmf147MmYdWPd6PuhD7YmCS1d7n2+rAxyMcvzOtBq5C6w0+GMF5QjihvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537671; c=relaxed/simple;
	bh=0ZVcZLmguVwwsrcLmuRwvIm+QXIMZti0ZQqnj8tsLm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVsdwMG5idhSt4odM2x+V4gV/MvhMayRS9GupQ+0ayi6qITIwcmSTvAVpLOVJEr8+ofo2SSX1eJ3q2Rc/VC6cpBIe+roCr3Ncn6238b4v14uLSLO8cv0llCKr5ebxpE9Fz3CnsTyHFzXDsx+ARYcClPOTGuocmlrbjhA8vsUqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkD10Zur; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkD10Zur"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4348110e888so275221cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Apr 2024 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713537669; x=1714142469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+5NRO0keNj748cHc56gDHYVamniP4PzKmCJTJlGNYs=;
        b=gkD10ZurYRHwHpNEl8H0WGsWTYrvzO+LMg2bcVPoJ3Mws1nFfuvHlrDjA+tV6gD93N
         SgRrol4fUcbbkFMhKqFOdFwQh3LCKXk0mVpv9tku4qzDaJ8VRlrzIc/fmpDSG2xNyxrA
         Tl09P1S2/JyJJ8ZFeG7Aqr0FbRUEKDNvussTMzs7JRa+ZTk2qxyDLS3IcKBB4Scls+6Z
         tIwgbbXBnk8F2onUpns0UQq5jmx3ybb63e92j5Z1zCdeNxozfNFurDirBsgdBeeBlArh
         7KJQwG2TFjmhkdQN1DHIL2Vh/la0oj8H0FVOQ4ZpL97a08LVbRrswBtRwuJkAUxJQddt
         aOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713537669; x=1714142469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+5NRO0keNj748cHc56gDHYVamniP4PzKmCJTJlGNYs=;
        b=q3Thw+oL+hPc8bV3ZBlWBndUiDcz25VzdFZGZHYmZ5rltd01v8Z7CiXaiNFmxnPb1L
         Z2inNoGn8tFLemQlhxJoFKCNrJKMO63/t6oh415bAodoUmix43I7vX5gRqqwYPb5QoW8
         N75ic+dhm3QRCiO4LGxr5YNoZ4XuycPnv+pZt5QKSah2kScBkoQyQ94mqCDra83FyLzu
         GRAITZ/5tQHFgpNylc6Zo+QLWIRN3Kev7HDXNP2vHwPlcU/SeKRxWETrOZUVL+BmoNqE
         l3IySrxkrKznNttiHaE2eRmZG12HiINU2Ksba8oxOxZnaLw8B3CzPp1kSXryte44Klsa
         L33Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSFwyP5NxqXM+Yw9yTjlOSzsSidaNHcYFh/Zl/Pp9G1T5PIJuxYvCALlckZQiX88BclWzh71uaVxAjR2oGFcc/AtEeWTDlw2CXfMrsMXFOzA==
X-Gm-Message-State: AOJu0YyabFLtSsuakuFz+GzacRUEIPHRlASse2uPMhDjpvQg0mP6B2PR
	SV63IkQ11kzDb3PuHKYx2NSoHSb/cxPm4/EzuOorI3qyhx2m58SO5msBAVDl7ikHyjvaFkSHnSC
	llgjsamu4HAxe/FZ0v8xWz9u8mdpSFVBbfzto
X-Google-Smtp-Source: AGHT+IG4ZTggbnV0lF4zBdKYEyF+UCmLg/6TvY1ySQga5KDtXBVFH7NUVRJx3yKiVucvcOqTKDvdEKNsOGI97DzTjXE=
X-Received: by 2002:a05:622a:52:b0:437:9875:9671 with SMTP id
 y18-20020a05622a005200b0043798759671mr319114qtw.0.1713537669042; Fri, 19 Apr
 2024 07:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417183219.1208493-1-irogers@google.com> <c68bf005-af20-4995-86d5-a62e171763e3@linux.intel.com>
In-Reply-To: <c68bf005-af20-4995-86d5-a62e171763e3@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Apr 2024 07:40:54 -0700
Message-ID: <CAP-5=fUG_b6e9Q=qMFMtuKpzvz7D1xoLXNxeyfqwyX8qSsBwsg@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Avoid hard coded metrics in stat std output test
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 6:54=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-17 2:32 p.m., Ian Rogers wrote:
> > Hard coded metric names fail on ARM testing.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/stat+std_output.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tes=
ts/shell/stat+std_output.sh
> > index cbf2894b2c84..845f83213855 100755
> > --- a/tools/perf/tests/shell/stat+std_output.sh
> > +++ b/tools/perf/tests/shell/stat+std_output.sh
> > @@ -13,7 +13,7 @@ stat_output=3D$(mktemp /tmp/__perf_test.stat_output.s=
td.XXXXX)
> >
> >  event_name=3D(cpu-clock task-clock context-switches cpu-migrations pag=
e-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions=
 branches branch-misses)
> >  event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "=
frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "=
of all branches")
> > -skip_metric=3D("stalled cycles per insn" "tma_" "retiring" "frontend_b=
ound" "bad_speculation" "backend_bound")
> > +skip_metric=3D($(perf list --raw Default 2> /dev/null))
>
>
> The "perf list --raw Default" only gives the topdown metrics.
> The "stalled cycles per insn" is not covered.
> The check should skip the line of "stalled cycles per insn" as well.
>
>      3,856,436,920 stalled-cycles-frontend   #   74.09% frontend cycles i=
dle
>      1,600,790,871 stalled-cycles-backend    #   30.75% backend  cycles i=
dle
>      2,603,501,247 instructions              #    0.50  insns per cycle
>                                              #    1.48  stalled cycles
> per insn
>        484,357,498 branches                  #  283.455 M/sec
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/builtin-stat.c#n24
>
> The newer Intel CPU doesn't have the stalled-cycles-* events. But it
> seems power and older x86 CPU have the events.

Oh, sigh. This test should really ignore lines like that. How much do
we care about these metrics? The RISC-V event parsing change:
https://lore.kernel.org/lkml/20240416061533.921723-1-irogers@google.com/
means that legacy hardware events will be uncommon and we need to
adapt the hard coded metrics in stat-shadow.c to json ones. Once they
are json metrics they will be in Default.

Thanks,
Ian

> Thanks,
> Kan
>
> >
> >  cleanup() {
> >    rm -f "${stat_output}"
