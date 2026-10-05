Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4235837C;
	Mon,  5 Oct 2026 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182060; cv=none; b=oeVeg/c6HFD5v7YTPXDP0vb4VJkDf8KsnbxkV+fvERUdZmra5Kev5mbGUNe5ViorLUFGwbdHnui7pf1N1eBJNJ3Vcx7yE1UETTmYhR8JLobm2ndoAcvs7EmCdly0rexeQdz17ddeNtvtI+PBW63uHv15+DwKSTQwxChM2LT8rzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182060; c=relaxed/simple;
	bh=2FSTKbLVedQuCD3pn1ra+g41XUxrwY1C6lZ+yCiJEjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5IgQDyE6pY8MitXJcbybky4bEyiTavAS3WkmhnfC+PKxn5MCwLbTFZpvfbdfxLUNQGbN5uTH9pcnsk6w713ToQPJmT01rGlx5LHKzKfgiKCBd3x7FRlB87EVRS9iGF0VzsCOkOeZA6mcy+Ojj3AN/hPsJxOnfGgePESxxpywg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWaiEf7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWaiEf7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E376F1F000FF;
	Mon,  5 Oct 2026 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182059;
	bh=+ESkVjER986pktI7XdpKJMdzEpupRBe8XcIIgRpPowc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YWaiEf7DwBMid5Kk8AwPQV3sUlFbod5+f/Ss/fty7F+JXG0FsYTlL4YHX8zD47TAe
	 W3dbYvnWdACkuD8YStgWOLhJAGuZz1Ju4BcEM+7Mc8ZcayusLBQqbyc+4UQjwnshOl
	 /VorxkhDebAQ5JAaAOrlPMctpxOYMdzm5ZBZfcK/9huy04iaUJpsN9q2Z1Xr7hDrXB
	 lCXltv/2v+892kgRONXNn26AT5vzTNCxbVIrlfUpl1IuhHNavXSSAkxSCdVe0wI/VU
	 mpUJR1DlAhEKz8RLMB5sZ7YFsp98zEQsZcTAbyfq61eYJTdexrnfAwQZtifnoM+u2Q
	 CDTi+xInF/4PQ==
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
Subject: [PATCH v1 4/7] perf symbol: Set binary/symtab type for split kallsyms
Date: Sun,  4 Oct 2026 23:34:08 -0700
Message-ID: <20261005063411.114244-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005063411.114244-1-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it creates new DSOs for split kallsyms, set the binary and symtab
type to KALLSYMS properly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cf099cbd29f268ec..fc6e4dff282bc2dc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1099,6 +1099,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 
 			dso__set_kernel(ndso, dso__kernel(dso));
+			dso__set_binary_type(ndso, dso__binary_type(dso));
+			dso__set_symtab_type(ndso, dso__symtab_type(dso));
 			dso__set_loaded(ndso);
 
 			curr_map = map__new2(pos->start, ndso);
-- 
2.55.0

