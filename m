Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054A1D54FE
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297209; cv=none; b=Bb3hj3bFdL93YWoSenXulW2IpwxtP+YGrPDbLTkJx/zz4YCjGwZm2YpnAecE5RcbGOTxl6D17TWgItgdzHO6KiJ874myIKl2Q+0wJmeZbW67BcRnd07ykRvEzgbKx+7z1j2MNZgKXpOS/zGvKuAYZLNTegjHRmSyDwLWBvzuo9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297209; c=relaxed/simple;
	bh=OytRgNPeKUnAoy0Vyg9o3zSBRo9UIoE+Y1y8QfRSSgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWABojZg6EVO+S+Cyyb7oAzVnKmsKeNZDhS0Kp53h+gBP4E0n1ezZExxGxy9LdWItCPLa+EFjsCoqJg1KapoSwV1+6FQxOwHKf4Mh3foeJyYw97AyojV7R67cEdMP1VnLI4xwCD+2Igtmt98DxTTMHVrYW4JlifxjWTVvSZJs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nT38f6NI; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT38f6NI"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d147331fb5so7925ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 10:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739297207; x=1739902007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzmurR78eCF1q/Efiyb54t1laawyXxvxmHWsMizBvSU=;
        b=nT38f6NIak60qeeMUOQmonvFk4zcLNSSnZyJy8F4Bd3LURhSj6oedqTCIGEyz0/MQn
         tRmpGFxydwfIBx+hN9kBPeWcZmnbdr0quGk5TnA+R7waZSfXCBpoTg7uwbG3YL86wxZ7
         +9UK2yv5w7/BYV/Pey475NU0OW72aLA4SJGRolWSxDeCXv0Uj8W1GJstcEFMxfQWfpQA
         QSGZZqST/achqRdP+rteQQRJSTQQDj3PuQBd8dWpaNo0cvSajmnZ0JoTKSkhjw58CUCk
         YlCYN1/7ayzhozETtbnvdifvNFoYkXuobB5kTtfWj9lm3ox6YVclhLJvVoCRhKX2UDla
         S/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739297207; x=1739902007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzmurR78eCF1q/Efiyb54t1laawyXxvxmHWsMizBvSU=;
        b=TbBprBbBV5pgnzYVEzscq7Ow1ytL+il0HKWTjbU6VYNyM/la66KyiR+T5ic4mkN2FH
         p0nKl+dn8944DuY/YLvphCa44XTNINQ8xjaRLBv8YRwkRrklToTHGiWmLJy7kgmGomVQ
         Z3O5elWHAndt4jdx+dWvUEAq/meEpTQB6Bafce776oh71OyUlxYrxP6DlcDcda5v4iMI
         FDtAE2z4oqDZ2B6hT7Hy1TVIYaCOW9Oo7tJEKZso0JkT4JLCCQAYFqTmuAHKe3Lpsws7
         9OxhFyaWq8Mj9tEBc9zpgbxPOPL0iYWrfkFSJDKQnAj02Pyz53U7cgWJ7iZsXdPw3XKL
         UTYA==
X-Forwarded-Encrypted: i=1; AJvYcCXOJbC9bl0RQ3/vkboHGkdyntybgzlcZ3R18VLM7SXcIHvvaqsLQi6aiZQuxpYDiEUtOz54Fkt3W9uvQYRvYh0i@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmrj25G5SxKgheW/O+qqGH+PrAGcQ58smlfQpxk4CTSKZb7tj
	KFwutS2PwlIqXjh7DoXCg+H25nsXx4Rpuzhtw0828l9QWO5NZwNHqoI7k53WRdedelFdblJlhE3
	krfpb1PYHLcBN6Nl0zqssKXjcmmWQJK4p/c1O
X-Gm-Gg: ASbGncu83s7ZOzL7J7xphVrIzV+ADm9fQ6K/Q5yAPGknyuaftgCqG7n4Fyd+6PYn/yq
	NAfhW6I+ZMgwYgt6WyxLfa4mlRp2hFq/iNa/hRysn9cJgFRhucgJjYj9J3Od4yyev3rAe4/M+xz
	sC6O0NV9L0KKu8cWQCk+fdT+pC
X-Google-Smtp-Source: AGHT+IEsfTzjtvmm1nvcqDS/HnNLh1LVTBfXEq3QQADjhxHZSSpHGhozWCxwrIVerIJHiJBKFpGrUB9GeZzRRQn90JM=
X-Received: by 2002:a05:6e02:1387:b0:3cf:c88f:2ce with SMTP id
 e9e14a558f8ab-3d16feee9dcmr4447465ab.18.1739297207049; Tue, 11 Feb 2025
 10:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com> <Z6panMzNSm1op8Di@google.com>
 <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
 <Z6rAHhAIdlkAryGJ@google.com> <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com>
In-Reply-To: <Z6uOGNO6p7i9Fese@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Feb 2025 10:06:34 -0800
X-Gm-Features: AWEUYZmkVoJa2KPOMj-kmrmsbLrNeuqFcPJxDJvle8dXEF_SwyY8bzGrcS0rWdQ
Message-ID: <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
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

On Tue, Feb 11, 2025 at 9:51=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 10, 2025 at 08:40:01PM -0800, Ian Rogers wrote:
> > On Mon, Feb 10, 2025 at 7:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Mon, Feb 10, 2025 at 02:06:18PM -0800, Ian Rogers wrote:
> > > > On Mon, Feb 10, 2025 at 11:59=E2=80=AFAM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > >
> > > > > On Sat, Jan 11, 2025 at 11:01:33AM -0800, Ian Rogers wrote:
> > > > > > Rather than scanning /proc and skipping PIDs based on their UID=
s, use
> > > > > > BPF filters for uid filtering. The /proc scanning in thread_map=
 is
