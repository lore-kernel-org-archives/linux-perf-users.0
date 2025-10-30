Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6461F03C5;
	Thu, 30 Oct 2025 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796901; cv=none; b=XjPqJzD+XimsuWwY2YR2KgoxMr2ayBmiHLMG5qv4Lw0gbtFBFem3w1rpZQIgHMnrftk8VXPkSqc+OfY54SJ4WdzFODeYelKw+wS0j9lL3VRi1VxYgivhmB9PkXD6Een3uRAZbl01QDzkMEjWiJB4zhae0jxHRmmZ6qLVblubW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796901; c=relaxed/simple;
	bh=dAIv3evjB4jt3R2ee3Lg209b4bPVWXCkkse+AcwvVmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTg6EcbAo63Sav5bpncZIZtd9mGFg739T8wyeQPJub+OxMenkRSJhLL6c7ieafQU+nyYKCDhN5MCsjDiBDSkLr0FqqgvedC5ohySkfx9J+floRuFFFOnj2zSrAj5/u4S4ali0V6VpPaUKaK4YzDVYbsbrWtssBcVfyaSeHHXEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS6P23nF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS6P23nF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FB1C4CEF1;
	Thu, 30 Oct 2025 04:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761796901;
	bh=dAIv3evjB4jt3R2ee3Lg209b4bPVWXCkkse+AcwvVmk=;
	h=From:To:Cc:Subject:Date:From;
	b=eS6P23nFGVSTOuSGMEfR3SrEAIeOIjucBfrY1jimpSaa6e9Lz/kHh8+mjNjB/TVPL
	 5y2NB5bXXSa4E/pZ0/A0pC1U4U/Bget0ZRJNlZOqeztAaAzBp6FymKQQEUiTenOBT3
	 TXij5Bj9PjhVm2GAUtZaIY1fl4bSyacQfZ133Fttaso1f1V15892jFDPHu4BNKq0mp
	 s6chiANmD0Mgv/pH0SUZnPQgB9RiCMEWPS8w68vJz/ul2tCbzq7/93PSbVHipgYtpL
	 94Yrvc3Rg+cZsLTNqXBYb0uR9Fr/TDLkL68H+R3pZer2Yl17k2zDCBssKVwMj3sQik
	 Z4roMH2bxa3Sg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf lock contention: Load kernel map before lookup
Date: Wed, 29 Oct 2025 21:01:39 -0700
Message-ID: <20251030040140.1115617-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some machines, it caused troubles when it tried to find kernel
symbols.  I think it's because kernel modules and kallsyms are messed
up during load and split.

Basically we want to make sure the kernel map is loaded and the code has
it in the lock_contention_read().  But recently we added more lookups in
the lock_contention_prepare() which is called before _read().

Also the kernel map (kallsyms) may not be the first one in the group
like on ARM.  Let's use machine__kernel_map() rather than just loading
the first map.

Fixes: 688d2e8de231c54e ("perf lock contention: Add -l/--lock-addr option")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 60b81d586323f379..7b5671f13c53525d 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -184,6 +184,9 @@ int lock_contention_prepare(struct lock_contention *con)
 	struct evlist *evlist = con->evlist;
 	struct target *target = con->target;
 
+	/* make sure it loads the kernel map before lookup */
+	map__load(machine__kernel_map(con->machine));
+
 	skel = lock_contention_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open lock-contention BPF skeleton\n");
@@ -749,9 +752,6 @@ int lock_contention_read(struct lock_contention *con)
 		bpf_prog_test_run_opts(prog_fd, &opts);
 	}
 
-	/* make sure it loads the kernel map */
-	maps__load_first(machine->kmaps);
-
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
 		s64 ls_key;
-- 
2.51.1.851.g4ebd6896fd-goog

