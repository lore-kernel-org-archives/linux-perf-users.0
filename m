Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB07BA50;
	Fri,  2 May 2025 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746218457; cv=none; b=XUY8sWLNpwlGnvLP6XgD7VmZSwG8SFASV1AdfCx1m0u/U6YnKPpPa0Kz++Epvv8x+8kkX3YPzuHipzcGdsbIRTuQsIF050gXpjDfwsW4tOVWscndWif1iArpzQuTaacyKX5K42+ue8G3zjE+KAbiu1TNNtGYFLKuD69cqe3yZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746218457; c=relaxed/simple;
	bh=0ToLQfR2fvtG0YWw6RPLmCeOlk6BInrIZ0t06llvUcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKqRmbZmdtmszZCP7LEfpFHKss8khj+y9QL1Ih8VO1S/2u3A9o9B3aP7kWZ4EDGbYFAjpFpiYgGuL0sbxitj7J/7KdsJktdRMxnKO28ftFh8MPJGWwmRyCTMsNuwZ9ppuK8upEATVH4JdNACLaSj4Ii8RDk198QG3DDO/QQO8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhPLoOpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhPLoOpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CB0C4CEE4;
	Fri,  2 May 2025 20:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746218457;
	bh=0ToLQfR2fvtG0YWw6RPLmCeOlk6BInrIZ0t06llvUcM=;
	h=From:To:Cc:Subject:Date:From;
	b=WhPLoOpW7wKmY1A4LiOi0ejg+HooXX+BjTqmclza9fp8KwS/aCwIgIDqKzUmsF9DI
	 awTQpVjM8/OQjVLAF9Ylvxt/3o1KQPagv8rGg/dhLpvWrmETg4p8OhBthkCi96G+O/
	 zQNPQqjUFNYbCYrDXn6lvKCsCDG+Cru4PihbML+pMl64LQWipp+UcD2yZKcUxGMQlj
	 8JGZxanHag0VOeemVG6C3JnusSkrNpW3xGcLAGAz08BQtF4epNaKS1rgEh7+ckAW/J
	 YueXvLvfSFWTufp3PnsEywO1nH2KkRmCvYwKkQ70hvYzASgySjRKLUwS0BiVY5i00F
	 QXW9vy2nLT3bQ==
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
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf trace: Show zero value in STRARRAY
Date: Fri,  2 May 2025 13:40:56 -0700
Message-ID: <20250502204056.973977-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The STRARRAY macro is to print values in a pre-defined array.  But
sometimes it hides the value because it's 0.  The value of 0 can have a
meaning in this case so set 'show_zero' field.

For example, it can show CREATE_MAP cmd in the bpf syscall.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 83c62c30d914306c..9210ba34002b13c3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1123,12 +1123,14 @@ static bool syscall_arg__strtoul_btf_type(char *bf __maybe_unused, size_t size _
 #define STRARRAY(name, array) \
 	  { .scnprintf	= SCA_STRARRAY, \
 	    .strtoul	= STUL_STRARRAY, \
-	    .parm	= &strarray__##array, }
+	    .parm	= &strarray__##array, \
+	    .show_zero	= true, }
 
 #define STRARRAY_FLAGS(name, array) \
 	  { .scnprintf	= SCA_STRARRAY_FLAGS, \
 	    .strtoul	= STUL_STRARRAY_FLAGS, \
-	    .parm	= &strarray__##array, }
+	    .parm	= &strarray__##array, \
+	    .show_zero	= true, }
 
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/futex_op.c"
-- 
2.49.0.906.g1f30a19c02-goog

