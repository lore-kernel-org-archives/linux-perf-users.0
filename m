Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942537DE9B;
	Mon, 14 Sep 2026 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368340; cv=none; b=ksCrapEQYs2Hx6T6wX0jgmjaLq+vms4TNHxvYz4C4BTqTRLTAzkrMYzY1wxEeO/QkUFOFZ0L3NutgSOlVlSVny/MUkkAfQLVHSXjXOw4kKs2G9CWsIiwBQtGyYvWHnb5Blat+msEVxTZcXaxVkJ3BC81sjRdSS97E2GWwexWrog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368340; c=relaxed/simple;
	bh=MGJ9Ucc4PWEmh8U7ndSvxUkdhbYFs9vV1DhMZpv+ssM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fn6lqpKHZhbpLHDV01MUU4yTvHQj60hzobenn4GUqXa3Uy11vxaX010F1TjeqgZU5tkmX9dBkPfGBJJti6B41Q72IqXRDnDYXCymiNbnSHKVm0ywFtMuS9HCS4T4OeNJrCrtH+vPYetf8fItI0IK+iJhn3XLNImCpiam+Ue4WVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw1GWC4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw1GWC4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82071F00898;
	Mon, 14 Sep 2026 06:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368339;
	bh=ymdYKBbVAY1WyUZy4e/FNcP10X3wEv3fOcy73P04PFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lw1GWC4HGoazzLOzbso/NpzFMV8qeociYKYcm8AGThhuX24PlapEs2eAVRCVOGeOk
	 eMOsdbIMF3MSLk6/MBwgyB3yDTHU+6ZSCI/I4d8sBrFgFoJeQM6yu2x8a54Ew8xRU0
	 Zbj9H1QWOjiinrN5kYahZMneIFCPk2pItDagnCXpLmpiVbmlFkKhBqrW9IjslSPzqi
	 Rg6FRv5RxhzRAUSljbONzeWZAUgl6H2MRkN+wKx11wqf7warTeEsZDcWn+huDPwD9a
	 gIpP0GLTrBB4uzW4IvieSA842bG+YhnmJQy3Lkzqr79OSzJ1gH24Nc+/SkdXYCM1SW
	 RqmVVIxMZ/T7g==
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
Subject: [PATCH v2 2/4] perf dwarf-aux: Add die_has_flex_array() helper
Date: Sun, 13 Sep 2026 23:45:33 -0700
Message-ID: <20260914064535.1671939-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260914064535.1671939-1-namhyung@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
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
 tools/perf/util/dwarf-aux.c | 77 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  3 ++
 2 files changed, 80 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index d7160f87ac7d7ab3..465824e6513eb0ac 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -2180,3 +2180,80 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
 
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
+		if (tag == DW_TAG_structure_type)
+			memcpy(&last_mb, &die_mem, sizeof(last_mb));
+
+	} while (dwarf_siblingof(&die_mem, &die_mem) == 0);
+
+	if (tag == DW_TAG_structure_type) {
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
+ * @parent_die: a pointer to type DIE
+ *
+ * This function returns %true iff @parent_die is a struct type and has an
+ * array at the end.  Note that the flex-array has no element, it should have
+ * no size and the parent size doesn't include the flex-array.  So it should
+ * locate at the offset of the parent size.
+ *
+ * For simplicity, it assumes the parent size of aligned with the flex-array.
+ */
+bool die_has_flex_array(Dwarf_Die *parent_die)
+{
+	return die_has_flex_array_recurse(parent_die, 0);
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

