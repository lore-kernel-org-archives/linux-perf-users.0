Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2E2BE639;
	Wed, 10 Sep 2025 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482437; cv=none; b=A8uGEkEl3YOuQL+Zl846UVz0ETlKnYMNNlnaCfBk7AzuauDWB+O/deSWHYinLXeOA8PKMZ0mIT0/d5ox/SlU+v/+zjzW/ZvOQwE66lCcsu3Y6l82v/8j2BRNAqaSUUNQspedjvfWRZ9xA7MfQPh0NjmE3dxGnRVLsq4KncrsQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482437; c=relaxed/simple;
	bh=CEdClddGjVYx6HjPNGBFPBiAS3jsMfpyA1eRZqyA0js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMZslnwyI/uGk5wbgJU5q6vXXPYjHKgdqqPEscWIWqxyGpAwYm8tDWgfTtIT8WM0jdh3bkh7LtmeFz6ysEcGvfkcA9aCfRnpYNqhjeW6b02jnk7pIxHtxmEpAlYxx6SJpTVh4sQjt6wiz5F8nS1dO9pUcbGn9QoOn7V0Pkx3WXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVcdfeum; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVcdfeum"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77250e45d36so5589712b3a.0;
        Tue, 09 Sep 2025 22:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482434; x=1758087234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqWZ4PXPvcwGUSVpTO1OvKWC6TpQO7QLp3apqR6W4A4=;
        b=aVcdfeumPj1MDW1b1K3lU2cNt/3yyS7RurufczpWDJBoxhLEKpodgJ6yve2z1+UbtJ
         2WO5DbpBDEcnAZpNhU3mC3mWMbjR4PeRjc3OmR0dsVFa8blGqffcMSz4Z/Dt6brj28bw
         W0F9X28CtSlo7JZcY7J8EPZ7TmYJjYA10agC1iVHb80laQhUQo6acXk5yrwCAZJtcCoc
         teWhs1OAMXf3D9DsASILsT/003EySUqMnRjUIVHa/CelHw/1X9/snpaGVIJJJ75VSXX1
         iGKhJBT1yx8lr1SzLSNAHhQr7VSuX+ycgkcQYRz7CMOuAme2hCar1Wk/PtmF+CScf/Qd
         Nk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482434; x=1758087234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqWZ4PXPvcwGUSVpTO1OvKWC6TpQO7QLp3apqR6W4A4=;
        b=WxVMbXhN7lxP99HWbXa2zgjkvCVWmEwVNLEs2csnpaEuMUTyNYs1/wiDCaH6UOGoPc
         kKRGLuF3Tj+Jrwic8jEeJoTIf7ajrYlprF+PtJIqv3JKoTKVs/nTlCWD40A9egycr+p8
         poutitcSQbVvR6Ejd8V1mBPmsjSGz58h4lpNipoC+g0T6LT+DgaBd6T/rujNc6hMi2E7
         59PxwMGSV7pDLBxNOIg1tbz6M8LWATSZGtxvv69k1G3HjimfTCo5DhdHZojeP6S8IWYj
         4l59cqoVAaDH3gIZxYmjgDI+d/TSDgsXEMhXT/YCN5QM75Ccr5sMBWX5Dx1zsJ1E3VQk
         EWMg==
X-Forwarded-Encrypted: i=1; AJvYcCWal5BNmfYSz+kac5czS+qADiKlE/b2uXyZNgFZQ7RgLHjBTR7mOAemOIM9fwek7p5O38JrtKaAKFpKTm8beWV8@vger.kernel.org, AJvYcCXP4EA3kpxMUUS7Gb+u8ijyydHUJPwTznnaHCLeyYYt7dK+f6FwJyKFVRXqMpCv3sBU5D+FP/xd3geMqYPC57WcwU4n@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKRqcT+1Y1s2ZNAoCzsZbNQSW3o5j1sOFIU3k0YeY5XvbxYfZ
	21TR6EpcCm4lH3P0WrzjQcNN06L8GPcMo2WxgBYlNEmyQ7OzfvJ0D9jx
X-Gm-Gg: ASbGnct8vXxANoGT+OHYVLilw97JWARP/2jcs9hpHjYrkQAzMFJu8Oy+6VmbOQ6IcOM
	fsdWVDXKnT4aYI/pTFNc2mSY28QiRIxgQUtcrIK/SzGIlrFt7B3ouFVgROaEDhJWLZlgm2xBoyr
	TyFERoQENy9K4DxmNGe3rcxhBgIMjdlzxWsQ1JqGb9fuUxtVdN5CdbEVuV1byyqzmEnhIzcggvp
	T5QrelD4cQ/lCV+DSC3FgdPw1rcuKseucm3Z89TkbNsO/E/Hzlo/K7RuMkMv1HjKm9d1YCqkd81
	ZsjpBZMmkJu5Ak26bvxhGZzZ0U3CZ35rI2n/sokzY48WTmN3XLxLP80X3TyFd6bgbjoYduPjYGe
	HBR0H8EE7KULdmRABjnXxQO3fec9aHLBRf9MiPAGv1s2tOb0lZryb7LxQwlN4
X-Google-Smtp-Source: AGHT+IEZNgWra/khv2n0XoAUNyfzdm90ade4Ygcmox5Pwd0/l1pQp4buy1JkzuVbOi4x7gskbJfFvw==
X-Received: by 2002:a05:6a21:339e:b0:24d:301a:79d0 with SMTP id adf61e73a8af0-25341e682eemr22538642637.38.1757482434425;
        Tue, 09 Sep 2025 22:33:54 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:33:53 -0700 (PDT)
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
Subject: [PATCH v3 18/19] tools/ksw: add test script
Date: Wed, 10 Sep 2025 13:31:16 +0800
Message-ID: <20250910053147.1152253-10-wangjinchao600@gmail.com>
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

Provide a shell script to trigger test cases.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 tools/kstackwatch/kstackwatch_test.sh | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100755
index 000000000000..61e171439ab6
--- /dev/null
+++ b/tools/kstackwatch/kstackwatch_test.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+echo "IMPORTANT: Before running, make sure you have updated the offset values!"
+
+usage() {
+	echo "Usage: $0 [0-3]"
+	echo "  0  - Canary Write Test"
+	echo "  1  - Canary Overflow Test"
+	echo "  2  - Silent Corruption Test"
+	echo "  3  - Recursive Corruption Test"
+}
+
+run_test() {
+	local test_num=$1
+	case "$test_num" in
+	0) echo "canary_test_write+0x19" >/proc/kstackwatch
+	   echo "test0" >/proc/kstackwatch_test ;;
+	1) echo "canary_test_overflow+0x1a" >/proc/kstackwatch
+	   echo "test1" >/proc/kstackwatch_test ;;
+	2) echo "silent_corruption_victim+0x32 0:8" >/proc/kstackwatch
+	   echo "test2" >/proc/kstackwatch_test ;;
+	3) echo "recursive_corruption_test+0x21+3 0:8" >/proc/kstackwatch
+	   echo "test3" >/proc/kstackwatch_test ;;
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

