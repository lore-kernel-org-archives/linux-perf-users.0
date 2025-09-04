Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984820458A;
	Thu,  4 Sep 2025 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945465; cv=none; b=ty2//Yg17t6LMWJiEB7rVmDNdQOO/HMNtS3VHySemyMUtFuSzeNWGF/VrwnAlg9erNx9TYYC2Koc5GRQpPtBmiESBsezxoiD2UdUDUSInnTGwGuZntA6WAMI1FtUOe6FideX+SHhPl0d+U4hoHC8nhjCvx1SPZVtBWT7DXTH5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945465; c=relaxed/simple;
	bh=3tN/HRC+L41rVh+xg7/C6oFcNmhKFhjVH37L+PVpcpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed+OH+S4fmFnT9ub/eGPf8Rp/woxbZ2QnZ5Ix3tkwqiHgCpuE10/0RtQoREGV72rK1qzqw1XsDV+SLJ1PsIhdtyr0VOmLHQBpgqaV2QOlmXETdv1x86eh4KQe4PlRgSRySID+GdoJ+8Wxy8+BNWv+sVj+B901TsbwShK4s6diXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSQminmy; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSQminmy"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-327771edfbbso374929a91.0;
        Wed, 03 Sep 2025 17:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945462; x=1757550262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=incKrp2UiMRL1bfFYHRaGnhm/dsia+B968fzxhF99tc=;
        b=dSQminmyNQQG72ol2z4mYrvANJ4OS3X1te2mK8oVpnWgtfPiPBfDUc4J2ua6BiW+ku
         LVic4Vh/Kh1CztcLa5VXHh9pTYyMMc9HfI9jPOIk3XnpkHvBexuou7kY8k057yMt4kys
         /X/zuYWOuZEu3tKwKZB6SfCZBpu606XC7qgrJN9ENdGfmLgAknYYD8hZ94cT5K1e+gsa
         Zg7e007oBPLSDxHdTPq0xIioO9q1b+GqsC3Nl4WGs7v/lmG+Pigc1T6SOmeOeASHaJOP
         YykHYB31p0YH66vOVwPhT1Acz34DY5vdJzGa8Ujlrr2WeqfU7HWH4bLerXWq3FzK81ou
         bkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945462; x=1757550262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=incKrp2UiMRL1bfFYHRaGnhm/dsia+B968fzxhF99tc=;
        b=xCy+rV6b9EXrkuUDd88CN9XZhb4h1uGKgcMLZF+xMHbKgSZNOKD7/6tlrjHphSxHjM
         jB3KhwyjRUhra465QYOzQG5Ssj6pGacp68CMJMSTep1l3DdvXbMgpTHUDoMtHOX+JLL1
         M2fRovp8Pdn8iD43e+kEhOfd05f++Js1YH1gj4MJUv4KmXws9vAYrTxKx+3uvPAkZ37Z
         OzA1MBDr5eUs/m2S0n5W9cfOIyEy2H0PSxiE4Ru4NkV2VbssAt0hGUVDcqWUdDVdVXFu
         lZKyQUSWuTMib13WOKWQ67dx7wdQLn6YF+R8hzPh7vPUa0obiHy3dtfhYnfZRGAsf7kI
         yPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+2xtbHynuC01Ar2B1uPdUZNbKsQ1ZrssKL3GLSZ/8AiPC/25JmZ4GLpYtOz/l0ANdbgUGCm3+T8U7LoMcTMkFzh+4@vger.kernel.org, AJvYcCVip/VGTYkQhqInlLJ4s/N9MA3tutmzZ8/vdth7N0my/xzSzTpY5kYQ4/XaQrN4C8bHnXNl+PgIrkxlR2+aA4St@vger.kernel.org
X-Gm-Message-State: AOJu0YzHEh0QFkp+Xh4vIeTRITIgKJ3vIVg4E0HM6UTaALeo6PO/osGZ
	tT46cEolISvtyWhCdassR0jVxTYH4/qHDkQ1gCfIXzxW5uX332WE9uZT
X-Gm-Gg: ASbGnctif32wEadIhIfT2WiWkVFo8urN9oj/EbCpdjhjJUbi/6kNBlTY18L8msj0leH
	tCflui7XBhGpJszffXTTPZBL/tUjwPwU972YBujcYqnM4pzLW+m7gFXqond9AwgKEl82EvOQP/0
	fDAbZHXTO/CibM9GmF5hP032Up+60uxWBO9zbfZvSUYg+gO6f966m/nSn73gPfshji4feE2gHQc
	kBzQllX+TQ2+npvNOifdep0Y/8PEc9jxFpBlMMQMVjrFnrXdpvvHIDK9VXQBIpuyRw0d1raCUr6
	egw7mDLUJBhV1CtDIGsTp5OIz0TGlQ7Lococ0X0XT/uVQUcZoaPVpvxf4X/gCSO87QBGZvZ9HCb
	GN/1hjhQzyLJzpGN2i4cWEGrQIUUkCxHZg5oODl1HJ/szjRSSD+qK
X-Google-Smtp-Source: AGHT+IEWdRv7pWRXFkXZkWNxZkP18IvQb4vEl1O/0LufV3mWJr4v4vPlNk8x7dizzsCLeMOYBwD13g==
X-Received: by 2002:a17:90b:3c8d:b0:327:ea30:4 with SMTP id 98e67ed59e1d1-328156e0093mr20349272a91.30.1756945462223;
        Wed, 03 Sep 2025 17:24:22 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:24:21 -0700 (PDT)
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
Subject: [PATCH v2 17/18] tools/kstackwatch: add interactive test script for KStackWatch
Date: Thu,  4 Sep 2025 08:21:14 +0800
Message-ID: <20250904002126.1514566-18-wangjinchao600@gmail.com>
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

Introduce kstackwatch_test.sh, a shell script to facilitate running various
test scenarios interactively or via command-line arguments.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 tools/kstackwatch/kstackwatch_test.sh | 118 ++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100755
index 000000000000..fcdb5ac9b607
--- /dev/null
+++ b/tools/kstackwatch/kstackwatch_test.sh
@@ -0,0 +1,118 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# --- Usage function ---
+usage() {
+	echo "======================================"
+	echo "  KStackWatch Test Script Usage"
+	echo "======================================"
+	echo ""
+	echo "IMPORTANT: Before running, make sure you have updated the offset values!"
+	echo ""
+	echo "To find your offsets, use objdump:"
+	echo "  objdump -S --disassemble=canary_test_write vmlinux"
+	echo ""
+	echo "Then search for your function names to find the instruction addresses."
+	echo "- Instruction offset: address relative to function's start"
+	echo "- Stack var offset: distance from stack base (%rbp) to the variable"
+	echo ""
+	echo "Usage: $0 [test_case_number]"
+	echo ""
+	echo "Available test cases:"
+	echo "  0  - Canary Write Test"
+	echo "  1  - Canary Overflow Test"
+	echo "  2  - Silent Corruption Test"
+	echo "  3  - Recursive Corruption Test"
+	echo ""
+	echo "======================================"
+	echo ""
+}
+
+# --- Interactive menu ---
+show_menu() {
+	echo "Select a test case to run:"
+	echo "  0) Canary Write Test"
+	echo "  1) Canary Overflow Test"
+	echo "  2) Silent Corruption Test"
+	echo "  3) Recursive Corruption Test"
+	echo "  q) Quit"
+	echo ""
+	echo "WARNING: Each test may cause system crash/hang!"
+	echo ""
+	read -p "Enter your choice [0-3/q]: " choice
+	echo ""
+
+	case "$choice" in
+	0) test0 ;;
+	1) test1 ;;
+	2) test2 ;;
+	3) test3 ;;
+	q | Q)
+		echo "Exiting..."
+		exit 0
+		;;
+	*)
+		echo "Invalid choice. Please try again."
+		echo ""
+		show_menu
+		;;
+	esac
+}
+
+# --- Test Case 0: Canary Write ---
+test0() {
+	echo "=== Running Test Case 0: Canary Write ==="
+	# function+instruction_off[+depth] [local_var_offset:local_var_len]
+	echo "canary_test_write+0x12" >/proc/kstackwatch
+	echo "test0" >/proc/kstackwatch_test
+	echo >/proc/kstackwatch
+}
+
+# --- Test Case 1: Canary Overflow ---
+test1() {
+	echo "=== Running Test Case 1: Canary Overflow ==="
+	# function+instruction_off[+depth] [local_var_offset:local_var_len]
+	echo "canary_test_overflow+0x12" >/proc/kstackwatch
+	echo "test1" >/proc/kstackwatch_test
+	echo >/proc/kstackwatch
+
+}
+
+# --- Test Case 2: Silent Corruption ---
+test2() {
+	echo "=== Running Test Case 2: Silent Corruption ==="
+	# function+instruction_off[+depth] [local_var_offset:local_var_len]
+	echo "silent_corruption_hapless+0x7f 0:8" >/proc/kstackwatch
+	echo "test2" >/proc/kstackwatch_test
+	echo >/proc/kstackwatch
+}
+
+# --- Test Case 3: Recursive Corruption ---
+test3() {
+	echo "=== Running Test Case 3: Recursive Corruption ==="
+	# function+instruction_off[+depth] [local_var_offset:local_var_len]
+	echo "recursive_corruption_test+0x1b+3 0:8" >/proc/kstackwatch
+	echo "test3" >/proc/kstackwatch_test
+	echo >/proc/kstackwatch
+}
+
+# --- Main ---
+if [ -z "$1" ]; then
+	usage
+	echo ""
+	show_menu
+else
+	case "$1" in
+	0) test0 ;;
+	1) test1 ;;
+	2) test2 ;;
+	3) test3 ;;
+	help | --help | -h) usage ;;
+	*)
+		echo "Error: Invalid argument '$1'"
+		echo ""
+		usage
+		exit 1
+		;;
+	esac
+fi
-- 
2.43.0

