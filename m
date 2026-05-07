Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E54435C1B0;
	Thu,  7 May 2026 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138801; cv=none; b=cu7+DCijS1oB9wVuw1Wh54UP6Edpbbj27FHjbqAqjYgrNqui3v81VpMkzVG8VxQeVgyPW5QBedc0LutxVxaGXNih4sQ44y7QtW3w6HCmFoNlXI0mTqRwyAl1koyAQIEXDp33BhNCxNz7M8SVL1XFPyrEpnzChiGya+w7d7oUu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138801; c=relaxed/simple;
	bh=JQPFpeqq261QbCDk1EpY/GFEQYtvoCWxwJbfcuKg9Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E72ZE1sLjMVLRMUGr8sYpalzUApO5zPaZiK3W0QEqZWF9k9MrgRrwErSZkrC0CDSy8TXPPh/HspJjHVbWvYcZdZmJxvqF44HPxlVRpR3uuHaQ7B9zqzR6ZK2Cf6BcdXjNcxlJoykxyA1XVRQ+JmAee3Q9x6m4VNFDwfOn7ybSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kkwlldw6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkwlldw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D178BC2BCB8;
	Thu,  7 May 2026 07:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778138801;
	bh=JQPFpeqq261QbCDk1EpY/GFEQYtvoCWxwJbfcuKg9Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kkwlldw67U8UPWyxJDyl/Fs9T+KPw40KcG3RdbXM637TnkRxa7IrycVW/sDEGdE6v
	 Z+rv27wUeOYHe4YoIJO1mFHcPppBRRiJhMfCpqNu3Wa589jmzJC9IZ94EtcCVlxpnO
	 RGKE2Vbt1VZQ0Fw8YGJVPkI9uiF1zSyqKppapKd3LHjErUtTaNvQzRFb4Vg8Kh6lwE
	 jLhnQSq2Bq8dTSQteOkbPFBRy6+XKayYOuE8GAhiA/tjKHyDsU1hmb8cwlAoxkWvxe
	 Lg7vVRDtJblHH05LOlMb+v6EpwwPQ2HkzDiJZ/ExxnQokyDCHoJf2mzX6GAp9Lo41Z
	 ET+Uwd64XO0TQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/7] perf trace: Sync uapi/linux/fs.h with the kernel source
Date: Thu,  7 May 2026 00:26:27 -0700
Message-ID: <20260507072632.37152-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507072632.37152-1-namhyung@kernel.org>
References: <20260507072632.37152-1-namhyung@kernel.org>
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
2.53.0

