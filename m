Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2614A08D
	for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330973; cv=none; b=dsTZVWNHJ6UpFRo05R00VaWeS4oqoALFyPSSSTeDNW33K4Nhccyu1mFdveBlGk1Hl12lZysOMHVy8WZEX4xClqxGswqCyzO8G0EWi28c6HQMwTTqICpUdTFXWs9Cs5nI4bnyDSkl9FsSGknzT7nM5tHdNR8620nDtCr+V8PgzD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330973; c=relaxed/simple;
	bh=QGxpTjj48GaRZSK2/CFDsNhCOvq+ZWj3YumGS/8jXG4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=MAo2faSkuroveAlfxqdSeZdyjgPgPDBESirSaAyxN1yYmqNyUMiumtynEcJdUYTJueUFPPWXMIjyTpke8BigENn2YHzjO3eWeGx9vOl8Yp6H3TmFovOysGm6PUFozubzEnQyBhccjCMwiTb7BWj2SUNJMnCE67lwgxjXbswyUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kqZ0cTw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kqZ0cTw"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61beaa137acso223509697b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716330970; x=1716935770; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9zyIB32Gej4Re6et8G9BG0IxjoKckxZsG/WVrAIAd0=;
        b=3kqZ0cTwUbRa8xe09xpufrt+jkmksHq6ZaAaz3hHuGTx1h/MfwzqjBVOe53aykf0Xg
         701SKr4YGcveVwy7Lzl9Li3vGyY35Gs9kfigAhXvB9c8n0qTpfsgl6kU9H2Kf0Mo3rsw
         NF3uv9zf3PnqDZc/c5khXrzsIrHZ6PacHAKDg2jFIduio2OfPno//PjZ7o+emJoQCYtk
         uJbZqw9KQAg94eC1ICxZMjtarf85KT/eN8Rtlzhqz/u9XcplNhjgirmphb2eLURsjFsG
         33debaEk1wstCu/ZS5U5IAsf+h9lSZWdVvxhHcS0navEgeVQGi+qhZerf8samge2ci2m
         fdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330970; x=1716935770;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9zyIB32Gej4Re6et8G9BG0IxjoKckxZsG/WVrAIAd0=;
        b=Uhtnodpu+PqP27E21ANJrF/b703eU3rWSWkJe5rB0ke4Fg3iIocHKtf+0vjVjaq6ZR
         ZsBnwCNNpQR+7X3rfn9re1EcNjKRP5uVQGNWohLXGa34zL7qYIFSErxQVRTu5nvKAa8j
         Lp81YTSNMjy7ZGvR+PaHTnNb3IFJ3UIUJBvXqo5XY3D3RW/Q+SrK4JhukkrsLpXfl4D3
         cctY52UpSZ1Dj1JggfFRVRlFJRNy4pS1cke4RkxQJYqnqk9NwwTL1CAgiMRKNvvnVWry
         bri05LZ0knKgD9R9QiaR9j6WoWwQJjfubEzXzjK9lDw5SCuN3BfSXRNmVdOtAKJFKK7w
         kRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM7bYmahzRQRKaPAT1K/qCp2zAFE5ZnhuObkoaFNC88jeCeTqMgDSRE2HDXR2pRJPzsxWpWe9AXStlKtwog9Fn2JNUk9aHXRKKEWEklf0TbA==
X-Gm-Message-State: AOJu0YxnaEGDrcS2j5Z2HwiMOI5GAsem0gsiZH+7ab1a6Ohr6b3KnBNV
	KYYH3ZJRJe/E37ndbeLH757peKclVX59EqagFsoe9OtYHz7Epo9rWTASDzAXow9qNeWXlxoqrMA
	pfsfAaA==
X-Google-Smtp-Source: AGHT+IFr46OKHqb1Gmau3FlOjnj7rKv/zTGU6S/NYdxkSQ+SlZLP0lYKMlzndTrTXDAiGfJd5nYQz59RGoWn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6953:f69e:7357:3598])
 (user=irogers job=sendgmr) by 2002:a05:690c:fd0:b0:61a:b2d4:a3fb with SMTP id
 00721157ae682-627e48a51d6mr988177b3.8.1716330970640; Tue, 21 May 2024
 15:36:10 -0700 (PDT)
Date: Tue, 21 May 2024 15:35:55 -0700
Message-Id: <20240521223555.858859-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v1] perf docs: Fix typos
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Assorted typo fixes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-kwork.txt  | 4 ++--
 tools/perf/Documentation/perf-mem.txt    | 2 +-
 tools/perf/Documentation/perf-record.txt | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
index 109ace1d5e90..21e607669d78 100644
--- a/tools/perf/Documentation/perf-kwork.txt
+++ b/tools/perf/Documentation/perf-kwork.txt
@@ -1,4 +1,4 @@
-perf-kowrk(1)
+perf-kwork(1)
 =============
 
 NAME
@@ -35,7 +35,7 @@ There are several variants of 'perf kwork':
         perf kwork top
         perf kwork top -b
 
-   By default it shows the individual work events such as irq, workqeueu,
+   By default it shows the individual work events such as irq, workqueue,
    including the run time and delay (time between raise and actually entry):
 
       Runtime start      Runtime end        Cpu     Kwork name                 Runtime     Delaytime
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 19862572e3f2..47456b212e99 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -21,7 +21,7 @@ and stores are sampled. Use the -t option to limit to loads or stores.
 
 Note that on Intel systems the memory latency reported is the use-latency,
 not the pure load (or store latency). Use latency includes any pipeline
-queueing delays in addition to the memory subsystem latency.
+queuing delays in addition to the memory subsystem latency.
 
 On Arm64 this uses SPE to sample load and store operations, therefore hardware
 and kernel support is required. See linkperf:perf-arm-spe[1] for a setup guide.
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb6..77578c0a142a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -311,7 +311,7 @@ OPTIONS
 	User can change the size by passing the size after comma like
 	"--call-graph dwarf,4096".
 
-	When "fp" recording is used, perf tries to save stack enties
+	When "fp" recording is used, perf tries to save stack entries
 	up to the number specified in sysctl.kernel.perf_event_max_stack
 	by default.  User can change the number by passing it after comma
 	like "--call-graph fp,32".
-- 
2.45.1.288.g0e0cd299f1-goog

