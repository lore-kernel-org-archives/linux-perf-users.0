Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1155F46D
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334572; cv=none; b=cambgCPy+fbTyEHlhWgIh1FaHC7YDQGbSCGCI5p//jrF0EyEbW30L3oKFhcuBChosLCdvdYeYq3dcAnEe5iq/h9AQfO+PEtJ1L5BFFWViV/gp/o/GUlupu0vesuOYVRTfDnoobdwySMs8eTmm7Pk3XC0uqgt5Naz6XnNEmdnTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334572; c=relaxed/simple;
	bh=Cc/GP/LGIYKdonuPQumWYq+5rAt9Vc9Ei8r9CSvVTR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvFxFQA3L/Gm1ZeQ01hSZUtElAsWNTN8mM31dJ+DjdaqaX+xq0gv2EhrSjp/g8u/YiKuAsfdBa+N3L+aHX3D3OCzGAq8zluCn6XEpiD1k7S1dQRLUEz0hmNXBoWVXyDeOSwmpH4wLTQVplaaZjdq3oUYYz6qgU25rjovJ5seW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gMAdOcPH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gMAdOcPH"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42e6939d34fso506681cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 15:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709334569; x=1709939369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwGDN6FcEU8MzFb9rM6a35WIbwnKWy7NZjIOsTvA+Fc=;
        b=gMAdOcPHt7ra/+33yZLNzwsSMacyIUK/brObIhyLhBMLsA8Hwja+Rfp7W0Vn1UUj0D
         uG7haSXdMzf6DMMCNznIEzPUDvhxBoXpku9MrYu8nFFnfGpdJN5N/f6zGPQM67ifLpwm
         HVfeCvWimLBa4xkPD+oVwU2vs0PSdXyhA7GCLDjCDpixCdcOlvN1tLY8Jo+gj5yPGeqj
         ayc/ryhNQ4SqDfWjf3Nw72UfETd3kKenVhZ7186x0MxP+aK9+Y2zplA1MZwWJir+pcnf
         JrvR5SoTHwsxIXNR9/UZuSNt0WU5lVTgbCQtGa3J4ecmWraPtb++pqJmxBPxQpTDgoB4
         hcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709334569; x=1709939369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwGDN6FcEU8MzFb9rM6a35WIbwnKWy7NZjIOsTvA+Fc=;
        b=Xj5koTHJ1Zoul67sugfSJ8VI5BmzoVBgpjiKvQMKWSp3oSuCm2t6gRFBu4DQTfJz6j
         P3A43p6/6uv1mEg6rWotnZItTf8ktiUR5YGXixhYfenCwtmhOsyMZ957Zvobt5slTva0
         +CLMZtJlzkJ4zYaskhnW+hHn4K9zJ7SgtCqYsQj2q9upCRUKcDOaY2wbjF3Bn/Iw2Gqz
         0WytRfN/a+GAam/zEd1f8QI+uIU5xxq6zv3gvY9s7oVpv4kulUh77QpFBqVHnj1afFf/
         91rMDDARZvRReHt2QZV5qDnfJIdk25mlFfhfYs6EiSglH6WQJAYM/wFab91S8S/sbPJh
         nBDA==
X-Forwarded-Encrypted: i=1; AJvYcCWAm2paXcvM/p56A82aN3cbMx9rwqLw69CQ6NWgNkuiWuQ+quqQWM8LDqO4920FNQ5CTRESz8616gv5ChK/Xj4a3VqPbEO6Mqnhl1zBXYJy5g==
X-Gm-Message-State: AOJu0Yw5XIHHNfoFgUDa0McrJjdTIDowK8sJa4PMIauTJ7fx4ArQijQO
	nk+4TOHbQu5l63AWErGf9wyMqcsmYE+qcU7e0EtPLYfmctC/IPo3XoBJJkL8ZuSe63ZUfnNCHYk
	343OgYrU4NKXhC+NuAPTYIC3XDxgrnq872/i/
X-Google-Smtp-Source: AGHT+IFhZaYsvDPUhKv588IyxxKiq70WACxtYze4o/wQ2AiGQmtnQSxWrbgyAqp9voa2GMsDU18oj+r6jnG7cEPBVB0=
X-Received: by 2002:a05:622a:130b:b0:42e:2931:13df with SMTP id
 v11-20020a05622a130b00b0042e293113dfmr266112qtk.11.1709334569254; Fri, 01 Mar
 2024 15:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com> <20240229001806.4158429-3-irogers@google.com>
 <ZeIVQhfDMP7_bSJ8@tassilo> <CAP-5=fWpXHXd8Dd39o_KEcVaBkQKk=aXjYSVTWCitaY6Xm-T4A@mail.gmail.com>
 <ZeJJyCmXO9GxpDiF@tassilo>
