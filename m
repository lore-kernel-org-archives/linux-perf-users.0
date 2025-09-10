Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA423ED5E;
	Wed, 10 Sep 2025 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482376; cv=none; b=C/sFEVJbuOxT6weWJLXPG+CH1eXMV8uzukdz6GxkG6nikyUNZL4Z9mvkDuPrULCdF8+Qr+wjNr3+4G0+AqSUn6Tq44yLWlNmnUSXXC4marNSUyPHJX8pw1O29Qmo0XG79U95pF+p5UfYzTU1HaUHiamK7uZGfCbIwx1lHZJj0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482376; c=relaxed/simple;
	bh=iwHG2r//u2zrEftaW61NPOriQPMlQ8VkZ4RRC9BUVEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buKYh2K4gOAqJ8IHFgR0HC3zdBqaH+gFoGegxdZqISGnT04SOS3RwBtn/jFc/O9iYfsBFnevK2CI4qMmmBfnSGg1oFtjY33L1RtVcvZn36jXRiJ8hNscX+hi2U3Ysj1dWJ54mFOlc8eTDxvdoOre6433yhEnxavXyWKNwBWi1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN2AiTas; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN2AiTas"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso5531753a12.2;
        Tue, 09 Sep 2025 22:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482374; x=1758087174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrAud60iSU3AEw7FPtcpLe0K/xeVWiZU0ZsMgXrQnOs=;
        b=mN2AiTashzG4N8YVQsq1ZFcVJR824jwI2RaGvdTkl0m9LfGBD5JSsv3f8Oh0orGBFO
         VQDrNSFzxelccfjaX+EeEdFHZDuNzTb7HbJDr0sX9NtGjJtvfI61fKxhxUCdzdd6qQ/w
         2Vt9evnbnie6T1tIsyicKiv2k98R08XLr9WJ3QVgfryFXsZcZv2uqVIus+oF+sTfWo0H
         UZa8Yl/QLiKOh8l+Y+YspAtXtP7L1MPMXi+4uh3ntyup1rgqty5oWGpQHWzWe01q5J/u
         bsyUmNNIjOUYxvZPMoVa6V+gDx0ojA9KE658eaVJjjgy1/dURQJJi3vPLJY1DMkM6Mok
         rKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482374; x=1758087174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrAud60iSU3AEw7FPtcpLe0K/xeVWiZU0ZsMgXrQnOs=;
        b=ksQGTkLJ/qSDZ8jjMczPeKKLGhcaTbOZRz9km9bdpJVbf8N9S4VnY5L2id3/uXzJlO
         Ggr2idPDw0mJGe/fex3giuurGdD8SG3S8FvLSNF4tzgv9CBN11epgMYcpkOVYrKRnLwZ
         +vM7eqdumf25F9iIfy3PYGu3X8NFzYq0PgywcMRSlBHNakXEQXEoFx7/Qk+ezF0gwWUy
         buQ1QUVxxmhiHE9n0pEhYlNhTqsjekJ2cJn9Gz4QULHelQBkkj+zvkxlUXSVEW7W+RqY
         v4P76DMyOdvb28dYDCmvFysU4woGFyqEJQgXcgvUpi5ZoGbriH4rQJbzgjsYLMZIn5nF
         eLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCGXVI6/aTqnrieiHpaf4AHW6ov2PG4AFso0ULp4w5xZBc7K52VgEZl+GMLB9yhdaJGISgE6MN+gUOrUAUpSz0@vger.kernel.org, AJvYcCW/dO+pFWVXgoNiO+1EIxDnFgAmQVO+svKgDH/khmCDu9CLiUw9DgG7GXlYpTSbTwdvybtspZK/DdTWVeb76csGrWL1@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBgSJ7RIpbRaC+Zy7F/dl3Pm9xYUtd/hJYFeTeHzqh34jwRm0
	WW6ApYZoi9lKGDKX/7TeahZBneXFD4y8QC5v1lkfhPJdySA3U/+EMdyd
X-Gm-Gg: ASbGncvb+cR6BzKlzos3Aj+JdDFi41Jn1kkhy4DCgSuz3DN6EuZ8Vs9wd/lla1p7R/c
	gN5jhcv1RTtY43HVYuicGI/qrmKvSBXuiLhLW6OCrC6YQPq1goUTA+NnF+ZwHOQMQmSf9x9crm1
	NzYF+lUndSlAKkAmLQgVucG38gKedYV3q4U9EE8pNkCj6g8Z+C1kfxJo97pQ2ZH5ZwXhEcN8vaO
	07qMXK1fXbJ/h2zr8lmQbB94ukamBqZ2Q5kukyAhl9o4If5nRvIWBHghe2/gYOmJpnBywmTJhS5
	pXgfRRbBwGs0XFe4c9WG2jc+0JauWUlR3TC/Hsrv1bxznooDhk3ycLmGl9odlD4b40taH1QlMN4
	uk6F1jWUiedKwFb9shxVkXq7YzyW9FHVFOr1DVCnG/PXI/OHKhQ==
X-Google-Smtp-Source: AGHT+IFvtyjzKqjD1jevQiJ1bC/syfF7SnR7xc0dVXuUXiVKJ5VEJ/pwIGVUhV4HcoGZrtlei49omA==
X-Received: by 2002:a05:6a21:32a4:b0:252:2bfe:b668 with SMTP id adf61e73a8af0-2533e572dc2mr21000740637.4.1757482374278;
        Tue, 09 Sep 2025 22:32:54 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:32:53 -0700 (PDT)
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
Subject: [PATCH v3 13/19] mm/ksw: add self-debug helpers
Date: Wed, 10 Sep 2025 13:31:11 +0800
Message-ID: <20250910053147.1152253-5-wangjinchao600@gmail.com>
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

Provide two debug helpers:

- ksw_watch_show(): print the current watch target address and length.
- ksw_watch_fire(): intentionally trigger the watchpoint immediately
  by writing to the watched address, useful for testing HWBP behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 ++
 mm/kstackwatch/watch.c       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 79ca40e69268..8632b43b6a33 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -47,5 +47,7 @@ int ksw_watch_init(void);
 void ksw_watch_exit(void);
 int ksw_watch_on(u64 watch_addr, u64 watch_len);
 void ksw_watch_off(void);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index d95efefdffe9..87bbe54bb5d3 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -185,3 +185,21 @@ void ksw_watch_exit(void)
 	unregister_wide_hw_breakpoint(watch_events);
 	watch_events = NULL;
 }
+
+/* self debug function */
+void ksw_watch_show(void)
+{
+	pr_info("watch target bp_addr: 0x%llx len:%llu\n", watch_attr.bp_addr,
+		watch_attr.bp_len);
+}
+EXPORT_SYMBOL_GPL(ksw_watch_show);
+
+/* self debug function */
+void ksw_watch_fire(void)
+{
+	char *ptr = (char *)watch_attr.bp_addr;
+
+	pr_warn("watch triggered immediately\n");
+	*ptr = 0x42; // This should trigger immediately for any bp_len
+}
+EXPORT_SYMBOL_GPL(ksw_watch_fire);
-- 
2.43.0

