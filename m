Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34A26ADB
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271413; cv=none; b=Nu5bXWrgkXZSJPPweHbhkYdYwMrRWFt1x5FmWaQ7HGpG9L42ooHq6tKABLRkUSckt3F1F+mhTJE66bLMXUuGLx3WYhKyKuO3NW25/tCQ7aoabcvSvUt6Unhqe1mFUn1Ee9nv8t8VAsZNtASuSmkZbsGGwYcJkUw9WK8yoJxKW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271413; c=relaxed/simple;
	bh=HgQFSvlCrQADFz3kGSpi6YyQyXREUPyNAOV62rIkpi8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=FHFNSNhtt//Bj8u9BfZFdBP3v4MyI9uKcbl+2hNhiwdgD9uZ3wDQNJaKsN6mP4qtCywW5eRo2tS5VI44+gehfQmAIriJmTRmPd5zxCk70KSNc26qxl3Qo1UO7lFJjc52wjNfAAxrPrvUkLpWJTGOTGHkje/egVag75jb6MOZIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3UXrONnm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3UXrONnm"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60966f363c1so24298947b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 21:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271411; x=1709876211; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lzDqYvXErE70KiqRsWc/Sm3PCB8or2RKw3JobeAHpbU=;
        b=3UXrONnm57dTiYjWLHke4q/85a0b5kFR0fNMFgs3Gu/2Fgu7eUfNwCaAZDy1Uq77B7
         6AAgaVCs1VBlHolioHuXUHiE0luVrmC+jbX0nE+RxnjOVZ1OYRdNJ94BmPTkq0Zy9o3Y
         tBTYw3C7aA64W9JBzg4irQ1NJM2sZGJB3HaZtFbqGoBooABSp51XaBFhCnNxK0cp+K0U
         Bf1t/M9UYejKKT9i3AjiFMhlVCQ0fWn3DyCV78CHa6E9QG/badnTTvtL25nT5Mhw44b4
         rl9/CKkihGvLYSdN5qml5iLHBbn3H/u24e1VbWbfu7FRb+/HlzufWjpLvyqaASy8qXQw
         xwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271411; x=1709876211;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzDqYvXErE70KiqRsWc/Sm3PCB8or2RKw3JobeAHpbU=;
        b=aS3bDpszDB0Y2LrGSXHWvpuZuRalzJy0DFTy4pPYDrEqViUS/hzvmKpAvTBHFyLn2d
         Av4NT27qwR7MG4XbimQN2A4/cgfRmBvOUf7N63uregH+cGjWPvzGPe3C6jf+D/WYdWQO
         bSLXQhnPzyncqejG2OlBQzuHV7UrI8qAU6zaGZTQ3OgjdCsjhA5r7/yUVoUTjNBcdwab
         uT1vNTadCXLEOMKAmrpi+9V/0G8N2HI1JbW1fV/Up9B/oOQcp9H/faIpaLq9xOB5HL1w
         hIh31+1O4pxM6K/8hsffetuuYbtliS3LiQEFbKBN33OGn60DVad1CLhKKnYm7N24r2Nl
         aorw==
X-Forwarded-Encrypted: i=1; AJvYcCWkqfAF5GcMfD8qDDd8923PHoDRJngytjEv17sr87a8a/dwzXsFt5Gp4FUZshn9VFpPsVvSpmZM9JYACI+EUfIU0wRjSdfc/ib+A0D4kZriCQ==
X-Gm-Message-State: AOJu0YxruVWOIXw2DSCxE+mF5FUIR46aBgMbnxoBZLdHYnsWow7nTayJ
	N0Zjxw6b2h1j5t3PKUbsQV29MklHK4TVN9Eg57BNis37nez8dm0sYJH8raA72a0XWzDGH4BdVv7
	/JYHk8g==
X-Google-Smtp-Source: AGHT+IHOU5Sza8dEsNHRDsES+qJxRSg8TaryNa7FDJ10j4a0TwQ24VECLaH1u+MByIz4Kb5VnwSLhBYwyhh8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1741:b0:dc7:5c0d:f177 with SMTP
 id bz1-20020a056902174100b00dc75c0df177mr134040ybb.6.1709271410883; Thu, 29
 Feb 2024 21:36:50 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:38 -0800
Message-Id: <20240301053646.1449657-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 0/7] Thread memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next 6 patches (now 7) from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
now the initial maps fixes have landed:
https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/

Separate out and reimplement threads to use a hashmap for lower memory
consumption and faster look up. The fixes a regression in memory usage
where reference count checking switched to using non-invasive tree
nodes.  Reduce threads default size by 32 times and improve locking
discipline. Also, fix regressions where tids had become unordered to
make `perf report --tasks` and `perf trace --summary` output easier to
read.

v4. Add read lock to threads__for_each_thread, Namhyung.
v3. Factor threads out of machine in 1 patch, then move threads
    functions in a second.
v2: improve comments and a commit message.

Ian Rogers (7):
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf machine: Move machine's threads into its own abstraction
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8

 tools/perf/builtin-report.c           | 217 +++++++++-------
 tools/perf/builtin-trace.c            |  41 ++--
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   4 +-
 tools/perf/util/machine.c             | 341 +++++++-------------------
 tools/perf/util/machine.h             |  30 +--
 tools/perf/util/rb_resort.h           |   5 -
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 tools/perf/util/threads.c             | 190 ++++++++++++++
 tools/perf/util/threads.h             |  35 +++
 11 files changed, 478 insertions(+), 394 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.44.0.278.ge034bb2e1d-goog

