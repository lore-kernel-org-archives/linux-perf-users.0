Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20EC218827
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580663; cv=none; b=cj409q8Plk0iHECgFX0O1ETOGbwOqUzfSC8bwb7jhVubVYCH8ltzAmnOdeN63HtOcQsQUww6h+JUQUMCoiQMaGVuLrg102UmlW9PJlnnL0k9fUZ5OqRySSt7+75roewqE0Ybfx9w0mq0tBAGa5bQMd6ei4qXmBq7tIuQ7p9aYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580663; c=relaxed/simple;
	bh=4ivNeOheBuNzExIPzRLVkR3bUyIOBfJwIFkhhVJf+IM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=edzU6ckwBGTf7Nj7n5FqsaxqsOoCoWSrnhO+go9hT+qhAUhv2D+q7+nZ4KdmkXhUalo0gV/WUZjDUfOjnQO4K//GPatQvW1yhs0Bf+g92d+fFpiWney8cmqCOnlwLK0j5vFSZmh6RNgWZjp9szAy8orE5aT9uRLwOg8ozPl13eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3Md5KeU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3Md5KeU"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc240cdb249so31227a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 11:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763580656; x=1764185456; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iiRb5FbuRLx/GNbTV/3vTEYYpI4yNEVejENPhqja2z0=;
        b=Y3Md5KeUSB0vI/YVG3evInBOyN5Fv/WNfgqiPkOCKKWi7AZ0kNa8bGWEv84UmiN5KE
         VKNGSMq/YtiVDs/tJGZi6op+ndZPpbGYZUJVKUrAlk1XD0lR+9fii8OAIONgOM7fY9rJ
         Luxvt/mHSoFs0aVvhVF57FE+KdEd7z/sVckr9aeV5pO+8R1tR9+rp/kNZebt3Nefx1jG
         RHnyGQFYvwBgQbCDrJLbTep26KRD4YyFgPDdwg/mHZZfMtY8KpYaU8l4In0XJdKbPCXG
         9GJteIzZzddaqvh/hpDCkqDP+qMYR58w9ggWBciQk/puynMHqMvHbDaSZrmv/iTg9EhM
         c4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580656; x=1764185456;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiRb5FbuRLx/GNbTV/3vTEYYpI4yNEVejENPhqja2z0=;
        b=Q4cINunaKGo+5VcD32Y531Xg9hMMeJXxPjJD0cx0EcYzuQwYG2Uqsfz/aUrSswMUts
         326w0tis79YZrGaj775hJnc5XZVI+eeBuuaC6GkpLzswA+7Stj21GlRIxBREFRg4VN6p
         gzVplW9lBDqFBqXCUhATYz9vI3e95IbDqOI8LIria+RUX96VeY9hRzGcD4MjNw4hh+Iq
         SZElg803G7T6Op61XFI2ud7UvZT1rjZ+vmaK7pjKRyLzRU9LZtMARqInB5RpvkJoLQUn
         gOaYdyX29Yc0sabNcCKdl2/624OujsSp5nDkcd6px2S/FSN3VYjAvTBMnz3Yv/8qJfd+
         ulyw==
X-Forwarded-Encrypted: i=1; AJvYcCX+OetvUdLQYprVgHn+ONm8e0L6J9WHZwgk2c6p/b/fTYVvbrBQGWhKBEhsnYQh2Us11CddzElOVkYwmUTkQA92@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUuIGRWtKfXcWdxVU7agQGhaH23al/awnPBvt2BNxGWCWr6Oa
	BzqnuJ7kmGy1SZdr8U09+FRx6S9cNZbdhyCPmbGqC94nH6oQMOM8w77OvpRk1weKEZku/IFHfXV
	dVh29hySHJg==
X-Google-Smtp-Source: AGHT+IHeSK6zSgFkdrwwfb4bIygeqaAylW7iZUr79GzdD1hIiFk5/+fc7unLeX+GDrj9bgL0BvZD4+FzRTL5
X-Received: from dybnb24.prod.google.com ([2002:a05:7300:cc98:b0:2a4:5fa4:9813])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:818c:b0:2a4:5c3b:e2b0
 with SMTP id 5a478bee46e88-2a6fd1083e6mr134014eec.25.1763580655890; Wed, 19
 Nov 2025 11:30:55 -0800 (PST)
