Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE241ABA
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqBwKDGO"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764F7212F
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cafa90160so5745694276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186302; x=1698791102; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cZX6FOP9Id6EVCdgsB1n601UiMDcX5xk8Ugm2UBQtA=;
        b=fqBwKDGOCT1JJF7Lj2boSkxpXCAnWxWXKUp8yd2xS3Fp0JFaquGdgMoicOfUwGuZDF
         H9K2FonFDUfPK9KHTBVqNSdRI5J9P/CEwWPO7qIhgfiC8e3OwPmla0U1dfiuuqfgq7ZO
         AE7BOhQdTTRK3YWK7TP8n/fq3518AsRJbk0TkhIidO7DNQ6b+BWJ+ZGrSePdW9bP4EB+
         1IrP29DhWSYktDWy5W8GtMGbDl4aKUPCIzHQQf378nGjo4OPuMWjFvZswvWiU5QEclte
         l/NGR7w4DGiSd72L1Hjl3IK5q76J9lMt3RV299d1aTqdLH56OASadjHKANAqmG/BM9Os
         buUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186302; x=1698791102;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cZX6FOP9Id6EVCdgsB1n601UiMDcX5xk8Ugm2UBQtA=;
        b=gFR8yxs/r3HCwrG5iO9Q80dtf32y97OgpbxXujIM878C4CS/xRiCkPxi2OUSwrxa+l
         /xw58gpZnRnMeWFQOpc0cEo1jRTFp+TNmU2FckxfbFNNOrUl/E3Vu99CtdU2v8B+w7rF
         MlvaDbxhJzE8zwbPUYQ4WemgvZ9P/4IiuPlXFmJG4x9k8N3L0cJHmVq2ye6juxyPoZO/
         4NI+PVWZGPdecRxEE0QI0WEt2+czVHgmCgiu3SEJZXqh5fdGvinXzbxTRVIjMl2B8s4G
         6UFXKs8XOSBGGnvgrhv+U7rXfN0icMPCa31fUq+wtTsFD661Ol3hUeJWP+atTNwrzndz
         Heiw==
X-Gm-Message-State: AOJu0YwpNSelH5BDdyjpIwkNVn/sG4Cc+C+xSerBFQPk8ZYtexQwMbZa
	kTPP/ItakvMH8t1ZD8ulcGf52TZGHWAj
X-Google-Smtp-Source: AGHT+IHiIg80UVxgn0ef1Q3+qtdWTTMqNK+8ZeTE8lM3zV2hmbAB53JCAibS99Jw+IqLwWJ58AoCFbXoW1Ou
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:ad49:0:b0:d81:582b:4661 with SMTP id
 l9-20020a25ad49000000b00d81582b4661mr259838ybe.8.1698186302403; Tue, 24 Oct
 2023 15:25:02 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:25 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 22/50] perf bpf: Don't synthesize BPF events when disabled
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If BPF sideband events are disabled on the command line, don't
synthesize BPF events too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 38fcf3ba5749..830711cae30d 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -386,6 +386,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	int err;
 	int fd;
 
+	if (opts->no_bpf_event)
+		return 0;
+
 	event = malloc(sizeof(event->bpf) + KSYM_NAME_LEN + machine->id_hdr_size);
 	if (!event)
 		return -1;
-- 
2.42.0.758.gaed0368e0e-goog

