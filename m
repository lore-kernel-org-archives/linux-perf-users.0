Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78F3A6B69;
	Sun,  3 May 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836706; cv=none; b=Iift9+2VXhKhciavQu/l3NPmyWbE9SO9Nw3rPh3wpuBl+HetIMJ3f7dsa6fAyt7lMeJln9NsVcZtOSdLKeGohnl7xix8hJ64TNLSkXxZ1VxS4goYV4nlCU9r5trHikxVk/Q1LkE8cvWGKtrYibGU1uoGiidGX8y50OwZFvT5IpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836706; c=relaxed/simple;
	bh=JQPFpeqq261QbCDk1EpY/GFEQYtvoCWxwJbfcuKg9Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZQX2KLfafVEyRSZh08Ttf2OYoFhrs5oQ0cHHimstzsmkIlUJATmk7wWE3MGkXyMGTtK67Zvy0rqp4vApftzXDm8ASzoPAW0yMeNtK/oGo0LX9xU+4DnNlGr4yjkyK0YMGanGYLKoGiKmclx0Q/WRUMmeeQTgS3lfVO1UF2wK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpPRLoOf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpPRLoOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF88C2BCF4;
	Sun,  3 May 2026 19:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777836706;
	bh=JQPFpeqq261QbCDk1EpY/GFEQYtvoCWxwJbfcuKg9Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WpPRLoOfXH1jUVdgatFGjc/jFe8qssvTsb+il4H5nLKSsDSbT6ERVaVc7/2vpQxdZ
	 /n7s0n6MzuEQiaz19P10hupmXlniWjhAXnWVndxUoXhymnKgxJOoyt8aoT+OXU1bZJ
	 4vUrQI7DQ69TwAEHhOQock8mt2o4N45SLOXpEBgyOUTwBGtOd5MChw4DhspeVoJekQ
	 zus2KyAa1d28JNML1zjS0xqhIrgzYMOhJuB6RGrbNF7Pgw/dCgpIKsZqCIi/NcbLc8
	 sEz/wPm5xlK8/2JCO5yz6NUfledduxaPS3cn/D/Uaw3LDTdrAMn4LjGIeEJ1NlvUuW
	 q8/oAJFpYuUPw==
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
Subject: [PATCH 2/5] perf trace: Sync uapi/linux/fs.h with the kernel source
Date: Sun,  3 May 2026 12:31:34 -0700
Message-ID: <20260503193137.27465-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503193137.27465-1-namhyung@kernel.org>
References: <20260503193137.27465-1-namhyung@kernel.org>
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

