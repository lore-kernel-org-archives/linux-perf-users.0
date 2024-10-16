Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF704409
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112038; cv=none; b=tzWUMknpy+LWPAa7asEiiMeZBUpozWRPpc9vCU8I21XXNLiysLkjVEEHpJjDVswNhFjiq1v17fgHihO1ic8T4ypg9tWrYbQWVln5CIVIOAyj6WwzZqCGS9a96BM2Z+c8VDhXsKJXS/7JM6gpIVRW2apMIOXH/WKBKz0o/dodgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112038; c=relaxed/simple;
	bh=u5MdepGIfBilLu0ziohieyw51PFn74HZe6J1lNo9KzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IMD94UWiKEEEPLU5BZdZtMdGSB/UZdfONzCsC35GOo1KCV4CZWHh812tj7cC/W6qS3gV3fDx0ZiWfDXvcZuv+BLCOreHOkpdk+0zSQmyQ+JinbAPRhOFFpjbCqw0JEdJBFMGSt5vTUk6UmxVglgi5INXV4h1vkIzCTvMtyRCWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUSjF5KO; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUSjF5KO"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so19025ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729112036; x=1729716836; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNY+GVmNb1YId0Xh+4NvDDftMMReKhqSCa5776z8e3M=;
        b=HUSjF5KO64TlfW5MCosu2seXqObyooz/42c01/FXZri9kXbkSnlx6kmG9oYJFNViDh
         /5HJYYREJzojlbcK12o+LR9B18YUKWkJSecJwtUo1a0NFabG2norLNFAdr8JwF9/cTTB
         nb3nCAzoQnALkSNddKVD7XGqDG0m2X5uJqS4i6Ue/9lJ1PILmmuc18jJpm8cwsdKKESA
         ExyRs0Opn7HivO5KF1bpU/PcxFZttzrg1y66uzRt4IwZmMCdtIPcQ7MRRedWEjdpiKJp
         7rn71RbkQQFmwHnB3SCIorypmhTPQxOzsNHfAMjUzU71nSP3MaxRbipv5liJeMl69qXl
         8gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112036; x=1729716836;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNY+GVmNb1YId0Xh+4NvDDftMMReKhqSCa5776z8e3M=;
        b=e47kSAbxKmIQi57eJmB5BySp76xfaB29taLUnQxCai7KqlMm3R/YaZ4NTcEwllxxB2
         j0X2wznAb7q2p1QfTi0bGCB2rCkOn5iI/MlTZxL7bgwyc+LBfYcpJruw8kH2L5AwrVyg
         NTljoHWQ+18Z9VHV3X29rkOdQAOnk+Y0l3K552CUwDhNXXowA9y3Hvuzj5kb7QFNBwzH
         orqjApyjkDsDnIhlwpNbWPZbWllxBFJHWJMfGEghRzQ/8GXWxMN8el2Ulx0p3AtlswQ4
         WGLN067bykNyJYEEWkKfmM3av+Abrapmi13S6+Zkf650z57qDDbiuEi8WkUbwkYX6ER6
         Nm+w==
X-Forwarded-Encrypted: i=1; AJvYcCXY0sKEylwtkCYeVKLsqzZs2BNmQYoKEg3ENCLOo7ESAFomC2fy49lMLrBmxCDXsKvqNXLMj3XAzceWEXv2nCg/@vger.kernel.org
X-Gm-Message-State: AOJu0YzTogFvYwN2dPkxq/xwz0W1dvPeGu2d7R16LWLi49RvbsRd18vy
	q/ntX9Nd1+tlhJeFSGV2bNNRw27wF+QCiPDqDTILiDeMuC2LhgNWWQ59HRpkjS67sMN4FOvCG7M
	06gKZbQWrYGcVJi74rm8s6S4JSslzKcX2PtAm
X-Google-Smtp-Source: AGHT+IFRXjyLQm+uJRX9z5lMKycMDQ18nfRsWOGMMiRoWsn7MPBvQvAuRvyfFmTSPONwCTNADh4XSh3SjIL8fpLfJPU=
X-Received: by 2002:a05:6e02:20cc:b0:39d:2555:aa2e with SMTP id
 e9e14a558f8ab-3a3ea02489cmr233945ab.13.1729112036282; Wed, 16 Oct 2024
 13:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 13:53:42 -0700
Message-ID: <CAP-5=fUUv4M0nKao1grRhjiSN3E7ntM0VRp-GJDEq0c3xnFFOw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] CSV/JSON metric thresholds, fix printf modifiers
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 10:53=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Metric thresholds are being computed for CSV and JSON output but not
> displayed. Rename the color that encodes the threshold as enum values
> and use to generate string constants in a CSV column or json
> dictionary value.
>
> Add printf attribute to functions in color.h that could support
> it. Fix bad printf format strings that this detected.
>
> v3. Rebase.
> v2. Don't display metric-value for json output if there is no unit.

I'm going to change this. On a hypervisor where counters fail to open
the CSV output is losing a column. I hate the stat-display code as it
is spaghetti, I'm just going to disable metric thresholds with CSV
output.

Thanks,
Ian

> Ian Rogers (8):
>   perf color: Add printf format checking and resolve issues
>   perf stat: Fix/add parameter names for print_metric
>   perf stat: Display "none" for NaN with metric only json
>   perf stat: Drop metric-unit if unit is NULL
>   perf stat: Change color to threshold in print_metric
>   perf stat: Display metric threshold value in CSV output
>   perf stat: Add metric-threshold to json output
>   perf stat: Disable metric thresholds for CSV/JSON metric-only mode
>
>  tools/perf/Documentation/perf-stat.txt        |   1 +
>  tools/perf/arch/x86/util/iostat.c             |   2 +-
>  tools/perf/builtin-sched.c                    |   2 +-
>  tools/perf/builtin-script.c                   |   6 +-
>  tools/perf/builtin-stat.c                     |   8 ++
>  tools/perf/builtin-trace.c                    |   2 +-
>  .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |  24 ++--
>  tools/perf/util/arm-spe.c                     |   2 +-
>  tools/perf/util/color.h                       |   9 +-
>  tools/perf/util/intel-bts.c                   |   2 +-
>  tools/perf/util/intel-pt.c                    |   2 +-
>  tools/perf/util/s390-cpumsf.c                 |   2 +-
>  tools/perf/util/s390-sample-raw.c             |   6 +-
>  tools/perf/util/stat-display.c                |  85 +++++++++---
>  tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
>  tools/perf/util/stat.h                        |  16 ++-
>  17 files changed, 191 insertions(+), 111 deletions(-)
>
> --
> 2.47.0.105.g07ac214952-goog
>
