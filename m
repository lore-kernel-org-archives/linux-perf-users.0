Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962716CD1E;
	Mon, 22 Jul 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670330; cv=none; b=IIimEIVbQ6FolNLX+x3solJu9nALSBmryZABozA8EpNCSimfmWoI2fPAkj7F9Exw9VyhGanWozwt18y5Fv2YlyXPUmLJe8mGbxLnXtiYRTt5FassarYY4X0uxRafbQPEkP8d7fruapGN2R0kKusJRfjw1jtu56OL+eiV+QrXJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670330; c=relaxed/simple;
	bh=CIBpkJsJvMIut/H/Mqv3n2ilagGDVLoPkrke7HVeLdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBVYXyscfnqrY821zGhiw4x4NDZD1Eh/het3NKySV3tKR9XDyvYW2JVGq1Jwio5EFp/rTDC4/IGMcpcDI+dWDNFUWJcq3j4BCzrDQwnMIKmKOM6GWZQdq0bfKpRetaLWS4xClVxHl4tISK+b4QWByhVp5xnaXyHMzGwuNy+grTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd640a6454so22375155ad.3;
        Mon, 22 Jul 2024 10:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721670328; x=1722275128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9NWGmlwOAkhOw72g0i8CpniZ7SsqAy6RdMTRvFCF/4=;
        b=GyDmv1wti8f9EnS6b+vKPzQxClrO2Ocb2cuQUge1ZHHa4oA0ygk+BS3FfYrOohVpFw
         YmVkDT77FmwTkgUfEa3PAd81Pw36mdR0GlzIA0xz705gXIBJt22zqrWM2KyqMfzxcg8L
         pFLa3Bygrp1kae9oAPKAjwJDPbZzvf48PLlO+ugBEutRGZyvgT3LQtIUmBup+4zIwmF/
         Rc8sJVWWA7Aqbm6adsia31Pu4ve+Nc+Spxw8rFOAYorXEVI13Yd2yKsX0HYtz2/qrUBa
         NXbJgIOSKKEZRpKUxDPTpeK5/Xs2QHSI9AWI2mEn6fKLx6WzSnMm+xiEM9wdHlx8DBIJ
         Ks/A==
X-Forwarded-Encrypted: i=1; AJvYcCVfqEi8A8WI3m8jbl9YsdVwFQr8Zy+PGB0Duyti39Jp3NNqudQfS7gGsJCXzd66lCkvcGcS49F4YNnOhqp0IhJ7Fgk9Yp00yjfQGlq5ZAuO6UiAITgVN0cjv2baoXaAIdZ7w2lp0SDu/0LLrfHtKA==
X-Gm-Message-State: AOJu0Ywg9WW5UWux1o2X2lCu6pLMHHiW74g5pZmYBf4X9CCWNU1e/BZ5
	JjabFf++sYZYAab4X9YFBUYqlMC3fetO0Nvon4YZPmzfGkiVxBqgd5Rm+QXxSBslMuqzrjN28sa
	rYkYuEmVR3n/MT2u/kKz4MBet4uo=
X-Google-Smtp-Source: AGHT+IE6ZHhsLriUqVudC7AnqFElq34Vxe3ooHvrEotr8dV3dnZYPjxESzu2nqTBWxYVXnkVqY5vA/INFTc/KwLZQqA=
X-Received: by 2002:a17:90a:7843:b0:2c9:7cf1:83a4 with SMTP id
 98e67ed59e1d1-2cd27434dcfmr3356286a91.20.1721670328064; Mon, 22 Jul 2024
 10:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com> <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
 <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
 <05fa0449-4fd4-41ed-93e8-db825e48268f@intel.com> <CAP-5=fU9riOR7onxCE3a2xOs_bVdQdTSkAHD5QLb=SO6SCzkzQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU9riOR7onxCE3a2xOs_bVdQdTSkAHD5QLb=SO6SCzkzQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Jul 2024 10:45:16 -0700
