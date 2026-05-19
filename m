Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5662D25C6EE
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155474; cv=none; b=hmOC7sFogP98n1asxd8uCzZGjShptE2khn51SwbO/PvyjjAveHr8oQat/x3gMllUeV5ZlyU8PPsTvgN3CEGxvDtFaXfK+8NWPJH7D2JZTNqg6ryhJpZq5vPsQ3/xiQ5A92evdO0L7M46I2cBk8ty09HdYWOtBor/EoCBYhkjCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155474; c=relaxed/simple;
	bh=riyWp2NwEYQcqEft2uViZHthxm//WXQulg+rWxeeONU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ddIXeAthKZh0hlsSEER2F7a7D2odfEOpHATwIxWYyECkfI8iuHXbdklPEdWMyBZ4PkVQJumHbmx5EcdkoZmnvdTWKN/Oti9LGNTqtg4qDlkU91ciMWOUSUbOIY/H2vUnm6Dd6QhpJyyBCZIOc4Vo0wO+P/pJqWO2CGfc9vrZC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+JwYh+o; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+JwYh+o"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312be8a31so10770646c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779155472; x=1779760272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y00rT6ya1oTmvPl3RxmxLmoQAn0kyRfCRvEy0yXiqOg=;
        b=d+JwYh+oqZjVmKHpYXKlgTpcOZ50a9g/HzV7VAoikPxAGD8B7lNYM1aTIZyKSL1KB0
         M5CgC7HTtg34IcQNmLlXpSvhKt98i3+jOhVhU/Ym17SphHyW6+hM9SMOE/9UXkBmtmuy
         Fwjpd3O3LJnOv+gwIsfjZRnb4/hIWYOPI5M/gXJc0MprUjHWzWELhngKWndWtITF1K6e
         9eXMCImD+ap8K6pMf2CwPJDGEZebDz9gzsGOl1PxN5x0EvJRrCb8UDjLTbjdd4l4aatQ
         U37lW4/s04nGaO3BC5G+HlfiKQENFVjMdF9lqGJ1dw/OOoD/wJOK65xZpgmy5cSBfGNy
         pxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779155472; x=1779760272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y00rT6ya1oTmvPl3RxmxLmoQAn0kyRfCRvEy0yXiqOg=;
        b=m5YXlxCLyxBElklVR0PqNJkZwmdOjh/RZwnK+kX8E2yKQ3Wsn64lYXnI0SlHv2Im3L
         GqfSaYs47iVuES2XUt2ApgmBnS14r4meC4uBq3g2AIbLPfryM7QENC8jS4Ljw/k+PXRQ
         84ACvXh9pPHN+iGmDtOAQzHNnMjcvowb/Us3I0BD1fPoME9nTOx6CO0KLb3+gCWm1bZv
         6O7FEeS/ljMDEdI66xXR6deaih6GOMp4Z4WyOZdz4OEBu/GfZ0v9iKQ5+fCb7zBtA9Ot
         LT3wPnlWcStTdAEiCS2qVBDz5+7dymJH+qG5aWINd+o7g+JLGvUJrXvNAMyG6XKra3dU
         NQgw==
X-Forwarded-Encrypted: i=1; AFNElJ/76opgRh4VYwMatlH7SYYfk1c2Y5aQF45nyWrzY7dz2F3eQRkWQqXoxueuN1YcUi3q6sSUsY96gw0C4K94WVbr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KfmvqqBZOoj2GtmEnv5i8vXG1hXaq9WDGImmfoBQHgKCAmlB
	Sb3eT2phVhAgacZIEM6AJIy84a1k2jf3CPJlEsYHj60mWlxoB03ZNmgoJMLoGSdZ1keKY6VZJPE
	t91M6moCfoQ==
X-Received: from dlboy10.prod.google.com ([2002:a05:7022:128a:b0:134:feba:1ec8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:290a:b0:135:2704:cd05
 with SMTP id a92af1059eb24-1352704cd3amr3991518c88.18.1779155472128; Mon, 18
 May 2026 18:51:12 -0700 (PDT)
Date: Mon, 18 May 2026 18:51:06 -0700
In-Reply-To: <20260518222228.3027004-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518222228.3027004-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519015108.3094513-1-irogers@google.com>
Subject: [PATCH v2 0/2] Fix cgroup metric association with BPF counters
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, skanev@google.com
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where cgroup metrics were not being correctly
associated and reported (showing `nan %`) when using BPF counters
(i.e., with `--bpf-counters`).

The root cause is that cgroup BPF counters only open the "leader" events
(for the first cgroup) and leave "follower" events unopened. Unopened
events have their `supported` flag set to `false` by default. During
metric calculation, `prepare_metric` checks `evsel->supported` and
discards the value (setting it to `NAN`) if it is `false`, leading to
`nan %` in the output.

The first patch fixes this by propagating the `supported` flag from the
leader events to the follower events in `bperf_load_program`.

The second patch adds a new shell test (`stat_metrics_cgrp.sh`) to
permanently cover this scenario (testing both with and without BPF
counters) and prevent regressions.

Reported-by: Svilen Kanev <skanev@google.com>

Changes since v1:
- Fix commit message for patch 2 to remove the mention of
  insn_per_cycle check (which was simplified out).
- Quote variables in shell script to prevent word splitting.
- Use grep -F in shell script for literal matching of cgroup
  names containing dots.

Ian Rogers (2):
  perf stat: Propagate supported flag to follower cgroup BPF events
  perf test: Add stat metrics --for-each-cgroup test

 tools/perf/tests/shell/stat_metrics_cgrp.sh | 123 ++++++++++++++++++++
 tools/perf/util/bpf_counter_cgroup.c        |  15 +++
 2 files changed, 138 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh

-- 
2.54.0.631.ge1b05301d1-goog

