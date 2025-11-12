Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CE24A044
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977199; cv=none; b=i8K0dh7CA2rlGyS7e/krf14CXBAf5Ts2boJLiFo9GdZP68hTH7Or+pwYwjdyk2jJYXayqb3UQ4yAkbYD5R+PdopqHD78NB/Bv8+ObKmnfNSINB3c8ABtZrrrhAEgJRkr9i5T39SOu1ti5vAmtwfPMC0/BJlBiuFl2JvWu+3PJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977199; c=relaxed/simple;
	bh=Mt4PkZwYOMGZoupVLZfiSVDVEqcX3IkEmjMvcMEiubE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=KU77aKGWpnUFrc6UC5GfdJcFUGCErYJg4RLlaQV8Fi13eAAt/zggkLuKsh9fmqq+06RFcVq0DHdYjzRr2O8Snj85c7/6JOZOIs8v19q+NBubE6Zqf0vQuxs5Ib9NFIFCfXDqznpLs9M/GQQFAR1wdtJ/6Gtlzk5zetIFt3CMtDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYkCqFzw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYkCqFzw"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc349a8a3easo5868a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762977198; x=1763581998; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=84G8eoSACWzBai0CppLU75VrSMUpLrAmepVMsjUJ5vs=;
        b=DYkCqFzwjdhrQPiY5wYYne+HD6HqUpVna5tILWJLVyLPda3JIfiWc1wu73zxd8ViS+
         chIP5Cn5MXE2hyctowEiplffu+x4w6HCzxaPvGVgEy9tAaegBgV4hMAmtRMGCWzFt1SD
         epJdBxygVVMKhNjw+7egtHSIISJx88dkg2xp89Y6IElcx2yaqmUZq3CNSTXnxkJomMg7
         x6AM2OAI6gfwp9yj7bSe7+pME5LCtgHANExMln6GOBY7qkJH7fC20+H2EXce9gKqji+Y
         FiQUG8Nehge3NWK+SFdWWJ9CaQK0vtUVUYjshetU3KpnLZDsVpX2pR6ZVKTyTgtbS/80
         64FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977198; x=1763581998;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84G8eoSACWzBai0CppLU75VrSMUpLrAmepVMsjUJ5vs=;
        b=PtpRjz6wQhRuZov3+r67N1+g5GMDtMHDHUOe4S07Jm/a/kABKZIlbZSHAMk9Bam2iv
         zhdvfm8eqX3EJh1rsCqM1xXWy8l4DcXJaQVE/0vKG36Qzb1ktKQ6gW0Ig0iTO4nyUUce
         Pg9MQINIuxngS2VtOZifIAqT4iZwIVJkiYO77wo9C22ZX3fm2kfuLq4or0NoTEvOHz8i
         23F8+1/XCVh3T12e6IkmmqO22VhRpPoehyaxIGvxPbTmoQDvtaORXqhcIGKe798MX5+i
         yiDfXPrLteRdSf37ZZFHFuYxyU2SiZnD5Zse6q0ii3s2Qc2UrUBpd7bBbJWISSG6yzVb
         Tuhg==
X-Forwarded-Encrypted: i=1; AJvYcCUAtKTWI3WCE3229OfpnOgXjQ84sTIF+Kgj9TSaLDlwLQ5HqCjBV4XXhoWiey6FZ7ax7tkrsLy31UxwFp3aViVY@vger.kernel.org
X-Gm-Message-State: AOJu0YwcH3SqCsAxL0vILmLSjerzOGy5Z9YZXa2uGaw5csB5TFoPsk2y
	E8zKOcrfx41IUAmOy4hpSLMOTU4rvFsM3+auvY2LZBd73ElMA6vUXOR6JMc8ZfoXbcQT9uAUk5J
	dmq9nBLNpKA==
X-Google-Smtp-Source: AGHT+IGJsZZQpwRbl5QFTT9oCGX/5ODEzI1gvvBHeZMwOQsfJYRjBRBRZfYsO6gV6qpNlx5+42xlWie3dztl
X-Received: from dlqq42.prod.google.com ([2002:a05:7022:63aa:b0:119:c6ec:cc42])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa7:b0:27e:f018:d312
 with SMTP id d9443c01a7336-2984ed2b587mr55528845ad.1.1762977197818; Wed, 12
 Nov 2025 11:53:17 -0800 (PST)
Date: Wed, 12 Nov 2025 11:53:07 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112195311.1673981-1-irogers@google.com>
Subject: [PATCH v2 0/4] Test fixes and debug logging
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Testing in a hypervisor guest showed some issues that these patches
try to address, or improve the debug situation upon.

v2: Rebase. Tested Arnaldo repeat case on Intel but didn't repro,
    assume was fixed as part of the legacy metric json test fixes.

v1: https://lore.kernel.org/lkml/20250914182900.1960567-1-irogers@google.com/

Ian Rogers (4):
  perf test: Be tolerant of missing json metric none value
  perf parse-events: Add debug logging to perf_event
  perf test: Don't fail if user rdpmc returns 0 when disabled
  perf stat: Display metric-only for 0 counters

 tools/perf/tests/mmap-basic.c                       | 2 +-
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 5 ++++-
 tools/perf/util/parse-events.c                      | 2 ++
 tools/perf/util/stat-display.c                      | 3 +++
 4 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.51.2.1041.gc1ab5b90ca-goog

