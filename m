Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D77BB0F;
	Wed,  8 May 2024 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715177753; cv=none; b=glOP3tW5mgZb6BkZNC9vuNtN/6UBeNMrxyX2KQWEq/Bpvm0FsYLb8d2yCee2fBWqafRN7AIcmAy5EOdhLYb/RWFw9hSxs3OJocVu3lnqGmzwKINU03gIBBa9SMtnF4XKaucDyvzAvfxgmfPWcR558kdvPSQbL/0xYpVrn/0DyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715177753; c=relaxed/simple;
	bh=6A7Z1g12GoKK+DOAy2tHYcRQ25V+VaPQo8VdbUz1buI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmOxJQO2agTFyVw1CmVsE/NNDprYEUaFo08ycCMKwF1Dbw4kFq65y8JlfyZRsc2xz63vNkj39ejwN2hy0SjBXFCbdchojbgkpXVGwvhnuun4M+h1AQMoebb/DXYzgqi09uBo0GVogI1eTqdOtRDSnlqGn6vhzU+yT+JxYDhwLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D201007;
	Wed,  8 May 2024 07:16:16 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 943633F6A8;
	Wed,  8 May 2024 07:15:48 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: leo.yan@linux.dev,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf dwarf-aux: Fix build with HAVE_DWARF_CFI_SUPPORT
Date: Wed,  8 May 2024 15:14:57 +0100
Message-Id: <20240508141458.439017-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_allowed_ops() is used from both HAVE_DWARF_GETLOCATIONS_SUPPORT
and HAVE_DWARF_CFI_SUPPORT sections, so move it into the right place so
that it's available when either are defined. This shows up when doing
a static cross compile for arm64:

  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LDFLAGS="-static" \
    EXTRA_PERFLIBS="-lexpat"

  util/dwarf-aux.c:1723:6: error: implicit declaration of function 'check_allowed_ops'

Fixes: 55442cc2f22d ("perf dwarf-aux: Check allowed DWARF Ops")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/dwarf-aux.c | 56 ++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index c0a492e65388..c9584563cd56 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1215,6 +1215,34 @@ static int offset_from_dwarf_op(Dwarf_Op *op)
 	}
 	return -1;
 }
+
+static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
+{
+	/* The first op is checked separately */
+	ops++;
+	nops--;
+
+	/*
+	 * It needs to make sure if the location expression matches to the given
+	 * register and offset exactly.  Thus it rejects any complex expressions
+	 * and only allows a few of selected operators that doesn't change the
+	 * location.
+	 */
+	while (nops) {
+		switch (ops->atom) {
+		case DW_OP_stack_value:
+		case DW_OP_deref_size:
+		case DW_OP_deref:
+		case DW_OP_piece:
+			break;
+		default:
+			return false;
+		}
+		ops++;
+		nops--;
+	}
+	return true;
+}
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT || HAVE_DWARF_CFI_SUPPORT */
 
 #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
@@ -1395,34 +1423,6 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	return true;
 }
 
-static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
-{
-	/* The first op is checked separately */
-	ops++;
-	nops--;
-
-	/*
-	 * It needs to make sure if the location expression matches to the given
-	 * register and offset exactly.  Thus it rejects any complex expressions
-	 * and only allows a few of selected operators that doesn't change the
-	 * location.
-	 */
-	while (nops) {
-		switch (ops->atom) {
-		case DW_OP_stack_value:
-		case DW_OP_deref_size:
-		case DW_OP_deref:
-		case DW_OP_piece:
-			break;
-		default:
-			return false;
-		}
-		ops++;
-		nops--;
-	}
-	return true;
-}
-
 /* Only checks direct child DIEs in the given scope. */
 static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 {
-- 
2.34.1

