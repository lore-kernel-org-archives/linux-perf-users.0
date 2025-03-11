Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B107415820C
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729003; cv=none; b=g8UiAp/CompPZIUt/C/IuQfO+hMe5KSbMh20O4kzxgg3d4vH+QbduNiVM3HlO/UpcnHSquT2YhnPsGvv9huUu54BRrO+dEJ4v3/VAMs35Smqoz22W0EwfWUZfGRaw7SMOOVlw3KYNPutyo1U5o40hq7zBUeagwF2+RbgWTwHVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729003; c=relaxed/simple;
	bh=sUwbT7WOgD0FIknigzEgWXhmOc32K/iEVs+GUL5v1TQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=MvFLDJO93Lr8/7X0Oh7xasVXp8HdlNCzjzuwPcbVc5ipLUKdKeyw8dbNXpJ35MAgq9rM+0C9gb/PYQXtSe5zKxK4rQCxjMvGaTROJ+ebL9J4HK5+6vk273Ou9n64Ni0RV+71SS4jMoJ5fovlvZ8HoUsvmkYiv7TfrZa//Gov7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQqr2fKS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQqr2fKS"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e572f6dee18so8507656276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729000; x=1742333800; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gdbMrZ6QKc/HSgRcVo2vPMQTZhcAPxAyZ2QgrcTsM/g=;
        b=wQqr2fKSjKgZDLNnWuw+djo42uqZcedYIIbAczV3BRrxhU/1FHKnFDsl3iqs6YblgZ
         aQPrywDKpBe5TOqQZXu44Mg56rIzPb/9vcNhyCl/Qz0A9SqdpjxumZo9y3npY86E24lQ
         vqZ836gt4ltu1P9712LEIvJxt9BGp8QH/HAVpmhlz4aEfqF7vQhiDharp6z6D+ckkaHS
         SSY4N5TtiypTwkboQuZKEpCoPlV6ob1wG3Ikis2bRcnLM0WSEqlXE14qA9QfNRxs0mXD
         N1kje0H0BdtAG9h4Jhcqzgbw9+8SfCtVsEz02kcdsBFqD1RsALvtU/a+ix9j91nInwD6
         HvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729000; x=1742333800;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdbMrZ6QKc/HSgRcVo2vPMQTZhcAPxAyZ2QgrcTsM/g=;
        b=cMHnb2PgZWPl+y5lU8osEAdxvzz86ZElWPsHr56hxcrkHQjGFzrTYonvXG8rQxCpBF
         TdFW24iKYjkq1BY0JNjbU3bOjGXGGFaxLgcVnXYrmjLF7xFWqk+JDQ9+r2Ek6RvCu91y
         /025Bb0UvSo+ZnM/TKAginujBChEErzv7ZwIbH1M8I8roPsoXLtQbnZfxhx+SNqK8Zpz
         nN+ioQBpm+z4sZvToNe8/DJfOmppBZafWX1hCvxFjXoo4AZTNA7SoeVG9wYZgVU9rETx
         pLkeHY9uYRScI/5QdqUXIVHuKq2yOuVyynlBIEGiAPfJpJyQf7yoZndOX2ypOY7EP28z
         Am/g==
X-Forwarded-Encrypted: i=1; AJvYcCXsV4yDofYm28z4ZB6kEsjtBa4SfsmxnjcSl1HTwruuKtmJNabGaJDCkxCKFfhxuDDxyuZ8BYysO5fgwHG+Oxt/@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtqHfe0kKkTbu+zWc8pX31CWd3i/hB9N+oVA1osl1ZzD1URQh
	lrYpzpqYZyfbkDK3b2wwXeS/WOkBMGLyRyJXn+T9Y34MwKaoMAyFMQQq7MJRM+NUzraHWmWnBhD
	H1D5CVA==
X-Google-Smtp-Source: AGHT+IEixeaWWdDRv7NsutZMCUQWM8MFfqMHG5r2TPiZPbjziRKYbNJ8SDXErqEIpQt26Pz9sgUXxloTZYNL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a25:bbcc:0:b0:e5d:bd27:92a with SMTP id
 3f1490d57ef6-e63b52006c7mr35598276.4.1741729000628; Tue, 11 Mar 2025 14:36:40
 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:22 -0700
Message-Id: <20250311213628.569562-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 0/6] Mypy and pylint build support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support building perf checking the python code with mypy and/or
pylint. Currently there are too many errors to make this a default.

Shellcheck generates no output on success, so linking shellcheck files
doesn't cause `ld` to fail. Mypy and pylint generate output that will
break `ld` so change the Makefile.build to ignore test log files.

Address some initial mypy errors.

v2: Rebase. Add James Clark's reviewed-by tags. Add example mypy and
    pylint error output.

Ian Rogers (6):
  tools/build: Don't pass test log files to linker
  perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
  perf build: Add mypy build tests
  perf build: Add pylint build tests
  perf test: Address attr.py mypy error
  perf python: Fix setup.py mypy errors

 tools/build/Makefile.build         |  6 +++++-
 tools/perf/Build                   | 32 +++++++++++++++++++++++++++---
 tools/perf/Makefile.perf           | 14 +++++++++++--
 tools/perf/arch/x86/Build          |  6 +++---
 tools/perf/arch/x86/tests/Build    |  6 +++---
 tools/perf/pmu-events/Build        | 25 ++++++++++++++++++++++-
 tools/perf/scripts/Build           | 26 ++++++++++++++++++++++++
 tools/perf/tests/Build             | 32 +++++++++++++++++++++++++++---
 tools/perf/tests/shell/lib/attr.py |  8 +-------
 tools/perf/trace/beauty/Build      |  6 +++---
 tools/perf/util/Build              | 31 ++++++++++++++++++++++++++---
 tools/perf/util/setup.py           | 10 ++++++++--
 12 files changed, 171 insertions(+), 31 deletions(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog

