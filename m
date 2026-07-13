Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536D3A4539;
	Mon, 13 Jul 2026 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986340; cv=none; b=Sf1nN+Ip2c6CpOAXQY/eFxurEhwrNK+hh5r/6e+c6F+7vHULFCnU9vcxTwRtWKC0TvutX5+Q1zhD7B9l8ZMbNSPJ/zVXDO+MtZ4h/QpBkqY5pln6/TE6kWjIZ2jA/OVDYnXI85WUIw/W0yJZZ02ElLxtncRaAW8lkCq1xSly0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986340; c=relaxed/simple;
	bh=e8L7JP+eDiD7idQalJ092Hbvi26hvz50A4ROwiGvGv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgUwJQF5ErN3x3Ts7Jyr7p+8MZKItCGItUwLetajluTWIPcj08ce+fKOoOeEl1zWbppDkUPCYyjwGH1OHWJudo2dqtu7N9lO3S8QK16kyT4ve62mLx54uj9dWiztkFWvAVJcOvtPXIT87eWjMUiloBEMPcOvQMaNXJtFxVMnhJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXznfom+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXznfom+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA13A1F00A3F;
	Mon, 13 Jul 2026 23:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783986339;
	bh=W3MbfPTUdWHNSNqEkTTqYBG6n5DO/IFfviNfQUBR0dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXznfom+fVQlle8m5ejRMibUrASNUvdHNcH/gH0cR+aatGkpa5ERQ9ccWGTYs0R2M
	 B467TwNIu6uoyx3aK+auV6yfUdrUXfdFFcAM4Xy1OR4iTiFiuX0h2IR7TQ6G+D+LEr
	 9qup1cY+qU3jnp5u6gkr7Vt8ZXiFQmq7aWOMG9yv4HOiY5yxXIkLPCCesdvpAnPzCj
	 p+s2thMMofdemnfHHRzrkoNZuEWdUIIZiDHKOhNLA9eFwu2Ypnm1tyTek5FMlGI8Dx
	 1NLAbU5Pc5hagpjG2/VxshvnR4VggXQlPUL8C/jcWIcVzCjX0ffYwZAR0X3l+7Z6Cm
	 Ik46/zB3/K2nQ==
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
Subject: [PATCH v2 2/3] perf sched: Fix memory leaks in perf sched stats report
Date: Mon, 13 Jul 2026 16:45:35 -0700
Message-ID: <20260713234536.2280374-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260713234536.2280374-1-namhyung@kernel.org>
References: <20260713234536.2280374-1-namhyung@kernel.org>
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
index c5728f3aa46f2630..ab9590c4d838eff3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4631,6 +4631,8 @@ static int perf_sched__process_schedstat(const struct perf_tool *tool __maybe_un
 			domain_second_pass = list_first_entry(&cpu_second_pass->domain_head,
 							      struct schedstat_domain, domain_list);
 			store_schedstat_cpu_diff(temp);
+			free(temp->cpu_data);
+			free(temp);
 		}
 	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
 		struct schedstat_cpu *cpu_tail;
@@ -4651,6 +4653,8 @@ static int perf_sched__process_schedstat(const struct perf_tool *tool __maybe_un
 		} else {
 			store_schedstat_domain_diff(temp);
 			domain_second_pass = list_next_entry(domain_second_pass, domain_list);
+			free(temp->domain_data);
+			free(temp);
 		}
 	}
 
-- 
2.55.0.795.g602f6c329a-goog

