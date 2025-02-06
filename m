Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCCB1FFC6C
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827912; cv=none; b=pm0II3Ff+GNXuz3y0WeauSLq4d+i08X9z8J01CrSn15G6wmb2fgLkQzLmtbO2YpUV5Tz3Xgn6rWaHlnD5R44QmDfILEw3MhMWzfpw2tGRomq75SwlQ19Dizm6Yr5XJ4GOQXYyQG8L6xizWgs2m242Ly5YOVMXSm1WYMbShP1sZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827912; c=relaxed/simple;
	bh=pd2E4DkV0kM5i7jjzzBFsQlRTZYRdJDV3yWx8ktjtsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suZcdce+D0FWln+2OKJcMou2mLyAhOjBB+PsrumpBtj96tVc1bEtxV4Qu2kVSIa/MOioYUPTxZ+yhdbNM84EsHQtIyHSu4+gfI+tGpLyup7DuLs4l9wh5W962USjQdM6A+gK+URvpZ2ZSSDKehXQ1tro7/gXgNw36Au3d0zhc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OldlMHlR; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OldlMHlR"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d05815e89dso74825ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738827909; x=1739432709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFjhp4JAR0g63YXhg7OTrrhc+8ZhArGsV0puAPZUzIE=;
        b=OldlMHlRdUWPrBNdhdrB4HmhGhhopxxT5XGtsyHy47JcyAEPKg24FyahkA5KPDJ10G
         BH1VBGqqYCBmLgOkc2I7rfPT/0pgCmLK3Sw8RBjxzSkOtFlFErfMlG0AhUIrUw5tq3M3
         dV4+HIt8MV54c8CkB9rfPmbZcWMH3ENzNYK/68dqX1CPRq/EfEYXolfBRdKo/UH0A01R
         1YjDlHutqBs69RKdYNV3Oy48HOVr1eUDbgyCsdC3Fs/hZwAEPtl+EQre22yibOUp+CJR
         +U68P4MLjgJlR4SSiW4mss0anOgjI40j5yAEhsiQXYXkEDfbq+rPCOrYGDjvMFhy4H6t
         yTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738827909; x=1739432709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFjhp4JAR0g63YXhg7OTrrhc+8ZhArGsV0puAPZUzIE=;
        b=KFphgvGfO1nzxhcpv9WUxf8EwTbivkBwm113EmokiYbPxp1zvK/2n8uxNzCk83ALzL
         k+pkL4vk2Pg84ybvXJ2WUHZ2ae2j/QwZEuUDy6qJ6+NqWsobKbanBFcIBl+1q6grJ7Jc
         TjE4KW1sT711fy56NEnUitL2FvHW3iJ2HX3pXWeXhnF8FBJVG6G8Wl4aGmvs8DglZ4GD
         WCWigk+Exuj9UMZp4K/zCPGgxwjnYIPyD/UieJjvKwE2ERIK6cwtEDMyTJ8qEfBZB+Tr
         KnSCeNF/LRNqr+eLqLdpCUODZxsLBCN+/WP880eGL6bimHk+iRmJtOgc7tcfD3gw94PC
         fNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvfNkwEHYtqP1Nm7TR7qBdsoVHyh6uHV0PMxDlj/4nkbLwnyPAUHhJNsmYRHARoPk8eZPBJdAp2B8ujw0Y5KMI@vger.kernel.org
X-Gm-Message-State: AOJu0Yww541DJum233aN7QElzmCXnqYU2j6sA6VLD9ou2MZLxm8A++tR
	mSSpw6sSMFh+DWmgWEjdTTb6T4q8VfM7Z0uFfGGAcb2GzthtdaGTmb3NtKQsWrudzvKeBoETw0z
	KQRMHFWo6EYzclzh6Jc032RuNogPbqOMq2VxX
X-Gm-Gg: ASbGnctFYVrWp+dC0BwsAmeoXcouNAjSnfj1HIoYGEr0RQxLugaebi3CKAD/f/whUBW
	1Ps89MYrzmoKXsmp/+ITEX1bEF7wgxksLhTz0IiLSnBmV0/96tXMmRB5Pc4u9HzmHEn70nCnnQw
	==
