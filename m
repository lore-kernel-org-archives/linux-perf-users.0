Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBD1DF97C;
	Thu,  4 Sep 2025 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945419; cv=none; b=fJvvrf6mDp2M0g2yS+ff1bektCUuYzJVJUb8bmCdTBtqrJSbDEA7tTFMuMBFPmg+iKHjGONEGlQDip4GqvdLkkSusqCrQY1K064HCWsqkQFw3F1mFwvhYbF3Z0QuWTzUVGlh8jzGP2vvr24tVSQx6ycAQxJzKJYncqxuwiiXyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945419; c=relaxed/simple;
	bh=+F7WhvUuFEr17da3jUnHwsnHX9itQiAKBlhr+pK9kw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFH9CIQ/5ngNZipj2kZaZpsbEygW+izG6ltVf9U5ahXXfdNmKh/IPj4vLFuXC3tf4KlDroJQKaEHQoqbMK5eH75Y6X8wjJrtDXjsRxx6fJw/h1+1eMVWHRPpScWQ2/fjL2SQlu2Fq3P+33FL2rvcmetrN3aN8wJGAWQ2kngp4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu7q3r+D; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu7q3r+D"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-772481b2329so570610b3a.2;
        Wed, 03 Sep 2025 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945417; x=1757550217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zy5btr4Cxic2TrxrfGpIdem3AHKjFkBdPXJVoZYatJg=;
        b=Xu7q3r+DqDFVtblArzSJqPGrtFPdF6DHiwEIPRUOCyzxl9BhC0R8UXgkefjULD/67k
         35kRGeotBg4xdoF4iSohvpLpgGfwMrNGaq3ILQeQWdWCPnyYK0BhV8HAftTgGfx+oENs
         OKzXg8X5tencd2/O2VVC7YlgpHOXhZ8gNDcIJaIBPR8kh1xaWHl2rU0vt3C0ufJ32xT9
         kEMzgkzBFefC2XX5ZHt3Wl7yqzaOILBhExsYokyaRD/kATHjMhI7E3azJKpa2DJnmczq
         2pGu++9wJT/+gKJNFk3ezZxGCfm6znYg9H+EuEVIemSz395dSCgH+14W9WCRzg6mcEEh
         D6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945417; x=1757550217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zy5btr4Cxic2TrxrfGpIdem3AHKjFkBdPXJVoZYatJg=;
        b=XnKyPKprSib2hlPq7LnBbsxs7h2by7U3ODKe8WkxmXTKTq3tPGb6Z0Mh4DfntvyXZg
         SF6yrGS8RR1MDsU9OpxXdhTbRiy+FHFUlKHIeJSsMNGlnrNrvEaHwXUnmUpAOpLcO2/Y
         xBLSEtvFZHO0KXXr6jFzPExELxbO2bYLe/9hOCPF4wZBHWvlitcIBlCfPXFP0fqVs1AK
         v5KjerW6a+B5i4v2BXvsKT4J9lJB+E41cF9W9SSCZcasONeXo4n/sHQ8ZZU6/6W6u3gP
         XuR1spKir5iz5IImSb4lJwau0QI4BouwxpIUIns/51rMJ++8K8/Bok1MFr6kBLaM6mn0
         Yt4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEJilMzta/GxPaTmpgwM4ijkw2GtaTAP+Zb+vfWh+NSSBjeEDfWcXKTdxKMKHeOIXjT21XFqrWpzbxBYWMYJcZ/3yA@vger.kernel.org, AJvYcCWdtk/JVY3I3VmSSr2YymILTGRb+GkpIyl/9QeUkAGNP+1mfGjmEYXB1XhAFIXypuSYnu/9IGKCknJ+YMuqxptd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hgZtlneLKN61j2+XD0CrVVu9Thpl3fH4cXZWKHkeFlvZ3DK6
	MbRl/02qU3zDorqZaTqj/IcAseXkQ45uerS1K43kfJAi0SI66Meg9lY9
X-Gm-Gg: ASbGncvm9Kzfgx0S3ZtwJs13FwqByle7ylzvZDqv13x5CQ6cq5xbWfhu0Bilrp2HAd1
	tVK1WSZQkbQra2399mL0B1SK8qcSVqo0KSQWLctOBJYeusVDxB+dqFc0qrYk6fToi4mJxLvw+NE
	EWVaVSZRQeSlly7wEx3bDA/l2z6nS7cAGe79Hqvd+n8X07SwLN4r0kXtT4zWu+C0aUFofxwELu9
	y59v+gUmNXf7Wi7v4Tt2i5Jdob+qqp+vOYIQpP80MqLWIPlNLmjWBKfqtxA/8MjLyq1vy64ngWt
	n+YDU2deC12xOkoDPvsKw8/ckNduV3Xm4c+oG5u9uT44LRbZL25tjhKtUC+CZrBH6N+VBmO47nR
	xX2ls0HhSEATEXvANYoZOD5gBfLtbzRMszju90XHzcQQrVxEOPeiRTq7m2BOVpmg=
X-Google-Smtp-Source: AGHT+IFj/QUfdNr54DaXrxUfOwjpV2lFcaLFWb1JY2iCOe+1SSplj0UymNXEqzVyRY1fytwFbBj4MQ==
X-Received: by 2002:a05:6a20:6a22:b0:243:7617:7fbb with SMTP id adf61e73a8af0-243d6f3941fmr24535766637.43.1756945416828;
        Wed, 03 Sep 2025 17:23:36 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:23:36 -0700 (PDT)
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
Subject: [PATCH v2 12/18] mm/ksw: add self-debug functions for kstackwatch watch
Date: Thu,  4 Sep 2025 08:21:09 +0800
Message-ID: <20250904002126.1514566-13-wangjinchao600@gmail.com>
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

Introduce ksw_watch_show() and ksw_watch_fire() for runtime debugging of
kstackwatch's watch mechanism:

 - ksw_watch_show(): prints the currently armed watch address and length
 - ksw_watch_fire(): forcibly triggers the watch by writing to the watched
   address

These functions help validate the dynamic watch behavior and facilitate
testing without requiring real events.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 ++
 mm/kstackwatch/watch.c       | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index bc8664af4fa6..d1bb5ae75aae 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -47,5 +47,7 @@ int ksw_watch_init(struct ksw_config *config);
 void ksw_watch_exit(void);
 int ksw_watch_on(u64 watch_addr, u64 watch_len);
 void ksw_watch_off(void);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index c563f8d17829..8f3f6cb9f17a 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -116,7 +116,6 @@ int ksw_watch_on(u64 watch_addr, u64 watch_len)
 			ksw_watch_on_local_cpu(&watch_info);
 		} else {
 			call_single_data_t *csd = &per_cpu(watch_csd, cpu);
-
 			smp_call_function_single_async(cpu, csd);
 		}
 	}
@@ -158,3 +157,19 @@ void ksw_watch_exit(void)
 
 	pr_info("KSW: watch exited\n");
 }
+
+/* self debug function */
+void ksw_watch_show(void)
+{
+	pr_info("KSW: watch target bp_addr: 0x%llx len:%llu\n",
+		watch_info.addr, watch_info.len);
+}
+
+/* self debug function */
+void ksw_watch_fire(void)
+{
+	char *ptr = (char *)watch_info.addr;
+
+	pr_warn("KSW: watch triggered immediately\n");
+	*ptr = 0x42; // This should trigger immediately
+}
-- 
2.43.0

