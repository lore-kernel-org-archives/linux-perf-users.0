Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8120B0B
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+CD5JIn"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795FA10DD
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b064442464so17724097b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947903; x=1699552703; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGESJj7au1uXJ8rgsZ7Z2SvkHL285HgbRjBBhgb6nnY=;
        b=J+CD5JInXbg2x05frrOkZwqLOYhF9KK9Jx8eWgEGvnJFgtUVK576cYF9cAuNQeNkDK
         jlCcooaAlZR4Jlz0PMe0J47QZ8FJq7nSxBtFUEEm+nHuxevxENK+d/J0l6pNHT9gt5Zo
         kXU3P4tDZYpWHjanA8SB99TGGF8bPbTSbBIr9584NcmCOKFB3SXoiH+J2ZXhTK1h7naa
         okFH+pmsYYjb32sviv87h7DARwy98ZenGMgl4NJKYhcIe6sLEe+rd9wgZxVZdHGq5hgI
         PBBkZ0o0t05pkERktEF+r9WYj77FUh3RZqVlo9gTs2cO00+ERKCBr/dhTqGrBLnykIJ1
         xiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947903; x=1699552703;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGESJj7au1uXJ8rgsZ7Z2SvkHL285HgbRjBBhgb6nnY=;
        b=o/4mrAT8pvxvtuqCpJG695hG3n/nK/kbsLo1rZDLW1dQwWn18kE4cTsFrBnaB0w8bM
         +GOR4oS3b+Mj7rI62BD7NUuFqeeIJp8s/4wQyh/CGUn8BRZXK/UDJtRlNtShLJI+C5xX
         zMqN9E8rh75zV/SzoUZtuFtaqSgBMlOWH8/nOB2P4ux9JxTnvrjvrN+FUFn+3tGT9fzm
         Cu3pk70Us3M5FRKB1XE1W7Q7ikvpG4XGepGBjJG8tSA9qTexH6S5jojNvijlqBZqDxTe
         am3ARrL37pfZT1Kv70yoDRgShHY4ZkDrAnXYE1RpTFNleU2zg86MWe7dzYLqNZbXmDEn
         XF6w==
X-Gm-Message-State: AOJu0Yy/s0def9F2q3hU4Xnsf3LujvZ0pmQYsVXJWG+5El/AX58rcVlA
	QUi8vMfWHLPa87w7xmDLnjDzjFmr7EU1
X-Google-Smtp-Source: AGHT+IErpT9V6TA5oY3EazOusVnIGLo3lQy4fUOSYc8uKrTiuq6W4VlJP3quotDnMeMnd+q3wawGdCOB1Oyg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:2083:0:b0:da0:c584:def4 with SMTP id
 g125-20020a252083000000b00da0c584def4mr359850ybg.1.1698947903463; Thu, 02 Nov
 2023 10:58:23 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:56:54 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 12/53] perf bpf: Don't synthesize BPF events when disabled
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.42.0.869.gea05f2083d-goog

