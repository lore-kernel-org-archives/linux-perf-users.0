Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9F10965
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368569; cv=none; b=rExQU9rVWSiXfT6nEXSQUYMQPd0wwWUfkoLWiIxYO9CMSdjeynsZMgCNq43xngJYmZpuUU1tdPof5CGFpLSvIhWCNe6NFrcde8/BVc1smIO0Bz3f1n/s1LWV7uHdcHPUv7GmswLHzGZtenoOV7owXiHZiQNsTZIptGT6zcep7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368569; c=relaxed/simple;
	bh=HSek40Kmp8UYD79s6PacIEy1fMXsFf57BBsWNTeAAfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=S/VkLKjM3O1chE3AYNtK4X6VQSHnaHHfe0f1L3rXzYwmxfexwOrEkS5hGYvyrpixMJoPoyp8QY2O96kMt1iC8bXQWa2ba+JDmddRESz8nB9Ss895QApbapvoXxrg9PxK3+yb0fQuIm0uaoIYPVyyVScfs1cZxMsrr444IN0kGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gL6NtgmR; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gL6NtgmR"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-439b1c72676so53461cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 12:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368567; x=1715973367; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLePWLlO1FMCtiS0T/B6hmJEHnrLSEzEWYLSk5IFE9A=;
        b=gL6NtgmRTrbv9YWiqrwGh+h5sL+vxakljGY4KP2qfDLboFJ6gt5mUugJq3Ddt283OY
         m+pqTDIPGQWNfCLxzALxWAdNtf2wK6j38Ij3/xoiOo8ftJ/l0eWzuZJwaGNKn4OkD+zR
         1vQSiP0b8MfaW6872FwwrPX37FvUNxQW/ihYQ6cDHJeixlhNdrucH2NBvOGnyJ60ZuvJ
         FNEPh+0bVNBBma2+kQPaM+e+jQTs5Dvb9Fc6xJWNnTG5D5PlJBmBYPZIFItuSOTqDABD
         aHEmoPfJvQ60kqSFoG50oI6c9YS5KqKMvJcoJE0azdNjvfujf9r7+j1Xb4JwwIgPHLG7
         Z3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368567; x=1715973367;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLePWLlO1FMCtiS0T/B6hmJEHnrLSEzEWYLSk5IFE9A=;
        b=iETU9MBdtyTDgQkqLW8WCUkeZeydNU05mrDYmmm2BnWjeQmoGuz81me5SEC0sebSfr
         f0Ogx1cVP6WE78dfnvM1JLO20DCH0V6e+vH4fnwJRVSbOrYDPYosx8mYmmIeYAeOrSwZ
         bHcHnTozbylCwa60g5Lf/3bQ44DyTWNqtnuK/kQJ3NzuWwRsTyJ+QwOkCSX8pJyDXi90
         XBj55hlwSNhzaP6fofNukyl/ZGWv+wl+3armtJNEuGBw5X/voZiwNeUYpSMIZZfewa2v
         rDCMdH34/ZlCiU40PtvSrgefv3r9Ky7nbrCjjPpfM+TgspToI+zSUUSPwWW6jwOf4R2K
         I5PA==
X-Forwarded-Encrypted: i=1; AJvYcCXJIzoJgmGh59n+mrR86+GCPne5GJFmAzXDlhQcGq8ps9RJiCFaRKOitv7v7WCOtUfP9nOQ8peqk6h86z8ek40vl/bHfAIHBiDOMwBPgB8xSw==
X-Gm-Message-State: AOJu0YwY1Fl6O4oAOigj7APVqO/guU5WWj9l8w/kAAxfDZlBnfGGu4Ju
	Nqfy8dYY1M3U7Na0r2GhIg5la5N+m04llz/K67fGrmJtRwTh2yHipaXPKFFOSNcWWBVelwyxsL7
	vLJsYWw4Xt2wlYWcmZzz02R10/A4zAKHOPpKl
X-Google-Smtp-Source: AGHT+IFDUy2tc99ghId8O6iiguPxUhm1Vs+n9s6f2Absozkmlx7+QxkdEcEpLr6oLhQ8grVm9xpwcRT/fm5ulLkdGsk=
X-Received: by 2002:a05:622a:1b22:b0:43b:43c:2e05 with SMTP id
 d75a77b69052e-43e097011demr246651cf.19.1715368566650; Fri, 10 May 2024
 12:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505031624.299361-1-irogers@google.com> <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 12:15:53 -0700
Message-ID: <CAP-5=fXuneU6ockdzFcnLGqATKkEfvEuTa778Hj92rBmkbiS1w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>, Tuan Phan <tuanphan@os.amperecomputing.com>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 11:13=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Sat, May 4, 2024 at 8:16=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > The mrvl_ddr_pmu is uncore and has a hexadecimal address
> > suffix. Current PMU sorting/merging code assumes uncore PMU names
> > start with uncore_ and have a decimal suffix. Add support for
> > hexadecimal suffixes and add tests.
> >
> > v3. Rebase and move tests from pmus.c to the existing pmu.c.
> >
> > Ian Rogers (2):
> >   perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
> >   perf tests: Add some pmu core functionality tests
>
> Hi, these patches have been hanging around since March [1], it would
> be nice to either be landing them or getting feedback on what to fix.
>
> Thanks,
> Ian
>
> [1] https://lore.kernel.org/lkml/20240329064803.3058900-1-irogers@google.=
com/

+Tuan Phan, Robin Murphy

Here is another PMU with the same suffix convention/issue:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/drivers/perf/arm_dmc620_pmu.c?h=3Dperf-tools-next#n706

Thanks,
Ian

> >  tools/perf/tests/pmu.c | 95 ++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/pmu.c  |  4 +-
> >  tools/perf/util/pmus.c | 53 ++++++++++++-----------
> >  tools/perf/util/pmus.h |  7 +++-
> >  4 files changed, 131 insertions(+), 28 deletions(-)
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
