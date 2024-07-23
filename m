Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754913D882
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739061; cv=none; b=clmZKI8b7Rl3k7txYSZQDNUM8AJqIgXP8d1yAJgz8DSy2x/trTBmgHvwZyMqmi/2LMb5oYJiezW43nTjLVngnsUTEI+s7GkxuqiCpidTDK1xT9nr6bLD/tN4bCedT34v5cg1uM2gUZZGtU4nRCNJ2BVaddN8OMIeS4qWiTXI8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739061; c=relaxed/simple;
	bh=M0JZcCpHvHqQLS/y3SSz2MG1vAIso3Dl9Y7syUu6yn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skj/+NeaUzvJgJyXbGecvOVkDE4Cm1NVsBhrAhkWX2uwf09OHjQn5O7PpB4wkmKsJdd6nGLI4/Yey843WpVT/AJwBL6Mgo1p5hDQXZneGhessBd03KRkcVjtQmnfAyO11SDzhOuil78Juu4o/ntSwNsBVcIpTs9IPrwoUQ/5eL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnMjPuCi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnMjPuCi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc4aff530dso205025ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721739059; x=1722343859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V4X2OdDqO9k8dk9s4XK8JBDL6kXx98KG5Q2RUxH/78=;
        b=OnMjPuCinpgENYHHBHN/hBbaUesJZQasxeV5cg5u7csRiRHX4BikoZTedfRUJzDhXX
         xQnAIVTPmYHJtVoO4xy88yjZrLEAEL+Si/4+3utmqTpRcc5Drm27N1a2XIbJMFzo4oEQ
         HVLluGYt6BwcC9WguP6va5IeMZmzF2U/mKxtI2zD5xNZDL1yg34FwFRDRlGqSppOfpeV
         OFKreRBGpUvWKlVqqzhLTrgQT1jjm2rMYZT/tl6TsnBB99EYbg4YfxKjEqsLAj5M+wM7
         OJdaDdUlTmboAIbsL/JhCWX2IVMYHBc1pjlQpxLMj4nk4ZH5zd8l+4hBSPO0EIGoC6eG
         q5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721739059; x=1722343859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V4X2OdDqO9k8dk9s4XK8JBDL6kXx98KG5Q2RUxH/78=;
        b=BhVvVGQQmDYcgAh7VnJlPLV92eiL1uD5s+DxCC7kBdguPgeqhsrvjqbwXn9VCJl6AZ
         zALOhB9+6AkTEZvkIon22WbHgD86AI1pfWErhm8/VtKlwQfRNMG0TQ+kYKnjp3jz+suC
         qlgig+lcGiBI+FG54CJOyIeOhkVGZ71ymJISRiV0DDfprMwxc/aWgpLAzMbSjm6guohs
         IiYE4dOdEYyeCx2A18gIIqihJtCcPWJGYQEq6eh1RXZWFhnP/Ck/02C4ZcqoPkzQ66q7
         3PhXpb9Ga88ySnw+IQcy2FUBAi9UPJByFofDjXIC1VSehhZ1+mx7UAmaJNCrjALjRZhX
         /IUw==
X-Forwarded-Encrypted: i=1; AJvYcCUqOSpTyPsa0voxcVgs92QXaycLSymj/m1sX7ZutdjSgVdhF0FD027eQVs0DryiIcRYHevX1YED3ez4KjmrmSEk6myveLHsGXvEByeYiaKvmw==
X-Gm-Message-State: AOJu0YxCgPmjoeTo946J0U/u/SgYXSFtFWxbdsbgKOUJreeekCQXXd2f
	RHD2WtTLb3PDaWalZVQVZ4zy5OzHu0UCAeaAlVZ2e7G9hsISe/EhQEux6/xnB6fgl48eeZC0hkc
	RdnaWo042kjxBrS6DoilxR+MKmD34W1QnJ1++
