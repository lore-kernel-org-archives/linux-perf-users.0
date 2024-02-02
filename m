Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5C18B09
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854572; cv=none; b=iwGYQkNOZWNPs9czvKNaJS+ll69xhjh9QV5lN4J3OoO8sn8QR49Zmk08T5LQHoB+H9b2Julg1IsMivtAv7Af+OIhfJe2WCAS39foIfyrbFU4+yyjR3202NNdhJ7WtjDxjXHgaFlVeMxrW157JXe4ffut9eK2xhnipeqH01QdlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854572; c=relaxed/simple;
	bh=ar+h6lW4xcIxzdvZbvzL64J6bTCD6UFYPdk5Pkaa3hQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fxaraq4yldVvNKEZqVuAsQNebbtG1z7+9OFt27SEMrTqBQ0wuTmYcDASwjzrPiPc6CY9+i6zHdgZYpJhYgzbvMhc2UJTMIqBRNxP5VaCeb/Rekfq83JrK6moU4jNTrF0dD4R/hZt0H6vs45OAyX1TlPo8/1tTNewks/F9zRNg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Je2mC/DA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Je2mC/DA"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so2713440276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 22:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854569; x=1707459369; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6mw7Xtg2kK14DjlLq7BifI7GtEprdY4uQDlUS0jAeg=;
        b=Je2mC/DAC2JRCwzcJ0s2U7AOMAmBnasb8Q9UaAHRZYVygUsjlY4K1qjORCYDwuZYvD
         +H1Z4IP9up/JYHyF6gbEpI9nB3cSCljk6baIlOyjBdwBWqeYHxiCnDul7Wz/jPRbJxUH
         A+norGsWQ2abTjukx1Fv5UbzYro0fvODMt6x7xcm4K/QHmyTLVMyVZ7cVq/4IQV08SZ0
         2Jz0PKhUSeMS+S4XpCLDGi8LE/Xx4BLf8iGg9a9jousQuIWNZVWALSXrl5dU7eXOHPV4
         pIfSB8fA8CGKwHLyOSru8Nzy9qG6wMSUzj6frKi3roaz0jMULape9c1T0LRKuWZwtPDZ
         lWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854569; x=1707459369;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6mw7Xtg2kK14DjlLq7BifI7GtEprdY4uQDlUS0jAeg=;
        b=ZHlso8eOpUxlTvfzt0+NC/2ovr+MtD31VjmV+7Zv7kW+cdAKThtvuN9NI29RSi/mkh
         BSsUGNB4oPFq2LhPcxzV34ZE22P12hrziVF3+zu9lAH8Ni5TKpS7pJg3PfIVhUb7G1c8
         oylHNntXsHLQVYLp+XNRwOfMMD9nftLXQKsusoGMvzRu+A1UBNebbLBTvulL1jUPub3Q
         AHPLVMM5SFg6oqsoAgTanEBKncwdvKymVbSePaUssnqfffuGED+V1KOkesrccNAI+PG9
         4tqVPwibH3fysmz1BhUcmtOUrIT6H7Li9uWK9sUCYQPT2LPIKugfV7+zIlw2IrF6nwf3
         fZPA==
X-Gm-Message-State: AOJu0Yx83vkggIWxSYrONJxnvozU75sHqiRxFCUmmddnsc+OG+KDRiwH
	KR5JLaeJQicOfH1J1AfYy+lYVrETN2TC38hHzB5SPpmZDSCEy83ZjQF35W2bGn4FLe7FCBPccSt
	/i/+IvQ==
X-Google-Smtp-Source: AGHT+IEw/Ym4EmlZFNH/BuM+k/izcqPlKcBFteZgBYzUyt5PfaotXjis6um1xqkabsZGibi3BcC8S+z7xnHi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:6902:2186:b0:dc2:466a:23c4 with SMTP
 id dl6-20020a056902218600b00dc2466a23c4mr375837ybb.4.1706854569681; Thu, 01
 Feb 2024 22:16:09 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:17 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 10/25] perf machine: Move fprintf to for_each loop and a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
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
2.43.0.594.gd9cf4e227d-goog

