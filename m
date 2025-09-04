Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9478F20;
	Thu,  4 Sep 2025 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945455; cv=none; b=KOKhAOwEhI+rGzAgh5PLvTVY2f3GfrTQ+a3JASiWHKeBjR25YrBmpWNlq4rqDqbos2wY7lu4egFrnZtkg4U0DA1zTwKlQgTK63wCNmB/dJX1xanrGOoxT+MdMJg/7FzRlSWH3F5I7ANrGxxYXSg8qgGi370+7m8b9yn5JImT8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945455; c=relaxed/simple;
	bh=ivSu/IMaZGfW21FS3ZEvzo2NiJNn9PUIMXyecx0W7Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcwD+Ide2KucNSX4lLuq5MVLARqtXkYi5mPt0IS1Jt+dHDDLmROWf0fA+evphQd0CbCpX6aYcF1CfKf0uYc0BXg8uRpCpVLWtNXUEnIZJ0ZrIb/zfM+ZVT/BIdxoAORUMaRV+PRTiUMMNsqfoHFOvKonLFJaiQScfuydccLh1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoFE9I55; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoFE9I55"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso264130a12.2;
        Wed, 03 Sep 2025 17:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945453; x=1757550253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOiu/GBUWD+aWp2OIEycImwBUVzT2dU285cFy6GfNhs=;
        b=MoFE9I55HBvet4wMYS9nvP5jXQqcgS+UYW9myNrwefxQhCA7o+VhyMp9kCYdGRPrqZ
         X+lctpbHq3g8bGMm7s42xy2Dm/CVfR0d2EFysM01caP8OJRG7fYQZBMZyYUV7QUOmlWs
         hWRwIqqfQNdl1IiXa4+FNUKjliSHOsqBwTyWA3JS22SZahYx4IJgBikszXIkPglSk5WC
         SWU4gKdrjvlqiHI6wAaaTunfScM9p+7vAUnPtt9rBGZGoKOIGqM2gfkLCimXOyUoP5Mj
         OkoBF2FrmFkCoA3KB/Mx5Wk6IwRKfQKGFMyECrPG3LU1BkyB/oDPfbzstn5I7ek6Zoid
         43Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945453; x=1757550253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOiu/GBUWD+aWp2OIEycImwBUVzT2dU285cFy6GfNhs=;
        b=Tl+1c7CHuefiARghrd5R5Jo9HweOtQvZl49slHmErqm3c1bK5L0yPArkkLmanGPuLk
         t6/KwZX0mliktPsIqN8vjkNtE844rGG+1HsmvUZEug7oPXiaEeKDJr0Lg2OuwS0wMUB3
         mVUtTbHs9nbGbwaDwbrB0KZpjKv2YMGLkxQ6xzCOd1PZgKx7tGUT36dgnTUzbrWzqCs/
         3LoepfFOEdQN5TQ/ORdylFjlNtLtrUytOsYZvOTWHpITU6Qyx4rSVc0io9y0B5pMQAUA
         4o7lOAwnD+e5KlpamC/pf+wJt05Pxq3lF6mS9UTfaOTan3Bo83QrQLzvIRGN5Y82FnL4
         9P4A==
X-Forwarded-Encrypted: i=1; AJvYcCUmlPs41aINGIqDa+vLgU2kOu76ORE2tnOInKerWOEN/Gz9zXoz9kGZd39gnMRBCG28UINZzRyx77bEEfZ7rlHU2gV/@vger.kernel.org, AJvYcCVo8eeenXSEenQXtx97kEwsavxhv6+Y4Xu6pIY0v0Uy9ZIH9iCvFkQv8NruRX+peGCCY9Upc/xzSr5ldb2rBVOJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwPD0UCmlIf7x+cjiNwARvsJlrVk3rgY8rm5BGo/Ker7l5kmCMC
	aTA24rnx5POYl0Znzi3Z73o49gNDDKi+3blPWHmXW/p4JJesL4KK7muR
X-Gm-Gg: ASbGncvGTSONIWwv7v/ePG/iER6j1q6gNB+UIv13Ko9HeAra6oB5XjAL6vG31eW27xd
	h9pgltEtTyymHzYa9HEl9MHj2Rrtg2HpUVB8LJ1SVsN2ctv3ZilwfixEY3CJZAku3KV8ZW1eUjq
	OxRn8cpMt9P9Eci+oW/7T2rsYFUOihR0w7mcYO/dfsIBwRKwDXj+bfQg3P4SvjqWx8OW0DGcxMO
	GklQ+JlK9HD2tIs+kS5U2dqP/bfR4BixBr14LDWnQrgPM1x8Dv7u+UnDT3rQBQnKEJBSsDBGjbq
	bbqO9w1IqE2Mk5X65pA884oJI6BtH2MXpbWXOQ6mhPyN0iMEq+7O0b3WSL8NZRHfPWQ0ETm35AO
	Vq4ufZgokCVr0nKv2X78b6lOvCEFiAtogHEQZ9m8oySvtXXqu1yo7YZm949g3yTg=
X-Google-Smtp-Source: AGHT+IGlCKz3wi42oRDwUIR9PQQ4OHO3kKDWN9VDgQVuoZDIBj9URRG5PxCTyk/oUZhJZ+LJU2AQvg==
X-Received: by 2002:a17:902:c40c:b0:24c:b2a4:7089 with SMTP id d9443c01a7336-24cb2a4744fmr36622505ad.31.1756945452858;
        Wed, 03 Sep 2025 17:24:12 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:24:12 -0700 (PDT)
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
Subject: [PATCH v2 16/18] mm/ksw: add recursive corruption test
Date: Thu,  4 Sep 2025 08:21:13 +0800
Message-ID: <20250904002126.1514566-17-wangjinchao600@gmail.com>
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

Introduce a test case simulating stack corruption across recursive calls.
This scenario writes to a local buffer at every recursion depth up to a
configured maximum, allowing validation that KStackWatch can detect
corruption in nested stack frames.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch_test.c | 32 ++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kstackwatch_test.c b/mm/kstackwatch/kstackwatch_test.c
index 1f0d616db7c5..cb216b6ee5d7 100644
--- a/mm/kstackwatch/kstackwatch_test.c
+++ b/mm/kstackwatch/kstackwatch_test.c
@@ -146,6 +146,30 @@ static void silent_corruption_test(void)
 		silent_corruption_hapless(i);
 }
 
+/*
+ * Test Case 3: Recursive Call Corruption
+ * Check whether KStackWatch can handle corruption in a recursive call
+ * Write the local variable at every depth
+ * Configure /proc/kstackwatch to specify the corruption depth
+ * Verify that the watch is triggered
+ */
+static void recursive_corruption_test(int depth)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("KSW: test: recursive call at depth %d\n", depth);
+	pr_info("KSW: test: buffer 0x%px\n", buffer);
+	if (depth <= MAX_DEPTH)
+		recursive_corruption_test(depth + 1);
+
+	buffer[0] = depth;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("KSW: test: returning from depth %d\n", depth);
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -177,6 +201,11 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("KSW: test: triggering silent corruption test\n");
 			silent_corruption_test();
 			break;
+		case 3:
+			pr_info("KSW: test: triggering recursive corruption test\n");
+			/* depth start with 0 */
+			recursive_corruption_test(0);
+			break;
 		default:
 			pr_err("KSW: test: Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -198,7 +227,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
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