Date: Wed, 19 Nov 2025 11:30:47 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119193047.2238095-1-irogers@google.com>
Subject: [PATCH v1] perf test all metrics: Fully ignore Default metric failures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Determine if a metric is default from `perf list --raw-dump $m` eg:
```
$ perf list --raw-dump l1_prefetch_miss_rate
Default4 l1_prefetch_miss_rate
```
If a metric has "not supported" or "no supported events" then ignore
these failures for default metrics. Tidy up the skip/fail messages in
the output to make them easier to spot/read.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Closes: https://lore.kernel.org/linux-perf-users/20251119104751.51960-1-tmricht@linux.ibm.com/
Reported-by: Namhyung Kim <namhyung@kernel.org>
Reported-by: James Clark <james.clark@linaro.org>
Closes: https://lore.kernel.org/lkml/aRi9xnwdLh3Dir9f@google.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 27 ++++++++++++++--------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index a7edf01b3943..3dabb39c7cc8 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -27,19 +27,20 @@ for m in $(perf list --raw-dump metrics); do
   fi
   if [[ "$result" =~ "Cannot resolve IDs for" || "$result" =~ "No supported events found" ]]
   then
-    if [[ "$m" == @(l1_prefetch_miss_rate|stalled_cycles_per_instruction) ]]
+    if [[ $(perf list --raw-dump $m) == "Default"* ]]
     then
-      # Default metrics that may use unsupported events.
+      echo "[Ignored $m] failed but as a Default metric this can be expected"
+      echo $result
       continue
     fi
-    echo "Metric contains missing events"
+    echo "[Failed $m] Metric contains missing events"
     echo $result
     err=1 # Fail
     continue
   elif [[ "$result" =~ \
         "Access to performance monitoring and observability operations is limited" ]]
   then
-    echo "Permission failure"
+    echo "[Skipped $m] Permission failure"
     echo $result
     if [[ $err -eq 0 ]]
     then
@@ -48,7 +49,7 @@ for m in $(perf list --raw-dump metrics); do
     continue
   elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
   then
-    echo "Permissions - need system wide mode"
+    echo "[Skipped $m] Permissions - need system wide mode"
     echo $result
     if [[ $err -eq 0 ]]
     then
@@ -57,7 +58,13 @@ for m in $(perf list --raw-dump metrics); do
     continue
   elif [[ "$result" =~ "<not supported>" ]]
   then
-    echo "Not supported events"
+    if [[ $(perf list --raw-dump $m) == "Default"* ]]
+    then
+      echo "[Ignored $m] failed but as a Default metric this can be expected"
+      echo $result
+      continue
+    fi
+    echo "[Skipped $m] Not supported events"
     echo $result
     if [[ $err -eq 0 ]]
     then
@@ -66,7 +73,7 @@ for m in $(perf list --raw-dump metrics); do
     continue
   elif [[ "$result" =~ "<not counted>" ]]
   then
-    echo "Not counted events"
+    echo "[Skipped $m] Not counted events"
     echo $result
     if [[ $err -eq 0 ]]
     then
@@ -75,7 +82,7 @@ for m in $(perf list --raw-dump metrics); do
     continue
   elif [[ "$result" =~ "FP_ARITH" || "$result" =~ "AMX" ]]
   then
-    echo "FP issues"
+    echo "[Skipped $m] FP issues"
     echo $result
     if [[ $err -eq 0 ]]
     then
@@ -84,7 +91,7 @@ for m in $(perf list --raw-dump metrics); do
     continue
   elif [[ "$result" =~ "PMM" ]]
   then
-    echo "Optane memory issues"
+    echo "[Skipped $m] Optane memory issues"
     echo $result
     if [[ $err -eq 0 ]]
     then
@@ -101,7 +108,7 @@ for m in $(perf list --raw-dump metrics); do
     # No error result and metric shown.
     continue
   fi
-  echo "Metric '$m' has non-zero error '$result_err' or not printed in:"
+  echo "[Failed $m] has non-zero error '$result_err' or not printed in:"
   echo "$result"
   err=1
 done
-- 
2.52.0.rc1.455.g30608eb744-goog

