Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799532C60
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915675; cv=none; b=INr1bS2srcVF28n4rmAn0KZkzQ0p6xtJyNCbalYdIjsd2/fR94OM1fdFyHUHZIv1/D0kEoWsGigp+gsaD5C87Gog1ohKojsALFW8NIvqN6Q1GTR/U0q31p432a6BYEHd2dJPUFwwqhdOSAlU50I3J5ZvliY/K4+FYiViZEaSwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915675; c=relaxed/simple;
	bh=feMQYk5ll/UDjxgT5zNSpH57cGDia9+FZhGt72Oky/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlVpJXpBmLLwn8Nx3ObMT69dX+C5IO/NRoMdxEogTLyeRmJ4bbimfG+0E1nQ1hFdHlswwif2ShXLmcE3UNiqa5Jsn9dg1P87wW7Wfda0kTfAz4k6+4nHey0DuBiKQWDr91ShcDZ2hxKkEyfEWIR2Y7p4am2hYsm9r2+Zc/KRfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TdbBK+u3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TdbBK+u3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52961b77655so1297225e87.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716915671; x=1717520471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ptvt4RiRJWpe5klhAWgPxYGDIFS0i3pz5gYd8Yb78nY=;
        b=TdbBK+u3ll61vb8tVy8UZUAx5/mnkAdFP3W/nC67fvEwb7F0tbLblVOIfEPLWHNWkn
         N8plsxS5EpzkpbixHh2kdABAhXi98W1nxE7w/bUn8430NBjvtEnkizbNN3q3KJdR25V+
         Y0bne62VXPEOEm1CgSGCwiNWNjTYjr3afCHmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716915671; x=1717520471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ptvt4RiRJWpe5klhAWgPxYGDIFS0i3pz5gYd8Yb78nY=;
        b=lk1aeXvVVIawAmpw+AlYUji+LA6d8vT1K5dQvDuPLDTiNIzLnk3b5+5KqF8Z6VdSPv
         AtBzBoIWPXV2NMDnm1nOrrrcbFCQzhomlbMLRnK1wIKfETalp1m4SXQpMxkzSqxTljjT
         bJWxghKmH4BZGs0uJXGjOsCInX+ZwJfQ+pepGVcD+1vn1rKZ1SOU1mCkZa/C5FCO05Nh
         S5ggibd99A+60pLnaQEB0CNW6XAEfMj9+QiRsd2mqzt18SHbYVNWKcOqdLYMrIlaDrcx
         DrTp393RzpVru4rNAvpVhDPI9iHsImaRuLh8poHf+l5Y73MMhmtnCx9QlGD7uW7dM0Tm
         DM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWU3H3U4YpKdo3KLgG5yEbRiSyCtgMV1KLWApryGNilHKFrwU+Tl6LE8ShW5Bng16iH5I2gdOadrOKRkUOx35Iy4BGZ/KwND/H9I70A4rkzqQ==
X-Gm-Message-State: AOJu0YyW2rdx98BBrlLgFjsyo+L7Yq8cjZ93uuRIzkONJi/sNzR9ABFF
	ZmRarO0DwQSowt5dPlaTfXRLR3kDNZO3OeY5DXvz6c4QGb4BaUPerjbNPVB5EuNzK4C9a11D2IV
	OWaeP1A==
X-Google-Smtp-Source: AGHT+IGqeBfApoAQZF5n7KSaDun92SDwWWsug+qwqTLgzOXCTSU2YyrqAgGA13bpYJYbdhb4pKVtfQ==
X-Received: by 2002:ac2:58f7:0:b0:523:88d8:67cf with SMTP id 2adb3069b0e04-52965198fc4mr7008683e87.36.1716915671166;
        Tue, 28 May 2024 10:01:11 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4f81csm625872066b.119.2024.05.28.10.01.10
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 10:01:10 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so144024566b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 10:01:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFGs2mhqi0SnC8aSnMx4jLenm2TNX1eLa7+1n5TRSj7SB51stS30u/3bCVYkuMjqYj8co2Kh8Bb6djJChPFcnLjTpya512CiBECOfXhEbucQ==
X-Received: by 2002:a17:906:581b:b0:a59:c9ce:3386 with SMTP id
 a640c23a62f3a-a62643ebafamr933551766b.33.1716915669945; Tue, 28 May 2024
 10:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 10:00:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
Message-ID: <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 May 2024 at 22:37, Ian Rogers <irogers@google.com> wrote:
>
> If you do:
>
> $ perf stat -e cycles ...

You always talk about "perf stat", because you want to ignore a big
part of the issueL

> The issue is about legacy events.

No.

The issue isn't "perf stat".

That works. Even with the broken version.

> I have a patch that's WIP for this, but I also think we could
> also agree that when >1 PMU advertises an event, perf's behavior when
> matching should be to open all such events. You avoid this by
> specifying a PMU name.

Christ. You're still ignoring the elephant in the room.

Stop using "perf stat" as an example.  It's bogus. You're ignoring the issue.

Lookie here:

    $ perf stat make
    ...
     Performance counter stats for 'make':

              5,262.78 msec task-clock                       #
1.195 CPUs utilized
                46,891      context-switches                 #
8.910 K/sec
                     6      cpu-migrations                   #
1.140 /sec
               198,402      page-faults                      #
37.699 K/sec
        10,238,763,227      cycles                           #
1.946 GHz
        16,280,644,955      instructions                     #    1.59
 insn per cycle
         3,252,743,314      branches                         #
618.066 M/sec
            83,702,386      branch-misses                    #
2.57% of all branches

           4.405792739 seconds time elapsed

           4.287784000 seconds user
           0.921132000 seconds sys

but then

    $ perf record make
    Error:
    cycles:P: PMU Hardware doesn't support
sampling/overflow-interrupts. Try 'perf stat'

because that broken thing (a) picked a different cycles than before
and (b) your argument that it should pick both IS WRONG BECAUSE ONE OF
THEM DOESN'T EVEN WORK.

Why is this so hard to just accept? Why do you keep mis-stating the problem?

How hard is it to realize that I DO NOT WANT "perf stat"? The perf
error message is bogus crap. If I ask for a "perf record", it
shouldn't pick the wrong PMU that can't do it, and then say "do you
want to do something else"?

I don't care a whit for "legacy events". I care about the fact that
you changed the code to pick the WRONG event, and then you are blaming
anything but that.

If perf would go "Oh, this one doesn't support 'record', let's see if
another one does", it would all be good.

If perf would go "Oh, let's prioritize core events", it would all be good.

But no. Your patch actively picked a bad event, and then you try to
blame some "legacy" thing.

Yes, the legacy thing picked the right event, but it's not even about
legacy. You could have picked the right event any number of other
ways.

It's about "it damn well worked when you didn't go out of your way to
pick the wrong event".

In other words, this isn't about "legacy" and "new".

This is about "right" and "wrong". The old code picked right - for
whatever reasons. The new code picked wrong - also for whatever
reasons.

Don't try to make it be anything else. Just admit that the new code
picked the wrong PMU, instead of trying to make excuses for it.

               Linus
