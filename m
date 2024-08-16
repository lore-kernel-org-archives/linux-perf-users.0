Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AE1487CE;
	Fri, 16 Aug 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852722; cv=none; b=KYgJEB5fF4O7/KHgcGfC9vL0VWq1V+H5omW7ny62VaNnnkQPo72S9VHb8mJCjv4QVMqLPZr5+EUS7KgP0RGGYd/HxiM9Njal/OVIgOkVtP1x1MGJPKvEJtksHUS+ERYOcEgejDK07pfa7jf4qbtH7YEuR1bqtzTHTgRGY7n1NKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852722; c=relaxed/simple;
	bh=QEdfiXXWPPSs97vHd/yHxLt8ReSrwGvcutiOuI4ry94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8SstIff4fPDznh0IRW5qS+MkZMXk9Z2g3Y48goFh+GIpYd57yJpjeTkNNUSO6TRnk9fILgU/RieTAl+6kclyHlX6Yp0mBNrxn2lzClyo6EtCuyoyAIfN5boJ0br1H4OPiaO3cE+1+6X4UCRUPMK4eJ2Ty466tanPdxGudvjm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMJ81mBs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMJ81mBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFB7C4AF14;
	Fri, 16 Aug 2024 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723852722;
	bh=QEdfiXXWPPSs97vHd/yHxLt8ReSrwGvcutiOuI4ry94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMJ81mBsCea5ljP3X7QVdDsUu3E13MWxTi7dwSBPMvUgG+sIz0+6eRqT/c43SpLum
	 J7wEMGYQG7hulACcREytWwPauVWMiDqn86uD1Tux97OEdM0cgXhkSO/2mPDfrO21mE
	 LPLbFyzTxIBqB2PrC7t/hPBBdMZ668sNb412IwsKq5iWzLVYvzCyqcMgwQoi1FupY4
	 820+GHhhwolZsP7zeoF6cKz7hCheLhx79fpwq5zP7XUogIo9pH/OWHb0IC2XXvQIeF
	 D4Aynk4zO9bHw41l7cnJgVSwQ813RlW5CVYTbAZXnOYjN6FmH1vLVs/iz43d9cL/lL
	 vy/TvBrIJOaLw==
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
Subject: [PATCH 2/9] perf annotate-data: Fix off-by-one in location range check
Date: Fri, 16 Aug 2024 16:58:32 -0700
Message-ID: <20240816235840.2754937-3-namhyung@kernel.org>
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

The location list will have entries with half-open addressing like
[start, end) which means it doesn't include the end address.  So it
should skip entries at the end address and match to the next entry.

An example location list looks like this:

    00237876 ffffffff8110d32b (base address)
    0023787f v000000000000000 v000000000000002 views at 00237868 for:
             ffffffff8110d32b ffffffff8110d4eb (DW_OP_reg3 (rbx))     <<<--- 1
    00237885 v000000000000002 v000000000000000 views at 0023786a for:
             ffffffff8110d4eb ffffffff8110d50b (DW_OP_reg14 (r14))    <<<--- 2
    0023788c v000000000000000 v000000000000001 views at 0023786c for:
             ffffffff8110d50b ffffffff8110d7c4 (DW_OP_reg3 (rbx))
    00237893 v000000000000000 v000000000000000 views at 0023786e for:
             ffffffff8110d806 ffffffff8110d854 (DW_OP_reg3 (rbx))
    0023789a v000000000000000 v000000000000000 views at 00237870 for:
             ffffffff8110d876 ffffffff8110d88e (DW_OP_reg3 (rbx))

The first entry at 0023787f has [8110d32b, 8110d4eb) (omitting the
ffffffff at the beginning), and the second one has [8110d4eb, 8110d50b).

Fixes: 2bc3cf575a16 ("perf annotate-data: Improve debug message with location info")
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 2 +-
 tools/perf/util/dwarf-aux.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index ff85d190e3ac..fd8d3cdead5a 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -95,7 +95,7 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
 		return;
 
 	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
-		if (reg != DWARF_REG_PC && end < pc)
+		if (reg != DWARF_REG_PC && end <= pc)
 			continue;
 		if (reg != DWARF_REG_PC && start > pc)
 			break;
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index beb632153a74..0151a8d14350 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1444,7 +1444,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 
 	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
 		/* Assuming the location list is sorted by address */
-		if (end < data->pc)
+		if (end <= data->pc)
 			continue;
 		if (start > data->pc)
 			break;
-- 
2.46.0.184.g6999bdac58-goog

