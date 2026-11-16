Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872853;
	b=sEeMdxFA/h9XF4/kTMSTWRR50QCziRd6Ty6HOQrtxSmCk37Uilx+gnqin96N8T4j6TGa
	 iubTzsiikpWv0ZYpLwjY0uHHrUnOQsoMGCSJPJrdfgGiJ+60puea0shdU5TC9IPwU6UGN
	 /y5ekaSKeAqK1I3c3vHvOoXHK9IqVD0wIcrFdLsz5ZaraNtGy94zg7nA2qfnow2tnvlx5
	 0e1/pmDgHIjXOaht7g8Kf97xkADLJbmB8Rr2tpoXNEi1j3qvb4hOPBVbjqwAuxk5u8Gp9
	 PnEjOd52zEuV+dI8umSuVFePH1CtERKTgUIaXEQ93pycY/5uVuNjJoI7n49cw+7diMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Zv27WeyfKuHk934BOkoEy9pjYUUOCVBJyFWVBjr4R9k=;
	b=dHcH3wizwT0zQmS8ck07C2wl2jYDmu5P5EM75q4LexLkXEB3tYwU8xmV040/5IjsJvmW
	 yIyb+q6Md7XgynRVmSUWFMflEbMQsoO9FtL1blV8D5sRLQaBBk29mLAtZ8GUDqxbVmkIe
	 MsJFsiZwTgLwWGJSN+oapw2fOMt83t+rKIAH4YirybiO+s3hgQmXvQ849uFN7VEECo+MC
	 XDIMyOpFT64h10937nMPrAIeKg6SPt3WzRJaoKcqwJI/9flP1m1WpCSjV0HMrWw94jVWG
	 4Ic4923C6iSzeQjq2jyy9uG76e5LWw/5df1Zgm2bJ0h8v8wchBQ9YXc+3a/qWddNQ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpU9CgYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D38606A331;
	Mon, 16 Nov 2026 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpU9CgYB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9012A1F000C4;
	Mon, 16 Nov 2026 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872852;
	bh=Zv27WeyfKuHk934BOkoEy9pjYUUOCVBJyFWVBjr4R9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hpU9CgYBqcjQHU+71NwMwTHYyzBzoSSqi0q3F0JGKtEQ09wUFQn+qjWjYi+0YJKOz
	 m5rRFiEFnQv93ebZ0u12gd9UNo1QWuoyKjwV9YbISVJ4QTEDkWzWoXxxbdYvWedn2z
	 iTAxdOtkTMs8Q9IO5i0I9PhMgm+UUclCD8cjQ/e4fkV4xy7RjUk6S8RL2/g0REcEni
	 2pphGl6iP47xhi2kcazexVYcmFBDv5KvPTWObO7pw8G2SIQnoph2tqizqbN6eEfw6y
	 MY4k8zTzMPDvJYMfzdfzG+ZmxJx1+N0hApJvRdWb2Zdu11h5ksryISDZxwUu2qdjIX
	 XGWeDB5aEfczg==
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
Subject: [PATCH v4 10/12] perf tests: Fix the Intel PT virtual LBR check
Date: Mon, 16 Nov 2026 20:46:56 -0300
Message-ID: <20261116234659.3950531-11-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116234659.3950531-1-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
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

The record this check uses writes aux samples, and with the single data
page the other tests ask for they are lost:

  Warning: Processed 29 samples and lost 100.00%

so no branches are decoded and the check fails with "Failed with virtual
lbr".  Record with 4 data pages and 128 auxtrace pages: the same trace
decodes 64 branches and still fits the mlock budget.

Require the python perf module to provide session, not just to be
importable: a perf whose python bindings are not found can pick up an
unrelated module and fail with

  Error processing events: module 'perf' has no attribute 'session'

instead of skipping the subtest.

Detected building perf on fedora:44 on the runner with Intel PT hardware,
where the subtest failed with "Failed with virtual lbr" in the container,
and with the python error when run as root on the same machine.

Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Python API")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index c0ecece0a8255124..511440b5956a6897 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -384,13 +384,14 @@ test_virtual_lbr()
 	# shellcheck source=lib/setup_python.sh
 	. "${shelldir}"/lib/setup_python.sh
 
-	if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
-		echo "SKIP: Python perf module not found"
+	if ! "$PYTHON" -c 'import perf; perf.session' > /dev/null 2>&1; then
+		echo "SKIP: Python perf module with session support not found"
 		return 2
 	fi
 
-	# Check if virtual lbr is working
-	perf_record_no_bpf -o "${tmpfile}" --aux-sample \
+	# Check if virtual lbr is working.  This records aux samples, which a
+	# single data page overruns, so give it more room than the other tests.
+	perf_record_no_bpf -m 4,128 -o "${tmpfile}" --aux-sample \
 		-e '{intel_pt//,cycles}:u' perf test -w brstack || return 1
 	perf inject --itrace=L -i "${tmpfile}" -o "${perfdatafile}" || return 1
 	output=$("$PYTHON" "${shelldir}/lib/perf_brstack_max.py" -i "${perfdatafile}") || return 1
-- 
2.56.0

