Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A240035E1CE;
	Mon, 13 Jul 2026 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975631; cv=none; b=ekzln7Ju8OewH7D4W4ghCPtPv9BXSYomUBj+rdGGP4nsktYdzydTFFIrqtA9Hdw5O0jT6C5QbugnLZTgbZoFxvYUuFcbWqM3QlsHoehEpz4kuzYkofzewaL10haY8PqIj1wRgoXMJkCWLj4Uh3cBKpladmJ6OYzvYYWemKuDKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975631; c=relaxed/simple;
	bh=uAm7aV1232k1GbDk5BfkOCfchIpYo/r3EmBcrbyDowE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrTadeAwxz35uBZ+Kdew82a7Kr99QAg6E4quPBK+znQ+P8ddwQqRx0KkykFZiTZZlwJJPAgGZWxxybjJlA22EAa6KMIRol33KAeM8ZtV1N/A7p8SteLIFPwhag6QmEt7VMcXHISh5yI9mVEu/P8AimKbzGQEQvtTOmomPV3XFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFP8VP5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFP8VP5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12B11F000E9;
	Mon, 13 Jul 2026 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975630;
	bh=7IsAFAA5xB5ZeMMltaHC20cdEr1tS2ZD6SOZo+gxkOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LFP8VP5OrK7kfX+vFcxaShV8Q6sTh9zqSSf2kICdqn50MS79ASmSjUZiT0J2szQLz
	 eM5HrkewwyLRG+z8V5HRD+Se1O9g0pi7jqXIWI+XV5tdin3HhBGox3KGE6ZXIBDjgj
	 3n7kmf3uC3kIteUfSOS+j4Ie3HemyEEfnB4uTejhLnP/RqHMcCslOR2tnaJLSXX+Jf
	 m9vFun9SXv5ctpZw6t/rtH97sNgQulEQjHBeP1kg1905JVdBnxxtgNi8t37O58HQtI
	 Gf0fJrdUQD4PRppkmTx/mEIxLFyY9gI/iiHOXmj9vs3WTi9GJZLPynDDm4P1DkjnLb
	 Qk9/7LNhV00SA==
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
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v1 1/3] perf sched: Add missing perf_session__delete()
Date: Mon, 13 Jul 2026 13:47:05 -0700
Message-ID: <20260713204707.2181098-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260713204707.2181098-1-namhyung@kernel.org>
References: <20260713204707.2181098-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf sched stats record missed to release the session and ASAN
reported a leak.

Fixes: c3030995f23b ("perf sched stats: Add record and rawdump support")
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 6e0d8f4d270e2d88..68147a0be5c710ed 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4027,6 +4027,7 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	else
 		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
 
+	perf_session__delete(session);
 	evlist__put(evlist);
 	close(fd);
 	return err;
-- 
2.55.0.795.g602f6c329a-goog

