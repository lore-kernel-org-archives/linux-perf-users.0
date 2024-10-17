Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32916C854
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192548; cv=none; b=liPgc97aCX8AaqyQXzjn2b7oCpH6k6z0mqKXIS04QxSOKMwIoma+QQV/BynSCyj5PHYRS39j+Z7bZnTAZVQBC4m9lyNbSEtGbN+LIGpa4OvBqr68TZ2F7G+PVWY6XkTE5tED5K8HO5sL55wtOXr87Z4SOumGiUHSqf7jN2Nmozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192548; c=relaxed/simple;
	bh=WEXAOJtdCE1SNlS/4JT7r7DpDNqxUK5tAb0Muj5O4q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4hL5L41g8xuJCUe5aWqhQQRUFdU17+ULImNmxl4fkw0dFUhJJwPzEChPIQCVahs36RkxdO2saVyM+SSd7/LZ80mrKwHXfT3sgfPVtTTzdzYHkgrTqO90lrc1uDdomQTeYFsRGh+EaKXApuJr3xgvI5rM7imaiQQ2fNrZh+87S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7PH0Gz4; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7PH0Gz4"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso39205ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 12:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729192541; x=1729797341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MgZetyT7kWa+/yuK0Fr7buErddvwijeezfKA2oUEsk=;
        b=x7PH0Gz41fbExPAdPWqsAXL20JDmNR7uPbkiJgOaWX6VcMwoBKK/5vmpTQuxQoKNwj
         bCrR06kCvrh3uCG2C8Xcb9Lx2k9/K8tFXbyOwHyaF8fLgxou+4vg9NLCQpY905DlPmJP
         xDVG52lCxsLzJoKEEWl/N3WRQbesPzDG0e6G9xAIiuNbsg67sxNlHQqrgrHzVswja3xg
         52IIZpy/9Xt5YbigaJLWEkiO/idou+P6R5GprH9jenE9FtgQyT9vliZQXLfdJCIycjUm
         X7kEpZWHTARlvY6M0mT0pszDTiMrByP1RvGWR6TEtvQOxjB0zsZd0c1Gc/Rtnvo52d9A
         4FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192541; x=1729797341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MgZetyT7kWa+/yuK0Fr7buErddvwijeezfKA2oUEsk=;
        b=Ygvq9U5UZjEaUP3UPK4nRaCWoPel1LOErYDuqHEZQbsHQeYaKv37c8KrWMxyfFN+Pr
         e5xH6m5oZwoJssrvGyQSCXGrwiZfUmECb7jwFrwBb/nw9q2HtfACveSY3vituFVv4Cy+
         TLtCybjRwSPUqHCCvQrDWgi72hL3dsMkDKUIDlyCYDr3Zi/CP6dGKPVog5XsV3VBVr/H
         m3oJAupA9VBtJHhyn+/2jI61Lsgq2wi7yaiOLsCjRqfp/ZDVn73+f6IvxsPyMHIFl49m
         8TxgeOiQ6yRf0RjD2DjBHt9CpNpdxjbB18CigkJu0Z+XSZ8aHq6mAlAf+MwdTnTkGQDA
         ta0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPC98FDj/R3yrMBYag0Cea8hBF3QsC/+mc/0HeVjPFpAu1AH9Qtq0KiDt80dJYa9tqeg9HI7380pyqXQmXFUhQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJexpfTuyB9a7fGdZ2X5Rkw5gV6Uypei/akSrFkDBlsX0Vj6z
	J+8cZl0nxHSRUbCvjbcZ6gn2nqAvEq+Mq6Fkytpx7SvEUWcuwybhf00UklFf6dJA+wfsnuwpCng
	2CWxqX0cbItlILWtE68h5z4i/o7MwrwjnUbRv
X-Google-Smtp-Source: AGHT+IE9XADz7SYrkz/q6qJJWYfl2s+CVkOMZmpSx+y3jeduyIakJqEHs9UZoAMhmSQK84cbs9wbRfXeEkLmNV5i69g=
X-Received: by 2002:a05:6e02:1d0f:b0:3a0:be64:a351 with SMTP id
 e9e14a558f8ab-3a3f340b605mr597285ab.10.1729192540574; Thu, 17 Oct 2024
 12:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com> <ZxFVYvDTtmz_JbMU@google.com>
In-Reply-To: <ZxFVYvDTtmz_JbMU@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Oct 2024 12:15:26 -0700
Message-ID: <CAP-5=fVicsN1_k5nycOzHnRxdmwdEk9Y==OSAaxdDL5wnX7_jg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] CSV/JSON metric thresholds, fix printf modifiers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:20=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Thu, Oct 17, 2024 at 10:53:49AM -0700, Ian Rogers wrote:
> > Metric thresholds are being computed for CSV and JSON output but not
> > displayed. Rename the color that encodes the threshold as enum values
> > and use to generate string constants for a json dictionary
> > value. Disable metric thresholds with CSV output.
> >
> > Add printf attribute to functions in color.h that could support
> > it. Fix bad printf format strings that this detected.
>
> Thanks for the quick fix, I'll take this.
>
> >
> > v5. Switch some u64 printf flags to PRIx64 rather than llx (kernel
> >     convention) to resolve 32-bit build issues.
> > v4. Drop CSV metric thresholds due to formatting variation on
> >     hypervisors (broken counters) and not as detected by
> >     tests/shell/stat+csv_output.sh.
>
> I'm ok with dropping CSV support for now, but could you explain
> a bit more detail about the problem?  Is it possible to see the
> same problem on host if it has a unsupported event?

It would be. The issue is the stat-display code being a rat's nest and
adding a column to CSV should be straightforward but causes --thread
to behave in odd ways with an uncounted/unsupported event. Where the
column counts differ from supported to not supported causing the CSV
stat output check to fail. Fixing one issue leads to other issues and
my usual desire to rewrite stat-display which can wait for another
occasion. Here I'm trying to address that we may compute the metric
threshold, use extra events, but then never even show the output.

Thanks,
Ian

>
> > v3. Rebase.
> > v2. Don't display metric-value for json output if there is no unit.
> >
> > Ian Rogers (7):
> >   perf color: Add printf format checking and resolve issues
> >   perf stat: Fix/add parameter names for print_metric
> >   perf stat: Display "none" for NaN with metric only json
> >   perf stat: Drop metric-unit if unit is NULL
> >   perf stat: Change color to threshold in print_metric
> >   perf stat: Add metric-threshold to json output
> >   perf stat: Disable metric thresholds for CSV and JSON metric-only mod=
e
> >
> >  tools/perf/arch/x86/util/iostat.c             |   2 +-
> >  tools/perf/builtin-sched.c                    |   2 +-
> >  tools/perf/builtin-script.c                   |   6 +-
> >  tools/perf/builtin-stat.c                     |   8 ++
> >  tools/perf/builtin-trace.c                    |   2 +-
> >  .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
> >  tools/perf/util/arm-spe.c                     |   2 +-
> >  tools/perf/util/color.h                       |   9 +-
> >  tools/perf/util/intel-bts.c                   |   2 +-
> >  tools/perf/util/intel-pt.c                    |   2 +-
> >  tools/perf/util/s390-cpumsf.c                 |   2 +-
> >  tools/perf/util/s390-sample-raw.c             |   8 +-
> >  tools/perf/util/stat-display.c                |  73 +++++++---
> >  tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
> >  tools/perf/util/stat.h                        |  16 ++-
> >  15 files changed, 170 insertions(+), 97 deletions(-)
> >
> > --
> > 2.47.0.105.g07ac214952-goog
> >
