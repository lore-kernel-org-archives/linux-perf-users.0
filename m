Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582392;
	b=WnP0qlLd7rjFYAnz9nvx23UJv1My0dMjHkE53zBdMzgDfeCAGdQbm+G+pKS5nQiwN6bg
	 CJcP28axgcoNsHM7lyhRGsOgwQOtvvKh4cQyBgih+0SIp+fGsftn+o2lIwN+pppz9OCMV
	 MiK/Eq+fkPNTlD7RRkgKQ6mG9QFZkQQ+hhqbQz0yY9a0aRqLOt71Wh043+q50iFzpF/9r
	 xUV8b48wfM0BK/4pz1VKBrIpyC1P/RTceXNxZnPEM+ewpi8FQfRrfUccgjA5zA/+j98M8
	 RaaryUC+xnMcMG04grPytwIPgvSHv9GkIL4wGFJ20qWh1ZffGws1b3cgAHAX9Nfg18A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8CcyYADhin+8i7oHA84mSiYxGkyQxGlWj0NcUes1MvU=;
	b=C7nmygWxuX/d98Auc0NUHauR93eyvq6bATvNYG5XLDc9K5o0aftTeE2MAGR0geQqw7/N
	 I3rsSO6UMgpdOSejVggj5MHTb1mXMlV5De99tM5a+fxLtj1B65gQIZTKDLZgL4X8rdLpH
	 gHZsdudoT/nn5TigFE5rohziE2EdgLwZhalvyq5Gz8YCw7w5DqsZ+5SmX8DXJzJZ9q12G
	 Dz0rBZRktkmf0PCU7iTGWCW6N7YoggRIQjehFuZTRtL0a9gCGWDFU17YghkQ7BM/+luVw
	 hswO2RAcDMNZQmw6ZQl3YOWCCVDFW2vnfsAIjmrVo+NC+7fIHfsWX+3PObI7mtE7JHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXDilvhc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0CD60A5BCE;
	Fri, 13 Nov 2026 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXDilvhc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DEC1F000C4;
	Fri, 13 Nov 2026 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582392;
	bh=8CcyYADhin+8i7oHA84mSiYxGkyQxGlWj0NcUes1MvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXDilvhc+XuUR2MrmPOMyyEs+CcUSHvYCRDH/5WUqKkuhtj+cf1Fz+1LxaU5XJOHN
	 Pukb3bCFx+TmINQGxH5QfSWXmqTuTOEO6nAY0e8DAv9rq6ThtLrxkAimkspcB4dO/A
	 7S5B3C/Ge1cwAwfzN1A7hz/H0toxOPPOxCKFoAnH8YnB/vtAz01dTkbmegSRAbHVZk
	 TLl9hfEyfEl7nAb0VPq1Z3ZNKlXp9oQqepEXVZV067LP3+3Xj+0dzdRxg6UQ4bLDu4
	 ZX7zYr4MWZ3JCD3mdpF9U6pFvanr4tDYuzgdjPCc8iamKJR5r+HJqZ3aZfAdNKj8jq
	 XcyjSzpNSBAsQ==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v1 10/12] perf tests: Fix the Intel PT virtual LBR check
Date: Fri, 13 Nov 2026 12:05:51 -0300
Message-ID: <20261113150555.1163049-11-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113150555.1163049-1-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
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

Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
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

