Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DD1FF7B4
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894336; cv=none; b=uAIHs0zM5gC3sxH0AFHH6UcVE8Ft7oy7GtD5xdEM7FXF+TMpZZXcPfMtPxcfIrPLR6yHWAJv7/cIU2JUK4Pfqn4W5aHn8WZN/hAyNj32sjXqdn2yHZouTtFSjpWSrV/ddL6zuv0PnLmA6ys0SKvbS0Iq8kAvU661KAvbFYDP+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894336; c=relaxed/simple;
	bh=zejmlYNwgS/OQpMHacoEnWFRqhftHB8onU2Qvy6vpsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cKE/MWiLgRw+q1BsmwFE1D+2X2dP+fc9oE39RcFdyrllq3gavGtKKbBFktdzLLoquNpR1Rg4bShQCK2qLhnoDUSWBVEh6EcySNWTUfB41NTsBCqUPdFfmRt0Ta5XE+HfzTl/H7E5T4Kj8Y1c96Jdw85gUFZCLwM+Fpc6cxAGP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDgFirkO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDgFirkO"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313f702d37fso2772803a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894334; x=1753499134; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dVZGHVi7sQRXRzVKkfTNIiUhn/WdB0GHZb62bnQe1c=;
        b=EDgFirkOGS85qRaiOI/zxkysJ6T1p81hM77lHF0hZuID2SuhzYP/LjkEpcEm8/8Hj5
         CTRxaWX6tsnwWTdUf/C1pygvyIniu+TISXGiv99ScBKMQZQlpcnzBxeA0/cwxftUyrPQ
         9hAvrpwrtnR3w6McgA5c36kDgSVDfuZOK4Ai1E+i3bXBOs+ThYr/q3LosEGdBnZbkmI6
         0/4Dink9VhCPL61DT1TLI4RNX1TihzGfczoRBkQm7xId+NUPfsx9C9Rky+3YdO4iU4qZ
         O5ibyJ7l9TgxyjEEfk33Qn7TeF2k+Ndk5IOq3z2qoEtIaU9oVQbT5XK7MkprFGnV6Qye
         VqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894334; x=1753499134;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dVZGHVi7sQRXRzVKkfTNIiUhn/WdB0GHZb62bnQe1c=;
        b=wzqqempDH6rf1s+PZYR0sZgglLKHUNRqoOFr2/x/uZxlMRZB7tS7qRPC/jLRCSHuFa
         mpO9TAhnlg8P+JmQbxyNLZxlPVwnIdAvnz74n1Y7lKSbZ80vYonyMwG959/5PoJ3gBUe
         dPbS+Ha4bin/kZUYMnkQG/hXSADF9836mL1rwTt9oh3lqxFFTA4EeQbA/IK+TXVCKoxj
         j1R2cEsIHHsBhDGmM1bPq+anp661ZFkqmcKf0lg/YLoiRQhffaN8eouYkLBDjWDOMHb0
         3HQrwroKBMkPnKgxA+tKEPhMff9swfA55LdSZ/YZ/M6UX3sCQksQw6awiG0rDCJ3wsC5
         Zkqw==
X-Forwarded-Encrypted: i=1; AJvYcCXTxsmF8nv47nB5jlG75LmYlAp0A5ceOI2ddYOZ2jmlPq9aN3pUjmLQtDK+qkzCieY+KLJ3VQ0KqImv95gvU6MW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9yKHqaIIkzoWibM2keciwzXEjS5MJaYuuMljVi0i7EQv1TI+
	MyWUPhUjD7gx1bJPQPkUTofngVFKbc0q84K6qLKUy9zdd8glvzF/A+ISnOX5fjmCeFJPMbKWfaI
	6SQ5cOc7u+w==
X-Google-Smtp-Source: AGHT+IGJY7ZCHAzxXWQwWCYTpvlQGS/fifvam3lq/ygXLcAuJEVe1IKP9gewERPFn8QEFZafxVK2+h8CDi4d
X-Received: from pjbsu3.prod.google.com ([2002:a17:90b:5343:b0:312:1eb3:78c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c4:b0:311:9c9a:58c5
 with SMTP id 98e67ed59e1d1-31c9f44b9c3mr18437977a91.12.1752894334313; Fri, 18
 Jul 2025 20:05:34 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:04 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-3-irogers@google.com>
Subject: [PATCH v3 02/15] perf stat: Avoid buffer overflow to the aggregation map
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CPUs may be created and passed to perf_stat__get_aggr (via
config->aggr_get_id), such as in the stat display
should_skip_zero_counter. There may be no such aggr_id, for example,
if running with a thread. Add a missing bound check and just create
IDs for these cases.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 77e2248fa7fc..73b4521ab8af 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1365,7 +1365,7 @@ static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 	struct aggr_cpu_id id;
 
 	/* per-process mode - should use global aggr mode */
-	if (cpu.cpu == -1)
+	if (cpu.cpu == -1 || cpu.cpu >= config->cpus_aggr_map->nr)
 		return get_id(config, cpu);
 
 	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
-- 
2.50.0.727.gbf7dc18ff4-goog

