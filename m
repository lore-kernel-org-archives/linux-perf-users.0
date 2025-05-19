Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AF22171D;
	Mon, 19 May 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690922; cv=none; b=JWRq3dFXLdgLVIz5kgxTgCAC8sB3mOzM8mpznPBjYdz8RwthYuVy38ikKOHbn4rtrUOSBPAhQS+RxO4qKNrez5xLyGejvSVUpfs5kFJaUm0znLAPMX0MYy+c7CyK25H04MuE8pp7JnD4Cw0UkXHJMDo43UmoK38vqsqS4+zIyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690922; c=relaxed/simple;
	bh=KEtAi64eL1fj21roRuyeRfQz0hlDeWxU2t/F8tyzaIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWixfFDlfzgQLdRhHdUgzLOAmAxM2NtJGyKcO4WaqXUICOZWFtVUdKZrXPkf8lNNIB/rO7VAMjo9ODhsdt0ZXJXBJ/rNm+uEsjfnzASHKWomkfYcFD4kqCSa8rJBy3MdvamLZ/W3G6EXSSUDOHPdQeYeOccGWpI8nQNCw/HOG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkZJEc7U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkZJEc7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED652C4CEE9;
	Mon, 19 May 2025 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690921;
	bh=KEtAi64eL1fj21roRuyeRfQz0hlDeWxU2t/F8tyzaIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkZJEc7UNR/3ygjSnnIQ5i0CYgBcFBdamh25CPLUVy7gOX4NMVVrrLYJZPHWH9b+Y
	 fb6xKuuIGHHSkxDGwpqKtylLpSpEj1bwk5/XR0KnJdCcitzGgLWtQEB6McGZX1Vq5d
	 YFAdLoLzDdkMAOeW7TWx20vLaklI+h3fWVO8JVJztisSe8gjBLtD0PbZo8jTwX8JCN
	 uwwjGc9Jdgc7mVNpaeo4Co+qtmY6vjmcocjgyw3ZErKumkvPA7jiSWkCVjct2iJfe2
	 ER9B9RiOEY9D7LswHCpSE4qHcH462LN2Gr6bQ+xGI7TO6rhHywbL6kNA44f/po0W/X
	 Pzhf0Kh4HVyzQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 6/7] tools headers compiler: Pick the const_true() define from the kernel sources
Date: Mon, 19 May 2025 18:41:25 -0300
Message-ID: <20250519214126.1652491-7-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519214126.1652491-1-acme@kernel.org>
References: <20250519214126.1652491-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The sync of include/linux/bits.h with the kernel sources will make use
of this define, so add it to the tools/include/linux/compiler. variant
used to build tools/ living code.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/compiler.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 9c05a59f01842c34..d627e66a04a6192e 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -81,6 +81,28 @@
 #define __is_constexpr(x) \
 	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
 
+/*
+ * Similar to statically_true() but produces a constant expression
+ *
+ * To be used in conjunction with macros, such as BUILD_BUG_ON_ZERO(),
+ * which require their input to be a constant expression and for which
+ * statically_true() would otherwise fail.
+ *
+ * This is a trade-off: const_true() requires all its operands to be
+ * compile time constants. Else, it would always returns false even on
+ * the most trivial cases like:
+ *
+ *   true || non_const_var
+ *
+ * On the opposite, statically_true() is able to fold more complex
+ * tautologies and will return true on expressions such as:
+ *
+ *   !(non_const_var * 8 % 4)
+ *
+ * For the general case, statically_true() is better.
+ */
+#define const_true(x) __builtin_choose_expr(__is_constexpr(x), x, false)
+
 #ifdef __ANDROID__
 /*
  * FIXME: Big hammer to get rid of tons of:
-- 
2.49.0

