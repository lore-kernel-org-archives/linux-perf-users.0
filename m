Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C732BE7A7;
	Wed, 10 Sep 2025 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482448; cv=none; b=Q/Xtpw+APjnnUixthZ8RoX9zY5JFdP2aX9AZ4ffhqk90FLSr/X/fG837yj8q7R76BzqhI9ndlTCT5pdOqwvfqTNpDMgMf1MGCW7YBOYvVRX3//yFU4ubdNiz2aHIkpNe0vfDluY0tBXjMksi9PDPXM4fmeB0rzYDkj9mDaZVJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482448; c=relaxed/simple;
	bh=Q/pFh66uggFYfO17OcStVavKWxHinlCiNIrqBOrW//4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbMGLDalev4TdCfk39Tzf5QNAX2x3jp/5+EaXZQxENGAAN9xmu4WvTk0PtX4qJehoH6+Nct2L/WTiwfjgc4fyvprlWtPcpXB1O2yVxuXO/R8jxaqfCNZzl1+7r5Tw4r5BcyREfAphU4d2nMziYVGkGfxL6WA+azG8pbL7aAgAM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQn87ZW+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQn87ZW+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7723f0924a3so8423389b3a.2;
        Tue, 09 Sep 2025 22:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482446; x=1758087246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LZ6B57mC2fepOM/oiVWF88xfTVcoYhpKk3jWWiDDz0=;
        b=kQn87ZW+gQKZqQzPKVk4hK31iQW9q2bjJhLUDJRymM3T6zU6mtYXav40e7fSUQ5E7V
         O7jPYCoLmT20boVLOkRKxuzTY3Jt6bQoRfG9jW8AgEw0mhU2XaXiF1UOcarb5RH/BRYC
         QfxhO8FXQGEhSwThvMW5lPJSTewOx3hqukZz4qDi9TlPIqwPb5wtrCbQW2MyMVWWyMS+
         EvmstcRF6uvWcjtXph8yYFudGv05l/Iw784UO0eP3tnjCL/LLu9ac3xJK5jRqgspcT9K
         UE0b5C4x1OTTrQtL3m7C8ydHwiU73yo6ZQ/zLK9UNHQHQAGqSo7+E+JTNuFF3DeLWDfT
         BFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482446; x=1758087246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LZ6B57mC2fepOM/oiVWF88xfTVcoYhpKk3jWWiDDz0=;
        b=iXRrAgU6z3Ff62xWePyGBhygWlN9XRfxa6V1ir3ywYc4lbJyelZyQMqKKMTd4Z/0jG
         R82X3iiDV3UMdMsMjd4azpTdMhHvIvXa+tdoxXDs19mrMp8oLF/6U0AKwNTO/8sLk8jQ
         jCtSxcaM8oWG5xWRmFXbWAaJ1Y3zQfA6likRczuB4m+aMhYqsv1K+hG9WGXW9UBTFWiF
         e8mY+BRk4ed0qqTpyhen210goaNEcj+uIYeqU8L8s4yN7by7+AqGaYTxLr96hVuxQ8S3
         kBSf2yRD5TIMrbJwAcjYp7/zDtJBssHjDcPU7ApldKBvFD6zDKfIGDliVUfaj+YeFcqU
         yQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXGLaaFrpCjkzGesitozV2liWYXeDaPQiJimzKomzPTTZMddEVXeJgJZloe9ko2YWVe18w7mzOmE3ms0tfYw4VW@vger.kernel.org, AJvYcCXtacMMEJX4BEL+QdDSLJlv2stgFiduSNqyowyL8zKQu6EyuIn5ylrS17hLqs3r/oNFpvyjc9VsA32e/auDeUtJ9T3Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7SWNm/j+yXfpITJCapDNx8y9LvudvjCHPJBCRzuQ9q82YOBX
	RGLE8ohPIkYCJPBSckXGDuoafYr3HykbQIt/uGoRfT3rq8NRtxwAzvZI
X-Gm-Gg: ASbGnctGsd4MUbvZkHUyEVwBPomJ+Cwkysp7JFhFJAeKQjfoi2CSL+x32lUd01i8D/E
	EQInZ+EfvOfCyLdfphtNIyCIjXOlr/AuN9NzBfSqv1KxL1Y5nppFaUTaba34TWG/PJUVQWFSgTV
	kG5BnxVVJ9A81EgoYL/tfpwAXE7i2Nij72+QEBgT8j/YoTJkbib3QsAyHgVnyzz9NQ3BpYTOZsO
	aTh7J9AYKqTaZe3r9yDShLFkV9eMDqiZf9vpq75OLDVQVjclgd5EWqVVuM7jqMApr3aJoQoN2q2
	ax+wbFl1X5J9DJmpyg2sOSlazLlRoIv+3VGZzFrneKj+MO8e/KH316U5AcdHjhMlUhAeDNRMpfj
	LP2/+mSghY4Vtvq7RvpBkj/a1LgS9eM3GuDYAckwREVwdoPgGn2yqOh8AeyXn
