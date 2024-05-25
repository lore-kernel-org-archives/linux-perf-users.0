Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9ABE6F;
	Sat, 25 May 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716622691; cv=none; b=RjpNEOnBPrK9llNxp7i+gn9KK5RKstmtgLbF6cL2DerCrSZpdhqyMvIJlC3r8VHVlboOwlBlwj4VeNLzL3sp0nkxdc9TD9KS/asevhKuQbEbKS7CUXy0JXGRronGp/hvQX93y3N82RkOjCC4nuyrEwDqhSzwRKrAktEhyW9Waxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716622691; c=relaxed/simple;
	bh=hjnFQGsTJPR8cRFI+tzxhz1tkZh4lBxpR3/xX+fvjJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W48pQZumYGfPJV0Hlh5X5uU769l2W63u6NZR2T08nGKkh/A5QBr2wXrFcErZY2ygOm2XnoYwXIa7WPdhDDJeVpQOPzBaS8r4RreDEKl/c+OXLLKZthk/jzwU1QIxmYXMziQ0P5ijjvQlVKFqigWktIWM4eiPUbpmoDmYbhCJNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-656d8b346d2so4131609a12.2;
        Sat, 25 May 2024 00:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716622689; x=1717227489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjSDPJ3ndkcl6uhv0oiHbgYv63rSd+FyYBnXbtqOYhg=;
        b=manLXTVNhGBqJV3TNl4vkqHosGzzf3H9fmYpKpk8sBJiS9mYZofQ8Lh0iaP7mZhXRF
         0c/R3DQdmM9it0pjDpVrbuFpuImUNQtNtIz6ARfArxdq0mzYNqZDLTAImgPsZshqzpa1
         /LgKcYYgR4cFfdnQXxZT1UfRVLItnQjwPMc16OHRwhGkIPjthEZlUfckUGf1BS51CpD1
         ygOgPlZKoSTSgO4AR7gbDY0s0EawPO8dA5xK42MZNMAFVIKkzzRRPaH12XZAC7h7159b
         divceGNCiumoYVs3KlIykPhdXXDlVRQhS46MbYmNONaicVSu/rQz0zSlq1CO0w/Z6dWQ
         Ne/w==
X-Forwarded-Encrypted: i=1; AJvYcCXgiUDUykQcBCr0GMviewfNHz/HoX2jukHYO9LaAfNtJve1eDqu2qFbLD9YbWcjTe+x1Lev9gW7wEmntDNZ1MNxaxXRMigC0PRT1ICbzWv3Lk1DM1o76o7sL/LeY6vb5N3ENzz+ei4hq4pvBHaZmA==
X-Gm-Message-State: AOJu0YzFNnwFuRtuXAvqVymnKQL97Wko6U2l87Q6LcEL9HkoJcrxozrL
	UNmHH3O3W2T+So86pBGI/Q36zBI7N7LWgTajCKd7azud8DO2tdC3CwlFZsuRqsjO0ElwnHfwvI7
	N4z2RjmF/NFeFdL2ZnJIeva2NeN4=
X-Google-Smtp-Source: AGHT+IHye6O0IdalgUS2IBMSDJiqTD6MjEHp+CyiIXyHMvmWb3eLtGiSu5COu7sJMX/b2rFNmcx7d6BsqIVlCA1j2tY=
X-Received: by 2002:a05:6a20:3cac:b0:1af:d1b2:4c21 with SMTP id
 adf61e73a8af0-1b212dee2dcmr5320981637.41.1716622689230; Sat, 25 May 2024
 00:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sat, 25 May 2024 00:37:57 -0700
Message-ID: <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Ian Rogers <irogers@google.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi guys,

On Fri, May 24, 2024 at 9:20=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 24 May 2024 at 20:48, Ian Rogers <irogers@google.com> wrote:
> >
> > Thanks for the report. TL;DR try putting the PMU name with the event
> > name, so "cycles:pp" becomes "armv8_pmuv3_0/cycles/pp", where
> > armv8_pmuv3_0 is the name of the PMU from /sys/devices.
>
> What? No.
>
> If that is the new rule, then I'm just going to revert. I'm not going
> to use some random different PMU names across architectures when all I
> want is just "cycles".
>
> In fact, the "cycles:pp" is a complete red herring. Just doing a simple
>
>  $ perf record sleep 1
>
> with no explicit expression at all, results in that same
>
>   Error:
>   cycles:P: PMU Hardware doesn't support sampling/overflow-interrupts.
> Try 'perf stat'
>
> because perf *ITSELF* uses the sane format by default.

Yep, so I'm curious what makes it fail.  IIUC the commit in question
would convert "cycles" event to "${whatever_pmu}/cycles/" if the pmu
has "events/cycles" alias in sysfs or in JSON.  But it should work after
that too. :(

It seems my system doesn't have the alias (both in x86_64 and arm64)
at least in sysfs.  I think that's why I don't see the failure and maybe
there's a specific hardware issue - like a M1 macbook issue?  IIRC it
required the exclude_guest bit to be set, but I think we handled it already
so this must be a different issue.

The error message is for EOPNOTSUPP, and I don't think it will set any
special attributes for the default event.  So I have no clue yet..

Thanks,
Namhyung

>
> So ABSOLUTELY NO. We're not changing the rules to "You have to know
> some idiotic per-architecture JSON magic".
>
> I don't want any excuses like this. No "You are holding it wrong".
> This is a BUG. Treat it as such.
>
> And yes, "perf record -vv" shows that it apparently picked some insane
> arm_dsu_0 event. Which just shows that trying to parse the JSON rules
> instead of just having sane defaults is clearly not working.
>
> So here's the deal: I will revert your commit tomorrow unless you show
> that you are taking it seriously and have a sane fix.
>
> Because no, "You are holding it wrong" is not the answer. Never was,
> never will be. Things used to work, they don't work any more. That
> shit is not acceptable.
>
>                    Linus
