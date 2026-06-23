Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61E384250
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178098; cv=none; b=TnA11NJPol9iPPL3EpIkueuIOQw58LPTH+SUoHJuR+nzAJwZyt7xSgR8ZBk7ZLEghcm0kU4vtIY7AvMY9Uw2O0d5eoQLeikDEmBGaGFVkidGUYflI7eG8nJurUEvTkWq9KrjxKzLTOd101pErYVS1ImYDq0IH94V/6jBOeNYbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178098; c=relaxed/simple;
	bh=gswo1+IG/EW9P3VgcgDb/t4iKP3iZpZsO6RSGnER59g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJJtA5h8NKISHeq18Q9IshYPJo8bmUjNcooVWvOARG0LFkwWpP9exP6eTDTj0K6kTOkG3TplDdt+XDn39ZzxG/pwjqXKC/Usw1t6VX8TJfPAdo7JJuYAE04L98J/ey7dKHFYrUb8l3tiF78xgkDhAr4WJRUe3XvMm/uiFnz98iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPB7sRwL; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPB7sRwL"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30c5978b108so604900eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178097; x=1782782897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0s3gIxE7xK8gtOKoXzturgjLnlGfsrNqZilFzAr5NvI=;
        b=HPB7sRwL13ozAAQgLqQ1UcbvoBvOrqPIwxP5wz2pmOKRSP+1mMLi40QyigWXNtIBg4
         j3eWP00zC/B/TGk+YA6xnW3uDrZIM0g/46YErsoMa8nIQgmlAB+ZeTe2db56MX7vP5+M
         YfiMtqT4Nvww+23OgDpvmXiU6n0raYaGojYFdHeBoSW6bg6EnK5eeVGYrKxbER15OU7c
         Ieb7LNt5+z+r7m1s360YzABwOK1hZR6kc6pFbcU8raaBcGCp1HCv27EuykMq7P/0hjY5
         OIkbsx/Ct8zSZ4wjJqNUjN8za+U4BR71XqQwhEW5fGK2Rx89gbYswCW+UO6ekDvKXZ3U
         o3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178097; x=1782782897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0s3gIxE7xK8gtOKoXzturgjLnlGfsrNqZilFzAr5NvI=;
        b=sRrj+qnaLU2zQkGZ4suBQZr4E3J5HMRbv+/4pun6hMXS7S3bu6l3HAiLwjbEcptUiE
         qmzLAt2MK+3d75lyjOgang2TG/d5SdOLE3JmPCdSQsLz7FZ5+ortlOLsrhkiZ9Isyo+P
         WSfxmoFnlrws53/G7F/T5yzvVZJkW/05qNGwL1Dqunmvt9aeABqFQcTC/4+kyDAu4GjE
         w3h9MyHb2IUIWoatF5i84j+FTrLFHs8UNF9ocbIL26mjWDgN21uxcW2imLY1KDSP7827
         heQNFD2JmO1pTIt7l0tgMw7btU5YQ6vXXorLWwvY9HtOyuWgq5OGZwpw8fEaygRcXe91
         EzuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rOlpTbdsXmVZlrP50aAYaAk8rOKuMXkYb3XkqmcPTAOSsptDI12dPn1lVpmWJWjMeVEIsQzQaH8pKkV4GJM8R@vger.kernel.org
X-Gm-Message-State: AOJu0YyfS2TrwKpER+t7n0NzmEVMXFT1ddunX26pYtwOFphYsp50EL/g
	ksvNFk+yoHx7j8wCx3z2UhuRclDp2fUMKt+rThJNP2KNzROyoRSDZyQvETwd5iGVbxWdqBOlLVK
	1n1NMLCFZDQ==
X-Received: from dleh19.prod.google.com ([2002:a05:701b:4353:b0:138:62a:280c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:491:b0:138:14dd:16c6
 with SMTP id a92af1059eb24-139c706ea67mr254544c88.34.1782178096694; Mon, 22
 Jun 2026 18:28:16 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:52 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-8-irogers@google.com>
Subject: [PATCH v4 07/13] perf tests: Fix flakiness in trace record and replay test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The `perf trace record and replay` test fails intermittently on slow or
virtualized hosts because the default recording workload (`sleep 1`)
occasionally completes without scheduling the target `nanosleep` or
`clock_nanosleep` system calls inside the recorded sample window,
resulting in the error: `Failed: cannot find *nanosleep syscall`.

Generalize the `perf_record_with_retry` helper in
`tests/shell/lib/perf_record.sh` to support a custom record command prefix
via the `PERF_RECORD_CMD` environment variable (defaulting to "perf
record").

Update `trace_record_replay.sh` to use this robust retry loop running with
`PERF_RECORD_CMD="perf trace record"` and a base workload of `sleep`. The
test will automatically retry with scaled sleep durations (from 0.01s up
to 2.0s) until the required `nanosleep` event is successfully captured.

Fixes: 15bcfb96d0dd ("perf test: Add trace record and replay test")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_record.sh     |  7 +++-
 tools/perf/tests/shell/trace_record_replay.sh | 38 +++++++++++++++++--
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests/shell/lib/perf_record.sh
index e137fa75370d..2b9e11b66dc7 100644
--- a/tools/perf/tests/shell/lib/perf_record.sh
+++ b/tools/perf/tests/shell/lib/perf_record.sh
@@ -24,9 +24,14 @@ perf_record_with_retry() {
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
index 88d30a03dcec..38fcafcdfb91 100755
--- a/tools/perf/tests/shell/trace_record_replay.sh
+++ b/tools/perf/tests/shell/trace_record_replay.sh
@@ -6,16 +6,46 @@
 
 # shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
+# shellcheck source=lib/perf_record.sh
+. "$(dirname $0)"/lib/perf_record.sh
 
 skip_if_no_perf_trace || exit 2
 [ "$(id -u)" = 0 ] || exit 2
 
 file=$(mktemp /tmp/temporary_file.XXXXX)
+err=0
 
-perf trace record -o ${file} sleep 1 || exit 1
-if ! perf trace -i ${file} 2>&1 | grep nanosleep; then
-	echo "Failed: cannot find *nanosleep syscall"
+cleanup() {
+	rm -f ${file}
+	perf_record_cleanup
+	trap - EXIT INT TERM
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT INT TERM
+
+check_nanosleep() {
+  perf trace -i "${file}" 2>&1 | grep -q nanosleep
+}
+
+PERF_RECORD_CMD="perf trace record" perf_record_with_retry "${file}" "check_nanosleep" "sleep"
+err=$?
+
+if [ $err -ne 0 ]; then
+	if [ $err -eq 2 ]; then
+		logfile="${PERF_RECORD_LOGS[${#PERF_RECORD_LOGS[@]}-1]}"
+		echo "perf trace record failed. Log output:"
+		cat "$logfile"
+	else
+		echo "Failed: cannot find *nanosleep syscall"
+	fi
+	cleanup
 	exit 1
 fi
 
-rm -f ${file}
+cleanup
+exit 0
-- 
2.55.0.rc0.786.g65d90a0328-goog

