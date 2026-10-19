Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1448594D;
	Mon, 19 Oct 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389224; cv=none; b=ThBAqCCqCtohJRfvsUFeOMth79jTYgjk/MFWNUcAdL+cicbTxeKHD+/LdAVBXLmNUcX3FW1pk25inrdwE30VMn9x5xEzsMkl/rFYgMzEsfcsZNbUl+LvacNS+VnJGu0kkhIPX7G7WkWw+4btwi5pwj4wRO2O8KxxUukGpSHmCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389224; c=relaxed/simple;
	bh=CO0qiiLzqINzhsjxwW01tyuZdoRqmH2UicEKiWD3+sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDm31WVEfKOT8VfWywlpaVAPQjRQVn47NySC/8wVLisTrjfe8nRdKxe52khLUlUvNGhVsO1228zZnKiZcLL0X5X1CqmpQwGhG2HWOXvzwGxjsvWQcxoPtJy5YUJTe+cP86Zcg8JB+2+0eBuhfbcdewAQyL1D3cOUmPDWSkvX/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyZUht/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyZUht/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF501F000CF;
	Mon, 19 Oct 2026 05:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389136;
	bh=Svp4QLHElgqe4ZARoRoAb5H/1fPI0Pk/UdQc6mVvJKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MyZUht/bEy160lUIWBhANhmrw0XkI8MsJ/0fkN1wmZY2VsIYWGT02s4ZvwUjzDtDb
	 EGtd7GOGJ90d64lid8tC0lntf2Ve70CqXlv7B6JkuWBHEnSfGxiG8LWfRSBR++At7A
	 CGAfvzbfj5JnrM+eRZGSEzq5j1q61AmeSFwF5aau+TrPzA3RghYEayIOcOMX3rsws9
	 a4Fr5NkF4H9H9Vv81lADTdV2uhwfVlQBkKrIr5BImjGthb81Z2o6keMr+VCXPUMdhv
	 1z4Dkp4lqs5go6bqLVNrJOCI0DGSpTPyrR6i4BwgZTStn/uvYKOtv4braZK9n9r1wO
	 6TToK0ELxIL0w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 4/5] perf symbol: Check result when reading section headers
Date: Sun, 18 Oct 2026 22:52:06 -0700
Message-ID: <20261019055207.39325-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019055207.39325-1-namhyung@kernel.org>
References: <20261019055207.39325-1-namhyung@kernel.org>
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
2.56.0

