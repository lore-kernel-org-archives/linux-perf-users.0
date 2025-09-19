Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759A2D12EB
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2025 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319869; cv=none; b=Tvjl63YFfaqGOVPJyk5RWOXv9nUNnrRMSMqFcVc0FtXUdNhONv+eYvgVzCtuvCsKo7TcqEZGh8LPTqaNtYT9EhZeK2bJR7LwuKMCwB/IF1T1M2l5lp/boZtByzCtldEsIKbmGI6u0UOGeCzgR2Cxr5eR3JLZc0ZnbkonezBI6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319869; c=relaxed/simple;
	bh=w3oJMiMy/aLfHezdZGx/BpfVJ2MO14O0I8TbLPG1uS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upR7hClPwhg2aycNTwG8de3FBOYyGTwRuucbGkx0Wh8nXE5u1l7NR77Fg41/G/8L6x/3ytqeNKqWmDufH0DfTP2vsJ9Oa+6SYphmEe8wqLUlNPBUxWUlpd/CL0d4ideRjuAKz6jIkU4g/496pEloP98DKJybUyHddxd6mu5STH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPzEreIy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPzEreIy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-267c90c426dso22925ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2025 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319867; x=1758924667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX4JHkNOYAmPpt72XdQ/NCCC4rGEcC8ljrTMPvj15/8=;
        b=XPzEreIy18lK7so8IsZyKT9XCMHe8JLN/rE4zTKylXqg1lcKJsdEiGYGvulmu7SoKT
         G/YOtmlCbmKibM55luMDeusqj54iXpubl34KCavaRLEooHgA5oztlYzPKPH829Ou2wX8
         lWFTnjWnzF6YCYhQPOuuXsFmdMZ9/9zndcqXS6GkOM1aUtNwT6OygDWDNP1hGDmcnGXa
         GFlFtd7ecjIIPzcsnZebKmxbtYGy9LLdJbTeOVOkYFG8iXPmV/sle2XY4qT80sOfG+Ho
         GyzuMNFjTj/LHG9AyAg8Hca3m3mQurCHBiGkmMF3Q5Z4lEtp2hQheo43YBVu/zbFB1c6
         WpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319867; x=1758924667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX4JHkNOYAmPpt72XdQ/NCCC4rGEcC8ljrTMPvj15/8=;
        b=wA9orHF4zn9KOLcqLINb67tvEajo/CUKoXLa9lNzG+vKP9fGD2mg5x0qS5x3RulWKX
         2X7WklV7NeuY4siH5k9gBvLjkIdoZZISdFFOj69PSZf6s76r5ZMLHsccoH7Rvm1/M8YX
         fBuNmkV+v3InYjHJ7j+PWEQ7qEc0BLLkagPy8sf+kTSBpx0pYE6LAsv0p9NtO7BsyckO
         aTWekh5XLcoD6gCJDvcbQctbFhLZO6IDmUoAp8RNqxaa4i1gJw5lYXSXyypqFDZHT0mc
         HdRZltVI0yBbRbhm0eHujL33L+Skbh8qp0vfeaF+ThRSmDyyP1IIiFOmbI5skEiFxc4O
         3tWg==
X-Forwarded-Encrypted: i=1; AJvYcCUMusu8sD85n1naRmdxxJWgqFbPAW0mvlH8ZVzVFIdfPTj2Dz4NAux2I4eA1iAIMiSQ+PoLP0RWZSJyHrj0qBAi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5uEll24WFrlz+iUviZrPE57h76bGiBOm5GxhsDDMpFt7GS+BG
	Zg35DjE5LLYctOgnFSMdC0lw3HoHsYAtFxhpFBkPzK5gauMld6y2Yz2wzaLD4zyArPJjNhwrUtr
	sGIkrxx3lSoVM7Gq2u6p2DrmhxPMBz3kBEIp3c921
X-Gm-Gg: ASbGncu/5GO3JQMlTAQmWvQ3y+YCHM+DbIBDQObjH8v4dxA1Pu6jaFrT/DRtVu7gfeR
	IINIVH1xqnGZObcX35oAaoo03zRLNWbUlkNRle87QwnnNTWnvqeysYDqGvedAlSPVDs3T5Xg07o
	t/GVDIBuSmtF7BCXWGcEu8b+029ksM3tyu37khEgn9+Al6W/RD7gpI4GKvib4oB7re1PpC9IUtv
	vnAvnGr
X-Google-Smtp-Source: AGHT+IF/XR6LN5y4L+t7CKVYTAqBZoNs51oFnPwlGtIk3O6dMLUK9rU8e8/WIsxecWYhSWgoXJllAjBjq2aRcxX2H7g=
X-Received: by 2002:a17:903:8cc:b0:268:cc5:5e44 with SMTP id
 d9443c01a7336-2680cc56199mr15292315ad.6.1758319867269; Fri, 19 Sep 2025
 15:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919210654.317656-1-acme@kernel.org> <aM3SCGOXZsP3GZal@google.com>
In-Reply-To: <aM3SCGOXZsP3GZal@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Sep 2025 15:10:55 -0700
X-Gm-Features: AS18NWBEtBFiKxbXwIB2OP1ZK_tima4hdB102zVpZWyZu-THdQ6NV1-Ttk8CJ_E
Message-ID: <CAP-5=fX6=7Ycp=Su2ahZS1R0wS9s4eozPPcBgMBG25UCaC6uBA@mail.gmail.com>
Subject: Re: [PATCH 0/2] LIBBPF_DYNAMIC=1 fixes
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Sep 19, 2025 at 06:06:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi,
> >
> >       Please take a look, noticed after processing a patch from Ian
> > for another such issue, on a hurry now, haven't checked when that
> > emit_string was introduced.

emit_strings was added in Linux v6.17 and libbpf was tagged as version
1.7 prior to that.

Thanks,
Ian

> >
> > - Arnaldo
> >
> > Arnaldo Carvalho de Melo (2):
> >   perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
> >   perf bpf: Check libbpf version to use
> >     btf_dump_type_data_opts.emit_strings
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
> >
> >  tools/perf/util/bpf-event.c  | 2 ++
> >  tools/perf/util/bpf-filter.c | 5 +----
> >  tools/perf/util/bpf-utils.h  | 5 +++++
> >  3 files changed, 8 insertions(+), 4 deletions(-)
> >
> > --
> > 2.51.0
> >
