Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE8E555;
	Tue,  2 Dec 2025 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716495; cv=none; b=EiMODrXXEYdT4Gov7VIkAe9qiq3dbzfQ+MLDMYCXNncRdgBHn3fEIxpdw8ZHax7a6KjYF597MjrWxkV0tlwSgfLO9NBwT9jCUcvOEQ7xf8NdD8lTnuyY8rLsAlNQRZhEl9IRJVP/KUrEIdUJgEfgUGyP7qdq8wWVYJzA61UuMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716495; c=relaxed/simple;
	bh=Yo0fNFcFXliIgj8HmzD8R5vWupI9R10UJpq6shCL6ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5dlzSfB4WL6qZFCXfTRmcegYuEvxrrEUdERGgcwQF4sLbnOutih4PKy9clhgHbRynRdYWGpN9e1XQXkSInIWSHZIUBD1jdZB16/PRyBvi/yGp7E17NDzzLPaNo5kAWIQhfrI4KkLv5O25v2N5ubcU3PU08PxS9FDyZHXvEzqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js3XXOk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js3XXOk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67BAC4CEF1;
	Tue,  2 Dec 2025 23:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764716494;
	bh=Yo0fNFcFXliIgj8HmzD8R5vWupI9R10UJpq6shCL6ZE=;
	h=From:To:Cc:Subject:Date:From;
	b=js3XXOk5QAkj9svhznYJO4A0ndzJ20BGmA3TFcFVtmPidrr+DG2Medl1kQ1PvJh6/
	 cDD3uCimJXcEFxflY/UeWY8ScRCSrFzw9jaT+UyD+1YHAiORWAalPvY13y8kcVO1SM
	 eEeMiLx/5x2eeajpjGx6tnbhpZ/f+3dM3/Rsd8mCS32rVxdyBIuHcUcuXcZ0A/+i1H
	 XitQdfcxhVVJMvpbdHhdrVUFfo9H38pKecFQJxBnjX/Lm2icM61RnsMfd/51EWtQPY
	 AU9P8ruIRQLJeAaFsT7ckDpFY85i71fXQhu0R4J3VtTlqc6NVUzLo1ZGp6o/hHkWfx
	 UOD6VvM+eeQWQ==
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
Subject: [PATCH] perf tools: Remove a trailing newline in the event terms
Date: Tue,  2 Dec 2025 15:01:31 -0800
Message-ID: <20251202230131.998662-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that it can show the correct encoding info in the JSON output.

  $ perf list -j hw
  [
  {
          "Unit": "cpu",
          "Topic": "legacy hardware",
          "EventName": "branch-instructions",
          "EventType": "Kernel PMU event",
          "BriefDescription": "Retired branch instructions [This event is an alias of branches]",
          "Encoding": "cpu/event=0xc4/"
  },
  ...

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 1b7c712d8f9902bb..956ea273c2c7805c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -645,6 +645,8 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			pr_err("Failed to read alias %s\n", name);
 			return ret;
 		}
+		if (line_len >= 1 && alias->terms[line_len - 1] == '\n')
+			alias->terms[line_len - 1] = '\0';
 	}
 	alias->name = strdup(name);
 	alias->desc = desc ? strdup(desc) : NULL;
-- 
2.52.0.158.g65b55ccf14-goog

