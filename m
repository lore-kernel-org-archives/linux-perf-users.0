Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C93242B5
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463462; cv=none; b=R9GJU7B2kemvk3BEfuQpEdvGOTQuM/hcbj5YuqXs7gEL4TUm9iNuSw+Q4FlA9Ro1qqRDPvLTx1uqrSOPTJOEAvQo29XruI1w7dBl+Qj05ycOsJlmcntlemGlBAbpST+gGY0aKbpA7A2eRIGvuWVUMYL8Xg7rmcVkiqVV4EHHp00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463462; c=relaxed/simple;
	bh=7hrATXdSkqOyQ0r0qHMUdfuT9mJCE7TUOjauz7AhFcw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=lIG3LRUPcyruSOfCRMUD5a6fr8LKsdleClT3/nYfYOUxveBlAC9b7yuJvqUSE58FZrxQ3Wdt3sNS4AQIsfQzLVhM5sDq+BC5sE9ek4fyNx2pI7C4VzCiPV9KJNazLAMtO5oc1EngbTqpSyt6NE4wb79GPDlzmaqvhSleYmNJqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GiGDllA5; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiGDllA5"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12721cd1a2aso946447c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774463460; x=1775068260; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6qrbAew5GclZC/lmFBbsyWI9kkJlWf87iDUPMx4bIU0=;
        b=GiGDllA5ScQ5aCCQVCWT9a3PIYdR6I3Nv4NGKZB345DM+OOO9fLqg28LScActdnjTH
         LVaKVTKpmOc9LLORMXmUYgm/aVskMLX2AleKdsiJNd5CgcC1hWUEmq1cEhJZ+MHK8Lgi
         MSz/QOHuIl4rn18DeKWOdYeEDHvZOFErUJeFa0uKwDEMGqsKsEa+fReaZIgjGMRcjYFx
         mOb2hp+D3dWmo4Y1+nf2wwEQ9uIu09w6b0s4kS9GsmsDQ5DJo3VwK63lrP16yJDGioap
         EyBFGmXsV/o8MieXZ1xDMu5mWlLb+1u/gQMD5xqmL3gDbaB1bAdGrDF7JMpKJBbklbJI
         bDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774463460; x=1775068260;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qrbAew5GclZC/lmFBbsyWI9kkJlWf87iDUPMx4bIU0=;
        b=HMKAmRb0mZDMMqNMSaZ6KvLHgWdeFrbcad6roblUV8YHCEOHTFwBDvS1mfx54qlZp5
         0+hABEnqZZI8vZyH7IV4bktIN4b436CrZBP5DPQovgRJcNnRcXVxTs77I1G65anqRnCX
         tUcSqSSj05j6u6+JVCroEMXPgnlT1O8xRu1AV6nwGePRMZV15EBlD9JYun6JvSQRdPdv
         OQndctHjZ+V53ECy0DiUPmwTGD668WEiPpEIxQKJwBzvC5WaFuZ1TQ9Lka2mvoKosAkV
         3KNsLwxxTFbv+30kVDYLWhU2kMm/SUEmVZmT/l9lZKk2tYJXbuVdZxKu9bN7qYIWjQ7n
         US9g==
X-Forwarded-Encrypted: i=1; AJvYcCWhDGMwKQeoKXINSxwCnCeMFzC9GPH4LiwWxcGluL8jabbPXWmvM5GCibDHh2uXy81B+5GK6belSmSfh6jGDkNc@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzFxgnd6xHun9kXrJVCwQgxWbH7cNBGpeGCx4CSEKDDy8fy3v
	eNn13j3D3qWApPKgz63YIu0VwXbDw3FPzvj+QTdDBFEpdCuyf+Y/sc+AsXY+tVzkVLJ7hbS+gnz
	Ao/SjRiwzZg==
X-Received: from dlai26.prod.google.com ([2002:a05:701b:271a:b0:128:cffb:50d7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:126:b0:12a:713b:8964
 with SMTP id a92af1059eb24-12a96e5c068mr2778071c88.11.1774463459799; Wed, 25
 Mar 2026 11:30:59 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:30:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325183045.1229502-1-irogers@google.com>
Subject: [PATCH v1 0/2] perf tests: Add tests for uncore and perf metric event sorting
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, German Gomez <german.gomez@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A thread changing event sorting highlighted a lack of testing for the
more complicated uncore and x86 perf metric event sorting:
https://lore.kernel.org/linux-perf-users/CAP-5=fWRgDo7UnJAD4C--d=mVPRhOEWZVyU7nVM1YEp3jncAgg@mail.gmail.com/

Ian Rogers (2):
  perf tests: Add test for uncore event sorting
  perf arch x86 tests: Add test for topdown event sorting

 tools/perf/arch/x86/tests/topdown.c     | 137 +++++++++++++++++++++++-
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/uncore-event-sorting.c | 125 +++++++++++++++++++++
 5 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/uncore-event-sorting.c

-- 
2.53.0.1018.g2bb0e51243-goog

