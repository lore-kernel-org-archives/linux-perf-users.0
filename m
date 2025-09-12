Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED52E336F
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671931; cv=none; b=oj2sbPqeKVATyxpqI0JLjGiOhttKRkTs336KztbhvYoaCRdnnXIAqGxP0/Ny9K3PeIP4DLrZ4U8AMfDeTZ0TTYNSn/+s6uNR66Kjdacqd3SuW9B6UKQ/AAUiAsVzU9/nrOoFrhcJJwTUERormTmIi/720H+ZCSXFX3kslIow1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671931; c=relaxed/simple;
	bh=zbmepUv5MhWdm0b+QCOGN6KW75Q1eP0IAhJLHBVpxMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atugirIzN+TfO9WnDfqb6wK7ZwsGIqM4dv58qiDC+W55eKgNROhu17IvxRmmQIAc1EsDqNHaymjFdC3NB6ARNAOlWgbwOgcIz8RDWXAlYvBTsSQhpUAYQgXjZUIir0YO8iEZaMx84PYu24jdakssEfs2QBt+jh9cvRTZjuP1VwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YakZc8qj; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YakZc8qj"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so1131119a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671928; x=1758276728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E07gf3+EHiFZ+TUqDdqlrvhEU6rgl4o/YSp2RBqLkNw=;
        b=YakZc8qjiI5W3v1TlAAhn8+1Plm5tgFZOiqF3oCD/+e/EGnQTFLw29HcsI5+H11mB0
         0IcUx80Rnu8LmfXuXJTuQxJzdMekYny+xacwcwnNQt3UMzvplDxo9/9ZFoGrSdqw5kq2
         UmShVTk9Dc8bN7CpYpd4DtjNiS5fgrCequmUBYd1kkyYaucetD3vMqmXuJCYA1A2UcL3
         VNsVZuuGEgTPDWZaCstIlbFmkdP3dtxRhV7qPcQzsmJ7TJGhTK4FOaWW5PUqNeHhmeHh
         5nBKAzR7In2AxXSQKe5GTf9Y8B5FvrlmgNU0arxWMzRgfzPQurGDY7sXjWg+r4HYnebP
         EAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671928; x=1758276728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E07gf3+EHiFZ+TUqDdqlrvhEU6rgl4o/YSp2RBqLkNw=;
        b=TRjvL7rZ34ugLrvZybTk9GAEnnb/E32rCd1ioKGouqanG9UjaRX1hKM/Aq/CKinZS5
         lJTW5+32IbjkYQ4MonN2S8eACCx43Bxt1SQAsEpYRJwokVvdel1+VKFcyUIE3L7d3QzE
         OybLtDP9lirBuHitWq7vaG2ucAkVEUAmCiRDIQxLjerJtpa2gkhkQQpAiZm0f1gmBeje
         DrHXQ4IFJuHjzDF8+ISLka7XdxgJQwuzo3v3S2edvzVY3w0vZNhHNtvtdOxPEKg1C5kR
         K34On2t5gnP2AnfZNSIRTR1OddgiaiyUGj5S3kItStVx+DcOxHrzRlD1F5H+fUBR3tFr
         Za5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2Pgu1i4dO5b6bIN1B2nDEiJOSgFJxSfeWaRmQjW6Bhh+2Gf9jG7afjK6tNQLQ9XJOwJ4OiIF6pqL1aBK9zFQH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EO1gVLajNpp0LheGB5kCSSmqP/ZRebMJQp+VDLv/2k0aUG6D
	OFT6tBvW/cBgvRds8BWriAzlFbuI8oFPH6vuTkAVeNsstNsAvcAtV3eX
X-Gm-Gg: ASbGncsHoLS3RhdKfqlGXtRCDzMFN+/ria/9XVjHS8vrpc1ogFB6/W68u3H1zbl+Ean
	Qjn1Lek4nyFjlyEhXs7L0OPANlgkNnQvnGO+NR3ucdM9cY6arIozS2B+30LYsq9nC+2Yn791UEV
	dAO1jTq1kGvGpa9yT1npTuA/jadfGE5TEdgtN0ERShbvoIjkx/riFmQtnepl64P0bxHOc5D4uOE
	RX4/WaM/gcaDtZfVVAN5IAEnIW2Ia8hpwVBkf3ESp8DUo7EJszBw406ScCtivYFXaDtAOt+p6VP
	CdJqAl1tmO6GN3rqZ7PlHDsdgScbprIhFeeZrZ4SKttITpwHFksk/TR/J1NVvysP0nEOJGc7zdB
	0YoFBWSdM++9vEMkjU9Qj2bBvPdgYNvHH+ZCornk=
X-Google-Smtp-Source: AGHT+IGs/ObotIuyczkZdqAXxWrWykSxCXKo0dzFjl5HuAQGOzaywRYcIXz6zrznumJ6ZW1Xtjh7JA==
X-Received: by 2002:a17:903:32c4:b0:258:f033:3ff1 with SMTP id d9443c01a7336-25d242f314bmr32759845ad.12.1757671928125;
        Fri, 12 Sep 2025 03:12:08 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37293fd4sm44061135ad.38.2025.09.12.03.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:07 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
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
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v4 02/21] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Fri, 12 Sep 2025 18:11:12 +0800
Message-ID: <20250912101145.465708-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context, unlike the more expensive free and re-allocation path.
This allows callers to efficiently re-establish an existing breakpoint.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h | 2 ++
 arch/x86/kernel/hw_breakpoint.c      | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index aa6adac6c3a2..c22cc4e87fc5 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -21,6 +21,7 @@ struct arch_hw_breakpoint {
 
 enum bp_slot_action {
 	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_REINSTALL,
 	BP_SLOT_ACTION_UNINSTALL,
 };
 
@@ -65,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 3658ace4bd8d..29c9369264d4 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -99,6 +99,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 		old_bp = NULL;
 		new_bp = bp;
 		break;
+	case BP_SLOT_ACTION_REINSTALL:
+		old_bp = bp;
+		new_bp = bp;
+		break;
 	case BP_SLOT_ACTION_UNINSTALL:
 		old_bp = bp;
 		new_bp = NULL;
@@ -187,6 +191,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
 }
 
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
+}
+
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
-- 
2.43.0

