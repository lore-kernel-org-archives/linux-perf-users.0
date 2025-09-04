Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C51B0437;
	Thu,  4 Sep 2025 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945373; cv=none; b=gUlKT2JMFooLeP2CRvUnfLII4ySIilH6Usc5vKD6DHlrl8uj4ztlRv+MDWGl32UlLminP32I8LjCE8Xt24mo9SeqCEu7uLpc7G8F6zAVryZgPpisgh0ONJdIWGTfH9ai6+pfYH6zeMD4Ozmwy66XiRxBbuiGxwo6kJTxdHlstFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945373; c=relaxed/simple;
	bh=O+PIwdZUlhV7lswiRN6FobRcgHyGWoHJZ0R7vjxdAx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8Ve9ZmneqZpRFl7uX6/czQolTU0lHmbqlSf8GgCIaeFoCZ8tCeBvMsHo2vSkIrC+nX8NZlcBoIsADlkvyOTfwjLd+Evj8LuAxc/AFoc7K/QdHZa4yOGjqmAzpZpGJlzf5aIKwZQgSIN8rWK73uMb64g3rR8lmbWuod+c1mDfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfU5BWzv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfU5BWzv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77269d19280so447658b3a.3;
        Wed, 03 Sep 2025 17:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945371; x=1757550171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTZRFEDtbchH98AsRwMn3UAjgd97CVQoF2+IU9lNOKA=;
        b=NfU5BWzvP4hH/KIpSKs3EKhou+1TjjjraMbe8wUdRZj5jkkJ75BcDPOciyJOeUY1MM
         8/0BC3Sv8pO50DVQJarIZGzGiKPSljLGWXR6jluZKdAMTw8YRmBYXsO3iJGo2GGaX80p
         BJsGnv7AIypN/T5u+8PpMqxv4PdpnuVnPizywuIqdU0mFH3tVsVAt3n1g0WSADfqMDbJ
         3e4DFSTykO20jucjBLinayOzwTAujp/FbrExcfSo2rnWORF2o0xhb0ydjlYkKsY9d5UJ
         itXPSp1SQNJaJ7oUyC4flGZNuT6yYbzn+p+/fCjtxoi6PAa1OIgR5t+S+0pwVXVAxMmw
         MO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945371; x=1757550171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTZRFEDtbchH98AsRwMn3UAjgd97CVQoF2+IU9lNOKA=;
        b=EapLN8QrFxZamQvRo0WIY+YYFlVOgbk68a+WLxz6NmVPTanFsGz+R63PZ2y5MalQRi
         fMETKhvty3V6va9FvHylw5xLWnF75nVHdjg7KqHyQ8GKCLe3Jh1MaBPqxyT+YvIj6Vfh
         to7Vkdpz0LyzmlRgDxeiv0TAsA2C9W70ld7vrhNrg9ZGYf+riWlu05MdMSQ29fH8mvfI
         bXYXk5867EPsmL9OMRjl8S44G/u1O/fe8EDb4C9wPUNQkW3nFva59I53aB+SsY5KNQRA
         f35hJdxAP0rfgsWyStS6RrlRKrIYcYePbIErR3wlOr6iN8ijNRhFrNzahiFBie9p6kOx
         Qfng==
X-Forwarded-Encrypted: i=1; AJvYcCUKE/O4X0KrGDa0NHpv8ySuftd+qTYjL19bIFWoxR7OYpzDJaMa63TxSoua+s6L2NE2XCAqAV9kL9FVlQIst1Ig/PTV@vger.kernel.org, AJvYcCUW23h8dOGwtbLGn6ixHafiV6O2eQSoeFmz/ITHvZeGaldFXJZmJUO5cRjDUJu4dwe/ojUC9Fe3mP/Irc3NqPF2@vger.kernel.org
X-Gm-Message-State: AOJu0YyWvjfuns4mMFTQ6HQgRDe6+atlzRxKlh7P6G0eISrB3FOOUwWm
	y1QbqN51S62JMqapCkJOFLrnd3K3Abwa8vNFEIIeic7LYy3Uk+Zdrrt6
X-Gm-Gg: ASbGncu/EH2m/GdoTHIjuFkbx19l7/rG64x/sccQZkrchxUUoUz8TvnCkTsC2GFqZgN
	5Nn5fi0/0clZOJS4dtEeaKnPWThAyW3mhTOnQrYGpg3hxKk7e7Yojbt1LJTaLZmTwvB21YDx6FK
	SyND3wxwDa4i/UCuqW+HX3vuvjV/kJo5+My0alXz4pFxIC/5r/Y0tCF3blzUxlvony0/89nlT1O
	4CcdfXs7ffy23aAnY7jYzzmjq1j/XMBiheDihG6r1Vr2LwcuR5+ICMkMwl3vk6TbZ2DhmvZmHgG
	YwHeQdnhlg1rH7UvTffpQyOLe/05BnJmWFZGOvNmVc/Dv0MKea0yGRJ2ZN7uqy63HsPq1FUAYWe
	vf6+F2sdDLDAN1T/rtuiqquz7QKcg+fd9SyqunokofoaUeIJaf2Y2/+B8z+aP8hw=
