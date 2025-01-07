Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB67082A
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222871; cv=none; b=ODqCkIU81teEd95Nug5r3wBMfUWaRjleNUB1zJUQRqR/CVAbQd6HyCnkkv45iJyZO1DUOmGvUj1CtKwm/h6BsHAfA6ztU8+SOum9P8ucvaVL1hS0b3OdBrIzbwDMG3xiGrdevx5V2PnlE+ecmdLVfynDyMqV1Y/5/2lC15KgwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222871; c=relaxed/simple;
	bh=4A/rV7NFZfXh7jg8xjVV3W+JnT5JNauMb5DtLEiU/Nw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E1LwGfz5YKHzzkWhNtnkxcR3RI5amvwyVhmnwR41OrmvBXgCS7o6O2eEz5YHl7EowDsOC/b7DlHexnvy7KvUNjKdhWFMxo0tUc4LxEkxicqfA7luN39xe8KrNOfjGzyZt59HUJKT1CNvZF68cyDaL9Go/qaY7kPqDyW05dO8j8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QKkbO6Mv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QKkbO6Mv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2161eb95317so225464465ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 20:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736222868; x=1736827668; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSdgFtH3xCheJ7nv0LKAtGz6EHGRLMsLcDoLAG3eInE=;
        b=QKkbO6Mvdst/GE975o4qN1ePEERYBsgI48dKgYxRXRZiPquoUMtaVXQxI9MQww5hwU
         3t3qLbQvJOSDzarw5XslD+6IljMcEO4sjriyUdijxuPVm3OIpA6rnvF7+HDmOz53VsEM
         0QuH7CHDCnvOi5sXmpSjHoeh4yshncWq30cPFJHtkAsvctvKJwEQCGwai1VPkGkgkp1T
         RZnICOviTyeJ35igz4J5AnLx18wuXoUUrX3F3xrVAiiWE38K+o5+6xYkPJxpTkPUusjz
         pJoAmG0Lsk30mZLWyr5do+/OHgcF0CRtk7YddO/u+om1NBHZ57lWQWWD+xKp9oOwefJR
         Aw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736222868; x=1736827668;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSdgFtH3xCheJ7nv0LKAtGz6EHGRLMsLcDoLAG3eInE=;
        b=W24schPWSD1/58cdp9S4BxgI4kEEXbqq6EF1iIOJrNRADZw9ykpGlHIPmr275mUoDo
         Xqh2ixAUkN58+fr/u74oo/lxvBH+kpKinWFAkG8FPJeYJznwSfA4y8GLWaYS5Osiitb9
         zG05LiqscMkpB1L856LePs6GZj8uHX3vkxO5KScohCmv5Nc4TfU0sAV4I7sEqiKTALPV
         OX6PVLZ/noY25/Gwwt+Y26oP9V5NQ7PKsjvQho0YdxB3p8ZIV+GDRL/R6DhXpm/Fv1YC
         HASZbURNfavpUzIUuoY2aIXtOv24twCDqnil8OOnt0P6NidRfoKMvGtks5/JsPAWiOOt
         ZZjw==
X-Gm-Message-State: AOJu0YwGkuuImvCSl/yhcWhgKifghSfWJ1deLHZC13OYTSEv1o77XkRO
	l9DUlZPeE2kiyAkRleesntIMwLo0PauUC1J/6V1qvoc2ozgD1WdB+rxGw6NuG2M=
X-Gm-Gg: ASbGncvGudWFkW/DWdBf9gq5bPldUUgqa4cBz2p7WM31Fj1hcFCuuaWu/xypUXESdDJ
	bGn4jeZ+frahNoPApYPsFdgv+XKIc+5rGDOrgTcD7b/rYDWmHrm3cDIXpcOCBmzzVsFszVVxVcS
	5bThJ3BACibHZ55G9OqdknsvU31yldzvcR+vERSJ61ZQMxCTseTbBA1qJS9csrj8+qc2LnYvc2l
	PmUBdI9mnRD9KOTGM0349klyyY21k8d1wzr0oQ00eH/879+l3x9Nf/aAcMQ3K5searWrP9t
X-Google-Smtp-Source: AGHT+IHYQ5OVQucXRlEba4LZLlmlH9KL5GZAo1enNd9u+7XRPLAdBuPNCyx2tldOfTzBzrLTWT4EOQ==
X-Received: by 2002:a05:6a21:6d98:b0:1e1:aa24:2e58 with SMTP id adf61e73a8af0-1e5e044b0c6mr99067195637.7.1736222867996;
        Mon, 06 Jan 2025 20:07:47 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-92587c62eacsm11698726a12.21.2025.01.06.20.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:07:47 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/3] perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