> > > > > > racy as the PID may exit before the perf_event_open causing per=
f to
> > > > > > abort. BPF UID filters are more robust as they avoid the race. =
Add a
> > > > > > helper for commands that support UID filtering and wire up. Rem=
ove the
> > > > > > non-BPF UID filtering support.
> > > > >
> > > > > Hmm.. then non-BPF build cannot use the UID filtering anymore, ri=
ght?
> > > > > Also non-root users will be limited unless it pinned the BPF prog=
ram in
> > > > > advance.
> > > > >
> > > > > I think you can keep the original behavior and convert to BPF onl=
y when
> > > > > it's available.
> > > >
> > > > Using BPF when available would be limited progress. The issues I ha=
ve
> > > > with not removing the existing approach are:
> > > >
> > > > 1) It is broken
> > > > Scanning /proc for pids and then doing perf_event_open means that a=
ny
> > > > time a process exits the perf_event_open fails.
> > > > Steps to reproduce:
> > > > This bug reproduces easily but if your machine is lightly loaded in
> > > > one terminal run `perf test`, in another terminal run `sudo perf to=
p
> > > > -u $(id -u)` the perf top command will exit with:
> > > > ```
> > > > Error:
> > > > The sys_perf_event_open() syscall returned with 3 (No such process)
> > > > for event (cycles:P).
> > > > /bin/dmesg | grep -i perf may provide additional information.
> > > > ```
> > > >
> > > > 2) It is a work in progress that isn't progressing. Scanning /proc
> > > > will only tell you about started processes; it won't tell you about
> > > > processes that start during the profiling run, whether it be perf t=
op
> > > > or perf record. Extra work would be necessary to make this most bas=
ic
> > > > of use-cases work, perhaps you could use tracepoints to capture
> > > > starting processes and then enable user profiling on those processe=
s.
> > > > It would be horribly complicated, suffer from delays between observ=
ing
> > > > things happen and doing the perf_event_open, biases in the samples,
> > > > etc. I don't expect anyone to do it, especially when BPF filtering
> > > > already solves the problem better. There have been 13 years that
> > > > someone could have fixed it.
> > > >
> > > > 3) it adds significant useless complexity to the code base. Having
> > > > 'user' in the target makes it look like perf_event_open can work on=
 a
> > > > pid, system wide or user basis. The user basis doesn't exist so the
> > > > majority of the code base is just ignoring it - search for users of
> > > > uid_str on target. Those that do run into problems (1) and (2).
> > > >
> > > > 4) It is redundant and leads to confusion with BPF filtering. Havin=
g
> > > > the BPF filter on evsels is non-zero cost in terms of the code base
> > > > complexity, but it is something broadly useful. As user filtering h=
as
> > > > never worked (see above) it isn't broadly used but is adding
> > > > complexity. If both approaches were wanted then it is unclear what =
the
> > > > code should be doing, presumably the mish-mash of BPF filtering and
> > > > /proc scanning that happens today and will be broken due to (1) and
> > > > (2). Putting everything into the BPF filter makes sense as you can
> > > > combine a BPF filter with an additional BPF filter on user.
> > > >
> > > > 5) It is untested and adding a test leads to an always broken test =
due
> > > > to testing being an example of where things break, see point 1 and =
its
> > > > example.
> > > >
> > > > 6) Nobody wants the non-BPF approach. As it was broken nobody used =
the
> > > > previous feature, maintaining it for no users is overhead. Let me k=
now
> > > > if someone is using this option (I doubt it given points 1 and 2) a=
nd
> > > > they wouldn't be better served by BPF. People building perf today h=
ave
> > > > to explicitly opt-out of wanting BPF in their tooling. I posted thi=
s
> > > > change a month ago and nobody has jumped up saying please don't rem=
ove
> > > > the old approach.
> > > >
> > > > 7) The interaction with this feature and changes in behavior, say
> > > > ignoring events that fail to open, is non-obvious and not testable =
as
> > > > testing would be broken as the functionality itself is broken. Havi=
ng
> > > > the broken feature hanging around and being untestable means that w=
e
> > > > slow progress on new features, testing and other improvements.
> > > >
> > > > Yes, we could try to fix all of that but why? Nobody has cared or
> > > > tried in 13 years and I would like the tech debt off our plate with=
 a
> > > > better approach in its place.
> > >
> > > Thanks for writing this up.  I agree BPF approach is better but it ha=
s
> > > its own limitation - basically it requires root.  And I know a few of
> > > people who don't use BPF. :)  And maybe we need to check if user pass=
es
> > > filters to the event already.
> >
> > I thought you were working on making the BPF filters pin-able? So root
> > could enable the filter but then users have access to it.
>
> Right, 'perf record --setup-filter pin' would do the job.  But it has to
> be run in advance.
>
> > You have to be root to be looking at other users in any case.
>
> That's true.  But at least you can profile your processes. :)
>
> >
> > > Also, I admit that I don't know who actually uses this.  But I can sa=
y
> > > sometimes people uses tools in a creative way.  Anyway, I can imagine
> > > an use case that system is in a steady state and each user has dedica=
ted
> > > jobs.  Then scanning /proc would work well.
> >
> > Another one for Google's tree then.
>
> Any chance you update the patchset to retain the old behavior and use
> BPF only if available?

The point of the series is:
1) get rid of unnecessary notions of target, the uid_str, it is extra
complexity and doesn't make sense;
2) switch the two users of if to BPF.
You are focussing on the thing that isn't the main point of the series.

Thanks,
Ian
