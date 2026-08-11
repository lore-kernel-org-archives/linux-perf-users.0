Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48144334A0
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492433; cv=none; b=Q567nNZA2Ej4/7k784f9SLaefhB5MD3sQKo5Qpa0J0PyI8fK8gS+EwcR5WYX5/xtpcviGBMQRDxGsSKxAeiVs12qICHDKTve2mCbvfeuEGv8Wr57RaJ70PrsBz28iS1Ivnh0095JKFAJAZNnEQid9W5xW198GBSWGvHfovi5tEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492433; c=relaxed/simple;
	bh=qpY9hwUm1VtCpfQaT9JtmZnLLzTR3oMcZSOjkRsdLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVQYRgTRbaKKFHbQnP25TgENMCJGRrrIAL/rkO4g+RzfmnIFIrh5btCj7eDbijkWG5nEoygLfl1fwinUnFdVq0++zfyT1jw6kidtWIvZbNYdjCR7KWsfyBAlZlRnhO0YvQ/fUu0L8dQAygC74lgMCpc0P86QlLvfWpH3Y+95KAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp889cmc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp889cmc"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9aea40d799so215740a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 16:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786492430; x=1787097230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AY/Dp7ip8sCatNzHcOgs/oMLEEtZQxV5ZR6XyZHm6HY=;
        b=Wp889cmcqoYlX8mUZlm58ciIBxFZxpDkuD+/G4g1QUyg6UEajlf23DztPx/y6OZ59K
         rKDt7WdR9yxsIs5YE9lwEgsJuINzhiMXo+dD9SmGx40U5lQv8h22PyDGkKtMWlVCfvA5
         SBLCOxlrOc5HBQ1b4dq1Cjf4nMFktyD/k852vyCF2hfGAi0UoVOXHfl1FDL9rPnAjtZR
         miRQEkxOOiIlFaOfbdycMoeDsy0iAvnz57dGto332Qg0gYSKmdXDvpEPylv94hzozuLk
         ZiZumgwCMOy20kWIlzFc7x7/DFjjyMMK0sKuUfnEfOu9LPOIGwlTeWn1X95LrNS16+it
         rNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786492430; x=1787097230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AY/Dp7ip8sCatNzHcOgs/oMLEEtZQxV5ZR6XyZHm6HY=;
        b=NKVs8yB2/25LaT7DJ1oqgggXF2KNxG+lGUmATqRGf4xIgOm6nUgSQ19lfsWpRIxeJu
         UKRaOcPl/fPECrgeAbrMzQidm0DdOxiLwP7LgumLwmCtncxp3iLqqjRVW6+olx8+sA7z
         iIZ+606sHXzd1nrMnJ5bPg6icTfMoVWiWfZLNV515rxsDazDI2QkNbVbma1ckT72C6ew
         DhVWipXakjUaPs96qfp8uxkQ62GiUT2CkLvnOZs75b8fmpVRPzKnlBFQ+x649x9doAnb
         o+c4rW8KaVu4biIL2xPN7j+Ktgq+zxY2gGxybsbNGhiMwweNZ96oo9V8caMueTlqaxcm
         glLw==
X-Gm-Message-State: AOJu0Yx6arVAC1YnslIQqyBX39bT2dD7zbI/l+kcyazfXHW58UfDH37V
	yhYuqGoo2JCYJKCMQQtWIq+pfq5rUhID9nrW6q8r9+ChFJJVuArkBS/C
X-Gm-Gg: AR+sD10R+BanbKxMjOL9wFWWjesZayefFTIOeWNGVUeTOo6XSuayel3SvZWZAPUVMin
	qyf4DouHjLw0PmwR1OBPS8MYPnNMR4FiXsixngo1a9jGnaI7u7eQDP3b+2cCVr78ri0PxSozfT0
	JUHUoIaJLBxyqZ0BodjXH/RlOp9Q8hNxTAwvuRJBHyXkqO0cf8rGTbWZjmwy66NYTXDosweWFr9
	kExYsWMymq0RHZPWCfeLEcJT86E6EqYkkA/r77k2X/DqUAY+B6hp4vfTrmn2XVkU9LdkPZzbjtC
	LoBGjGB0uQVoTstS0AJZugcGQpJ8S0fbntbwhJ5iiSc3DPFtDBiShUDhsk8D/K4OF3XzxoNajZX
	ZOvIkd/pw4Nuhryy+Q2+k/kvP39Eowr02UZYNz/JaUVbxMud4nGdA4EwAbLr7l51exKJA5QmGvU
	zz5g3l8U8TqC6FyT2HpvA8OoLqT909RCpj/BYJwsNCLwX0oHK7RkASy0bBNTBxBuFQQ/8LqmrgZ
	xNJq+O3K0bYKZRkTt3DIEQ/Ag1kHJrO7z8IdBgANFBI2JwukHAGIw==
X-Received: by 2002:a05:6a20:3c8f:b0:3c3:8d4c:6673 with SMTP id adf61e73a8af0-3cc3f8ade77mr603568637.37.1786492429914;
        Tue, 11 Aug 2026 16:53:49 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:4531:180e:142a:c2f1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3d0b432sm3853828eec.8.2026.08.11.16.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 16:53:48 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	me@kylehuey.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Subject: [PATCH] perf/bpf: Fix data race in __perf_event_overflow
Date: Wed, 12 Aug 2026 05:23:31 +0530
Message-ID: <20260811235331.10044-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_event_detach_bpf_prog() writes event->prog = NULL
under bpf_event_mutex, while __perf_event_overflow() reads
event->prog concurrently without any lock protection. This
causes a data race detected by KCSAN.

__perf_event_overflow() can be called from interrupt/NMI
context, so it cannot acquire bpf_event_mutex. Fix the race
by using WRITE_ONCE() in perf_event_detach_bpf_prog() and
READ_ONCE() in __perf_event_overflow(). Also store the result
of READ_ONCE() in a local variable to avoid reading event->prog
twice which could result in a NULL pointer dereference if the
pointer becomes NULL between the two reads.

Reported-by: syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=651d2774bd1d8395595f
Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through overflow machinery")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 kernel/events/core.c     | 4 +++-
 kernel/trace/bpf_trace.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78fe7..9d9c5477772e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10753,6 +10753,7 @@ static int __perf_event_overflow(struct perf_event *event,
 {
 	int events = atomic_read(&event->event_limit);
 	int ret = 0;
+	struct bpf_prog *prog;
 
 	/*
 	 * Non-sampling counters might still use the PMI to fold short
@@ -10766,7 +10767,8 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (event->attr.aux_pause)
 		perf_event_aux_pause(event->aux_event, true);
 
-	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
+	prog = READ_ONCE(event->prog);
+	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
 	    !bpf_overflow_handler(event, data, regs))
 		goto out;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 75495a5c3507..ee61dc760045 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2018,7 +2018,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 
 put:
 	prog = event->prog;
-	event->prog = NULL;
+	WRITE_ONCE(event->prog, NULL);
 
 unlock:
 	mutex_unlock(&bpf_event_mutex);
-- 
2.43.0

