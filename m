Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CC84FCC
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225976; cv=none; b=FrEyuMbyZsCrwyhPO0pjVqFJyDCs+Ui8HSUx9TB7TZUJicbDoKV2Y0MXrwDYcSLqfQ4lOBcLG8TG5mxkRgb8+Ply2K1ofJLejQ/vntfpuc2cdxzvQdbx62ep2305nCWIaiXt38VNbgsrerAGk19tpCKblAqp5uN5OMgswSgxwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225976; c=relaxed/simple;
	bh=hPFWi4QxzNcEP51DZmP3MHWLX9GCVr2i2GLvwpb2egI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf2ok9a3h+2M7YFmO2c8Mcp6xZoqdKN4vIrCSmed083QBwZqC8ZqYeuNsu9rVXBBQcrH39aANIN2NSR64sqMwc8Q9LMk8QhsxmKamQWUuPQ6EMsU9T3ZJE059tvKgbtoZ/qTInUha8VHW+Nzn6rTXbahXzBJzS5NjDjbT9qpBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwaRogoV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwaRogoV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f61742a024so56695ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718225974; x=1718830774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPFWi4QxzNcEP51DZmP3MHWLX9GCVr2i2GLvwpb2egI=;
        b=TwaRogoVyuhOdbOfyGvSm6/hEfX/7oPcW0BRgxMAjFB7o80vqZ+GQVlbA5A6c6ExLd
         o4OpOqJhc/UTyDtMA3QtxpZ84Fz0s5TvhhU5M0Jk/5oeNj0Zrgkfpiva2IOwvD7plGKO
         d/mghP0RpQNo8xE9+H4YRU8rwdynLV5UNzmUgBuRYl7xVgY550+JVVtPHa3h+ozZngc5
         DTZSNSPOu6G+PwbKKO7VjiXmTvZGf4yung5VQpYNW7jAA2R5echo3a4qlyAnX7+7L97b
         2Odd8yGEa2u/sdT4J4VovV/Xi52EsKn9soCaTE7Hv5kxPXa57ABfcCAFrwjPFhVQKK9J
         uK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225974; x=1718830774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPFWi4QxzNcEP51DZmP3MHWLX9GCVr2i2GLvwpb2egI=;
        b=ltbI64khQNRrgyPQSVd4OzqJPFMF9F5ns01R+fa3J5CUNqSxsKCPfRjvitY520EBvo
         Ra+aVVANTLjgdiCz0jtYmCIzP9LquhxrF//tcFtY7HklZuZKv/I5R1IdBe7ptshg6WG7
         njfOoY7mJKTjlNcsNEohTPKt/pNDQ+WFYnUvgfBtOts32DrOcVDX9zgdRsM+7RYPEVk/
         6yyc7/+0Lpsf85+UxbOA/2kJ5hKOi1DnixYn6dLIkM4SST+o16Gn53IeCGYIqZF4Ksxd
         Paho+UcBE+ErL5l4swZ6Fh/2JlO5PNGz83oyGK3RjWAKB7EA23T97PTuLKZoMu1BLVix
         JPog==
X-Forwarded-Encrypted: i=1; AJvYcCXjAfiwmT1FUKKre34megLpBYBGQ2LWwzNUlwfq3hZwSbteKmOGdx+lNcysei7QCjZVsOExF/udB4+lCXUYuIc/xeKzq7io56r5iHZyoaq47Q==
X-Gm-Message-State: AOJu0Yyqj8rywL3j4dFnSv3vJXpzRdiaslwaWs2Q+duv+SArywvDGpXN
	tspsP6IcEA/ou7y8fj0oyKp3o/gNmoU2kVgkbuZjKQsPnmX2ukwjnh3aX/O6uQQeMhSLV26DlCQ
	0z9b4N8S7XkskddvHjJe07iq7y06QvnLQc3wY
X-Google-Smtp-Source: AGHT+IFWmsdEasPwyOynYBtzxGWhPDlYAW7MCo/VR6F7DeOyZ4t8Z05zsA0gmIZLPABsyF5wtAXUbmNxcWHTnKYlGWw=
X-Received: by 2002:a17:903:2b86:b0:1f3:3ede:9b0 with SMTP id
 d9443c01a7336-1f84fd58c5cmr833695ad.10.1718225974074; Wed, 12 Jun 2024
 13:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607065343.695369-1-irogers@google.com> <23ee1734-7e65-4f11-aede-fea44ada3cc4@arm.com>
 <CAP-5=fUP69NJ+j6+9rUnp+UPBxcopJ=BOY-LeOjs8vYdt4soMA@mail.gmail.com> <cc1b0673-13b3-439f-afdf-c9cb450f8fed@arm.com>
In-Reply-To: <cc1b0673-13b3-439f-afdf-c9cb450f8fed@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Jun 2024 13:59:22 -0700
Message-ID: <CAP-5=fUBsuOau6scssB_RL6uGczGfe8GHL2Cx-ZE1Oj7ZTZ4KA@mail.gmail.com>
Subject: Re: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline cpus
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 1:32=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
[...]
> >
> > Renaming of the cycles event in arm_dsu_pmu.c - I'd say this is a top
> > priority issue right now.
>
> I cannot promise this. The main reason is that I still believe the
> 'cycles' event (or, generally speaking, all events) should be managed by
> the tool rather than by the uncore PMU drivers. Additionally, the perf
> tool currently has handled these symbolic events effectively.

I don't understand this.
1) the PMU advertises an event called 'cycles' - nothing to do with the too=
l
2) perf without a PMU matches events on all PMUs. I don't know people
involved in the perf tool development who think cycles shouldn't match
on an uncore PMU, which was Linus' stand point and reason for
rejecting my fix in favor of a revert.
3) matching all PMUs wasn't the case for legacy events, like cycles,
but now we want it to be to fix the Apple M? PMU issues where legacy
events fail to work. The whole reason we changed the priority of
legacy events as ARM requested. It also makes things more uniform with
BIG.little/hybrid.

We can update perf record to warn (not fail) about not opening events.
ARM should do this as (1) and (3) were caused by ARM - I have a WIP
patch but I'm in no mood to finish/send it. Even with this there will
be a warning for "perf record -e cycles .." and fixing the event name
is the only way to clear that up without special case code or making
warnings verbose only - something that makes me and others
uncomfortable.

Thanks,
Ian
