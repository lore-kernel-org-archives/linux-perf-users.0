Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93687620
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262646; cv=none; b=VDLrTQYVbXIETGO7Ke+bJS1l4HkHeExvAmM38xobZOlOMVoAHHNjIw6LqNFIfvSdBuzdQ6AYFXjBAwwV4LsSUNfiEvtBgkbWeuzSuCmTE3oCi4ANJkTPKA7ueXR4Tviuu9X2xtEjrnVaNaXfRgwuqClzgoT+XlaCaJ3ObdfgGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262646; c=relaxed/simple;
	bh=3MmR6WYn5H6j6OnCbe2YIZN1LUz/9RtidsFDq6cezCA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=oyMTGDGvUnBiMIsFdRmabaIYE1EWTSu15ONIMF8fP5r8Mh5hJob5lftyvx4vKJfdlfOnAmHVIULWQRJXS8CJz+90zPVZ5IOBmz6IIhLSKeywoe9VyCjRfac1E2CyZ8xdQPnTPRIFgr+pp9pc7CF0X4y/EwUpM079HFKANwZtFF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HpnoHAmd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpnoHAmd"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65f77c34c3bso7013467b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262640; x=1721867440; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6MIUEZAXr9ARz/GejKmT/R1O9t1/kgujIZ/pqahQfTY=;
        b=HpnoHAmdEZNnH8FktsKDPLDAGM7uzGnOiB9eFoRubhhuXcqE6t3rZfuNtMyLlSP1NK
         aKKS74uJW3/mPhxlsYE6iaepB9GrHvBmJj6hupYEl513dUFK923hkQbjiP2ZMEVDqyWa
         oTLcn9dH4wksbHK5shwt+/16HDgKRsNvSVK3VIEKWLkgeLk6vvU0/tupxpUhYyvVGSZq
         h7oHSPwtzXpAgp2r9Y1ptUJhO2mxkicw/vz09ZscSF07Ew04o0TaE/9qDPHBmzV0TRwF
         eJ70Mm6p4Wm8LJYsz8XkHkPqp3c3MDOFhdxGt5tsNIVudOqizc/bIRfTTCD4MggwlZ9Q
         Z5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262640; x=1721867440;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MIUEZAXr9ARz/GejKmT/R1O9t1/kgujIZ/pqahQfTY=;
        b=Z/dvvktffokE4VZmCXuM+Mz0A75xTiC5LncpEkJs5v447zTmQL5RcBuS3orikxjAre
         9ln0v04W5JUqGlAPduHJoTEKJ72uBRHT3v2VJJ4yAzD0yBbHgvnPO6Epl0xn6Lf61nGs
         PkM5DS1nVoZrHL3GZQrZuzq6+jkcX4WljhAuKMoIzweeZgNbtTy1Q+LGaMeVh90/6oz5
         TP9fo/G5HZrEpPB39J8YVNK3ACl9I7aPl1mwoy4f3PXk3KpRslWmiKEMkYbYCC9O9Puk
         u0iOjedQgFpE54xSSpQFiSOEKMS6ju9ih4nYPzqE432oFUNxmUtfbvspXP/rG+YbtB1X
         rHZg==
X-Forwarded-Encrypted: i=1; AJvYcCUDLPgUge5Ued5F1FPMvGdVOHb1bcJZAYOxL4GIUPsJ5CZMmmrnJVYOejv5vd36Lj8BWQRafDlcDZ7mnlgfYZF/rkcdqi6WnCve92zRNhiBBw==
X-Gm-Message-State: AOJu0YwDlnBVfckqQ+3TQbhMp253Asdji/crxnQJsY5SJcKYCzNLrXPs
	2yP5BZKtouzdeB/rKzBds052mCjOr+3CHintKOf97aKN1iPsdpcEaSODZOn2gnsaogD05Kzf9n6
	+JmJZRA==
X-Google-Smtp-Source: AGHT+IECxaYbhNd5fpP/BxbbwRLk6/tzdHS84XHPvPQhwjJd6j5KAeRS5gwXqiiEJfVrjEx+c1ogUd8pzm3z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:18d0:b0:dff:1070:84b7 with SMTP
 id 3f1490d57ef6-e05feb23b1bmr2077276.5.1721262640550; Wed, 17 Jul 2024
 17:30:40 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:19 -0700
Message-Id: <20240718003025.1486232-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 0/6] Add support for sysfs event.cpus and cpu event term
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

The need for a sysfs event.cpus file is discussed here:
https://lore.kernel.org/lkml/CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com/
following Dhananjay Ugwekar's work on the RAPL /sys/devices/power PMU.
These changes add support for the event.cpus file in sysfs and also a
cpu event term allowing events to have differing CPUs. This was added
in order to test the parsing and map propagation for the sysfs case.

v2: Add support for multiple cpu terms on an event that are
    merged. For example, an event of "l1d-misses/cpu=4,cpu=5/" will
    now be opened on both CPU 4 and 5 rather than just CPU 4.

Ian Rogers (6):
  perf pmu: Merge boolean sysfs event option parsing
  perf parse-events: Pass cpu_list as a perf_cpu_map in __add_event
  perf pmu: Add support for event.cpus files in sysfs
  libperf cpumap: Add ability to create CPU from a single CPU number
  perf parse-events: Set is_pmu_core for legacy hardware events
  perf parse-events: Add "cpu" term to set the CPU an event is recorded
    on

 .../sysfs-bus-event_source-devices-events     |  14 ++
 tools/lib/perf/cpumap.c                       |  10 ++
 tools/lib/perf/include/perf/cpumap.h          |   2 +
 tools/perf/Documentation/perf-list.txt        |   9 +
 tools/perf/util/evsel_config.h                |   1 +
 tools/perf/util/parse-events.c                | 162 ++++++++++++------
 tools/perf/util/parse-events.h                |   3 +-
 tools/perf/util/parse-events.l                |   1 +
 tools/perf/util/pmu.c                         |  92 +++++++---
 tools/perf/util/pmu.h                         |   1 +
 10 files changed, 221 insertions(+), 74 deletions(-)

-- 
2.45.2.1089.g2a221341d9-goog

