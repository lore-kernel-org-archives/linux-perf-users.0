Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706898;
	b=ouQMykhxuQy7sRZdW6DLegvyncrNMmBGgRiHCcK0hxF26gpGnS4ORgc3WsYwBoemB+C1
	 qqbia0RutYN5D5NzO9crf0g1KoYamV/qYLNouWMzobKkGHPg3AlC0V00uWD+zyESwWg3K
	 TzWmolQItOoqjWcmQme459tD8knQQtSH0KPOzdz5jwebjwgVwdZJ00P6y09mys5hoOARk
	 QlqT87l2aShNslMD2K2Zbt47GoKOOpne85fH+SCWbHBx2BLU9CetZHBu19toesZOhjD97
	 Il4iSLxWSNKzPwiOsFvwtIlkoL1kKYt50L6ijiYzXASveYboEBGpMRdgn7a2L8qdmSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706898;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iT/MoQupol8iNbk2531HTgOEAOEfgGTm9mLESO53EJQ=;
	b=bhs6gsRQvR2vMjjw6oNHd8UdsEfRp9CnqlDeB86aYCsBulxpdKVHpUdJSi2vrCL+xWBT
	 /LN6750kHwH4EHSDgyGITi7A2u9bCVBuFXy6baaH6N9yrwGwNBy5PhLG4foHAkVc95aew
	 Kz2A49vOy6IYQx3Xrj/VrJNkRm/vGOwlQTzXd5UepTw0xjNoBNIyP7qWXG5DImxk0l2jw
	 OdHgCnOPO0+tUgOMZscJPd5w/O51bCeXvLPyhO8bAV/8545JikqhnreDygQ31JRMMAkfs
	 /01sKenlg6JkjJLEgzt8KJA9Kxv7tD+fRkNTNkHHCRUOdcEhjKH7pmIFENEhPnAUQfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F51eFQiq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1660A260F;
	Sun, 15 Nov 2026 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F51eFQiq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E041F000C6;
	Sun, 15 Nov 2026 01:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706898;
	bh=iT/MoQupol8iNbk2531HTgOEAOEfgGTm9mLESO53EJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F51eFQiqBrifl1IjsVPxL7CN+6yd3g/DbAZpqBvdGMJBGOOT/Ecx+t/C4Q8atczaQ
	 OEJa4u4UvVulUday7fFcVVFf7XMFV5BTnrc4TsJJrzhB+89wMqd6lZ1NEUnENvr9Xi
	 TvvfoQjylvX6dv6Q1TkRHuA+xGo9DOL2HAASb2fvG3mTIzj8gJmy0b+AF439GL3Zfa
	 hQJgZRekv1IuvM7ezw/EMSl5sS8WoPPp1CaiuQvkiTJNRpF0IbVfzCN0fccA6pRwSZ
	 p53v+owEjEb1t82sXWV3WtmaeoD29maA6n14zK+fhlyl8tzOGb+1n13Y4ct0mr6pYA
	 FHh+B5129cwXw==
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
Subject: [PATCH v3 10/12] perf tests: Fix the Intel PT virtual LBR check
Date: Sat, 14 Nov 2026 22:40:58 -0300
Message-ID: <20261115014102.2879372-11-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115014102.2879372-1-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
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

Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Python API")
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

