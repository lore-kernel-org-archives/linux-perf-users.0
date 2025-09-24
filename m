Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048B3054C2
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715250; cv=none; b=RuWMlTP8sT8b9QlpXeYgdSqxk+USP3nU9qnmvX9UPv33mJGNO6ga5ODjGQj4WE0ZkHppYR3EzP0lApmUrsDyYPHqS+T4pwIk4Gel8naxs75UlZqtR9Q4u2nZKUD0GSBwmEs9Ya/T2LLNVXVmqGAngCHmBxxuIkYNKb0ByKdZ56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715250; c=relaxed/simple;
	bh=ceqMPO/CCLxptz7Kcmz7UHHum+IA7F5szQ405xxeOe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLIWTdOz82Q4v2Kv0rtnzJ0q7MXCjxptit9UhwAYQFQ8/2CpcpTKaIVD/C94v0Omvox77h0RLF5sNWHg2pTdCMPz7kQsrit7rU6lnSytNQgRF7rEi3ZijvdbWR80sw8eYJZ6bvdUO/xqvsAcHUY1upf1E38o78EpKoOzibiC9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMK6c+X0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMK6c+X0"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f7da24397so525442b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715248; x=1759320048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3XGYZ1mTVo1cX+yb2z67UYPJCwM1YcVlAKDPd0GQ2Q=;
        b=mMK6c+X0TOD2/Kz5n4yFXoa5kkTOYqEhREejrcY+07hXLZCU0BFXc4GSKlowPnOV64
         jDjnVerSJtIyfiGHAb4V/uzAQ+k2k7qndGTk0uPA1H6cirwjxYTwVd+gJFahtr3f4s9P
         DO68o62wDOnvbCkGBfPoTbq292nXZDDHQAHUwiPbcBjDa7wUekymMoq+rpkRH/DLaLrm
         e5mC/8dCFX7LI8bAPLZawbxmq5JkZQrDqD7V0cK26sm4SGrBaPAr8T8NEZPvWYRgbjlI
         XP4LjMfkghHeuEqWg9mLqCk91Cv85LeBHjl5lS7jmg/WD+Da9sxf/qng9t2RuwvxhKqh
         x8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715248; x=1759320048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3XGYZ1mTVo1cX+yb2z67UYPJCwM1YcVlAKDPd0GQ2Q=;
        b=mLr/dQAT3o90WIXdFI+zaermiK4eij65WqRL0liHVzfHdbWqBbvJ/kCNmYuHjAcAq+
         q9xmdEDC/qhpa80u8DM2HcxF8wzCI0wsPzIrVCwDTu6qmfOfpzck0eBrAOxFNXVteSrc
         gVzD2BzP50ycPsENRxNDxhjLO8X6hyJE9ervbt2Upb8djhYxKqtZ10ppLwn/43EaBcA7
         ZffOdcws1WyKqOjL1eAIA7kLbNxbww/W884GWIaX+WPI8XXJrreR5WyBYRp80zRinxiT
         hh6x/WFA42NZgqATjVQkb2JEM4dc8tyCBO92qDGc313H6LMEZbosg6FjKqBllAuBo/x0
         1Nww==
X-Forwarded-Encrypted: i=1; AJvYcCX1CBcmDqG8mgZclhu2JX2eTffYG4i4WVYqoqsE+fsv15lin8dpHcUnnrQDcBjNoeuskXud5TRh6DgvBA7Ibv5z@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3jcSfbesqpiU7VwSCkh7jUpPXqa55Tr4e5wqSnYGkG8oxj+K
	WtfBqcj2ivdq+NdbjOJ+jGjwPJEyAYFRV7vHhLUzN0M25dH5CSgWLG7R
X-Gm-Gg: ASbGnctCGvT2GxOedtgN6zgKALew4Im8IZUQyWgX2v6KS4ZfMxRUwLwpJJVxZROm2un
	+vbPFUHd9uCG4yn2TaGQCMlB9tn17VK2JxeVAyLyMzyS/4/HrNUi6f4d24rZMNNnrNkdM5FqbCE
	GZijaONfVLrZJoFPGBw7aLQinRd12jlQGIXGreAjZhQrxipHiKGybZBhEzNr6yW+ZOzRBV0bSed
	VvKuWv4ETN0gopQnU7529ZycvmRMNy7s6oOwID8HVOCrvUkoJXiS1sMV9qDC0a336fKv3cJeLgx
	6UaBEganWvPurYg0555KxGUjVgUuCrAEmhRKGMEykgis9WYwWpnSn07ReeuS5AdxDoik0XtVLat
	U4hG5ZOGfzz4LDgC63y763KE=
X-Google-Smtp-Source: AGHT+IFjwxI+PhtV7jgjoa1gOIc2i5iuKeq4ASvkc/Bz/cNSIoBtm/vDSyxk5EpYVIU5WEV3bOsalQ==
X-Received: by 2002:a17:902:d113:b0:269:82a5:f9e9 with SMTP id d9443c01a7336-27cc79cb20bmr41740315ad.29.1758715248144;
        Wed, 24 Sep 2025 05:00:48 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ec0d14344sm19610475ad.126.2025.09.24.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:00:47 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH v5 21/23] tools/ksw: add test script
Date: Wed, 24 Sep 2025 19:59:27 +0800
Message-ID: <20250924115931.197077-6-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924115931.197077-1-wangjinchao600@gmail.com>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
 <20250924115931.197077-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a shell script to trigger test cases.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 tools/kstackwatch/kstackwatch_test.sh | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100755
index 000000000000..aede35dcb8b6
--- /dev/null
+++ b/tools/kstackwatch/kstackwatch_test.sh
@@ -0,0 +1,52 @@
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
+run_test() {
+	local test_num=$1
+	case "$test_num" in
+	0) echo fn=test_watch_fire fo=0x29 wl=8 >/proc/kstackwatch
+	   echo test0 > /proc/kstackwatch_test
+	   ;;
+	1) echo fn=test_canary_overflow fo=0x14 >/proc/kstackwatch
+	   echo test1 >/proc/kstackwatch_test
+	   ;;
+	2) echo fn=test_recursive_depth fo=0x2f dp=3 wl=8 so=0 >/proc/kstackwatch
+	   echo test2 >/proc/kstackwatch_test
+	   ;;
+	3) echo fn=test_mthread_victim fo=0x4c so=64 wl=8 >/proc/kstackwatch
+	   echo test3 >/proc/kstackwatch_test
+	   ;;
+	4) echo fn=test_mthread_victim fo=0x4c so=64 wl=8 >/proc/kstackwatch
+	   echo test4 >/proc/kstackwatch_test
+	   ;;
+	5) echo fn=test_mthread_buggy fo=0x16 so=0x100 wl=8 >/proc/kstackwatch
+	   echo test5 >/proc/kstackwatch_test
+	   ;;
+	*) usage
+	   exit 1 ;;
+	esac
+	# Reset watch after test
+	echo >/proc/kstackwatch
+}
+
+# Check root and module
+[ "$EUID" -ne 0 ] && echo "Run as root" && exit 1
+for f in /proc/kstackwatch /proc/kstackwatch_test; do
+	[ ! -f "$f" ] && echo "$f not found" && exit 1
+done
+
+# Run
+[ -z "$1" ] && { usage; exit 0; }
+run_test "$1"
-- 
2.43.0

