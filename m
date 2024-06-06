Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F619D890;
	Thu,  6 Jun 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657787; cv=none; b=YaMQStQqrqBXPAm9PuXMCmdb5/GVmiIMklDbOxjae1gUtkeO0pcCpfWv8W5y6kixR/0vLZEuC/DRC/4cispfSATJKM1SH1MZiaaJIQulUq4wKBMwJ9m5UPJTrkRX/AEF9ORQmu0BVihhQshWC9NQ4OFRD0BxO0CE1kSUN/ZaLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657787; c=relaxed/simple;
	bh=T3FIcYCGvpLO0Es2jtoQNLujuS2R1njurpgfnkXnNBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRExMIzbQ7XCAukTudLbEbIjzvujPyhfgAGAiOfS5xSZmI6hKVnRrUGCnLdtf+EAYSZRIlpm9YbsdSKdrJdBylxF7vkMHjOPGZZxVNJmqx3vJXUKKyjO9FoogfK0AdkXf70rbV/yzkbCCqkFHb4BFbxRLlhIZevYr1D4XiUvEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7024426c75dso589704b3a.1;
        Thu, 06 Jun 2024 00:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717657785; x=1718262585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5K2xyTAzxaR0U9go7UapE5gZnzt95HLEb+vCp9VKKQ=;
        b=ZK0A+fqr851lYBGdKbCmgKRePrndXKfHYgA+8fAV1j5IqKOMSIprbONuKTVW+JQeUi
         qGMePfndJJOd3P0+oR1L+lKaG5Smv2m7A9aftZcXi9bQsu93eLaLjmqYq/w4TuXZPTTQ
         9sjx200UuEd9KpjcttfY1UrdrLIP2JtiQxzDfYLBkmynLJdnPBEs7KOX/Df7OaFZnsLW
         Lh2ql3EhNFcENh9C8P+BNFkwR9isD0TIxa5uSCkUBKbDuM1IiY7dmdZLFNL5I3ZhlvAz
         AMKl/ME1LF7QK7/W0RGUOAe5MPW+3UWW9N5vkcHXzpBLaq2AIdxZJArjDODs72G7YnL5
         uYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZTJfOYefQnEm2RQRs1L2JlrkWax/65S2i2czsd3fnLIgPtPzH7C2GOGMOuzfS9YChV3/O4Qs10LKpVJhc/sIk9SCreqIAeTHEbdmJowpF5EKI1YPswaEKmgNiYMH//uw4+sHxjXdF8f/GTfOtA==
X-Gm-Message-State: AOJu0Yx6LK7d87q9i0CKuGOsjlnUvghOhjE+Tzlo91k06nG4guF5vBQB
	doTIWsU36LNHO3RK+uofz/AEH6tfyt3lAuDSJBRRuNIxkaez1Cygbs7D8GMhCt1fcAqHYDw9vid
	JBr75WiDqUW4nq4JgNqo9tjpkaqA=
X-Google-Smtp-Source: AGHT+IGUQVD5oP/h+g7p4Z9RknbNvOeKZgxHu7O0FIq6dNXT/Ihg9tfh8TRxNh5txyJ6lqp6Cc9fijGMoWo084p0Rcs=
X-Received: by 2002:a05:6a20:7348:b0:1b2:3ab8:5194 with SMTP id
 adf61e73a8af0-1b2b6f4efedmr6283266637.23.1717657784964; Thu, 06 Jun 2024
 00:09:44 -0700 (PDT)
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
 <ZlkC_Tm6kKIL3Phc@google.com> <CAM9d7ciTbHngfimDNsXS_adR7xg4ZHvSHzVhAzuQ6o-nQ2nsMQ@mail.gmail.com>
 <CAP-5=fUq6jLCtjPNb0gngtR0cXopG+-mJ-+CnEOAXeG7VShh8A@mail.gmail.com>
In-Reply-To: <CAP-5=fUq6jLCtjPNb0gngtR0cXopG+-mJ-+CnEOAXeG7VShh8A@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 6 Jun 2024 00:09:33 -0700
Message-ID: <CAM9d7cjPe68PMb1hnbypMOQUQOybpisdqH3eTH1B9G-KG5rKXw@mail.gmail.com>
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