Message-ID: <CAM9d7cjbi_P+V=QkLFg6OuEJqmCOsOoDBddQbyhMYD3aF8do4g@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] Constify tool pointers
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Jul 22, 2024 at 1:29=E2=80=AFAM Adrian Hunter <adrian.hunter@inte=
l.com> wrote:
> >
> > On 19/07/24 19:26, Ian Rogers wrote:
> > > On Fri, Jul 19, 2024 at 1:51=E2=80=AFAM Adrian Hunter <adrian.hunter@=
intel.com> wrote:
> > >>
> > >> On 18/07/24 03:59, Ian Rogers wrote:
> > >>> struct perf_tool provides a set of function pointers that are calle=
d
> > >>> through when processing perf data. To make filling the pointers les=
s
> > >>> cumbersome, if they are NULL perf_tools__fill_defaults will add
> > >>> default do nothing implementations.
> > >>>
> > >>> This change refactors struct perf_tool to have an init function tha=
t
> > >>> provides the default implementation. The special use of NULL and
> > >>> perf_tools__fill_defaults are removed. As a consequence the tool
> > >>> pointers can then all be made const, which better reflects the
> > >>> behavior a particular perf command would expect of the tool and to
> > >>> some extent can reduce the cognitive load on someone working on a
> > >>> command.
> > >>>
> > >>> v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-b=
y.
> > >>
> > >> The tags were really meant only for patch 1, the email that was repl=
ied to.
> > >>
> > >> But now for patches 2 and 3:
> > >>
> > >> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > >
> > > Sorry for that, you'd mentioned that pt and bts testing which is
> > > impacted by more than just patch 1.
> > >
> > >> Looking at patches 4 to 25, they do not seem to offer any benefit.
> > >>
> > >> Instead of patch 26, presumably perf_tool__fill_defaults() could
> > >> be moved to __perf_session__new(), which perhaps would allow
> > >> patch 27 as it is.
> > >
> > > What I'm trying to do in the series is make it so that the tool isn't
> > > mutated during its use by session. Ideally we'd be passing a const
> > > tool to session_new, that's not possible because there's a hack to fi=
x
> > > ordered events and pipe mode in session__new:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/session.c?h=3Dperf-tools-next#n275
> > > Imo, it isn't great to pass a tool to session__new where you say you
> > > want ordered events and then session just goes to change that for you=
.
> > > Altering that behavior was beyond the scope of this clean up, so tool
> > > is only const after session__new.
> >
> > Seems like a separate issue.  Since the session is created
> > by __perf_session__new(), session->tool will always be a pointer
> > to a const tool once there is:
> >
> > diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> > index 7f69baeae7fb..7c8dd6956330 100644
> > --- a/tools/perf/util/session.h
> > +++ b/tools/perf/util/session.h
> > @@ -43,7 +43,7 @@ struct perf_session {
> >         u64                     one_mmap_offset;
> >         struct ordered_events   ordered_events;
> >         struct perf_data        *data;
> > -       struct perf_tool        *tool;
> > +       const struct perf_tool  *tool;
> >         u64                     bytes_transferred;
> >         u64                     bytes_compressed;
> >         struct zstd_data        zstd_data;
>
> That's the case after these changes, but not before.
>
> > >
> > > The reason for doing this is to make it so that when I have a tool I
> > > can reason that nobody is doing things to change it under my feet.
> >
> > It still can be changed by the caller of __perf_session__new(), since
> > the tool itself is not const.
> >
> > Anything using container_of() like:
> >
> > static int process_sample_event(const struct perf_tool *tool,
> >                                 union perf_event *event,
> >                                 struct perf_sample *sample,
> >                                 struct evsel *evsel,
> >                                 struct machine *machine)
> > {
> >         struct perf_script *scr =3D container_of(tool, struct perf_scri=
pt, tool);
> >
> > can then change scr->tool without even having to cast away const.
>
> Agreed, but such things happen in builtin_cmd where the tool is
> defined and presumably they know what they are doing. My objection is
> to code in util mutating the tool as I want the tool to have
> predictable behavior. As callers that take a tool can call fill in
> defaults (not all) then the tool has to be mutable and I don't want
> this to be the case.
>
> > Really, 'tool' needs to be defined as const in the first place.
>
> I'd like this. The problem is initializing all the function pointers
> and making such initialization robust to extra functions being added
> to the tool API. It can be done in a long winded way but I couldn't
> devise macro magic to do it. The other problem is around variables
> like ordered_events that can't currently be const. The patches move us
> closer to this being a possibility.
>
> > > My
> > > builtin_cmd is in charge of what the tool is rather than some code
> > > buried in util that thought it was going to do me a favor. The code i=
s
> > > a refactor and so the benefit is intended to be for the developer and
> > > how they reason about the use of tool.
> >
> > It creates another question though: since there is a lot of code
> > before perf_tool__init() is called, does the caller mistakenly
> > change tool before calling perf_tool__init()
>
> If they do this their function pointers will be clobbered and their
> code won't behave as expected, which I'd expect to be easy to observe.
> In C++ if you were to initialize memory and then use the memory for a
> placement new to create an object which would call the constructor,
> the expected behavior would be that the initialized memory's values
> would get overridden. I see the use of _init and _exit in the code as
> being our poor man replacements of constructors and destructors.
>
> > > how they reason about the use of tool. We generally use _init
> > > functions rather than having _fill_defaults, so there is a consistenc=
y
> > > argument.
> >
> > The caller does not need the "defaults", so why would it set them up.
> > The session could just as easily do:
> >
> >         if (tool->cb)
> >                 tool->cb(...);
> >         else
> >                 cb_stub(...);
>
> Multiplied by every stub, we'd probably need a helper function, how to
> handle argument passing. There's nothing wrong with this as an idea
> but I think of this code as trying to create a visitor pattern and
> this is a visitor pattern with a hard time for the caller.
>
> > > I don't expect any impact in terms of performance... Moving
> > > perf_tool__fill_defaults to __perf_session__new had issues with the
> > > existing code where NULL would be written over a function pointer
> > > expecting the later fill_defaults to fix it up, doesn't address codin=
g
> > > consistency where _init is the norm, and adds another reason the tool
> > > passed to session__new can't be const.
> >
> > perf_tool__init() is not a steeping stone to making 'tool' a
> > const in the first place.
>
> It is because the patch series gets rid of fill in defaults which is
> why we have a mutable tool passed around. I don't think this is up for
> debate as the patch series clearly goes from a non-const
> tool to a const tool at the end. Changing perf_tool__init to make all
> the function pointers NULL and then making every caller have to do a:
>
>          if (tool->cb)
>                  tool->cb(...);
>          else
>                  cb_stub(...);
>
> I think it is a less elegant solution at the end, it is also a large
> and more invasive change. The various refactorings to make tool const,
> changing the aux use of tool, etc. wouldn't be impacted by such a
> change but I think it is out of scope for this patch series.

I don't think it's a large and invasive change.  The tools are mostly
zero-initialized so we don't need to reset to NULL.  And tool->cb is
called mostly from two functions: machines__deliver_event() and
perf_session__process_user_event().  Can we change them to check
NULL and get rid of perf_tool__fill_defaults() to keep it const?

Thanks,
Namhyung