X-Google-Smtp-Source: AGHT+IGWU73oT/VaQcAznSm7YzjNOZbgfBD0gmg8RYjxK7cLGZgpVNX1W3T0EI71ND9cLoNXP4e0sA==
X-Received: by 2002:a05:6a00:4f81:b0:772:60b5:957b with SMTP id d2e1a72fcca58-77260b598a8mr16120493b3a.32.1756945371106;
        Wed, 03 Sep 2025 17:22:51 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:22:50 -0700 (PDT)
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
Subject: [PATCH v2 07/18] mm/ksw: add atomic watch on/off operations
Date: Thu,  4 Sep 2025 08:21:04 +0800
Message-ID: <20250904002126.1514566-8-wangjinchao600@gmail.com>
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

Add support to atomically turn the hardware watch on and off without
allocation overhead.

The watch is pre-allocated and later retargeted using hw_breakpoint_modify_local().
The current CPU is updated directly, while other CPUs are updated
asynchronously via smp_call_function_single_async().

This allows KStackWatch to switch the watch in kprobe/fprobe handlers.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 +
 mm/kstackwatch/watch.c       | 97 ++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 2318779bde70..13ef8c79f855 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -41,5 +41,7 @@ extern bool panic_on_catch;
 /* watch management */
 int ksw_watch_init(struct ksw_config *config);
 void ksw_watch_exit(void);
+int ksw_watch_on(u64 watch_addr, u64 watch_len);
+void ksw_watch_off(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index e7ed88700b49..c563f8d17829 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -16,9 +16,21 @@
 
 struct perf_event *__percpu *watch_events;
 struct ksw_config *watch_config;
+static DEFINE_SPINLOCK(watch_lock);
 
 static unsigned long long watch_holder;
 
+static struct watch_info {
+	u64 addr;
+	u64 len;
+} watch_info;
+
+static void ksw_watch_on_local_cpu(void *info);
+
+static DEFINE_PER_CPU(call_single_data_t,
+		      watch_csd) = CSD_INIT(ksw_watch_on_local_cpu,
+					    &watch_info);
+
 static void ksw_watch_handler(struct perf_event *bp,
 			      struct perf_sample_data *data,
 			      struct pt_regs *regs)
@@ -32,6 +44,91 @@ static void ksw_watch_handler(struct perf_event *bp,
 		panic("KSW: Stack corruption detected");
 }
 
+/*
+ * set up watchon current CPU
+ * addr and len updated by ksw_watch_on() already
+ */
+static void ksw_watch_on_local_cpu(void *data)
+{
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+	struct watch_info *watch_info = data;
+
+	int cpu = smp_processor_id();
+	int ret;
+
+	bp = *per_cpu_ptr(watch_events, cpu);
+	if (!bp)
+		return;
+	attr.bp_addr = watch_info->addr;
+	attr.bp_len = watch_info->len;
+	attr.bp_type = bp->attr.bp_type;
+
+	ret = hw_breakpoint_modify_local(bp, &attr);
+	if (ret) {
+		pr_err("KSW: failed to reinstall HWBP on CPU %d ret %d\n", cpu,
+		       ret);
+		return;
+	}
+
+	if (bp->attr.bp_addr == (unsigned long)&watch_holder) {
+		pr_debug("KSW: watch off CPU %d\n", cpu);
+	} else {
+		pr_debug("KSW: watch on CPU %d at 0x%px (len %llu)\n", cpu,
+			 (void *)bp->attr.bp_addr, bp->attr.bp_len);
+	}
+}
+
+int ksw_watch_on(u64 watch_addr, u64 watch_len)
+{
+	unsigned long flags;
+	int cpu;
+
+	if (!watch_addr) {
+		pr_err("KSW: watch with invalid address\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&watch_lock, flags);
+
+	/*
+	 * check if already watched
+	 */
+	if (watch_info.addr != 0 && // not uninit
+	    watch_info.addr != (unsigned long)&watch_holder && // installed
+	    watch_addr != (unsigned long)&watch_holder) { //not restore
+		spin_unlock_irqrestore(&watch_lock, flags);
+		return -EBUSY;
+	}
+
+	watch_info.addr = watch_addr;
+	watch_info.len = watch_len;
+
+	spin_unlock_irqrestore(&watch_lock, flags);
+
+	if (watch_addr == (unsigned long)&watch_holder)
+		pr_debug("KSW: watch off starting\n");
+	else
+		pr_debug("KSW: watch on starting\n");
+
+	for_each_online_cpu(cpu) {
+		if (cpu == raw_smp_processor_id()) {
+			ksw_watch_on_local_cpu(&watch_info);
+		} else {
+			call_single_data_t *csd = &per_cpu(watch_csd, cpu);
+
+			smp_call_function_single_async(cpu, csd);
+		}
+	}
+
+	return 0;
+}
+
+void ksw_watch_off(void)
+{
+	ksw_watch_on((unsigned long)&watch_holder, sizeof(watch_holder));
+}
+
 int ksw_watch_init(struct ksw_config *config)
 {
 	struct perf_event_attr attr;
-- 
2.43.0

