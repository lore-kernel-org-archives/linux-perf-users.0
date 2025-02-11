Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F51D61BB
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739248815; cv=none; b=fs86mhWq8UNABWow2QbyfKdDWkCO5AUObwzRK8xQgs3lmccnFzI7rMLEClOEfsITed5uXWxUw0iDk8gsXOhbk6J6+e6tmJjsjHOaVdrrpFIL5dxr695ShpKsbjpfgsScRvUr3AKjiWSRE1UIS0KnAcV9GaorvFuttskWZvW5YjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739248815; c=relaxed/simple;
	bh=KjZJWe2Xw83p4NFLnWct8cxZoWEwdRwdsuigSWncIPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuTXISFAjy9QwMtn7E4wBe7Utb+I4IY7XL2XMEVTPQ8mfncTuNO08bd7fql/O25074aE4nnjlgbM0v3ImjLakerpXHg49gbYAWUIKW+LYnUH7kVRkbeD3O5MnQQ3PuFCaMxu1vJUkV9G/eEX7dTsIJrkYj8Mpb+fpmytEnofKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NugLugRJ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NugLugRJ"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so87175ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 20:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739248813; x=1739853613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa2G3g0oPa7vjziZL8NpG57mqXqHzcWkESMdTFy0AUI=;
        b=NugLugRJ3qGkLJS3A0XKKVeVQjmgOA6SOIzovZ4jKZcH0S4GwhozenJgoLXF25vKKz
         vMJd0/H4K3bRxakzeCARshBElEcZ0/1fZjtJwqWCWOrmN198Y4Knl6kwJQIBambg/Dl+
         /D64q17fq785zKRaEbFc1Fa1dJ4GQsnI8sHL5PWzrH5hEwabQC+AgjR6rruousC+Sshd
         U1q7arVsJ0EcMSBWX+JFcMlN92ukpiUnp3MMjuZJun2oIKYregGA+rYtsMv0RT35WoBK
         xFhjcsnJcrfOY2Nyz9oPqSYE8dO0iQDvJdlFZ/0jApX2dq92z8zDTUUjt5tZgVdA0vv5
         WswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739248813; x=1739853613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa2G3g0oPa7vjziZL8NpG57mqXqHzcWkESMdTFy0AUI=;
        b=vlXVpcJPaFbbNHK8Wv0MdSYm9mV44XhbEmsGNqVzIk/l+jrkVXLagmtahG94ef3UHM
         LUxxELMDBP1mY9FIBEdnVJIrF9z0PvNTGlGW1po5sE6IAIcN/5Y1kfkRLvw8qogFPDDz
         n+Hux/cu3pSH3PH/2oUnpPgbjnjNxAkPCI9a0BV1sP1fLQjShmWOuK3MqwO4Jx9vRuMo
         BXkVk3Z7dsMPk5UHdXqMiXITSR9RtL6qgrUCXzYWGDe/J4+ZML+z/z6LYxg9zQh4p0JP
         plikQPVwN+Lie3GfMox7SHJW2YerKxCsaIAtM506iTjVXdie038jBmhCIVLhQ5G8AOPt
         cr5A==
X-Forwarded-Encrypted: i=1; AJvYcCUqr0A9ojihRLlIqcsA5vhYLbp7qEJppjBMo88yV9qi4Mnx3fZD7t0K4w/+0FhH8CuQNCfVimVpyalXbk7kZ4y4@vger.kernel.org
X-Gm-Message-State: AOJu0YxL1lq96B0iWGoddDp0JBkMgoMmaxII3rVdmaSSDn/1GQHTm8lc
	DU1pYQuiKe2lIAAD/LIvXsfc+1i24sD9rZ6fl8ej0hOSBnwr6oIGyoFiJ8ta+eN0/w4VmT4pnl9
	yR8fOrJJaUms2m0lAY/o6ZGTEIa6vEjJsKteL
X-Gm-Gg: ASbGncvHBiViqOdHxkXUpyMjzffz8sCeozOHKcAj5zLVBPsNRf27SwLBFG+jn7Q1UR2
	HjjryfuF20OSqbtwrTKG9dxVTCURhBI8e59emH+jfQpRsWz+yIOFIfLiPtj5ngIoMtGZrJmnQkw
	==
X-Google-Smtp-Source: AGHT+IEz/1QIrihND6gMY/qBTZdB9aN8LV8UtPv2CeJAaJKuj0E6k2b9wNLVeXRhZ9G7oMKbCcrtyIprFboyGjukIzY=
X-Received: by 2002:a92:cd87:0:b0:3cf:a4e4:8f85 with SMTP id
 e9e14a558f8ab-3d171e08ab8mr1140695ab.7.1739248812964; Mon, 10 Feb 2025
 20:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com> <Z6panMzNSm1op8Di@google.com>
 <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com> <Z6rAHhAIdlkAryGJ@google.com>
