Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF8A1F1911
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855708; cv=none; b=HzMTrrYhwRum1vG7+ze9cbb2dPH7bmDLHcIKzVvSZwEYmINsqk6hdaLty7sppJXbKD6Xo7ckQlHp9QMA+cbWxjesMJ8cORjlcx+ICD6p7s4T64B+JMlUsVz9U+v6Gf3I2KQeHghVPPb6hcTwZfesRDsCj2+Eh8T4hifOi8/MnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855708; c=relaxed/simple;
	bh=ie26b2RyksuReoq3CaWAWU5urfeVKfBweu+iRLyCrp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z732OLLZAKjgNLhkHIHVQNfAPnjmcFB8PJ0eR19wzjYMiCHb6Tudq0WorxNUgaHGEDV0TyP4+m/dPI6AMXsf8tX9kWMj0W+u3st2HaVjqn5qYWcBFhTPFdvuGWtPEk2DwlRYdCIBILh/teChGPdzhEaZew49KQCtp63IBctDg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=goyuoU6/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goyuoU6/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22647ff3cf5so69297255ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855707; x=1743460507; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UQH7oGCzJ0WNTA83Vjhjs3RZyEx+gk9Fkp49zJCF0U=;
        b=goyuoU6/LuDHXoHYtsRTTajw4+JsrWyok+bL8EOgV166PakhdydURwGgyZ+6qUDs77
         GTY5Otdl2ep24wmcq1bKofEEo5WSalAu6uCEyirqUAYKdFep/vYH0ThGWBAHCl1WGl3W
         /9Z6f8pN5CrJJrK74zsiFfZmkzdX3GuPOMoUkQdOXtxXxIo7N64TOFml5Q25eNJn97zv
         G69t/Tocix7Tw4g6IUAs1YebeEzaFHvENKpfyQ0PJob07JjJz9CY/XVdulsCFU9friV5
         1+Qe+uxP8HHqUqG/RPnX0/18lwPFofxuXyHmRulhrc3mEbCwbOTWDTVPgOE1jQ0bWlVi
         ZIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855707; x=1743460507;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UQH7oGCzJ0WNTA83Vjhjs3RZyEx+gk9Fkp49zJCF0U=;
        b=XKIgCYZKQheBp6a24eBMftoTtMEbMWkGLR/5pFrOL1+BSQNViaAnHRCQRj2yC1nyQ4
         RWau1Ujp8ZvO0zS29Y4LEKs6axcI+ExsFJx04DKHJBAUL0DXH06skHYyhVuLdgrY60Ls
         1Ke8sgh2r+Y1dyZ1TPFiPP1x191pUgAyA6V4njLrV+oxDR4thwl5i9189BBz2sMvLSLu
         w0MjI8hZxqSMXflLEzNW3WU3EpOi9vs6tO1njEyc9lGO4ZEo93HM/Sb0TLFtP+FhxjSe
         K2bCU0nJgc0WJ6LPnS6JWUSQa0UBf9E6oGq4zr30HT5jebf2apzbaqDtX56QkUN6YB9a
         lYOA==
X-Forwarded-Encrypted: i=1; AJvYcCUNfNpr8XULq6x9uPye/zNzxtONKiX+LatvtwIUKlVhr+S8cOr3CfPUu4t8WPLLwYrFZPktW4sNGmeA+CQszOTa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz686BHSpZsu6H+RbHeRyMzz+0Ie0cekiWnZu+EZU4WG3qbKw7M
	sgEe2HSLnelo5T5DoOKaxiOmoKFEVr+jciuyJJOujGTkpHSkgtkLzx4sZAgCv/JpVITWQPOtRHn
	vbEzjMA==
X-Google-Smtp-Source: AGHT+IGFLKGJaI5bECm8GfE6E/ktNhg/Uw8ybtyoGREwW3ADT2dnJDRNCo4vlwbZHy3oU/U1f9nA6LgLIxMV
X-Received: from pgjh4.prod.google.com ([2002:a63:df44:0:b0:af5:91a1:e217])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7116:b0:1f5:9961:c40
 with SMTP id adf61e73a8af0-1fe42f26554mr25357292637.8.1742855706986; Mon, 24
 Mar 2025 15:35:06 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:43 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-6-irogers@google.com>
Subject: [PATCH v1 05/14] perf intel-tpebs: Reduce scope of tpebs_events_size
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Moved to record argument computation rather than being global.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 13d70c6bd44b..e5ca58599b5f 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -28,7 +28,6 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
-static size_t tpebs_event_size;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
@@ -85,15 +84,20 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
 	const char **record_argv;
+	size_t tpebs_event_size = 0;
 	int ret;
 	char buf[32];
 	char cpumap_buf[50];
+	struct tpebs_retire_lat *t;
 
 	cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
 			 sizeof(cpumap_buf));
 
 	scnprintf(buf, sizeof(buf), "--control=fd:%d,%d", control_fd[0], ack_fd[1]);
 
+	list_for_each_entry(t, &tpebs_results, nd)
+		tpebs_event_size++;
+
 	record_argv = calloc(12 + 2 * tpebs_event_size, sizeof(char *));
 	if (!record_argv)
 		return -ENOMEM;
@@ -225,7 +229,6 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 		return NULL;
 	}
 	list_add_tail(&result->nd, &tpebs_results);
-	tpebs_event_size++;
 	return result;
 }
 
@@ -288,7 +291,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 	if (ret)
 		return ret;
 
-	if (tpebs_event_size > 0) {
+	if (!list_empty(&tpebs_results)) {
 		struct pollfd pollfd = { .events = POLLIN, };
 		int control_fd[2], ack_fd[2], len;
 		char ack_buf[8];
-- 
2.49.0.395.g12beb8f557-goog

