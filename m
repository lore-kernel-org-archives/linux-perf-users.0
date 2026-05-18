Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A92989BC
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779126148; cv=none; b=L7OFiRNlV6pAUhwOR2tqJLFHRGbEzXwhYNKrillU41MzkHHCxC+9yX7vLHO+AYMfM3+5ZXpsbENkjnL88yTMqdlrCgvKiE2QqpkI0JQDHT7viJ7JHmfeAHOusop61o3oOsthUjbZAD4qy8NbTSwnjhIY0baFxYYveg/GpIRegMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779126148; c=relaxed/simple;
	bh=qXp7CseHYV8iqbeq1vkUrT4f4UESvv3dJP7LpI5MZ5I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KL91w6JvhAa43JI9XHE59OtZ7R4/FtL4TmGN3dw3+FxeY77rt89yAnOOqeAMLssTU3aKYTntvygo0MBsCpugBvz5DYe95vV4uS8m6mnwuzlNZkVDzkquSU5q9itF47ametBFCTpgpWylyAqizxX1DULcThVu7gUAfr3TEGC3ISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSh+Dfcj; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSh+Dfcj"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13537722193so10297358c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779126146; x=1779730946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ArPDPsXqWxv2tWUpgQ+9DRcdJT82uTP9KMMeLvxS2Qk=;
        b=sSh+DfcjCnn0ap95m4mRnDIZanGWywxVTiSleqX2KOxfrdfPHfSy+qppY5SryL9/lS
         YbB+vccucjJ3x9kfvB+OLY9LMo++9WW6e+VFdnW0H+kf6dQ3RTUzfJp0mzDeBNdEdEO3
         uyqs9JKQRT3TRwnhxbdEoTsRpQvTzyEU66R2BDxKgvKkLiuRhv7zZnkbSTAC/tu0fdpx
         IBH/lWCWNlWElLufgyK4TxVeLYcAjddX1KQI8Do9wh37EOnHBLUgHmMgqOLGsgWpfgU6
         dmG70xkCMAki0+bSJacwWBZOS+nb1C9433MKR7No8mZtiPGvjLSkni8UlpSDN103jNgP
         4VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779126146; x=1779730946;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArPDPsXqWxv2tWUpgQ+9DRcdJT82uTP9KMMeLvxS2Qk=;
        b=GDwPlXPvsVh56hL3/HNxVJRM73rFn+eIA+q0Y180t816SC7zAx4/Z7BeZljUkxnr7p
         sf0QuyIAHaxXxRq1LryyMzTy/uB3aVgolR08ISXjlaBPF7gn5ZYi83AaH5SelJAD0z6c
         UiH6A0Im2jh6gYr3k2SnB0SFhahYPziXDimJG9BiccOj2zwWmoac1TVRVdek14qggFX6
         kae/MIU2FjvGjsIx+mFwOC/XUwtZyHRps2Cyo0DMOpqP2Z/CX8m6O9Z5RnjDkk2sPvEx
         aN1VUCG0YvmCE3aebn5T2pUbtVev6N3VoJ8Rg+/R2rLrQBhfw09K7NYQ1gjGkILHjVli
         MtdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EiFj8FNTkT4iXrroNzO+KO57sY5m1A7jiPF+ACV8G5zS3ozgvyYMIBmvZfkYLuNXf+P/9WOPGdSP51oyqcVbU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7A0QmKQvo1tlyvJDa7XGGGpOrrsgpjJTt0vSKBn9Gpw7yLmL
	v6bCvtBjZcrZLM/fs5Sc3MMqJ6IN4v/8Vtms2EByc/DMSCGddt5CULOPM0mkP4d/gsx0egWFpjj
	K/Et3Sg==
X-Received: from dlaf25.prod.google.com ([2002:a05:701b:2419:b0:134:e337:a5ef])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:922:b0:12a:6902:ddb8
 with SMTP id a92af1059eb24-13504313d47mr7218841c88.4.1779126145365; Mon, 18
 May 2026 10:42:25 -0700 (PDT)
Date: Mon, 18 May 2026 10:41:22 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260518174159.1177549-1-ctshao@google.com>
Subject: [PATCH v6 1/2] perf: Reveal PMU type in fdinfo
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It gives useful info on knowing which PMUs are reserved by this process.
Also add config which would be useful.
Testing cycles:

  $ ./perf stat -e cycles &
  $ cat /proc/`pidof perf`/fdinfo/3
  pos:    0
  flags:  02000002
  mnt_id: 16
  ino:    3081
  perf_event_attr.type:   0
  perf_event_attr.config: 0x0
  perf_event_attr.config1:        0x0
  perf_event_attr.config2:        0x0
  perf_event_attr.config3:        0x0

Testing L1-dcache-load-misses:

  $ ./perf stat -e L1-dcache-load-misses &
  $ cat /proc/`pidof perf`/fdinfo/3
  pos:    0
  flags:  02000002
  mnt_id: 16
  ino:    1072
  perf_event_attr.type:   3
  perf_event_attr.config: 0x10000
  perf_event_attr.config1:        0x0
  perf_event_attr.config2:        0x0
  perf_event_attr.config3:        0x0

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v6:
  Rebase.

v5: lore.kernel.org/20251121230951.3240124-1-ctshao@google.com/
  Added config1, config2 and config3 and print output in hex.

v4:
  lore.kernel.org/20250603181634.1362626-1-ctshao@google.com/
  Removed the first patch in v3 since it is merged.
  Retested to make sure the patch still work.

v3: lore.kernel.org/20241106003007.2112584-3-ctshao@google.com/

 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6d1f8bad7e1c..d88947e9f774 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -58,6 +58,7 @@
 #include <linux/percpu-rwsem.h>
 #include <linux/unwind_deferred.h>
 #include <linux/kvm_types.h>
+#include <linux/seq_file.h>

 #include "internal.h"

@@ -7506,6 +7507,20 @@ static int perf_fasync(int fd, struct file *filp, int on)
 	return 0;
 }

+static void perf_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct perf_event *event = f->private_data;
+
+	seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
+	seq_printf(m, "perf_event_attr.config:\t0x%llx\n", (unsigned long long)event->attr.config);
+	seq_printf(m, "perf_event_attr.config1:\t0x%llx\n",
+		   (unsigned long long)event->attr.config1);
+	seq_printf(m, "perf_event_attr.config2:\t0x%llx\n",
+		   (unsigned long long)event->attr.config2);
+	seq_printf(m, "perf_event_attr.config3:\t0x%llx\n",
+		   (unsigned long long)event->attr.config3);
+}
+
 static const struct file_operations perf_fops = {
 	.release		= perf_release,
 	.read			= perf_read,
@@ -7514,6 +7529,7 @@ static const struct file_operations perf_fops = {
 	.compat_ioctl		= perf_compat_ioctl,
 	.mmap			= perf_mmap,
 	.fasync			= perf_fasync,
+	.show_fdinfo		= perf_show_fdinfo,
 };

 /*
--
2.54.0.746.g67dd491aae-goog

