Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188326B971
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206947; cv=none; b=OXU8HSp2EhWcrHiOU63GsozuIY575VnZNOMAE5hFfUQjZ4Nq59zJfW/M5iFg5PCNhn5SHfYlkaCWhiaXWQCZEbUOkNo/H20uNXFMUAR3JA0Vipaff70YzY1PPgDk1AVJ4nBvAcdOWnQCmukGvXuj4qLVn3/xDQ4+jZ42gNK1Fk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206947; c=relaxed/simple;
	bh=YE84lpQaw1heuB719e5fRhehQLLd5zdh8g+xIVhn9Xs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=plPEOJ3pmGOHq9cb/UEp0RPz4Ykfv5vKNohwr2y5HwuX/kBlQhdb3ABbIbizPLGkFZOuMzk7dAvNBPGDU62V8/gf5Lz1HOwAK+2D2qqmJ0RkvzV4xog6YkxAc9xis6NqHu5ygUrGJiLniYo+MlkkWScMnhbm5IwZiKaB237fjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYJ5QLki; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYJ5QLki"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12339eea50bso14164019c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 14:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769206945; x=1769811745; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mLky2Yj0yGAR3m2d9nieRuLfDgaOLQS0mm28KnoRcyE=;
        b=AYJ5QLkijb+R7EP03Jdo8D3P0ALr6SzE74Ym9Xwl1B2WThJPiQ0b7mgySV7/YJD+Af
         ukiECR1e0tyJbldmTxaUsJ7B3YljTKLqJb2jgkWj2f5MxK0Fn4wsswGgkgqMLDx/uGMc
         0Rr5vuOdGSJ/DPqQ2DPCCvs7JXElafXRiY5cqqc4237L3yAwsJsI3gD6YUrupQyfwBeF
         dyTies+ZRIXuY39yNzz1FJt+UXn4uBH5/Jw2ueHFnMOALt2sf6GD7UHhIE15orekWmkI
         lslsl+bkYauovkBwjQubTrHhtzDQP5maV6ztcdkUBS1mklVxZQHqgWZetMRv6Uygtb1a
         smmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769206945; x=1769811745;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLky2Yj0yGAR3m2d9nieRuLfDgaOLQS0mm28KnoRcyE=;
        b=gMR5bS1Qo25iAWw5Df5hVvCZPuqpH3XupKBgGoEhQ0OT4B1Ppw75sEIb1SAh2ydJoq
         vVrq7SzTWB0mt/2yqFkDkQyoCGnm8W5uKdQkBDZY7CFyXKCYufN+IY9dOE4d6gDUAFy+
         G4m8ILP29cdcsmbIQsNHw0G+ikOdkuV6HN+tKuzIIuf3OF0qr8RxzYum2VRIKOuTHRHN
         zvyHyAtp+grYp1llPNGolKgwa7X2HTQ9swxbUoU6PCmVKOJfXIhKh0vV62HGOU5n7PJI
         78iO8ugtniJgPmjaT1CKmwvI2VaR/Lbaco4iX4WloL3gJTCXW+aInH6jRMVAJx0R7ZuC
         x7tA==
X-Forwarded-Encrypted: i=1; AJvYcCW/ZIukIngyP3JGUMbvIydiMFoXFhmTfNpg+34ZLSH3FWpaYUnMbWD6j1Qhz0mTBiW9ubjyUk/LjxZDsSUPKYzo@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqCnFemU9BpQarpqHRp6lmYA8NvlVjUQveHu8cBWLbJ159JWH
	VFz7EJf03EnDkYmFnMmIhmlUjn8b+XJWD+QjQDPF0m/9pEts8ccy4FcialwQXi2/6vsBhMQibOU
	t0czF3ZixwQ==
X-Received: from dlbph22.prod.google.com ([2002:a05:7022:3716:b0:124:79f7:415c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6723:b0:119:e569:f277
 with SMTP id a92af1059eb24-1247dc01145mr2527208c88.32.1769206944963; Fri, 23
 Jan 2026 14:22:24 -0800 (PST)
Date: Fri, 23 Jan 2026 14:22:05 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123222209.1181249-1-irogers@google.com>
Subject: [PATCH v1 0/4] perf e_flags support for CSKY
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Guo Ren <guoren@kernel.org>, 
	Tianyou Li <tianyou.li@intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Howard Chu <howardchu95@gmail.com>, Sergei Trofimovich <slyich@gmail.com>, 
	Shimin Guo <shimin.guo@skydio.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The ELF machine type for CSKY is insufficent to describe the perf
registers, the e_flags from the ELF header is also required. Expand
the thread__e_machine and associated APIs to optionally fill in an
e_flags output field. For uses in `perf trace` the e_flags doesn't
matter and the e_flags needn't be computed. For `perf annotate` the
e_flags are computed and passed around, however, this is optimized so
the e_flags are only read for EM_CSKY. Call chain unwinding needs to
know about perf registers during recording and in the unwinding logic,
this is similarly wired up with the e_flags.

Ian Rogers (4):
  perf dso: Factor out e_machine reading for use in thread
  perf thread: Add optional e_flags output argument to thread__e_machine
  perf perf_regs: Accurately compute register names for CSKY
  perf unwind-libdw: Wire up e_flags for CSKY

 tools/perf/builtin-script.c                   |  38 +++--
 tools/perf/builtin-trace.c                    |  12 +-
 tools/perf/util/annotate.c                    |   5 +-
 tools/perf/util/disasm.c                      |   5 +-
 tools/perf/util/disasm.h                      |   2 +-
 tools/perf/util/dso.c                         | 139 ++++++++++++------
 tools/perf/util/dso.h                         |  12 +-
 tools/perf/util/parse-regs-options.c          |   4 +-
 .../perf/util/perf-regs-arch/perf_regs_csky.c |  13 +-
 tools/perf/util/perf_regs.c                   |   4 +-
 tools/perf/util/perf_regs.h                   |   4 +-
 .../scripting-engines/trace-event-python.c    |  17 ++-
 tools/perf/util/session.c                     |  26 ++--
 tools/perf/util/thread.c                      |  62 +++++---
 tools/perf/util/thread.h                      |  16 +-
 tools/perf/util/unwind-libdw.c                |   9 +-
 tools/perf/util/unwind-libdw.h                |   1 +
 17 files changed, 244 insertions(+), 125 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog

