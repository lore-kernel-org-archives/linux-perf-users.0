Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VPLK8ylz"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FBC10DA
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 15:50:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db542ec49d9so1487749276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Dec 2023 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474639; x=1702079439; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMWeTAylF3bUIvrApUeKD5Af/l0nzPxNAdOfQ8ZWtyk=;
        b=VPLK8ylzIs3LTjCvGHt2TOWKY6j5qZOCmv4K5x+D3BP3VeNe+ETocBZMJnW7kS1yll
         y+6h7yhVC1i4z8uHnSxkQNaSkXqru//4CzP2MMDfiP7wCnFg8otITcuVT+FsoH6jUj3d
         2gcrgTVmlUXzYHWf5KFMzj+DORb8qHSNcYBy6xcZdZp/7kfU21r4N1pq8+R/J6W652Hf
         zbo4AEPvP6rgUEZzykB2T/fbB9zIoKZOlLhboNw9n4Sha4rfs3pF0GOB96zqh3W4E4wH
         6RGZiXbOrUjKStkr4D/xw4udz48v5T2eyiN0+elVTmofHlCMLVP/Nz2LiLJy6lh32u4/
         AsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474639; x=1702079439;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMWeTAylF3bUIvrApUeKD5Af/l0nzPxNAdOfQ8ZWtyk=;
        b=WnHYFqy/nDy7MUxbzcMlpMDBvXFS/tS2AhaG0zPs6a5sbFVrEVALEeoK4bu1DqdJA2
         L9AMBLNEeBknoa95upJh3HhIuQAdWiSsvB8SJcrKui0ps5anA58p33mL07oqfNRwlAYq
         wMs57kvKxI95OWkcFNQBgJ0VgXJ/Vpmy9ZPzaJMqYTDH8zwjEQZeT5G0goT7lEbWInjM
         lCnLeLFbXfS0stxv2kjkJ2o3co+nd2KNGSbIEUycCm3f75U6KamTLkCi36HDA1qqzyZH
         UGww1eO2X80E5R2a1/7Rwjxbz0tj21i6R+kBG0Kdf4pnO1LONlgowVOciZ3II5x1iOjR
         aukw==
X-Gm-Message-State: AOJu0YxmbERt+QFTI+Bn2LJDmsCgtVaFyxmSkPtsgD9uRhdveDvXeqPK
	Or1PrkTxDKtJ4Uwf5UjaW3dfu8uIqmRs
X-Google-Smtp-Source: AGHT+IFNARd7MyKjCR2gLvJy45/OB20UrZiZukoWo3tgtMA/0nbQdgyhR+LI1WVbM0lMkdiPHvakkjNz/pMc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a25:dad3:0:b0:db5:3d61:8e63 with SMTP id
 n202-20020a25dad3000000b00db53d618e63mr241281ybf.13.1701474639430; Fri, 01
 Dec 2023 15:50:39 -0800 (PST)
Date: Fri,  1 Dec 2023 15:50:23 -0800
Message-Id: <20231201235031.475293-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 1/9] perf thread_map: Skip exited threads when scanning /proc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Scanning /proc is inherently racy. Scanning /proc/pid/task within that
is also racy as the pid can terminate. Rather than failing in
__thread_map__new_all_cpus, skip pids for such failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread_map.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index e848579e61a8..18fbc41d09f3 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -109,9 +109,10 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
-		if (items <= 0)
-			goto out_free_closedir;
-
+		if (items <= 0) {
+			pr_debug("scandir for %d returned empty, skipping\n", pid);
+			continue;
+		}
 		while (threads->nr + items >= max_threads) {
 			max_threads *= 2;
 			grow = true;
@@ -152,8 +153,6 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	for (i = 0; i < items; i++)
 		zfree(&namelist[i]);
 	free(namelist);
-
-out_free_closedir:
 	zfree(&threads);
 	goto out_closedir;
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