X-Google-Smtp-Source: AGHT+IFEkhAzhQt7bj284mzDkh6CvlLNsFBpXO81ntvqDy54Y2oL2L3N7xGnIq0lEfwpyQHxL/BIaNQW4c3RciaASB4=
X-Received: by 2002:a05:6e02:12c4:b0:3a7:cd21:493f with SMTP id
 e9e14a558f8ab-3d05d76e874mr1496745ab.26.1738827909071; Wed, 05 Feb 2025
 23:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z4f3fDXemAMpBNMS@google.com> <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com> <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com> <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com> <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
 <Z6LFp5jiED7_-weN@google.com> <CAP-5=fU6WSOK_N0NoLcMSSdaWAkdC2DUBwLqsLn_KA7m6dJyeQ@mail.gmail.com>
 <Z6RD7NuT9IPhOkIV@google.com>
In-Reply-To: <Z6RD7NuT9IPhOkIV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Feb 2025 23:44:57 -0800
X-Gm-Features: AWEUYZlERHrl9VStVAsu-lGlLnxk56tAdGd4eYDpAnruJOulDK3g982GeFJgu28
Message-ID: <CAP-5=fV8rRMQyMDuy1vcxyEX9Gf8x0QJdVEP-K5krBec_A7mpA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 9:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Feb 04, 2025 at 08:48:20PM -0800, Ian Rogers wrote:
> > On Tue, Feb 4, 2025 at 5:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> You mean the -z flag which is documented in the man page and also it the
> help message (perf top -h).  Anyone can read the doc can know it's
> there.  Of course, people would prefer reading zines than man pages. :)

I link to the patch. My point is that something as minor as making
"perf top" behave as "top" does was too big a (user command line)
regression to land - I strongly suspect nobody would notice. Your
proposal breaks all non-core events on every perf command that takes
PMU events. It is a bigger change.

> > So, it would seem to me that
> > changing something as fundamental as how all non-core events behave
> > would be seen as a regression.
>
> Yep, it'd be a regression.

Agreed, you are arguing for a regression.

> Which suffix do you mean?

It's off topic. ARM added hex suffixes to PMUs representing physical
memory addresses of memory controllers but then that makes cortex_a72
look like it has a 3 character suffix. So perf assumes hex digits more
than 4 characters long is a hex suffix, which of course it wouldn't be
for a1000 (which is also somewhat close to being an old Acorn
archimedes machine number ;-) ).

> Anyway, the person looked up the intel webpage would be eager to learn
> about performance related things.  Can we also assume if they also want
> to learn about the perf tool itself? :)

I'm not sure how turning data_read into
uncore_imc_free_running/data_read/ is in anyway helping people
understand perf? They want an event name that matches the
documentation, manual, web site. It is what the vendors I've spoken to
want as they use the event names across tools (fwiw oprofile doesn't
even have a notion of a PMU). To my knowledge the PMU names are the
wild west, often illogical and never mentioned in any kind of
documentation. I have a hard time explaining how the suffixes work and
I believe there are more conventions in the works where there can be
multiple what we are currently calling suffixes.

> If it's not the case, we have this:
>
>   $ perf record -e xxx
>   event syntax error: 'xxx'
>                        \___ Bad event name
>
>   Unable to find event on a PMU of 'xxx'
>   Run 'perf list' for a list of valid events
>
>    Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
>
>       -e, --event <event>   event selector. use 'perf list' to list avail=
able events
>
> So it says twice to run 'perf list' to see the events.  Then they can
> run either:
>
>   $ perf list | grep xxx
>
> or
>
>   $ perf list xxx
>
> to see the actual name of the event available in the perf tool.

Why was adding a PMU to an event name, working around ARM's PMU bug,
such an unsurmontable problem that the original change was reverted?
Because 1 person didn't want to have to write a PMU prefix and
considered it a monumental regression having to do so.

