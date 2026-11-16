Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815122;
	b=Pl9KGJULzh6ZJzNCGK3rQi7FmEUnp2FI0rvVM7uXyP8zuBr7+MbCXgYLI3sDJ+1NzR2G
	 NQjBvVbZYVz5gnMw0wKjlQSgOOkRdxIAzRl83/n7d3JiLv13/3jHkNV7eEFL0ffMEMERR
	 RpqGvBgJpvyBtEirO+RyBjvy7IFQsw5nvok8ZI/UWQvm2GXpgt0Ijju0d2cpJxoHrmKVh
	 3/wlD4w5Sip05HLr0fL3MKXPAkzRkvjKZ9c3fyQIfw8LOKC+xbcRknlNXCfSwbVj/+nyw
	 N1G7fJF9FkklzAR67ulkh7Jibw9GCmVsYq9jJLa8B+VMy6FiBQCDLY1W3+flyKTHaKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=aRfvNh6QD28HUWSe7IyYWWl2xa0mUXFP5NmeCi5RQT0=;
	b=FV0pUaY18MKpeur+gKGl5Ylw8r9xbHmbIHFOiXpChS/TwonPOp0AWgv72FTGklCdDnrX
	 bjUkE0EA8knxfmYDedxHipBfSNbX5g5YhTZ+93GgOdd2uTaM9NwTl/wtGN9wIGEokGnLp
	 desYvHIUuk3SWGY4t+R9m7V7KSIrBN4qpElbpOQfMRCT9jkNLd6+TyAvnCCLjvRYxjgCI
	 VaaY3pWOeJnokwfyQscC9HvtQTZ089wld0wdY829+E3Ld1Nn3eTSCbHWOqQLRhDkuCHXW
	 bXMT8Qxpuvxdv59j1vf3O28zMp1lSpDYuMjcXMAVEaT5cWhBUXdNGw6+wEw3DOzHJlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cNM+iT6J;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9A606A881
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E9A606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cNM+iT6J
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36f26e6abe9so3844723eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815122; x=1795419922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRfvNh6QD28HUWSe7IyYWWl2xa0mUXFP5NmeCi5RQT0=;
        b=cNM+iT6JbTBSKJgUOV4y2nfVvqfIakYNiNGFP0z5awc4TP4I6f8wCUqw8RmuFcnvbz
         89SIh1c5ucI/oG4V7xg0D4HnwxsIUMWU8EJuopXhE+jyGjQuPGsW7X9agoKl6mgPoGJF
         hcz0Ahtev/j1CuDmTljU/ZbPfGVRmTEYSVvJxyinDpKZpaXF0EyuUjcDKdZNvRLEr1Z9
         uDBzyWnrNrAiJVmPxpdv/Yt/qvSYa7e4cSO/6uf5xpukehBKxRKOs/EF9sqG75TLIiR0
         Wd5d8N+gX2L5hP5zaOiBUBWd2qgns90gjonMniZoKr39fFfyPEfcGL2kOURI/5DB8dka
         oKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815122; x=1795419922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aRfvNh6QD28HUWSe7IyYWWl2xa0mUXFP5NmeCi5RQT0=;
        b=XvG0TlosgAl28/nmgKszOZ5FPyECKKJpMmmJWkyvtiBCjXarJK4jkaadjjsETMtah/
         KbqunRXlE3OGv40iYHJSkY1NZIvqh0zO5JlRfFJFj4flQKmRYrbSlEjElKZRG+YSQdCq
         PqiezP1YzmI/r2HqF9z/rXl5/E9gTlIc/SUdgmp6M6eUC93Chrctgu/1Jj+BgQSA2YKQ
         Xf2KiYF/VI/Oq0mMS+akpuXTlTUfzKFKEBhJqRQn5dA5TjfeO78Lf9C9NgIYaDg1tzod
         LwSRAlOgFSCWS6E58+fhq0Gw2g9GVFMCKOWu5q5D2K3v+p0gWYURiA/grvU8UWBuFZfu
         BQpQ==
X-Forwarded-Encrypted: i=1; AL+hErFTIwyS3N2FNyOpvegj4p3kglgiqtxIKlH0it/FyAN09WXBw/7m+HhortKIDbAe04Gybt6xx1fqo5wsTHptskme@vger.kernel.org
X-Gm-Message-State: APuU4Z9AqoGu/++9mqbiNctyMnMxhDnF+XDKdE51BlH699V9ZwqjhpR2
	nsNOpZa+d9MddktKMWGQxbZKgbZqHae59kgXAMeVVNtFMk7Q8SkPyVmgj1fG8e4OZtl/BcvdXC9
	/VglFULb87Q==
X-Received: from dycnm5.prod.google.com ([2002:a05:7300:d185:b0:35a:c4b6:314b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:8617:b0:370:cc56:b61a
 with SMTP id 5a478bee46e88-37967dd6065mr9478567eec.39.1794815121228; Sun, 15
 Nov 2026 23:45:21 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:02 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-8-irogers@google.com>
Subject: [PATCH v3 07/19] perf inject: Set ordered_events and
 ordering_requires_timestamps for --aslr
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 0ce6cf53db5b ("perf inject: Set ordering_requires_timestamps
before creating session") initialized ordered_events and
ordering_requires_timestamps on inject.tool before creating delegate
tools and the session, but omitted inject.aslr. Also set
ordering_requires_timestamps on aslr->tool.tool alongside ordered_events
in aslr_tool__init() so --aslr orders MMAP and sample events by
timestamp consistently.

Fixes: febea9ec382f ("perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 4 ++--
 tools/perf/util/aslr.c      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3f3108fd3981..b887a4398f96 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2810,7 +2810,7 @@ int cmd_inject(int argc, const char **argv)
 
 	data.path = inject.input_name;
 
-	ordered_events = inject.jit_mode || inject.sched_stat ||
+	ordered_events = inject.jit_mode || inject.sched_stat || inject.aslr ||
 		inject.itrace_synth_opts.vm_time_correlation ||
 		inject.itrace_synth_opts.set ||
 		inject.guest_session.perf_data_file ||
@@ -2861,7 +2861,7 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.tool.merge_deferred_callchains = false;
-	if (inject.jit_mode ||
+	if (inject.jit_mode || inject.aslr ||
 	    inject.itrace_synth_opts.vm_time_correlation ||
 	    inject.itrace_synth_opts.set ||
 	    inject.guest_session.perf_data_file ||
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index e365f807b021..dee077cca5fe 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -1273,6 +1273,7 @@ static int aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 {
 	delegate_tool__init(&aslr->tool, delegate);
 	aslr->tool.tool.ordered_events = true;
+	aslr->tool.tool.ordering_requires_timestamps = true;
 
 	if (machines__init(&aslr->machines, /*session=*/NULL))
 		return -ENOMEM;
-- 
2.56.1.703.gf848ed807c-goog

