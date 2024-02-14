Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719B10A11
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886473; cv=none; b=aNEdsd9L0KlAY4kpjjmNDqBzA6CPlHciUqYQWAnH4ixIYupKywVZubeD4PXtxEME1xMxNoE5C/zuKs6frpw6ZnC/qZcPwpJf2aWH6g7THj882/zIMAhmIOaE1rDfxc27NMpdO2tHppa0GUaN+OaBn8IxYwjllAyMBU9tngZilgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886473; c=relaxed/simple;
	bh=AZkj8nr3rTJwCIYBmRK7nb3+iIvG9RkuLmqV/PSrPQs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=eI4u8dglGmpOCwVyEiVmy6O8peVlEb1u15gy4CTNbDExQyR6GBB7lNfNuOjUIEXzTUgYY2kn2doBI2joT5NYXj0czEiIjChacxncfYRL5UA8y5Wi6a+GDa5MWUpUTnC4uMzdNDk9GR8PrwREdb/bWgHXBOVMnW+Q51frbg5xifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPyKZM8Y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPyKZM8Y"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60799671960so22239757b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Feb 2024 20:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707886471; x=1708491271; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ctzZOFDIDCO27f6VAbHfS1jvQWovSoWz66g42EKGfuk=;
        b=uPyKZM8YMvZZIznt1YcoDrzBj1Tk2olWjC2SI9xAFwwMlF23m+6PUoSyQxdj6Zuu+d
         7Ei5HeuvifXvbwrQkNMHGAH1/rtjrHno38Zl8I6lt8yTUOfiuuGO/KoNv6sTpmzhDczz
         muKzAqsaehNRUKTsFTDzxZ7/v6LTCVUWm9ZBIdXFy2+KnT9I4sDueqPbgNoKXekvuaB/
         nzXTxJ3L8Z68qtyTkN/+gYfFMoVbFg3K9Qo8BcOEk+6nbi3xPGnHmi0yZP8TNBFJAn4U
         l52dvZAr5tPe0oQv67DTkBGxYlUqU5hH2Mj3A4mXb2JGcOc5xCtIZKYkVkcBWHi5rs1j
         16fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707886471; x=1708491271;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctzZOFDIDCO27f6VAbHfS1jvQWovSoWz66g42EKGfuk=;
        b=q3raHdEv4jmWglOPRrid4+TeburYJ2mMry3O+l1oCKOpcAGQuLGVWydl2reQS28foB
         ze821xHPX6WEw9wOrbopH5cwfnb+CSoUQziZeSo6WwwqgeS59u73Mg6Vmw+HMda9iBUN
         oFeUCIW34VtYsym0pEtpPmpKcQmP1EdeiCRmu1uq+wb2D3BR6IHHGvNM6oYPjlJ8TNNG
         fFjHmdB3NYkBMRoViZSEO0i8a+uA5yvqcquoMKOMOpIsKd6QR9q8hY421XF4nv8uCkhX
         j/UyrfBDMKYmc70Z54+l1lKD0xOiAkh+VpFRYp9m8xi9E47CUF0WJUgkAicdTG4BkqWw
         TY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpZkx/GDObO1BscXsI1aNxz3alQlbhlg72QnkSQNFUjTLA8ohI9y4SwaUSovkXcicqpT+01/6cxvtIEf9/gOBuLExDdYcOhqHr18glx8476w==
X-Gm-Message-State: AOJu0Ywq5u2xBQXBMgjeeYGAZ5Y9hiFV3rhRz8vrC5p6uVfMbJBAsUF3
	G0KhZeTxlpDr4Bc+AHSIkwUA/tLwj6eBud/uHS6qaLs9kJQ/uItY2fT7MI91RJCtB3JTdG86j60
	i7kueQQ==
X-Google-Smtp-Source: AGHT+IGPnmcYdhlTyWdG8WwU1B8c6rYZBkfwPChuZzSyqXfDRxnlsUWRs2jjVCCjiapBLHDNTioXDCpl6oPD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:150d:b0:dc6:e1ed:bd1a with SMTP
 id q13-20020a056902150d00b00dc6e1edbd1amr357350ybu.2.1707886471142; Tue, 13
 Feb 2024 20:54:31 -0800 (PST)
Date: Tue, 13 Feb 2024 20:53:48 -0800
Message-Id: <20240214045356.748330-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v4 0/8] Run tests in parallel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

If command line option '-p' is provided, start/fork all tests in the
main thread and then gather them in order at the end. On a laptop test
time was reduced from 5 minutes 21 seconds to 1 minute 50 seconds. The
option isn't default as the test shows up perf and test flakes.

The '-v' option is modified so that 'perf test -v' will give verbose
output only from failing tests.

v4 - fix bug in width computation.
v3 - fix a crash if shell test directory isn't found, remove merged patch.
v2 - fix parallel test output/verbose issue
v1 - initial PoC

Ian Rogers (8):
  perf thread_map: Skip exited threads when scanning /proc
  perf list: Add scandirat compatibility function
  perf tests: Avoid fork in perf_has_symbol test
  tools subcmd: Add a no exec function call option
  perf test: Rename builtin-test-list and add missed header guard
  perf tests: Use scandirat for shell script finding
  perf tests: Run time generate shell test suites
  perf tests: Add option to run tests in parallel

 tools/lib/subcmd/run-command.c                |   2 +
 tools/lib/subcmd/run-command.h                |   2 +
 tools/perf/tests/Build                        |   2 +-
 tools/perf/tests/builtin-test-list.c          | 207 ----------
 tools/perf/tests/builtin-test-list.h          |  12 -
 tools/perf/tests/builtin-test.c               | 378 ++++++++++--------
 tools/perf/tests/shell/lib/perf_has_symbol.sh |   2 +-
 tools/perf/tests/tests-scripts.c              | 257 ++++++++++++
 tools/perf/tests/tests-scripts.h              |   9 +
 tools/perf/util/print-events.c                |  12 +-
 tools/perf/util/thread_map.c                  |   9 +-
 tools/perf/util/util.c                        |  19 +
 tools/perf/util/util.h                        |   8 +
 13 files changed, 509 insertions(+), 410 deletions(-)
 delete mode 100644 tools/perf/tests/builtin-test-list.c
 delete mode 100644 tools/perf/tests/builtin-test-list.h
 create mode 100644 tools/perf/tests/tests-scripts.c
 create mode 100644 tools/perf/tests/tests-scripts.h

-- 
2.43.0.687.g38aa6559b0-goog

