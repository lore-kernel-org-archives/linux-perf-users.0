Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194E420E87;
	Wed,  1 Jul 2026 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934917; cv=none; b=AknTPgMA9mujT61FFR/W9eImfaDYBHl9yI60fsaPhGhqCDqYykOx3GNUkAeQwBpKZT/G+d29qkfRCmkdA9uAnjFnB/dQkKgjbMB5261WlM7Kx3HD67M38f6RqZBDGY8RFF3K0K82bKEUBglOVEPp1ua1gB4UzuuiiPzLk6Kx0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934917; c=relaxed/simple;
	bh=9in14sLP/n1poW1M/f+gj6OzwLUFdzXD0785ogl+GwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgU4snW5jJscZk04gC2VtxecCL6JkhwSNfFh2FvkH3emtVS6LLeABDLob4G13Zn+mSMyPYHgOLGNjmYoYun1d5wgGM0VwJqwnFmeSdOq4SwNgfWr7aspwuMHb+Hvd9GYv5dqbb0eHEbecStcvk8G36uUAVWwCJ0RTxsYXgwAvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9q+wdQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9q+wdQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7271F00A3D;
	Wed,  1 Jul 2026 19:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934916;
	bh=TEwv5qYPQ8iJR8vmMNiVkIRpTJlR5rpyHBgW4uFYGXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U9q+wdQeSmW5WW096HbONkXO1fbWghO+PT9YZkqNHuQANXYATlyc9QiqNqnfOgWL/
	 y2Gx/TN/xeJy0F/1oAtpeY9fMj5Rs/61extIFXAWOKmXe6YcQ+c7aqCv1//j2yqhEv
	 CxkITw+m8Gvt+JiXZvo9Tn5iy2ekSiCP07Sb/KGMNIYXZ4Pd/HwLo+UOLu/CwmuLMA
	 5zYMPta3mlvX+KsCPu7QFttcKB/ZSN5IhnqLA033Lup9rhJUONmABSbAVApBeVc+l6
	 ZM5lWFjWBjmPyGfjtF5w6KxsdibQvLAGhrI5Nj0SnuKt09JTHteiDbRnS28oU9fJOd
	 01E9mtyrZSEuQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 6/6] perf test: Extend perf kvm tests to check default event
Date: Wed,  1 Jul 2026 12:41:53 -0700
Message-ID: <20260701194153.401218-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260701194153.401218-1-namhyung@kernel.org>
References: <20260701194153.401218-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can now pass command line arguments to perf kvm record.  Let's pass
'sleep 1' directly and see it doesn't fail.

  $ sudo perf test -vv kvm
   96: perf kvm tests:
  ---- start ----
  test child forked, pid 3686726
  Starting qemu-system-x86_64...
  Testing perf kvm stat
  Recording kvm events for pid 3686746 (duration 1s)...
  perf kvm stat test [Success]
  Testing perf kvm record/report
  Recording kvm profile for pid 3686746 (duration 1s)...
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.576 MB /tmp/__perf_kvm_test.perf.data.0HgX6 (4009 samples) ]
  perf kvm record/report test [Success]
  Testing perf kvm buildid-list
  perf kvm buildid-list test [Success]
  Testing perf kvm stat live
  perf kvm stat live test [Success]
  Testing perf kvm record default event with command line
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  perf kvm record default event [Success]
  ---- end(0) ----
   96: perf kvm tests                                               : Ok

  === Test Summary ===
  Passed main tests : 1
  Passed subtests   : 0
  Skipped tests     : 0
  Failed tests      : 0

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/kvm.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
index a5396f8e6fe5ca82..7b26368051ffdbad 100755
--- a/tools/perf/tests/shell/kvm.sh
+++ b/tools/perf/tests/shell/kvm.sh
@@ -138,6 +138,15 @@ test_kvm_stat_live() {
 	echo "perf kvm stat live test [Success]"
 }
 
+test_kvm_default_event() {
+	echo "Testing perf kvm record default event with command line"
+
+	# Check if kvm record with default events handle command line arguments
+	perf kvm record -p "${qemu_pid}" -o /dev/null sleep 1
+
+	echo "perf kvm record default event [Success]"
+}
+
 setup_qemu() {
 	# Find qemu
 	if [ "$(uname -m)" = "x86_64" ]; then
@@ -191,6 +200,7 @@ if [ $err -eq 0 ]; then
 	test_kvm_record_report
 	test_kvm_buildid_list
 	test_kvm_stat_live
+	test_kvm_default_event
 fi
 
 cleanup
-- 
2.55.0.rc0.799.gd6f94ed593-goog

