Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5307044374;
	Tue,  1 Oct 2024 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742036; cv=none; b=l3ZouqBwAc53IUzjKb1RgpFe00RAeKbsSTjBMOpY6Mj55UIXVZxH44ZR+ONlFY3/8RGBLJ6+XC9dTkcWQ45AZYyX5hXTGOja2ODNFa30Yr5QBbpUNO8fYnDMT4YrkXpDnoaMA3NBtqS5D1HFX45ZNYXfGP9usvW5dyB1QKUc8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742036; c=relaxed/simple;
	bh=7aieh78om/yhYCq16DdxzBsiyA5Y6XfHwyZ+r8siS3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKn0nba5pTJFZsHDR1sy8aoIz/QhnPi+o3DSMBbyINzNin3HIZgfabtUDiMhMxJXSzQTv3sa772awqDlKypD4+NKiAqOF25gYDCfkE4p87TuZEQzrfLfKcLBuVfGtpvMHyK69v+UMQpjsIivHOsEdapoFf+sIqYHjCVlig9SEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4ASG11v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4ASG11v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A001C4AF0D;
	Tue,  1 Oct 2024 00:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727742035;
	bh=7aieh78om/yhYCq16DdxzBsiyA5Y6XfHwyZ+r8siS3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4ASG11vHtUugMFKHmoZPmRXX/4xL+wgrP/D0u/ky/8O1QhDtd9GCOW6qo6Exp1IM
	 jn81qmPho3LdqxET20EVBVITHedVOTakiwm31T/lUbyCppIh7q1OGgltm4lC7w7UZm
	 c5vC4nZWR/daUuBctL9Ul/6Av0qL5t50u2A8TLjGgW987l+X3M45lgFydfyqJ/C45L
	 kiHcZ8oyUpJ9meQIxSNa1d89u6brvoSiZQ+iXvBGZAVVFF9o67TvNDJiw9gPjpQB8f
	 V34D3/xcirZJhb9Ntptp3qT5YHnfwgsiiF0MoOEV0ZnQ6Hdpom8VsbQ4HJK9sD7FUF
	 xY6W9y7GIPgxQ==
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 8/8] perf record: Just use "cycles:P" as the default event
Date: Mon, 30 Sep 2024 17:20:27 -0700
Message-ID: <20241001002027.1272889-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001002027.1272889-1-namhyung@kernel.org>
References: <20241001002027.1272889-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fallback logic can add ":u" modifier if needed.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c1f4c..f8325247292112d7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4157,9 +4157,7 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-
-		err = parse_event(rec->evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		err = parse_event(rec->evlist, "cycles:P");
 		if (err)
 			goto out;
 	}
-- 
2.46.1.824.gd892dcdcdd-goog

