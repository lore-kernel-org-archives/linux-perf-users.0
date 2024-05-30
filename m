Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C217622A
	for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076782; cv=none; b=SknAka/L9LjUIF4Sb2IG+oF9GRzYKx7qGaiWSCuJXKN1MXGfXcd2Re2K9GdgupUpuR0A4EgB0i8HtTS4i8QFrLs4oCFDCe/4zHPJeojPWM6CmffygOVc9Tt6p48aEaWoFQSmaB6rP4F8YA1npaV53pCTzYQaL/LdswG/bqLDVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076782; c=relaxed/simple;
	bh=JFhwaAacDH2z63xbkQsWA6Css5WAh1oUSYItrm83lWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTv30/BTuAXAIgwE3Mc7zEiX7tSAQGn7DOU/qIEh+K1bEJW/2EtzBC5GZIIwcLFeZWtk6OBBWSmqTj6mVfQSQQe++peihCx9+67kLNpooZRJTWTazIIO/JJlaIW9Mz7qRyVWqIDoohvULHWBhY9cQIO4FuU2QlaP9Um5YPJ9+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UL4Pb+s4; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UL4Pb+s4"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36db330403fso139395ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717076780; x=1717681580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tAW56zJXvgRLAmYST/Io71B8Ofionrgt6hjpIXJJGc=;
        b=UL4Pb+s4NQhgijASnZp82eLZ3oOsA5zO+Ca4bZzL1v04YjOqU5eShPeV9rKPEpSATT
         xt6h6w8f4Rda5jCpYSuJXf7OwJlJtExZ+cjAowgp9h9Kt45zlrStlmXWbeUPmMIy+YmN
         NBQTO52q+gEbtJYZXT2yf9JXNjkSfCKBQ0Xs8lKoK/nqH3GP0+o/n4rAr9jE053KS02S
         TljbfJvJ95+sl4Ks62bIKT0pifc2A2EMoHt0tIL4K5vOMfvgS9OeerclnzqlqsCr6E0e
         w//VFMUqLDWUaCOWdFcVIaZyLGN7v7VsBLvyU6EB6iamq9Vx+EszeTv+i17aV0CzsfIf
         Cd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717076780; x=1717681580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tAW56zJXvgRLAmYST/Io71B8Ofionrgt6hjpIXJJGc=;
        b=T1B9liQD64ctmIcDzQ2F1iVmhi2TlFZ69Fys4Ibfn2rlZSU1hTSwNnGV5nKHpIQ5/u
         U4Z1STWz2pU5H8h+i/GT52yMa6UtO9oYcTjj0jy8PUpuhsie37KpBZKQiMMbH3Jrd4af
         31Ny6DRNrpxu6mTcKRQcl1GC4odUXyR4FWi/i+lAYreEDyKWyvUrq3D9z88vuCj/Ww8O
         e6AfF4yNMY58uOi0/bgUriuVgh85I9ZzPpsN9/yk5KYon/MPvpqloesU8molUB1H7H6u
         lx1ApQcM8UJuz196p2E/WB2E82ptmbPzWB4D9L3kN9Bzv8aGzSMqdNJ6/X6Cwma8G/24
         WIUg==
X-Forwarded-Encrypted: i=1; AJvYcCX0yO3Vw7GGzBctl22Wa+yTKKaEfhaT7sNPgndnmFgE9+5RmVZTQ5HFuS6a9WusalFmceaQhVdqX4mBJbmaNukalS1WpyMspKvu51RkjHVW/g==
X-Gm-Message-State: AOJu0Yx2mx8+3GeCKka4BHv21oiw0O9PzezoN0D+VAF1g4dgMiB+mV0W
	kGjmibDCDGh0F82jO29ewv29yZ9bP1xSf+NnRr4zESRrHil+gq8y29GpGWrLAdgmjx9vNVPHkHJ
	L+9RrIEnW8i41md+MvocmOwrO/QAZTUU6no3/
