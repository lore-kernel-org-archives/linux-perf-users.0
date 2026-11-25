Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634650;
	b=zZD826GyKHJREEWBysM4LLkDxXbAJQD2NytqgpEijh49hOxrfLGMmz8Y1DzyLl6PIGAd
	 jByqrYBSKHmPBWRf1Qim3zruHTSmgAuBIdGk3uNrch4sz5IpZDNZvfgMYEMjkWUgRUkOG
	 Kb8vfptNWBILwERbLZrzf6Wt+NU3Ni986vdtJfyrqf/yAF2Zvll0un+VT0IhwNMX1SZ88
	 BtPf7xlR6PRnzHrsUo7xRrZ12CIb95IqWPQ6WUzO6StbS/JZvyT1RJgdB8U1kR02GyhJt
	 OK/LIOoTazV7Tugf5nKDJD7kkj2kUNfnCf5Apz3PLRJXAvPKVblA1Mp4is2T5K6aICw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634650;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=salfeQFlmGPsAyKGQjgwjrheD0amYhnaDYI9pSIJYKw=;
	b=UUWPfhT7lQY3zIWg1t1lb4gOwefX6Bv9cHVZEUnjHCK/SV7JcqQBiW7i2umsC4OTVvJc
	 zd2P2ziY9/lO5T7bxC/kw8gk5IP3buE74zvpJmrBO78Sbf9cPR86kKLynsWkv3+4qADx9
	 QnYluFE5HL7Ac+wjpLcQXnPTpsubfgsD4ohiAjjCZ7jsIUdrih5jQNm1gVp7dmiV+LCKc
	 7l78FYeYZN4T943yA7ydBn8MirdXO+qAXBChiPfaMAaAxghraeckJlsIPRkV7lXc8oiOX
	 OpfycKrMjRQ3IYm0S1Qm6yF6DkMRUauM6J0tS1PvHDhHEF4adf8c/D8l6aGIb70bqkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgUjby6z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616ED606A32A;
	Wed, 25 Nov 2026 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgUjby6z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394951F000D0;
	Wed, 25 Nov 2026 19:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634649;
	bh=salfeQFlmGPsAyKGQjgwjrheD0amYhnaDYI9pSIJYKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VgUjby6zHrQ7TtwMFo19LED1Cmz0Z/OLRXO1W6wBOxa2EiPqCyo7MTylbh9NiFg6Z
	 bhWrUxQn0fyMBX9cAZR+FWq75QRmO4VKb/ZCMi9EYOCpOdt0x+qeJyXde3+99aVdW7
	 mpOc4vO4Heqd9W9fEN4yckd0kqIVjYT+oKevJvEJu74JSY3zI0x2bd+Ji/E8CmKWFG
	 Y2QCGxdiRf7cB7TCXORFNm81JwIEwrOWZ8wzh5qzLO9BOUgmgajxtdAEsIFrKG7QAU
	 GWz1fXRueYmATSuoPYGI07L6ldSRKU8FxjA8CF400NadH4r8dnCqjqwMCv+ZDLGqBW
	 DyBe1qSHRjdHA==
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
Subject: [PATCH v13 15/19] perf test: Skip the LBR inline unwinding check when unsupported
Date: Wed, 25 Nov 2026 16:23:08 -0300
Message-ID: <20261125192312.34134-16-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
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

