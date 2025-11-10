Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB9F32861D
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792718; cv=none; b=F8wFJxt/gDik7tWZM9tZ9hwU5GIT9OJnIA0rxi3b7jxulgqQPuQgAaOALdEDwCVK2e8zWipo6A1jZwxPyT36PRNj7kzpBKELkquKOMDwUBQ0fOPpUd4LtTAAhSXAzdbXfS2lsr/0xHmaLgNILsL/0zpwXbibvyE66wKov9hB+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792718; c=relaxed/simple;
	bh=7XtXQ97oCD17IPK7+NK1Mw0M3hjSZXH8IzRrWjOBBJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEEwlzjR8ZM5zu66YaI2MDvJYhG5hjUcaQckeOmoU8YSH5xnDxmXeGa5+nMNF7Cnx1SUjVtULRlvAFor57vH5QgeXVf5XXQE0Y6MF0LJd4Lxt7nWpgMypzaXJ1Odd64NP+sqsec8rjcHzt61lHQzLB5h5PY150D15MRLFHGomdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtfYJ9ms; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtfYJ9ms"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29558061c68so39128915ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 08:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792714; x=1763397514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3GxOA64nlDPTJib953n4vjoIghnHFGUI3myXADNt+s=;
        b=MtfYJ9msGxlKiKt2vwibjYrQn9Q7Iem3xQxfw94Y0bjSQQZ2Tpw5CtlvU3vBcRGcDz
         I+V8r12hwuTjXcrfUHsvDA+j6oUMIcenhVGuzgG7sNYKdMMpMiC8dn9pBqP+NTzxW2cD
         tuOcqo+wHJlruQ8duXqcZRMidpt1Iy47PSWDEsHUne/izqMhkWNpxv6HrucgufSSApSn
         2tuJo2mhUIWceRaWxWTQ175ix0wFd+3gy70Y7Ztz0aMqkupWRn7I7e3kag5ftI/v/hkU
         wVxuy8Gp6dtov2GwQ1q4ovvEYAwcemIGcFjq/CMkusCJM7sZmJeYstkefeJIpbflcYJL
         +ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792714; x=1763397514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3GxOA64nlDPTJib953n4vjoIghnHFGUI3myXADNt+s=;
        b=xIvt9LuAGuT3yIceoT8xaL/8UKxCiZZA1bbgtIsC/iN4b7CC77FHZnLXmXwlqGPqD5
         zZ2WZL89Std1lcRXIUDnExIUu5QOCljESLrGqlYAL6HWTdsEX3Z4VP3/ZdAGkEDohnbK
         K1P4/rInrQcmhadfE/YRzjcY+L9Nggmi7//wZwvP2IvcBspr/vowT+lfaFBEKtDFy7OQ
         MhtmbCZwXy/TEe16PYCzuO7TTgU5DE8J+UngsFPAi3ZGDYt6AyfS9DZ/YBDOlZKhdiJ0
         s8qsfNVJJoGHeLlQN9UmJDZTjrh6VzphzMTEKO61ocjO5KmqFNc7AYo84hK3HxFhjdrz
         WDfA==
X-Forwarded-Encrypted: i=1; AJvYcCVmTHY8MndKCF241Q6EEJuWm1xQFbLI2VjCM/x90OSU4G3pCh97sZmJSwJpDVpYjc9CAycCW6OgOOmbrvOUi3RG@vger.kernel.org
X-Gm-Message-State: AOJu0YyuV+PMId2EkE465MpGXPRDvPMiY4+n0ICKo97HJFaz2vPFFjHv
	2TbmEXw+vErbQJCLpbt4nHKkeeH9q+ocjTCVq/hfp6fEjyhPYgcwZP61
X-Gm-Gg: ASbGncvIpvCsz/3upQUy03mLPCADelEXF2lre4IilktfO/9xxc3rVcA6Crzg22JZCcj
	+b7m2ib+IlCFNCes6uVfrN/WPN5MqO9fD+c2ibg6QjtUQmpqca14b/E17/nYahrrroW1AVb6mq7
	aD18ijP99Kq1Ibotbm4eGVPp3bmAPnnv0i5a6WIo6oeyycQF34gxCms2RBiV+CCWlWJlEITR7Sw
	C3orQsFnLzj173DZKqbBe3PrSOcJsHieMoB/bGfRrO5lqOjJd5Hu3lLTwVEYQnzSqS7dF4cc2lB
	H+x2ngFVsU5RX3W2uCUKteE3Cw23sr5uZDjSp9Oxn7XsmqqYJCzwMJhS1FhXBtYk5yW8u5DIh7i
	OvVPpn2g3EcAMcLdQqs+N79pxcNHAn2hPGxbMAGcBDUmxCP7B9g2MdC0tex7P9phDbwH8BiFRnb
	6567xT7ic2D1rIlShB+TS0pQ==
