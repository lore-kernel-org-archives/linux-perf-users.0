Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F6364026
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896168; cv=none; b=JuE+XMgkLvJfGwUhJvCboFnID6mQxZvXBThfhOhcxUlLgEOl5kozHCa3b5hwAojHrJqSppCOiLeRp0KIEbSm2U/+R3zJlQbGEkdqxnaSIHDty6hSJACaxwWrKrkNS6s39Cb+XPnLfoufyjHfat4YSmotLdVFzUHCDP14Ml8gPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896168; c=relaxed/simple;
	bh=NQZLwrJVuAq7AnAGYojD2+FNeBDfMGlmTWdY5sb/Yxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=X/tSz0ZUkVJvjlpdlwAyL4VFdZDlkVTWigAeZFcLj2igKC9O8M8Oxx+w7XkFfTa1rBStdKxBCXfqWMydGE1WC4KPGEnMDsR3w/evuOtBqWX3oyH9APco4TGh4LpUuMweLCHgec9JFc2w7W22fq8LOCsjGyx8Qwi34mF44L3BOew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eraNyMGr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eraNyMGr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297e1cf9aedso4006575ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896166; x=1763500966; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=eraNyMGrt0jENw4btjGXSMbizAoW25gXWknQzJG6jPMYYQlPobUxdtABZAKAEXe5QJ
         yc/11KgfPYvyccdAZl0jFcoTE0vrXM7QAE9Ln0pDRDHeYVjwYYxe7AXor9kZgPCWnG3N
         DktYLfVuBpnvEYDlmaLErrxJlvAA2nl6gHUS791C7G6vZHfKtjDsxg0pGov/lCfp/K9U
         ohjSQDcO9DdG2yoY4MuvPu3ruqL2Dls6giWHFtHzsNRxikyQaEAwkrnBvMJ+/3luG8kJ
         8h365ydZZHoLrLyRyy4dIp/7p8501ZR3ohfJ7kFpIiwPeq/dqNLq2rYmJ9FheJn+pDti
         QBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896166; x=1763500966;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=e8QnwKW2CR8bPDjLhHGmsju5fColdOU4LFvPsiES2tpJmchf/39GO2/o1o46HYf0Ug
         2rBpxghi95wrjwPiqYFZzLeokvUukPSd8fgcTvaiOACeURSYCwyVMESpUpvwIoVX0J2W
         61Ca4AUP3uz8kdEL0SmeKX9RsWMTeSC2e3kEhVdUCj+6fmCN2MglwaUhKECuohz3W0BD
         CiOesyw/TslPo3iw3ZpA14rpE/lgz/ZwTca1LOA8V8USEuBPAbemwKZfUAobHJaATvDi
         4tkpNq9ImVtdIzVdy/kgo30DUIGTrZbWVmPGNZlRSur9KqvCCqPnxAdZ4fvVyqPhMwVo
         nfzA==
X-Forwarded-Encrypted: i=1; AJvYcCWiGYlchqn7KMMOvXcRWpvM9Ves4YpByOrWGqi6d78jJLwK8AFaUQZLHexDP/iOKDOhW59gw7LOjQgWf02RzK1K@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8aD+qB5yaZwyUe0npAClsBvCwFiFNcCjaSXo4G0a7XmKBvV0M
	vsDebTvD4uwSYinExrpgJXWx7//VNF8nnZlfKXfeE2sy9tR08Vr3fFK32/uhS8Wkk1r3CA5P0xs
	vbt6ikxg6Dw==
X-Google-Smtp-Source: AGHT+IHoLFxLBvDxnhRtcK5+Rq2f7KF34QNfZroRMzntkHhW+Yb+NDYSMCqhvav079UNNlqZGhM40LZpUquv
X-Received: from dlbvp3.prod.google.com ([2002:a05:7022:ff43:b0:11a:126f:ee80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d544:b0:297:fbff:fab8
 with SMTP id d9443c01a7336-2984ed35b15mr10303485ad.21.1762896166290; Tue, 11
 Nov 2025 13:22:46 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:03 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-16-irogers@google.com>
Subject: [PATCH v4 15/18] perf test stat: Update shadow test to use metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Previously '-e cycles,instructions' would implicitly create an IPC
metric. This now has to be explicit with '-M insn_per_cycle'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+shadow_stat.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index 8824f445d343..cabbbf17c662 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -14,7 +14,7 @@ perf stat -a -e cycles sleep 1 2>&1 | grep -e cpu_core && exit 2
 
 test_global_aggr()
 {
-	perf stat -a --no-big-num -e cycles,instructions sleep 1  2>&1 | \
+	perf stat -a --no-big-num -M insn_per_cycle sleep 1  2>&1 | \
 	grep -e cycles -e instructions | \
 	while read num evt _ ipc rest
 	do
@@ -53,7 +53,7 @@ test_global_aggr()
 
 test_no_aggr()
 {
-	perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
+	perf stat -a -A --no-big-num -M insn_per_cycle sleep 1  2>&1 | \
 	grep ^CPU | \
 	while read cpu num evt _ ipc rest
 	do
-- 
2.51.2.1041.gc1ab5b90ca-goog

