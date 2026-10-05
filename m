Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F514353A94;
	Mon,  5 Oct 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182059; cv=none; b=Ehp1kb+KfPMOA8j6ZZqeMx0ga07BhPFvSzO5Tux0QnhgDCJ/754vDsTZuHaXpsjMavnMD4R65IQDWTvgAu9QaAdnygR9UpIZxOzmCOg1BntFPaW1dkKywBqT4v0tqSASdKtqwYe+W+VvQg5SHZLIjIwxnplGu+nkWS/8MjRddj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182059; c=relaxed/simple;
	bh=hndQEYcHder30DOoUFGcwS88f2kPSmrAP4mY62/5lXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHvkWjaRBBuBAUL6FvYkVo0K3SNKEj8Ftn3EVtFbY4iRioryEoHrVHKIPZhDxvwNEzM/dObXVjDEUm3Mh+52KoXctCd+2nEtA3cOMraof15MWxBea2+jS2dqgXApWcGrB6WFZPkj4p1Yogywyznnc8bwiZj9RtCSP3pwOuJH55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGrYXlRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGrYXlRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31581F0089A;
	Mon,  5 Oct 2026 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182058;
	bh=saVrbYaaQK0VBlhPwCo7SQGdhjo4ZNmFSNDAl38qU7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gGrYXlRCDcmJwJnytZP6kt+NiHD1adDfuJ9yYAL+gVMK0Y0DWJIWpFC1fiIGQPxqQ
	 u9b/zpWNG+GIzLQRKOoPcL9Nb6CMx2TpZaznhexoBaCRylnqatclZFRxT1UG0NAJ9B
	 VVYLjcV5a+ooYkeTfIMrNIkBgS0sU1MTyhom0nVvzO6fOI9C0DJTP6QkvMs3PeB0VU
	 k7+b/LnsCeHDe9cAaQEACCc4IMLgNVBmNmr1cyOlimn+Kcx0BrNM+NyLvPMl7J8AcA
	 4t8DDFQGQyJEceautn5kPcITPPA3ae+I8FjF5QqVeEdjuzMukTwpOibMgTFYuWiYQ1
	 OWXaeF4Yv9Udg==
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
Subject: [PATCH v1 2/7] perf tools: Try linked debug files for DSO debug info
Date: Sun,  4 Oct 2026 23:34:06 -0700
Message-ID: <20261005063411.114244-3-namhyung@kernel.org>
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

The dso__find_dbginfo_type() should try DSO_BINARY_TYPE__DEBUGLINK so it
can follow the .gnu_debuglink and find the debug information in the
separate file.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 7f389b913edb5ec7..732c49c8fc3dc1a5 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2111,6 +2111,7 @@ void dso__find_dbginfo_type(struct dso *dso)
 		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
 		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
+		DSO_BINARY_TYPE__DEBUGLINK,
 		DSO_BINARY_TYPE__NOT_FOUND,
 	};
 	const enum dso_binary_type *type;
-- 
2.55.0

