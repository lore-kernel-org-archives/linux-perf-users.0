Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8235E1D9;
	Mon, 13 Jul 2026 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975631; cv=none; b=Cz8z//SdqDtVm4D8QIXR5eEPg0GNoKH2wkAkbG3RNQ1KwomJNrvH6sKtOgg0TPqGqZjAnXNudUE8KPZ2+++lQhaAv6qfBnmMxD+rnD5JfKyX+SnJb9DTRacyjManKWc3xQlho+vnPFwcK+Fv84d7DmbuoiDOVbGsN8QRG/LGg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975631; c=relaxed/simple;
	bh=YJJiqRf9h6bFaDLrUNyd6Pn3veU4WyvmxepRl4BLlis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4cJMt9nJtlnsM5Fidcy7meFYf42+yGBY0UAPZFj0S0g/pA92HuCzGf4O7X0Jt26s7bkQtGTB3++0BqTO2sFXCnE/+dEiLAfqtptW88V22TrIEUj2aK2v3Uq/oy/f9lnq9Cf8sId4Sx+Avw5pQDQhIwptS4RhDtVp8BhdQjlOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5RwjXyq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5RwjXyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C48C1F00A3F;
	Mon, 13 Jul 2026 20:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975630;
	bh=nDrDfafXYGDy6ulQwYd+nOjs9BVAD1MZGdRlgu1eJFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N5RwjXyqRzuOEchURWJKFq9aV+3c8CodP7IG3EkTKAH//uTBa7HsLJE+Ym6GTO397
	 9VKmoLZKl5ULml2ZjVHp1QJ00gsU12Vl9eHX3ofI//kKOVGJpeqiUhY7yN3fSjSuEr
	 4BsFQBdtTUqUJUrLLR04/Qh1kcmTEiu1ZGc7EcLzCHlUOeo0+OPnZp2ewaEVbtZIkF
	 QH7hW0KbzDlnaYwmD6NCiWqc3SbqXcskS8SIJKkUOVyS/8galrZ34uSquK3lT+g2e5
	 kJM+kUk5yn/VGuIyFKUR8WB/9e5U2QXdYrxI4dZdgrrgLpcCtNCWdw+Sry7EPZwIsZ
	 V0YA9q/YB8+jg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v1 2/3] perf sched: Fix memory leaks in perf sched stats report
Date: Mon, 13 Jul 2026 13:47:06 -0700
Message-ID: <20260713204707.2181098-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260713204707.2181098-1-namhyung@kernel.org>
References: <20260713204707.2181098-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second pass data is not saved in the list and only used to calculate
delta from the first pass.  Let's free the data after use.

Fixes: 5a357ae6ad63 ("perf sched stats: Add support for report subcommand")
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 68147a0be5c710ed..439e50d9a936f6c1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4632,6 +4632,8 @@ static int perf_sched__process_schedstat(const struct perf_tool *tool __maybe_un
 			domain_second_pass = list_first_entry(&cpu_second_pass->domain_head,
 							      struct schedstat_domain, domain_list);
 			store_schedstat_cpu_diff(temp);
+			free(temp->cpu_data);
+			free(temp);
 		}
 	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
 		struct schedstat_cpu *cpu_tail;
@@ -4652,6 +4654,8 @@ static int perf_sched__process_schedstat(const struct perf_tool *tool __maybe_un
 		} else {
 			store_schedstat_domain_diff(temp);
 			domain_second_pass = list_next_entry(domain_second_pass, domain_list);
+			free(temp->domain_data);
+			free(temp);
 		}
 	}
 
-- 
2.55.0.795.g602f6c329a-goog

