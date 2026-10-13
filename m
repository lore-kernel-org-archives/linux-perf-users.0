Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97A522EF3;
	Tue, 13 Oct 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912120; cv=none; b=Xg8x8FYNh4v3TMunJNFsPf2QTJkqcUvq9zFzNDJ0CtMeLwQCpqVZQ30qHcg+gZhoEG71rmqNTnexgmNpQh03VwGUMyyPP0dEIFQkwn4L3SlQlLlIGzkkaohVoo3v3ngdu2p7O5s7Kwi+6ozuhHCq8lutkRhp3AgaEG0Q77qHX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912120; c=relaxed/simple;
	bh=oMmNREBvVmBO0/mEPJUg9On1yLv01/4+ACmr7DvrnbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vukx3fkDEK1yhGdzwz9FXD4bvMbfXCjYJxJnSgtQO473Fe2Ay6A2M7VTWFye8cKYT7/tbREWX6Eho8FHFvFk4gAR6CN41VcG1ExScPzOGmc4HcnrHpZtxVLiQORfkC4yRV606/W56c2tZFkJebMbzkkGPq2YIg8CorswCr/qJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jit2o7/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jit2o7/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA0A1F00898;
	Tue, 13 Oct 2026 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912118;
	bh=j5QiqEgvgLVvNmfVIL+5I/L7kDNsnJsFEC8hvU+v54I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jit2o7/DNKJ/GXvG+3Gp7aty94JCHP4n/H9WDDsC50lgxGVTrH2vGwBvibEupHn6b
	 4e5iuyH3b8AWZAVI2ZioPAiRhYwP4BGNCl6ACpnxyLHXLL63k+pSdV17PudDIhjOC8
	 mU//SLcym2PEcF7EgYRP932ETsFf3jZhHGYz9Z7PaekCNtG66jPw1OxjLVyqyTghWL
	 Wmc9HP09EKDWtA5cOnLb3QYgfyUrE6/BgC7XthnF2nCxTuAnaS7ku8JV9UsZH/Q+2/
	 ObCj5aNuhkLXvzZiLZy8AFQtuL9+Q6nY3ClIMknND8pLTaoJmbAtC5v0sEUhAGqTBR
	 mvrJ5lw4iP6EQ==
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
Subject: [PATCH v5 02/11] perf tools: Check ELF section type with name
Date: Tue, 13 Oct 2026 10:21:46 -0700
Message-ID: <20261013172155.160869-3-namhyung@kernel.org>
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

In filename__has_section(), it just checks the name of the section but
it's possible that the section header is present without actual data.
In that case, it'll have SHT_NOBITS type and can confuse the result.

Update the function to check the section type as well.  Normally we
want to check if the section content is present in the file so it'd
have SHT_PROGBITS.  All the current callers of the function expect
the section with SHT_PROGBITS type (even for debug info).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol-elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e955c3feddcd62d0..1e2716c6af45712a 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -228,7 +228,8 @@ bool filename__has_section(const char *filename, const char *sec)
 	if (gelf_getehdr(elf, &ehdr) == NULL)
 		goto elf_out;
 
-	found = !!elf_section_by_name(elf, &ehdr, &shdr, sec, NULL);
+	found = !!elf_section_by_name(elf, &ehdr, &shdr, sec, NULL) &&
+		shdr.sh_type == SHT_PROGBITS;
 
 elf_out:
 	elf_end(elf);
-- 
2.56.0.385.gd3acb90ef8-goog

