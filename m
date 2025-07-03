Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769DD214A7B;
	Thu,  3 Jul 2025 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507387; cv=none; b=apFMHeTJyaCwfl6reQMkUmMe0VMaw8wR1ydoRWg8X5+iFSYYyQ4Em7OyvVEu/QhAa58Ut4/lPP25JNimvryX/5a/1GO6wDkZ1JLeEdpnosLI5sznRTPGuo2x7oKL9VSwCTku/eEfGvhGz05W64FLbUQe9+huqhADJuYEpbbkeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507387; c=relaxed/simple;
	bh=qV50sNpmeQ+z4VHzK7ckgYbxgB6pDIXg/c1TlYYcuLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Au6Pdr2aH8vHy/Ac/puVWGITVqXQoAgHyZz3mNL8iax7HVAkELuvb0d4Sw6KomxQJ9V3BlWsGSVNzdzwl0mXMyz3PgYA8X6n0YT0j8LdFWCwz2rTVerUz5Zxve2QUbaQRAdWUEvdNlKU1AoQpgz5+sEyzWyx5Qt8knFe1mVuldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcQv0sHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcQv0sHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3EBC4CEF0;
	Thu,  3 Jul 2025 01:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507386;
	bh=qV50sNpmeQ+z4VHzK7ckgYbxgB6pDIXg/c1TlYYcuLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcQv0sHTsdAz3whlyscoDezIa+gypvgDAxztngAUEdKWHhdk6kzq/Hqs2UNWlJC95
	 eGlEPBU6imwAhOW8/cs6KyK6Yd1EpM0BiU2FYfxD8/psRSLtun+cR9DG4sLzIzaaoO
	 tiEnbds8Nmz2qU/Afp8p6vmFyghKhYYUjLLdUXWDJhfLjkT08/T7VPVIXaZ87KAMqI
	 KhXEGS6khkAWSFbABw0PcQPR+tpRIrtsNYDFPU4MB67tbnBx1C6sZPuTgULR6pzjPQ
	 f0On84tKwFe7accZ64iluR9JTli3RwnbZmfzjYepge7aW/Sos4bju6Zz7ZgoWvnA24
	 DFSNuLZ1SznDw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 6/8] perf sched: Use RC_CHK_EQUAL() to compare pointers
Date: Wed,  2 Jul 2025 18:49:40 -0700
Message-ID: <20250703014942.1369397-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250703014942.1369397-1-namhyung@kernel.org>
References: <20250703014942.1369397-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that it can check two pointers to the same object properly when
REFCNT_CHECKING is on.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index a6eb0462dd5be20f..087d4eaba5f7160d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -994,7 +994,7 @@ thread_atoms_search(struct rb_root_cached *root, struct thread *thread,
 		else if (cmp < 0)
 			node = node->rb_right;
 		else {
-			BUG_ON(thread != atoms->thread);
+			BUG_ON(!RC_CHK_EQUAL(thread, atoms->thread));
 			return atoms;
 		}
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog

