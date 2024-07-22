Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC216EB56
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721671513; cv=none; b=WRcRCVjCwdrTQ4HBH+T6d4Bhm0omVz+X1Obu1jCDP39nHuJ1/DIcj1yHnNP+TqVwfaeVZB45wqDLYMFKj4QhW7EVGtRGghWUISY3iwidWehLJsGlexzj5hfh35te9vZkSH2mTOIZ71sb83xAuEhkC0yVlEaxM6amh9P/nXXTn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721671513; c=relaxed/simple;
	bh=B/b4oSEdQIJSoZl90hzr7567DiLQI+lDSYxIHBtlDLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQdUh5TgjeRHWRsvMeiexG315O57G83eWd3ZPh/D1K9Vjvd3A8wbCQjt8pV3Hcw0fYXQMi5va7FqHicrzhf9tNdNS4GKH/7Sit3X7zBzaNcG20gky55AsxL0uhGagCGJm7SDMI+V2jUnH8X2RxRBGbvMeg96fC7G6lOlXXYux/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XF16gZ4+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XF16gZ4+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd7509397bso17775ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721671510; x=1722276310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5vlvG03fUbvTFvup7c86o5P/axLn4J97RohqqjvM2g=;
        b=XF16gZ4+qKaxqKYIg+++MiL+Q0AZhUGow9L2kj22u5OZAW/yNtYNK+C95ji2yLxbo3
         MMnMU5HvdgyibOTHJBPIQO5YUBh8eXr/Ae4uURp2cOYKip7ikAVPS92B86xaXTzbDvth
         sbbUR1gtRefTQZQV4e+OA0sclFzuS4YSe9LWIEwy/J8pCbH1vpjUWkZu2C49CtkZ71OL
         tJkna/8PipZLpiHobUX14lH+N8Jk19aYzPZJGS/1SSrFVS9XSlmAGb0VhFPLQh6Z7Ojo
         T7SqQXAUKH6H6Vjyd62kcB4ve4aV9ApC9auwpX6QVQw3h0nKym9Wf41lXcKNgLJ6pEGr
         JtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721671510; x=1722276310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5vlvG03fUbvTFvup7c86o5P/axLn4J97RohqqjvM2g=;
        b=Ojs5paQDrwTIOyLNQILUxcaJaV0i5mQDMVeYwDy77RXBZhgKhh2q/lW8J9QPrOHq1S
         f4A9hvYeo8KpwaYVCFExkVojNWAGRXC0l6Z4MAKzQdm7/4MuzQo90cqwDJS12vAcr2F4
         5NED67/9e1q7CZ6HtNDH4yJTkE/PBxc3qcqMwrJnYpSY8ucXvrkFRMuWQZVnnMSVPxky
         CugGiLulWfCMy5n09yt0PZPfmofRSVWN2POw8LzL0b8F5vQjAqQbJl/r5a2usv2WmfDI
         gPrl7pS4O1yBJ5fA2uipdNXZWh+2ayuFnJikTQaJ9aSrgxILnu62N4sm2IfJAclXsy0z
         kDhA==
X-Forwarded-Encrypted: i=1; AJvYcCV7qJQ4IdMQpokym+eTW6l6nDXYMYpKWYBQIyjEVvoHzy0xug3F/mYPUmCRZrsRB9uvT0lCQ7cRxJTbEfs7rPflREcSAnmZIxm95ybL26Y+8A==
X-Gm-Message-State: AOJu0YwTaGgFLWTvxRJM5hrnxz5m9hgK+J13Xd+yURSDpG79sk36ifN0
	N53ktMZvUbj1J3d3MxdXGYTVdcmW7+cjGEEVwbb5Tt16LTqIej4+OweKXKrFnZNSg3xp3PVEu3a
	hwCz3pgM9pmFII9CCwEuXsE7zNhuICbVgcxUw
X-Google-Smtp-Source: AGHT+IHvMyNrL5r7VoktgasmMYZ4mtLLFQcjSQQTcLCY5s4TZCyXdO8XOqzKFVgWbXJSAG2d2lQ/BVR662AtS3eYjag=
X-Received: by 2002:a17:902:cecd:b0:1f3:61f1:e340 with SMTP id
 d9443c01a7336-1fd7ff4548emr4470985ad.13.1721671509429; Mon, 22 Jul 2024
 11:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com> <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
 <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
 <05fa0449-4fd4-41ed-93e8-db825e48268f@intel.com> <CAP-5=fU9riOR7onxCE3a2xOs_bVdQdTSkAHD5QLb=SO6SCzkzQ@mail.gmail.com>
 <CAM9d7cjbi_P+V=QkLFg6OuEJqmCOsOoDBddQbyhMYD3aF8do4g@mail.gmail.com> <CAP-5=fXd3t4pXKU7hVDRZp5DnRbZpJRp9zO3ia8cwbRSROKMRQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXd3t4pXKU7hVDRZp5DnRbZpJRp9zO3ia8cwbRSROKMRQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jul 2024 11:04:57 -0700