X-Google-Smtp-Source: AGHT+IGVn1OMmW5s8NwzwHY+IQretedbbcR+s58C8S/zYWRBFfY1X46Z4zhxOAhzEP5lP1MqZHWXqQI+eJwxpqblG8s=
X-Received: by 2002:a17:902:d483:b0:1fb:1a7:a64f with SMTP id
 d9443c01a7336-1fd7a2087ccmr8228335ad.20.1721739058539; Tue, 23 Jul 2024
 05:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com> <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
 <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
 <05fa0449-4fd4-41ed-93e8-db825e48268f@intel.com> <CAP-5=fU9riOR7onxCE3a2xOs_bVdQdTSkAHD5QLb=SO6SCzkzQ@mail.gmail.com>
 <CAM9d7cjbi_P+V=QkLFg6OuEJqmCOsOoDBddQbyhMYD3aF8do4g@mail.gmail.com>
 <CAP-5=fXd3t4pXKU7hVDRZp5DnRbZpJRp9zO3ia8cwbRSROKMRQ@mail.gmail.com>
 <CAP-5=fW4LmOMo6fD9d9Ymc9stDttxQv-Pjg-=Xeq41-LGumwSA@mail.gmail.com> <5444c426-a4be-4b85-b9d4-65aac78115be@intel.com>
In-Reply-To: <5444c426-a4be-4b85-b9d4-65aac78115be@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 05:50:47 -0700
Message-ID: <CAP-5=fW8YMivp1JW8vRKh=OZtGVLPQ4v88z_2ae+cAVnr7RXoQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] Constify tool pointers
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

On Tue, Jul 23, 2024 at 2:38=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 22/07/24 21:04, Ian Rogers wrote:
> > On Mon, Jul 22, 2024 at 10:50=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> >>
> >> On Mon, Jul 22, 2024 at 10:45=E2=80=AFAM Namhyung Kim <namhyung@kernel=
.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> >>>>
> >>>> On Mon, Jul 22, 2024 at 1:29=E2=80=AFAM Adrian Hunter <adrian.hunter=
@intel.com> wrote:
> >>>>>
> >>>>> On 19/07/24 19:26, Ian Rogers wrote:
> >>>>>> On Fri, Jul 19, 2024 at 1:51=E2=80=AFAM Adrian Hunter <adrian.hunt=
er@intel.com> wrote:
> >>>>>>>
> >>>>>>> On 18/07/24 03:59, Ian Rogers wrote:
> >>>>>>>> struct perf_tool provides a set of function pointers that are ca=
lled
> >>>>>>>> through when processing perf data. To make filling the pointers =
less
> >>>>>>>> cumbersome, if they are NULL perf_tools__fill_defaults will add
> >>>>>>>> default do nothing implementations.
> >>>>>>>>
> >>>>>>>> This change refactors struct perf_tool to have an init function =
that
> >>>>>>>> provides the default implementation. The special use of NULL and
> >>>>>>>> perf_tools__fill_defaults are removed. As a consequence the tool
> >>>>>>>> pointers can then all be made const, which better reflects the
> >>>>>>>> behavior a particular perf command would expect of the tool and =
to
> >>>>>>>> some extent can reduce the cognitive load on someone working on =
a
> >>>>>>>> command.
> >>>>>>>>
> >>>>>>>> v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's teste=
d-by.
> >>>>>>>
> >>>>>>> The tags were really meant only for patch 1, the email that was r=
eplied to.
> >>>>>>>
> >>>>>>> But now for patches 2 and 3:
> >>>>>>>
> >>>>>>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>>>>
> >>>>>> Sorry for that, you'd mentioned that pt and bts testing which is
> >>>>>> impacted by more than just patch 1.
> >>>>>>
> >>>>>>> Looking at patches 4 to 25, they do not seem to offer any benefit=
.
> >>>>>>>
> >>>>>>> Instead of patch 26, presumably perf_tool__fill_defaults() could
> >>>>>>> be moved to __perf_session__new(), which perhaps would allow
> >>>>>>> patch 27 as it is.
> >>>>>>
> >>>>>> What I'm trying to do in the series is make it so that the tool is=
n't
> >>>>>> mutated during its use by session. Ideally we'd be passing a const
> >>>>>> tool to session_new, that's not possible because there's a hack to=
 fix
