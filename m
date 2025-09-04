Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579F1D63C2;
	Thu,  4 Sep 2025 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945383; cv=none; b=TyT0FSMMLDndpoqyUUwROVlrm8TlPjAgG1+C5erkFtG2IM115AHMIOMyr7u+TgC4IvJxfBI/j4Zbz2l2JkxnYC5XzptvzuZSnrOMdJpsDQShYW5XqXaKmjjAeEA52Kp1PWy0ep9aC95PBf7RB/UymgaC+hfPS3t9N/fThmRWM0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945383; c=relaxed/simple;
	bh=QgMzLX+EujUl5nFUa6zgdRyiCNDRhy+hzjs8trJUMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE9NAVtUEhbusnf1hp0/pnmMaTDRHCJTbjBBws0cnCMjlKiHvHtcDDdVVd/UemeiGnHNMz8yNsVIVZ9N3+W2FAOOv0sz47EOd2vkS5E/Z0GwVJHAaHSdJn4u97ZpA5AbuoGRgxjZJ7Vrrv13q5cXnMc/+f+VGEvfcJ8ZlD3kEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2Zcl6y9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2Zcl6y9"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so649376b3a.1;
        Wed, 03 Sep 2025 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945381; x=1757550181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG7HgZbRDL9zQbYB/rpSIbCyKAIzwo1Rr8phODu9KXc=;
        b=O2Zcl6y9Ohn2KJmw6NddIUaHknyUN4skT6O/5mn91EDaztAslUpR0BhiMJ2LQIlt6U
         JOs5cNVsKdCljQ67BT9RIBmgrDq85oft6LZ3kVP9nsxKQ6OiI74ouQwi7hSFPXrnkGF0
         MHnF85LIxRFGbnQXOyRNI1Swl6w3st3m37n5d9dUVpGwbbhebaT2J0UdCBxyJOgXTMGE
         cHJkBjpAXM1S77i5JIXyQN7ZTcLH1KTUcPBM9rAclphKx03foJbNf1qkRLJoWC0GfKE9
         YrJCJf4LnDcT3L5lzy0nQ0CDcskYYE1mKXypK++UBO8jyqZrjI1/2UisT2GpNsKCiTR4
         mPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945381; x=1757550181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bG7HgZbRDL9zQbYB/rpSIbCyKAIzwo1Rr8phODu9KXc=;
        b=VNXl8wNefo8EKJRXqU/7uZz0U4UwUpqYmZKtKD0TCn70djTaZjZzTyWIL0rah69SvF
         i1YRlVGyupZXEng9D1ULnADCY04y69DQoARI0RMmuSrJpcri7NqNEn9qARM0e1i/yhO1
         tiVvDhyu2x2Oxl/2xYddwFJAidavyCFGAjbaq2K+r64Vm6DkOwvyVVWflr05u+Muy3DJ
         QSAr9piSLk0l3BGp86g4KWYNiBJ5Xl5HPdOTQv22uw73WlE8NFW/Tbe90//9UgwgSRuw
         LQh1GL5zF16BpkLA9o9OAV29jeRFEdezZM3pA18ksLtRl74/RRrcA2vLy7t4c5HyPTQ4
         82qg==
X-Forwarded-Encrypted: i=1; AJvYcCVs94TP5HfFMqioveDylYxWEitNZHXlXJuq/7Ah6PLtaaMv24s2kobXUrrhuQcaf3I839nwjUBe3Lt3dBCUcpt8k7xp@vger.kernel.org, AJvYcCW7Zr58o+wZoSrWfjrwMOH6dsky0W64fn70dD/dCm9Vf6072SZhl1lvdJeftofHuJBVBQ9DV9effyuIMqm0V+Mx@vger.kernel.org
X-Gm-Message-State: AOJu0YzP27TWf59NTWULp4dREDZMo2PcB3i9vtvGdKuVRRGY9m1qofRe
	pqm4rS/5WqDvsTN2rADCzIFBbq9LH9J/y2sclqUbidw64skiN0U27mP5
X-Gm-Gg: ASbGncvw+ypS+52MX4WT57XV6NHTHLdbszNzKNQ4Jnho5o3IOleJZIMDJXc0BQ56gIU
	X3spHEvJGSwO6hPq/Xt8q3h0i7IQvH9HqDVdDsmxaJSzX+kuRUT1dK5N/ZJxiSQ60dH2V5TvOmE
	QOmp205M04D2nuHiifPA6dmMGoExzanZdP+NKr7i3ixUuOHO6hu41LQmo2qvmhriM5i2G/ay9x2
	tq/Px25lezbxUg6qTCr8ShoaTue1OgtL8Cyz76+rpTRX1tv+JfbghmRMLwA6g3tInnh6BKjq9SF
	pJE/aH6ilFNeF1JurtdO34eKfV1clsoCqGbo0y5t8Q+iPXLk4vJM7BC1zjPTky8J3EjLjE3JVfc
	HkrXLLaQb7vd4hmfBlJDJf0O4vdRZHNaf/nieMlpgp0GhVytP7niRvbtSYYOAN40=
