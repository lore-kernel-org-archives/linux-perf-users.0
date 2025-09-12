Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C62F28EF
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672010; cv=none; b=sKI8wtyRsLDeAY5sfLxOxPFg2RJpTXXS6HVWCaDJ5/0MZDGczgpRg1Jpwtqa7dqIwqwkRMUVH0Ytcdxnsfst2BsjuCED/87Qe+4XFfnK5P8oogeYDe/DOMwacjzxgM3ow2tfqSY1b5qmwUDpwKQlcxRGDTuIX6VRPtBlyKNiJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672010; c=relaxed/simple;
	bh=k6timgyy8B4GPUl9IUPi95Oa04aVieHJCexEN+DVT5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/m+qm7FcrbE3lBHF//JgudjEGeqGC+kJLu4AfoINfz7bnxUTyA+7v/pXN6k139xNfJRIITqyOYu4EWelfS5rnubqlnhVXkWlsUacvhUKUaQ3xxm4QxV/ji2dwJf+LspLY1BuvsDDLOYO8FPsjzZ6w/LBOQWY+BFIs3IKT7D1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwL2Tz0X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwL2Tz0X"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24458272c00so18783815ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672008; x=1758276808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5u/a2s8j5yqiSFbkPas+Re9l+zCPojPRf0oLtuMcdk=;
        b=MwL2Tz0XVsS+r5ozTCrIlMb06yMsEs8UVob0h1JVcrLV+Z3G355tyMmhBvyDldpfwO
         gn8PhuE70WA82Rrf4h+uTDiOkgIWnz+qN9b/HBSlPHHODyImOSkbwI8dMr7G6Z/iojfn
         hDKzeJLbX2gJ/Rmk59EpxX5GRVhwBdoqmH8OpjlNd7GyliXwnoeXtnl8MWvA/n9VCiHX
         GTovlx31S0rHMtYXf/Za7qkPTd091638SUjb7coZoMWdvCv2h8PJm867sYRfE2+uL7xN
         yUfme2a6ytDj7+yW4s1GG4ZDlEa92fHzLZPjEPvVTJMXE/lKW2GqRv2d+iZufspPfZYF
         Jwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672008; x=1758276808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5u/a2s8j5yqiSFbkPas+Re9l+zCPojPRf0oLtuMcdk=;
        b=ueT3hf/kmV2V5ZuSULBuYE3jD0hBAdX1tEIM6Bcs9CusPYcKbS5cXio+GUiYRzx9Aj
         8gtvRxOR5ETsatIS7ay2fmiOOcUdc2qmtYCA6bAnWS+rjH6HMDm9idTmHGUa8ex+YYhv
         PA1tOou4P+8hkW91i9Vveax+inajWweqmdNMUKRg8yUwqCCdyZ2eedYDhM7ET7UfoB0R
         nQvuEvPc+I2laDUe+UTCCO5dVjVUwd+p+0h0+kY4euNWPEAriKCCS5IAnOAVkl4YQi1l
         ZqsjKZE7EPZ7TWBgFY7hUgWKQVR1BQH75302ACJXs73us0ZSeIxP843X8naHoPCLRbZZ
         Y77Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOcuDSmWXpBYHwMmHLMKSrLNXFqTMCbe3ijowbq9sJAVmaj9Z81cSDIyXNknJD0uahT0k1w/aLJSgPpL2McdpQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdNWCJKh0jJcmXTu8+OBgOmkZDsjAhCeTIIZbR97isg/82UaV
	KsN9Dyk+tOMSVALINVWnMcWg2AEWhBddF0yvQIAGx0FN8WxEuUVgiRCY
X-Gm-Gg: ASbGnctFcQGIKR76diEeNTiBymmxJKtCku96VClNXGTn3QLxgVHWJN2xXnb3N7sdxnv
	r4AonRb1jxu4WdeNK0JLZ3if4q98x1n08DTiOr36AUIIzdmZ0t5mHIVdAn+0e2bMNnM4QtxVFNk
	oslzVxDpVp48+jMRHmIB8zM0l/C+m60Wb9x6KyIwwbhKN5CwQaJqZweXnFuvgHW+lrk234vUeVo
	h7j2POM4yt+4nGC8OkLwLCLtT0qP5WWg5CVs5+RI5l4GkzGvnPSksvAGNw2uGSzXXa3TV4IT7YN
	d8oRy+3b2FEQZN0nHe6Q8pJhYFk6fIm+Pq8RyrKzj3VhKZWcc4AszODhtmWVKR+3XJp8adHNzSo
	I4UAPzy3yr0recCOSnqf+7nlhq709t0iW5K0=
X-Google-Smtp-Source: AGHT+IHfq4U4MFqDIc6ZxO6yNatWwL7n6+/zPGuAMGcOfOLtnumo4rnkiu74aB1UWkUMdayihYaGMA==
X-Received: by 2002:a17:902:ebc2:b0:24a:ceea:b96f with SMTP id d9443c01a7336-25d24e9dc1dmr34403925ad.24.1757672007735;
        Fri, 12 Sep 2025 03:13:27 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd9509002sm5179465a91.0.2025.09.12.03.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:27 -0700 (PDT)
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
Subject: [PATCH v4 18/21] mm/ksw: add recursive stack corruption test
Date: Fri, 12 Sep 2025 18:11:28 +0800
Message-ID: <20250912101145.465708-19-wangjinchao600@gmail.com>
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

Add a test that triggers stack writes across recursive calls,verifying
detection at specific recursion depths.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index 2b196f72ffd7..3e867d778e91 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -150,6 +150,27 @@ static void silent_corruption_test(void)
 		silent_corruption_victim(i);
 }
 
+/*
+ * Test Case 3: Recursive Call Corruption
+ * Test corruption detection at specified recursion depth
+ */
+static void recursive_corruption_test(int depth)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("recursive call at depth %d\n", depth);
+	pr_info("buffer 0x%lx\n", (unsigned long)buffer);
+	if (depth <= MAX_DEPTH)
+		recursive_corruption_test(depth + 1);
+
+	buffer[0] = depth;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("returning from depth %d\n", depth);
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -181,6 +202,11 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("triggering silent corruption test\n");
 			silent_corruption_test();
 			break;
+		case 3:
+			pr_info("triggering recursive corruption test\n");
+			/* depth start with 0 */
+			recursive_corruption_test(0);
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -202,7 +228,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"Usage:\n"
 		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
 		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n"
-		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n";
+		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n"
+		"  echo 'test3' > /proc/kstackwatch_test  - Recursive corruption test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

