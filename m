Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DD2D052
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760215; cv=none; b=LmMeitbbwvus8kw8cgbeC7JU+KTsoYzZY963radZ5Clq1Ll6Y45L64F+Ls6mFTcpaTbVHV95DmsRN3aqYMv4/uFqfaWKqT2lY9W4rVGgHkJeFGgOIVwCa6B86uaNo7yuPmt5QPEbn+JDFyKSZa+8eroTzEzPBcAk+wckQJW1a4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760215; c=relaxed/simple;
	bh=Y8Z+G3E1FwYZnGTVV2SNsuzXekibwKvHxDpS4gzFmHY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=CXjgLtR8GNrPfyXVTr/x0U52shPWMLGYEEkCXuCwQ6nzzCR6wi0+1CPQZB6K2d4tLGQ5unHI0MNskImbCV1XEjeV2epguDhicXRz7CT4AlKkB/CIN8WAqzRG+00uvG6eXXwF6JFArR7YzZtGvVFstuZsFfv362Za1+bziPpjLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nt3v/os6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nt3v/os6"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2270a147aso79906257b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 22:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760213; x=1728365013; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hnPZq2wqBO5wayp+/qP/HbZeSdJX2pF+L6UWiisy/g0=;
        b=Nt3v/os620rgEU0b2P6TymK3J/vzThPOY2biiWLo2lDeOhsq9BUj/MbLGCze+mVBz5
         QU+KX2Z/IfMR6rsbh6Ibe6rETf22uwvo35HkzZWbQ06r9pu7+UvVHnlfnGZwDl1PzXOI
         tudZO2wIWrwTaLCUXViPw/nRB2+VpwRW4rOxFFHTy0ZmIMewny/ikZK1pBgMYh3KSzvf
         Vv9EtRxaIM70VxqDfu7NnHmMPrj0rXobocESxiCEO8mE+rRZedJCbFWjXiaqQ7tsDA1T
         NRoR9Fh12fVhI7hwGN86t49oDMWjxHzie3wdgo7ZOu6exTrHFjabFjoEYQ4VONSuQN5r
         OgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760213; x=1728365013;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnPZq2wqBO5wayp+/qP/HbZeSdJX2pF+L6UWiisy/g0=;
        b=CBrwQtkFXW7TjPXvk/QGiIniQdkanuHoGynXtrZVfe1Bos1PYyeFFXdcYr+DQIkf+G
         nYZAFcCUsQX86Co87+GhL30NNys0Jfarz4QQYh3EwRnlrInIfLuiPA95uwKKPYsKM1n9
         /wEzDZWH1jrljzkiJhRtiLRkfh6ZwcxEfQUxly6fu1Y+/InuA0v98mn4OjlrSt+nae33
         hEYiJC/zBQujXhS2Y5HGObgwvtgA5qwf7/URB421goQaKEAfttG4As1BLQX2vYaTH2F/
         zi0pbCrx4d5hlR9KMoSsnDintXd+/T0/SqeXBNn5qcJZ5rQmBs0k2g8Na65KeZpvNzpg
         WocA==
X-Forwarded-Encrypted: i=1; AJvYcCWe669zUzbDLv4lTtPVyJbhFkIljOWtblmNjeypFUtH86v3o7itj0xXQjC8gzs5mGnmmYVXzkBSrRcLTEpFQT1H@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVqMOqHVufdk+C1tG+mKVoR5td+TT2syvv0eBb1ccrr2kf33A
	afseMxgmhWYabyT8RLecpLvs9NezoiDsqQSUSjRopbZJXcXjdmP/jO/ylRonpiAJSPrXWZUkPls
	muEYfmQ==
X-Google-Smtp-Source: AGHT+IFufDeXAVmZbG9ihgubBavhEoecSpbNDyEAJ4lV55EVPCl28X+PgpGUKLM8QNB2RQYqA4s6NzGbs3t1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a25:7bc7:0:b0:e20:2d40:4b82 with SMTP id
 3f1490d57ef6-e2604c799e0mr102605276.8.1727760212503; Mon, 30 Sep 2024
 22:23:32 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:23 -0700
Message-Id: <20241001052327.7052-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 0/4] 2 leak fixes and lower 2 test fails to skips
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix some memory leaks that show up testing as !root. Lower some test
failures to skips for the !root case with a skip reason of
permissions.

v2: Rebase that also cleans up on the bpf_counter__load error path, as
    pointed out by Namhyung.
v1: https://lore.kernel.org/lkml/20240924202916.1560687-1-irogers@google.com/

Ian Rogers (4):
  perf stat: Fix affinity memory leaks on error path
  perf test: Fix memory leaks on event-times error paths
  perf test: Skip not fail tp fields test when insufficient permissions
  perf test: Skip not fail syscall tp fields test when insufficient
    permissions

 tools/perf/builtin-stat.c                   |  2 ++
 tools/perf/tests/event-times.c              |  5 +--
 tools/perf/tests/evsel-tp-sched.c           | 40 +++++++++++++--------
 tools/perf/tests/openat-syscall-tp-fields.c | 19 +++++++---
 4 files changed, 45 insertions(+), 21 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog

