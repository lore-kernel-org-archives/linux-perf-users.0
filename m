Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E42FDC30
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465158; cv=none; b=tadUQQNwZe2x5cS8+c574gSM4xb6BV5fKzjrYJ5V2Xm9qTtixjEDx2Z/bnx+i47sj5LY0NcQ79vBoNNbH0iKVYfCq/LnCnAACxtrgQrXddlYdKTZfjXwciYxDcCtNMB4nLxFySiq2r5TT64o9PQrK0jpY5yZo45MktDQbom9iY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465158; c=relaxed/simple;
	bh=0PkJR2ZVOdJgAixw8+EYDxw3BJ/phQzdubalA1Kuuwg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=WpLTFAzfFW9rEaWLMWFBoqZrM9Kkjv5V56Kqerg+t9PZMV6qO5XipvgSSfDH+Y0dclZCXONYvYDPuB8A59EJEgxksnGfX81OwUe2MUVtRaFcqdPD3R8jV4Pc1vzzeEwKbJ4vGwqPvcnJSUsmowZiHI4ATsg7Urph/5QEgQ9fu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyahtUmL; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyahtUmL"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12338d13f2cso5946724c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 14:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769465156; x=1770069956; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WsmtjAdlKWFIVdr5e0MkWWZSM/gQUG3aZ9RzF9bx7Io=;
        b=OyahtUmL+lwvRAYhjImSq4TusLXzDkz7V45IcX2oF0s62pKWo+q741Xu7ztpRCecR8
         +56bBBbX1a0glWa52xee3eCQYM/rV4KIfjk8CgdTV1+RnTz8bUBL/vdmfk0fvOXjWr0O
         nPjgWwcezMW0V9SOQ77NITt/n/HcwG8VutqbYWfnVbUZQM0GoLE3gYfbjR+NgzgS2zpF
         X3DMhthHtgegH3+mCUEnIM4PfhWxjAMn+S5VeECkDkRFGLlUWHTiHJJXnZzeWmXylRMf
         oyALXkCov9Mg+uh9NLeS8C046qBTwamCpcMMq5lkowdhj6YDqXCs6n0oE/mJEmi2aMdd
         5IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465156; x=1770069956;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WsmtjAdlKWFIVdr5e0MkWWZSM/gQUG3aZ9RzF9bx7Io=;
        b=T4jL27vYDquCnEA6oCtgvOMliGFFgBBKZsE/9SMKxBKBsglcNPwrXJnybT/p1m+gDz
         SGgM5OIsOiUG2mr4qY19u2RvYORm4AjfQItQBAPPB7Y1GO/I92RrGPHwbweWYdO6Sa9y
         71v9Z3L8vnONIilnJg9RCUud5DtblF/6OHDD2tSM5EI7H0q1FRoOauKjCfsgeVQSeLY1
         XRI6v7tcuwY+VqUniUyetJqvTl5/Pw6WqizsEWiZsNfiGFAox0IIrIq7FGTe+vWYuFuM
         5VMxkv8NFIexIq4z+b6JYSFAT0Ca2aclU98tubCUFuUrZGymM1kMYBlJWJ0CQlh5LNDk
         uofA==
X-Forwarded-Encrypted: i=1; AJvYcCW+qctHnrOPvKiNaoPpcb8hhlmQZgTD++kcuI+NupPoLk/ZuzBd3dS0AAdyd4AvzF1/YdI9TwFbAyJcAQ/9gQt8@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8q2ovHQ0G1nQzG+QNRHUSPi3FW6xZjLhOZU2H4V1tnQnWH3P
	jEIa3n4f5AwcFyPmJ/y+p0R9nZdhoGIJBU+qlKLsL6mW3/8Au7YQrLw7tHUlVENj/WRbJh5JdmE
	a8+TeYNbrOQ==
X-Received: from dlbep10.prod.google.com ([2002:a05:7022:108a:b0:11b:65e:f6a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4182:b0:11b:aca4:be1f
 with SMTP id a92af1059eb24-1248ebfd433mr2771222c88.17.1769465155794; Mon, 26
 Jan 2026 14:05:55 -0800 (PST)
Date: Mon, 26 Jan 2026 14:05:47 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126220550.2573257-1-irogers@google.com>
Subject: [PATCH v2 0/3] perf more ELF machine usage
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

v2: Resolve conflicts with:
    https://lore.kernel.org/lkml/20260123222209.1181249-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260124001611.1332019-1-irogers@google.com/

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
 tools/perf/util/callchain.c                   |  4 +-
 tools/perf/util/callchain.h                   |  2 +-
 tools/perf/util/dlfilter.c                    |  3 +-
 tools/perf/util/sample.c                      | 71 +++++++++++++++++++
 tools/perf/util/sample.h                      |  7 ++
 tools/perf/util/thread-stack.c                |  4 +-
 tools/perf/util/trace-event-scripting.c       | 16 -----
 tools/perf/util/trace-event.h                 |  3 -
 15 files changed, 90 insertions(+), 89 deletions(-)
 delete mode 100644 tools/perf/arch/x86/util/archinsn.c
 delete mode 100644 tools/perf/util/archinsn.h

-- 
2.52.0.457.g6b5491de43-goog

