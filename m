Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770172848B5;
	Wed, 10 Sep 2025 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481966; cv=none; b=jLft9hfdjh6MW+/KAn2S5YKtNiXU0JObFQm8UgHeGEGZm2UsxlzYSt/2bXKCs8+HfnONytZ3wBcmr4Vyr7I5E27qW0G6BCPA+4MjfDBlZGiqV5sRqLhWyR1bX2F5Y8PkukEwbVvLe12H7oC3xVYj+2MuMGDRJaIy7WG2iijlEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481966; c=relaxed/simple;
	bh=K2aOQKGkezRFrr5k+OSEpiNgla9WAzcTPd10dtBmhRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G08YU6hkBFohddgwXi0AviW3jawswHnJ6rqf3ShC+0iLxESCnnuvUgyvEezZ53q1gMve/tnEQeekwhEpGUtsp7F+beu9xiLRY5/RCnNRBSSN/sb8TCW97fffWRRlrPzKxMWFhF36fP1szFDRyysXIYvXfxWlwm9GZwnWl0Y7zPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndeuLEfc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndeuLEfc"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso6909073b3a.1;
        Tue, 09 Sep 2025 22:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481965; x=1758086765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cGC0gkaVd18/Lxr4eoS+A1o44ByCYajfvvOspb3trU=;
        b=ndeuLEfcl+9lfY1LHbvrW6tR5m6Wts30KrjMXF5nZX5AVXze2Xfc+85URw8a3xzthf
         2HwOocVN0aiQThKqnfVLDOV2CQMCQ9nsfCm719DgzlabkswRTG2hK9WWhLkvHSJqYgtW
         Nb5OIY1Kdjbk/31DnZEKQCGQQeSZ9RnVTtQHctCVyKsJQSKNRv2tFTtd9YpaxiKDjlOe
         OMQh8d1RiOSpeER3WDFSvyiDhK3BDk3GnHrAWDMwN9505Nm99DlreN5U1X9Vou8K2iIB
         Rj22EBuCIenYCVq68qHio/OIT7V/0dQolVmxEGF9oi5lWRtSGmrT9vcDVqE5CW7uQSzY
         9c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481965; x=1758086765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cGC0gkaVd18/Lxr4eoS+A1o44ByCYajfvvOspb3trU=;
        b=a4fvjKEDv9mQrPR/ylRIazsDtgU0gfEyHnTKLQC8/bylTYFf/hEWRABTZhuPyYfpl3
         zktkWjm9LMbQWVSwbzPjWuYQyYE8Vzpv1ahCkhIbLoWX+I5bD+l2OsUd6iLe683LDmVk
         XJaJu2Crs9TtgncO9TIk1a3rfK44QT6jDS7PEuLmjmZqFyRyihuhhfxD5klhyLQv2Y9B
         Bb0jZ9ha22lEryASM96tpmsYQjCswY+HK+FYB0ECGb1IBSM3978R544Fl88HEpqIKRJn
         TvlMhyipAG/yTTxLQ1TZWE+Dvh7v2Iqt2Bk/oFVo57fL3G1bmY4BQ5SSKC7Ddwzj9MXW
         JTlA==
X-Forwarded-Encrypted: i=1; AJvYcCUC5JkGJAMKgBFmbBeheDD1fLn6LoZ+Q5RY8IwzutilE07yfEvduvINM5Z1pRG4Y5e9qvuC6ALlQ5hmWXZr8kzR@vger.kernel.org, AJvYcCWV5UvSTANG5LQ/kn8GC4HjF/M77ZpM1lGht/YRS5Cxxwf0qRV7fypfe8Ut3J0lLVJtzMzltAB5BdlrSmIFmSFq+eGI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rpDTA7cxczCKxlweY2iDmhTlKJnX0tfybf+p3T84ykmyuwZJ
	iUMpRk3+P/mEPd1f8I25XZm2Zf9SRMT/VCLzTd9dZ5hzSqGmB8YwlgS2
X-Gm-Gg: ASbGncv6g2MTmoUIa+UlgtpZDC9waANUnsPOLp8QAdoaVbOFw62pKrF4fx+Wym6Q+5a
	u/dFghy/Wx3c5RepU6WoYNw/F8q8iniDVp80wK+f8fuxUTyM5fZcOSHIJCeJtxAN2wO2JO9oWkZ
	CKRgrbPG6/1ybwfPDybrBpGkBcnDhoFqzbUpYSWKxFXW5wmqiwuibIMYUfs953p2qdWTVP9tmzY
	iV5Jj2LXd8lNd62LOwp8c9Uo68WFBuUZEfzj3/z8RYAjFWy+BRXcVxu/PjUO4pMOfZXW+GLT+Uf
	vj1pJyEMvyArxHHCr4n1REJUzWsQGeyFkELvi8qPzn2VUpZc4gKlODZj8As6/M9JNoWC8Kdyolh
	jZZplcG/H3Qc0EWdRyBb6eju/Luf8dbxc7dhAQUCu7ugF
X-Google-Smtp-Source: AGHT+IHRnW0jqK60RBaX9CyGZ4rbkLTldty1zM/NNrTXrRROO0CZyvlymHODufDpMyz/pY0YLm22Nw==
X-Received: by 2002:a17:902:fc46:b0:24c:d717:719d with SMTP id d9443c01a7336-251761615a7mr159790755ad.60.1757481964506;
        Tue, 09 Sep 2025 22:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ebcsm14815125ad.29.2025.09.09.22.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:26:04 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 08/19] mm/ksw: support CPU hotplug
Date: Wed, 10 Sep 2025 13:23:17 +0800
Message-ID: <20250910052335.1151048-9-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052335.1151048-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register CPU online/offline callbacks via cpuhp_setup_state_nocalls()
so stack watches are installed/removed dynamically as CPUs come online
or go offline.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/watch.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index e02ffc3231ad..d95efefdffe9 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpuhotplug.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
@@ -67,6 +68,32 @@ static void ksw_watch_on_local_cpu(void *data)
 	}
 }
 
+static int ksw_cpu_online(unsigned int cpu)
+{
+	struct perf_event *bp;
+
+	bp = perf_event_create_kernel_counter(&watch_attr, cpu, NULL,
+					      ksw_watch_handler, NULL);
+	if (IS_ERR(bp)) {
+		pr_err("Failed to create watch on CPU %d: %ld\n", cpu,
+		       PTR_ERR(bp));
+		return PTR_ERR(bp);
+	}
+
+	per_cpu(*watch_events, cpu) = bp;
+	per_cpu(watch_csd, cpu) = CSD_INIT(ksw_watch_on_local_cpu, NULL);
+	return 0;
+}
+
+static int ksw_cpu_offline(unsigned int cpu)
+{
+	struct perf_event *bp = per_cpu(*watch_events, cpu);
+
+	if (bp)
+		unregister_hw_breakpoint(bp);
+	return 0;
+}
+
 int ksw_watch_on(u64 watch_addr, u64 watch_len)
 {
 	unsigned long flags;
@@ -141,6 +168,15 @@ int ksw_watch_init(void)
 		return ret;
 	}
 
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"kstackwatch:online", ksw_cpu_online,
+					ksw_cpu_offline);
+	if (ret < 0) {
+		unregister_wide_hw_breakpoint(watch_events);
+		pr_err("Failed to register CPU hotplug notifier\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

