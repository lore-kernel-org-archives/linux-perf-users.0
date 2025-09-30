Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019A20B80D
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200271; cv=none; b=CJRaDFVQsgoXY5BgGOOsCZ4bqKVWYVYe0ObnFlJ0vDsicsvZ34jhULCOnt1TmTx9ULI1Ljzg3dd/k3oYzF4ueB4aDuT6H9lxz4Xi+eAmstcpp/Q7pL/OS/eoQSFRBp4WVIhAc0lc1UFQpqy+0/TXr2R9853AIebAKz/OLkpPDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200271; c=relaxed/simple;
	bh=ZEq5LCeeZxdZtY+a+kvZMIoWs2Mzj+sOmq7f1LtT1gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kjzcg3hr38KW4urYSYF/dAqpyEyDw16eqPbvg3ExY9fnbSP3Pp1jV1dmdyfqmALzb6kIPd2n7mGHIEJje5CJWckuB8rFrZ+I7cN7kpvWCFciiV0ofKNX2erYGexQKkAQdxQyaTMspWjOCcyhzpwuy+OksQG+T1KqeV3nSVdIezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkGzb5LE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkGzb5LE"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77e87003967so2685095b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200268; x=1759805068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=VkGzb5LEGvJKRN7Y2WFRHu+8I5VpCaY44IwkBES6oVgTVZAE6McrKnwgK4mKF90wcD
         NQRNmK0gi/8jjHVb6Ic9mfB6vibCQwNpPo0817cNGmshKn7muGrJzVo6uriMMS60GJJj
         BO3AktyngzM7/cT343tQCnMEnccjUnsrEa2CzbRJxlxACYHSb35YGAsLnyhtvhjdySja
         tbqdf8CJbL3rBm2yedIwYpeiJS5rdVtXU/dZAGVeYTNaxs1xmnITSG9GtWYJ9d5BY/p4
         DgdNTEqMenp3iHBMNJB6Gvb2K5siryzDi1ydOQrzVtJBbsThBXV+DN8qBta5coWVBB5P
         158g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200268; x=1759805068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=pBm8tGP5m3o/9mnpwyGkSDWzCPEmfzj+lbFxVlPpbsUiyA/ofsjphQTtrVZRUeUmyS
         EdAuYiRU2+tMyRsyJQnqL26JsWBeAz/mGwIISxAh804yf8S/eSuA/UyhsHIigrSO0d+e
         +jGsE5LlK4AJ907aW2lvKSrGo4U7jbuU2r1TSe7MauDD7WZVgqx7fm4w6w6rP2rXKYF/
         BNajlqnJUf9s1umf8FxjpCuqDy0iPuxdHakCFVIgHKv/1Jwnu+XJDdLhc6oRX0fZsjvw
         zhIidr9/uCybdN3LktESt/ZNChOnPYOrXhlOifuN+hpTGwxLqhD038v5d3xqnBFAlxwR
         DD6g==
X-Forwarded-Encrypted: i=1; AJvYcCUdYOYJ3KEw7sGWGZotKwr/aHgCEYePhEmJJNfNE+AAaeCCZtyHzcFmNw7NvI1QjTLAtCUHVB8+x8L7BozGO1fh@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/VLlgMT1U/QmQ+gh+wJ6OtUoYN8kEG7ZWvhk/e3EgSYNYbUe
	iVY61EJvmPkAAwcto72xwzWmLuJisUgqRlnKW/hjNPtR9fM3gmddOzj7
X-Gm-Gg: ASbGnctzQKAbw12PTE1A+u+gc0pSYX1HyImrvEc2SuU+RS3hpm6i7qjTLyTvLQfrVPt
	y6yy7b3XSJZ6sORliQJ5MUoCCE4D3H7CdzthgH6MruiruQ+yKRi+h3Rlb+xKg5YDG60pWHKEqgk
	yElaDXAApJeItmNDKO0L3ERKZn/WQv7TESNGuQEz4yjuCVx80wMtNmdxBjGsiNIcNdk4ccfRWwN
	7Wba+1lI3oTQd8HSqa/1f6hxbdlpefTjfV7arEdlZcRe+50t78+JZLNzcBFm0eerZpRYksAxmne
	aOj+A7Y8jYts/oWoiHhzfdrXj7V31RbZAbluV3Y5k9yOvWYgB2TG6xSLGBbhJkoZPjhdwxUBqVg
	OIVRUiEApX9T+Hl0FDeoDQIwThX/7ikHUiCtaHDlFM/2KlAU+zUIHZiRAUC9W7hMBFodKt8NRZ3
	0Y
X-Google-Smtp-Source: AGHT+IHMOcWUXY/HnXgeQLe6jbo4QIzPdgwdgujFPg5G7XU1dMaY5AtA37WyD38lOg5pTss5CR5fOg==
X-Received: by 2002:a17:903:a8b:b0:27d:339c:4b0 with SMTP id d9443c01a7336-27ed4aa57f1mr154617195ad.35.1759200267317;
        Mon, 29 Sep 2025 19:44:27 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm144778285ad.9.2025.09.29.19.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:44:26 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
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
Subject: [PATCH v6 02/23] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Tue, 30 Sep 2025 10:43:23 +0800
Message-ID: <20250930024402.1043776-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
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
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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

