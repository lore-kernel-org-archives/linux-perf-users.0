Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039088;
	b=RQXW/RKy/xiE8MtQn/2FsPGko/LG6WQW1YxSlrWEDBgeVE/KJRPMzLJFjfI18WdpY2Ra
	 PLEgsVKWbHqr4Omp3tfk6DLdZnTjn7l9hy1LpB+QjEe9OCic9kf+i7OYe6kYId7mqjWBv
	 c530JbsDLEZpVrx+25ySLE2/r7+KbEuz3wEVmhUJPRjj456dvmDhWQ3X24iwyPkgX26fc
	 bQr4OxCWcf5m7C4LetPV6KyQUkMPKiscxnBrnxJHoLIBwIV6w/NWnO/ftwt6Oefe/+DYI
	 bP8Vdrd8sR7OfbHYFrMvu2b68HLgWrurJx+6Q+5NmDRCCwjvie+UFTOYPC78A3Brv5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039088;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HqdU3TKWtk+QHYDMIs0OjFQmc/8QrMHOsCdFuTPEaI4=;
	b=07gUurbhH4qZCcTxICjYEqGkmVOh8W0wdK3BbJPMD5IX/oLWPiNepKksZG9UnyXldYzl
	 MLQSbkzIc+OLlrYnG0DodbA8BWEsefVX5tZdYQKEtt/ILiWBXerBLimnmyC4GMaGtmplc
	 WqozFHkZ3+K1d0rcq/3gLykcDREBOKncfRWyrw6d0/ItyVLeU0rF3ALBRuJmgOH+oHsW/
	 1YT/z5ttylihHzlt8iG/74JFjXYAS9Xr7FkHkcZnz5M4yhvPYWifNJ8npqazj0YyDGazd
	 8z/G4VFQR/A+e3XEaBna/FeW5AZjWYKwrBr8T5hLK75+wsdPpTWYQGENbPhdpMp0Y5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2VvBPID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8260A2602;
	Wed, 18 Nov 2026 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2VvBPID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDBC1F000CB;
	Wed, 18 Nov 2026 21:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039088;
	bh=HqdU3TKWtk+QHYDMIs0OjFQmc/8QrMHOsCdFuTPEaI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C2VvBPIDE5Rn9Qmczx+zT8rkh6xGMTN6oFbWfPpoaP+fDAXF1EaKjyWud+Rcc4gdi
	 ptU5TYYQCMLjzYae0Ar6TLUdnS/oc6UgQYT+DJQ1o+M2I0vUN+PPaKok0ji46oqoOq
	 IFDOcBxO7+lOGWe6830gaaFpOTgrzsKDicW8JqiDJcY7ci50obmsaw7J++N+SY372D
	 cxVXCPcLaNrREeLc/QMPuu47OeGZiPfIL0mJQ2h7wQ5z77iwlMHkzKBSgF2AX84r5Z
	 KA5UuvYejLEh/QcD0i1EwebHXkOb0qAy06AdE7bMis82A7wZ2QAqZQUAH1y9YVAWry
	 ub4nPAsS4XVvg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v7 13/13] perf test: Skip the LBR inline unwinding check when unsupported
Date: Wed, 18 Nov 2026 18:57:15 -0300
Message-ID: <20261118215716.114868-14-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The LBR check takes caps/branches as sufficient to record cycles with
--call-graph lbr, but the file only says the PMU has an LBR: AMD LBRv2
rejects the call stack mode with EOPNOTSUPP and AMD BRS, which samples
only its own retired branches event, rejects cycles with EINVAL, so the
test fails on AMD instead of skipping.

Skip when the same event records without the branch stack, so a PMU
without the LBR call stack skips while a perf record that fails for
another reason still shows its error and fails the test.

Fixes: 446c595dc0dd1759 ("perf test addr2line_inlines: Ensure inline information shows on LBR leaves")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index e8754ef2d7f21ac2..050e95c0fea12aae 100755
--- a/tools/perf/tests/shell/addr2line_inlines.sh
+++ b/tools/perf/tests/shell/addr2line_inlines.sh
@@ -8,6 +8,7 @@ err=0
 test_dir=$(mktemp -d /tmp/perf-test-inline-addr2line.XXXXXXXXXX)
 perf_data="${test_dir}/perf.data"
 perf_script_txt="${test_dir}/perf_script.txt"
+perf_record_err="${test_dir}/perf_record.err"
 
 cleanup() {
     rm -rf "${test_dir}"
@@ -71,7 +72,24 @@ test_lbr() {
     fi
 
     # Record data. Currently only dwarf callchains support inlined functions.
-    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf test -w inlineloop 1
+    # caps/branches does not mean the LBR call stack is supported: AMD LBRv2
+    # rejects it with EOPNOTSUPP and AMD BRS, which samples only its own
+    # retired branches event, rejects cycles with EINVAL. Skip when the same
+    # event records without the branch stack.
+    if ! perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- \
+            perf test -w inlineloop 1 2> "${perf_record_err}"
+    then
+        if perf record -e cycles:u -o "${perf_data}" -- true 2> /dev/null
+        then
+            echo "Skip: LBR call stack not supported by the PMU"
+        else
+            cat "${perf_record_err}"
+            echo "Inline unwinding lbr verification test [Failed to record]"
+            err=1
+        fi
+        return
+    fi
+    cat "${perf_record_err}"
 
     # Check output with inline (default) and srcline
     perf script -i "${perf_data}" --fields +srcline > "${perf_script_txt}"
-- 
2.56.1

