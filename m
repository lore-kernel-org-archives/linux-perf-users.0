Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6353DA7D6
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590465; cv=none; b=sGqdJpU8RzcwtxJHGG2tL9IR/M7SHqsWO2LN2SDogGf8BPYvaDBsLG55eWZCEpicZkrD14S2MQpm9z4h+2/tyExxTZHo0uI5NCw4uzGN+4mdaMDBDAHIVcZHcJq1i0NMNnan6VQDkQgkWurc34LmkppnuQzDb41oUYBUsHLVfcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590465; c=relaxed/simple;
	bh=zIghP44hQaxLLXe4lO55MRSBkbYFlHz/ZbxoqAc47dg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=asxotmscfeeMYLMMnsGJNziye6ip4yuzDK/xwZ9wW3VSpHBtmuieodAha8GNC58Gat3whfHA7KX8/AuIZ6v8JDOt4JrbJNNqYPpdgeNYjCdEOxsTJmMTXbUwCkc18HQExSUApNZv9e7Clryt0QcMWDYl+8ZqMR7ibRdUghayCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikDxbyFV; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikDxbyFV"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30761ab3483so246397eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590463; x=1782195263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dqhQ3bVhIZxJz7m8iksWxycfJbaP6PkrU05mstbHLI=;
        b=ikDxbyFV7hmpe2hHD6i45U0RQbLhRsJCmkvAUuToDAls6wD0BoGT4H4gPi98OoLgTv
         /E04AlMIB2G4Bchd/QATh2ZFZ2bn4kVekzFymlwCAR6JdbcDxrb2OXnZSUl6YgRvvKdJ
         GXWcOdWkutQ8CJP3YK31zAnLWLIBsZMa6BDSZ4i9nWq3fXGBdcI/uD44m5XHrmdrWqya
         FGtoUhAHj3Iz+z2/NohLDYArCy7rukqpd/6Z2jTl9WwrtHhOTRY1sU0qcukovJPhaYwb
         zztaABlpt7LDD/o/KtCcOOJmbCzCPY79B1et1NV+6P1bsxeHz/QNaJOws3usefYWUe9h
         RY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590463; x=1782195263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dqhQ3bVhIZxJz7m8iksWxycfJbaP6PkrU05mstbHLI=;
        b=OYLdRgA6uno0pTfO+5887Gh4kzGqDrtJKpMgDmQJIl1x/lO4mmtybwogiElU8+9CYP
         ZSiY9nH7+Jktk9mRDfO6YSsnEdLoQC8cN5Dny35U8vQPT/uienC9y0tP2ZDCIFnc2H7l
         F+bNurIss2xVnkgTQEIQxDzBqL4YZqXkGfO6VxpSdbjWS3+4vf1MieTkIO+wS3MN/tLe
         H/IvO3sYHa2gpoOQSCEindMiio2U8/LA5NNPIKRrDYYgPbmvBRJBnSObxN4cS2v99Asq
         yxltCNFloyigcjdJNn1ClYFKwFabbHpZZ8NwNMhFT8bdp1EltCCQOopkkrUoKskNYxBl
         A33w==
X-Forwarded-Encrypted: i=1; AFNElJ9x6OlFPvb4Tm95Z0jPzWLzFPCYXDaJG4dgnT1dqPSxGGKYdYj/0F7DlaeA3rT60f0iP2uWEn0b+lFxy4SfPQkn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvaz0NV+G646187aoSFasv7K4iZvEmgrsE8U+fpKy2ZjcKZxXO
	AvFVIsIMHU8S6PoqMh1Innst2NpeABbuMGJMVFpbK+kDIdRVNClYSpsndS9xwZrAb97fV33Iiup
	eJZi6N9rg3A==
X-Received: from dyay13.prod.google.com ([2002:a05:693c:62cd:b0:307:ff57:53b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:641b:b0:304:acc:f086
 with SMTP id 5a478bee46e88-30ba6051574mr1324032eec.33.1781590462363; Mon, 15
 Jun 2026 23:14:22 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:13:59 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-8-irogers@google.com>
Subject: [PATCH v2 07/12] perf tests: Fix flakiness in trace record and replay test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The `perf trace record and replay` test fails intermittently on slow or
virtualized hosts because the default recording workload (`sleep 1`) occasionally
completes without scheduling the target `nanosleep` or `clock_nanosleep` system
calls inside the recorded sample window, resulting in the error:
`Failed: cannot find *nanosleep syscall`.

Generalize the `perf_record_with_retry` helper in `tests/shell/lib/perf_record.sh`
to support a custom record command prefix via the `PERF_RECORD_CMD` environment
variable (defaulting to "perf record").

Update `trace_record_replay.sh` to use this robust retry loop running with
`PERF_RECORD_CMD="perf trace record"` and a base workload of `sleep`. The test
will automatically retry with scaled sleep durations (from 0.01s up to 2.0s)
until the required `nanosleep` event is successfully captured.

Fixes: 15bcfb96d0dd ("perf test: Add trace record and replay test")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_record.sh     |  7 ++++++-
 tools/perf/tests/shell/trace_record_replay.sh | 18 ++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests/shell/lib/perf_record.sh
index fe5721427e58..2c705840d554 100644
--- a/tools/perf/tests/shell/lib/perf_record.sh
+++ b/tools/perf/tests/shell/lib/perf_record.sh
@@ -21,9 +21,14 @@ perf_record_with_retry() {
   local duration
   local first_run=true
   local ret=1
+  local cmd_prefix="perf record"
+  if [ -n "${PERF_RECORD_CMD}" ]; then
+    cmd_prefix="${PERF_RECORD_CMD}"
+  fi
+
   for duration in 0.01 0.1 0.3 1.0 2.0; do
     rm -f "${perfdata}".old
-    perf record "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$logfile" 2>&1
+    ${cmd_prefix} "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$logfile" 2>&1
     local record_exit=$?
 
     if [ "$first_run" = true ] && [ $record_exit -ne 0 ]; then
diff --git a/tools/perf/tests/shell/trace_record_replay.sh b/tools/perf/tests/shell/trace_record_replay.sh
index 88d30a03dcec..f27e32b18697 100755
--- a/tools/perf/tests/shell/trace_record_replay.sh
+++ b/tools/perf/tests/shell/trace_record_replay.sh
@@ -6,16 +6,26 @@
 
 # shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
+# shellcheck source=lib/perf_record.sh
+. "$(dirname $0)"/lib/perf_record.sh
 
 skip_if_no_perf_trace || exit 2
 [ "$(id -u)" = 0 ] || exit 2
 
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
-perf trace record -o ${file} sleep 1 || exit 1
-if ! perf trace -i ${file} 2>&1 | grep nanosleep; then
+check_nanosleep() {
+  perf trace -i "${file}" 2>&1 | grep -q nanosleep
+}
+
+PERF_RECORD_CMD="perf trace record" perf_record_with_retry "${file}" "check_nanosleep" "sleep"
+err=$?
+
+perf_record_cleanup
+rm -f ${file}
+
+if [ $err -ne 0 ]; then
 	echo "Failed: cannot find *nanosleep syscall"
 	exit 1
 fi
-
-rm -f ${file}
+exit 0
-- 
2.54.0.1136.gdb2ca164c4-goog

