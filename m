Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE343438A0;
	Sat, 12 Sep 2026 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192033; cv=none; b=RJ7zXrOF3aq65K8mzB/rHO+Twq7c6pqkcgoiitXiwrKLL4z9KKUd1s6IxLaMBtgNF6+RJiAiede+1SgGL6kFvKwvZX78qPuPpcap9stP5VPpQ3VgsTwoAEvVXAU9E6ujlqyZLALol4H2La8jd0cmv+zb8lig0YbqFZWkqRzoB0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192033; c=relaxed/simple;
	bh=9rTPBRQNFbhkPpWu07uefnMLUJIgUw0iqFOmDICck7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGMBE7BVNjZgFG4Uf+T9NiCcQMgMe1e7zoMTelMsfQqT8uWMTXWDoeol4p43WVpyReI5smiHfL5X69VBc4r3WEb+QPP3RCjRiZ4ABAaB3/D3BSScimUA3ZMC/f1Cm/3fv+lkHDwVXjcatLIRtTHDfih5nQZEjwI9gOEJUfbLYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kExom4ei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kExom4ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7511F0089D;
	Sat, 12 Sep 2026 05:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789192031;
	bh=/lbcpL34xjVfLdT41e2SVefAYol68GxosbShhiJAp/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kExom4eiDy6NqWDOFMkx8p3L1m9z2e+hhx2452ObCDnAuAlCY8rL9ZSHm4lgya3PA
	 gXxTFfjuCXjmWCUKfpJliLtd0+AY+jwjhVNIZA9q9JtNjJgSOKx99UR6RLRfWH2bIw
	 hr5zLy8Dedm2epBtKbNI2Z77uHAv9O3fdurwZYMNYLQj2brLDuLWROD3pE2sksvrqz
	 t4v9NdQqeeiI1dTDeoqi9ouoheRQqBJDyg+2CvvT8kvW+gGYny1O+1aJ6WDP/9264V
	 2OABpyFJDGWVjShN0+IK0DtmFCM4DTdN/89ygfS9g/M+W6VkAY/gbR0zYGgvNMFkuP
	 8RuWQjNVPfrrg==
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
Subject: [PATCH 2/4] perf dwarf-aux: Add die_has_flex_array() helper
Date: Fri, 11 Sep 2026 22:47:04 -0700
Message-ID: <20260912054706.1475583-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260912054706.1475583-1-namhyung@kernel.org>
References: <20260912054706.1475583-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The die_has_flex_array() returns true when the given type is a struct
and contains an array at the end of the struct.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 57 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index d7160f87ac7d7ab3..98d018798fa750ae 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -2180,3 +2180,60 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
 
 	return die_get_member_type(&type_die, offset, die_mem);
 }
+
+static bool __die_find_last_member(Dwarf_Die *parent_die, Dwarf_Die *die_mem)
+{
+	Dwarf_Die tmp_die;
+	bool found = false;
+
+	if (dwarf_child(parent_die, &tmp_die))
+		return false;
+
+	do {
+		if (dwarf_tag(&tmp_die) == DW_TAG_member) {
+			memcpy(die_mem, &tmp_die, sizeof(tmp_die));
+			found = true;
+		}
+	} while (dwarf_siblingof(&tmp_die, &tmp_die) == 0);
+
+	return found;
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
+	Dwarf_Die die_mem, type_die;
+	Dwarf_Word size, loc;
+
+	if (dwarf_tag(parent_die) != DW_TAG_structure_type)
+		return false;
+
+	if (dwarf_aggregate_size(parent_die, &size) < 0)
+		return false;
+
+	/* get the member field at the end of the struct */
+	if (!__die_find_last_member(parent_die, &die_mem))
+		return false;
+
+	/* get the type of the member */
+	if (die_get_real_type(&die_mem, &type_die) == NULL)
+		return false;
+
+	if (dwarf_tag(&type_die) == DW_TAG_array_type)
+		return die_get_data_member_location(&die_mem, &loc) == 0 && loc == size;
+
+	if (dwarf_tag(&type_die) == DW_TAG_structure_type)
+		return die_has_flex_array(&type_die);
+
+	return false;
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

