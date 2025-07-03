Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339553365
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Jul 2025 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751514332; cv=none; b=tnTuQyXmlO/3nlxdEMm5wk/lOxnUxtxsh9gLn9iIRKGqcX39mZtVIGW756uI0vIrpOGEFeJXy9ZMJcu+qdpdci/Kdg9Acp2YQHARMVh5tY9LZ0dWr23he6ILXmwnspL7QZfOol2r1NO0HnO8RORwJuV6y6Ey6iP4yt6yfWP/m6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751514332; c=relaxed/simple;
	bh=4GdcrjfvQWdgelhDLWcQPzqnyTyKDTaFyKAS0EHNcDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjzVwPG4ZSSoqDZEhYFN2yQmtyjjglBZRwrbG0eiPQT+3YT2z+UbJ6oTug9D17Jl5D5Mmx7w8r0C49JlEOPn6jy7ZlawbipKdfmMuGecQSF+AuF1CL6E3u8sw324DGhM6gdXZJBk/Oc1JaByuU6yIs297Pjzc/CSdWoNusXFEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zsnkZomT; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zsnkZomT"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so127325ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jul 2025 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751514330; x=1752119130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDWofyikxgAby3E+Q/6GP+cuqkz+oCYSVWUcRwa5HlY=;
        b=zsnkZomTrGzSNSmdyGepFKtx76OCRwHB3T6lKWDVJRmhFFQLz4Te8L+uhkjwA0QOTw
         eQIRtMU7YDsHOUflpKihGSWhqj1UXKAcNvp9wvPqDtgzK5PiU/HoHLYjahi9gk+NxW/4
         lqeLicXRARhcn88vitD7d1F5C8OuztqtLNgBsr4/pwh+ErIYp51fCxO0uwmVVOETw7K5
         RoEhZ7i8WGhR9AiSGl0xGYd9r2+d/XGnx3kp8Cq+BCwJrD4zD9mNygc2OSkcdGoYzna/
         MijYT3KT2nC+4Z4r0ujwwNB0z5oOJzRCAVJUu32D7OZ8VMoJyPgmvSsrKRqpzBi4uo7F
         cZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751514330; x=1752119130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDWofyikxgAby3E+Q/6GP+cuqkz+oCYSVWUcRwa5HlY=;
        b=AFHyU4ObZvjkzfCe2bYB/pePHnsF0vBM3SEDzmV+JxAXrSvTWtOKKq/rsbOqJGsRsx
         +haAXDb6rMkkolp6RGahmnc0wywUwa8RmC71FTkax3a8sMv5awzCy6HHZqnSyGC30Tzj
         FzgRxQ2/glhX85KJZvgeHA0MtmgMDTCfdFsmnTsYMTfriqq7MTW3rzep1q/qijhsE4Jr
         rlLUMtjyOsYCpwyeyxEMstp2w03IoeecAHLq6kCSohjYRfDpNJyGi6qRfCqFxeVQexae
         +kZkVwQ7uhsZoljzjoJa2BL/zDCYTSs5OhRZ5Lvtx29+7ZHWz8DesiE6kGFWQ/dHZ1w7
         dxhg==
X-Forwarded-Encrypted: i=1; AJvYcCUTWBjDcDFhOGhT895ZkAFbGd0eCM5ENJA3cd9FRG1dzF/wDU07EBeGJTTKlBd74e/7RNOCir7nzpe6Mg1we5/D@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnteQbqgCGXzLCPdGRbedumEWPsYkGg0vmo9aGCOJmW+Lj1pH
	r/mL09QTnohyNq+HMlEME/0frJaMK2vpY+tGCeKNZaCumRoGQ0Igpl2MCgHPhcdopbnaDP8k0zz
	34oVUqwUcntRBf3cjiE4EhtSC/CUX0j3WmInD/FH6
X-Gm-Gg: ASbGncsfXHqXmDWZBOSqKraapXWcnt/W9exOLbdEUZEfNIqkQLtbibw76m2iTfcSh7P
	JqBv3oiu6q2y/dHu2be07V24HnQqOCkQwscs4F2DjituJdt1yKaKWRGezv6W040mzXLfPzsBslF
	ftTmQNtsHLwNt0OUk5Vkh8nIxyXmFErPhAFhg6rNJK67AH
X-Google-Smtp-Source: AGHT+IGigOGHKR1OKei6llPQJNr2padfok25eTJWSFN+CoLzKy97HkPYRmaIV6tVfjlKhqIFtjbGuk5nRPbIu5WQrEg=
X-Received: by 2002:a05:6e02:3007:b0:3e0:5511:9796 with SMTP id
 e9e14a558f8ab-3e05d239337mr1635885ab.1.1751514330009; Wed, 02 Jul 2025
 20:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703014942.1369397-1-namhyung@kernel.org>
In-Reply-To: <20250703014942.1369397-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Jul 2025 20:45:18 -0700
X-Gm-Features: Ac12FXxa_W9a-oE_jO77-zvKjtu2PHdq5PT0jO1zmeclhFiNuV2WlouuvaN4Mbw
Message-ID: <CAP-5=fWyb54utMyi0uKj6ek4qBmHmX2Xr9RR=s4o-ek5HdHHnA@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf sched: Fix various memory leaks
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> While running the new perf sched test with ASAN, it fails due to
> memory leaks.  They comes mostly from missing thread__put() but
> sometimes it needs to release other data structures.
>
> Fix those leaks and add more subcommands to the test.

Thanks Namhyung, it may be worth adding Fixes tags for the benefit of backp=
orts.

Tested-by: Ian Rogers <irogers@google.com>

Ian




> Thanks,
> Namhyung
>
>
> Namhyung Kim (8):
>   perf sched: Make sure it frees the usage string
>   perf sched: Free thread->priv using priv_destructor
>   perf sched: Fix memory leaks in 'perf sched map'
>   perf sched: Fix thread leaks in 'perf sched timehist'
>   perf sched: Fix memory leaks for evsel->priv in timehist
>   perf sched: Use RC_CHK_EQUAL() to compare pointers
>   perf sched: Fix memory leaks in 'perf sched latency'
>   perf test: Add more test cases to sched test
>
>  tools/perf/builtin-sched.c      | 147 +++++++++++++++++++++++---------
>  tools/perf/tests/shell/sched.sh |  39 +++++++--
>  tools/perf/util/evsel.c         |  11 +++
>  tools/perf/util/evsel.h         |   2 +
>  4 files changed, 153 insertions(+), 46 deletions(-)
>
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