X-Google-Smtp-Source: AGHT+IHJX8e0VatXnyxoY2Gj4pP23au6Z6EmKSnmcplOP/Vs7kpe6TtUClUvAMyMHtho7bQMYRxkQg==
X-Received: by 2002:a17:902:da4b:b0:295:fc0:5a32 with SMTP id d9443c01a7336-297e53e7aa7mr114885545ad.3.1762792714416;
        Mon, 10 Nov 2025 08:38:34 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2980c51b8c9sm52389295ad.47.2025.11.10.08.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:33 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 25/27] tools/ksw: add arch-specific test script
Date: Tue, 11 Nov 2025 00:36:20 +0800
Message-ID: <20251110163634.3686676-26-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a shell script under tools/kstackwatch to run self-tests such as
canary overflow and recursive depth. The script supports both x86_64
and arm64, selecting parameters automatically based on uname -m.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 tools/kstackwatch/kstackwatch_test.sh | 85 +++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100755
index 000000000000..6e83397d3213
--- /dev/null
+++ b/tools/kstackwatch/kstackwatch_test.sh
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+echo "IMPORTANT: Before running, make sure you have updated the config values!"
+
+usage() {
+	echo "Usage: $0 [0-5]"
+	echo "  0  - test watch fire"
+	echo "  1  - test canary overflow"
+	echo "  2  - test recursive depth"
+	echo "  3  - test silent corruption"
+	echo "  4  - test multi-threaded silent corruption"
+	echo "  5  - test multi-threaded overflow"
+}
+
+run_test_x86_64() {
+	local test_num=$1
+	case "$test_num" in
+	0) echo fn=test_watch_fire fo=0x29 ac=1 >/sys/kernel/debug/kstackwatch/config
+	   echo test0 > /sys/kernel/debug/kstackwatch/test
+	   ;;
+	1) echo fn=test_canary_overflow fo=0x14 >/sys/kernel/debug/kstackwatch/config
+	   echo test1 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	2) echo fn=test_recursive_depth fo=0x2f dp=3 wl=8 so=0 >/sys/kernel/debug/kstackwatch/config
+	   echo test2 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	3) echo fn=test_mthread_victim fo=0x4c so=64 wl=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test3 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	4) echo fn=test_mthread_victim fo=0x4c so=64 wl=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test4 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	5) echo fn=test_mthread_buggy fo=0x16 so=0x100 wl=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test5 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	*) usage
+	   exit 1 ;;
+	esac
+	# Reset watch after test
+	echo >/sys/kernel/debug/kstackwatch/config
+}
+
+run_test_arm64() {
+	local test_num=$1
+	case "$test_num" in
+	0) echo fn=test_watch_fire fo=0x50 ac=1 >/sys/kernel/debug/kstackwatch/config
+	   echo test0 > /sys/kernel/debug/kstackwatch/test
+	   ;;
+	1) echo fn=test_canary_overflow fo=0x20 so=264 >/sys/kernel/debug/kstackwatch/config
+	   echo test1 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	2) echo fn=test_recursive_depth fo=0x34 dp=3 wl=8 so=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test2 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	3) echo fn=test_mthread_victim fo=0x6c so=0x48 wl=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test3 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	4) echo fn=test_mthread_victim fo=0x6c so=0x48 wl=8 >/sys/kernel/debug/kstackwatch/config
+	   echo test4 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	5) echo fn=test_mthread_buggy fo=0x20 so=264 >/sys/kernel/debug/kstackwatch/config
+	   echo test5 >/sys/kernel/debug/kstackwatch/test
+	   ;;
+	*) usage
+	   exit 1 ;;
+	esac
+	# Reset watch after test
+	echo >/sys/kernel/debug/kstackwatch/config
+}
+
+# Check root and module
+[ "$EUID" -ne 0 ] && echo "Run as root" && exit 1
+for f in /sys/kernel/debug/kstackwatch/config /sys/kernel/debug/kstackwatch/test; do
+	[ ! -f "$f" ] && echo "$f not found" && exit 1
+done
+
+# Run
+[ -z "$1" ] && { usage; exit 0; }
+
+arch=$(uname -m)
+case "$arch" in
+	x86_64|aarch64) run_test_${arch} "$1" ;;
+	*) echo "Unsupported architecture: $arch" && exit 1 ;;
+esac
-- 
2.43.0

