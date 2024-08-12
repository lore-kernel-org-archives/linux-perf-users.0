Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A0193092;
	Mon, 12 Aug 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491890; cv=none; b=FTuy95n9Qwbe6nO8J+chDW/BTatSnYc+AHpFiYTUh7liDMd5u/kkX1cR5wRdhZXba477kT/QljYb9ASQWdN0jXZpgGV8vkNfQmmiWDQjA3DN8M1YgU7J72n54G42uSouv8/8t2UdljvPfnr+ZFZZAKbXuGu5XjDQrAn+32I2w7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491890; c=relaxed/simple;
	bh=QHewfVSyj7Ct3cw0t63ntx4CvJfX2M//3DZapaeY0HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMH8P+CaKCWi/HEUkhko1RpL6vzLPzxsHPaRTyWpADegNkROAdF41fDahXXpH2BPW9GlhOftXzRf6v1llSHcGb4ztVBjbtQDcO5RI5nEobsjRKX1Ijxlv4HRGS32tXjArKMdUPfcuwsUPP5bglqBtMHLcPQ8qTW3nxrok3BqiE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4Md5gWg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4Md5gWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AB0C4AF0D;
	Mon, 12 Aug 2024 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723491890;
	bh=QHewfVSyj7Ct3cw0t63ntx4CvJfX2M//3DZapaeY0HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e4Md5gWgCwRnTQePXMH1DSm8L08RywlUbal8bqQsuFjhdimnyrAHkeGjTSEiGBQOx
	 zdvjOmCNkikHWPLrmG1VujXs4PRULQlz1RnqkbWRgKrFlqYZiZFH/jrSBTuEl5M6sV
	 YeUmPODYNRll6FfufEr43mJ2SgjynCNDBXzT7YvFELOiJI8uoTxeoN8AfdY/nY9n4Y
	 qJwoFScJmGGWK70boRSf9YrZya5V0V5yGvgLHzcNqj7gLCqeGGYUs44If9ludydKIW
	 8lzCsmvVDpkYxXoF0YDyFEmttVYzlgeG/ukZqdkIjvX2SYIpsWRSmVDW7TFpejt5Lp
	 Led/L+1vF3sXg==
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
Subject: [PATCH 3/3] perf annotate-data: Show first-level children by default in TUI
Date: Mon, 12 Aug 2024 12:44:47 -0700
Message-ID: <20240812194447.2049187-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240812194447.2049187-1-namhyung@kernel.org>
References: <20240812194447.2049187-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now default is to fold everything but it only shows the name of the
top-level data type which is not very useful.  Instead just expand the
top level entry so that it can show the layout at a higher level.

  Annotate type: 'struct task_struct' (4 samples)
        Percent     Offset       Size  Field
  -      100.00          0       9792  struct task_struct {                           ◆
  +        0.50          0         24      struct thread_info     thread_info;        ▒
           0.00         24          4      unsigned int   __state;                    ▒
           0.00         32          8      void*  stack;                              ▒
  +        0.00         40          4      refcount_t     usage;                      ▒
           0.00         44          4      unsigned int   flags;                      ▒
           0.00         48          4      unsigned int   ptrace;                     ▒
           0.00         52          4      int    on_cpu;                             ▒
  +        0.00         56         16      struct __call_single_node      wake_entry; ▒
           0.00         72          4      unsigned int   wakee_flips;                ▒
           0.00         80          8      long unsigned int      wakee_flip_decay_ts;▒
           0.00         88          8      struct task_struct*    last_wakee;         ▒
           0.00         96          4      int    recent_used_cpu;                    ▒
           0.00        100          4      int    wake_cpu;                           ▒
           0.00        104          4      int    on_rq;                              ▒
           0.00        108          4      int    prio;                               ▒
           0.00        112          4      int    static_prio;                        ▒
           0.00        116          4      int    normal_prio;                        ▒
           0.00        120          4      unsigned int   rt_priority;                ▒
  +        0.00        128        256      struct sched_entity    se;                 ▒
  +        0.00        384         48      struct sched_rt_entity rt;                 ▒
  +        0.00        432        224      struct sched_dl_entity dl;                 ▒
           0.00        656          8      struct sched_class*    sched_class;        ▒
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate-data.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index a5c5ad63425e..f563a3bb072c 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -596,9 +596,17 @@ int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
 	}
 
 	ret = annotated_data_browser__collect_entries(&browser);
-	if (ret == 0)
-		ret = annotated_data_browser__run(&browser, evsel, hbt);
+	if (ret < 0)
+		goto out;
 
+	/* To get the top and current entry */
+	browser__refresh(&browser.b);
+	/* Show the first-level child entries by default */
+	annotated_data_browser__toggle_fold(&browser, /*recursive=*/false);
+
+	ret = annotated_data_browser__run(&browser, evsel, hbt);
+
+out:
 	annotated_data_browser__delete_entries(&browser);
 
 	return ret;
-- 
2.46.0.76.ge559c4bf1a-goog

