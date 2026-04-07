Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C43793C8;
	Tue,  7 Apr 2026 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591520; cv=none; b=Qr9DAKMOHViWYLDDnY8Gb09bN8HWEcEqGnfaTPBSpTmKM8RDnGbyvO9LNF0+ydtVTfDoS7T4E5wW8IvujTipGSIBHUnxQ7X57WHeFgN4oLNUueXfhFU4AGB9i9VoRkgt9QXknDxRHpG455yNaRDIsTs0g7UwpZC7xAqIttBezSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591520; c=relaxed/simple;
	bh=EShclxNu6pRrud94k4SQiZ8VTYXHzEfH6c2jhDarHLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYY41ZfZTDLzSyUD7V407vqae2STMFsEt7ZKgv8JXnPg1TKZ2IBQlmStrvvER+ELTT46Qti67Up8xB7T3nB0E3udT3d7EdConoby0gTGMgxeMog0fVNumP/p1gj7Z4QZQkdgFLVSBXNbFLvorQc6my265bjP7Le/K+wF1wpyvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcMco9rA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcMco9rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF2BC116C6;
	Tue,  7 Apr 2026 19:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775591520;
	bh=EShclxNu6pRrud94k4SQiZ8VTYXHzEfH6c2jhDarHLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcMco9rA2vLQnBCBcUGye7oxiOLUDAoqLQRUMiHoDuylx00201qzDOsKgF5Ug8x9O
	 hqF2EpxobTPn03bmVDrleninUEKhv7ZZzUK8Gtu/4HG0ytI/O+X0n/eKdrS4zeJ3q0
	 /WRXZDyLDmugeSPfK4Rsq6r6znLa/A4MUezW4KhYh7eDyX0XHnopOYOteJ6dDtZQvl
	 z1Enml/Gp0gMxM8tLh/Qs4ZDWKuJYDnQQCO9G+Q/5dpVohkz0sqWBML/tgaznriqQk
	 aZ1RcoESWpyuWlwGQ0MAir0PA1nlDdMJZJSbQQsU1SXvxMjkY9q7iyuzBtNipg6CvB
	 Sg9Pj/8LpW6jA==
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
Subject: [PATCH 1/6] perf symbols: Make variable receiving result strrchr() const
Date: Tue,  7 Apr 2026 16:51:40 -0300
Message-ID: <20260407195145.2372104-2-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407195145.2372104-1-acme@kernel.org>
References: <20260407195145.2372104-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Fixing:

  util/symbol.c: In function ‘symbol__config_symfs’:
  util/symbol.c:2499:20: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   2499 |         layout_str = strrchr(dir, ',');
        |

With recent gcc/glibc.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b4b30675688dbda5..708375d67b85fd1f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2492,7 +2492,7 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 			 const char *dir, int unset __maybe_unused)
 {
 	char *bf = NULL;
-	char *layout_str;
+	const char *layout_str;
 	char *dir_copy;
 	int ret;
 
-- 
2.53.0

