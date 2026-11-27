Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743499;
	b=XegyjmTOi2ClCngAf+vNdRoz/XE9L9Zha20QcOGWs61d1NwwCnYPqD3SgpaUUINzKhGb
	 ESNNwHndDJN/Nq1USt8xgj18yDjFNvlCT8hvQrZX0/lZ998qfE70aLPNVKW61+CyEWVwm
	 qkppgpwaT/vAihjEEercNLQss9FQVnze7NBWu0nTTbJ6nZjIRhUb/V7UaJdLRuNs8S2kd
	 84AfGznyDQCEaXajk/77GyfjFAmYS/VolWT+D12dlGNLRF5BxutPN77nytso1Mr/Md05F
	 t1zWUXf4uiV+vaqhCtvznQaAmy2v/AI+aSaL890dADVzQdTV6qApHn+VwPcauLrW33g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743499;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5k7ucL6wIMzvkk6eENIsxST3JmM3KfyBNtOm4U3EwyI=;
	b=Tu41T4CGkvESzYvxC2ZWS+18awvR2UFahqu6YKQqF9GX97cHGph0ukhUzMcOvrMp5+So
	 tKf1FERBNwYE8xXcWumVUMBEVs5uJiJV4KtobuLSueNj3dbWz8wF/qGClJ2S/k0uqviFu
	 +SdGy0gXnbaztYjOEfyOw9jyb0gTR5cEcO6AvTgyBclh74VyQjA78NXzUZ8Hvl03YRh4w
	 ioJfkmogPlvbyasYhAM9iWbNf3PQSKyBXE2VBJBuE5Zx//lm2/JBFp4Lm5ySXNKFbHFHW
	 7KVXi43eY5iEgjFEpkhLtLcopjfAgd34LFMvVlukLjsaehnzn0cbN25T2K2LQcMe4Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+1g0PzT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1934606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+1g0PzT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4B81F00898;
	Fri, 27 Nov 2026 01:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743499;
	bh=5k7ucL6wIMzvkk6eENIsxST3JmM3KfyBNtOm4U3EwyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+1g0PzTQ0TE+E1VF4VStf+5k6xNMsrsPsO53p/60OzeE41sAjAg1rArhMaX+0vMk
	 LUfzmt2dY8QVrth5FsgxYyTsNdjPTKj7XR5QRHim4b/rCQhmn7+/8WMWxtsKOm951O
	 8/vIyl0IG8CO73hEhmFLjdv9DipdTiSHgnx20gF+D+lXz09J13kh4V5SzhIeYTbd1x
	 IEOBZqkYQdpq9AvMfFAjYVn3Xebsb3zKJK0NX6oW+yVYVDAXer5SjOhRDvdh6L0/TT
	 omuN8lTzqkhTlxRRD39bLOfY5jXlMYnCejeniu+IcGv8f3BNfjB6DNWZ0GTwYZ9Ewy
	 fd1iFYxFODk4w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 02/18] perf tests top: Pin the ring buffer size
Date: Thu, 26 Nov 2026 22:37:45 -0300
Message-ID: <20261127013801.14841-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127013801.14841-1-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
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
perf top fails with ENOMEM.  The BPF sideband evlist ignores -m and uses
the same host setting.

Pass -m 512K, a byte size that does not grow with the kernel page size,
and --no-bpf-event to both invocations, so the test behaves the same
whatever the host setting is.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/top.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
index 3d52677ccb5fd309..deb0782e991e42fc 100755
--- a/tools/perf/tests/shell/top.sh
+++ b/tools/perf/tests/shell/top.sh
@@ -19,6 +19,11 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
+# perf top sizes its default ring buffer from kernel.perf_event_mlock_kb,
+# which a test host may have tuned large.  Pin the data buffer to 512K,
+# a byte size that does not grow with the kernel page size, and disable
+# the BPF sideband evlist, which ignores -m and would still use the host
+# setting.
 test_basic_perf_top() {
 	echo "Basic perf top test"
 
@@ -36,8 +41,8 @@ test_basic_perf_top() {
 	# Use -e cpu-clock to ensure we get samples
 	# Use sleep to keep stdin open but silent, preventing EOF loop or interactive spam
 	retval=0
-	sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock \
-		-p $PID > "${log_file}" 2>&1 || retval=$?
+	sleep 10 | timeout 5s perf top --stdio -d 1 -m 512K --no-bpf-event \
+		-e cpu-clock -p $PID > "${log_file}" 2>&1 || retval=$?
 	if [ "${retval:-0}" -ne 124 ] && [ "${retval:-0}" -ne 0 ]; then
 		echo "Basic perf top test [Failed: perf top failed to start or run (ret=$retval)]"
 		head -n 50 "${log_file}"
@@ -83,7 +88,7 @@ test_hybrid_merge_perf_top() {
 	# environments can seamlessly fall back to cpu-clock while real
 	# hybrid hardware will naturally cover the merge logic.
 	retval=0
-	sleep 10 | timeout 5s perf top \
+	sleep 10 | timeout 5s perf top -m 512K --no-bpf-event \
 			--stdio --hybrid-merge -d 1 -p $PID > "${log_file}" 2>&1 || retval=$?
 	if [ "${retval:-0}" -ne 124 ] && [ "${retval:-0}" -ne 0 ]; then
 		echo "Perf top hybrid merge test [Failed: run err=$retval]"
-- 
2.56.0

