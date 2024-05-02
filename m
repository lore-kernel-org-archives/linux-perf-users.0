Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530C179972
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685712; cv=none; b=DGP4knukaiQ6ydkb0ioBMD7LDlaKYUz5zKxcumoMAHboFkqIlpMLyi4Xlx6fgJNJWbw6koJUawkYX5A2VQAcL2irXUmNg7xQrQWDU4WVW4hwMXIRT4P/fiobIUEiyg9o+hmIegq7WYKdVkxdf194eMIzvx/s8TY1kI0B3agiQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685712; c=relaxed/simple;
	bh=qOgLBJE0LE1Qr7V8zbAlCdL72iO5CLfA0xy5a53x4LI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=ssOVhQLDejVjAcWhFXyM5ZLWcLp70hvns+Lo7Kwg26ZCfaMFA5BUlYU0YPUGSylWyckfALKhiZvCffsoHk/9veLCLGBPLsnHaNtgQtuSreO1L0U+9zjqqQCAYV2dioUDM2ZZju7uaOpr8cbHUyqnUCPSwvZ/oqMg2+UBmXQD+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1XTZgOrN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1XTZgOrN"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be26af113so74452227b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685710; x=1715290510; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qhcKEmyfJmzka3bwh2Qr09m8V19zJ3Gs286JpGC5N+o=;
        b=1XTZgOrNjFUvpVRbHLdEX7DGDSuxZcwzf/5IOHccKUyJNkeoyOWwMljyhlm8UYK+SV
         7vUif011PsTC8oNFa4ETVazH9Q9902SV6opuCFLvLWvRFSceoV21tnSMpdD5I5QkV83i
         yfvV/BMWOz3Q2xVTOc7D1E53RoQ81yJReVxDGmwJzOWm3Ir95v9dArQOqnvhxVZqCzvA
         IkydHz6Qbf61jMS2g1ip+fje4ZBmBqHL9IYxpc7k3wMbXELxPvcVnl1ARM6BHGG3NLtK
         SNxTChTBwmwQT62PSym3b/n6SUCyXCHmxI+VoAaaCxkyUz9JzC8VOeWhg1CAYD9h2ckH
         lsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685710; x=1715290510;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhcKEmyfJmzka3bwh2Qr09m8V19zJ3Gs286JpGC5N+o=;
        b=ZaoeKJjgONaQoG/GO3HpwmGDhyOn9V4pfzB4Mgj2DTEE4VtXfjdnqVXZT6TGL/Bh4E
         AGz+U5mmLvPzhWjWm4A07RKzVNMW2ozhsyXyPFeHOD0X4NyhF+rBV58MG/9YAT3tVD+i
         ukF1bPBhqyQ+7YcJsDV3E4HBfUkrqo5YNqkMPmv9H3Nsl8ue7KcEQnrb12A8qbyEDaWd
         Rl3nq+is1XcgIkSYIR1NvVQ0tNqRV75aFN7KqxTeji+UdZK3soy7fQeJPCCu3KimlZ2Q
         ExPny7M3y7V/BMnE4yUJf2h3d28jprWr7HfQOFZA96UvWj2gS/mw3t4nLe1FaX2VmXCV
         iTow==
X-Forwarded-Encrypted: i=1; AJvYcCWFoP3noprnod5KdtzjsDU1boCeYni0n0m9Q4lJlK4pRDw6CBWAdcVEVD2VFkAreqaKkclBxI8e7kL3bNvelMxkLcH0/h/hTZ6b5utb7glXHA==
X-Gm-Message-State: AOJu0YwF66CTvsGjHA5CxkXa19EaHu+aivS6pRacR3XhDbEU81tCGVKe
	DVrqGKl5sGKwm4Tzeo1yuCBThzk9JxrMh4VxX1dMLMdkg63slAu2EcSp6LwKOyRwR9SPAm4brMh
	vjcq27w==
X-Google-Smtp-Source: AGHT+IHipT/3I7TZPtQNOU5cK7w6gazz2EG7ggZtHX90TFERJA9kLwPfsnpZ/IISO+pyZI7y6ke7invIO6vO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a0d:d84b:0:b0:611:2c40:e8d0 with SMTP id
 a72-20020a0dd84b000000b006112c40e8d0mr156843ywe.3.1714685710542; Thu, 02 May
 2024 14:35:10 -0700 (PDT)
Date: Thu,  2 May 2024 14:35:01 -0700
Message-Id: <20240502213507.2339733-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 0/6] Assume sysfs event names are always the same case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

By assuming sysfs events are either upper or lower case, the case
insensitive event parsing can probe for the existence of files rather
then loading all events in a directory. When the event is a json event
like inst_retired.any on Intel, this reduces the number of openat
calls on a Tigerlake laptop from 325 down to 255.

v1 sent as an RFC:
    https://lore.kernel.org/lkml/20240413040812.4042051-1-irogers@google.com/

v2: addresses review feedback from Kan Liang, by updating
    documentation and adding tests.

v3: incorporate feedback from Thomas Richter <tmricht@linux.ibm.com>
    that s390 event names are all upper case. Do a lower case probe
    then an upper case probe, make documentation and tests also agree.

v4: add checks to write (kernel test robot) and fix a typo.

v5: Add reviewed-by: Kan Liang and fix potential uninitialized use.

Ian Rogers (6):
  perf test pmu-events: Make it clearer that pmu-events tests json
    events
  perf Document: Sysfs event names must be lower or upper case
  perf test pmu: Refactor format test and exposed test APIs
  perf test pmu: Add an eagerly loaded event test
  perf test pmu: Test all sysfs PMU event names are the same case
  perf pmu: Assume sysfs events are always the same case

 .../sysfs-bus-event_source-devices-events     |   6 +
 tools/perf/tests/pmu-events.c                 |   2 +-
 tools/perf/tests/pmu.c                        | 467 ++++++++++++------
 tools/perf/util/parse-events.c                |   2 +-
 tools/perf/util/parse-events.h                |   2 +-
 tools/perf/util/pmu.c                         | 111 +++--
 tools/perf/util/pmu.h                         |   4 +-
 tools/perf/util/pmus.c                        |  16 +-
 tools/perf/util/pmus.h                        |   2 +
 9 files changed, 415 insertions(+), 197 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

