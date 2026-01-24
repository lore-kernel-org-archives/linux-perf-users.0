Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749773F9FB
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Jan 2026 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213779; cv=none; b=FobW3Gd1MphRYfVVfQNjJKEkarrUHCJ2+J0SesqW0ZP0pQWExL6OC5h94J/z8d0msZhHUYSMMsU2slTU4RexOr9s0UaKCR4YtHEmQRdS7g9XUjH67wDDfg2spm+BHG4uuqLtKuUDpt74M10DgjERni2n4fPdzLRP8ucuurJ7Qbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213779; c=relaxed/simple;
	bh=l1OtJNRmVlpHOTj2Smi8RX+2ZAUb7q4TwQvX+GYCjZQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Jy7MhWaPmiaTtBcfn8S4LAYWKWJ3lu/cmlbRo6i9YXqmI1LBW3wXC7Sv+YFUbUsLGCRs0fVg4xDyVxc7NsTTcBSUWnN93HTqthkyDPjlWhB10HHn6YQiAwZ5o1Km4nZ6AnQfu/pkPv+bf3gmBhOKXnmxVTy/MUoEqsf+IB5+znI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cekQm7hV; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cekQm7hV"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b708fa4093so9915337eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769213777; x=1769818577; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cWBaKaTJtS+F22NaAxygstDx+g/XbGwM2Z3qb0zl83k=;
        b=cekQm7hVJJwM/07iNjDMLxwSUtHXhs9/eY3b3gj1EMiCvfVCK2KZRi0U4PkW64h6We
         MeLrrvla7qeyJXEaediYBWYrhaZOPGytPwygHRGuQk1zhgYLgF2z/V4FmD6iY7ut1iNi
         GdYPm6McR8PuA+1o8bf3UgEKfZh8m2UAei3EfjWk5hpzMfhLUFhaxZSFW0zN+MUWCymK
         dwk9pDya5EV8tHWZfjigUbiec6bfRHeD/eTNzpi2ix+IRwGAgDAsWcGbMbfIVO0u6gFt
         NfuUJfEAxP8fI7t9hD3Mi5SIj4I2vZOrM2Lj+M5e/idUVjC2s8V3Ths4f8yHUH1bv9yy
         5pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769213777; x=1769818577;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWBaKaTJtS+F22NaAxygstDx+g/XbGwM2Z3qb0zl83k=;
        b=JpJNr0GgTh/SriCnacMDuJARPhfni6P/1JqCmmO6qDqoKZxNVRci9SG/tK0RFaL69N
         TtBJm6vEitgreEmV0XnYdOIqdriNy+5fC6GUHHLjXBSQRuJ5SAtWyNESFFNBPz3USnMM
         EChkqb0kj6XzQ8JPUKCHm7TgxpDTJS3z+KWg9C0KBf5uAL3BU51leGF7JZo4r+W17x1w
         0rRFWLhx0T5Hvx4CsEqB9h5aDjQqz7u+6vp7x8eM/u9+FZG5vsFOR1WV0BwFXnN+p6n5
         9Vet0Xm5iJxUT8NK7xYgk7yJJvGj2IecYMqUTT8ga5JBNba+lBiOlgAC4caW3CNBpYKh
         W62g==
X-Forwarded-Encrypted: i=1; AJvYcCXylqAI/d0PYieltS9v/73+tpYNWVhWsCoQjW8Dkkt6iMi5C/bqut6/8CAVgD16d/tFiMzhQMa1cgGDt5YIXKMy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86cvtv+y3QQ8a7q3FAD/IE/zpPgws6+NjLkxJ/ErwDeAHpRY6
	L0l1hgI2/yPdd6Ej34uBFdHywpZMyCKMBz2Mn1AHkDIbYRimA8YoQPKkx6iDh0HDMStXQvYST0s
	PLvEQuYEEQA==
X-Received: from dybqy24.prod.google.com ([2002:a05:7300:d718:b0:2ae:3309:a304])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2393:b0:2ab:ecd0:5221
 with SMTP id 5a478bee46e88-2b739beb562mr2094171eec.42.1769213777390; Fri, 23
 Jan 2026 16:16:17 -0800 (PST)
Date: Fri, 23 Jan 2026 16:16:08 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124001611.1332019-1-irogers@google.com>
Subject: [PATCH v1 0/3] perf more ELF machine usage
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch 3 more cases where the perf_env arch was being used to
determine the architecture type and switch to using the ELF
machine. This includes the addition of minimal instruction parsing in
perf script for architectures other than x86, or x86 when
cross-platform.

Note: this series will conflict with the e_flags series:
https://lore.kernel.org/lkml/20260123222209.1181249-1-irogers@google.com/
that adds an additional out argument to thread__e_machine. In all the
cases here that argument should be NULL. So:
  thread__e_machine(thread, machine)
becomes:
  thread__e_machine(thread, machine, /*e_flags=*/NULL)

Ian Rogers (3):
  perf script: Fix script_fetch_insn for more than just x86
  perf callchain: Switch callchain_param_setup from an arch to an
    e_machine
  perf thread-stack: Switch thread_stack__init to use e_machine

 tools/perf/arch/x86/util/Build                |  1 -
 tools/perf/arch/x86/util/archinsn.c           | 27 -------
 tools/perf/builtin-report.c                   |  6 +-
 tools/perf/builtin-script.c                   | 20 +-----
 .../scripts/python/Perf-Trace-Util/Context.c  |  2 +-
 tools/perf/tests/dlfilter-test.c              |  1 -
 tools/perf/util/archinsn.h                    | 12 ----
 tools/perf/util/callchain.c                   |  5 +-
 tools/perf/util/callchain.h                   |  2 +-
 tools/perf/util/dlfilter.c                    |  3 +-
 tools/perf/util/sample.c                      | 71 +++++++++++++++++++
 tools/perf/util/sample.h                      |  7 ++
 tools/perf/util/thread-stack.c                |  4 +-
 tools/perf/util/trace-event-scripting.c       | 16 -----
 tools/perf/util/trace-event.h                 |  3 -
 15 files changed, 91 insertions(+), 89 deletions(-)
 delete mode 100644 tools/perf/arch/x86/util/archinsn.c
 delete mode 100644 tools/perf/util/archinsn.h

-- 
2.52.0.457.g6b5491de43-goog

