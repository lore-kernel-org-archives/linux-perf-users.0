Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C114601F;
	Fri, 16 Aug 2024 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852721; cv=none; b=jlV9EaQA5jv94piXJKKJOC1CXXXfV/EUhLz6lYFx0BkA7fLRk6LUKQ6fjR9gTM/2jAj5mqdwW3tWLlck/jLxagwoP6OWbj+Gix0Ecaf8VCmHT9qFo8tgyIbiGTpxDGB+Ec3sWndkb19gQroaGGiJCqmLXJ/+Q9Y8+anVtMzwgms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852721; c=relaxed/simple;
	bh=gQYWHT2iv2QpIDygwPCmKISsf64+h3O6hd8st6xxcVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3uAi3SXF4lr4aCLFHI89nhyrb9Pb2joSJH2AklZAVouxO11Zg1ySDDgj0gPyOWfFGd8acBAK+1e5FUWb4sNBI9HocUlZPchCNzuHDEygMJK70S8XBXa/fmuN1km62LmvIBiroAaDg4ztvbhA810OWIKrMpw2LnI+mF+7tR9bls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrQYfm9j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrQYfm9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F4DC4AF11;
	Fri, 16 Aug 2024 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723852721;
	bh=gQYWHT2iv2QpIDygwPCmKISsf64+h3O6hd8st6xxcVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrQYfm9je7f0Oh93OaldgbUYVTPIHlSikymL6sgRYOSgd3kEzERBpNgXl2/R90Cog
	 N+pdOWwB0fwF5ysZPbAQcmbeLBKyAcEJkfuUVp9jQTVvfePeJw4UThb57vCtNMB94w
	 1PCTK0i+sBgiNwIY9gAaRUwtfWwU3lGrKmSqOWcOSBc+MXu98ZCHcTkPOicFw409sO
	 ccG0ahfWWLkOUjy0ijcO4nvY/8x19zYy2HcQ3CBHalfldpIYF9Mb8wYVE66eFabrap
	 AIOfSknIKkR7M8Wxswt3MXv8BLnknT0dcSHEIRxOp8aVwH3vZhQkw/Y1g+RSTk2y1o
	 MIkepsynR/jRg==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/9] perf dwarf-aux: Check allowed location expressions when collecting variables
Date: Fri, 16 Aug 2024 16:58:31 -0700
Message-ID: <20240816235840.2754937-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240816235840.2754937-1-namhyung@kernel.org>
References: <20240816235840.2754937-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It missed to call check_allowed_ops() in __die_collect_vars_cb() so it
can take variables with complex location expression incorrectly.

For example, I found some variable has this expression.

    015d8df8 ffffffff81aacfb3 (base address)
    015d8e01 v000000000000004 v000000000000000 views at 015d8df2 for:
             ffffffff81aacfb3 ffffffff81aacfd2 (DW_OP_fbreg: -176; DW_OP_deref;
						DW_OP_plus_uconst: 332; DW_OP_deref_size: 4;
						DW_OP_lit1; DW_OP_shra; DW_OP_const1u: 64;
						DW_OP_minus; DW_OP_stack_value)
    015d8e14 v000000000000000 v000000000000000 views at 015d8df4 for:
             ffffffff81aacfd2 ffffffff81aacfd7 (DW_OP_reg3 (rbx))
    015d8e19 v000000000000000 v000000000000000 views at 015d8df6 for:
             ffffffff81aacfd7 ffffffff81aad020 (DW_OP_fbreg: -176; DW_OP_deref;
						DW_OP_plus_uconst: 332; DW_OP_deref_size: 4;
						DW_OP_lit1; DW_OP_shra; DW_OP_const1u: 64;
						DW_OP_minus; DW_OP_stack_value)
    015d8e2c <End of list>

It looks like '((int *)(-176(%rbp) + 332) >> 1) - 64' but the current
code thought it's just -176(%rbp) and processed the variable incorrectly.
It should reject such a complex expression if check_allowed_ops()
doesn't like it. :)

Fixes: 932dcc2c39ae ("perf dwarf-aux: Add die_collect_vars()")
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 5e080d7e22c2..beb632153a74 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1598,6 +1598,9 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
 		return DIE_FIND_CB_SIBLING;
 
+	if (!check_allowed_ops(ops, nops))
+		return DIE_FIND_CB_SIBLING;
+
 	if (die_get_real_type(die_mem, &type_die) == NULL)
 		return DIE_FIND_CB_SIBLING;
 
-- 
2.46.0.184.g6999bdac58-goog