Message-ID: <CAP-5=fW4LmOMo6fD9d9Ymc9stDttxQv-Pjg-=Xeq41-LGumwSA@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] Constify tool pointers
To: Namhyung Kim <namhyung@kernel.org>
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

On Mon, Jul 22, 2024 at 10:50=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Jul 22, 2024 at 10:45=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > Hi,
> >
> > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Mon, Jul 22, 2024 at 1:29=E2=80=AFAM Adrian Hunter <adrian.hunter@=
intel.com> wrote:
> > > >
> > > > On 19/07/24 19:26, Ian Rogers wrote:
> > > > > On Fri, Jul 19, 2024 at 1:51=E2=80=AFAM Adrian Hunter <adrian.hun=
ter@intel.com> wrote:
> > > > >>
> > > > >> On 18/07/24 03:59, Ian Rogers wrote:
> > > > >>> struct perf_tool provides a set of function pointers that are c=
alled
> > > > >>> through when processing perf data. To make filling the pointers=
 less
> > > > >>> cumbersome, if they are NULL perf_tools__fill_defaults will add
> > > > >>> default do nothing implementations.
> > > > >>>
> > > > >>> This change refactors struct perf_tool to have an init function=
 that
> > > > >>> provides the default implementation. The special use of NULL an=
d
> > > > >>> perf_tools__fill_defaults are removed. As a consequence the too=
l
> > > > >>> pointers can then all be made const, which better reflects the
> > > > >>> behavior a particular perf command would expect of the tool and=
 to
> > > > >>> some extent can reduce the cognitive load on someone working on=
 a
> > > > >>> command.
> > > > >>>
> > > > >>> v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's test=
ed-by.
> > > > >>
> > > > >> The tags were really meant only for patch 1, the email that was =
replied to.
> > > > >>
> > > > >> But now for patches 2 and 3:
> > > > >>
> > > > >> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > > > >
> > > > > Sorry for that, you'd mentioned that pt and bts testing which is
> > > > > impacted by more than just patch 1.
> > > > >
> > > > >> Looking at patches 4 to 25, they do not seem to offer any benefi=
t.
> > > > >>
> > > > >> Instead of patch 26, presumably perf_tool__fill_defaults() could
> > > > >> be moved to __perf_session__new(), which perhaps would allow
> > > > >> patch 27 as it is.
> > > > >
> > > > > What I'm trying to do in the series is make it so that the tool i=
sn't
> > > > > mutated during its use by session. Ideally we'd be passing a cons=
t
> > > > > tool to session_new, that's not possible because there's a hack t=
o fix
> > > > > ordered events and pipe mode in session__new:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/session.c?h=3Dperf-tools-next#n275
> > > > > Imo, it isn't great to pass a tool to session__new where you say =
you
> > > > > want ordered events and then session just goes to change that for=
 you.
