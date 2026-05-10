Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6A28504D;
	Sun, 10 May 2026 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444635; cv=none; b=mq96wXBGt1t9BWilWYETpO4xiSa0kBAGxUWTPFhSA3TAFK1433RwxoT7DvgG8PAL2dLHRIIyjBzhDib9uxkdOBU4hv+0BSMAvJN5YFgVK5xoCimFQ+k3A8fCEo6MMYUELNniDBOjlmnyrVDtUL4rYzb4Wkr+mGwKLO4wbJtJhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444635; c=relaxed/simple;
	bh=XbJlDVsxh+4J+3Dpzziq7UdjXEZ81sqQYS4/VuN59Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmT9GoYg8VQwag4nOum7Yk+n/5tPSaskkej7dbfschD/KEd+IMR5o0+2V1cVfjcbiVwvprC2hmvT28Va/dnoTUYd0GK5myRDIgjlYxIgimuoaBNzvNZveElVsyzr6ctJNRjjf3zSxckrpQc/Rsvk5MqXfGWd2AttgAv4dbcUJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppqi1g32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppqi1g32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DD1C2BCB8;
	Sun, 10 May 2026 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778444635;
	bh=XbJlDVsxh+4J+3Dpzziq7UdjXEZ81sqQYS4/VuN59Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppqi1g3260gGoVU/f1Mjpeo8mKM41brVpbwXfSpZMeGeWJ6LnlwJe2S5s0SGZFpu3
	 jSDFpo946OyYiw3A993PGmRn2wDFGc1lzwiehw882krt3hmx+7Or023RNj20JMf4QD
	 JCz1hGk+DJPyC3vsDl2Xoz2XpmFqqVnCvyYIHlCihH16vbj+egMULfxIOeuO8u1JUV
	 evBAzYWOYAGQAjS1dFTiyOy+3rKupe1vJmMHzdCTpJbWfPRhFIUEQE/Y4EgkQV+2gC
	 uY/tqqZ2Lkn+0qJT+N3mUnKX8ZMYGBsElJWMqB+4ngfpv1FpS/eysC0o9in8LmOwj6
	 YicsWUFt06/EA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/7] perf trace: Sync uapi/linux/fs.h with the kernel source
Date: Sun, 10 May 2026 13:23:41 -0700
Message-ID: <20260510202346.49853-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510202346.49853-1-namhyung@kernel.org>
References: <20260510202346.49853-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

 1f662195dbc07a66 ("fs: add generic FS_IOC_SHUTDOWN definitions")

This would be used to beautify filesystem syscall arguments and not to
affect builds of other tools (e.g. objtool).

Please see tools/include/uapi/README.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/fs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index 70b2b661f42cb6e5..13f71202845e8f9e 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -657,4 +657,16 @@ struct procmap_query {
 	__u64 build_id_addr;		/* in */
 };
 
+/*
+ * Shutdown the filesystem.
+ */
+#define FS_IOC_SHUTDOWN _IOR('X', 125, __u32)
+
+/*
+ * Flags for FS_IOC_SHUTDOWN
+ */
+#define FS_SHUTDOWN_FLAGS_DEFAULT	0x0
+#define FS_SHUTDOWN_FLAGS_LOGFLUSH	0x1	/* flush log but not data*/
+#define FS_SHUTDOWN_FLAGS_NOLOGFLUSH	0x2	/* don't flush log nor data */
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.54.0

