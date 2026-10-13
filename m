Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BCF522695;
	Tue, 13 Oct 2026 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912121; cv=none; b=fKy1/u/U7nghlOQFuKhbLixlF4fT2DvDaUuABlE1UWxWrDPFbP1faL2fMTi45xaOh5peSW0nQlLy3rJoKEeVdxDkEP2iBHUSD3b+BB2KNLBHs8t+yC71P00FrbowIVxH56mYGM21kK+rqLYELB9ML1B3/dd2y63V9ftwTuWD6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912121; c=relaxed/simple;
	bh=lKJkS2igU/ql/4oIHIDKzIzeq2cUzgOl2Qv/92A7IkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsaIQigpgbihSXG8FAIpGxqxhLXvAN+5vE1muMQreHCPbBUQevLW6xAO+LnjSQNR2wuE66tzbSnKGUVjV7D565ZneGh99n6/84i2AXNCzYD3wC/HeTidzPE+y01coEGgrdbipgVpAX5PJK5MIxYgzOQm2DaBYRJydCZm5zRdYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYfWbyfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYfWbyfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922321F0089A;
	Tue, 13 Oct 2026 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912119;
	bh=7IvNKCVf6t7esx5apdXvLVVn4btaI3A9PCG4bw2aQpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYfWbyfJyVu2TcCgPlb9cxNU1vyxMRIYZkgcqzVMS8JEYqZVP5PUC4UTAfmJ1NEQh
	 xj/sT8KZuDTWvFga2D3+yjAxwSqLxxHGmF7UcMWgWbWA9OZzCyFBoP4eGxrlcdJxXS
	 SF0r0ESdjBLQO3SBpyhGCPAehUsaSUt2T42tGoTJwmL8IBb0Zq+Ua+n3wXf5sb3KP5
	 PaC/3kE3yShV/TuSTymSs3SU/3aPNAkf8o/hs16G7A5N0bDXRtqcntffe9RejlxxHM
	 EpBG/Q+yVHr7T9Dt9NtS7XJbfr8AvVIiyuJ0l3uQH+IM5N4VEBOwBi0IpEJ6k4rGC8
	 wtSaWsKAzxHVQ==
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
Subject: [PATCH v5 06/11] perf symbol: Get rid of machine_or_dso_e_machine()
Date: Tue, 13 Oct 2026 10:21:50 -0700
Message-ID: <20261013172155.160869-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013172155.160869-1-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function tries to get e_machine from a DSO (preferred) or env from
the machine.  But currently it's only used for kernel DSO's during the
load which refers to /proc/kallsyms most likely and it doesn't have an
ELF header.

Also machine->env would have proper information about the kernel so no
need to check DSO in this case.  Actually check DSO's e_machine requires
a correct binary type to be set but it'd cause a recursive locking
problem.  I think it's ok to use machine->env info for the kernel.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 56b8d75966133f87..a7afecb5816c25f8 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -967,23 +967,6 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	return count;
 }
 
-static uint16_t machine_or_dso_e_machine(struct machine *machine, struct dso *dso)
-{
-	uint16_t e_machine = EM_NONE;
-	/* DSO should be most accurate */
-	if (dso)
-		e_machine = dso__e_machine(dso, machine, /*e_flags=*/NULL);
-
-	if (e_machine != EM_NONE)
-		return e_machine;
-
-	/* Check the global environment next. */
-	if (machine && machine->env && machine->env->e_machine != EM_NONE)
-		return machine->env->e_machine;
-
-	return perf_env__e_machine(machine ? machine->env : NULL, /*e_flags=*/NULL);
-}
-
 /*
  * Split the symbols into maps, making sure there are no overlaps, i.e. the
  * kernel range is broken in several maps, named [kernel].N, as we don't have
@@ -1005,7 +988,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 		return -1;
 
 	machine = maps__machine(kmaps);
-	e_machine = machine_or_dso_e_machine(machine, dso);
+	e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
 
 	while (next) {
 		char *module;
@@ -1567,7 +1550,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		free(new_node);
 	}
 
-	if (machine_or_dso_e_machine(machine, dso) == EM_X86_64) {
+	if (perf_env__e_machine(machine->env, /*e_flags=*/NULL) == EM_X86_64) {
 		u64 addr;
 
 		/*
@@ -1855,7 +1838,7 @@ int dso__load(struct dso *dso, struct map *map)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
 		machine = maps__machine(map__kmaps(map));
-		if (machine && machine_or_dso_e_machine(machine, dso) == EM_X86_64)
+		if (perf_env__e_machine(machine->env, /*e_flags=*/NULL) == EM_X86_64)
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
 	}
-- 
2.56.0.385.gd3acb90ef8-goog

