Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567883;
	b=UqF6IfzNE6DdtmnGv9PSzOV57gz8B45uWetxtbT/UYwl/D04TtS3w+lok8zHayZ9vVG5
	 ZDscejsa6nWdL6E8waZGGwDZuwyjtuiCYmqHg5NFVqusdZ/5viEcf9q547xMUmqhDaFPm
	 lNSAkmKHGVu2hSExOYyklwYcPiRbFwUF/n5zVY3u1I1/I5t1TGKZOKOF/rq/7ZPXEFy/l
	 6yoPXxtL/LaPkbD0+FmY6pSzeDCvwjyoTdcPU52aqNxmXuExu6tP9C+PcHiN5BmAgLpTh
	 tGBlpX4gPfe/Pnfir7sOTdbh3qvmrwIjAif6QiUPWJLvcoCipo3q5xVkcYJRa5AZzew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=p2fy+DpqSZGCjXCmXOGO/oc1L9NBEimm7FRwFXyUqLA=;
	b=dRNIOxe4vXRfXuL+M10WZg6HYRMN84ifL/lckjIdwrnqFxOVsoQmWzFBAR9P8EeaRriw
	 PpiIPDangsr6anUD0D+c8Y2wAtfbxoW5GfKiM/f35t377eWaqwWlGv6mnOKGyphRSff8V
	 t0ICX+4ElnK9ECO0CGuI4A4dLpdTj0dB3Ci50/PYpP3wKvIP6Pjyl+KY6GSdP5PM4YQYG
	 odp8jkUGZEGVcpkuUm+pJVgDHmCOXrShzr663mQploKtrfSlqVGoccZcONaym2ikBbZlM
	 947JbQtUeEspf/Rs+s49d/HbHh7Bm3Q86hv4aH7qsrVeJMB2kG/2uZh9g4NnzPhlQvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M3VRzKsP;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CA606A323
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 848CA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M3VRzKsP
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5670651eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567883; x=1796172683; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2fy+DpqSZGCjXCmXOGO/oc1L9NBEimm7FRwFXyUqLA=;
        b=M3VRzKsP3UU+jOmahxJ9oJPAs3N0YNRgLeynysUqTwnKN3O2FrO+UiWcovRQjLYdUa
         PtOKXAvO/ZDaKwWxZtSt0sHyILm1do5CxcIgYdafcJigWctm4SKnk2egJEuZ1t1m/fz+
         c0+KgN/MA+HzF0EG8xpjKmNbgYocQNTK5o6CpooKWu3xsYvKdqghR7031/P9dZCfa1Qq
         VwUD1dN5h91xvEhmRQQ5uv1AHWOWFCpLMTcr5uGgZaAzdvnKRoK2iY+s8JfGgjZPf22n
         bPKDNfWTfpYtv9dYLV1WCJeNxA7y2rihYRc8Xhh6AMam5U1WrHYwcF/AyeIJWcVKZtTe
         +99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567883; x=1796172683;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2fy+DpqSZGCjXCmXOGO/oc1L9NBEimm7FRwFXyUqLA=;
        b=ZiwEvSOAeM1q9iV0J0+EKiFDbkVmwjf4bRgVaoe2GJ4cJLRZ83ybHHJGytg53SQ74C
         CEjgvi9EjhuIFY9j4zkI0Y9R0+09gqbT6T5DEarrwM44JstLgn4GSTyLt20JNMrh59P4
         rp0JFsG9YJquq5va1Bb2us37uEHC0pm6jIO9CTleMY1FbztyhelILji8OzdXNe4A3V3r
         GhzYA5mav6ObmuGmmFgS0+a/QDkDD0wU3ySvna1/KYhacMphfqFI1NtApHvEVGqc7f/p
         tDQvhO+G410t9s85vOnrwsQR0ly73JhAOftoeM2YE5oDjqEfmoLksN9VTZqaYydZqO+E
         VEjw==
X-Forwarded-Encrypted: i=1; AL+hErFvwe1zgCxVc3Ckr4l3x8lFeSrIkRnHwADovugWVayCcwaC4I+rnhyYy4Z0z1vUDAovK0DLE9Pf0p48RacgEZcY@vger.kernel.org
X-Gm-Message-State: APuU4Z+BRgx1HHaJ6qCl2maxZ0t0RJ/Wb2mAI38qF2DOqQWVI4oepcND
	eFZuYmDzb355+vg1aG0Ltfnu1nGTGIv5r4VXE9ujdS8VAKtRSICsdu3AYXOSbz3nGgeteFf0chP
	MlC5s4QJuFQ==
X-Received: from dyad21.prod.google.com ([2002:a05:693c:8355:b0:35d:1771:4816])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:42cb:b0:386:b621:d8ec
 with SMTP id 5a478bee46e88-386b621dc16mr6503137eec.19.1795567882190; Tue, 24
 Nov 2026 16:51:22 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:50 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-2-irogers@google.com>
Subject: [PATCH v4 01/19] perf/core: Protect per-CPU callchain buffer across bpf_overflow_handler()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In bpf_overflow_handler(), perf_prepare_sample() runs before bpf_prog_run()
and saves data->callchain pointing into the current CPU's callchain buffer
for the active interrupt_context_level(), after get_perf_callchain() has
already released its callchain_recursion slot.

If the attached BPF_PROG_TYPE_PERF_EVENT program invokes a helper at the
same interrupt_context_level() that calls get_callchain_entry() (such as
bpf_perf_event_output() on a PERF_COUNT_SW_BPF_OUTPUT event configured with
PERF_SAMPLE_CALLCHAIN and a larger stack, or bpf_get_task_stack()), it
re-acquires the same per-CPU callchain buffer and overwrites
data->callchain->nr in place. When bpf_prog_run() returns non-zero and
__perf_event_output() emits the outer event's sample, perf_output_begin()
reserves only the smaller dyn_size computed earlier while
perf_output_sample() copies the overwritten larger data->callchain->nr
entries, overflowing the ring-buffer reservation.

Hold the callchain recursion slot via get_callchain_entry() across
bpf_prog_run() when PERF_SAMPLE_CALLCHAIN has been prepared so nested
callers at the same context level cannot overwrite the active per-CPU
callchain buffer.

Fixes: 0eed28220598 ("perf/core: Call perf_prepare_sample() before running BPF")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 947f23973ed4..d67bb825c504 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10816,11 +10816,18 @@ static int bpf_overflow_handler(struct perf_event *event,
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
 	if (prog) {
+		struct perf_callchain_entry *callchain = NULL;
+		int callchain_rctx;
+
 		perf_prepare_sample(data, event, regs);
 		/* bpf_perf_event_data::addr is readable without PERF_SAMPLE_ADDR */
 		if (!(data->sample_flags & PERF_SAMPLE_ADDR))
 			data->addr = 0;
+		if (data->sample_flags & PERF_SAMPLE_CALLCHAIN)
+			callchain = get_callchain_entry(&callchain_rctx);
 		ret = bpf_prog_run(prog, &ctx);
+		if (callchain)
+			put_callchain_entry(callchain_rctx);
 	}
 	rcu_read_unlock();
 out:
-- 
2.56.1.831.g720f3f5937-goog

