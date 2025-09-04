Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49D23ABB3;
	Thu,  4 Sep 2025 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945436; cv=none; b=sjGuM1oQQZQFgQPf0r0KcqednZOWh8SsRDwSKCfHpVDrvV4/SvdDDi7ivo0rjF0B+Y9hqcgaoZOMpkPTibR+D3SjcH1GR6S6+D2Fqp6LzvUdViF+KatH1/EUPeGtT2TKALCRLjcmCH4Py/KIOr/UGuctrMXUvrPexzchXWqo7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945436; c=relaxed/simple;
	bh=6rw+m4VKvEY+PNH3LtpXPUlmxSfDZ834B7ADRGFPwkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKiGNcWq82kcOlUvMlGgdizDjIMRgCiRoo/EgRgev6OCwhRA749A4bbhbU/vtmfCYrMM+g0OHjjKJFpPcEMWaSUPEs0grSh+FMHKSP07hiQGsHmkfVrJrVTvawVXx0/kIEfcXZLv/I0zbpClNuYp61ODQ6Y5pfu0ftOSm36bvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNddLgAM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNddLgAM"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-772301f8ae2so429143b3a.0;
        Wed, 03 Sep 2025 17:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945434; x=1757550234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or2e3wHrlUvOPFgjfY3GC0NcILvcAZ+AmyV41U5R5a8=;
        b=jNddLgAMkQZecu8JgrjseupFX3pyoNTJYWsuwLSa+LXSbOPuXKbg1ODRDuVgEsS0iW
         vepmWL7rJpWFOsT7Y2Tl6RcuCQX30Kc9O5QiahAMeKmbYQoFd1bhOjelwegSO4hD86M3
         +nz1oo/q/uFZm9RtOCg34Jrz+Zyi7qg0yc8BpBszuKcIJAKnieLEQP2pp1KrnyLkBxmt
         O+hBuqKLLlQL7EpErsh/k/YOADh7apn/3FQ6F8lUxPItfx+x0EmuiPw9pwWCkiSFJjkC
         Nnyc9ATBEFeWf+0xmou4FXbA90BxeXo9ehBecEGrTBHuvxJuIS69vyADqpQLt5GJUW9O
         wFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945434; x=1757550234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or2e3wHrlUvOPFgjfY3GC0NcILvcAZ+AmyV41U5R5a8=;
        b=IzlQIWNs56SmVGmsCrmkIkOnwt4MCXWPV1xWCCZEI+Ye8jZUjeCTgvLF7LBPb036f/
         UzufvYbtQ195DQLjn9u6v1yUD5Jb5muPxztl51p8zxt+8tAVazN8KRnwMMpBK0UrVue+
         0Nhj0YLJeA8cEa1MT0sniUqRK+neJ4QEGFbg8hfO67CYsY58AFh56K9uExjgOeIAXmaR
         hnCkVqShpA/a1AReWPT4uqMBPoGGZWwgeKzT0eyEL/a3URxTQ6rdBswGp6SZjQuXo/ts
         P1WlscLuf1429il/SF1ObFySSXI4qjNrAtiWkPh8GItjF09SRJYcSUKFhOQvMojM+Eqj
         URVw==
X-Forwarded-Encrypted: i=1; AJvYcCVEkUzfl6096x9M+6b6fCUlYfz/d6wdFstaAOmBdUaYXWPk9qNsY4bZgtcGJUpFeN0wj0rTwgjcrlW5+gZ6/k1b@vger.kernel.org, AJvYcCWBvqGLJBR28W3wIcaplYq1SW+Fg/vSVWUuI8KVIzkGysTDqvhTEoZN47Upvq0Sym3bPprgsjJQR28/3CNZGDEtu37C@vger.kernel.org
X-Gm-Message-State: AOJu0YzayQEVf8PWcnRKxyg/YkuCzMzkENDExjrTWGTDyWdn+WeEWI+6
	lhuGohpdHvR00g+KwBPM1ZUnn8NHHXV2iKCc84NQccPnwdAyzWX4nuDi
X-Gm-Gg: ASbGncuRfz83GOMGzc1poTmDXZw8dExztZ83DqCch/3F9SraWIkEpyQOag1DLd7zNiA
	101ptLJO3CSrvz1GM+62dnmj8XAt3UGiQc6NnwKxfWL2H1o9fnyc6FiAoXMPrQSOVphfxJJU4mI
	pGF2Ru3/M3twM0oIMAZw/NaskZNFqB+68m/GeFZOLKLifYYJwrQGuLN5bOIPyTzEMdAwovYTMm4
	c1L1jle4OeUhvwIZMPSs3cO3ckZRkjUboUog0tt9B/xURZFgm1z/L2Vmf+GGf/fMv+sd+8Um07h
	SEE19curPsihH7JZG5hry7HvduYhUe0WVREGvc5MX/W/DdvVbXPLZi0uU2MfQ+eA4WKiZ2tCbRq
	XQx1M2PvDeHh2/oP8dyEosToA/Xh+Ig5K1v1RjoW2sQ8kN5qGKmXhtC6DSN9raE0=
X-Google-Smtp-Source: AGHT+IEFRgUm8G3fOt9Njei098V+G0dLsLeU/egZbWUWIOvW90ec1jG3Rb7Noxb0HUZlTjRFfu3Imw==
X-Received: by 2002:a05:6a00:1399:b0:771:e2f7:5a12 with SMTP id d2e1a72fcca58-7723e1f0883mr21918504b3a.6.1756945434094;
        Wed, 03 Sep 2025 17:23:54 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:23:53 -0700 (PDT)
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
Subject: [PATCH v2 14/18] mm/ksw: add stack overflow test
Date: Thu,  4 Sep 2025 08:21:11 +0800
Message-ID: <20250904002126.1514566-15-wangjinchao600@gmail.com>
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

Extend the test module with a new test case (test1) that intentionally
overflows a local u64 buffer to corrupt the stack canary.  This helps
validate KStackWatch's detection of stack corruption under overflow
conditions.

The proc interface is updated to document the new test:

 - test1: stack canary overflow test

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch_test.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/mm/kstackwatch/kstackwatch_test.c b/mm/kstackwatch/kstackwatch_test.c
index bba2ab8530ed..138163472b03 100644
--- a/mm/kstackwatch/kstackwatch_test.c
+++ b/mm/kstackwatch/kstackwatch_test.c
@@ -42,6 +42,27 @@ static void canary_test_write(void)
 	pr_info("KSW: test: canary write test completed\n");
 }
 
+/*
+ * Test Case 1: Stack Overflow (Canary Test)
+ * This function uses a u64 buffer 64-bit write
+ * to corrupt the stack canary with a single operation
+ */
+static void canary_test_overflow(void)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("KSW: test: starting %s with u64 write\n", __func__);
+	pr_info("KSW: test: buffer 0x%px\n", buffer);
+
+	/* intentionally overflow the u64 buffer. */
+	buffer[BUFFER_SIZE] = 0xdeadbeefdeadbeef;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("KSW: test: canary overflow test completed\n");
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -65,7 +86,10 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("KSW: test: triggering canary write test\n");
 			canary_test_write();
 			break;
-
+		case 1:
+			pr_info("KSW: test: triggering canary overflow test\n");
+			canary_test_overflow();
+			break;
 		default:
 			pr_err("KSW: test: Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -85,7 +109,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"KStackWatch Simplified Test Module\n"
 		"==================================\n"
 		"Usage:\n"
-		"  echo 'test0' > /proc/kstackwatch_test  - canary write test\n";
+		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
+		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

