Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106F199FDE
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373294; cv=none; b=ur1xz5cIT6hMqZzSA+JdtGa2JlprRK4I7uQvES9htpdOIY0DMw+fmoShqqE4R11VMJI6W5cMZN1j0fTipXv5UybGX2CIYHWU6jYL4XoI4CE36hMjsTW7seosjP5ef/h9s3vieaChga+k463QiI8mtSTsZDgUFWMs1laWmzGExSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373294; c=relaxed/simple;
	bh=GTfNNZvLCbOPBoM0Ai0WgtMz65rUH5c7i6UB1UGWT7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAZYmNeKBJV1lXoY2OHW2W+z7FUbBz6ybG+ax24AQnTIuHcx7fWZY93TjiishuI6VYyvMAD9fdfcQeYwRb4QRrU5AML/6r8JRlIRWP33J2a89gsWmAhqN76UhqmbG926k/irtMu4v3cVTgL+NKgZPqpIN0aTojJSuKANW58ng+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPkXkgBp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPkXkgBp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2242aca53efso11175ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 10:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741373292; x=1741978092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnnBLiHSipCquEBENm80tx5p5tMfaLtXbkHcXLPFAjU=;
        b=XPkXkgBpG2Z/bl6TqPHaytNlT1VMOl4x5jpQBvxyz8CBz3WUEZb5/elJHjKYjRMQ87
         sfnMLzQJwtcUqO2PhXCVQnp9d/Vrbj0mUhQyVMeW8MDqpnH9079IP7VMd4bpemw2iLsj
         HRDZWHVIWtYKNHdjmpB/+3SbOsd4oqJ55XAmo7R/CLjxQ6n0JEUgxx0ry9OrqhImowzW
         vZk25VWt3RJidaN5GopH6dya26Bw1jXvC/0WLywzHvQDbngBA8/pssjiHhJGoIt7s0z4
         a7YeUyzEqW/KrQ+h4xX9a3if/gbxDsXyz7fjndyy9Q3w/g6RRe62ysebX2BGoBLg3SG8
         lXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741373292; x=1741978092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnnBLiHSipCquEBENm80tx5p5tMfaLtXbkHcXLPFAjU=;
        b=H6ZxL284jds3OEn4Tv9rbgEUAeUeqGpdKnJFqTmWxm5ydnszzaLbelvczymubK/vOi
         8Og5xnlHuipQBnqlqVYLUdLMrSlNu+7WESsDIHdDcG7fb4ViOYHoq7o0qVyfGqVyJdyP
         gHmVeeu1Xww5ZyOODyq9Q4+S8wESYZcnms5/VfB8RoH8/KiNkRam0+K2HQ1dXPKC+O0L
         UPV4G6w+BCGJkDSXE2P4kdi7dDw3P7nf++nZXPwpC4WDTkfawSRs+vZQXoxwE/8auED2
         8LNFuyTV3I7PVoLTBVdqbKhHmptEL+Snu90bM5MNxb496bFCOFQNtLOnKXZZIPVCkeRL
         cu2g==
X-Forwarded-Encrypted: i=1; AJvYcCULoNjIllgvVxrToU+DDpCfvTdtMJuok4ZpOA1FCuJdnSIu3J5mW0QaYEWJVyfIlFu32lYMsTcmILRuwQeYBdC4@vger.kernel.org
X-Gm-Message-State: AOJu0YzajIhUm/Tk8IH6pVRpZEB19FvrBTJAaiokXh+xbRH8Jg0vmEro
	meHEHc+uOyZKlARjBhUiQaEgLyPE5plFN27myt00Wr8fbi6Zm90hViYuw5u4H11aik2/1m9yIUk
	d2DHmUbpm51qjpn6aBLkhYkchWH2Mgwc3FTWQ
X-Gm-Gg: ASbGnctzAY9hjyE1D52tYRceY1clD7HVgndbTN6H6d+jhFy0/xPHL4eC1WHDvzbGgCm
	YObHC9R0paWVe7VEMJLAWF+8cNMMOrzXW+fN78S9K6jlmqM095JSy2DgwTbuGiiwsIucO0c5GaL
	8FVDu4l+bn1bFLO/8wbulP5ZYMTRA=
X-Google-Smtp-Source: AGHT+IGdT5nE+QHbJpWHzcC0wNB5abK8RgakHQzBWpxs8Ndj2pR7WbNhCjKOLLaAbeK/qow+V4wBDpPUYk2l/+ePmXg=
X-Received: by 2002:a17:902:ccc8:b0:215:42a3:e844 with SMTP id
 d9443c01a7336-22434b5433emr1163905ad.17.1741373291454; Fri, 07 Mar 2025
 10:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7Z5kv75BMML2A1q@google.com> <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
 <Z7yJ0Vpub6JeQyYo@x1> <80432f35-e865-4186-8b92-26b25279e150@linaro.org> <Z8sMcta0zTWeOso4@x1>
In-Reply-To: <Z8sMcta0zTWeOso4@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Mar 2025 10:48:00 -0800
X-Gm-Features: AQ5f1Jq6zGKtLrcNss-uzScSqLCab5P5rfBJprgge4TMGFWgurWy9LXP2biOgVw
Message-ID: <CAP-5=fWytO4QkxQEu02RxTM51dtqtDXnT517tdiAe79LidT6Ww@mail.gmail.com>
Subject: Re: [RFC] perf tools: About encodings of legacy event names
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:10=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Mar 07, 2025 at 02:17:22PM +0000, James Clark wrote:
> > On 24/02/2025 3:01 pm, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Feb 19, 2025 at 10:37:33PM -0800, Ian Rogers wrote:
> > > > I knew of this tech debt and separately RISC-V was also interested =
to
> > > > have sysfs/json be the priority so that the legacy to config encodi=
ng
> > > > could exist more in the perf tool than the PMU driver. I'm a SIG
>
> > > I saw them saying that supporting PERF_TYPE_HARDWARE counters was ok =
as
> > > they didn't want to break the perf tooling workflow, no?
>
> > Doesn't most of the discussion stem from this particular point? I also
> > understood it that way, that risc-v folks agreed it was better to suppo=
rt
> > these to make all existing software work, not just Perf.
>
> That is my understanding, and I agree with them and with you.

