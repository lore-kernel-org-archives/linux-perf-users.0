Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8F41760
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379683; cv=none; b=hPsqIss4s5uT3ppmp7ftoFhwAPoLjtUih8O878SFUolNWP6qFC6Dvp4cBg4cznG+NupubQTd/ud9Sj8VSJPZOSZDhcsMl/ybKwR4I9oWeBS6vXolMGkZE3XuWOTU6CBtODHm0uAmsZu61BBAfE9dqWRA2XCJJnBy7BWc/CDxxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379683; c=relaxed/simple;
	bh=Q/my21LU81QWCNduAB8QYEpDktC2vzKK8+QiMKR3Ovc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qMgcu7NR/2d11y+2eHl+8VZoy8tNZgQ0GEbWIhMLEgvJkXD5GRyhxJczILtiEa2uy5Tp8+akERmtOkfAcv2OplFzYMhJ3Xj6F/vp+LZRWQj6AMdhu3r762zGaC1YOJ/FycRP2UC8hWvNdgsvmoxc/esmD3va/C3vRH4JlHOoWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHYr9pzu; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHYr9pzu"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso18835ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748379681; x=1748984481; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saRBnVAV9ald8ATB6pKTuzMNGlKbn7cHBliMBSEPoXM=;
        b=tHYr9pzujXAH14Ia0e2mIIWYtThauQgJ0pR+Gw8ZoWmnjUoD5x3pUtjrCYLPnkNEK3
         xBHJ2QJ2ktNPCmHlsLNRCrWlqhsSZ5kGv20jPVpZC1Vq7k4e985uFL/8u/FHDjdJ/NFr
         dSiERyU4C8hqwNxSkqv8xKGMie/51kK9l3KXQhvPk3FMvup11OvKJwuDPs5XWZBiAPsw
         781ir7HzVNpLsmMXgiwwVpfSK9zGqZ5FHilJnxp805u2i5BjeJJWJ6KlNEOC0o6Mrk8G
         c5Xlyo6KIkfA3owsGOflOf4l6kuavsZYsR4wXgb7AIOip6SEqfrYWXRs7aEdWvOWVnM0
         TA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748379681; x=1748984481;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saRBnVAV9ald8ATB6pKTuzMNGlKbn7cHBliMBSEPoXM=;
        b=vVXfMMSX9WUiO6OI59ZyNWqCLL9YbE/IjJ4geBhb+79ikvTP7X+R39K4RnR+jyvOad
         GsKbVUWu0EwAFt/9eqlj4/fSHBDsVjfoB5Zj8lYC+ClmlZ0hikb1T66qDxBOMGmjA0a3
         bbP5fat9faeIw6Nr0d0X12hwdwPum1maloqJVJhYEJTBWQUKtIcD4VZZj7yEz1GoOwxG
         OwMd5jY/E5J9AR4n4QAUOxmcHLZsufv8X9dUeKZwRZBU/OC2a1USkdEEzV8xJ8DoUi67
         347dbG/YVnqOBIOaIcNyhOpu8pLjveBl8fG6atyZArIOz6WvRXYUvZG9OTTXhnMrUrz8
         In3A==
X-Forwarded-Encrypted: i=1; AJvYcCVMtVcTrr/waaJpePb1d1oGkM6SQlopqDzcqEA8rvN8N702JkyghuTTD3hV3f7+UKxmI2MVIitUq4Xlyb3laS8p@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBua9kz4BtwMkDi8hq659DocD9CamLB5NXiice6BRj1GjyeoV
	qJJ/lv33fA3yRpk1EV7zUwnDIP1aFgdD27pjWrPMFDMDuqTPcUreeNskObvyeci0u1v2vdUIsqa
	pL/PRuT8/8SesVQ1gAqBlFLV9v4k6b1DmlA8qvT6b
X-Gm-Gg: ASbGncvVbhm93UY3wAtgTEno0STyg4LTkb4aYEUqV80D90sEBDDOKrWC/Q8TOXm4/kE
	DQuwYO4ymezwl2KLB1jOt6RiYTLzL7xbawxaMNfuFAnzYUDdW01CoV5KbKvQ0dlCuMIywU4u5/3
	ZNov8AtaK+whH4N1E5fhWxX2hywNoV8rU3etVuFBwWx8kHoIzoF0R3/oJx0brO+Btx9ygP+eQyo
	tF80yB7ZSw=
