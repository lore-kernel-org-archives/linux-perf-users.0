Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545975;
	b=MC+CNg8FwcdWwMKmhtnX9kS7cHdCPv+2iZzeMBBFR7xKvW6TZ/ADYyFrRVpqfblhQVjG
	 B7Uo+NxK3CY0Twd3fdztFskLNPA0y+YWYpwIQnQ0Z2GP6/x2u89DCaeqgOv2AEab26Mzv
	 1mxWwWJOda56+rZr6WzrN4XufxBIAi/tJcSz3CUMxiRU+MoHXY83fgHllQ1njmc1SXne3
	 LEtumNpNTXztVC9EkyTxl+Blnp7rCNQuq1Db63UjyF+pt9oDRItSyzcRAaZPlK/8wnWpk
	 0DhRP/sKlRlNTAptLJcrG1mvZHn/NbI9soTEqo93WCQ8y7KIcEZoEHeX2HWW+wbo0OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545975;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cWzmCGSOUkT82JwraHh6W3LzeDAaWseTKyeswNlLCqk=;
	b=1AN3Ro35vVTjAyNg5lj2eVDtRa6yIiYKQkZZsJ5vBWFtb18obmy63ZZCrkmIOtSNEBYe
	 DKnHSLlbp6nsTJi/X00sYZJMtFfMkd/LTbUK8WxNPUuc8s8h2sTC179LA80xzEIo83hdl
	 mYVS+lUCxixv7uZsXKXDFoV2zgkack2na7X4oN6Oh/mfVWmCV9ozAFwt4wbJ1EIXp1oBZ
	 VBCJp6Cv4TGYrVO2cEcFVSMeQdp/ioKX57rWcnI3eMmTg0UwdCZ9t/Lk7/BusgU26AScv
	 A7ohwNr67rO1in2QBCQ97T6I38sZ404+TdSDrrbdBZZ5UENjaF0FfGuMFfsPMvf63Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7K+T7Ve;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6133606A321;
	Tue, 24 Nov 2026 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7K+T7Ve
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEAC1F000E0;
	Tue, 24 Nov 2026 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545975;
	bh=cWzmCGSOUkT82JwraHh6W3LzeDAaWseTKyeswNlLCqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J7K+T7Ve5qhNxhl3YiA+pDWjf0JuyC893rbsw0LgXW5CeD2xm8CVjXMCvVM9fmLgi
	 qbPs9J3aIY3/IhM1N4w5FxKNpOmVDVNUIohwit5/HhGt56m8bKyCSVncYqdXAe/EdQ
	 tAHj2xsFl3XAhJcyaavdltHX9M+KiizkjfWi+M/8IDQZtEytLcI5xKKTR6oiF/+hD5
	 X3hwfXnrZwXoxLw+0j7MKqxj7WZNGH4CF/C6HKpzKzV3xgvI4r/wiYe7n2/FFxxhup
	 o49VSxeFf0RmE9ZGjd7s4d/CAjBmhyUc8H3YUUBsUur80SNuLxwF7rVQSYCPAW/ZhG
	 /UX9qQmpVRa/w==
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
Subject: [PATCH v1 01/17] perf tests top: Pin the ring buffer size
Date: Tue, 24 Nov 2026 15:45:48 -0300
Message-ID: <20261124184604.24983-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124184604.24983-1-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
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

perf top sizes its default ring buffer from kernel.perf_event_mlock_kb, so
a test host tuned with a large value makes the default mapping huge and
perf top fails with ENOMEM.

Pass -m 128, the upstream default of 516 KiB, so the test behaves the same
whatever the host setting is.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/top.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
index 3d52677ccb5fd309..4808d79275178b40 100755
--- a/tools/perf/tests/shell/top.sh
+++ b/tools/perf/tests/shell/top.sh
@@ -19,6 +19,9 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
+# perf top sizes its default ring buffer from kernel.perf_event_mlock_kb,
+# which a test host may have tuned large, pin it to the upstream default
+# of 128 pages (516 KiB) so the test does not depend on the host setting.
 test_basic_perf_top() {
 	echo "Basic perf top test"
 
@@ -36,7 +39,7 @@ test_basic_perf_top() {
 	# Use -e cpu-clock to ensure we get samples
 	# Use sleep to keep stdin open but silent, preventing EOF loop or interactive spam
 	retval=0
-	sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock \
+	sleep 10 | timeout 5s perf top --stdio -d 1 -m 128 -e cpu-clock \
 		-p $PID > "${log_file}" 2>&1 || retval=$?
 	if [ "${retval:-0}" -ne 124 ] && [ "${retval:-0}" -ne 0 ]; then
 		echo "Basic perf top test [Failed: perf top failed to start or run (ret=$retval)]"
@@ -83,7 +86,7 @@ test_hybrid_merge_perf_top() {
 	# environments can seamlessly fall back to cpu-clock while real
 	# hybrid hardware will naturally cover the merge logic.
 	retval=0
-	sleep 10 | timeout 5s perf top \
+	sleep 10 | timeout 5s perf top -m 128 \
 			--stdio --hybrid-merge -d 1 -p $PID > "${log_file}" 2>&1 || retval=$?
 	if [ "${retval:-0}" -ne 124 ] && [ "${retval:-0}" -ne 0 ]; then
 		echo "Perf top hybrid merge test [Failed: run err=$retval]"
-- 
2.56.0

