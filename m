Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712834E759
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328787; cv=none; b=HsT4GDqVLobMXSPWjAzYuafguS6Iogkv7fFPqVVT6DNJeSn6d2AjPC+mEY0BogdxgSl+3JEyhW2PTte94UJqtkGQgZqFY2LT+aV/WAIoV1NJ1pBwsgR29WtWREPexP0ipqCONBlPXe+0KBedntBvgpB6naLVYxu7kYJROkbXwNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328787; c=relaxed/simple;
	bh=a5JGvMLFyprG6QfL5XnHpkM6fv0A27tSZN8uL+4ANfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hJ1BhkQEykzIr5/LU+tBGuT1LxtHr4CAYF/gpITW5U5KqRb3q30qDUIT2CNxx/5vfvXhfvYXTUONINrDfv4+JWLa9HNf+jhUGc6yAXRGaWvouvxAgmRDD5p1ms5zhMbdwf6eNDD74X8Z4qhR3TmB6FuYJfWy5UnXnJPkNxSyPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgVwxfOU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgVwxfOU"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bba464b08so2257970a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328784; x=1761933584; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yI70voK5e+ZzNgu0TYVzbazqhONpuqvIFoYlpIFjbk=;
        b=dgVwxfOU1JIuSrHesNEoYUsn8NO3yM5d5+JQVB36Cu7704m/DIhVMioSnScuiYyZxZ
         IFQO4s8Y5xaNufwJpK0E152xmIx3Auv8pUE9Nx+M6V6BGOwNj4LdkVlVxkO+38tRc48P
         nccHvgopjr4wFY/5VWLqoHNylgm5YbaJUZ0LKkep8DJGwR1Mh5IPcyyIUWa3zVHfIBmG
         h2BxdzyRanKYMhno+YCBDtaRQQEMy/+WYINYD/mpaGA6nhRMl0IAD7nlkG47VDxbslGC
         6yVpdnH6qTHnNS74m+ur/yurQUqgdlYtb6y9CvqvkxT5SlYltDatRDXJ0D2wvCrZ3IWL
         RO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328784; x=1761933584;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yI70voK5e+ZzNgu0TYVzbazqhONpuqvIFoYlpIFjbk=;
        b=VBpNDq6UOSFQWBvaTxIAW1QYiEmGiGyngoAN41G6cgPv7gx3x+1+QemRx9Ryeis68R
         UAciha8mCfTGKgJsfICgrpcPGeUU4cisQV8y4Mpm2vlnf/+IYdS+hgLx2PyZTmBaTqmF
         QzQDlzgwPPrnqFFPJLfszEdtod6eC3CrjcelE+TsUFZPqTJMqQ1wfsyCRF7OGii5atgb
         +nGr/W8NsXmn0glZ7vF51QVAmGkGcTrYJC0xX3V6UXrxGnlWNcXQVTRBBK/MAoNsxX7O
         LB50zku6y9KMo3gHpskVuXb2GC2IPw4Ly5VxFQ+FqyPhUF7TFVtiCbTBWjSt8e+Kl021
         fiOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Xj6ijwl2SsOWjYpVQoRbwsHZcQ5kCy+k8nH/h2uBcIRn2Jo8N6uiMNd3KANRKhnn9yA4rbWjb6n/QewMr0RH@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbxGesRAPC9eAa9FjEGrs00GjqWVQ1ZLk9nvK58tu4evP1gdd
	sM3dlkh2FTk87rGbyBgqoS8s+ciAPzGnVQ/rfMfA2sFHmgDPCtT/9+miNqxUEKNq6EGTH6rkxB3
	OBeXKo8uvQw==
X-Google-Smtp-Source: AGHT+IG02mHYSHgon5GJSvJvSSO7TIhhkQ06xdgDu0aLXCVNpp4zfSMQGEXZc46bfivjxQnjSY9hFD96bbum
X-Received: from pjblm10.prod.google.com ([2002:a17:90b:334a:b0:33d:ee1f:6fb7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:327:c0c6:8829
 with SMTP id 98e67ed59e1d1-33bcf8e4f50mr37235277a91.24.1761328784087; Fri, 24
 Oct 2025 10:59:44 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:55 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-21-irogers@google.com>
Subject: [PATCH v1 20/22] perf test stat: Update shadow test to use metrics
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
	linux-perf-users@vger.kernel.org
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
2.51.1.821.gb6fe4d2222-goog

