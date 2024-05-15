Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8754204B
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752880; cv=none; b=s4JqtxwBwKmjM3T+UdY235t+/+LyWuNpD0sSRvlW2mzMx3sacD1Ba25AYCkxhmBZtR9ZHzBV0ZC4Rv4uZR76GEs3G2rKnXJS2SIDwmLFUHX0SW3SI3hF87Ga1cowXdT2JAObE24Lz24+3SDV3wcAG1rBp6Z4xjPJKy52EfnQfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752880; c=relaxed/simple;
	bh=GiXxAHFN2GD4CXggEYA/tGtT5/RanUB+p73pbxTb67E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=HDOL+cUZI1arOPMCSR68eTmex7vFG56V+LaZHhRrWepltoPGkYldC59FdCkvhIWr4G+f0NKWeTQGfIGhXIgC6zirYCs6A2V8t6mcfsyNyJtQ75/kxPU4PAa+XBQyuw3wOjcWqw3avxjBQwbdnFddcYIpAp92zkdDFNExMsBMRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmpd2wIx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmpd2wIx"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b1200cc92so111526787b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715752878; x=1716357678; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X4R5s9OJ/uGB6XbGrKz0Wv7rjDRBvcB0bapwlYPxoLM=;
        b=zmpd2wIxB7IFCLe+3wEliwe9DkUK01+DlgvQQMQQs9b32JrGgNUUN/XSILM6sti331
         7CeODtG3rPsiYbnHf1eA97ODROTUZRTnjZlnK6Bii/R2BUmProHchsBiHRtqB8SPdAOU
         PE/n3yWlPniWtouVqCPuw8FT9NH5gdSYczNUhQuWH3w9oY0hXREAL6YPQ4S7JzTsBxjK
         ow/22eKTwQTAPuKks/efrVvCcb9/ClQeQrXDMvJO/cVn9OBigSG+2AkaDtFFAonPhHTO
         EaQZmKf6A7gWQ3JQNkMcmdnFPN47g+SPeGEHyjFUjxa2IfofLNMndHNqRHAhdzxYeFmx
         NOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715752878; x=1716357678;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4R5s9OJ/uGB6XbGrKz0Wv7rjDRBvcB0bapwlYPxoLM=;
        b=Kp7gvZowMGv1sbDwDUK4P/yNeGGlDIWrHFjy9rJBfZcY8JpdIztUp7xn214vNyjO8v
         tymBMCeSCM1FshWc8285ZMJ1stevlkxe756YSX7rnlM5QEhqdQML9MiTBBNCLAFGK6So
         WqSFLqJDRMDEJ/qh2tqsmjv1g94gcS5q9ZgdQSJkpEk1O43S4jjDzIoqVHr85OfMKgry
         wCevjnpB5/ji/FPR5W2GcrAAXJysvlk0wCICk0sUPT2ByaeayIt+J2yNn40F+1es8231
         8bU0YSSADhSlobLmLcOGDmZnpYdvHiTknVqaM+9PJmwMZclo6ol6I3T21R/YqFsolXs/
         KXkA==
X-Forwarded-Encrypted: i=1; AJvYcCU6EJc4e7BoSkWh3VDGub2oTnyWMmQKlOSMLI/hMKXDOj8pxzIZWgmVHmJV5dtyeb8rIJUsRg+zbi4C2yHcwfxNMUBfax95seU6cCaHdlvwSw==
X-Gm-Message-State: AOJu0Yz+rMQJsFEr/k9mG0cjt3CZRrX70SDsEOXg+XroNHgrXsGEuo4n
	pTau1XlaLzXqFMcMBO7kj+T8YzHtTRVQ087iRa4aS5DbDXKq33O33B0lcbvz42qtcTTwMGkd4b4
	6nb7oSg==
X-Google-Smtp-Source: AGHT+IGnt3HIxHi4XWke7jxmWc3mTKxLZwUxpFYUbZXCr6GXLud2W3KxEdFcusezJQDhsEbvfc3IULp16Q6u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a0d:eb57:0:b0:622:cd98:3b89 with SMTP id
 00721157ae682-622cd983e47mr25481097b3.9.1715752877742; Tue, 14 May 2024
 23:01:17 -0700 (PDT)
Date: Tue, 14 May 2024 23:01:12 -0700
Message-Id: <20240515060114.3268149-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The mrvl_ddr_pmu is uncore and has a hexadecimal address
suffix. Current PMU sorting/merging code assumes uncore PMU names
start with uncore_ and have a decimal suffix. Add support for
hexadecimal suffixes and add tests.

v6. Add necessary fix in pmu.c to perf_pmu__match_ignoring_suffix that
    also needs to ignore hex suffixes.
v5. In pmus.h remove needless addition of #include list.h but add
    stddef.h for size_t.
v4. Workaround GCC build error by using unsigned types. Don't consider
    short hex suffixes as suffixes (e.g. cpum_cf) and test this
    behavior.
v3. Rebase and move tests from pmus.c to the existing pmu.c.

Ian Rogers (2):
  perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
  perf tests: Add some pmu core functionality tests

 tools/perf/tests/pmu.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 33 ++++++++------
 tools/perf/util/pmus.c | 67 ++++++++++++++++------------
 tools/perf/util/pmus.h |  7 ++-
 4 files changed, 164 insertions(+), 42 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

