Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1B3F0ABC;
	Wed, 17 Jun 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700371; cv=none; b=bUo4TWdg6wVK4hvcWK8fEr0PvSYM5I0gwgwh46K71Jiw7d1cPhwIcFR8ScBHMbBPM08qawxx/omW6EaKw5L5EgDJHi1eacZ9iJ+sHo81/mtTOEP/5UEwnBiPxB6noZiehJ7U1fb/MD7a+mfItAi/MqdnOSjS/cM4qoaI+U9LNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700371; c=relaxed/simple;
	bh=2gY8GbUStY6qciNwMPf3gST6/L/mnKc2KkCP6ycsktQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctZYE5nIhZNzdFmXGLbPX25IpXYFWPJzgbmPmh6b5JvlMupXfQ1AMMgL136Ij48MymckAVlNLfvGxVqqGcXlki8yu+zfvVnl6IeFx2ssCtt9tBVTabWerbDjZeXVOgYZuM1oHh1WqN3wMLd1u2WgCskPp8few5XyZa5A4ldPsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR029Bhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR029Bhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C901F00A3A;
	Wed, 17 Jun 2026 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781700370;
	bh=RM8E3XsXssu/MYfXJpqe+4jGb3DAZT+1m4WOzPUwWiM=;
	h=From:To:Cc:Subject:Date;
	b=CR029BhdcVDX0wTkx8V4kEMnzs6ODEqRgM7eyHh+6ne9aOP1iAqhJIWKmhwVJu1Qv
	 RmuONaSlqZiWPWnENbWfPwGpR8jzpsXPEFsRSe1D91nj2sPNc0KKnpkAxTg3HSRcge
	 JBbcSRdwYIrCRMFZAhdK1dCdXYitwYElj0IRQVfQCf7y5DMizyF+sU7gO/rGwIQleV
	 KqOfRhvoWY9iv6aDI2wELlwCh+Clp0NEQIFZ+J6nHa9YazyRf0i/UUXoYAhA4CjLBO
	 J+89qIlI+8G2XD/ON5+1iN3S/SvhyQUTFUjihtVJb8trx8J6QlBX2w2BFaHFVvklmV
	 G636ziuAc2xxQ==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] perf: Fix up build failure due to bpf changes
Date: Wed, 17 Jun 2026 13:45:54 +0100
Message-ID: <20260617124554.33182-1-broonie@kernel.org>
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
cc1: all warnings being treated as errors

by making the variable the same type as the function.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/perf/util/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

