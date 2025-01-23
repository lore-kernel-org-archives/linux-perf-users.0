Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4062010E1
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618425; cv=none; b=XVpuUzNsvPY4fmYqwLJfZetPt6cucJhqsgDIapjQdBwvO3CQ6DAluwHanV/FO1uA20vU/Pmt0AEgBZ6xvzaSp4xdpgbeG3S9LzQzhtsnq2+UJrfgw6LloxL64LgwM36OYVhSWnlSeXFSBN8Zi4U6f/8+7Y1T6sgsT46bxghtLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618425; c=relaxed/simple;
	bh=HoXgcqiWf/E0zLrC6B1dpFdL7VSeOYH0Qtg5N2sqJTs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=MvFVD9nFBEm14cfJpunnrvZzP5PLDt7ajV6f7THDl/lhk+rAgDe7x2dW+xxD2eU2qSOSLev8gWnE2qv1qmtr0fQWMUvUDmBljAg2AUzziSw9j6/PF0BZfZGmhbw36R/8/h+NSlWuzRqtGyKBA1TWnrDOULRUISBDcoFWY2H0R6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTfPz3qw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTfPz3qw"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e572cd106f7so1594672276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 23:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737618423; x=1738223223; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=odP281TSf4aX0xn7SOC+E60jUGaoTJ6qC2EWz5qXXOQ=;
        b=NTfPz3qwEi8pwtmZvfjnBrEh6w8lRihFFFP1/kXQ7vRgFx6fsqKdW51o7BUhDCSF8c
         7fylq+L+AJynRIFb5h/H7iHylaoj8Sl1IJJFFVmD5fzZJyVC4JTOadABDu7oZEjEVkrr
         Fi0arnFpBQu2Av+VkHWSgD71bFF4epLuJ4B/hoC/KFxGA/NZVB7NFhNc7XDvN01dkOBL
         timej5Qycj4IZUOrNVr+7aUajT9Z7s81HJeUGLaU2AEEVtadT0zdbZQuWQZTcznrHEAU
         +BBB7MG/319s8mnX9lVcSx5AFXAv4GLPUGwS8p2jBRJzR/qET0XsALXqnXiJ51PfDuO1
         tcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737618423; x=1738223223;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odP281TSf4aX0xn7SOC+E60jUGaoTJ6qC2EWz5qXXOQ=;
        b=JQwKFiF4oBA8vWPX+zfLkqQ2oJzatznC8Atbv5r/Y022T7LiKOXOMDASAQtfCdtv8k
         mtGvPLw7KDWPUH4IjNuZvwzMP0A2gIvzCNpyWwilJrNugjR59LE+raX0TRZdu8p9ZS4V
         HsU8m/V+6qdzYr4o6xsJTXEkYulPZz0Yq3sMGq5NBy4idlyw6jHS23AWieufYx6tqkQV
         oJMXYZ4OYARPg57Y9CXtuKPY6bJVpj7nNm04tQOJr0thbLedGcyCy8H13MxVMjQD6Lv/
         Q9jXgcpZZSexkLJXKaK/UK/8l5XfcAWRHZhQmxkXTAGRWMchGeMAdKcRwmIYVpKd0A/y
         mPOg==
X-Forwarded-Encrypted: i=1; AJvYcCU37UAnQMGhSsJyMpwolAjJcDFawiQZ6gdbK6h0Rx9a9wDRTIVxsvPh4I81pOWd3JO25S8YcVMMDxYOjdlg9oT7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5IG2RJI/4imunyjVtQXbmRRT2VH/6XK6lODN4xMsVTR5wBp2e
	iQRipvp+IQ2m04xfmMvPP248NGN2APLO7bZCkn5JZ83ophINuv0Rm16678K1ROpPDSFldCFs1fR
	bZWfjjw==
X-Google-Smtp-Source: AGHT+IHmjMhW/xgzwLbzHjdu52oyzXwTgZldlZy3RxRdKILFZRwsq9Ir9swIerVN/tvdfkRKoNMA/x7WtOaP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2fda:d811:ae83:77e0])
 (user=irogers job=sendgmr) by 2002:a05:690c:658a:b0:6f4:bf83:4837 with SMTP
 id 00721157ae682-6f6eb653442mr361467b3.2.1737618422865; Wed, 22 Jan 2025
 23:47:02 -0800 (PST)
Date: Wed, 22 Jan 2025 23:46:54 -0800
Message-Id: <20250123074659.698123-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v2 0/5] perf hwmon related improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Try to do less scanning of files/directories with or without hwmon
PMUs. Don't merge all events with the same name, only merge those on
the same PMU ignoring suffix. Tidy PMU name matching to distinguish no
suffix or wildcard matching. Refactor uniquification so the evsels
with the same name as other evsels in the evlist are uniquified.

v2: Rename ignore suffix PMU name matching that is really a
    wildcard/prefix match. Use a proper ignore suffix when not merging
    counters purely on name.

Ian Rogers (5):
  perf evsel: Reduce scanning core PMUs in is_hybrid
  perf pmus: Restructure pmu_read_sysfs to scan fewer PMUs
  perf pmu: Rename name matching for no suffix or wildcard variants
  perf stat: Don't merge counters purely on name
  perf stat: Changes to event name uniquification

 tools/perf/pmu-events/empty-pmu-events.c |   8 +-
 tools/perf/pmu-events/jevents.py         |   8 +-
 tools/perf/tests/pmu.c                   |  85 ++++----
 tools/perf/util/evsel.c                  |   4 +-
 tools/perf/util/evsel.h                  |   1 +
 tools/perf/util/parse-events.c           |   2 +-
 tools/perf/util/pmu.c                    | 252 ++++++++++++++++-------
 tools/perf/util/pmu.h                    |   7 +-
 tools/perf/util/pmus.c                   | 144 ++++++++-----
 tools/perf/util/stat-display.c           | 111 +++++++---
 tools/perf/util/stat.c                   |  13 +-
 11 files changed, 418 insertions(+), 217 deletions(-)

-- 
2.48.1.262.g85cc9f2d1e-goog