This is describing what RISC-V have been forced into doing:
1) to support non-perf tooling,
2) because the perf is inconsistent in priority with legacy and
sysfs/json events.

Their preference has been to move these problems into the tool not the
PMU driver. What you are saying here is to ignore their preference.
I've already quoted them in this thread saying this, but this keeps
being ignored. Here is my previous message:
https://lore.kernel.org/lkml/CAP-5=3DfXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3Qhr=
Tg1mtBw@mail.gmail.com/

> > Maybe one issue was calling them 'legacy' events in the first place, an=
d I'm
> > not sure if there is complete consensus that these are legacy.
>
> I don't see them as "legacy".

So let me say this is really distracting from the intent in the
series. The series is:
1) trying to clean up wild carding ambiguity - not making it dependent
on the name of the event being parsed, the behavior of `cpu_cycles`
matches that of `cpu-cycles`
2) trying to make the legacy vs sysfs/json prioritization consistent -
making it so that `cpu_core/instructions/` encoding matches
`instructions` as we display both of these as cpu_core/instructions/
and it is confusing to a user that different encodings were used. We
also pattern match perf_event_attr config values in places like:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/x86/util/topdown.c?h=3Dperf-tools-next#n38
so >1 config for the same event means such pattern matching needs to
consider all cases.

There is now a  "Make Legacy Events Great Again" (MLEGA) effort that
is standing in the way of clean up work. As already stated but
repeating, why is MLEGA a bad thing:
1) legacy events lack descriptions and are open for interpretation.
For example, do the events include counts for things done
speculatively?
2) it is unneeded. Vendors can choose to name events the same name in
sysfs and json. ARM are achieving pretty much all of the same thing
with architecture standard events but in their use they will have
appropriate event descriptions for each model giving all the caveats
for the event. When something is common we can encode it in the common
json we don't need legacy events for this:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/common/common?h=3Dperf-tools-next
3) LLC doesn't mean L2, it nearly always means L3, the event names
have become obsolete and confusing. More MLEGA means more of this.
4) PMUs have only ever supported a subset of the legacy events. We
have to make use of legacy events in `perf stat` not fail when they
are implicitly added as default events and via the -ddd options.
5) multiple encodings/PMU types for the same thing complicates things
like topdown event ordering, that is a kernel/PMU restriction, and
metric event deduplication.
6) legacy events are broken on ARM Apple-M and have been broken on Juno boa=
rds.
7) architectures trying to push complexity into user land (RISC-V) are
being forced to push it into the kernel/driver.

Is MLEGA relevant here? Well if you want legacy events to be >
sysfs/json then yes. For wild carding I don't see why MLEGA cares. Do
I want to push on MLEGA? No, and I think the reasons above are why it
hasn't happened in over 10 years.

> > Can't they continue be the short easy list of events likely to be commo=
n across
> > platforms?
>
> That is my understanding of the original intent, yes.
>
> A first approximation, those who want to dig deeper, well, learn more
> about the architecture, learn about the extensive support for
> vendor/JSON events, sysfs ones, how to properly configure them taking
> advantage of the high level of flexibility both perf, the tool and perf
> the kernel subsystem allows them to be used, in groups, leader sampling,
> multiplexing or not, etc.
>
> But lots of developers seem to be OK with just the default events or
> using those aliases for expected events across architectures, sometimes
> specifying :ppp as a hint that if there are more precise events in this
> architecture, please use them, for instance.

When and where have I said that I don't want to support events like
instructions and cycles? See above, consistent wild carding and the
encoding priority are the only issues here.

> > If there is an issue with some of them being wrong in some places
> > we can move forward from that by making sure new platforms do it right,
>
> And adding special case for broken things when we know that some event
> named "cycles" shouldn't be used for sampling, for instance.

What is this? A new framework for special casing PMUs and events,
where we're maintaining lists of broken PMUs and changing encodings?
And tooling like event sorting, metrics, is all supposed to just work
with this? Are we going to write json for this? Who is writing/testing
it for Apple-M?

Special cases should be the exception and not an expected norm.

> > rather than changing the logic for everyone to fix that bug.
>
> Right. And again, if something doesn't work for a while in some
> architecture, its just a matter of specifying the name of the event in
> full form, with the PMU prefix, etc.

So MLEGA would like sysfs/json when they are broken? This is just
silly, if something is broken we should just not use it. Having 2 ways
of stating something and expecting different behaviors from them is
clearly brittle.

> > For the argument that Google prefers to use the sysfs events because of
> > these differences, I don't think there is anything preventing that kind=
 of
> > use today?
>
> Indeed.

I explained that in the context of why legacy events are wrong. I've
repeated it above. This is not addressing the issues of wild carding
and the encoding priority.

> > Or at least not for the main priority flip proposed, but maybe
> > there are some smaller adjacent bugs that can be fixed up separately.
>
> Yes, and work in this area is greatly appreciated.

I don't know what your proposals are and to my eyes none of them have
ever existed, no one has created them in over 10 years.
I am trying to fix wild carding and the encoding priority.
Bike shedding on MLEGA, please can we move it to a separate email thread.

Thanks,
Ian
