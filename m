Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BA3B1009;
	Mon, 12 Oct 2026 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782771; cv=none; b=O3LlMEgqXpOePPtXaEIvMOdfA8s9IOy+851qe5r/aOkWBcgPObz7I82GxJ+CBgSjqU1gDDTmj9/aKtreaBIIjU4WijkFQ5LOh06LLznqldtRYKFGTfmTBxqJqn587axxmBivgd2y+9V9YRGyfvSyieyE69Msl/Qn9OpejqJQx+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782771; c=relaxed/simple;
	bh=GSKghGRHKCaOwFRiWDvcsNzfSd+lG4htrcx7iRcxm+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiHuCtl13RFUQufGiiQgVbrOGzCW2yPgaHeH8FXLzf2W0yzEnKPEF9DK8+TCcexao5fkv09NM6ZQ31b+q5pwDkL0ruc5mwaeVgvHm9R5qHFHAsEhrEiOhRGR3L3b3Vemga/c2UP3loTzMzP7BZzs0OU+Kw5Oqj29RJBZNj4/wRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex9diXqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex9diXqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14C11F0089F;
	Mon, 12 Oct 2026 05:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782770;
	bh=dViWFPpFiAF3tzQW59aK+92FChCqEHJ66gqb0/wk09c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ex9diXqMQjvqLrY2tCoZdazYRWKQ/9BPafwGD4I+qLXmK2k1M3tzBSRyQ0dPAr1oP
	 i3AxWj6TK4nWQyz5tJ+/kG3vVvQQA7/PXqsrJsqd+AbkiOtvD3IEqMfxbA7GhcAhLB
	 3h+04x7La6GWd7Ei7L17buoh4eOpE2otYducYGjscXnPsnw9BZm5joXG/qsuCgGadD
	 8PvJatEra/c7zMZaIVitQ5G1bDRJojwIK/rCFw6Jg1U85M8qKgZ4iw0+KQVTafEHyq
	 COpbKgNG86WIsT6ONWq1E3760wBnBrPj4+qoTizFvFfDJd8d/AElcdPt9qRkuOTUjN
	 EFBOuD1MpeG0A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 05/10] perf symbol: Get rid of machine_or_dso_e_machine()
Date: Sun, 11 Oct 2026 22:25:56 -0700
Message-ID: <20261012052601.13920-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
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
2.55.0

