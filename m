Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592A3F4100;
	Sun, 18 Oct 2026 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341474; cv=none; b=rTahgZYllyTLs/tQyogvPKWpIlvUAvIFQkaRSGlRtJpgL8I50jXXxG1lpbJQ6o2N2g2/ccszIZzHjFOWVrw8CRSpzCzQOxCE6uFCSr2HmKVgKEoiiIGxjFa8AMR/zYmC6jjcJvWn/ZOuoV370WvdpixFLhTjljmiaouF9Hz1arA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341474; c=relaxed/simple;
	bh=dKYhuoswLQgctKqKYJzS2AUuFaMR02qlG9qayx4UiiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANdkrJ5VuXXlHQAWdZ3R8eBPiUjP9ttNn5tR5F/HyzKQvB5ykR5wfsc9LnU/99H+joHRgAahuDigC81gULnBpW95d/Y7BS0r454lEz2uNkU8DV5XeaU63fbqTZOcYzXTTCnqyw+lPi5Ixc59bAoqdfGo1437amEMC0ixIG42O6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEQATRqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEQATRqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8615D1F000C5;
	Sun, 18 Oct 2026 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341465;
	bh=TTRqC+9annBATm7Nud+6/q2rMOMGEfcPhy9IL/UodDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SEQATRqYnL9zV+Bya3s1NQx3Q9SBibM2iuBHeOXaXtXL4mnrEamazfB3yNzFNpBZ1
	 5lKMAhtqwciqeohQLt+ijo4BnzzSpzA891imElvzPLOp2U8YSZfQO7c3kpiprAbbPi
	 wa6TSrC3xxtUm1BljCgyas6HMOkJQDcrZdjNAC+e8MEKj/OIOIofTLigGR5nCK1Bks
	 ZxuGKho8lGFv4/uoiKP9p9sYmToMjHEMSyW7TIBXFMRS2UZkolHf/B1+LAXiPeo+tL
	 MoW/Hj+R59aSVfw7b2oIpPYnP42uZBjCgHMatZgRUpTlCJwUbeNPC0960A+QV143j6
	 4CSOUScCQqC+A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v1 4/5] perf symbol: Check result when reading section headers
Date: Sun, 18 Oct 2026 09:37:40 -0700
Message-ID: <20261018163741.850434-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018163741.850434-1-namhyung@kernel.org>
References: <20261018163741.850434-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise it may access uninitialized section header struct.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-170233@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol-elf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 1e2716c6af45712a..00ea0e19020fb256 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -196,13 +196,15 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 	while ((sec = elf_nextscn(elf, sec)) != NULL) {
 		char *str;
 
-		gelf_getshdr(sec, shp);
+		if (!gelf_getshdr(sec, shp))
+			goto next;
 		str = elf_strptr(elf, ep->e_shstrndx, shp->sh_name);
 		if (str && !strcmp(name, str)) {
 			if (idx)
 				*idx = cnt;
 			return sec;
 		}
+next:
 		++cnt;
 	}
 
-- 
2.56.0.176.g3575e65682-goog

