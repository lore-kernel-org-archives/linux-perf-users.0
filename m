Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62A733CC4
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256462; cv=none; b=G1bvIlStUiq+Jgxntx+VNbWS5T/N4tCJpZU/lG1y7kmX8w2QQtNKD1HOtOGg8PpshVOklcoSn9f/GAfbJ4e/ePggqct6aBd5BCJbqyU/71wDnuko+xx1SrptuLCtJF5jtNl8IzWmYsabbfdXgtiUEmK8V0XM3hCvEWqtfr9RreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256462; c=relaxed/simple;
	bh=JrW8D/ojxXf0j/SIRVu/keJZ05s+oq/LzWd9Sm9U59I=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=i1jW9PubOie2Sp2cFy9QZFBzwePinE9eSEZr2BLybcHUHwx9H9f5kiPWdJOrCl9+zmAAO7O8BS1bUu3jcR9qUraxjdwkzZrdmfy+cRck8/kQCWlJWPkKWyC5pUsyZfrpoPfh/+KaRf9zM1rp5N3FFbIPTdQ9N1277iC6gKBY36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlu7UvmG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlu7UvmG"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650b621f4cdso3523317b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256456; x=1721861256; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pR5ziDZUrbtvXuAxnnNXi/ECVNOOFYw5IhaL3PqW3bc=;
        b=qlu7UvmG+I2JuCEESbZEI8zikdsD1J2fuy+tATTOfkQWEK9styyxhHGc80mhd28hGF
         qaaAifhozibOkGhNKXQrDUpqZTLgK5pWfDDI/HivJ6aRrzfoycKkfx2YYqaN5BEi7WUT
         dkoeyp7ZGiFZSRJmrTHfry7Vi6TFR0azEjHWOLlPHI5pc4xllVNP9Bz6jEbNeoC563lM
         m1rHp7MgdoEAqcUxTTihUG9HcXtXrp7nYrFmSHvKHz6nEGXOfpJ9P17iSh1U2p2V5qOy
         0umSSDRfmQz6gR90jmQhxQPe2OgV3Fl7eVmzMUChwDIeiQio11DVUorKhNdojO6H4v7y
         L7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256456; x=1721861256;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pR5ziDZUrbtvXuAxnnNXi/ECVNOOFYw5IhaL3PqW3bc=;
        b=EfP+VeFVTjhjm6Lh5ozLWigeHGbyJb7or9O+4cpdkttmGm3oYg3cgpW07/0fGBfAsW
         Clt36PUNedP1EkyfTgQc0fj5XlJ3wPQQ2iTquxLGlfRVy7lwm7HGJadxXuI0uEA4s3UP
         e4p5le6oqGcfgJpncRnh1hmUFUoVgM+Ix/+D04012kC3bt2sXmFalMTRfxnTGl6eAzzc
         rXgzQT8wMQ0KyJfXxik9VUd92w8SOo28KmyiUNgjeKSAr07/7ooDtgdHKC5oAa42rrOM
         E1toWmXQ+KwH+5bxoDba2smcrGwnB/F2vzBny6La5jr/TXOLbZoE4VKis8BPtHKSbVKy
         fSLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2DbD7QYcuRRQMQj+pdqy9SSUvz6hkZQ0mAdXiIgUotp4vT3kF675fl3wA9Fg7jJgq/Ur9zMLfabJt/5ctjgOGYnfTOFXcmFMMg8Z78QqcMw==
X-Gm-Message-State: AOJu0YyY/tXEvkVS/W62YDYJzRy5yI3EY8TC9C/K0/h7/4Z1HQ6IOkyt
	T+S7Gsp3SqNM/0QdThRR1n5t6BcYQBV8rDftv/5ljW+6TSf8coVB2uIsumFS3wG7mF/BNPAOOPe
	0066WPA==
X-Google-Smtp-Source: AGHT+IFLybgLrLOsOM0ierUBa3tUykoM2MDdu9F5Fmoe0eKzh6IXK2QnVCT/xdZ4Oztpr3BmZVt4vE6ZnMQK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:39b:b0:62d:a29:537e with SMTP id
 00721157ae682-666037ff9bcmr772777b3.4.1721256455917; Wed, 17 Jul 2024
 15:47:35 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:26 -0700
Message-Id: <20240717224732.1465438-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 0/6] Add support for sysfs event.cpus and cpu event term
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
cpu event term allowing events to have differing CPUs. This was adding
in order to test the parsing and map propagation for the sysfs case.

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
 tools/perf/Documentation/perf-list.txt        |   7 +
 tools/perf/util/evsel_config.h                |   1 +
 tools/perf/util/parse-events.c                | 156 ++++++++++++------
 tools/perf/util/parse-events.h                |   3 +-
 tools/perf/util/parse-events.l                |   1 +
 tools/perf/util/pmu.c                         |  92 ++++++++---
 tools/perf/util/pmu.h                         |   1 +
 10 files changed, 213 insertions(+), 74 deletions(-)

-- 
2.45.2.1089.g2a221341d9-goog

