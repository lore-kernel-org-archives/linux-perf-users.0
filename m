Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F3126C02;
	Wed, 16 Sep 2026 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539571; cv=none; b=hT8Qhn9kwzgpLIQeR4qlBtoX4eFdr++/3W0ZMfDWZrLbW+GFUi15jeZMEjZVh3Zo2BCfi8Hb1KjwYQE+z4VS/FD+pey+Yn3hTF34+bKRDNLNcWRK7N9Ll3difATazh4Ozhst5qd10/oqmfR3VgFVOyA/xrPu/tZu/kRvz25X2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539571; c=relaxed/simple;
	bh=k5FqQb0DrZujvC1aCwwsmEwU+t8in68Shz28J0sr0cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIbqz6sNYIMP/2JpqAL3yOEqlSbh3/UGzT9Il3VIkg0sNTZHgx+Z2eiGMA0luM/HFeeCS7bwzd1CgeT+SY0m+CDsRdZ/s/2QjRdS2EXvVHWhway8p7ezczHlX6HxoTuukgNv425/9nn3dSIOJsYsTT52mPB1AMPs4b9VoXBvxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYs0yVwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYs0yVwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC84B1F00893;
	Wed, 16 Sep 2026 06:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539569;
	bh=zAtolG3m/bkTO/+ZLRReCmgs7uPvele1yen8eTW3fCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QYs0yVwehShsjGoCK0/wXnX9zEOAmEIKiV36vWii732IRtZQhHx6roOO8M093r4K3
	 bYFUXGAv2WPZC3mdDoXGy39KKMAUPBkoi3M36e0ZIS21zrkmwuTozF7ORK2IyDrMU4
	 a+zO5OJKjcixITmMIpkd2yXE14RsRGkW+sm7NGDQuTbWtio6U7ki502yn0tppcVfFA
	 bAd1HmXB0Xdx3rKG8/4VFWpMJFGDy2v/oUjcYUxFH4g7wgiYPaIY8gWFnEGI+8sXua
	 WRNiLa+x2PMyfmSOD3xik5+5H4lbNzqL1NY2CQkwXTS8V7nr5zs2ryE7RzSckMMtW4
	 P1wJkgwv1SMKA==
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
	Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 1/3] perf dwarf-aux: Add die_has_flex_array() helper
Date: Tue, 15 Sep 2026 23:19:24 -0700
Message-ID: <20260916061926.2224222-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916061926.2224222-1-namhyung@kernel.org>
References: <20260916061926.2224222-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The die_has_flex_array() returns true when the given type is a compound
type and contains an array at the end.  To prevent an infinite recursion
add a depth field to the internal function.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 107 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |   3 +
 2 files changed, 110 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index d7160f87ac7d7ab3..1560e721479a1ac2 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -7,6 +7,7 @@
 #include <inttypes.h>
 #include <stdbool.h>
 #include <stdlib.h>
+#include <string.h>
 #include "debug.h"
 #include "dwarf-aux.h"
 #include "dwarf-regs.h"
@@ -2180,3 +2181,109 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
 
 	return die_get_member_type(&type_die, offset, die_mem);
 }
+
+static bool is_flex_array_member(Dwarf_Die *mb_die)
+{
+	Dwarf_Die type_die;
+	Dwarf_Word size;
+
+	/* get the type of the member */
+	if (die_get_real_type(mb_die, &type_die) == NULL)
+		return false;
+
+	if (dwarf_tag(&type_die) != DW_TAG_array_type)
+		return false;
+
+	return dwarf_aggregate_size(&type_die, &size) < 0 || size == 0;
+}
+
+#define MAX_FLEX_ARRAY_RECURSION  256  /* arbitrary */
+
+static bool die_has_flex_array_recurse(Dwarf_Die *parent_die, int depth)
+{
+	Dwarf_Die die_mem, last_mb;
+	int tag = dwarf_tag(parent_die);
+	bool found = false;
+	Dwarf_Word loc, last_loc = 0;
+
+	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type)
+		return false;
+
+	/* prevent infinite recursion */
+	if (depth > MAX_FLEX_ARRAY_RECURSION)
+		return false;
+
+	if (dwarf_child(parent_die, &die_mem))
+		return false;
+
+	do {
+		if (dwarf_tag(&die_mem) != DW_TAG_member)
+			continue;
+
+		if (tag == DW_TAG_union_type) {
+			if (is_flex_array_member(&die_mem))
+				return true;
+
+			if (die_get_real_type(&die_mem, &last_mb) &&
+			    die_has_flex_array_recurse(&last_mb, depth + 1))
+				return true;
+		}
+
+		if (tag == DW_TAG_structure_type) {
+			if (die_get_data_member_location(&die_mem, &loc) < 0) {
+				/* ignore bitfields */
+				loc = 0;
+			}
+
+			if (last_loc <= loc) {
+				memcpy(&last_mb, &die_mem, sizeof(last_mb));
+				last_loc = loc;
+			}
+		}
+
+		found = true;
+	} while (dwarf_siblingof(&die_mem, &die_mem) == 0);
+
+	if (tag == DW_TAG_structure_type && found) {
+		if (is_flex_array_member(&last_mb))
+			return true;
+
+		if (die_get_real_type(&last_mb, &die_mem))
+			return die_has_flex_array_recurse(&die_mem, depth + 1);
+	}
+
+	return false;
+}
+
+/**
+ * die_has_flex_array - Check if the given type has a flex-array at the end
+ * @type_die: a pointer to type DIE
+ *
+ * This function returns %true iff @type_die is a struct or union type and has
+ * an array at the end.  Note that the flex-array has no element, it should have
+ * no size and the parent size doesn't include the flex-array.  So it should
+ * locate at the offset of the parent size.
+ *
+ * For simplicity, it assumes the parent size of aligned with the flex-array.
+ */
+bool die_has_flex_array(Dwarf_Die *type_die)
+{
+	Dwarf_Die real_type;
+
+	switch (dwarf_tag(type_die)) {
+	case DW_TAG_typedef:
+	case DW_TAG_const_type:
+	case DW_TAG_restrict_type:
+	case DW_TAG_volatile_type:
+	case DW_TAG_shared_type:
+		if (die_get_real_type(type_die, &real_type) == NULL)
+			return false;
+
+		type_die = &real_type;
+		break;
+	default:
+		break;
+	}
+
+	return die_has_flex_array_recurse(type_die, 0);
+}
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 161f0bf980b6ee6a..9b662db710220522 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -189,4 +189,7 @@ void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types)
 /* Get the frame base information from CFA */
 int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset);
 
+/* Check whether given type has a flex array */
+bool die_has_flex_array(Dwarf_Die *parent_die);
+
 #endif /* _DWARF_AUX_H */
-- 
2.55.0.1032.g73a4cd73de-goog