> >>>>>> ordered events and pipe mode in session__new:
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-ne=
xt.git/tree/tools/perf/util/session.c?h=3Dperf-tools-next#n275
> >>>>>> Imo, it isn't great to pass a tool to session__new where you say y=
ou
> >>>>>> want ordered events and then session just goes to change that for =
you.
> >>>>>> Altering that behavior was beyond the scope of this clean up, so t=
ool
> >>>>>> is only const after session__new.
> >>>>>
> >>>>> Seems like a separate issue.  Since the session is created
> >>>>> by __perf_session__new(), session->tool will always be a pointer
> >>>>> to a const tool once there is:
> >>>>>
> >>>>> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> >>>>> index 7f69baeae7fb..7c8dd6956330 100644
> >>>>> --- a/tools/perf/util/session.h
> >>>>> +++ b/tools/perf/util/session.h
> >>>>> @@ -43,7 +43,7 @@ struct perf_session {
> >>>>>         u64                     one_mmap_offset;
> >>>>>         struct ordered_events   ordered_events;
> >>>>>         struct perf_data        *data;
> >>>>> -       struct perf_tool        *tool;
> >>>>> +       const struct perf_tool  *tool;
> >>>>>         u64                     bytes_transferred;
> >>>>>         u64                     bytes_compressed;
> >>>>>         struct zstd_data        zstd_data;
> >>>>
> >>>> That's the case after these changes, but not before.
> >>>>
> >>>>>>
> >>>>>> The reason for doing this is to make it so that when I have a tool=
 I
> >>>>>> can reason that nobody is doing things to change it under my feet.
> >>>>>
> >>>>> It still can be changed by the caller of __perf_session__new(), sin=
ce
> >>>>> the tool itself is not const.
> >>>>>
> >>>>> Anything using container_of() like:
> >>>>>
> >>>>> static int process_sample_event(const struct perf_tool *tool,
> >>>>>                                 union perf_event *event,
> >>>>>                                 struct perf_sample *sample,
> >>>>>                                 struct evsel *evsel,
> >>>>>                                 struct machine *machine)
> >>>>> {
> >>>>>         struct perf_script *scr =3D container_of(tool, struct perf_=
script, tool);
> >>>>>
> >>>>> can then change scr->tool without even having to cast away const.
> >>>>
> >>>> Agreed, but such things happen in builtin_cmd where the tool is
> >>>> defined and presumably they know what they are doing. My objection i=
s
> >>>> to code in util mutating the tool as I want the tool to have
> >>>> predictable behavior. As callers that take a tool can call fill in
> >>>> defaults (not all) then the tool has to be mutable and I don't want
> >>>> this to be the case.
> >>>>
> >>>>> Really, 'tool' needs to be defined as const in the first place.
> >>>>
> >>>> I'd like this. The problem is initializing all the function pointers
> >>>> and making such initialization robust to extra functions being added
> >>>> to the tool API. It can be done in a long winded way but I couldn't
> >>>> devise macro magic to do it. The other problem is around variables
> >>>> like ordered_events that can't currently be const. The patches move =
us
> >>>> closer to this being a possibility.
> >>>>
> >>>>>> My
> >>>>>> builtin_cmd is in charge of what the tool is rather than some code
> >>>>>> buried in util that thought it was going to do me a favor. The cod=
e is
> >>>>>> a refactor and so the benefit is intended to be for the developer =
and
> >>>>>> how they reason about the use of tool.
> >>>>>
> >>>>> It creates another question though: since there is a lot of code
> >>>>> before perf_tool__init() is called, does the caller mistakenly
> >>>>> change tool before calling perf_tool__init()
> >>>>
> >>>> If they do this their function pointers will be clobbered and their
> >>>> code won't behave as expected, which I'd expect to be easy to observ=
e.
> >>>> In C++ if you were to initialize memory and then use the memory for =
a
> >>>> placement new to create an object which would call the constructor,
> >>>> the expected behavior would be that the initialized memory's values
> >>>> would get overridden. I see the use of _init and _exit in the code a=
s
> >>>> being our poor man replacements of constructors and destructors.
> >>>>
> >>>>>> how they reason about the use of tool. We generally use _init
> >>>>>> functions rather than having _fill_defaults, so there is a consist=
ency
> >>>>>> argument.
> >>>>>
> >>>>> The caller does not need the "defaults", so why would it set them u=
p.
> >>>>> The session could just as easily do:
> >>>>>
> >>>>>         if (tool->cb)
> >>>>>                 tool->cb(...);
> >>>>>         else
> >>>>>                 cb_stub(...);
> >>>>
> >>>> Multiplied by every stub, we'd probably need a helper function, how =
to
> >>>> handle argument passing. There's nothing wrong with this as an idea
> >>>> but I think of this code as trying to create a visitor pattern and
> >>>> this is a visitor pattern with a hard time for the caller.
> >>>>
> >>>>>> I don't expect any impact in terms of performance... Moving
> >>>>>> perf_tool__fill_defaults to __perf_session__new had issues with th=
e
> >>>>>> existing code where NULL would be written over a function pointer
> >>>>>> expecting the later fill_defaults to fix it up, doesn't address co=
ding
> >>>>>> consistency where _init is the norm, and adds another reason the t=
ool
> >>>>>> passed to session__new can't be const.
> >>>>>
> >>>>> perf_tool__init() is not a steeping stone to making 'tool' a
> >>>>> const in the first place.
> >>>>
> >>>> It is because the patch series gets rid of fill in defaults which is
> >>>> why we have a mutable tool passed around. I don't think this is up f=
or
> >>>> debate as the patch series clearly goes from a non-const
> >>>> tool to a const tool at the end. Changing perf_tool__init to make al=
l
> >>>> the function pointers NULL and then making every caller have to do a=
:
> >>>>
> >>>>          if (tool->cb)
> >>>>                  tool->cb(...);
> >>>>          else
> >>>>                  cb_stub(...);
> >>>>
> >>>> I think it is a less elegant solution at the end, it is also a large
> >>>> and more invasive change. The various refactorings to make tool cons=
t,
> >>>> changing the aux use of tool, etc. wouldn't be impacted by such a
> >>>> change but I think it is out of scope for this patch series.
> >>>
> >>> I don't think it's a large and invasive change.  The tools are mostly
> >>> zero-initialized so we don't need to reset to NULL.  And tool->cb is
> >>> called mostly from two functions: machines__deliver_event() and
> >>> perf_session__process_user_event().  Can we change them to check
> >>> NULL and get rid of perf_tool__fill_defaults() to keep it const?
> >>
> >> As I said above, I don't think that is good style and is out of scope
> >> here. It clearly can be done as follow up, but I don't see how that
> >> fixes the style issue.
> >
> > Just to be clear on what the style issue is. We already have code:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-record.c?h=3Dperf-tools-next#n1461
> > ```
> > if (rec->buildid_all && !rec->timestamp_boundary)
> >     rec->tool.sample =3D NULL;
> > ```
> > that relies on the special behavior of NULL in a function pointer
> > being changed at dispatch time - a simple reading of that code would
> > be anyone calling the function pointer would get a segv. I'm trying to
> > make it so that NULL isn't magic in the context of tool and you can
> > simply look at the tool to understand what its behavior is, much as a
> > virtual method table would work if we could do proper object-oriented
> > development.
>
> In C, NULL or zero is often used as a special value to mean
> no-value.  Optional callbacks that are NULL is also not remarkable.

Sure NULL means optional and has since the dawn of time, I don't see
this adding anything to the conversation. What is remarkable here is
passing around a collection of function pointers, then the caller of
the function pointer is supposed to check whether what you want to be
an optional value (I don't, nor does the existing code) function
pointer is present, and if not present the caller needs to know to
call another special function. This is complicated enough that the
function calls could use helper macros, e.g.:

#define CALL_TOOL_SAMPLE(tool, event, sample, evsel, machine) \
  if (tool->sample) \
    tool->sample(tool, event, sample, machine); \
  else \
    process_event_sample_stub(tool, event, sample, machine);

you need about 38 of them. Now if I'm a buildtin_cmd writer wanting to
know what gets called on tool, I need to check, do all callers of the
tool use the macro? Perhaps the user decided to do their own NULL test
and call a different function. Cases like tool->finished_round already
need to go to one of two different stubs. There is clearly more
cognitive load on the tool API user as now they must check all uses of
38 function pointers across the code base to understand the behavior
of the tool, they can't just rely on the function pointer in the
struct being the place the code will go. A simple function pointer
call has imo become spaghetti.

There is also the overhead checking the optional value - I've never
seen a C programmer wanting to do this in 30 years of doing paid C
development, the use of the function pointer was to avoid checking,
etc. But maybe the kernel does this and it's an existing kernel style?
I can't find it.

Thanks,
Ian
