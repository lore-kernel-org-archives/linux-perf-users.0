Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A13EFFB8;
	Wed, 17 Jun 2026 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701250; cv=none; b=KOGyFCQkTu91yl7VXf6vY1R4uyJr4Ngx1nqpDYFpLacpOPG+C48bzxKfQDP7jxm8fB9lngAp5/6okieaqgm1wGqeuSHYWh7zNuOD2a08/aLHqNXM94JkqqWEcahW9e3Ix3GShCn8y/F6dXAzUEE9TsJ+a1lzBvbcIdeCwI7kCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701250; c=relaxed/simple;
	bh=g0FSlxXsIVhds+IwTBdWbk8sKdRl/PUFAtlZUcFv+U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqE9yEeGAo+2cirFl1OBhdOGfJtgfPaL0JKSnAX6qEr8PBjSqwpq4+g3N9A45xzXL0BcQThctX3RdYk4rCOAmdUTDr1qc2QeLE1I3sm5sBrvme4ktHCUFVfKQclO5BNu/ksbTaZ/O6A9I/PGnt7qadQgyRfeGqtYvmVUuMoCODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCsQkdpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCsQkdpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A521F000E9;
	Wed, 17 Jun 2026 13:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781701248;
	bh=e2Ivq2etchOJV7GJy8XPV3qx7YkRHRGPkdtsYpmPAmg=;
	h=From:To:Cc:Subject:Date;
	b=NCsQkdpafIgL4E88Ns50TmWJTA1cF7MZ6m177pOkNkndixq+fdBZB+UL1Jk+53M9x
	 Hzur7da/agPG7XUIsw1yHgZWM7noH1Xgq6rplj0duN+8EPDY3f8mLODhvxfFDr9h6a
	 6emfPLLZyt1SpovVcdJNofBf1yIY/6ETPqYgPIdwZ98eTpA5pAvgfn3ExhDLpvLLpi
	 oBXAnM8O1NHCJj565y+E+Q9vKmbSX+vk4l9BHw1xQ0zdbPEC8hnEZFd5KT+zzy0x3C
	 SPxvam3kRy8c6PRTXtnzRz4stoQPHaX57Y9rwka620S91zsNYMSiUvpTUcDkXAcZfr
	 2Ckf6j3WEfDrA==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] perf: Fix up build failure due to bpf changes
Date: Wed, 17 Jun 2026 14:00:38 +0100
Message-ID: <20260617130038.34534-1-broonie@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

util/btf.c: In function '__btf_type__find_member_by_name':
util/btf.c:19:43: error: comparison of integer expressions of different signedness: 'int' and '__u32' {aka 'unsigned int'} [-Werror=sign-compare]
   19 |         for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
      |                                           ^

builtin-trace.c: In function 'syscall_arg__strtoul_btf_enum':
builtin-trace.c:967:27: error: comparison of integer expressions of different signedness: 'int' and '__u32' {aka 'unsigned int'} [-Werror=sign-compare]
  967 |         for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
      |                           ^

by making the variable the same type as the function.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
v2: Fix a second error.

 tools/perf/builtin-trace.c | 2 +-
 tools/perf/util/btf.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 48615ddccd93a..4b23b82732e74 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -964,7 +964,7 @@ static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_
 	struct btf *btf = arg->trace->btf;
 	struct btf_enum *be = btf_enum(bt);
 
-	for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
+	for (u32 i = 0; i < btf_vlen(bt); ++i, ++be) {
 		const char *name = btf__name_by_offset(btf, be->name_off);
 		int max_len = max(size, strlen(name));
 
diff --git a/tools/perf/util/btf.c b/tools/perf/util/btf.c
index bb163fe87767c..50d98f3e83bf0 100644
--- a/tools/perf/util/btf.c
+++ b/tools/perf/util/btf.c
@@ -14,7 +14,7 @@ const struct btf_member *__btf_type__find_member_by_name(struct btf *btf,
 {
 	const struct btf_type *t = btf__type_by_id(btf, type_id);
 	const struct btf_member *m;
-	int i;
+	u32 i;
 
 	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
 		const char *current_member_name = btf__name_by_offset(btf, m->name_off);
-- 
2.47.3

