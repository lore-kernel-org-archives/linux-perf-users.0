Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CF331A5B
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203103; cv=none; b=F159NAelRSYkZRqoYyrrUldCEhy9Vg4A+LM7aGBFU9cJgMbhZPi84ZpjiWhAM2Lveu6uXe0BKHNIQrm2iUi1rOviW0XScZ0yqcX2GbYQD7UMI5OKplJApjNr5aWDojzBa82nv4ARQBA5Vg/uNyn+ASTqh0x5pez+gnMo+l3LCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203103; c=relaxed/simple;
	bh=tYtQxBgUqKR92NbcYX76PhLlJU93RkKFpHKXGXIMEl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3m6nO8kwxTcSjQUuA32GPxcUPg3ri+0SMoPyajCCnWKqyjTWZUJJFv7k5+hUHGez/2ts804jeWtrZICbB5MwsEa4pWDiJFiH9IjGjJPKWjpcobrTve0TOOXF4RU/JBDLDmB1VKTrwx2aNexPPjJwQpwZgPnLvJiBAERvxZmF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMv/DcX/; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMv/DcX/"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so5100730a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 23:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768203098; x=1768807898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjuUi0QUA6RJxii/d5muuv3zhVxVzqbMxj6gCIp3Xjo=;
        b=TMv/DcX/9H5Zj7F4oGJzA5Zot5vGozuZ2Aa9yL6rjECZ1ZuhcYqDbZKmHSB+BAA31X
         Tuu7m8nRW2Evu1MUs4qbICZGqXcpvllQkevh3eIkAjYxOo4XFUGeMBUzj3u6RVy6Zk9X
         HVeBrcFEVze48Fo7HrbDf4cz3irJi+AElU5Bq7Q0etUf9mEMIATsNJr9yM57FT7sz9zw
         l5TExde9Sa8xKfjues99AeFZOOvp2LTeAyLmavqT546154dlm0Ve2X214pmRavdpzxXI
         czAivndFH932QqWyFez1gk4LXu03JnBw2ElR48GpOT7WVHzsilR0MFHyRsNxzxy8CqV0
         zIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203098; x=1768807898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjuUi0QUA6RJxii/d5muuv3zhVxVzqbMxj6gCIp3Xjo=;
        b=kL7YkUp8VA22uk5CnmHsN7J0IP8srge9jOPYm4x8MQ4XjPSO4EztWDAWyci5DbPvVM
         +veusnkdVuyyytDp117h2EEAKNR6Rv5EQRyjztu7WLSAfVmbdBAgCa/HZzHhEyV0jmlL
         emPe/cchUlDPthMrX6t/kpYykiqKTf3sr8Bt+lOOpdGyh4QMT46j79l30JQ+c860qQpo
         IlrXiXq3buWIngLFIpReP5pVB6PR7RScrbnIS2roiRQ2GC2AJrJyFT9u1K1YoMbxoF8W
         K7CdrzV0awkAqlSBKUo0YoFko7etnyyooc9Kzc4E+KVj7wW6hfnFt7ipAuAxWxSOJnJo
         mfcA==
X-Forwarded-Encrypted: i=1; AJvYcCVzKeib3eCcWl8INVd7nszbQs4+spoF+o6X3KRdbJy/W+yE7qDOhGWveN+QBL9/f6EvgGmHqRQrvUmCTaqV5dul@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JmqAcJOzln6/+euwOAqZt+7wC1T/z3IFijVF5Glw9nTROhjN
	L9ecE7X6XT2FgpeoZpdkJPMzZd64r4tlNuNNbWQd/Gck6c7ddf0Qd/Ci
X-Gm-Gg: AY/fxX5RZCcat+qrbD9EIgzZqMv3H/Vo+G+7HV9xisBnl0V8y2ZN09luijcOBWCtaWS
	GKl/ch9bEhOZatNx1FaktmYRjxhQk3BEI9UG96jKdHGeZUrcnAJvKT8y45k6Ng+1y6tIcrMrE6C
	TMJr4xPdYHF6ZFitAJ4GTOWAYqT0CbfFISjLhKkZNH3IZtsrXRbFmsCZIx88wUcMa0bcdWydvFl
	35AqQZ5iOV9v9uEarCK7FbjHdBdvvoUNM2pwmfILM4hbZcFRs3fwTP5gkyuB7fMRs3zlqk5TS5g
	jRb1H5PNgpx7/uZuRWLxYVMAb1NTV2HOZkbVZH9PZLjrASl78Exaw+bbu655hjilJugiQygxG2p
	aO/TbKbi+VOcrFYrLPmMc5v97CPO9+kwuJkO0yRsNviV2IGxefvkfPGcHO7lIhNIClVREpTVpQA
	5AiIzVBjrPoqyRf/PImzPKM635sKPt
