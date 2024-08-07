Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0AA6CDAB;
	Wed,  7 Aug 2024 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011358; cv=none; b=SsX8HItzUD8RBmPM9we3Y2Su8wZkgmZ5OZmsyBg5ssZcjohb6rwZOtYBcZjQ1FRoGXPW0jXDyMeUDSlY9DCEYQVgCMw85Mo9yN8QafuvKidk/CR5ginY/TKbHFiH6EtIHjKL7WpI7JKD+RX81/GlfT8FUXG1yBfPMr/XNLNm7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011358; c=relaxed/simple;
	bh=o3XYizA79qMV7uBvCLbIqYFtVIa22HgWDUXyJQuGwL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnmcyMy6sDfpdsjuORgrvZfWAGf/nisHTSlCNMUtrOgsxWMq0inydb5ioMCmX6ORWu7m+mOHnkC1eHk6N+VHUP67TI/Ff26qtPr5Hg8NE6vydf+SbekX0YRLGK7IDFAgBab6x2B1ue6w0WcXjmMW3TwLRYtJuGCdiF6ntsmJNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPumBkjh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPumBkjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A396C32782;
	Wed,  7 Aug 2024 06:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723011357;
	bh=o3XYizA79qMV7uBvCLbIqYFtVIa22HgWDUXyJQuGwL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPumBkjhdbkGEMs/pky9eYQdlSGJH9sBxxizfIN33q7YPz8op6sbz5TPi9oC3ZxYU
	 wNOqaNFndpC0kUJ+TJf7wmK3wLk1+wqoeTUfZgI6jn6GbKfQfLV3Hj2/tvPQ4DhkfR
	 vYXZftGZd6NGAaaDG0m5LJSzdLSD2/XP9DNJD0xEtkD8hyFwKnfDApV11wxmxnQisX
	 dQqPrVFi9Inb4xXtIXSZnPksem/I2RCsVxitxb9JWu7+YD8zMjI4Sf2YEcKHVNGvlF
	 DXUWii4nRy7OEWfji/m03867P3y/ShneureEVTXAOsTnOAtFduuwDfm1aq1qb+hreN
	 3Q2lRgb9BVwdQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] perf annotate: Fix --group behavior when leader has no samples
Date: Tue,  6 Aug 2024 23:15:55 -0700
Message-ID: <20240807061555.1642669-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <CAM9d7cjXmaMuidQR10PXrp9khZ4LhDZbLno1rN2JcCncaYyp7Q@mail.gmail.com>
References: <CAM9d7cjXmaMuidQR10PXrp9khZ4LhDZbLno1rN2JcCncaYyp7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When --group option is used, it should display all events together.  But
the current logic only checks if the first (leader) event has samples or
not.  Let's check the member events as well.

Also it missed to put the linked samples from member evsels to the
output RB-tree so that it can be displayed in the output.

For example, take a look at this example.

  $ ./perf evlist
  cpu/mem-loads,ldlat=30/P
  cpu/mem-stores/P
  dummy:u

It has three events but 'path_put' function has samples only for
mem-stores (second) event.

  $ sudo ./perf annotate --stdio -f path_put
   Percent |      Source code & Disassembly of kcore for cpu/mem-stores/P (2 samples, percent: local period)
  ----------------------------------------------------------------------------------------------------------
           : 0                0xffffffffae600020 <path_put>:
      0.00 :   ffffffffae600020:       endbr64
      0.00 :   ffffffffae600024:       nopl    (%rax, %rax)
     91.22 :   ffffffffae600029:       pushq   %rbx
      0.00 :   ffffffffae60002a:       movq    %rdi, %rbx
      0.00 :   ffffffffae60002d:       movq    8(%rdi), %rdi
      8.78 :   ffffffffae600031:       callq   0xffffffffae614aa0
      0.00 :   ffffffffae600036:       movq    (%rbx), %rdi
      0.00 :   ffffffffae600039:       popq    %rbx
      0.00 :   ffffffffae60003a:       jmp     0xffffffffae620670
      0.00 :   ffffffffae60003f:       nop

Therefore, it didn't show up when --group option is used since the
leader ("mem-loads") event has no samples.  But now it checks both
events.

Before:
  $ sudo ./perf annotate --stdio -f --group path_put
  (no output)

After:
  $ sudo ./perf annotate --stdio -f --group path_put
   Percent                 |      Source code & Disassembly of kcore for cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P, dummy:u (0 samples, percent: local period)
  -------------------------------------------------------------------------------------------------------------------------------------------------------------
                           : 0                0xffffffffae600020 <path_put>:
      0.00    0.00    0.00 :   ffffffffae600020:       endbr64
      0.00    0.00    0.00 :   ffffffffae600024:       nopl    (%rax, %rax)
      0.00   91.22    0.00 :   ffffffffae600029:       pushq   %rbx
      0.00    0.00    0.00 :   ffffffffae60002a:       movq    %rdi, %rbx
      0.00    0.00    0.00 :   ffffffffae60002d:       movq    8(%rdi), %rdi
      0.00    8.78    0.00 :   ffffffffae600031:       callq   0xffffffffae614aa0
      0.00    0.00    0.00 :   ffffffffae600036:       movq    (%rbx), %rdi
      0.00    0.00    0.00 :   ffffffffae600039:       popq    %rbx
      0.00    0.00    0.00 :   ffffffffae60003a:       jmp     0xffffffffae620670
      0.00    0.00    0.00 :   ffffffffae60003f:       nop

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index efcadb7620b8..1bfe41783a7c 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -632,13 +632,23 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	evlist__for_each_entry(session->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 		u32 nr_samples = hists->stats.nr_samples;
+		struct ui_progress prog;
+		struct evsel *evsel;
 
-		if (nr_samples == 0)
+		if (!symbol_conf.event_group || !evsel__is_group_leader(pos))
 			continue;
 
-		if (!symbol_conf.event_group || !evsel__is_group_leader(pos))
+		for_each_group_member(evsel, pos)
+			nr_samples += evsel__hists(evsel)->stats.nr_samples;
+
+		if (nr_samples == 0)
 			continue;
 
+		ui_progress__init(&prog, nr_samples,
+				  "Sorting group events for output...");
+		evsel__output_resort(pos, &prog);
+		ui_progress__finish();
+
 		hists__find_annotations(hists, pos, ann);
 	}
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog

