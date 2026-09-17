Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364743F4A0
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627390; cv=none; b=UGoXYPpYSwSO1IBt2THsde0QDhBLfZhmTjBKnbMQQ1MuFQgIm4ImQoCwHlU3kn+CCGTiLPiiPXgryj9GZRVjwpE96Jx5SXypEwNlMEjd2+fbZ/3np0vuF4J+UzIqlwh9/uv7SYUXlEtyR8UVZFZXjekKkz5bhRTZ5DazG5Vcjeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627390; c=relaxed/simple;
	bh=uXUyVsWXdGRR9r0Yf+u2xCJJUCEXrufHCD6FF1dYRUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oqdAFciwJxYq9PHphokGyccQ0Beuk/M6kyyYYVnYUpigmAdAqtIYYiaCXTzV6jJ9fALs9/rJNOQLj9IrOmL92GG119qXhnrvtoVH3/TFtjNjVj4/YIXyly1aNZa0vXfYOennZMtK6XfKK6lblsoDTsoPG0vE8e2McidP/djvN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xx19uWQW; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xx19uWQW"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so1599672a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627388; x=1790232188; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0q/ZlHbTsYZyN2/8M0P/yh3YerzxVzD8tkGrmWQ37IA=;
        b=Xx19uWQWCX35d3V+qK6dt2sJnFO8CA/WGKOi3J08gmoTp/+eMEF6xkLQSCSaAZYTlx
         BA8pnXxeiITtleV6mm0TXlSFQpGBEMUQ23yZ3S6tf08VfN9/0LF8DP4A6O9p/bFLwMrD
         fxlz+PHPHnPRQL7R0m0GOLrtLJ8EZ9k3fz4u+ircu3mbVaCvQQV485Cyh+dis/iCMHDw
         Z9ZS+Cx2deulaN0r0jEv/mWbsjN+bz5TCIuxgpooNChiJkJzvGxa5jaQO2N3APrj/fWp
         v9O8/yoD+6THKZvMEv/TvsGzAsLJfKLMFlIpjB6JEi6MzPkw28uVh2istkvqiDo/2f0C
         fbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627388; x=1790232188;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0q/ZlHbTsYZyN2/8M0P/yh3YerzxVzD8tkGrmWQ37IA=;
        b=H8c+4onquGtOSnnwPaBvtHgAaFj3syULdYj0d3V6ZY2QLcNp2PGTxQlJ+k7CRUTr1p
         aA4dlPVHNMXlOdD3xkiP3HZR2jR1weO89CcpJ6bZ4VSRO3oyh7dZZUJwv+WQm35OWqty
         Sbm1+Ca/MSkl2pzJbaiIFQuij+kWlq/DRRsWfwXyPgtWhBH9R/RQmmadXaSXEq4AFX18
         WsO4flWFJh6aFAiG+p266pYREpmov89NpnPn/uYck5bE2vp/THrQ5mPRSL111hUUBUqG
         dUn87k/7OZ2OoIKtpnm8qDpacMh4XfLRHo7TE/R2f5lTTzkP66wnc9BaPOMTmDGPiEcj
         30Rw==
X-Forwarded-Encrypted: i=1; AKwUvBxH3q4RW7ZU91RUvseLYPSS0uI3Z3efMRm1fqMddwF8nj+PMC+JBphcX0ucEKdg4Ah8ahWI2SjyW4elIKgyNvWF@vger.kernel.org
X-Gm-Message-State: AFuF++keKBSQ2qOlrZSiUMAvx39UERaa50D76SO+9sQCHEc2eeT0VgUy
	6/0ut7d89jI+gkAVPCJVZSMAr0Ff4s9m64SNvPizLs945l+gu0EE93dAJvqGeq4rjJgpPs7Svjk
	kpjI6fT5liQ==
X-Received: from dlbps9.prod.google.com ([2002:a05:7023:889:b0:143:8c65:6162])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a43:b0:39d:f5b1:e365
 with SMTP id 98e67ed59e1d1-39e1e559b78mr13296706a91.25.1789627388112; Wed, 16
 Sep 2026 23:43:08 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:33 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <2116386f185b31e0a0e197d37151d585ddb02019.1789626978.git.irogers@google.com>
Subject: [PATCH v1 11/13] perf test trace_btf_general: Drop --max-events=1 and
 make non-exclusive
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

trace_btf_general.sh used `--max-events=1` with `perf trace` on
commands such as `mv`, `echo`, and `sleep`. When background activity
occurs or tests run in parallel, `perf trace` can capture an event
from an unrelated process and exit prematurely before recording the
target command's syscalls.

Drop `--max-events=1` and let tracing run until the command completes,
checking for the expected output with grep (matching trace_btf_enum.sh).
Remove the (exclusive) tag so the test runs in parallel.

Running perf trace in parallel is only safe now that the probe tests no
longer name their probes "vfs_getname...": perf trace opens everything
matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
those probes and make their cleanup fail with -EBUSY.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index 7a94a5743924..4d654b687a4e 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf trace BTF general tests (exclusive)
+# perf trace BTF general tests
 # SPDX-License-Identifier: GPL-2.0
 
 err=0
@@ -27,7 +27,7 @@ check_vmlinux() {
 
 trace_test_string() {
   echo "Testing perf trace's string augmentation"
-  output="$(perf trace --sort-events -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
+  output="$(perf trace --sort-events -e renameat* -- mv ${file1} ${file2} 2>&1)"
   if ! echo "$output" | grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
   then
     printf "String augmentation test failed, output:\n$output\n"
@@ -38,7 +38,7 @@ trace_test_string() {
 trace_test_buffer() {
   echo "Testing perf trace's buffer augmentation"
   # echo will insert a newline (\10) at the end of the buffer
-  output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
+  output="$(perf trace --sort-events -e write -- echo "${buffer}" 2>&1)"
   if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
   then
     printf "Buffer augmentation test failed, output:\n$output\n"
@@ -48,7 +48,7 @@ trace_test_buffer() {
 
 trace_test_struct_btf() {
   echo "Testing perf trace's struct augmentation"
-  output="$(perf trace --sort-events -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
+  output="$(perf trace --sort-events -e clock_nanosleep --force-btf -- sleep 1 2>&1)"
   if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,.*\}, 0x[0-9a-f]+\) += +[0-9]+$"
   then
 	printf "BTF struct augmentation test failed, output:\n$output\n"
-- 
2.55.0.1082.g2b9226bbc0-goog