X-Google-Smtp-Source: AGHT+IHBPvUsY13KtoTRsogdm/bRlWq0gO1v0k4y7rzb1fO/rxnKYPUBI6NqEG0WWU38DlPQik1nWA==
X-Received: by 2002:a17:90b:4b85:b0:34c:fbf0:fa55 with SMTP id 98e67ed59e1d1-34f68c4d727mr15921794a91.21.1768203098011;
        Sun, 11 Jan 2026 23:31:38 -0800 (PST)
Received: from PC-YLX55712.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6af4e14asm6732798a91.1.2026.01.11.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:31:37 -0800 (PST)
From: Wang Xiang <xiangw985@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	yangsonghua@lixiang.com,
	wangxiang3@lixiang.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools headers: Sync UAPI linux/openat2.h with the kernel sources
Date: Mon, 12 Jan 2026 15:31:25 +0800
Message-Id: <20260112073125.4115607-1-xiangw985@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Xiang <wangxiang3@lixiang.com>

Since commit 3d6cfbaf279d ("perf beauty: Introduce scrape script for
various fs syscalls 'flags' arguments"), the file
tools/perf/trace/beauty/include/uapi/linux/fcntl.h includes
<linux/openat2.h>, but openat2.h was never synced to the
tools/perf/trace/beauty/include/uapi/linux/ directory, even though it
was added to the BEAUTY_FILES check list in tools/perf/check-headers.sh.

This causes a compilation failure:
  $ aarch64-linux-gnu-gcc -E
  tools/perf/trace/beauty/include/uapi/linux/fcntl.h \
  -I./tools/perf/trace/beauty/include/uapi

  tools/perf/trace/beauty/include/uapi/linux/fcntl.h:6:10: fatal error:
  linux/openat2.h: No such file or directory 6 | #include
  <linux/openat2.h>

So, now we need sync openat2.h from include/uapi/linux/openat2.h to fix this
dependency.

Signed-off-by: Wang Xiang <wangxiang3@lixiang.com>
---
 tools/perf/check-headers.sh                   |  1 +
 .../trace/beauty/include/uapi/linux/openat2.h | 43 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/perf/trace/beauty/include/uapi/linux/openat2.h

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e0537f275da2..411a45d8f9f6 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -95,6 +95,7 @@ declare -a BEAUTY_FILES=(
   "include/uapi/linux/fcntl.h"
   "include/uapi/linux/fs.h"
   "include/uapi/linux/mount.h"
+  "include/uapi/linux/openat2.h"
   "include/uapi/linux/prctl.h"
   "include/uapi/linux/sched.h"
   "include/uapi/linux/stat.h"
diff --git a/tools/perf/trace/beauty/include/uapi/linux/openat2.h b/tools/perf/trace/beauty/include/uapi/linux/openat2.h
new file mode 100644
index 000000000000..a5feb7604948
--- /dev/null
+++ b/tools/perf/trace/beauty/include/uapi/linux/openat2.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_OPENAT2_H
+#define _UAPI_LINUX_OPENAT2_H
+
+#include <linux/types.h>
+
+/*
+ * Arguments for how openat2(2) should open the target path. If only @flags and
+ * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
+ *
+ * However, unlike openat(2), unknown or invalid bits in @flags result in
+ * -EINVAL rather than being silently ignored. @mode must be zero unless one of
+ * {O_CREAT, O_TMPFILE} are set.
+ *
+ * @flags: O_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
+ * @resolve: RESOLVE_* flags.
+ */
+struct open_how {
+	__u64 flags;
+	__u64 mode;
+	__u64 resolve;
+};
+
+/* how->resolve flags for openat2(2). */
+#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
+					(includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
+					"magic-links". */
+#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
+					(implies OEXT_NO_MAGICLINKS) */
+#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
+					"..", symlinks, and absolute
+					paths which escape the dirfd. */
+#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
+					be scoped inside the dirfd
+					(similar to chroot(2)). */
+#define RESOLVE_CACHED		0x20 /* Only complete if resolution can be
+					completed through cached lookup. May
+					return -EAGAIN if that's not
+					possible. */
+
+#endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.25.1

