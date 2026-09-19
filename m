Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4862E0B5C;
	Sat, 19 Sep 2026 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850466; cv=none; b=Lusdwu1FneuWLlRP4BDBIkbUNMoPtODg91hNHh5v9YEr/OMzVg8nJm57GqYxKL4P9Bflt/vwrr6zQEDecS73OvQFPdxt7iwiEiA+cJ3UQGOsOfy8/lILR2uDsTEeV3o1dLZmKHPPLZiK2GiOzZmzg6pcMrmPd0zOIgebXBhekIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850466; c=relaxed/simple;
	bh=3cDhoN7P/1XTUwvA8WkOrFA9S1haHivtyk6o/1zsDr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBeoCIL493fIs3KwkENvqTpkldw0cZREjKj9R/t7om2y6EpkxETx1fHh4jaUpcjCF/J4oE2aRjxc0UqdAudKedAOhq+0qein7KxXbbqc9kugYzSuJphNIaSOJMJudlJ5oLBRs6aJM5OMC1unY8UpCcTyaufyDYBx8Bbj5XxmyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bcn5r6Mt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcn5r6Mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50F81F00893;
	Sat, 19 Sep 2026 20:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850465;
	bh=ut/tiruf2HnofkU7Adqr3g/phrfuZNzP9oxtyKMjlx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bcn5r6Mtr1/JYWm2aHtPyM7kGYmPam5JK06rtW4LM4BFWXZ7l4dokQpCJnL6r+9Hu
	 kM7c40Ed9tSSH0Burry8U58Tz12UYnzJ2qcnsj8MYIGopgjHsndg6SVRVmIk1m9akE
	 F2vjAX/BnFqqBWQ3bdRV+dW6WV2cVflzEAHBf0aHiZDxlJWkf6Va8VeWn1Dj9nywiL
	 Nl271nLL7su33f9edx9WXO72ZzvLPPTlA6Nf7IuhG0I2BIQUI0Of6xnsY8JF2ISG32
	 MiMvwRVJkf/ccAEMgTeep8dAn5MK/VNzNXRsQA1Mu8HSEiM4I/H0EthpUxX/ZARPmF
	 oC8x44Ub4OW8g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/7] perf annotate-data: Show the sample count in the data-type browser
Date: Sat, 19 Sep 2026 17:40:25 -0300
Message-ID: <20260919204027.8504-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260919204027.8504-1-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The samples view (-n, annotate.show_nr_samples) prints a local
nr_samples variable that is initialized to zero and never updated, so
every member is listed as having no samples while the period and percent
columns for the same entry are filled in.  Print the histogram entry's
own count instead.

Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_data_tui()")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index c6e07a9b64089ab5..a15608f6ee53335f 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -374,7 +374,7 @@ static void browser__write_overhead(struct ui_browser *uib,
 	u64 period = hist->period;
 	double percent = total->period ? (100.0 * period / total->period) : 0;
 	bool current = ui_browser__is_current_entry(uib, row);
-	int nr_samples = 0;
+	int nr_samples = hist->nr_samples;
 
 	ui_browser__set_percent_color(uib, percent, current);
 
-- 
2.53.0

