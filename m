Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010E18C335
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430833; cv=none; b=Dbe3U9pensCfl2bYFcVHZ6WKT32bywrPtfZTucL7EL0ZngVGHgBxxdTT7m5zqYBiBshBugD1jD+rCMjEfBPUZ4avRDDsQCfNud/8UdVgfSdMxxsL6RsS1HyU5ySR0uvSp8oTXcCHlTNCNGTzjL32jQnP1c+LajDEPZ6QMCuHFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430833; c=relaxed/simple;
	bh=3Id3YShJvU/qzMpJxiLmIb/mHvhpyX85OyEo+GK4LaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUEyRCDf1suoqrTNU5LQ1U2bG2DJZGtiPzek4XsQG0+IS4lIgYHvyNU/0r+dxxql8R1kwyJ8Cca7+KotSonkjo2e+TbyGsbNNM8bq+f8A1gBMylglrj4NCLG3XZ3qP4vVeJ1OqtZhA8BFzWCSQE1GrniV5vZSz7C0sYLA2exKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqoE63Rh; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqoE63Rh"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a36ad4980bso91195ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Oct 2024 16:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728430831; x=1729035631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TzFohBlNzqxKjuZ5GdWfeG9SOi18QREh/ikp0rKgog=;
        b=nqoE63RhdGRrUt0d8oBr7pDZCtOy0gj3Jf0BTMaF6s0Z0L0UDtoy7wznSV0oGhT5Po
         MQ/CxnUzbH3xe9KilL2mCRQ3Y3vm8y4rLN9MS/A3qUSRUsZDw4rgIrtTI+cwWP2rVJFV
         QbJUDQxwmMThbXVP8VXlbSE+WLEcAKFVRkXMu+sNokLV4RYUDsnMVl8VikZlOeqfk4KF
         4lpTl586UWmeQ19gaqZ3RtRKqXNxIvFfO8anll8qT3yBr0bDhs1ZxLQX5Jmcokvqw8+R
         Xj/kUONOn9WadKKBHE33+sPr3vJjQFHBqxKLy3dZuwijiNIw65ADzFHguUIMAlVWyjsc
         qd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430831; x=1729035631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TzFohBlNzqxKjuZ5GdWfeG9SOi18QREh/ikp0rKgog=;
        b=GxQmwHWv7pjPuUQ72yhUSuzNQCb/q752KINkAbQcTaM/eQ/StWnRCt6eddQQTL0EEN
         stdCLfvFC3T2NzmspNiNWK0afpdeE/kDR1UM6nKh7KRwMzkltSRiE/K7hylEEHZ2Uz22
         rlxFC+K9DA6xAbGNZAe3VJOx4rhQ3NIrNunWzVCQgbHKa49BKNBk+C/W1DSMlzzJGwOD
         Zl6Dc3+k8YnV25pypjwO7rrQpEt7f5p/99FwEl53qmeSKx3uN0cQa7Q0PzGL76vo2f7U
         LU0RUty3gy+3DnC6dRonUPAmItQThVo6k2f7PTIohwfyw2Uh1cRpTw92mgxy7hngujtm
         m6WA==
X-Forwarded-Encrypted: i=1; AJvYcCW45mUNuXnmF4EL/Swbu/hC+7lrIpA8mbDuWC0YIPKG3hqWhxz8/xYZvawwI+wa1JvcfSgmq702UkKzkJSIFXer@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KCndx/ZBKuwF70bhHPPwiFZriYwI5ef0/V7S8irml9UkYaJs
	G9lDkoxE7JGPlsjbH3JkzPgknknefhplvbH/qaTd08XGfkgal1BZda01IwWwYZogw/8/M/CgKLA
	phG6udLcJDqEfnEuWAouVxTnDmGKTZAVclPkm
X-Google-Smtp-Source: AGHT+IE5fjoBzAtkHCZGRdBV0PsFyCvAbFAQk3kbxTIueT1WdZS6X5ubk/wldHFcczaiHaFDoWXDSNx3t7l8U0XSvt4=
X-Received: by 2002:a05:6e02:144b:b0:3a0:a75d:8659 with SMTP id
 e9e14a558f8ab-3a3980913f8mr745665ab.29.1728430830851; Tue, 08 Oct 2024
 16:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com> <ZwW2m5D2cnIabE_z@google.com>
In-Reply-To: <ZwW2m5D2cnIabE_z@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 16:40:19 -0700
Message-ID: <CAP-5=fV80pNi=jh48uq+99pSHV9aeE1X7LvDi=bY9sGQ0JVwkg@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] CSV/JSON metric thresholds, fix printf modifiers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Weilin Wang <weilin.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Fri, Oct 04, 2024 at 04:41:12PM -0700, Ian Rogers wrote:
> > Metric thresholds are being computed for CSV and JSON output but not
> > displayed. Rename the color that encodes the threshold as enum values
> > and use to generate string constants in a CSV column or json
> > dictionary value.
>
> IIUC it'd show "good" or "bad" when the metric defines a threshold and
> show "good", "less good", "nearly bad" or "bad" for the legacy shadow
> stats?  Anyway it's nice to show if the value is good or not.

Correct. I'm open to suggestions for the names. The alternative to
showing the metric thresholds would be to drop them for CSV and JSON
output, which would reduce the number of events. With this approach
the thresholds can still be dropped with --metric-no-threshold.

Thanks,
Ian

> >
> > Add printf attribute to functions in color.h that could support
> > it. Fix bad printf format strings that this detected.
> >
> > Ian Rogers (8):
> >   perf color: Add printf format checking and resolve issues
> >   perf stat: Fix/add parameter names for print_metric
> >   perf stat: Display "none" for NaN with metric only json
> >   perf stat: Drop metric-unit if unit is NULL
> >   perf stat: Change color to threshold in print_metric
> >   perf stat: Display metric threshold value in CSV output
> >   perf stat: Add metric-threshold to json output
> >   perf stat: Disable metric thresholds for CSV/JSON metric-only mode
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
> >
> >  tools/perf/Documentation/perf-stat.txt        |   1 +
> >  tools/perf/arch/x86/util/iostat.c             |   2 +-
> >  tools/perf/builtin-sched.c                    |   2 +-
> >  tools/perf/builtin-script.c                   |   6 +-
> >  tools/perf/builtin-stat.c                     |   8 ++
> >  tools/perf/builtin-trace.c                    |   2 +-
> >  .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
> >  tools/perf/tests/shell/stat+csv_output.sh     |  24 ++--
> >  tools/perf/util/arm-spe.c                     |   2 +-
> >  tools/perf/util/color.h                       |   9 +-
> >  tools/perf/util/intel-bts.c                   |   2 +-
> >  tools/perf/util/intel-pt.c                    |   2 +-
> >  tools/perf/util/s390-cpumsf.c                 |   2 +-
> >  tools/perf/util/s390-sample-raw.c             |   6 +-
> >  tools/perf/util/stat-display.c                |  85 +++++++++---
> >  tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
> >  tools/perf/util/stat.h                        |  16 ++-
> >  17 files changed, 191 insertions(+), 111 deletions(-)
> >
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >
