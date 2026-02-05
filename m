Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E7308F23
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324989; cv=none; b=S3wQVxiuBVhm0jZ/g9ENFP3pwxnRVsLekTo60nPs4gRf54qyIy8nzP+bYyw9NhhrFctNIJpvbjmv3LzdeSrH6kF+9T+qDNjh2JFow9ziyNCMP0nVllinL8APyP700is8PBa8+Y9McT+GwPpBP8OkZH8ZSsjM7tUvbQKVOvQQUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324989; c=relaxed/simple;
	bh=YuQTf4AgHIC04iSqhEUgNsCQRhztsJ6xLrtW3gZAcUY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=IL3R4ws3hIrd8LUpf+/rkDGr8FV0RCL3Gp/8rCRHa+ZfxkVmp/ORwXF6HBMzjlVEAYOoP0LoPbOssmAZIsuzZMQZpmcaAeCFkTDWxVgvQhB8LiZfz4aU7RiMG0Vvnjzbk+adk//8IUSyvzmkdPlrqiLzKtkupwHBmkvapW8RlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWdz5XHe; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWdz5XHe"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124ac76ea5bso10877061c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 12:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770324988; x=1770929788; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DsYQd+rOOncCXoOGe8CV+9nv08iz6kGOmfyIgeYCkos=;
        b=MWdz5XHe5XiH/39svkiNRk3NbAnBaexZJ8QWbWtnAK7QNVtjPdvrkT3g9kBt+mUIf1
         pXCYB36VqBeR6DEfiUXOts8QiMexUp63ZDr6IXHGzPjiEtNICDgf3IrdO6d9JfUCCFce
         rmKLtjMUzGlK4VeQTerwiaUhBZebsdhuVfK/anAShA4XsFUNxDP8GoUg3rAr/7xqr7V+
         EVwwRSb3DIoa3AOul8eTPpdq1HpmL6BjnUcRHBm7JUTTDRLXcoBuqfkBwY2HtZ3ReII6
         Zwf3NwjwR11xkr2JQ6n07yKCzvIPy28ZU4SrVBmqg/O5R2UkECZNQMRtCKLQ/ZUtENgL
         yDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770324988; x=1770929788;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DsYQd+rOOncCXoOGe8CV+9nv08iz6kGOmfyIgeYCkos=;
        b=GNBO3J1vfJjD93neOrXdfLXbJxbqWqw3dnv6nf69gdLr9lV1ezUu7B8cKcHtIyCugf
         7wB5qKHTeTPMdf21SePes0t0/xQjsTc8KmdVsCuA/rRL2+nL71uyWnKuz0zhouFR4CQV
         jXDNCUWtRbu/81g9wiKYdrkR2kDdVB7UhnUuHl7H+ygbF5F6HDlYuWcKPMVRPpahF4LW
         Ds7PynX7VHcSB0zUSe6qqdHzbp7JVnvefFewepWk6S3lFIEcTeVqnqg78MpT+1G3H+20
         modOLFVSRNy+Q1AVdmMWZC2yHFlI/DBY0oP05oszvXJEKDiBgSiVHTaZTp7kohBixKvD
         QQmg==
X-Forwarded-Encrypted: i=1; AJvYcCWBI9Y2aEu+s/w+rkreGFdCfRr4pZlLSIO0bR5bkCterstRSNQFT3yLKRsxf57n91ygc9SwQr99NguzUJNvoZNc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7KY7KzErzQMnpiucMK7i7zrrDGDmW+6AZd+oLgJXVG40HtS5
	n8Z93klAHz5vudlH8LlbFaaNn/GKwy1ztxwhKKZSQkfB2egWUSSIoe6XKmIvHLxHkVaVV62MfPI
	7uP/Hd9x6Gg==
X-Received: from dlbur7-n1.prod.google.com ([2002:a05:7022:ea47:10b0:11b:bcda:45a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:49a:b0:11e:3e9:3e8b
 with SMTP id a92af1059eb24-127041b2d7dmr191099c88.50.1770324988383; Thu, 05
 Feb 2026 12:56:28 -0800 (PST)
Date: Thu,  5 Feb 2026 12:56:21 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205205622.530825-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf callchain lbr: Make the leaf IP that of the sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The current IP of a leaf function when reported from a perf record
with "--call-graph lbr" is the "to" field of the LBR branch stack
record. The sample for the event being recorded may be further into
the function and there may be inlining information associated with
it. Rather than use the branch stack "to" field in this case switch to
the callchain appending the sample->ip and thereby allowing the inline
information to show.

Before this change:
```
$ perf record --call-graph lbr perf test -w inlineloop
...
$ perf script --fields +srcline
...
perf-inlineloop  467586  4649.344493:     950905 cpu_core/cycles/P:
           55dfda2829c0 parent+0x0 (perf)
 inlineloop.c:31
           55dfda282a96 inlineloop+0x86 (perf)
 inlineloop.c:47
           55dfda236420 run_workload+0x59 (perf)
 builtin-test.c:715
           55dfda236b03 cmd_test+0x413 (perf)
 builtin-test.c:825
...
```

After this change:
```
$ perf record --call-graph lbr perf test -w inlineloop
...
$ perf script --fields +srcline
...
perf-inlineloop  529703 11878.680815:     950905 cpu_core/cycles/P:
            555ce86be9e6 leaf+0x26
  inlineloop.c:20 (inlined)
            555ce86be9e6 middle+0x26
  inlineloop.c:27 (inlined)
            555ce86be9e6 parent+0x26 (perf)
  inlineloop.c:32
            555ce86bea96 inlineloop+0x86 (perf)
  inlineloop.c:47
            555ce8672420 run_workload+0x59 (perf)
  builtin-test.c:715
            555ce8672b03 cmd_test+0x413 (perf)
  builtin-test.c:825
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5b0f5a48ffd4..e76f8c86e62a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2423,8 +2423,14 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	}
 
 	if (callee) {
-		/* Add LBR ip from first entries.to */
-		ip = entries[0].to;
+		/*
+		 * Set the (first) leaf function's IP to sample->ip (the
+		 * location of the sample) but if not recorded use entries.to
+		 */
+		if (sample->ip)
+			ip = sample->ip;
+		else
+			ip = entries[0].to;
 		flags = &entries[0].flags;
 		*branch_from = entries[0].from;
 		err = add_callchain_ip(thread, cursor, parent,
@@ -2477,8 +2483,14 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	}
 
 	if (lbr_nr > 0) {
-		/* Add LBR ip from first entries.to */
-		ip = entries[0].to;
+		/*
+		 * Set the (first) leaf function's IP to sample->ip (the
+		 * location of the sample) but if not recorded use entries.to
+		 */
+		if (sample->ip)
+			ip = sample->ip;
+		else
+			ip = entries[0].to;
 		flags = &entries[0].flags;
 		*branch_from = entries[0].from;
 		err = add_callchain_ip(thread, cursor, parent,
-- 
2.53.0.rc2.204.g2597b5adb4-goog

