Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E611F3FF4;
	Thu,  3 Jul 2025 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507386; cv=none; b=Gjm762/iRXP4EPf519YQNeU7sbHTysq2S/qJTSRXzcZGBOqH18qi2Ms4gRFstTXKPw9PrH2fNTTFND/l+oFvR+dAyUKhmUlgLZX0d7wjLzD0SuGOIztWLsxFUJx7zMKYWhaKNQNXxqOltNeVp955yIcaTcDq1qp8j9fpo05LbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507386; c=relaxed/simple;
	bh=QCu94DjYUjiUtTZcW4yZqzI5SrvSiYnBT9kSKjn/EJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLdwBJ8wv/R7ggl1LjbtiolUD2CePsO8kZlcUpSN+49xniJ71sXsp2KKb15DF1Tj8tPgWMcsaziz7d9XQ/p75i8YEBILaA5QucsjVoWwC+VUSNmz4Vf2WOQICDwd2EuMm9sU/8UPGoVDcH2GoIv3oqKfXn8sWcUMlu7WOZ/KQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCSI/dhW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCSI/dhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390D2C4CEE7;
	Thu,  3 Jul 2025 01:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507386;
	bh=QCu94DjYUjiUtTZcW4yZqzI5SrvSiYnBT9kSKjn/EJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCSI/dhWVYf1M4Sve90pJAh6H2QgS+iMkDg8UvgTOK/zfdlRH85y57AGJNqOoOATw
	 LYPXRIETYoWk7Gd4p6l9LGtLkDqmJk9HtEG7kIKP8vrWMrN1IzqbnODa6W3tfCwlCW
	 NS5/6CZ26/kfImH7NpAz/WFxaIm7GwEmTArQngEZ2BT3vuEU4MgcVLGz2P52JRwFwA
	 92kMVPmbjErMcERsdAWq6/lbKQa5naT2x03vby6LZ0LUdXaYiEd5J+mgtYXjnL2J6m
	 MizK0RxR2hLbavFToP9zRkgJFWDEzztffbPhUwpmHNZ1WDrnNSjKJZUd7973oDUMJd
	 Ir6B8NEljN3xA==
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
Subject: [PATCH 7/8] perf sched: Fix memory leaks in 'perf sched latency'
Date: Wed,  2 Jul 2025 18:49:41 -0700
Message-ID: <20250703014942.1369397-8-namhyung@kernel.org>
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

The work_atoms should be freed after use.  Add free_work_atoms() to
make sure to release all.  It should use list_splice_init() when merging
atoms to prevent accessing invalid pointers.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 087d4eaba5f7160d..4bbebd6ef2e4a791 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1111,6 +1111,21 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
 	atoms->nb_atoms++;
 }
 
+static void free_work_atoms(struct work_atoms *atoms)
+{
+	struct work_atom *atom, *tmp;
+
+	if (atoms == NULL)
+		return;
+
+	list_for_each_entry_safe(atom, tmp, &atoms->work_list, list) {
+		list_del(&atom->list);
+		free(atom);
+	}
+	thread__zput(atoms->thread);
+	free(atoms);
+}
+
 static int latency_switch_event(struct perf_sched *sched,
 				struct evsel *evsel,
 				struct perf_sample *sample,
@@ -3426,13 +3441,13 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 			this->total_runtime += data->total_runtime;
 			this->nb_atoms += data->nb_atoms;
 			this->total_lat += data->total_lat;
-			list_splice(&data->work_list, &this->work_list);
+			list_splice_init(&data->work_list, &this->work_list);
 			if (this->max_lat < data->max_lat) {
 				this->max_lat = data->max_lat;
 				this->max_lat_start = data->max_lat_start;
 				this->max_lat_end = data->max_lat_end;
 			}
-			zfree(&data);
+			free_work_atoms(data);
 			return;
 		}
 	}
@@ -3511,7 +3526,6 @@ static int perf_sched__lat(struct perf_sched *sched)
 		work_list = rb_entry(next, struct work_atoms, node);
 		output_lat_thread(sched, work_list);
 		next = rb_next(next);
-		thread__zput(work_list->thread);
 	}
 
 	printf(" -----------------------------------------------------------------------------------------------------------------\n");
@@ -3525,6 +3539,13 @@ static int perf_sched__lat(struct perf_sched *sched)
 
 	rc = 0;
 
+	while ((next = rb_first_cached(&sched->sorted_atom_root))) {
+		struct work_atoms *data;
+
+		data = rb_entry(next, struct work_atoms, node);
+		rb_erase_cached(next, &sched->sorted_atom_root);
+		free_work_atoms(data);
+	}
 out_free_cpus_switch_event:
 	free_cpus_switch_event(sched);
 	return rc;
-- 
2.50.0.727.gbf7dc18ff4-goog

