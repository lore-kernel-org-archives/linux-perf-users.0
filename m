Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634643;
	b=KbeGcYPksyi2TKDpgSssvoeweOQoM46r0CmwRtIXl2BNHBtjAVEDUzXQpGxHoiTe4gLu
	 YyePJXvDGpPOxQNj1IdWvA8SxHBe/68rBwdQlqNGx0/B7RKU+ydpysogJLueZiHr7jwIt
	 Efudi9iUc8501+NgjG6YDr1E0stxnN1NEZDjCaRAeEEJJznK+lAY2jDXdqryhlOt2bjp9
	 FA/2vIMxCWhwbVWM8BWi7AkO5cmh3uQdhs7zxJ4k/52mcCGLlATt/y6A6QER2XFITj1KG
	 pj6NzBLT+WcAzqQVteSdscttvBtoTAHf6tzuRac34mkuA1TWShTYXDL08PN35ACLCtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634643;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KGmUhDDN0UG2rp9CP1JqbUp2tr3lxr0jBQoyS/TZUB4=;
	b=nlgj1NbzwA8AMXy1mt7TwwDqKvnFksBVQsEaP3PerJzD13v13umr27JhdL8drSDmwuBR
	 AG8HacjV/j3k0VnUzaeNWoR/NJYn8A5uSK2bnTlVV2AM/aRvu4qtZRbNZnAplTfLrZ1eE
	 PvqI+LGIjTYyFHBDpKYpxQ0o35k7YcefsUnZwbAmh0kqYYWwkZhTwIdNvLILYgstemRB0
	 Lm0EW8LznKMvsMRIb+xkRaj9+8zNqNFZYD6GVBa7hAFXNTNmlct/2ea8SrY7ViyEOkIqv
	 blcAxuaBAh30wy3A+VbxcMq4CKwCceku00LtW/i+3J8gmsD4EklBzglQytEuw7wldyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q14KmGIu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D398606A321;
	Wed, 25 Nov 2026 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q14KmGIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFECE1F0089F;
	Wed, 25 Nov 2026 19:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634642;
	bh=KGmUhDDN0UG2rp9CP1JqbUp2tr3lxr0jBQoyS/TZUB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q14KmGIupizQuBj0gJFxduH573ZEVMJGbA84pxIr1q4UlvgNl3LgL9YIHPsm4Q9E8
	 EpuA5U5H2mLGUBtRspWfmvbMuQr0Jafc+d3H4Ma6QNUDVnCvQCCk0DPQNOMOVUxbHq
	 0dI4JyOMbvPRn2l9vnLfO5TUDAy9HM09vmhd+DJXEaSVvSOvLNE+WrB0E7P1tLJwaL
	 bxpnK2igqcAN0ggokwd50HcpVILQgzwX3rSnqnm+UB7CSQzj6GF3mBTEXl8awKUNic
	 a7sK8C22spO8kF4UPoEfHTGqQ5O2FDsYI6NjyqWB176KG5ACE21eNv1laBQnLikjHB
	 Ypojy2Nc6r6rA==
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
Subject: [PATCH v13 13/19] perf test: Fix the Intel PT virtual LBR check
Date: Wed, 25 Nov 2026 16:23:06 -0300
Message-ID: <20261125192312.34134-14-acme@kernel.org>
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

On an Intel host the virtual LBR check failed with:

  Warning: Processed 29 samples and lost 100.00%

The record leaves the buffer sizes to the tool defaults: the data ring
follows perf_event_mlock_kb, and the runner's small value left a single
page, too small for the AUX samples.  Pin 4 data and 64 AUX pages, so
the test does not depend on the host sysctl, and give the AUX ring room
instead of the single page the tool sizes to the 4 KiB snapshot.  Both
fit in the default mlock allowance regardless of the CPU count.

Also require the Python perf module to export session: a perf module
without it, like the distro's python3-perf, made the check fail instead
of skipping.

Fixes: 915d6b14dc0c8971 ("perf test: Migrate Intel PT virtual LBR test to Python API")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index c0ecece0a8255124..96f5c132cebf23e6 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -384,13 +384,15 @@ test_virtual_lbr()
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
+	# The default data ring follows perf_event_mlock_kb and can be too
+	# small for the AUX samples; pin 4 data and 64 AUX pages, which fit
+	# in the default allowance.
+	perf_record_no_bpf -m 4,64 -o "${tmpfile}" --aux-sample \
 		-e '{intel_pt//,cycles}:u' perf test -w brstack || return 1
 	perf inject --itrace=L -i "${tmpfile}" -o "${perfdatafile}" || return 1
 	output=$("$PYTHON" "${shelldir}/lib/perf_brstack_max.py" -i "${perfdatafile}") || return 1
-- 
2.56.0