In-Reply-To: <Z6rAHhAIdlkAryGJ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 20:40:01 -0800
X-Gm-Features: AWEUYZkgnnTHSPlleAkMnoMrbqcxvjana0ia-6yjrNOLIpXXRYQB8fsb0_912xE
Message-ID: <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Hao Ge <gehao@kylinos.cn>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 7:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 10, 2025 at 02:06:18PM -0800, Ian Rogers wrote:
> > On Mon, Feb 10, 2025 at 11:59=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Sat, Jan 11, 2025 at 11:01:33AM -0800, Ian Rogers wrote:
> > > > Rather than scanning /proc and skipping PIDs based on their UIDs, u=
se
> > > > BPF filters for uid filtering. The /proc scanning in thread_map is
> > > > racy as the PID may exit before the perf_event_open causing perf to
> > > > abort. BPF UID filters are more robust as they avoid the race. Add =
a
> > > > helper for commands that support UID filtering and wire up. Remove =
the
> > > > non-BPF UID filtering support.
> > >
> > > Hmm.. then non-BPF build cannot use the UID filtering anymore, right?
> > > Also non-root users will be limited unless it pinned the BPF program =
in
> > > advance.
> > >
> > > I think you can keep the original behavior and convert to BPF only wh=
en
> > > it's available.
> >
> > Using BPF when available would be limited progress. The issues I have
> > with not removing the existing approach are:
> >
> > 1) It is broken
> > Scanning /proc for pids and then doing perf_event_open means that any
> > time a process exits the perf_event_open fails.
> > Steps to reproduce:
> > This bug reproduces easily but if your machine is lightly loaded in
> > one terminal run `perf test`, in another terminal run `sudo perf top
> > -u $(id -u)` the perf top command will exit with:
> > ```
> > Error:
> > The sys_perf_event_open() syscall returned with 3 (No such process)
> > for event (cycles:P).
> > /bin/dmesg | grep -i perf may provide additional information.
> > ```
> >
> > 2) It is a work in progress that isn't progressing. Scanning /proc
> > will only tell you about started processes; it won't tell you about
> > processes that start during the profiling run, whether it be perf top
> > or perf record. Extra work would be necessary to make this most basic
> > of use-cases work, perhaps you could use tracepoints to capture
> > starting processes and then enable user profiling on those processes.
> > It would be horribly complicated, suffer from delays between observing
> > things happen and doing the perf_event_open, biases in the samples,
> > etc. I don't expect anyone to do it, especially when BPF filtering
> > already solves the problem better. There have been 13 years that
> > someone could have fixed it.
> >
> > 3) it adds significant useless complexity to the code base. Having
> > 'user' in the target makes it look like perf_event_open can work on a
> > pid, system wide or user basis. The user basis doesn't exist so the
> > majority of the code base is just ignoring it - search for users of
> > uid_str on target. Those that do run into problems (1) and (2).
> >
> > 4) It is redundant and leads to confusion with BPF filtering. Having
> > the BPF filter on evsels is non-zero cost in terms of the code base
> > complexity, but it is something broadly useful. As user filtering has
> > never worked (see above) it isn't broadly used but is adding
> > complexity. If both approaches were wanted then it is unclear what the
> > code should be doing, presumably the mish-mash of BPF filtering and
> > /proc scanning that happens today and will be broken due to (1) and
> > (2). Putting everything into the BPF filter makes sense as you can
> > combine a BPF filter with an additional BPF filter on user.
> >
> > 5) It is untested and adding a test leads to an always broken test due
> > to testing being an example of where things break, see point 1 and its
> > example.
> >
> > 6) Nobody wants the non-BPF approach. As it was broken nobody used the
> > previous feature, maintaining it for no users is overhead. Let me know
> > if someone is using this option (I doubt it given points 1 and 2) and
> > they wouldn't be better served by BPF. People building perf today have
> > to explicitly opt-out of wanting BPF in their tooling. I posted this
> > change a month ago and nobody has jumped up saying please don't remove
> > the old approach.
> >
> > 7) The interaction with this feature and changes in behavior, say
> > ignoring events that fail to open, is non-obvious and not testable as
> > testing would be broken as the functionality itself is broken. Having
> > the broken feature hanging around and being untestable means that we
> > slow progress on new features, testing and other improvements.
> >
> > Yes, we could try to fix all of that but why? Nobody has cared or
> > tried in 13 years and I would like the tech debt off our plate with a
> > better approach in its place.
>
> Thanks for writing this up.  I agree BPF approach is better but it has
> its own limitation - basically it requires root.  And I know a few of
> people who don't use BPF. :)  And maybe we need to check if user passes
> filters to the event already.

I thought you were working on making the BPF filters pin-able? So root
could enable the filter but then users have access to it. You have to
be root to be looking at other users in any case.

> Also, I admit that I don't know who actually uses this.  But I can say
> sometimes people uses tools in a creative way.  Anyway, I can imagine
> an use case that system is in a steady state and each user has dedicated
> jobs.  Then scanning /proc would work well.

Another one for Google's tree then.

Thanks,
Ian
