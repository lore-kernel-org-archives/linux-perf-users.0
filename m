Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4B179A3
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615548; cv=none; b=syTUlKQY25fl1vJCnAgemlux0+aEnudwzJRWKKnHNPs2R1zOEdKrEoCAO0/w2XPHArt5thIEMTs3gxAdBZ3wPKBGOR9HbKycAusJyp4/vS0JNX3IvsCnbrNRdv7jFUX8Xi59UuEW3ZyQkr5KoIKJYhUH/fK5ntRfgKP9LbDzUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615548; c=relaxed/simple;
	bh=vkLE3ThAcRnXVsMhuA6mAajRU1E+VMOLAEmdSVnfxH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhzOaDZqUaVLhLuQOZQcr0gae6TPQccYDvtRGi9oPD3LLT5o1LoL5eLw0l+MULDY8WqYK4qhyFdTyag2sgHSjmXwiAtbFSR1VSKEuXtTeVtkoeacIMI9E2rRPJS9cHJL/ccriHPI4m9LI3ahXIw213gWqEfYMr/keQ+rif03l6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+MamYn0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+MamYn0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43dfe020675so808761cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715615546; x=1716220346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab6Pb1Zn+PdwPKJ9a5mXYGSOH8gBv7qhSD/WUjQgp8s=;
        b=F+MamYn0MdnBJXObBkqQnXQ4RCnjFunhfr06c/0pUakX23/zt2o6zMXFOXgfAai8/G
         7tkbfOsxfSlqOM8ssZscPPwqneKRuOJysSibWyAHqRn2jZt6fBjqYxrUpLTY0rNGXnjE
         oNLQZrjUByafq+mHyvF66ceGWEMGaOOzGsWJiIZMhsUULSY+q2o2gymM/BCbvDajVjLT
         GsoctfbaIZwGeYr5nItl9D1g4S/zz4bZLGWFCx1i6/uX0t98sA0UZd2/0u0rHoEmNv7h
         96biPQ2zyShMr0Y8R9H3Tsm5HxKOL3ud+1KyMzeY/S9bpNj9JiNwK38kVVsOP9Xt+Ggg
         UJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615546; x=1716220346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab6Pb1Zn+PdwPKJ9a5mXYGSOH8gBv7qhSD/WUjQgp8s=;
        b=hsjCjnVRKqDxWJHCK3KUt/jpDvvbcGJUrdJUTFPn7ETDZL/p4lrk5MmdGa2Z3iOWhz
         bjgJQ9JM2U9VpVnAFK8E3rLLpxZS5tYUeEMqnDEt+3CWYN+BvCs1Vs9lPzM3PGN5i42g
         w8WzK+V8b0eBSAuGbrfgu11F/gPh8z0QSIuLi/OzbXe0E6jw28DcEpzMxFUcNqF/739S
         XalGy6olQ+E4ug3X2Bwa1wk/lRku4aRXto4MX0UshFrHQU+FFio3PtoNSaLg/N234ru4
         nCzFoS1W//cRkhiQa/DmxcztDK1JJnZCk46L8mavaw/lswbxy4yRmGvksX36vvh0RDID
         i+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVhRXG60zk8dHPXOWM1DUBerA3jItv/qdHl/arrrEI6VscNczJUPFaZRKuG8hIZaNZOTAH9XKEkM6xRxKhMOkC8qjKq6faYwNY+cZeBMLyhMA==
X-Gm-Message-State: AOJu0Yy/TrkmoOX9SLTmw2m+1aq39/SKI7Jg7LKun4ndzRwntzDL6Qtg
	KNIs3BnvtCJ14z5CmZJ9cSNiE7L8Zdpmm0p8R/5OfAyJtTBWfjHQ0Ef0HJgslFgP9qd38y5AM1E
	yYKnfBm5UccjBLXNJB9YVknccdLWwVLIQWRLR
X-Google-Smtp-Source: AGHT+IFfwR81J/neIzXou87W+GV66GTPQOziuMfR6JAYbFA1015p3P3pBkkVmrfr+CcMuqrdlZNaiXRao+YFaGuMwyw=
X-Received: by 2002:a05:622a:a490:b0:43e:e09:d346 with SMTP id
 d75a77b69052e-43e0e09d358mr2510511cf.5.1715615545425; Mon, 13 May 2024
 08:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjssGrj+abyC6mYP@gmail.com> <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com>
In-Reply-To: <ZkG4LWr7w11wQ/PR@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 08:52:13 -0700
Message-ID: <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 11:50=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Ian Rogers <irogers@google.com> wrote:
>
> > On Wed, May 8, 2024 at 12:39=E2=80=AFAM Ingo Molnar <mingo@kernel.org> =
wrote:
> > >
> > >
> > > So I've been getting this perf build failure for some time:
> > >
> > >   kepler:~/tip/tools/perf> make clean
> > >   Makefile.perf:1149: *** Missing bpftool input for generating vmlinu=
x.h.  Stop.
> > >   make: *** [Makefile:90: clean] Error 2
> > >
> > > ... but if I clone a new repository, it works fine, until a point.
> > >
> > > 'make clean' doesn't work - and 'make mrproper' in the main kernel
> > > directory doesn't clean up properly.
> > >
> > > Only if I do a brute-force:
> > >
> > >         rm -rf tools/
> > >         git checkout HEAD -f
> > >
> > > does it get resolved.
> > >
> > > The failure condition triggers if I Ctrl-C the following build a coup=
le of
> > > times, without it being finished:
> > >
> > >
> > >    cd tools/perf; make clean install
> > >    ...
> > >
> > >    LD      util/perf-in.o
> > >    LD      perf-in.o
> > >    CC      pmu-events/pmu-events.o
> > >  ^Cmake[3]: *** [pmu-events/Build:43: pmu-events/pmu-events.o] Interr=
upt
> > >  make[2]: *** [Makefile.perf:709: pmu-events/pmu-events-in.o] Interru=
pt
> > >  make[1]: *** [Makefile.perf:264: sub-make] Interrupt
> > >  make: *** [Makefile:113: install] Interrupt
> > >  kepler:~/tip> perfi
> > >  Makefile.perf:1149: *** Missing bpftool input for generating vmlinux=
.h.  Stop.
> > >  make: *** [Makefile:90: clean] Error 2
> >
> > We have a checked-in vmlinux.h:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/bpf_skel/vmlinux/vmlinux.h?h=3Dperf-tools-next
> > so this shouldn't have been a problem for a while. bpftool is no
> > longer on that line:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n1149
> > so I suspect if you use a newer tree then things will work.
>
> Was this regression fix propagated to v6.9 in time?

We switched to using the handwritten file in v6.4:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/t=
ools/perf/util/bpf_skel/vmlinux.h?id=3Da887466562b425bd6183bf75b523c1477c9f=
d22d

Thanks,
Ian

> Thanks,
>
>         Ingo