Date: Mon, 06 Jan 2025 20:07:31 -0800
Message-Id: <20250106-perf_set_event_limit-v3-0-dbde0e90ddde@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOofGcC/4XN0QqDIBTG8VcZXs9hWmq72nuMEWWndWBpqMhG9
 O6zbgaDscv/B+d3FhLAIwRyPizEQ8KAzuYQxwMxY2vvQLHPTTjjJVO8pDP4oQkQG0hgY/PACSN
 lqh6Krq6lUJLk09nDgM+dvd5yjxii86/9Syq29Q+YCsooSM1MLcC0VXXxmFxAa07GTWQzE/84m
 qkfDs+O5qJTumelUfLLWdf1DU/i4aoDAQAA
X-Change-ID: 20240724-perf_set_event_limit-079f1b996376
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3329; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=4A/rV7NFZfXh7jg8xjVV3W+JnT5JNauMb5DtLEiU/Nw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rNiu53667cnjXjjeqitb0KzJnFLl3NdzcGnGBbVLlt9
 dUzhpdqOkpZGMQ4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZhIYDAjQ/9fxifav9XDp5kc
 6ni4LUAwTkT855+YCfei2zI+O0Ycmszw31uL01aJifPRsbkm940152uFzzfcbrgjZcVEozkuhln
 fuQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Introduce a new perf ioctl key PERF_EVENT_IOC_INC_EVENT_LIMIT that
functions the same as PERF_EVENT_IOC_REFRESH, except it does not
immediately enable counters.

Also create a libperf API perf_evsel__refresh() to allow libperf users
access to this ioctl key.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
This series is going to cause an issue conflict with another series I
sent [1]. The final patch of this series changes perf_evsel__ioctl() to
accept a unsigned long instead of void *. My preference would be for the
following patch to be squashed onto "libperf: Add perf_evsel__refresh()
function" when applied:

From 66ab7b57c8b5a94c02c8d82204338b0ebca48bc5 Mon Sep 17 00:00:00 2001
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 6 Jan 2025 20:00:28 -0800
Subject: [PATCH] libperf: Fixup perf_evsel__get_id

This patch should be squashed onto
"libperf: Add perf_evsel__refresh() function" or
"libperf: Add perf_evsel__id() function" when merging.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 1cd1680d28d7..8690588c0ba1 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -521,7 +521,7 @@ int perf_evsel__period(struct perf_evsel *evsel, u64 period)
 
 static int perf_evsel__get_id(struct perf_evsel *evsel, int cpu_map_idx, int thread, u64 *id)
 {
-	return perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ID, id, cpu_map_idx, thread);
+	return perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ID, (unsigned long)id, cpu_map_idx, thread);
 }
 
 int perf_evsel__id(struct perf_evsel *evsel, u64 *ids[])
-- 
2.34.1

[1] https://lore.kernel.org/lkml/20250106-perf_evsel_get_id-v3-1-44eca9194f1e@rivosinc.com/T/#u

Changes in v3:
- Use uint64_t instead of __u64 for consistency
- Link to v2: https://lore.kernel.org/r/20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com

Changes in v2:
- Drop discussion about signal race condition
- Add new patch "libperf: Add perf_evsel__refresh() function"
- This newly added patch was pulled from a different series with
  modifications to fit the new ioctl key
-
https://lore.kernel.org/lkml/20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com/
will be updated
- Link to v1: https://lore.kernel.org/r/20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com

---
Charlie Jenkins (3):
      perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
      perf: Document PERF_EVENT_IOC_INC_EVENT_LIMIT
      libperf: Add perf_evsel__refresh() function

 include/linux/perf_event.h               |  4 +--
 include/uapi/linux/perf_event.h          |  1 +
 kernel/events/core.c                     | 17 +++++++----
 tools/include/uapi/linux/perf_event.h    |  1 +
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 49 ++++++++++++++++++++++++++------
 tools/lib/perf/include/perf/evsel.h      |  2 ++
 tools/lib/perf/libperf.map               |  2 ++
 tools/perf/design.txt                    |  5 ++++
 9 files changed, 67 insertions(+), 16 deletions(-)
---
base-commit: ed60738a9b7ede4a4ae797d90be7fde3e10a36c7
change-id: 20240724-perf_set_event_limit-079f1b996376
-- 
- Charlie

