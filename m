Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72A481DD
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144537; cv=none; b=V58fDu74Z0whD93OFLk7Lo8wfZPlvbJy+0el15c1nJKFQ0AIfP5+qWEoO+LRZAJoqJY9LjxEdstk+QFGecqmRywojjcdf98A87SzwhQn0jV/mx6QmjR6W0zWBZcPme0RiitkDbw7xn7IBx/Qb/m0exr7nfEa51GQqKicMcwkcoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144537; c=relaxed/simple;
	bh=Q8F8GOrNpztTu8ri/FXCt89INicdBfENhX7D8zuGzp4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RMkPJsCCPxr3AfTVuL5kAw3AXOYQ95DAcwRCg9aQrw1CzHPpSvaKrVljgmoS3jyd9wWt60tXH8+/kklnoDaYE3jaX3oPm+hcdA4MHlBrOWaZIxM/TCOy+9OHK5Y4PI+/G3xxYBsavAaP8kfsJQyXyeJvyxwqwhp0IM0B7LJ5IjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2JSZj9A; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2JSZj9A"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1306c2f7037so2417785c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779144536; x=1779749336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wHBpvHVKDIno27yjod8WSj85854CldzftU6Bn44aU2I=;
        b=L2JSZj9Ak83wOdDS58AWffrAnzKHRg2Hgwq20+59uudWI5/HOEDHA/l21QBTgM5DgL
         vINrK36Fo4rz8dG9rInVB50V2evrosf8bmWkBqkUCGwSXLRIJ4koTQpQaU/QiGHvIRiR
         oojCs/vljXRHvjN+DwU0z6S1kdqJGKg1KBbEY/IEa3CeZhdbnJD9M4JutrQvw/59ePI6
         Og3q8am5WK+lFc79UhJylKa+XkrHZZnXcNPfRP3ZiMZ/A7Rb4eKVSXxHWgX53rSd6jnH
         PmsdXu9QZr/8cFBr4DUnKrdJQJzmlfmjc4S+Mb0In4S1ntADAlfnEzDM+mIyVyG60D09
         fs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779144536; x=1779749336;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHBpvHVKDIno27yjod8WSj85854CldzftU6Bn44aU2I=;
        b=D0t+Ja1Hz7J7KDYw3YLLyqdsoSyWoSw2hIFZjzugZY+fGk206pI6UoVz/pOpleOsjO
         LTQnZ05ch9kizXWTYxp6S76eqNeIYHYypFOOqTB9eTYPC8EZLfHa6gfa2asu9QRgpo3/
         bOCeO3pGMyG2qHYJl4e/QuR4Pnaqqm04CXKbiUuvalWs2qExC2S1upEvk1i79vveL/0P
         Me+DGfrjEn6aGJ+Km2TwpeHUGr5SbzEtyXWJHXcb004/gWj/cuaL2JyCoJjXVlOgp1As
         JnO5nDyZ1YmTeWmrLfHlENLam8B0qqDqrQU6WDf53eegfLZSf2RyFEFmAlwDO2nwegW5
         J23w==
X-Forwarded-Encrypted: i=1; AFNElJ8eZGoGNB1cfei+NkiXwDZKzkcFFHsPc4iQ2aapIKjhjV/YgqlcyqjiQnkBz4JGJeE47jEjnlnVcdwRP+AQ9QrU@vger.kernel.org
X-Gm-Message-State: AOJu0YyQE/toZNjU2+yvE5y1uXEUl98z7b3ooDnQDIazsOXm8zBOUucy
	ivrLXNUc7/sQ6WfoKVfltOL7S8+BDEEB/PH0lR3r5oiZ00G8XDRerMlO/SYwMUbh2s2VkmwjxaZ
	L0kBKuw==
X-Received: from dlbrh6.prod.google.com ([2002:a05:7022:f306:b0:12c:1f83:7b4c])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eacd:b0:12a:6c7e:bef2
 with SMTP id a92af1059eb24-1350440ae0fmr7701247c88.7.1779144535419; Mon, 18
 May 2026 15:48:55 -0700 (PDT)
Date: Mon, 18 May 2026 15:47:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260518224819.1247382-1-ctshao@google.com>
Subject: [PATCH v7 1/2] perf: Reveal PMU type in fdinfo
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
v7:
  Fix a leakage found by Sashiko.
  sashiko.dev/#/patchset/20260518174159.1177549-1-ctshao@google.com?part=2

v6: lore.kernel.org/20260518174159.1177549-1-ctshao@google.com/
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

