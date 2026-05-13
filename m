Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12DB3AD53F;
	Wed, 13 May 2026 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700683; cv=none; b=RCy1jl3P9Ov2T3BI2Mo/Bs9P3jXm8aqkLQRSCMDPUnnnM7rZDSOYa5PJbanHVfGQZZT6d5QGBLRKgxUSgfwXVZgciQBesCTo3pmXQT0rvoqJ4ak1JNhW+olL5Rlmk7OmdsfZY6vpqHxzJcnT1+0W4bEA+wb9I36I6A6sXFpOd6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700683; c=relaxed/simple;
	bh=hHaDaGS9eAImWZB4NOSQvJwaHxrn5i1WWDhneNY2Hts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rYXa+RSZq+e46HqZ9ykzrggIc3Y3Z7U+XbGhj3zWGAFEwldWJRR3rw4dVS34FDE686gKxIOXo/YeiYaBWCGGKzScUV96jc8fg96xQoAZ18PSHiT28srXOsvupE0VqUc3vlvdSzeR4YKJD1e4QieQcTOcIPTXx/nulfeKAzYoQWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fEygZXDl; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fEygZXDl"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 87AA8C013A64;
	Wed, 13 May 2026 12:23:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 87AA8C013A64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1778700229;
	bh=hHaDaGS9eAImWZB4NOSQvJwaHxrn5i1WWDhneNY2Hts=;
	h=From:To:Cc:Subject:Date:From;
	b=fEygZXDlr9rM9F2EnWUx8mv+tsL2a9eibNoEjVJBJXUTVWBPHTf1+TkAj7+ce2Kld
	 VzbB1TPL9RVP+tYn1G/+uJxUYodSusHauiTyQ52RMd+yWbfm9AZCT+nyI1FnQn9OEz
	 83Bo4pDpdox26fjwYuG5rlVGA+Fau6ftJ90U/eSI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 5E0EEB70;
	Wed, 13 May 2026 12:23:49 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: mmayer@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf trace beauty fcntl: Fix build with older kernel headers
Date: Wed, 13 May 2026 12:23:46 -0700
Message-Id: <20260513192347.4007895-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Toolchains with older kernel headers that do not include upstream commit
c75b1d9421f80f4143e389d2d50ddfc8a28c8c35 ("fs: add fcntl() interface for
setting/getting write life time hints") will now fail to build perf due
to missing definitions for
F_GET_RW_HINT/F_SET_RW_HINT/F_GET_FILE_RW_HINT/F_SET_FILE_RW_HINT.

Provide a fallback definition for these when they are not already
defined.

Fixes: 9c47f6674838 ("perf trace beauty fcntl: Basic 'arg' beautifier")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/perf/trace/beauty/fcntl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index d075904dccce..e1b99b8f55eb 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -9,6 +9,22 @@
 #include <linux/kernel.h>
 #include <linux/fcntl.h>
 
+#ifndef F_GET_RW_HINT
+#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
+#endif
+
+#ifndef F_SET_RW_HINT
+#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
+#endif
+
+#ifndef F_GET_FILE_RW_HINT
+#define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
+#endif
+
+#ifndef F_SET_FILE_RW_HINT
+#define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
+#endif
+
 static size_t fcntl__scnprintf_getfd(unsigned long val, char *bf, size_t size, bool show_prefix)
 {
 	return val ? scnprintf(bf, size, "%s", "0") :
-- 
2.34.1