On Wed, Jun 5, 2024 at 4:02=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Jun 5, 2024 at 1:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > On Thu, May 30, 2024 at 3:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Thu, May 30, 2024 at 06:46:08AM -0700, Ian Rogers wrote:
> > > > On Thu, May 30, 2024 at 5:48=E2=80=AFAM James Clark <james.clark@ar=
m.com> wrote:
> > > > >
> > > > > On 30/05/2024 06:35, Namhyung Kim wrote:
> > > > > > It might not be a perfect solution but it could be a simple one=
.
> > > > > > Ideally I think it'd be nice if the kernel exports more informa=
tion
> > > > > > about the PMUs like sampling and exclude capabilities.
> > > > > > > Thanks,
> > > > > > Namhyung
> > > > >
> > > > > That seems like a much better suggestion. Especially with the eve=
r
> > > > > expanding retry/fallback mechanism that can never really take int=
o
> > > > > account every combination of event attributes that can fail.
> > > >
> > > > I think this approach can work but we may break PMUs.
> > > >
> > > > Rather than use `is_core` on `struct pmu` we could have say a
> > > > `supports_sampling` and we pass to parse_events an option to exclud=
e
> > > > any PMU that doesn't have that flag. Now obviously more than just c=
ore
> > > > PMUs support sampling. All software PMUs, tracepoints, probes. We h=
ave
> > > > an imprecise list of these in perf_pmu__is_software. So we can set
> > > > supports_sampling for perf_pmu__is_software and is_core.
> > >
> > > Yep, we can do that if the kernel provides the info.  But before that
> > > I think it's practical to skip uncore PMUs and hope other PMUs don't
> > > have event aliases clashing with the legacy names. :)
> > >
> > > >
> > > > I think the problem comes for things like the AMD IBS PMUs, intel_b=
ts
> > > > and intel_pt. Often these only support sampling but aren't core. Th=
ere
> > > > may be IBM S390 PMUs or other vendor PMUs that are similar. If we c=
an
> > > > make a list of all these PMU names then we can use that to set
> > > > supports_sampling and not break event parsing for these PMUs.
> > > >
> > > > The name list sounds somewhat impractical, let's say we lazily comp=
ute
> > > > the supports_sampling on a PMU. We need the sampling equivalent of
> > > > is_event_supported:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/print-events.c?h=3Dperf-tools-next#n242
> > > > is_event_supported has had bugs, look at the exclude_guest workarou=
nd
> > > > for Apple PMUs. It also isn't clear to me how we choose the event
> > > > config that we're going to probe to determine whether sampling work=
s.
> > > > The perf_event_open may reject the test because of a bad config and
> > > > not because sampling isn't supported.
> > > >
> > > > So I think we can make the approach work if we had either:
> > > > 1) a list of PMUs that support sampling,
> > > > 2) a reliable "is_sampling_supported" test.
> > > >
> > > > I'm not sure of the advantages of doing (2) rather than just creati=
ng
> > > > the set of evsels and ignoring those that fail to open. Ignoring
> > > > evsels that fail to open seems more unlikely to break anything as t=
he
> > > > user is giving the events/config values for the PMUs they care abou=
t.
> > >
> > > Yep, that's also possible.  I'm ok if you want to go that direction.
> >
> > Hmm.. I thought about this again.  But it can be a problem if we ignore
> > any failures as it can be a real error due to other reason - e.g. not
> > supported configuration or other user mistakes.
>
> Right, we have two not good choices:
>
> 1) Try to detect whether sampling is supported, but any test doing
> this needs to guess at a configuration and we'll need to deflake this
> on off platforms like those that don't allow things like exclude
> guest.

I believe we don't need to try so hard to detect if sampling is
supported or not.  I hope we will eventually add that to the
kernel.  Also this is just an additional defense line, it should
work without it in most cases.  It'll just protect from a few edge
cases like uncore PMUs having events of legacy name.  For
other events or PMUs, I think it's ok to fail.


> 2) Ignore failures, possibly hiding user errors.
>
> I would prefer for (2) the errors were pr_err rather than pr_debug,
> something the user can clean up by getting rid of warned about PMUs.
> This will avoid hiding the error, but then on Neoverse cycles will
> warn about the arm_dsu PMU's cycles event for exactly Linus' test
> case. My understanding is that this is deemed a regression, hence
> Arnaldo proposing pr_debug to hide it.

Right, if we use pr_err() then users will complain.  If we use
pr_debug() then errors will be hidden silently.

Thanks,
Namhyung
