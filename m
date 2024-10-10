Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803C443D;
	Thu, 10 Oct 2024 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728537381; cv=none; b=Qq/VidVyYUXae/zS5FF3/TJDGzmXmTfAgL9Zk3Q0brwSBX7KiSyOsIjLbrNJXqTWlWUQUykiLjnxnk6tp8+uguLWjvCVI4A8VIdvE8qmdDkHuC6LQgvO/gxMY6u63KLS2T0dNcyV8FXcBUe1gMqjQLy4Gv6lGHlQZmHDTpYER38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728537381; c=relaxed/simple;
	bh=LFAjTpAnqSocR1XUoKJ2dWiM2U5S2Ivu2fRF8V0aoJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYbfGSufzky8pO0u4slQnvHbpxZPyDjF9c9CQL5ng/vCSBlDKXHQ/dq9vnRGqvIDBkcpSS4PrfsA9wcVU/dbw06fVikr/zyyhurWleXF2E2dO6wjnYtxOEFN9uit8bmbEGzeCtd3Jchg3bfyjHo+SrJACvfcDa36z9+g/HyHWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNKXTbcN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNKXTbcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9761C4CEC6;
	Thu, 10 Oct 2024 05:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728537381;
	bh=LFAjTpAnqSocR1XUoKJ2dWiM2U5S2Ivu2fRF8V0aoJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KNKXTbcNQl5VNXrD9vUKHnLvvD+BJgU9Ti3eewyTuTgh4SEqBy2MXJmpTOCKMzfP1
	 8unOT2oeL/YG2w8KAhzLZL9aWJpKMj3wxFmeyDJ+I3yfLou6KUe+7k0kcZcLGjJUW8
	 +hhqd2v9y7jVwaQ3JX5gWbxbO9n/U1MIF8/f1zIMOlnia0BsDXqx1I07/YUYPsGLXf
	 B9jPg+IJaw8GvTgbnjmo1PSMxOy7YtRwXb7Y9VwHrWCVZxa9lNh+kJ8jrmoo8eKLe9
	 vh5C8DiLr5O14oOfUspbgUZCilvAdSFsNsz7dVoSx9f6dg54/SF8w8yLRrHeE+hobg
	 SQY/ldeCWgwhA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: [PATCH] perf test: Fix probe testsuite with a new error message
Date: Wed,  9 Oct 2024 22:16:20 -0700
Message-ID: <20241010051620.1066407-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On my system, it's constantly failing because of new error message from
perf probe.  It should update the regex pattern to match the message -
"A function DIE doesn't have decl_line. Maybe broken DWARF?".

  $ sudo head -n 2 /sys/kernel/debug/kprobes/blacklist | cut -f2
  warn_thunk_thunk
  asm_exc_divide_error

  $ sudo perf probe warn_thunk_thunk
  A function DIE doesn't have decl_line. Maybe broken DWARF?
  A function DIE doesn't have decl_line. Maybe broken DWARF?
  Probe point 'warn_thunk_thunk' not found.
    Error: Failed to add events.

  $ sudo perf probe asm_exc_overflow
  Failed to find scope of probe point.
    Error: Failed to add events.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
index b5dc10b2a73810b3..01e5e09053c37e46 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
@@ -42,7 +42,8 @@ REGEX_ERROR_MESSAGE="Error: Failed to add events."
 REGEX_INVALID_ARGUMENT="Failed to write event: Invalid argument"
 REGEX_SYMBOL_FAIL="Failed to find symbol at $RE_ADDRESS"
 REGEX_OUT_SECTION="$BLACKFUNC is out of \.\w+, skip it"
-../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
+REGEX_BROKEN_DWARF="A function DIE doesn\'t have decl_line\. Maybe broken DWARF\?"
+../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" "$REGEX_BROKEN_DWARF" < $LOGS_DIR/adding_blacklisted.err
 CHECK_EXIT_CODE=$?
 
 print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
-- 
2.47.0.rc0.187.ge670bccf7e-goog

