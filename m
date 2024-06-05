Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB44154445;
	Wed,  5 Jun 2024 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619356; cv=none; b=s7IgMZ/QFM7wrISWMuB6vTOXr9t66IW+b6kNIKmBINfXN3iuz5UonZtNI5Nqthnh0TV1UXJsMGc9XTdjAHa/fmmo+zt5lrHEF/BWA1VMVGjdzvEqTJ1Bdo/ERwK6m582K7mA5tTPKsxCu+BqXik98zlrq3q+/mlt6ptLEsZf7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619356; c=relaxed/simple;
	bh=DSPArV6Z2a+KiBRCJYvaAfEOU6EEf7btH5Yz6Tj4aFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SU8Kmtx5/+k/m/7dSjVRADAQq1kCr5SmFLHYNR9yyhNwq0CJsGcz57szzkjxzQExI2hT6KeL/6UqmYc3xrzdqjG/8ifwNXHAfVIyX/PAQwo6nNkEX49jqrNAkDUnjThpigBGT3iMXNHXu/JwtXvHrbVPYZQI/l8Y7pWcnUNzfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6ce533b6409so146370a12.1;
        Wed, 05 Jun 2024 13:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717619354; x=1718224154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhdufPka7d0xOyoq7UULW75JegC/mKKmmURDvjgZle0=;
        b=Ed40CuwPZbkqzGqWq0qg/FkNwzRt6F/yJQQvvsfgjkWgCN2GvqtsDStWcQUpIraUh/
         HrPMnEPkXDTQfrs8kFMolVTZ4fdMnf7OyuMlq5EaPNxtB8Y3zmjdoZkctTwOEkRxhaXA
         6Z+JngW/fpVE1zGehI8AToO3WEpiskF3v2MLyddBD9zdOgPVJ0kz9oLWoAp0KBcy9y4Q
         W6Dld3RRFQY84V+MKBCe5TNl3Nq6yFI6/mvCYRjHp3gQllpb0CKMiFi/dXc6AuY66rdN
         xx5IxZao1Y3JAFzW9CsOE6r704Cs2J+btrKv0DYVkk5GMEPr0dKSJijDYTK6xh/6JY1c
         Q/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTYA8lhX0W2IinltRvOnlSrnlqVEeZKwa7gfEV63KZ0YXKjeokG7SPswswlEpI+ZK4qq+AGDtwY9mpKk/bOLFPXXRIxcJ3UrurpMYOj/Biim3Tn3uW4JR+qvTsfcbLYI5kG+W7vR8aFtZQhJ9D5A==
X-Gm-Message-State: AOJu0YxtBhhF4wpzQZg0LQimgjhq3ZlGBsDcIdNb8oHz3Mi28KHMa18l
	gfwtrnvV5HBGPsXNtnaiQCi1mUmM7zpWRQx52E+t6vlzmAhrUEB097pTqU1vFd5vfSznCzj5E/J
	kW7SsJv3ARks9uEWsfCUfMxiBxa8=
X-Google-Smtp-Source: AGHT+IH5uNmAxDcdzsCFM4a/9AobJg9GTU5KIYQ+XRPCpQ5Xi3Rpiz98QpzyR58SjaHzzjs7RXCTqegJDsGySG127kM=
X-Received: by 2002:a17:90a:3489:b0:2b5:6e92:1096 with SMTP id
 98e67ed59e1d1-2c27db19e2amr3616189a91.28.1717619353917; Wed, 05 Jun 2024
 13:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1> <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com> <Zld3dlJHjFMFG02v@x1>
 <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
 <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com>
 <aee9254e-81c1-464a-8a28-f971615baffc@arm.com> <CAP-5=fVynt-8cH6Jc5VyfBLBOqkF+v_7kknHdUPZBM1r3WwhTQ@mail.gmail.com>
 <ZlkC_Tm6kKIL3Phc@google.com>
In-Reply-To: <ZlkC_Tm6kKIL3Phc@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 5 Jun 2024 13:29:02 -0700
Message-ID: <CAM9d7ciTbHngfimDNsXS_adR7xg4ZHvSHzVhAzuQ6o-nQ2nsMQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, May 30, 2024 at 06:46:08AM -0700, Ian Rogers wrote:
> > On Thu, May 30, 2024 at 5:48=E2=80=AFAM James Clark <james.clark@arm.co=
m> wrote:
> > >
> > > On 30/05/2024 06:35, Namhyung Kim wrote:
> > > > It might not be a perfect solution but it could be a simple one.
> > > > Ideally I think it'd be nice if the kernel exports more information
> > > > about the PMUs like sampling and exclude capabilities.
> > > > > Thanks,
> > > > Namhyung
> > >
> > > That seems like a much better suggestion. Especially with the ever
> > > expanding retry/fallback mechanism that can never really take into
> > > account every combination of event attributes that can fail.
> >
> > I think this approach can work but we may break PMUs.
> >
> > Rather than use `is_core` on `struct pmu` we could have say a
> > `supports_sampling` and we pass to parse_events an option to exclude
> > any PMU that doesn't have that flag. Now obviously more than just core
> > PMUs support sampling. All software PMUs, tracepoints, probes. We have
> > an imprecise list of these in perf_pmu__is_software. So we can set
> > supports_sampling for perf_pmu__is_software and is_core.
>
> Yep, we can do that if the kernel provides the info.  But before that
> I think it's practical to skip uncore PMUs and hope other PMUs don't
> have event aliases clashing with the legacy names. :)
>
> >
> > I think the problem comes for things like the AMD IBS PMUs, intel_bts
> > and intel_pt. Often these only support sampling but aren't core. There
> > may be IBM S390 PMUs or other vendor PMUs that are similar. If we can
> > make a list of all these PMU names then we can use that to set
> > supports_sampling and not break event parsing for these PMUs.
> >
> > The name list sounds somewhat impractical, let's say we lazily compute
> > the supports_sampling on a PMU. We need the sampling equivalent of
> > is_event_supported:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/print-events.c?h=3Dperf-tools-next#n242
> > is_event_supported has had bugs, look at the exclude_guest workaround
> > for Apple PMUs. It also isn't clear to me how we choose the event
> > config that we're going to probe to determine whether sampling works.
> > The perf_event_open may reject the test because of a bad config and
> > not because sampling isn't supported.
> >
> > So I think we can make the approach work if we had either:
> > 1) a list of PMUs that support sampling,
> > 2) a reliable "is_sampling_supported" test.
> >
> > I'm not sure of the advantages of doing (2) rather than just creating
> > the set of evsels and ignoring those that fail to open. Ignoring
> > evsels that fail to open seems more unlikely to break anything as the
> > user is giving the events/config values for the PMUs they care about.
>
> Yep, that's also possible.  I'm ok if you want to go that direction.

Hmm.. I thought about this again.  But it can be a problem if we ignore
any failures as it can be a real error due to other reason - e.g. not
supported configuration or other user mistakes.

Thanks,
Namhyung
