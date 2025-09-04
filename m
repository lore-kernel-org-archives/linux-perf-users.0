Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1EA199E94;
	Thu,  4 Sep 2025 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945445; cv=none; b=A6t9qnV/2sOM9NOCHLDeMEiQheI3D20Mlqt8VTlUPt9kjeWNmCBmkKjpSLTGRHSTO5S65XrTnRL6JEeQwXPFPkbhtaQQR2vyigIe8R0hr8PX4/TavAU4qrIvb0fUxaZej/rkDLzVBzj9XX2PHEFichn1mbCdpPCRCpv2WRhij/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945445; c=relaxed/simple;
	bh=LZfImMzMcwQbupG4M6+Sd95ddnMNs/MgYxCY/DAN4QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bg+bvWHZubKkF0QxnmOd39hff0CwW2rYa2daJRNLTqlyFMgKhwCX7Hnu+aLOxx7XLhSyplAnqPTkDOVX+1r3QRSyrPloQM/pVrmEb99rQSV+YhZOQBPe6LiHZwIyFk0bywVVU/fm7vhDGo2/qYoWy7eHvvhZFbSAWZglnP6hQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0+wcD3z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0+wcD3z"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so334358a91.2;
        Wed, 03 Sep 2025 17:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945443; x=1757550243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrzeI3EYnXpSYBJKftFAUOvxevvy4jLNuncba+XGBDk=;
        b=V0+wcD3zAY0DWXW0Ob86jXpmPq0Yz6BmXET9ipNLk9fy20hS1GtA4pXlNs1c+A8Bdq
         QBC4Qz2r/3XmqHSNdNEo09ruunOInYlYtOV99IgEfZXfgqQNn3tU5dJvDVolw9vg8VrE
         0QFtq00kGxlWAlQ0fv8sXA95WcVGwOvVyxNrwhBTQ3xVHMwdK73Aw7ceYdbLAWR6Uj3G
         IvT+Y+DTGZDibqQXuQHD04Nvp4AAcaCiAtj8Dd9bTiBo1nMwFt1KW7FoVV+tVFYJU9uY
         GXA/AWzkNFfnhP0nsiyW3rcnYXOczkm0IXmHcobfTq/4iCtvdq15bsf2dzwn5eNLRq1Q
         ct5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945443; x=1757550243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrzeI3EYnXpSYBJKftFAUOvxevvy4jLNuncba+XGBDk=;
        b=InDczYQeVeVJcGTDTuxgnTeA/ZJxX9mzlNE5liBv+jKq6IQe+hUkB5ECugkmE4uGSp
         jnd4itueGzY2pPD6TraFQOxilBW/z4E2VTUkd1HxBWThelLBGIOn+x6QbGRrEcWULjxb
         lEy7PUyTx4uH4JLSaTI0uCQmQuK5y/fXEoCyREhXNh8QB8S9e43SpAL/zUFs3dtG86dz
         eq+cG5fD1kYm1fzop3GMhmf8ZVtvEvqBGZRsZZg56GjSWj2BrQ79XGCkJY6KqdRVmvKm
         +hNJCcb+ww3eyLVrwRRIjo92DInDdX8InxJ5YoqinqoZlAwI/KS8OFhwDhNqrg6YDDqU
         SZDA==
X-Forwarded-Encrypted: i=1; AJvYcCXR9v4grtH++yGkcsYAMfyQCDBWvQ6JTwLr6ciGI8tfKJtUl++7Yg+Q/jx4UkDd3egWZ82ntbVvVOZMqk9sKEEW@vger.kernel.org, AJvYcCXg2T6F2F3Mv70aN2eU4/nGutI/VxklTJ0cZFzu20V7nvVyFX9OEGzoMqc16yjW0gNd3aSro6hNb0RTLikOarVXQuiu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9c8pG+hR4f3zHlje6DAKGO37tADoeZGTQF25wXpibDVUlsgGt
	5EC1wEdNdsJKG1wSwXqEtfSm1M6VQj7C9vpvMOVDUJb1EQKI9tTNMoR1
X-Gm-Gg: ASbGncswQB8JdRHJQdKZ6jX9nBYeBRT7yHKk1OmKVpkZH4BCOiw006nYxCx1BmyBBwv
	gIBgz9HC6GJUnGS5KoO3xibmS2Anx7MhOW2bDds0Z8LBtumqDnByaRyFpxB8a8VrpzAC6rAXqk3
	CX2crbr2LmQBFBmbTo6hJ1uEBYMscVYQoR7q+x1LcHm5avSIUCv1W91dtGARdUWBv9HcCKgSqbM
	8q6SFlt1Rlj4LkCjUwL7l2QHNmfLZUVK0x6VA+Y01SET9qK2aHImpORzzrK/6qhtR0pOwvy0G32
	ilJ+clTOZpxwxDOLn+ppg2sxhLwPrsew3xNO9uOdLVJFbIJ9sTA5piWNZWkaA2uM9f9uPFfZ9gc
	N5flkVuABe5WTeZBxw+NxP2UfoEVDTv9owJX3o30/NGA1sSM896BOGsbvBe3GIFM=
