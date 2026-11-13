Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600562;
	b=UcXYuImxmnGnAlS3Jwbbre6qWmKEtyY/Tmhk9zei3YBFjLLAcoC5vYyMyt3mJHvnq1vw
	 3Jpju57oWJaWpweQ0w+2dLSzb6gDSmaJLyLYyOvh1JUwCNCE/sUat6yXpifvCiEqYo2Dk
	 I5fuHi6TIcYVulzOzHYCwj86YuOSTVCLTke8kEau3E+Hk6Tjzp6K3S3BIOTENfecCqQh0
	 ztIibhmY+1m8ctVbkwsaWj84d0yEisN5i4EHpbJs3BmbKWHvlKsgBRQbROhbqp4rw58Iw
	 M+tz6kP3vDJz1iQU7m0G/bqW3OMyYG8rAE+fP1hOuQYCq2kean9Wtjm8HPquGN8USCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600562;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sPu27QRpeMoKrqj0vMYhs8hcwNWeldd3csiOrvjnGH8=;
	b=5lLgYB1O06hJe0aLU9FFoQtfTUVZUgoQ+UAyYxz21jrRfPs1RrcQJbd4SoxFspVnotTV
	 MIADoRDrAbtTYi+7Gtoa0ViF5IPa/uEbY+18gSwtVpgg4J6rTS9ctZctxukR4wNduZBdT
	 RqjhPOMNQ1e3jSsGcatLe0J3b1xatHZlWwjNQtc2TmhAjlBXLBMLlpqRv+QspRdiQzQ7q
	 OBPIw57VwdY9psFpxhfb6LAfaXsxH0fzTX1cKZE12w0/2DMUUwdEswi6qE7w5/Mhok/Mh
	 Fn5HtmHlG3OXD8iG6KCnChZ31DJtfZcj3R/6dVzMVT63dNafVPQpDKI/0l0jclAb9nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMOEPPC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD9606A32E;
	Fri, 13 Nov 2026 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMOEPPC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAE91F000C7;
	Fri, 13 Nov 2026 20:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600562;
	bh=sPu27QRpeMoKrqj0vMYhs8hcwNWeldd3csiOrvjnGH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BMOEPPC9gGai2yGaUdQRibeI3ljnAsULhmGbgsWx2UwaCA7T4ntO2BWSTwGCCjPig
	 w3Shu2NMHGC/PgxB+/U1iFFBuwMCov+am9A45YbGiEvhGKEOon92VeP9PxQ33b0eCG
	 sO0K7ErT/iNepbGkf2KRAJICo2ax31T1wcWdGxqpSrYurswCk1pJDiDZUpvzCDSAKm
	 mOXucBwAS8m8XrL1n2llrLDL7SXe/nMXLYgcP03R85/1ZzjB2V+BDrfi+At3nnWRha
	 xU255qgWrXpe8PH2fN+tr9q96+h52stTca7vIVCHgMq+FyuzlpOxY15JRTESRZUCrj
	 oNpg8wkW51CSg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 09/11] perf tests: Fix the Intel PT virtual LBR check
Date: Fri, 13 Nov 2026 17:08:47 -0300
Message-ID: <20261113200850.2803460-10-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
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

