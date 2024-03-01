Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732152F9B
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271420; cv=none; b=JMhd9cXEnL2uT06ZfcMtB/kNhSYHvm8bJ5RA0Zbesfc/4kwoHcFH9fNBf1WXyQLvHVFLIxGrKI3vWHbrkvgivLfFL7J5Dt+sxcnrbmWUc9IEKAXoLwfzRgI09dcAStCFu6rH+tk5wdNVcCreaeOy+giDJnaQGOXSgNk6i2zWcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271420; c=relaxed/simple;
	bh=BBmU04u6tU5hlUeOKBhv7F/E4iRu0Xd0+OelCnDu9d4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Q6CDZGPCobSCGPClnsWL3cfotBxifgp3HzszehT1GzLEcr3IWP9+MjWNzOknFx76O4iTVf74+TVaNNsGDL0H50g+sEjFCCJMaksIIZwcn758XF2rUig6SLD6ScneNtb6Nb0VUhqRXWnEG7W5nBcd7Nyf8L3wQwUZ4FowbUR/Oc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ro/PVEIb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ro/PVEIb"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so3571473276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 21:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271418; x=1709876218; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRPVI6egL+2XI2pKzd6EAQy7fDTiYP04TRmL/KfQbAc=;
        b=ro/PVEIbA41Q4SdR4B2QPlPKNtMHCyuFGJUvsvuk/AtEFRo+N5U4X9+p246GpEtZFS
         oTardnH8fIDYNTWFC/+L/HxZ/67Zgh4sNVLkl0w8PiPltPr2H/Ithsi411awv1BTsyjs
         9uCLZN6j0VOemEVMEGV3H8r9YD+tUCx0TdOgblvCNpX9eeMHtJSfHgIJwbll876fnKmZ
         a9JdMWVIby1jPAo0k7fuD5ID25qi1xp0E7vflnjVZV+wqUp7vfYF3VzCDJz32u720K3D
         wkW0uwob92PUw9+3uKARnAUpyqCGH9fsRICo/Xz9PVIMdNmsRC7DlQL2h+qld4EQh9Rv
         5GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271418; x=1709876218;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRPVI6egL+2XI2pKzd6EAQy7fDTiYP04TRmL/KfQbAc=;
        b=JfoVaxdG9cgnf174M99GaFatIlhzC9gtr2JsGKRCZZDKCJLN/wo05ZVLoDqW2Xgn54
         3cVRiHAyUSwhEpRI4yX6z5IWdmXgiF4sAECb2DgtJZORKYo9PmloTlfNf5p6SrLcPkHE
         v17eMxmEWGXb8gt/oR38Xw48NVKyRpyJU673fw+mGKmJVYCJpK1bdDAvial+faY5MQrT
         skEc10M27F7LgqSpCqwRnncg9l5kQzJfIAucM7fkL73h/6VxXDcPeojwvJ6DPN1EHldF
         zs/luW6nCfYFfyTy45fKjvJsrQpizeWH+8yCUXEsBpoDqdbeFaytI64Edg4T1xU7CnTO
         DnWA==
X-Forwarded-Encrypted: i=1; AJvYcCXhYfyQYkCiQt0finH0vgCR9Q6W2UtA/zMLUYGbWp353nKaB1ApvLyDDVFePQUhns/lrfNTdW+UcHm1jkflOmGUva3InCq2DAKMyW18jZTSzg==
X-Gm-Message-State: AOJu0YzGSFENUS1oj4BVkCte7DzDpPJ0g8cba7MN7iu6zgi98xhctAB8
	xzn48/0ntxDC8eHVIcSDVANg0LYHK83r+NQ7xERqUU3/qvykJmvzfOhmoHOUkgnqvypOzksytrr
	clYj08Q==
X-Google-Smtp-Source: AGHT+IGRLMrQFbbox60wk3jGuHwsiDSFz/GgzyTXEcf4rK5AC6vMv1Mi7Tmq1hBxxVIampmyF3fsHTa+P71N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:b292:0:b0:dc7:5925:92d2 with SMTP id
 k18-20020a25b292000000b00dc7592592d2mr757438ybj.1.1709271418281; Thu, 29 Feb
 2024 21:36:58 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:41 -0800
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
Message-Id: <20240301053646.1449657-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 3/7] perf machine: Move fprintf to for_each loop and a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid exposing the threads data structure by switching to the callback
machine__for_each_thread approach. machine__fprintf is only used in
tests and verbose >3 output so don't turn to list and sort. Add
machine__threads_nr to be refactored later.

Note, all existing *_fprintf routines ignore fprintf errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7872ce92c9fc..e072b2115b64 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1113,29 +1113,40 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 	return printed;
 }
 
-size_t machine__fprintf(struct machine *machine, FILE *fp)
+struct machine_fprintf_cb_args {
+	FILE *fp;
+	size_t printed;
+};
+
+static int machine_fprintf_cb(struct thread *thread, void *data)
 {
-	struct rb_node *nd;
-	size_t ret;
-	int i;
+	struct machine_fprintf_cb_args *args = data;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
+	/* TODO: handle fprintf errors. */
+	args->printed += thread__fprintf(thread, args->fp);
+	return 0;
+}
 
-		down_read(&threads->lock);
+static size_t machine__threads_nr(const struct machine *machine)
+{
+	size_t nr = 0;
 
-		ret = fprintf(fp, "Threads: %u\n", threads->nr);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++)
+		nr += machine->threads[i].nr;
 
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
-			struct thread *pos = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
+	return nr;
+}
 
-			ret += thread__fprintf(pos, fp);
-		}
+size_t machine__fprintf(struct machine *machine, FILE *fp)
+{
+	struct machine_fprintf_cb_args args = {
+		.fp = fp,
+		.printed = 0,
+	};
+	size_t ret = fprintf(fp, "Threads: %zu\n", machine__threads_nr(machine));
 
-		up_read(&threads->lock);
-	}
-	return ret;
+	machine__for_each_thread(machine, machine_fprintf_cb, &args);
+	return ret + args.printed;
 }
 
 static struct dso *machine__get_kernel(struct machine *machine)
-- 
2.44.0.278.ge034bb2e1d-goog

