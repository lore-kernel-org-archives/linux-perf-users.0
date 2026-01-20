Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56153BBA06;
	Tue, 20 Jan 2026 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947082; cv=none; b=WnLIEizKB8IN1n5glV7cHKThZqGMhZYpOBXMzITtX3JZk4jFsDsP5gOEYoS2P+IHd9Sa/NJa9AnhfHPQFlT4h+KXSBPW8IPGQPQiQ4kqByNwzublhM8EtewZE5c4L1MA0rfuLRc2CQ/8GQ52Qh/XCvJuLxyU2ihrYsNxGkt0Qjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947082; c=relaxed/simple;
	bh=2D5vgF6AZ4BggNPQLEURklEG7352xqjAuCBH4p2jCOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orOqXh828FWEPQRQtGvWWGNiSoJ9xp8rRqp7t7wHe5U08P3B4lb049YBkGTHvhlncoYn5EfZQpbo7tNPL/8k+TUDD5Ovn9SyWqqMR7lKCiLTCCd/j2emGumHggcGNuT4KXOSxTz5WW+pWpsAG6Va++St7M27P0XM6mAAlQa24hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjF99C07; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjF99C07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FADC16AAE;
	Tue, 20 Jan 2026 22:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768947081;
	bh=2D5vgF6AZ4BggNPQLEURklEG7352xqjAuCBH4p2jCOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjF99C0737vAQhpqBsqvZACvdS15L/5I7a5zYf2seQUICFrTfbqGhEU7LezUf7XKj
	 q28DbwYc6D5hQYTDehKie+6RnhS018Sst5vSt2Ff0+5/3EMeAjVPqSi41/DYR0Wobz
	 lcLXHOOR4PqvwUhQeJ9YB6/949pqBgmUH654jE2tS4kNy517Nvkh9MWOZ4XTq7ieJt
	 41aOFUDOqUGfALyAfTZDBFnT7mEh+Bv6rVvarxIpLUcVfPTbZO2o5UrdOfkBodG/q3
	 7Lqilsp2Hl5UfFS+8+El3raOKe0QCOb36RBFOfcFDbE+TFbSWp1sSzggI8UmM1nChu
	 lJDZa6N+uzMoA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/4] perf trace: Deal with compiler const checks
Date: Tue, 20 Jan 2026 19:08:58 -0300
Message-ID: <20260120220900.366451-3-acme@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120220900.366451-1-acme@kernel.org>
References: <20260120220900.366451-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The strchr() function these days return const/non-const based on the arg
it receives, and sometimes we need to use casts when we're dealing with
variables that are used in code that needs to safely change the returned
value and sometimes not (as it points to really const areas).

Tweak one such case.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 58a32adafddff7f5..8df5ca44e4f91529 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5190,7 +5190,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	}
 
 	while (1) {
-		if ((sep = strchr(s, ',')) != NULL)
+		if ((sep = strchr((char *)s, ',')) != NULL)
 			*sep = '\0';
 
 		list = 0;
-- 
2.52.0