X-Google-Smtp-Source: AGHT+IFGZy7sSmrUQDGt3B2pKCl4y7opyz0UYxFa5xUtmavk1LEzMR4Am76fNdf7KXmigSozBwZsxx9bF5jL7gv53+A=
X-Received: by 2002:a05:6e02:1c26:b0:3dc:8116:44a8 with SMTP id
 e9e14a558f8ab-3dd88fc27f3mr815995ab.26.1748379680474; Tue, 27 May 2025
 14:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521165317.713463-1-irogers@google.com>
In-Reply-To: <20250521165317.713463-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 14:01:08 -0700
X-Gm-Features: AX0GCFtlnVS6B_OGSV0n49shLWA_6YYzfymGUo6EP9yC_fUFq12D5mhe5n9VNOM
Message-ID: <CAP-5=fWWjx+SxwEHRY2Xju_0Bin3AypkpYz+8vnwuCd08Q1awA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Generic weight struct, use env for sort key and header
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 9:53=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> The arch directory is a barrier to cross-platform development as files
> and behaviors within it are inherently platform specific. Sample
> parsing should be generic but the PERF_SAMPLE_WEIGHT_STRUCT handling
> was only present if building for x86 or powerpc. The sort key and
> headers should be specific to the session that is being executed and
> not to the machine perf is being run upon. These patches clean this
> and associated code up.
>
> v3: Code reorganizations suggested by Kan Liang.
> v2: Avoid changes to include/perf/perf_dlfilter.h as suggested by
>     Adrian Hunter.

Ping. Thanks,
Ian

> Ian Rogers (3):
>   perf sample: Remove arch notion of sample parsing
>   perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to common test
>   perf sort: Use perf_env to set arch sort keys and header
>
>  tools/perf/arch/powerpc/util/Build         |   1 -
>  tools/perf/arch/powerpc/util/event.c       |  60 ----------
>  tools/perf/arch/x86/include/arch-tests.h   |   1 -
>  tools/perf/arch/x86/tests/Build            |   1 -
>  tools/perf/arch/x86/tests/arch-tests.c     |   2 -
>  tools/perf/arch/x86/tests/sample-parsing.c | 125 ---------------------
>  tools/perf/arch/x86/util/event.c           |  46 --------
>  tools/perf/builtin-annotate.c              |   2 +-
>  tools/perf/builtin-c2c.c                   |  53 +++++----
>  tools/perf/builtin-diff.c                  |   2 +-
>  tools/perf/builtin-report.c                |   2 +-
>  tools/perf/builtin-script.c                |   2 +-
>  tools/perf/builtin-top.c                   |  16 +--
>  tools/perf/tests/hists_cumulate.c          |   8 +-
>  tools/perf/tests/hists_filter.c            |   8 +-
>  tools/perf/tests/hists_link.c              |   8 +-
>  tools/perf/tests/hists_output.c            |  10 +-
>  tools/perf/tests/sample-parsing.c          |  14 +++
>  tools/perf/util/dlfilter.c                 |   2 +-
>  tools/perf/util/event.h                    |   5 -
>  tools/perf/util/evsel.c                    |  17 ++-
>  tools/perf/util/hist.c                     |   4 +-
>  tools/perf/util/hist.h                     |   2 +-
>  tools/perf/util/intel-tpebs.c              |   4 +-
>  tools/perf/util/sample.h                   |   5 +-
>  tools/perf/util/session.c                  |   2 +-
>  tools/perf/util/sort.c                     |  67 +++++++----
>  tools/perf/util/sort.h                     |   5 +-
>  tools/perf/util/synthetic-events.c         |  10 +-
>  29 files changed, 150 insertions(+), 334 deletions(-)
>  delete mode 100644 tools/perf/arch/powerpc/util/event.c
>  delete mode 100644 tools/perf/arch/x86/tests/sample-parsing.c
>
> --
> 2.49.0.1143.g0be31eac6b-goog
>
