Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71171339374
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715920; cv=none; b=hMU2OUlnv6BHgZRdylQUq2YI38DnhMS0J+7ni81F4ZnPIhMulNy+zajbqqk+cjDOOZ1PRcBP1P60AwD2yxqSEcx0KZfMOJcBJQTiWqwqtZBB8449wgJCkNrFt69G1l3ne4Tsa8/VlHuWoTjKFTtPKSb/sv/DQMVX2tvYJacD7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715920; c=relaxed/simple;
	bh=FRbnHj9bnq3muav99zIW0sn/lrRSQR0HOYaHHl/2QP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzEDEbI4ucYejWMK/RNz6ul510rNNrNjrwCSyc8Cbeq1+5iWWrBj9qdRdw2VsRvuK7GyUmkCd23zOXQ2IRX5/6uJoYw6nNLd4TyJSbGBZrmd6tEIMRRItl+9EwiZVmW93jxeEKcSEwAF5kNbYxxtixewwzBck9JVyLHi/og7Ld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gASVaNRP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gASVaNRP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so20285255e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784715917; x=1785320717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4brpqsgpOGYaU8Xko9TkV4N1SpH1YwC7JnF9u87bPWg=;
        b=gASVaNRPW35qlmD6H4pN/mNS5umKGsGZzlB6Ggxtt2A4ybhIN29DEj3rQ5MoPfuejH
         GjenOS9bIe7MV9qVKxiHTvbRFcJtTwvDUUeqcq9iaCmnS6gd6uWI3Ogj1M9OqSYSj79Y
         eJrF9xJWfZipVfutGLI2XkcjbV+Xon3ff1qALWatfJcJjXBfkdsZ6dqS9rSdlN51g/Kx
         7G60VB8BT125M4CvdHBq2U6qgh+ESd9arGS2Y3QFIN/GDeyfsL85ootaEzQ+xaOTeRr0
         e68vxJwZinA6EgcZI539r1q6km2L+VUINyy6yuZB/UEr2vv/hjnxUmj1X9/rfLXH2GLy
         6k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784715917; x=1785320717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4brpqsgpOGYaU8Xko9TkV4N1SpH1YwC7JnF9u87bPWg=;
        b=U8X3Ccn71+EJnXSWYeUmneeJsnIwOtedaOfXezrxHT9Aq8WuH48nT/dIPDwKTh+v9b
         NjFAP/GJoBMXCElEfDs1IN4jGa8XHTpAaPhPeIVDIVKxfAeaNlR8zPpklXEfrk7ytwY0
         HFwDOo37R2XuCmFPgJy1k6C1hlt1dtug8ssr3jOwv9iyukPnpbvbKRgFjP7b8M13uNtx
         ASN1l4FmFWAhxfVjh4GTG/iQxtnY96BiJgsyM8vGgQkgKRzQbcip5BOg+WxUlYOEGvQj
         qNzRQuigaFGz3eCBlKKzGiATSh0RasTAPGCUViVAlO1s8uHyFJmL2wFiMwVTo7/Vq3YO
         WW8w==
X-Gm-Message-State: AOJu0YzGUGmuAGGLhNC4uIf4pDlhfdw32hxfsM+b8Etk7Bsr/0qPxRKr
	TeVzAsvMFILjpgrWhPS6/xfDzbE9jNed8O86qbh8Z12TisK2t18znLcQcAXK6385lIW9Fw==
X-Gm-Gg: AR+sD1022Rt1jU+01ZazISdD9Jy5HaquIWRwU3Eofj+blG1gukao/eaWpF1KQApNi0H
	lr/tWjIwgxtsqFezrdp5CWUXyFE2AAVjMZQs3nRk24IhFnl9Sv1ciHEWL9/q7ZumnGa0eqc9WnM
	OYZcJT5fz/b5eQLS9ViKGld67OlZnSU1PEv021qzzYZkXnOg1VIT0dPoMAMOGlI50h6Cwr5J1ug
	m58B8GJTDfgFZU2UeKYPFLGY2hczAkheaBtNdwGWihhADuX9MCHvCkCeEE4luXXIHtYx+RPzdgi
	AfxzvjR8DHficQODSAwkjGWpGFEXcLoa1TgLm/xsoGpCTWLGLzBIIRmhMnFwF8jhNuixVowBEsm
	Rly21rGqBsmA2sTGezQyABR9W7gcrZV7XNangVXfoZhGp5oqKm92WImhU