In-Reply-To: <ZeJJyCmXO9GxpDiF@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 Mar 2024 15:09:16 -0800
Message-ID: <CAP-5=fUPzzJtHEnwEoBQXQb6ARje2nyWAwXKSvMn5KApwFWs4Q@mail.gmail.com>
Subject: Re: [PATCH v1 02/20] perf jevents: Add idle metric for Intel models
To: Andi Kleen <ak@linux.intel.com>
Cc: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:34=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> >
> > I see some of the gains as:
> >  - metrics that are human intelligible,
> >  - metrics for models that are no longer being updated,
> >  - removing copy-paste of metrics like tsx and smi across each model's
> > metric json (less lines-of-code),
> >  - validation of events in a metric expression being in the event json
> > for a model,
> >  - removal of forward porting metrics to a new model if the event
> > names of the new model line up with those of previous,
> >  - in this patch kit there are metrics added that don't currently
> > exist (more metrics should be better for users - yes there can always
> > be bugs).
>
> But then we have two ways to do things, and we already have a lot
> of problems with regressions from complexity and a growing
> bug backlog that nobody fixes.

If you want something to work you put a test on it. We have a number
of both event and metric tests. I'm not sure what the bug backlog you
are mentioning is, but as far as I can see the tool is in the best
condition it has ever been. All tests passing with address sanitizer
was a particular milestone last year.

> Multiple ways to do basic operations seems just a recipe for
> more and more fragmentation and similar problems.
>
> The JSON format is certainly not perfect and has its share
> of issues, but at least it's a standard now that is supported
> by many vendors and creating new standards just because
> you don't like some minor aspects doesn't seem like
> a good approach. I'm sure the next person will come around
> why wants Ruby metrics and the third would prefer to write
> them in Rust. Who knows where it will stop.

These patches don't make the json format disappear, we use python to
generate the json metrics as json strings are a poor programming
language.

I agree we have too many formats, but json is part of the problem
there not the solution. I would like to make the only format the sysfs
one, and then we can do like a unionfs type thing in the perf tool
where we can have sysfs, a sysfs layer built into the tool (out of the
json) and possibly user specified layers. This would allow
customizability once the binary is built, but it would also allow us
to test with a sysfs for a machine we don't have. Linux on M1 macs are
a particular issue, but we recently had an issue with the layout of
the format directory for Intel uncore_pcu pre-Skylake which doesn't
have a umask. Finding such machines to test on is the challenge, and
abstracting sysfs as a unionfs type thing is, I think, the correct
approach.

I don't think the Linux build has tooling around Ruby, and there are
no host tools written in Rust yet. Will it happen? Probably, and I
think it is good the codebase keeps moving forward. Before the C
reference count checking implementation, we were talking about
rewriting at least pieces like libperf in Rust - the code was leaking
memory and it seemed unsolvable as reasonable fixes would yield
use-after-frees and crashes. I've even mentioned this in LWN comments
on articles around Rust, nobody stepped up with a fix until I did the
reference count checking.

Python is a good choice for reading json as the inbuilt library is of
a reasonable quality. Python is good for what I've done here as the
operator overloading makes the expressions readable. We can read in
and out of the python tree format, and do so in jevents.py to validate
the metrics can parse (we still have the C parse test). We haven't
written a full expression parser in python, although it wouldn't be
hard, we just ack the string and pretty much call eval. It'd be
relatively easy to add an output function to the python code to make
it convert the expressions to a different programming language, for
example the ToPython code here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/metric.py?h=3Dperf-tools-next#n17

> Also in my experience this python stuff is unreliable because
> half the people who build perf forget to install the python
> libraries. Json at least works always.

It has been the case for about a year (v6.4):
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/?h=3Dperf-tools-next&id=3D175f9315f76345e88e3abdc947c1e0030ab99da3
that if we can't build jevents because of python then the build fails.
You can explicitly request not to use python/jevents with
NO_JEVENTS=3D1, but it is an explicit opt-out.
I don't think this is unreliable. We've recently made BPF opt-out
rather than opt-in in a similar way, and that requires clang, etc. It
has been a problem in the past that implicit opt-in and opt-out could
give you a perf tool that a distribution couldn't ship (mixed GPLv2
and v3 code) or that was missing useful things. I think we've fixed
the bug by making the build fail unless you explicitly opt-out of
options we think you should have.

Fwiw, there is a similar bug that BTF support in the kernel is opt-in
rather than opt-out, meaning distributions ship BPF tools that can't
work for the kernel they've built. If there were more time I'd be
looking to make BTF opt-out rather than opt-in, I reported the issue
on the BPF mailing list.

> Incrementional improvements are usually the way to do these
> things.

We've had jevents as python for nearly 2 years. metric.py that this
code is building off has been in the tree for 15 months. I wrote the
code and there is a version of it for:
https://github.com/intel/perfmon/commits/main/scripts/create_perf_json.py
which is 2 years old. I don't see anything non-incremental, if
anything things have been slow to move forward. It's true vendors
haven't really adopted the code outside of Intel's perfmon, I've at
least discussed it with them in face-to-faces like LPC. Hopefully this
work is a foundation for vendors to write more metrics, it should be
little more struggle than it is for them to document the metric in
their manuals.

ARM have a python based json tool for perf (similar to the perfmon one) her=
e:
https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/main/to=
ols/perf_json_generator
So I'd say that python and perf json is a standard approach. ARM's
converter is just over a year old.

Thanks,
Ian

> -Andi
