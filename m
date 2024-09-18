Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEF13AD1C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726696912; cv=none; b=k1uve9IWjbd2AfMNlDwYagQfGDi/lBFG6rAbneBhjuC4UZxu+bXkM6znphj6mGz10nSYL2AOU6nPexqXJoCUWGss3siVmdOg8MoGtr4KwrQrr0VQKN9KyNUdABmYjTjx75dlsPM0sgBQU4ojCXcsKAQhi8lT4CHlzO70BuHJ/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726696912; c=relaxed/simple;
	bh=Gv+o3ZbA4E2DAwxQITxbmZcZD0OAyd7iBeB4r8n9hTY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=mcyWsW/I19BwkX/nHMzz1mlnEtrzB+SqFzy/YB7ACuqzc01QeJInuJF51mdQertZqdAWK692HIGsBxhVGDOQcs3qdDJTnru8uNNqYjbL/8pijEVukXkSt8QmWgJIVsk3Am/qZQhnA7i21beBCxaQ898yWTbnOL0Ei0Ko9+HOakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9ntip/d; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9ntip/d"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ddd7800846so4552147b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726696908; x=1727301708; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vzq+ZiQjxwGjt2wTYxeHA2liyw6Vv7Vj8czqWzpAvsQ=;
        b=l9ntip/dqrtc23fy317IxG88VC54aXSBPYMfeKz/BIcarNLJ4mJW9C1hSwSutOkr3p
         fHQEEWIVJmNDPzPVnmENFSuXQTypxrLedS2DfLQNrMMnSXuJYuuOBpsT1FAiPadiaRPx
         7d0JQyJ0yuAGIz862Ez4yAtHfK0iJvVSxWMXZKMEdrJBbUZOTheoqVXA2sqFVx2Iq0OM
         TJIToLWnNOXXMN1Qfra857Qt3cmXE9TlmIPGWhWHOyzzyxvX0gcxLEIB5ScOTV2RnpIB
         9kkW2fzqCqbzBt6zqlEXYEZXe0TiqtCckZ1dbbJrDrWk+R+JIQ0iOr/K9bqoxAN5LNRt
         ePFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726696908; x=1727301708;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzq+ZiQjxwGjt2wTYxeHA2liyw6Vv7Vj8czqWzpAvsQ=;
        b=HiTS7TAcGDrTzJ+MHUwIa9cmW8C27UZBzolUkHDCC1l8Ic77YMSwmmr0U8B4m+146l
         1qIMIhmMQ+C4GD6xoxukVcH+NbQ3llb78V0UTucKx7I+lMghtvfOkXrn06fTJlPeAPt1
         ImX+aUo5DRWrtSHjQy8imHv/b7+/pUZR+zrACss5nq0rkGJXkhiOuvTnWfNOVcpNxqqQ
         UEzaulDjKNsCF1DAlcvKDyhNjUskMDr+9tJ9GkeONjN6UsODZ4osQjgEYH3D8lBA20D8
         B92hsKgEYyO1ePYeriB1vPeOB8tlHMvj3bGe3RmEc8imKsrE0wxi5UEclwCjKz5x3gOw
         YDnw==
X-Forwarded-Encrypted: i=1; AJvYcCXTSg4/RbmXBDhJDqtR3Qv1c5vzHYdlTCUEv2BWxiBN7PgW1DnguBlfsd+MR+tm/FqvJVphM06IRcBB4KMFgsgA@vger.kernel.org
X-Gm-Message-State: AOJu0YyM+f8h6lN8xOz+NBPHAPR8cpIvY/OjU+avqAZcmC/R5YOEEzi2
	kZd9JojAnR4a+uJbI+F42P7iclA31dCnIrIBwz9QVYMvU3+AqvKbOKbx52SVvHLlFwurvAQHYXG
	fqykclg==
X-Google-Smtp-Source: AGHT+IEdz4mPkmorE1yDLYhDjmI14NId23qkjFGWYXr+JOq+n9Z0o7brbKHek6dsBk0xDdKffXJ12bgCiIxx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cb6b:1e62:cfd8:bd50])
 (user=irogers job=sendgmr) by 2002:a25:d0d5:0:b0:e1a:8195:3c1b with SMTP id
 3f1490d57ef6-e1db00d2c06mr24256276.6.1726696908220; Wed, 18 Sep 2024 15:01:48
 -0700 (PDT)
Date: Thu, 19 Sep 2024 00:01:30 +0200
Message-Id: <20240918220133.102964-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v3 0/3] Add support for cpu event term
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Being able to set the cpu mask per event was discussed in the context
of a sysfs event.cpus file is discussed here:
https://lore.kernel.org/lkml/CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com/
Ultimately Kan preferred to have multiple PMUs with a cpumask each
rather than an event.cpus file per event. It is still useful to have
the cpu event term and so the sysfs part of the original patch series
is dropped.

v3: Drop sysfs event.cpus file support patch from series.  Reference
    to using cpu to modify uncore events is dropped from the commit
    message. Reference counting issues on the cpumap are addressed.
v2: Add support for multiple cpu terms on an event that are
    merged. For example, an event of "l1d-misses/cpu=4,cpu=5/" will
    now be opened on both CPU 4 and 5 rather than just CPU 4.

Ian Rogers (3):
  libperf cpumap: Add ability to create CPU from a single CPU number
  perf parse-events: Set is_pmu_core for legacy hardware events
  perf parse-events: Add "cpu" term to set the CPU an event is recorded
    on

 tools/lib/perf/cpumap.c                |  10 +++
 tools/lib/perf/include/perf/cpumap.h   |   2 +
 tools/perf/Documentation/perf-list.txt |   9 +++
 tools/perf/tests/event_update.c        |   1 +
 tools/perf/util/evsel_config.h         |   1 +
 tools/perf/util/parse-events.c         | 108 +++++++++++++++++++------
 tools/perf/util/parse-events.h         |   3 +-
 tools/perf/util/parse-events.l         |   1 +
 tools/perf/util/pmu.c                  |   1 +
 9 files changed, 110 insertions(+), 26 deletions(-)

-- 
2.46.0.662.g92d0881bb0-goog