> >
> > Even with this what would be the behavior of core events? You want
> > legacy events to have priority over sysfs/json when there is no PMU.
> > You know, and have stated not caring, RISC-V wants different and that
> > it breaks Apple-M's PMUs for a fairly large range of kernel releases
> > including 1 LTS kernel - the only reason I'm writing patches in this
> > area in the 1st place. Software is soft and you can go fix software
> > anywhere in the stack. Listening to vendors and not breaking everyone
> > is the point-of-view these patches have been coming from. I find it
> > very hard to have a conversation where this is just forgotten about
> > and we're working on hypotheticals which seem to be both unwanted and
> > implausible.
>
> Sorry I don't want to repeat that too.  Correct me if I'm wrong:

You are wrong.

> 1. RISC-V is working on a solution with the current status and it's not
>    absoluted needed to change the current behavior.

They said to you directly it was what they wanted, that's why I
reposted this change and it is, has always been, in the cover letter.
They've then followed up expressing their desire for this behavior but
having to have a plan b as the original change was reverted and you
are blocking this change landing.

> 2. Apple-M is fixed already.

No, James tried to repro the bug on a Juno board, not an Apple M, and
didn't succeed. I don't know what kernel he tried. I was told by Mark
Rutland (at LPC) that the tool fix was absolutely necessary and the
PMU driver wouldn't be fixed, hence the series flipping behavior that
I thought Intel would most likely block and wasn't keen to do in the
1st place (not least wade through all the test behavior changes and
the bug tail). All of this was premised on a threat of reverting all
of the hybrid support so that Apple M could be made to work again, and
I was trying to do a less worse alternative.
https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com

> >
> > I don't know why people (yourself, Linus) keep wanting to show me the
> > perf list output. It is arbitrary. I rewrote it and changed the
> > behavior of all uncore PMUs within it (we didn't used to deduplicate
> > based on the PMU suffix). It is nice that people think it reads like
> > some religious text.
>
> I think it's what we want users to know how to use the events.

I don't understand what you are trying to say. I'm saying the behavior
of perf list in its output is arbitrary. We use the same printing code
for every kind of event. An aesthetic decision to put things on a line
does not imply that it is more valid to use or not use a PMU, it just
happens to be what the tool does. Did I break perf list as if you look
in old perf list you see:
```
$ perf list
List of pre-defined events (to be used in -e or -M):

 duration_time                                      [Tool event]
...
```
while now you see:
```
$ perf list
List of pre-defined events (to be used in -e or -M):
...
tool:
 duration_time
      [Wall clock interval time in nanoseconds. Unit: tool]
...
```
I'm hoping people find it useful to have the unit documented.

> > Why is the formatting different in perf list for
> > json specified events? Well it is because json events have
> > descriptions and the events you are showing with a PMU don't have a
> > description. I think because there is no description, an effort was
> > made to keep the output compact and put the PMU and event name
> > together. It wasn't trying to enter some kind of long lasting marriage
> > that the event name should only ever be used with the PMU.
>
> I like the description but I don't like the formatting.  I think I
> understand why it looks like that but it could be different.  Anyway,
> I don't think showing PMU name is related to having descriptions.

No, it has more to do with how I was feeling about filling in two
string fields called name and alias when rewriting the perf list code.
I added aliases containing the PMU name just to add a little bit more
detail when there seemed to be little documentation with certain
events. I never intended placing the PMU names into any events to be a
commitment that all non-core PMU events would need a PMU prefix and to
break all such people using those events.

> > What happens if an event is both in sysfs and json? Well the sysfs even=
t
> > will get the description from the json and then I believe it won't
> > behave as you show. Did the event get broken, as perf list no longer
> > shows it with a PMU, by having a json description written? I think not
> > and I think having descriptions with events is a good thing.
>
> That's bad.  Probably we should fix it takes only one of the sources and
> change the JSON event not to clash with sysfs.

No, you are talking about breaking everything already, let's not break
it yet further - not least as we lack a reasonable way to test it. I
think if you are serious about having such breaking changes then it is
best you add a new command line option, like with libpfm events.

Thanks,
Ian
