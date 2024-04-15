Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E918E1E
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162993; cv=none; b=gpkPKrBTTMo47kiBcv2xvvo7Tr4hdRPf0xrqO1jCpIkACvLcMBtE1n+q60Fz8FJrMXjX4YmXFOgu3Aa1r2bztwAd+XHKBi8MQ9SSUOVqZLeA0+X2tYRNzmVNmcR8v+XdHldD75WW6SJjyBIBKevfJCdscHMcbKyKq9E8O0TlKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162993; c=relaxed/simple;
	bh=1d/EDYFwGSGnOUpbaeGtzTmb3A7VDzDqdL9koovPZnk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=TjgHLUqn5WRh/kLk2dIOeKowCWCFxaTrdVN7qB1K3qV/KRw0Qz5th3C9kSb93x/gQKv3cfSWHPJaPheSBxMwD3bfc61UKHqjRe1EKyi4blDL3nW7s/b44UyC5Q+1sIkdfuaLg7Gxb8GZWwwwf4pRbUPfsGID5pGiPzzwvxpe9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcGRw8SM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcGRw8SM"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-617bd0cf61fso54690957b3.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Apr 2024 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713162989; x=1713767789; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wB0mFKuGZHW/z83jZ9UZ1kMmy9iw6kq5zXLeGG3r0jQ=;
        b=hcGRw8SMOTvoMtNVOokID05DyO7/dYhklcK3EuiJjHeIoPV5l9mEE/LT3saizYkMeB
         Qbbm3JHrFlTt0kt1DNFNkXM9ZvxqTZ+3MURAKWxyz1X2jXvcy6OFC4gMoJ89SnLuF/fG
         5qgtV4imNjqEhhc/8e5bIf+3Ogh4egdqCxVdgaB/R+sKU+pGluxKAXJ8TzzI+m/HyQjn
         ynyej5z1M89YxJJyhrBuJFCk+V5cg96zG61erH3jrzC0tewtaS0g8gTJDw0+m7TpLmRU
         Cr8PpGvlPBG3Hpl9e6m93SIsK2STdJn+Y0uvR+/yMlB3Zm6fFoJDvrh2hc6Yg3usFD53
         hg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162989; x=1713767789;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wB0mFKuGZHW/z83jZ9UZ1kMmy9iw6kq5zXLeGG3r0jQ=;
        b=h3pcCGlLrHSGyz5CIQb3EPAGsZTjhX+NTbDsJkLe+eXb5TOJilEY3VAX4z73MpzL9s
         PteCMhi6Y7WYECVOm/U7H9PCqwlDAHmUBn07PvAud5pJkG7rmQB+IG+Z/4iLuWnYxM7+
         URTQE2IEDNsoGBrazrKj8r+lATQCz/WHUUrTDGZW0zm5rXbZF4EZQxjbJABOLT1ZZxX2
         6E6jkPD0XdmkF+bGum+4UTdfxP1qweP4BBxHGckZbs+oiuj6oiUL5/k7MiaxPJ3rBRLn
         2sXDYy3mNobvsZq3G2YImD5Zse3XMR2D8kG/Gp3XxLFAKmsPUe842GPDbj8mcbkQEq6b
         Bzpw==
X-Forwarded-Encrypted: i=1; AJvYcCWnWYWBnjGVPS8rzaRSeCjwmlxCankUgyjB1V6y4SOR7Yu6GGvgK4Qxd9FvAu8NT/HalU5hKN73TjT1wCq3e+mV2Jgss/cd58VlNnm6kKibeA==
X-Gm-Message-State: AOJu0Yz3pG+uw4V2RCmmKYBiFjh0xV3FIRHV7KbiJcnQ/A5oqKwQJc4L
	+MGf9OzKhklkAqSZwbqqTfYuv8plR3/KK7AjBzdOtdk3t4bRV/eH701Vn1Kz99WJwMkoJVOREDY
	klmsOgQ==
X-Google-Smtp-Source: AGHT+IFla4MrX294yqIP+FWtWzJmxqGcQ32XqueDUfsH1OcnJlS4SzKTAazV/kcLnzG+SAXlo39sSpcyIttX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:690c:a:b0:618:9588:e9db with SMTP id
 bc10-20020a05690c000a00b006189588e9dbmr1908547ywb.2.1713162989579; Sun, 14
 Apr 2024 23:36:29 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:17 -0700
Message-Id: <20240415063626.453987-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 0/9] Consistently prefer sysfs/json events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

As discussed in:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
preferring sysfs/json events consistently (with or without a given
PMU) will enable RISC-V's hope to customize legacy events in the perf
tool.

Some minor clean-up is performed on the way.

Ian Rogers (9):
  perf parse-events: Factor out '<event_or_pmu>/.../' parsing
  perf parse-events: Directly pass PMU to parse_events_add_pmu
  perf parse-events: Avoid copying an empty list
  perf pmu: Refactor perf_pmu__match
  perf tests parse-events: Use branches rather than cache-references
  perf parse-events: Legacy cache names on all PMUs and lower priority
  perf parse-events: Handle PE_TERM_HW in name_or_raw
  perf parse-events: Constify parse_events_add_numeric
  perf parse-events: Prefer sysfs/json hardware events over legacy

 tools/perf/tests/parse-events.c |   6 +-
 tools/perf/util/parse-events.c  | 201 ++++++++++++++++++++++----------
 tools/perf/util/parse-events.h  |  16 +--
 tools/perf/util/parse-events.l  |  76 ++++++------
 tools/perf/util/parse-events.y  | 166 +++++++++-----------------
 tools/perf/util/pmu.c           |  27 +++--
 tools/perf/util/pmu.h           |   2 +-
 7 files changed, 262 insertions(+), 232 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog

