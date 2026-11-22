Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383685;
	b=5AlmrapSmDRRyV86yNrd0oUJttQ6zeJ5I/M6dhAkrIHJXhbGtr1Osz1b0Xw9boI5s+mp
	 H7w+kypXQMn+OLsr7yaAfPUXhp9Tu9SVAQ5NUTrN+Ip31a9wY7s1j5XXhrAMkInbY3OaG
	 WJ4c0kznfIEsLXYDU6qfC/8fFdsWSc/T6PAN6zxskjCPLZ6SyhOoFYm8A5BCAtYtVPCL/
	 rsfWn1VS3nUp87cjQC9pkOMp9z0eqjOeUEOTd6QaPUUveshDC7PPVmoMMYDHnMBhGZotx
	 9gqw5yptNWtvKqbbYRiX6lsVkFqecyRnvw81cTwYpkvtL2ccmElGurm54E1aIrp4rvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TAQSJSakE/xLPDv7wuU6GekzRtpAh647c9x3A7WPyx4=;
	b=CU/n7MIehLElyPZDoO6IwuQuNry2Q+aHvD8HENSHK+DPPHx9S6n9aCr/vm+wo1MjSFyV
	 FZfy4ipxD7xxX453iLMFDk4AhHmIJ1Y/d3DqpVJ4olM8VIQQT3TqhfvAWKFQZy4DdNnLg
	 YCr3fGGeqEm1K2PjSGtYOt83DAs3NCBP+mZhH+PcS3QVCdXh8s22C8yc2PeD4iHVFeo1x
	 K8JeArmIvZRUZiSFFxIbE3cy42BydCnqbwSMa+mqVYOl0J/TmS2pOBtXDduCer3i6ncKz
	 8kczXAheZTASJ+6Uf4NCwAdtjy6y9vwn0+ihNNF8uR7G18jnu5Otk6b09hL4W95W7ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LG+zdU0V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB77606A31D;
	Sun, 22 Nov 2026 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LG+zdU0V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919381F000F2;
	Sun, 22 Nov 2026 21:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383685;
	bh=TAQSJSakE/xLPDv7wuU6GekzRtpAh647c9x3A7WPyx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LG+zdU0VyiCt3TtjpjdBvQs0dP2vmqoJVD6H+/jkOHxDou5ZiC3jS7jjrBhZZyoCS
	 IKSUtjMi5eSPnNfqEGfL0beT+2bai46I5kgYaSvhzvtnt22Zc4ef27+q7YFVi444Hv
	 EEnyCzu0hTCYcL1XMu87CQ+ZjSZJ/yYUloLi1BvUGkgXOf4qyG/dSqBBnlPWK6qeyS
	 p9vxx1Az/mSuJ5dQ1IEbiFCFu5DMIq/iaydWB8h/TPFGV6zmNaQDnBSXzV+oggbKH0
	 7XQmS0zpmSumMVHgCf0WFNIQDtS3KsGBl5GOeQIln+xjgifDNn1ajH3G45m3wClsT3
	 1MOAORTzjCtqQ==
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
Subject: [PATCH v11 15/19] perf test: Skip the LBR inline unwinding check when unsupported
Date: Sun, 22 Nov 2026 18:40:21 -0300
Message-ID: <20261122214025.16769-16-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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
2.56.1