X-Google-Smtp-Source: AGHT+IF59l6Y6il6sWe+ojfk5O2VEV4/iuJ8NUJrR5PDNiGZHhFNdzPEip0wnBYNg8k9w5p76AV22A==
X-Received: by 2002:a17:90b:2e04:b0:32b:5195:d124 with SMTP id 98e67ed59e1d1-32b5195d364mr5800597a91.11.1756945443320;
        Wed, 03 Sep 2025 17:24:03 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:24:02 -0700 (PDT)
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
Subject: [PATCH v2 15/18] mm/ksw: add simplified silent corruption test
Date: Thu,  4 Sep 2025 08:21:12 +0800
Message-ID: <20250904002126.1514566-16-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904002126.1514566-1-wangjinchao600@gmail.com>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a lightweight test case simulating “silent” stack corruption
where hapless() is unaware its local variable may have been modified.
This test is much simpler than real production scenarios but demonstrates
the core logic.

Test logic:
- buggy(): exposes a local variable via a global pointer without resetting
  it, creating a dangling reference.
- unwitting(): a background kernel thread accesses the global pointer and
  modifies the pointed memory.
- hapless(): operates on its local variable, unaware it may be modified.

This controlled, minimal scenario provides a simple way to validate
KStackWatch’s detection of unintended stack modifications or silient
corruption.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch_test.c | 90 ++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kstackwatch_test.c b/mm/kstackwatch/kstackwatch_test.c
index 138163472b03..1f0d616db7c5 100644
--- a/mm/kstackwatch/kstackwatch_test.c
+++ b/mm/kstackwatch/kstackwatch_test.c
@@ -22,6 +22,9 @@ static struct proc_dir_entry *test_proc;
 #define BUFFER_SIZE 4
 #define MAX_DEPTH 4
 
+/* global variables for silient corruption test */
+static u64 *g_corrupt_ptr;
+
 /*
  * Test Case 0: Write to the canary position directly (Canary Test)
  * use a u64 buffer array to ensure the canary will be placed
@@ -63,6 +66,86 @@ static void canary_test_overflow(void)
 	pr_info("KSW: test: canary overflow test completed\n");
 }
 
+static void do_something(int min_ms, int max_ms)
+{
+	u32 rand;
+
+	get_random_bytes(&rand, sizeof(rand));
+	rand = min_ms + rand % (max_ms - min_ms + 1);
+	msleep(rand);
+}
+
+static void silent_corruption_buggy(int i)
+{
+	u64 local_var;
+
+	pr_info("KSW: test: starting %s\n", __func__);
+
+	pr_info("KSW: test: %s %d local_var addr: 0x%px\n", __func__, i,
+		&local_var);
+	WRITE_ONCE(g_corrupt_ptr, &local_var);
+
+	//buggy: return without reset g_corrupt_ptr
+}
+
+static int silent_corruption_unwitting(void *data)
+{
+	pr_debug("KSW: test: starting %s\n", __func__);
+	u64 *local_ptr;
+
+	do {
+		local_ptr = READ_ONCE(g_corrupt_ptr);
+		do_something(0, 300);
+	} while (!local_ptr);
+
+	local_ptr[0] = 0;
+
+	return 0;
+}
+
+static void silent_corruption_hapless(int i)
+{
+	u64 local_var;
+
+	pr_debug("KSW: test: starting %s %d\n", __func__, i);
+	get_random_bytes(&local_var, sizeof(local_var));
+	local_var = 0xff0000 + local_var % 0xffff;
+	pr_debug("KSW: test: %s local_var addr: 0x%px\n", __func__, &local_var);
+
+	do_something(50, 150);
+	if (local_var >= 0xff0000)
+		pr_info("KSW: test: %s %d happy with 0x%llx", __func__, i,
+			local_var);
+	else
+		pr_info("KSW: test: %s %d unhappy with 0x%llx", __func__, i,
+			local_var);
+}
+
+/*
+ * Test Case 2: Silient Corruption
+ * buggy() does not protect its local var correctly
+ * unwitting() simply does its intended work
+ * hapless() is unaware know what happened
+ */
+static void silent_corruption_test(void)
+{
+	struct task_struct *unwitting;
+
+	pr_info("KSW: test: starting %s\n", __func__);
+	WRITE_ONCE(g_corrupt_ptr, NULL);
+
+	unwitting = kthread_run(silent_corruption_unwitting, NULL,
+				"unwitting");
+	if (IS_ERR(unwitting)) {
+		pr_err("KSW: test: failed to create thread2\n");
+		return;
+	}
+
+	silent_corruption_buggy(0);
+	for (int i = 0; i < 10; i++)
+		silent_corruption_hapless(i);
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -90,6 +173,10 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("KSW: test: triggering canary overflow test\n");
 			canary_test_overflow();
 			break;
+		case 2:
+			pr_info("KSW: test: triggering silent corruption test\n");
+			silent_corruption_test();
+			break;
 		default:
 			pr_err("KSW: test: Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -110,7 +197,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"==================================\n"
 		"Usage:\n"
 		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
-		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n";
+		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n"
+		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