> > > > > Altering that behavior was beyond the scope of this clean up, so =
tool
> > > > > is only const after session__new.
> > > >
> > > > Seems like a separate issue.  Since the session is created
> > > > by __perf_session__new(), session->tool will always be a pointer
> > > > to a const tool once there is:
> > > >
> > > > diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> > > > index 7f69baeae7fb..7c8dd6956330 100644
> > > > --- a/tools/perf/util/session.h
> > > > +++ b/tools/perf/util/session.h
> > > > @@ -43,7 +43,7 @@ struct perf_session {
> > > >         u64                     one_mmap_offset;
> > > >         struct ordered_events   ordered_events;
> > > >         struct perf_data        *data;
> > > > -       struct perf_tool        *tool;
> > > > +       const struct perf_tool  *tool;
> > > >         u64                     bytes_transferred;
> > > >         u64                     bytes_compressed;
> > > >         struct zstd_data        zstd_data;
> > >
> > > That's the case after these changes, but not before.
> > >
> > > > >
> > > > > The reason for doing this is to make it so that when I have a too=
l I
> > > > > can reason that nobody is doing things to change it under my feet=
.
> > > >
> > > > It still can be changed by the caller of __perf_session__new(), sin=
ce
> > > > the tool itself is not const.
> > > >
> > > > Anything using container_of() like:
> > > >
> > > > static int process_sample_event(const struct perf_tool *tool,
> > > >                                 union perf_event *event,
> > > >                                 struct perf_sample *sample,
> > > >                                 struct evsel *evsel,
> > > >                                 struct machine *machine)
> > > > {
> > > >         struct perf_script *scr =3D container_of(tool, struct perf_=
script, tool);
> > > >
> > > > can then change scr->tool without even having to cast away const.
> > >
> > > Agreed, but such things happen in builtin_cmd where the tool is
> > > defined and presumably they know what they are doing. My objection is
> > > to code in util mutating the tool as I want the tool to have
> > > predictable behavior. As callers that take a tool can call fill in
> > > defaults (not all) then the tool has to be mutable and I don't want
> > > this to be the case.
> > >
> > > > Really, 'tool' needs to be defined as const in the first place.
> > >
> > > I'd like this. The problem is initializing all the function pointers
> > > and making such initialization robust to extra functions being added
> > > to the tool API. It can be done in a long winded way but I couldn't
> > > devise macro magic to do it. The other problem is around variables
> > > like ordered_events that can't currently be const. The patches move u=
s
> > > closer to this being a possibility.
> > >
> > > > > My
> > > > > builtin_cmd is in charge of what the tool is rather than some cod=
e
> > > > > buried in util that thought it was going to do me a favor. The co=
de is
> > > > > a refactor and so the benefit is intended to be for the developer=
 and
> > > > > how they reason about the use of tool.
> > > >
> > > > It creates another question though: since there is a lot of code
> > > > before perf_tool__init() is called, does the caller mistakenly
> > > > change tool before calling perf_tool__init()
> > >
> > > If they do this their function pointers will be clobbered and their
> > > code won't behave as expected, which I'd expect to be easy to observe=
.
> > > In C++ if you were to initialize memory and then use the memory for a
> > > placement new to create an object which would call the constructor,
> > > the expected behavior would be that the initialized memory's values
> > > would get overridden. I see the use of _init and _exit in the code as
> > > being our poor man replacements of constructors and destructors.
> > >
> > > > > how they reason about the use of tool. We generally use _init
> > > > > functions rather than having _fill_defaults, so there is a consis=
tency
> > > > > argument.
> > > >
> > > > The caller does not need the "defaults", so why would it set them u=
p.
> > > > The session could just as easily do:
> > > >
> > > >         if (tool->cb)
> > > >                 tool->cb(...);
> > > >         else
> > > >                 cb_stub(...);
> > >
> > > Multiplied by every stub, we'd probably need a helper function, how t=
o
> > > handle argument passing. There's nothing wrong with this as an idea
> > > but I think of this code as trying to create a visitor pattern and
> > > this is a visitor pattern with a hard time for the caller.
> > >
> > > > > I don't expect any impact in terms of performance... Moving
> > > > > perf_tool__fill_defaults to __perf_session__new had issues with t=
he
> > > > > existing code where NULL would be written over a function pointer
> > > > > expecting the later fill_defaults to fix it up, doesn't address c=
oding
> > > > > consistency where _init is the norm, and adds another reason the =
tool
> > > > > passed to session__new can't be const.
> > > >
> > > > perf_tool__init() is not a steeping stone to making 'tool' a
> > > > const in the first place.
> > >
> > > It is because the patch series gets rid of fill in defaults which is
> > > why we have a mutable tool passed around. I don't think this is up fo=
r
> > > debate as the patch series clearly goes from a non-const
> > > tool to a const tool at the end. Changing perf_tool__init to make all
> > > the function pointers NULL and then making every caller have to do a:
> > >
> > >          if (tool->cb)
> > >                  tool->cb(...);
> > >          else
> > >                  cb_stub(...);
> > >
> > > I think it is a less elegant solution at the end, it is also a large
> > > and more invasive change. The various refactorings to make tool const=
,
> > > changing the aux use of tool, etc. wouldn't be impacted by such a
> > > change but I think it is out of scope for this patch series.
> >
> > I don't think it's a large and invasive change.  The tools are mostly
> > zero-initialized so we don't need to reset to NULL.  And tool->cb is
> > called mostly from two functions: machines__deliver_event() and
> > perf_session__process_user_event().  Can we change them to check
> > NULL and get rid of perf_tool__fill_defaults() to keep it const?
>
> As I said above, I don't think that is good style and is out of scope
> here. It clearly can be done as follow up, but I don't see how that
> fixes the style issue.

Just to be clear on what the style issue is. We already have code:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-record.c?h=3Dperf-tools-next#n1461
```
if (rec->buildid_all && !rec->timestamp_boundary)
    rec->tool.sample =3D NULL;
```
that relies on the special behavior of NULL in a function pointer
being changed at dispatch time - a simple reading of that code would
be anyone calling the function pointer would get a segv. I'm trying to
make it so that NULL isn't magic in the context of tool and you can
simply look at the tool to understand what its behavior is, much as a
virtual method table would work if we could do proper object-oriented
development.

Thanks,
Ian

> Thanks,
> Ian