X-Received: by 2002:a05:600c:3143:b0:493:e79e:da98 with SMTP id 5b1f17b1804b1-4954a413071mr265438035e9.39.1784715916551;
        Wed, 22 Jul 2026 03:25:16 -0700 (PDT)
Received: from fedora ([95.143.48.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956bc68d4esm26973475e9.0.2026.07.22.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:25:15 -0700 (PDT)
From: Alessio Podda <aleph.pi.gh@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Shimin Guo <shimin.guo@skydio.com>,
	Alessio Podda <aleph.pi.gh@gmail.com>
Subject: [PATCH] perf unwind-libdw: Fix unwinding of multi-threaded processes
Date: Wed, 22 Jul 2026 12:24:07 +0200
Message-ID: <20260722102407.3755154-1-aleph.pi.gh@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libdw callback API has two levels: dwfl_getthread_frames() first finds
the requested thread using the next_thread() or get_thread() callback and
then walks its stack.

Since perf only has a snapshot of the stack of a single thread, it
provides a stubbed-out API that always returns the pid the Dwfl was
attached with (i.e. whatever was passed to dwfl_attach_state()), rather
than the actual sampled thread's TID.

Commit 6b2658b3f36a ("perf unwind-libdw: Don't discard loaded ELF/DWARF
after every unwind") changed libdw unwinding from recreating the Dwfl
object for each sample to caching it in struct maps, which is shared by
every thread in the process. It left next_thread() unchanged.

Since the pid passed to dwfl_attach_state() is only set at creation, only
the thread of the first sample is ever found. As a result,
dwfl_getthread_frames() fails with ESRCH when asked to unwind a sample
from another thread.

Make next_thread() return the current sample's TID, provide get_thread()
so libdw can find it directly, and pass the process PID expected by
dwfl_attach_state(). This allows libdw to unwind samples from every thread
in a multi-threaded process.

Fixes: 6b2658b3f36a ("perf unwind-libdw: Don't discard loaded ELF/DWARF after every unwind")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Alessio Podda <aleph.pi.gh@gmail.com>
---

A standalone reproducer is available at:

  https://github.com/kryggird/perf-bug-repro/tree/019c8ae97f9e4370ef2265d7badc3269e2a5044f

Run it with the perf binary being tested:

  ./reproduce.sh /path/to/perf

Results:

  perf 7.1.3-201.fc44.x86_64:
  1517 of 1522 samples have no userspace callchain

  patched perf 7.2.rc4.g1590cf032971:
  15 of 1449 samples have no userspace callchain

 tools/perf/util/unwind-libdw.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 7f35042be567..3735ef83c8c4 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -173,14 +173,30 @@ static int entry(u64 ip, struct unwind_info *ui)
 	return 0;
 }
 
-static pid_t next_thread(Dwfl *dwfl, void *arg, void **thread_argp)
+static pid_t next_thread(Dwfl *dwfl __maybe_unused, void *arg, void **thread_argp)
 {
+	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
+
 	/* We want only single thread to be processed. */
 	if (*thread_argp != NULL)
 		return 0;
 
+	assert(dwfl_ui_ti->ui != NULL);
 	*thread_argp = arg;
-	return dwfl_pid(dwfl);
+	return thread__tid(dwfl_ui_ti->ui->thread);
+}
+
+static bool get_thread(Dwfl *dwfl __maybe_unused, pid_t tid, void *arg,
+		       void **thread_argp)
+{
+	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
+
+	assert(dwfl_ui_ti->ui != NULL);
+	if (tid != thread__tid(dwfl_ui_ti->ui->thread))
+		return false;
+
+	*thread_argp = arg;
+	return true;
 }
 
 static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
@@ -306,6 +322,7 @@ static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
 
 static const Dwfl_Thread_Callbacks callbacks = {
 	.next_thread           = next_thread,
+	.get_thread            = get_thread,
 	.memory_read           = memory_read,
 	.set_initial_registers = libdw_set_initial_registers,
 };
@@ -400,7 +417,7 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (err)
 		goto out;
 
-	dwfl_attach_state(dwfl, /*elf=*/NULL, thread__tid(thread), &callbacks,
+	dwfl_attach_state(dwfl, /*elf=*/NULL, thread__pid(thread), &callbacks,
 			  /* Dwfl thread function argument*/dwfl_ui_ti);
 	// Ignore thread already attached error.
 

base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
-- 
2.55.0
