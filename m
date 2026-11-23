Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471281;
	b=MvFqAJpHcWknPu9k9xW4WeEI9M0pEBr40HLn1Tcnn0tKbcIz+kHNgMjjk4Ll/rKZARAc
	 dtzJmElMJ7OTYwuWxNh6/tYrgGHNSt0XtTM9p4fk1zXyiYQfQYNtxg0vrpE/jJqhWsSLN
	 cSawuE5aCCUGj2jIu1j6AvMQ1mAy4yBFv0QLJJSgD4GnIYSdXjWpgU6QNDhQ2wNxsN9Sk
	 VTLfYW6ZEmPptUTFHoryKeb5WJTaw3zQZVGUtjAhOYBgZWtD4mbtDw4SX630rI/PD42E3
	 gingl+rkLEzvgqtZ96SWJbcKRTOlammS2oZaCc5Y8G7nzRsOswsB9aS25trGRTyC4vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=salfeQFlmGPsAyKGQjgwjrheD0amYhnaDYI9pSIJYKw=;
	b=HhwJXuLELoYPAxgU5aD2gOxLrfUyzp04l6JIiMAPZ3L5FVAxL2WXkiWx5RHzEMDHOzHM
	 92tPkhQy+tS862K2WbJF7Tj5Ne2TcXi/TaaX1TW1nE31i04/YBkr5sVSfnlfjIpRad/cX
	 +gUVorJEBdm8INjqbQU34Hn4HwbIDgvRP4SoauvmUszXQG0VDe52wCice99Vh1F7q9MZt
	 ICQ7hRUXoIGUm7OvT/PIqLj1IESn5t7d1SRdt9GocXeNFOL20RUEgjJ1JSHtyI+W2d5tK
	 edjKY5P/4ZyVBEJmQwuj8ZPNFGt1hsf3G6OlICND7/tZSSBv17wlWxQnjO3z3kOhB6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GExHF9xx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CA606A31E;
	Mon, 23 Nov 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GExHF9xx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8AF1F000C4;
	Mon, 23 Nov 2026 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471280;
	bh=salfeQFlmGPsAyKGQjgwjrheD0amYhnaDYI9pSIJYKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GExHF9xxfN8mZTQwssK2mOAMjWXYMLiWa5GBB47lzT1XgdH7uA+qyuGXiUU6M3p83
	 xO5MSSGdOlD12JpzzkxcCPAW2vCWaS2asjNd9et/P3kqCP6BA2Sagn0GHnJH9ucxU+
	 DMok9tCpIMX2lXmBwk7v2Tez/6+VO3J/jgmB0r+AYcS2TqQQ0DUTd4ERxcANXtbKRH
	 RSsqNDPMuWhOQrApV2r2gKFzbN349gMa6VXJ4LxLRiVLE+E0xXZU/gkyaeNcsyizOp
	 T/O5cF7IegiinzMBknJI0pYPWbpZv6kjDUpDXxGM33bZEbI5bb8z429oi7vTE8yQRX
	 mz5AtDl9+Razg==
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
Subject: [PATCH v12 15/19] perf test: Skip the LBR inline unwinding check when unsupported
Date: Mon, 23 Nov 2026 19:00:20 -0300
Message-ID: <20261123220024.14891-16-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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
rejects the call stack mode with EOPNOTSUPP, so the test fails on AMD
instead of skipping.

Skip when perf says the branch stack mode is unsupported, so a record
that fails for another reason still shows its error and fails the test.

Fixes: 446c595dc0dd1759 ("perf test addr2line_inlines: Ensure inline information shows on LBR leaves")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index e8754ef2d7f21ac2..02a896c9d99cb2ac 100755
--- a/tools/perf/tests/shell/addr2line_inlines.sh
+++ b/tools/perf/tests/shell/addr2line_inlines.sh
@@ -8,6 +8,7 @@ err=0
 test_dir=$(mktemp -d /tmp/perf-test-inline-addr2line.XXXXXXXXXX)
 perf_data="${test_dir}/perf.data"
 perf_script_txt="${test_dir}/perf_script.txt"
+perf_record_err="${test_dir}/perf_record.err"
 
 cleanup() {
     rm -rf "${test_dir}"
@@ -71,7 +72,23 @@ test_lbr() {
     fi
 
     # Record data. Currently only dwarf callchains support inlined functions.
-    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf test -w inlineloop 1
+    # caps/branches does not mean the LBR call stack is supported: AMD LBRv2
+    # rejects it with EOPNOTSUPP.  Skip only when perf says the branch stack
+    # mode is unsupported, other record failures still fail the test.
+    if ! perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- \
+            perf test -w inlineloop 1 2> "${perf_record_err}"
+    then
+        if grep -q "doesn't support branch stack sampling" "${perf_record_err}"
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
2.56.0