X-Google-Smtp-Source: AGHT+IE5Rq1rrzJXAUxF3Qk/Dgi7jghuqZ6IFego4Tk4Ip7IXws9wM59yr3GJE3aEhSdjZsId8DOtQ==
X-Received: by 2002:a05:6a20:3d8b:b0:251:7f83:11cd with SMTP id adf61e73a8af0-2533e5732famr20377356637.11.1757482445592;
        Tue, 09 Sep 2025 22:34:05 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:34:05 -0700 (PDT)
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
Subject: [PATCH v3 19/19] docs: add KStackWatch document
Date: Wed, 10 Sep 2025 13:31:17 +0800
Message-ID: <20250910053147.1152253-11-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053147.1152253-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
 <20250910053147.1152253-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new documentation file for KStackWatch, explaining its
purpose, motivation, key features, configuration format, module parameters,
implementation notes, limitations, and testing instructions.

Update MAINTAINERS to include Jinchao Wang as the maintainer for associated
files.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 Documentation/dev-tools/kstackwatch.rst | 94 +++++++++++++++++++++++++
 MAINTAINERS                             |  7 ++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/dev-tools/kstackwatch.rst

diff --git a/Documentation/dev-tools/kstackwatch.rst b/Documentation/dev-tools/kstackwatch.rst
new file mode 100644
index 000000000000..f741de08ca56
--- /dev/null
+++ b/Documentation/dev-tools/kstackwatch.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+KStackWatch: Kernel Stack Watch
+====================================
+
+Overview
+========
+KStackWatch is a lightweight debugging tool designed to detect
+kernel stack corruption in real time. It helps developers capture the
+moment corruption occurs, rather than only observing a later crash.
+
+Motivation
+==========
+Stack corruption may originate in one function but manifest much later
+with no direct call trace linking the two. This makes such issues
+extremely difficult to diagnose. KStackWatch addresses this by combining
+hardware breakpoints with kprobe and fprobe instrumentation, monitoring
+stack canaries or local variables at the point of corruption.
+
+Key Features
+============
+- Lightweight overhead:
+   Minimal runtime cost, preserving bug reproducibility.
+- Real-time detection:
+  Detect stack corruption immediately.
+- Flexible configuration:
+  Control via a procfs interface.
+- Depth filtering:
+  Optional recursion depth tracking per task.
+
+Configuration
+=============
+The control file is created at::
+
+  /proc/kstackwatch
+
+To configure, write a string in the following format::
+
+  function+ip_offset[+depth] [local_var_offset:local_var_len]
+    - function         : name of the target function
+    - ip_offset        : instruction pointer offset within the function
+    - depth            : recursion depth to watch, starting from 0
+    - local_var_offset : offset from the stack pointer at function+ip_offset
+    - local_var_len    : length of the local variable(1,2,4,8)
+
+Fields
+------
+- ``function``:
+  Name of the target function to watch.
+- ``ip_offset``:
+  Instruction pointer offset within the function.
+- ``depth`` (optional):
+  Maximum recursion depth for the watch.
+- ``local_var_offset:local_var_len`` (optional):
+  A region of a local variable to monitor, relative to the stack pointer.
+  If not given, KStackWatch monitors the stack canary by default.
+
+Examples
+--------
+1. Watch the canary at the entry of ``canary_test_write``::
+
+     echo 'canary_test_write+0x12' > /proc/kstackwatch
+
+2. Watch a local variable of 8 bytes at offset 0 in
+   ``silent_corruption_victim``::
+
+     echo 'silent_corruption_victim+0x7f 0:8' > /proc/kstackwatch
+
+Module Parameters
+=================
+``panic_on_catch`` (bool)
+  - If true, trigger a kernel panic immediately on detecting stack
+    corruption.
+  - Default is false (log a message only).
+
+Implementation Notes
+====================
+- Hardware breakpoints are preallocated at watch start.
+- Function exit is monitored using ``fprobe``.
+- Per-task depth tracking is used to handle recursion across scheduling.
+- The procfs interface allows dynamic reconfiguration at runtime.
+- Active state is cleared before applying new settings.
+
+Limitations
+===========
+- Only one active watch can be configured at a time (singleton).
+- Local variable offset and size must be known in advance.
+
+Testing
+=======
+KStackWatch includes a companion test module (`kstackwatch_test`) and
+a helper script (`kstackwatch_test.sh`) to exercise different stack
+corruption scenarios:
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..076512afddcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13355,6 +13355,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	Documentation/dev-tools/kstackwatch.rst
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL SMB3 SERVER (KSMBD)
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Namjae Jeon <linkinjeon@samba.org>
-- 
2.43.0

