Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693508;
	b=zcEcPCDZqtmxX7/1RC8MhfJ7iPExy3GrmmGU57maTgqoWB80OSeDJS2bCOZO9M0lP5xB
	 2FjxsQngnz39wBQXHejYhrg3BTL9AYp0+b6gOcDNw9ix+mn5e6A1wc7hmvkQJTHAIzuhu
	 gO7IuH8AJA5fkGwlPRTgm7Nqunw7L6IM3nNv/+MlQYbmrmTGibCAu4QEvS07N8k7qurRg
	 7X05WNxyYUgQhF4YHQkZ05bpDGL1g7f9N8kjYBm3xThXV9VSKGd0jjZVQjYfoDlWaokLQ
	 z7EPhX0YhQPx/GM3mbJr82qsmmNRDBp7doqaPgXDr6KHRCiziMMX5dWMHamZSy4J6MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3V2DNkDLfU2DSu2SytskyV8hCqSvepdJ+kYH9To4EK0=;
	b=DR/oD5HuOcvT5H0mk6Vi2O/w6Hp3+w84RmmS5JW8UqVU0oWKnMqhEOAr0Pg5JZ2IsaT8
	 ok296+DmXgXF1z9rN4vh9x1ZAg96J+WxNpO12MPTYixyWm6kNa2c60rQmvJHVIaFV+akG
	 JCFSCJCcO0962YnhQuSu1AWqbja5B8wU6Iy6Dt41m+HAhyTbyn6UNd6FAgXFVyhT2SI0M
	 Sdfw9Q3oJBJZLBY21FlTWnflW/KhjyF+t7Yi7n5QpocPEmxc0eSgjk+lsA+hCZRmg5wEX
	 vBMgql+1SM220z/qmRX5KWSw8W+CnikadsjMvO1U24JdyBTem210yPUg/Shmun5+htg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dlrGEyyn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032A4606A31D
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dlrGEyyn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81671F01829;
	Thu, 22 Oct 2026 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693507;
	bh=3V2DNkDLfU2DSu2SytskyV8hCqSvepdJ+kYH9To4EK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dlrGEyynYOqNixFc8/hXvVlYVLfF9aqIPTbrC+pwHySkNVCJLWMl1XkF8015QOV/E
	 W0AogLVpusyYWOP1MyKD/naxwdHgqS4Pe8YrMdSXDiXEyKEmXhgZ1f5CeucZ+HFVl+
	 bsHwSP3uuANdEDVQSfuSPPr7Ij49Rvf3FXoC7zq6ZxwYCIxy2Er1yPZt3HlRLZTs73
	 EAbIK2F4gpGF1YmULkRyRLIrQATjX4vjDb6tmG6CGRQ8uycTGPSsTs/wECTmWc+pV3
	 yg1e/ZBC8Ww3d7WRDSd4uY203vT+u+YPGbkHa53QajEKQzOKh9RNAKT3FTKSgv6eIk
	 /bJxJdVskPlcg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH v3 08/10] tools headers: Sync UAPI linux/mount.h with the kernel sources
Date: Thu, 22 Oct 2026 15:24:27 -0300
Message-ID: <20261022182431.25673-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022182431.25673-1-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  73b40395c71c ("mount: add OPEN_TREE_DROP_MNTNS_MOUNTS")

That don't result in changes to the string tables generated from this header.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h

Please see tools/include/uapi/README for further details.

Cc: Kir Kolyshkin <kolyshkin@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/mount.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
index 2204708dbf7a583a..ac865edac5173e26 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
@@ -63,6 +63,7 @@
  */
 #define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
 #define OPEN_TREE_NAMESPACE	(1 << 1)	/* Clone the target tree into a new mount namespace */
+#define OPEN_TREE_DROP_MNTNS_MOUNTS	(1 << 2)	/* Drop mntns mounts from the clone */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*
-- 
2.56.0