X-Google-Smtp-Source: AGHT+IF8vif2SMyS7b0Y14u6occzXKi/v4yy8ICXoht40V0het8ir2qpLWqnkYrrTJFAlnnbmVHg9Q==
X-Received: by 2002:a05:6a20:3d87:b0:247:65a0:822 with SMTP id adf61e73a8af0-24765a008c8mr6727769637.40.1756945380982;
        Wed, 03 Sep 2025 17:23:00 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:23:00 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 08/18] mm/ksw: add stack probe support
Date: Thu,  4 Sep 2025 08:21:05 +0800
Message-ID: <20250904002126.1514566-9-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904002126.1514566-1-wangjinchao600@gmail.com>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce stack management for KStackWatch using kprobes and fprobes to
enable dynamic watch switching:

- Entry: prepare target address/length and enable watch
- Exit: disable watch

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  4 ++
 mm/kstackwatch/stack.c       | 91 ++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 13ef8c79f855..bc8664af4fa6 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -38,6 +38,10 @@ struct ksw_config {
 
 extern bool panic_on_catch;
 
+/* stack management */
+int ksw_stack_init(struct ksw_config *config);
+void ksw_stack_exit(void);
+
 /* watch management */
 int ksw_watch_init(struct ksw_config *config);
 void ksw_watch_exit(void);
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index cec594032515..3b72177315cc 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1 +1,92 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <linux/fprobe.h>
+#include <linux/kprobes.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+
+#include "kstackwatch.h"
+
+struct ksw_config *probe_config;
+
+/* prepare watch_addr and watch_len for watch */
+static int ksw_stack_prepare_watch(struct pt_regs *regs,
+				   struct ksw_config *config, u64 *watch_addr,
+				   u64 *watch_len)
+{
+	/* TODO: implement logic */
+	*watch_addr = 0;
+	*watch_len = 0;
+	return 0;
+}
+
+static struct kprobe entry_probe;
+static struct fprobe exit_probe_fprobe;
+
+static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
+				    unsigned long flags)
+{
+	int ret;
+	u64 watch_addr;
+	u64 watch_len;
+
+	ret = ksw_stack_prepare_watch(regs, probe_config, &watch_addr,
+				      &watch_len);
+	if (ret) {
+		pr_err("KSW: failed to prepare watch target: %d\n", ret);
+		return;
+	}
+
+	ret = ksw_watch_on(watch_addr, watch_len);
+	if (ret) {
+		pr_err("KSW: failed to watch on addr:0x%llx len:%llx %d\n",
+		       watch_addr, watch_len, ret);
+		return;
+	}
+}
+
+static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
+				   unsigned long ret_ip,
+				   struct ftrace_regs *regs, void *data)
+{
+	ksw_watch_off();
+}
+
+int ksw_stack_init(struct ksw_config *config)
+{
+	int ret;
+	char *symbuf = NULL;
+
+	/* Setup entry probe */
+	memset(&entry_probe, 0, sizeof(entry_probe));
+	entry_probe.symbol_name = config->function;
+	entry_probe.offset = config->ip_offset;
+	entry_probe.post_handler = ksw_stack_entry_handler;
+	probe_config = config;
+	ret = register_kprobe(&entry_probe);
+	if (ret < 0) {
+		pr_err("KSW: Failed to register kprobe ret %d\n", ret);
+		return ret;
+	}
+
+	/* Setup exit probe */
+	memset(&exit_probe_fprobe, 0, sizeof(exit_probe_fprobe));
+	exit_probe_fprobe.exit_handler = ksw_stack_exit_handler;
+	symbuf = probe_config->function;
+
+	ret = register_fprobe_syms(&exit_probe_fprobe, (const char **)&symbuf,
+				   1);
+	if (ret < 0) {
+		pr_err("KSW: register_fprobe_syms fail %d\n", ret);
+		unregister_kprobe(&entry_probe);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ksw_stack_exit(void)
+{
+	unregister_fprobe(&exit_probe_fprobe);
+	unregister_kprobe(&entry_probe);
+}
-- 
2.43.0

