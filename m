Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D03A71AA
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438418; cv=none; b=cEGmygBFY93/Aq4vTfe/fsY4f0//1e4RH8SugVx39Csoi+RxK6S/gecx6DG55ukDjWcx8NNWB3uDeO/ygDYZAx2a9cBF7UGL1Z083I9PmAZeeSamTqZC4ygbml+t64Q5rvbpvwRWygN3n9GskDR8aO/BlYMjguphKUrNf6GX85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438418; c=relaxed/simple;
	bh=V5zoyHXxdIR+FWIdUoJu2SfIXA209Z5txBT1C4guMWw=;
	h=Cc:Date:References:From:Subject:Mime-Version:In-Reply-To:To:
	 Message-Id:Content-Type; b=rAJzv9gIzBL9dBqgAVRgyDIGvX1ZAA0FtMSIpbN9Rl7CrDqbQC7h5iyHkwgI6ZvUBcpdLnDHDyZcrQKHDMaiuaY02wKHB09EKV0jnpPg/5l+Bqff4wcsT9exuqQjHHgJ70Xmj7uzfZx84JdJp0aw2Vzrf9+I38OMYZz9cuvc88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g/3Jjgu2; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g/3Jjgu2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779438406; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5Iu5XnqSFHndFk0JX8U3Pr0e2xZYS221KCy9dvuonq8=;
 b=g/3Jjgu2CTjOEl/1sUCu9AO9W4XL1n5FKoWle2qxa0WTjXIR+75elX5wPFvX36znxMGM60
 syk5I4TZkQI8nSi6QbRzCM63UeCVSP82nojdfFta1uXLKdgJ7Xm+WL90TZxUf4Kw8mlz/p
 OwxRqNOuEze7cXhpo+t2TMfE9JWs1sruQk3N4MTHFe++98SCNbJz4O7+VAtNsT3wlxdFne
 ZYf1U6O8GdTqFvg/kc8DjuSLI87nLobUF8crpxfww8zyWTIcDihfJOVBNf0D8FQCVocXsH
 NIqDqXJKuzU5cH4T8fuz36mLohDGaSmutaxLouWLouXrU+bihBu+IoibysySWg==
Cc: "Mark Rutland" <mark.rutland@arm.com>, 
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, 
	"Adrian Hunter" <adrian.hunter@intel.com>, 
	"James Clark" <james.clark@linaro.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
Date: Fri, 22 May 2026 16:26:04 +0800
X-Original-From: Rui Qi <qirui.001@bytedance.com>
References: <20260507071103.2772577-1-qirui.001@bytedance.com> <20260522082604.89447-1-qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a101344+a54306+vger.kernel.org+qirui.001@bytedance.com>
Subject: [PATCH v4 2/2] perf: Apply is_ignored_kernel_symbol() filter in ELF loading path for kernel DSOs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260522082604.89447-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
To: "Peter Zijlstra" <peterz@infradead.org>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>
Message-Id: <20260522082604.89447-3-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8

dso__load_sym_internal() had no filtering for .L* and L0* mapping
symbols while the kallsyms path already filters them via
is_ignored_kernel_symbol().  Add the same check gated by dso__kernel()
so that kernel ELF objects (vmlinux, .ko) have mapping symbols filtered
across all architectures, but userspace ELF objects are unaffected --
'$' is a valid prefix in languages like Java and Scala.

The existing ARM/AArch64 and RISC-V architecture-specific mapping
symbol checks are preserved; the new is_ignored_kernel_symbol() check
adds x86 local symbol (.L*, L0*) filtering and provides unified
cross-architecture coverage for kernel DSOs.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 tools/perf/util/symbol-elf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7afa8a117139..77e6dcba8fda 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1592,9 +1592,11 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		if (!is_label && !elf_sym__filter(&sym))
 			continue;
 
-		/* Reject ARM ELF "mapping symbols": these aren't unique and
+		/*
+		 * Reject ARM ELF "mapping symbols": these aren't unique and
 		 * don't identify functions, so will confuse the profile
-		 * output: */
+		 * output:
+		 */
 		if (ehdr.e_machine == EM_ARM || ehdr.e_machine == EM_AARCH64) {
 			if (elf_name[0] == '$' && strchr("adtx", elf_name[1])
 			    && (elf_name[2] == '\0' || elf_name[2] == '.'))
@@ -1607,6 +1609,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				continue;
 		}
 
+		/* Reject kernel mapping symbols for kernel DSOs only */
+		if (dso__kernel(dso) && is_ignored_kernel_symbol(elf_name))
+			continue;
+
 		if (runtime_ss->opdsec && sym.st_shndx == runtime_ss->opdidx) {
 			u32 offset = sym.st_value - syms_ss->opdshdr.sh_addr;
 			u64 *opd = opddata->d_buf + offset;
-- 
2.20.1
