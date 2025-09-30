Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F226C3BD
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200357; cv=none; b=LKuJ/yv/oTwSVz5gygH7Mah6ab4Q3dlcsbpLFbGSTbTfuhjSTui0m8i6iLV3tWc9Q8TS88zLbjywcExZ+avPJUbd4jJwofWbobEpcHAEttsDsgr38vzDt28s0kDAmJJWy99CBfIygw9z3Sd59XMYYdwQnxtr+zdh4bgKjS57TxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200357; c=relaxed/simple;
	bh=WUmvecag/bRJ9LbEABvkcHBuLoUzQ3sY4/EKuJYpRQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMlRu4dxHEZtqjEFWV8n1tMa6u4O1YoOpDbfc7bEJ1dPlDwWAmaeG6CPR95RhjepCAlvWvo20PZcbK2/HGbiXF7L9KgltnraklgJRWFm/0zMaaamBzcUuZwL0ihJzsrqiFU64exSUCq7vpHuBN9lAyXlsrqkLq4IoyqM3QZIgAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtNTcY6n; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtNTcY6n"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f343231fcso3067764b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200355; x=1759805155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANupiyfNlS++I01zMHP5Qbsc6Wgfn8wZLgNnwRsiWjA=;
        b=UtNTcY6nEyOkr6nfhHubQfmLFjQMmbWG9I/TLRBH+IUtB1rWBZQ/E61TFCjA5f6BnG
         NEzWEYOXZuup0kUOIr9fqcxL9+C8dX3J7CSMwq7n0WuJhmHDHdCUSdIaeuVgNWmiyaNz
         LI1rT27GDNqsCt728MSjQ/5vKlRBRCumScPxNQehpSvpsXYYJDkzYLmRnEaED43NGerJ
         wS3hNXB4Kla0AVzFIbcavTLQ09PwgqQQtMWasLR8+l5pNND2I+XcFwnm3xK5qVuvFBPw
         jFINLsNyqvJbEdob8KKtg8tZSLEye/gLqTcDRG3m+prja+73T/tpATIXOZlBtsz3/nR6
         L/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200355; x=1759805155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANupiyfNlS++I01zMHP5Qbsc6Wgfn8wZLgNnwRsiWjA=;
        b=Mn5O8L7yJPthtzci2wri5Q8KiNpSXQBi21NzWL5UyC1HvXW/X5tvaj7qd7tUkrX9A5
         tx6Oc0Vqd249j9jPOVBWNrodhFnBSnixIiMRR0qOxNdOiqiE0jfiPTTIyhEsKy3bi0Ve
         qkdodm07VcvBCysDPep++TooiFxMikAcpGd2LcWvdBtl+CD1qpirJvg9cUVXULnY4/mW
         WIXSUemwHiGPtbYuhE/KyLXalO3390vi4F4L4swN8E/WPjntlXjmmGV5aqsdMIcOvRzI
         1bGh1noC48XPq33g4PQ/dc0T8FK7+7iKGR81TqjPbFfMGNcB5HYz7WXbU7oJfV0sLsmG
         1WHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPgWTYrnl95t2ogEMcQ0ZGvbjcnq0HQAJgH+z7nEzkNcz5gK4EjJtjO5+MbulucfHhBINvO+hdZBg19n2RT/Li@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYBdzD1xVaJ0Hge6cPKsVQ6yGcj8ZHkYdbklvfqfo6uaSsTdl
	X5rk0Lk+7fCzd3xJ5E5Z/2scGk0QSMH/fj7pMOn3R4cG9x3kHMyWOxfb
X-Gm-Gg: ASbGncutfRYJlWtncG4mv+VDY+/m9767fh4NHlnQtCRBfXZ5hbw70dt2Q2BP0R4vmuh
	l3e1PJ0kU4RGkORcxI9oxlfrx+XrrMRIce0rV0h/bd4bE07Wxrs1HTDaoaNcbCIxB/2LDv5ZOA6
	Vu5gjMRl8BoZ2BFwG6EQF31IyiwSH4DjPzIuFoaeb2RpxrkNRLfI4s289HOW9YdW75YoSS79Zmv
	l12TPlTibQM6LTBqMnJkHJDS6KI3uWUzHGfMZVuzyntIaGzf4gWeFKY5T2hkJtvibccR0VjaBFv
	NMIjfm5Jrj9b7yxEcXYnG9TFvFO5cZUw11bN567GFzs+yLqfIPhdTOLfVDQ8kYQLtXlPoFqJ025
	22M60+3lg/fyUUEDVDpeHPkEiTlbCIkeCnsxgdoG+WO4ys0/PBrGP0qkyNp2DhsUYGjUtqSLpMp
	Uu
X-Google-Smtp-Source: AGHT+IFgQx8Uh36EA0aXny7DSw1dXOgHQg+bo/K2OmzhGw1sKK8D6YsVYmNHfsV+5mgUHC/7blvjEg==
X-Received: by 2002:a05:6a00:3cd4:b0:781:261b:7524 with SMTP id d2e1a72fcca58-781261b762bmr11615416b3a.14.1759200354649;
        Mon, 29 Sep 2025 19:45:54 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b2ec47sm12565336b3a.50.2025.09.29.19.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:54 -0700 (PDT)
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
Subject: [PATCH v6 19/23] mm/ksw: add recursive depth test
Date: Tue, 30 Sep 2025 10:43:40 +0800
Message-ID: <20250930024402.1043776-20-wangjinchao600@gmail.com>
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

Introduce a test that performs stack writes in recursive calls to exercise
stack watch at a specific recursion depth.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index 012692c97a50..203fff4bec92 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -18,6 +18,7 @@
 static struct dentry *test_file;
 
 #define BUFFER_SIZE 32
+#define MAX_DEPTH 6
 
 static void test_watch_fire(void)
 {
@@ -46,6 +47,21 @@ static void test_canary_overflow(void)
 	pr_info("exit of %s\n", __func__);
 }
 
+static void test_recursive_depth(int depth)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("entry of %s depth:%d\n", __func__, depth);
+
+	if (depth < MAX_DEPTH)
+		test_recursive_depth(depth + 1);
+
+	buffer[0] = depth;
+	barrier_data(buffer);
+
+	pr_info("exit of %s depth:%d\n", __func__, depth);
+}
+
 static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *pos)
 {
@@ -71,6 +87,9 @@ static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
 		case 1:
 			test_canary_overflow();
 			break;
+		case 2:
+			test_recursive_depth(0);
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -92,7 +111,8 @@ static ssize_t test_dbgfs_read(struct file *file, char __user *buffer,
 		"Usage:\n"
 		"echo test{i} > /sys/kernel/debug/kstackwatch/test\n"
 		" test0 - test watch fire\n"
-		" test1 - test canary overflow\n";
+		" test1 - test canary overflow\n"
+		" test2 - test recursive func\n";
 
 	return simple_read_from_buffer(buffer, count, ppos, usage,
 				       strlen(usage));
-- 
2.43.0