X-Google-Smtp-Source: AGHT+IEyAuInFjHx7KG16qBdLUdsFf378Z5CdrJ1/5+qsnKJZNM4MXmhxPvQfwY5UbONxye9naaTSBh4wYxBYV8w9Pw=
X-Received: by 2002:a05:6e02:16ca:b0:36d:cb9e:a0da with SMTP id
 e9e14a558f8ab-3747df9d137mr1748365ab.25.1717076780225; Thu, 30 May 2024
 06:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1> <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com> <Zld3dlJHjFMFG02v@x1>
 <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
 <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com> <aee9254e-81c1-464a-8a28-f971615baffc@arm.com>
In-Reply-To: <aee9254e-81c1-464a-8a28-f971615baffc@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 May 2024 06:46:08 -0700
Message-ID: <CAP-5=fVynt-8cH6Jc5VyfBLBOqkF+v_7kknHdUPZBM1r3WwhTQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: James Clark <james.clark@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 5:48=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> On 30/05/2024 06:35, Namhyung Kim wrote:
> > On Wed, May 29, 2024 at 12:25=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> >> We can fix the arm_dsu bug by renaming cycles there. If that's too
> >> hard to land, clearing up ambiguity by adding a PMU name has always
> >> been the way to do this. My preference for v6.10 is revert the revert,
> >> then add either a rename of the arm_dsu event and/or the change here.
> >>
> >> We can make perf record tolerant and ignore opening events on PMUs
> >> that don't support sampling, but I think it is too big a thing to do
> >> for v6.10.
> >
> > How about adding a flag to parse_event_option_args so that we
> > can check if it's for sampling events.  And then we might skip
> > uncore PMUs easily (assuming arm_dsu PMU is uncore).
>
> It's uncore yes.
>
> Couldn't we theoretically have a core PMU that still doesn't support
> sampling though? And then we'd end up in the same situation. Attempting
> to open the event is the only sure way of knowing, rather than trying to
> guess with some heuristic in userspace?
>
> Maybe a bit too hypothetical but still worth considering.
>
> >
> > It might not be a perfect solution but it could be a simple one.
> > Ideally I think it'd be nice if the kernel exports more information
> > about the PMUs like sampling and exclude capabilities.
> > > Thanks,
> > Namhyung
>
> That seems like a much better suggestion. Especially with the ever
> expanding retry/fallback mechanism that can never really take into
> account every combination of event attributes that can fail.

I think this approach can work but we may break PMUs.

Rather than use `is_core` on `struct pmu` we could have say a
`supports_sampling` and we pass to parse_events an option to exclude
any PMU that doesn't have that flag. Now obviously more than just core
PMUs support sampling. All software PMUs, tracepoints, probes. We have
an imprecise list of these in perf_pmu__is_software. So we can set
supports_sampling for perf_pmu__is_software and is_core.

I think the problem comes for things like the AMD IBS PMUs, intel_bts
and intel_pt. Often these only support sampling but aren't core. There
may be IBM S390 PMUs or other vendor PMUs that are similar. If we can
make a list of all these PMU names then we can use that to set
supports_sampling and not break event parsing for these PMUs.

The name list sounds somewhat impractical, let's say we lazily compute
the supports_sampling on a PMU. We need the sampling equivalent of
is_event_supported:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/print-events.c?h=3Dperf-tools-next#n242
is_event_supported has had bugs, look at the exclude_guest workaround
for Apple PMUs. It also isn't clear to me how we choose the event
config that we're going to probe to determine whether sampling works.
The perf_event_open may reject the test because of a bad config and
not because sampling isn't supported.

So I think we can make the approach work if we had either:
1) a list of PMUs that support sampling,
2) a reliable "is_sampling_supported" test.

I'm not sure of the advantages of doing (2) rather than just creating
the set of evsels and ignoring those that fail to open. Ignoring
evsels that fail to open seems more unlikely to break anything as the
user is giving the events/config values for the PMUs they care about.

Thanks,
Ian
