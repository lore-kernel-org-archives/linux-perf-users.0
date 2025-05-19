Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B2220F53;
	Mon, 19 May 2025 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690914; cv=none; b=mcvx70cwqAuo80SofyfdyzWLONnFV2N9tFZSb71z5ksjSBn8gNBt7nZh7n0Xy5xyaxc0Nd6Ibk+TlNpU01pl+uhqkNAS4/xY02Kdm1hjGJ87GImmSCPCqQ0pXmCQxVk7jrgg5b20fbJard1MNqHQugyj+ubOO4Muo05sJJ52RHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690914; c=relaxed/simple;
	bh=ABHTPNeUoxMe4QiIS5I9q9cNqFeQQ5os1WOfZQrI2W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXnvcOlb2Y0/AoYpSfCTaMMOi4KnnP42cBzyARydqalDNMKpc+AMDgDcCUsnINIAUe8Micrfhu7xF1EDKKVgrU6c8vO8ahdp1eaEm86COQx9ajf9JZs5IXmRO/sqK76bK21pCGRNGlJbTLROGz2xpKIe7/kjkk+yg9ZOR1YQ/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8fDCn5/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8fDCn5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3E3C4CEEB;
	Mon, 19 May 2025 21:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690913;
	bh=ABHTPNeUoxMe4QiIS5I9q9cNqFeQQ5os1WOfZQrI2W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8fDCn5/R90nOKD4wN1fd6OTU7ThXbHkD1EtnfH62OjsDbXgQQWvqGMdPOMXaGlDS
	 ujbohQuweK+KtAihdYZ6Tn11PzwRidpMri6Wa+YS3edsbtH5I1Wqk2hCfsl+NSUAco
	 d/XINqIWJrD6Da5T8esBjXbS1qAqc0lh49S+VGVYJuekAr8oq84m1i8ALEBEV7U93n
	 Nmjt7vS7Wnmq/9ixd+tf7QOOykFJc0s8/DqC2NBpiJd50t3etzTVZzW4Kg7UnKVO8F
	 qL/U46SVyqVDKkgjYKXN71cG7xcxQvZEbgis1jmLqhIT3faKReZEJ6gOurUQS3JlWe
	 Tqqq8FTAb1VGA==
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
	Peng Jiang <jiang.peng9@zte.com.cn>
Subject: [PATCH 4/7] tools headers: Sync the linux/unaligned.h copy with the kernel sources
Date: Mon, 19 May 2025 18:41:23 -0300
Message-ID: <20250519214126.1652491-5-acme@kernel.org>
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

To pick up the changes in:

  acea9943271b6290 ("vdso: Address variable shadowing in macros")

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/unaligned.h include/linux/unaligned.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peng Jiang <jiang.peng9@zte.com.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/vdso/unaligned.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
index eee3d2a4dbe4d3df..ff0c06b6513eff61 100644
--- a/tools/include/vdso/unaligned.h
+++ b/tools/include/vdso/unaligned.h
@@ -2,14 +2,14 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
 
-#define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-	__pptr->x;								\
+#define __get_unaligned_t(type, ptr) ({							\
+	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
+	__get_pptr->x;									\
 })
 
-#define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
-	__pptr->x = (val);							\
+#define __put_unaligned_t(type, val, ptr) do {						\
+	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
+	__put_pptr->x = (val);								\
 } while (0)
 
 #endif /* __VDSO_UNALIGNED_H */
-- 
2.49.0

