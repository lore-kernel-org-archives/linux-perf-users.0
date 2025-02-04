Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A18204F9B;
	Tue,  4 Feb 2025 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706769; cv=none; b=qpuZutsygK0rE+Zs41yWME6m6MBNXGsYNDDIrV5xliPB/smI2zYO63QsPaBaWfBrF+nnZcluKa1wvh65OfhfQeZMJLuso06PoEyL0RK9buEveJu4Ys3cP0qciqCUNPxTf8BZu2dwacqu4vKBGV540neDXqT9QPoh8m2WIThWFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706769; c=relaxed/simple;
	bh=VxDhPrT+HEja1iMpSqKbmt39s6MisQxh39e0g7u5lUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jszgxfBklhR7pDjqth2Gq3On7Ls2t06ndixOwfGLJrfghLC/AMpQavUxZ+pLx2L5SH6RrbPOLmXSHbb1uCtsGnj1FAIRi7KhZ/lyQSre5T0FUXzF/YyE7raafenyVKKzQPFGHioabDqlNXUCA7WPXYqEseS5di4PngXqolWMnsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eNiGNKfv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eNiGNKfv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=cjRPmO318o0QM4HZgBJKyI73yAH7m/wyY/u5sUKuQ+c=; b=eNiGNKfv21bKpgEO
	mjy9asILz2wHBWQLG+/umz4dsv/p8to8o0u7R0REaZhaFSZ3dCNJN8/W1S0AHXmFB8ie9dwYiGJFm
	91g/QIk60sthKRdT7HVmcj1jv4z7pw2h5NcbzC0171bPbB7YqSt+JN79Mlg8HCyuCqGdNpAbVefFL
	sBW8ZEt24JaYnteydwEjpVVbMXXRMpNOp8hgJgrW0nkdXBpvICznR//E2An9JGLlxCLAVoG3LydgB
	IIDcjNQtTdW07TlFlssvhyczt/FrVkDQr98yKXjNTM4lZi9HV5/4JaI+w85R/ZQqpFgy7dswjBKAU
	rAMT+b0sLlWFRkDi/A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tfR3C-00Dbvw-23;
	Tue, 04 Feb 2025 22:05:46 +0000
From: linux@treblig.org
To: irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf: Deadcode removal
Date: Tue,  4 Feb 2025 22:05:45 +0000
Message-ID: <20250204220545.456435-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of machine__fprintf_vmlinux_path() was removed in 2011 by
commit ab81f3fd350c ("perf top: Reuse the 'report' hist_entry/hists
classes")

mmap_cpu_mask__duplicate() was added in 2021 by
commit 6bd006c6eb7f ("perf mmap: Introduce mmap_cpu_mask__duplicate()")
but hasn't been used since.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/machine.c | 20 --------------------
 tools/perf/util/machine.h |  2 --
 tools/perf/util/mmap.c    | 11 -----------
 tools/perf/util/mmap.h    |  3 ---
 4 files changed, 36 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2d51badfbf2e..321cc110698c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -886,26 +886,6 @@ size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
 	return ret;
 }
 
-size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
-{
-	int i;
-	size_t printed = 0;
-	struct dso *kdso = machine__kernel_dso(machine);
-
-	if (dso__has_build_id(kdso)) {
-		char filename[PATH_MAX];
-
-		if (dso__build_id_filename(kdso, filename, sizeof(filename), false))
-			printed += fprintf(fp, "[0] %s\n", filename);
-	}
-
-	for (i = 0; i < vmlinux_path__nr_entries; ++i) {
-		printed += fprintf(fp, "[%d] %s\n", i + dso__has_build_id(kdso),
-				   vmlinux_path[i]);
-	}
-	return printed;
-}
-
 struct machine_fprintf_cb_args {
 	FILE *fp;
 	size_t printed;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 2e5a4cb342d8..ae3e5542d57d 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -266,8 +266,6 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid);
 int machines__create_guest_kernel_maps(struct machines *machines);
 void machines__destroy_kernel_maps(struct machines *machines);
 
-size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp);
-
 typedef int (*machine__dso_t)(struct dso *dso, struct machine *machine, void *priv);
 
 int machine__for_each_dso(struct machine *machine, machine__dso_t fn,
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 43b02293f1d2..a7ef4d8d57d8 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -356,14 +356,3 @@ int perf_mmap__push(struct mmap *md, void *to,
 out:
 	return rc;
 }
-
-int mmap_cpu_mask__duplicate(struct mmap_cpu_mask *original, struct mmap_cpu_mask *clone)
-{
-	clone->nbits = original->nbits;
-	clone->bits  = bitmap_zalloc(original->nbits);
-	if (!clone->bits)
-		return -ENOMEM;
-
-	memcpy(clone->bits, original->bits, MMAP_CPU_MASK_BYTES(original));
-	return 0;
-}
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 0df6e1621c7e..4d72c5fa5084 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -61,7 +61,4 @@ size_t mmap__mmap_len(struct mmap *map);
 
 void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag);
 
-int mmap_cpu_mask__duplicate(struct mmap_cpu_mask *original,
-				struct mmap_cpu_mask *clone);
-
 #endif /*__PERF_MMAP_H */
-- 
2.48.1

