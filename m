Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7741C6B4
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373436; cv=none; b=Z1fa+vvFnn0GSZ1mKRAysvx7xNJyuZBFsu7piM76G6C4bB4B84kfQasM37Hjhn8+pTgezf8nb/PmQoNEQAQZHTGSC0Acpo253IDtgUGRnGOfuP0iTJDwnwSL++OA9qyB2tCggR16xX27sbIEXD9htXRyuIL7u0jdbFR85dAs7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373436; c=relaxed/simple;
	bh=yQLTFAI6fm2S6WA1+4rUoCU2eC6pNpVtiygrTZySpg8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=EPHKMdUm34moSOVtV9SJDeRTNCzimYIF+aEy7VHZwFUZhtSm5mZs2pX982AhP+DPAuvZ3fthagUOSL/GaokBNqUkuxSCwDEx5YLSDUglwxrf4wL36UI1Uil4gC4iFaEvfUvLEDRa4V4ikoMqToO9z6c7fofbtj0p8JVGZDhRx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xb2XCThC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xb2XCThC"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso1746668276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373433; x=1727978233; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O0i4jjOvP6OpA7ZpA7aNGfOXmC8iMW1XimlebYcMMOw=;
        b=xb2XCThCKJlAfiYPKA5g4S9OhUh7pfxwlHuSzTfwheZU3/iiscBKKj6AzpkbYY9XKu
         FaTBwESNQK4v16kL4PvdjAZ0RRH3Wyb1Iao4RXGWdjOkFCENFTVG6vP6/gmTSG2UyrKG
         IGPxQXi678nhhs4jsB8md9i8vI1REmiftlyPRAFK8ZCsLb+XKt0v/wUkc9nTmqLhLSLJ
         Q3GvSIoX1KADlUjjEcHO+TXr+WC2/beMHzJ+MipmYT2Lq7Vd+imdlrh6NOUTntUevH20
         XWOOproJ5e5nt9B5s3XhiW6q1r09MS4LQ3/wKgJ8obA+pocVgQCDBlMeFwuQi4vKvgnY
         qBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373433; x=1727978233;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0i4jjOvP6OpA7ZpA7aNGfOXmC8iMW1XimlebYcMMOw=;
        b=W1GdhXca3K82v8wMKIlXq3vOmUAGWHLNFk1gxL7PpwKf5KYc9NmvRTOw8nPlVc8r0P
         NETtyKISVFW/3BTAafZL33t8xxU3dd9ameGc8hR3sHjhtX5SoDtsyHXUiNvD7XMQ3KvG
         aOLweDrbfSQ+Nx9n+2P9axpf0ijiXYZTurJPXqfVUTSoHp6n30j6jKml8QpIh7vRu1r0
         FYMe81wz4qADbvtV70T5kT7/DLg5IgmUZOCB1Ydh+E4/YNgFpxLfSrHg3W6BAFvHpTD6
         sCY5y4iu3gCdsJcdc3HCmD3oX5qtIfiJvPk7aC030yP4a87Qe9YPxxF+y5VeCVHRvYXb
         ozuw==
X-Forwarded-Encrypted: i=1; AJvYcCXK8IbmHaBF7OprCOX8HuwEZEWtztfwpkMFpeKdlmZSiddPjrTwNamw+Kbqrm+ad4eDlu/wdwhFwF7p6iI89bge@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wiGrpxqETNkxbfvz04Njp5HHkKHzSi4sQGucEJ+stMZ0VdRm
	5zuJOWmYxFh2fXCa9igG2nEsoq8U6/8aaa9T8dxQCeVfqOVvBS2WGJzJ2Y9ONxHXtj4iTffDz1P
	03eZIlw==
X-Google-Smtp-Source: AGHT+IFrKrFTKYqE8L8NRygtNLax5RL2MI+YZtF6E5IqIoKgsdCqpSLZjmvEJGFP2HwHCduugVzIY5xcDu96
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:ce4f:0:b0:e22:5bdf:39c1 with SMTP id
 3f1490d57ef6-e2604c883d4mr144276.10.1727373433466; Thu, 26 Sep 2024 10:57:13
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:57:07 -0700
Message-Id: <20240926175709.410022-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 0/2] Python generated Arm64 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Generate two sets of additional metrics for Arm64, where the topdown
set decomposes yet further. The metrcs primarily use json events,
where the json contains architecture standard events. Not all events
are in the json, such as for a53 where the events are in
sysfs. Workaround this by adding the sysfs events to the metrics but
longer-term such events should be added to the json.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240926175035.408668-1-irogers@google.com/

v4. Tweak to build dependencies and rebase.
v3. Some minor code cleanup changes.
v2. The cycles metrics are now made common and shared with AMD and
    Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
    assumes these patches come after the AMD and Intel sets.

Ian Rogers (2):
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64/AMD/Intel

 tools/perf/pmu-events/Build             |   2 +-
 tools/perf/pmu-events/amd_metrics.py    |   3 +
 tools/perf/pmu-events/arm64_metrics.py  | 149 +++++++++++++++++++++++-
 tools/perf/pmu-events/common_metrics.py |  18 +++
 tools/perf/pmu-events/intel_metrics.py  |   2 +
 5 files changed, 169 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

-- 
2.46.1.824.gd892dcdcdd-goog

