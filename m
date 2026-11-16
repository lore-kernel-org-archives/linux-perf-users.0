Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815110;
	b=n6KriOic/simRysKYUzCq9FOLByw+QWKoDfV67lydm5aP8aMIoqIdzHMV/Ov6iN49EJ9
	 1KMc9M7KoKM5PopfYvxFzsTMA7LIkLWRoHVlGlemIkCvolMbOaO7oiWmX6OKopys3aKqM
	 wJ/0VIR4V20oZYdklVADZRVmN4BaUQZQ70b+8ipRepJosbqah0rC6yiCh7iPKt3Q7n9H3
	 T9OJEjbf1Z5jRvtij+A+nXn6S0EUOCHhudDFGbrZqGFx9Cr9j8a2h+EAJlCN5Bh7M9asA
	 yZBycQ+BZ/o4qGYwZ4LjLxa6otmkTiSwnSuv+Mv4sVJYKr27qVqM6g+vcUuqt7YGP3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VhmVWVRrk2339BmZFkj7hmAbe8j2FMXF93AwQ4jIvsU=;
	b=Bk6obqIIvkSPrJfW9omfhW1bcGAuJcsES7smJT5iHmFvhfhtH+CDrJZyVDqU6vqF7GpO
	 sFm/09BYogmFHcuvzmUVw5I3GzVYwh28koiBrN/NkR9t+vd9kijGSagG3XQwACaaihF46
	 R136+F7uJ2lwTbOS0btHNERgBW6365BZkVn+o00ZSUFPAd/cKAtPC8ZQngVj8aokM5T7A
	 wHJkJlq/GbTgSLGecXN9xQBKr9o9CT/h3lC3GyxkEr7eOWergCBq3cZPHWwdqZ2DBVSDt
	 hL77+KVgDL4/gWrHBcEKAN6DbZnCp4z08v+xGFhTz/d7WwJLqwkRM+cBO6dclG+6MRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TpYUQ9mr;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC42606A32C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC42606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TpYUQ9mr
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-37549877380so4363997eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815109; x=1795419909; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VhmVWVRrk2339BmZFkj7hmAbe8j2FMXF93AwQ4jIvsU=;
        b=TpYUQ9mrYK18ylzU/qW2jN4cLwlmXwHRsuugDsgXNoihNQW29xUQbGlyihr+RIJcCl
         y3zxNpG5aUMRY7Ka1GuvmCBEKRa+4XHhA/W7GLr1wjZReFN74YtwIvdnXOi7KtSfOS/9
         /hJCbYzAw76Bg1SlS+pujjgp6ol/afwLkTf+aRpdDLNGaCEZOpKjq7TCTSwHJa/sYTRo
         QnzfaA8zcc/b+jqbIT0m7XYrDmnLI1jHBrbOAEEKzkxgUtnd/MBb67ZsAiU+zS/Tp15u
         0S12vuK6VfirFt88KjTh1NZMQeI/tltZorhOg+0vvqbeEHfnij6Yci6OfJFYgMbChHhY
         evFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815109; x=1795419909;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VhmVWVRrk2339BmZFkj7hmAbe8j2FMXF93AwQ4jIvsU=;
        b=xGWb4RA43tFrZIlCIu+7KdXtjpUZjl/G0B/fapY7bwesRoAm1YQsDOTtEYqycFh5vJ
         Cl/yefXUPvgmH1GX38AWOdaXTYJepRh9x1+tiKGC3iyqMnvyS2ssMKevvX0VjEzHykd0
         7qDQd4b9KRT0jwBrGPxLm6A/OVulY22knx0Ram85+AcJpAWGYZDkYznQ3uUMRp/A/2/j
         NKKt+vFE372B7hEb7X/vywHg6CePtMATgk1wRTGqs3vZuT3dKPxaqPYLv7qqroJ8xdW1
         rexd9JE5y8rHUVKwaAyTBUtePMSfZ4uCIe+NHOhKx7I0vn3RW8/tVYbbiTDcvMfocaE9
         lnFQ==
X-Forwarded-Encrypted: i=1; AL+hErGw0kp2jTAkO+jfVdFLYaZ3ZG5+ZIjNorERts7dhRM+8pLb6OL0D+Sb3eX1ayJZZn9Goy7vRATr1pJrFF32P56q@vger.kernel.org
X-Gm-Message-State: APuU4Z+hCF0z4a8X6wisS9ctix6gtKkdtkfMoutcLSG2vMom4JnA63eJ
	CJ6AQ4rmKiQy9DKc1oazahB6/btUY0w2UHwE+IuwzNj6cG2y8Nrmx7TGT5pwMs9A5UYj7ZlsZlW
	N8fhZFOVdgA==
X-Received: from dlgx28-n1.prod.google.com ([2002:a05:701a:ccdc:10b0:1b5:345d:ed30])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:d0c:b0:1a2:fa1d:1de5
 with SMTP id a92af1059eb24-1b5030f284cmr11497837c88.20.1794815108990; Sun, 15
 Nov 2026 23:45:08 -0800 (PST)
Date: Sun, 15 Nov 2026 23:43:56 -0800
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
Message-ID: <20261116074414.3174737-2-irogers@google.com>
Subject: [PATCH v3 01/19] perf/core: Protect per-CPU callchain buffer across bpf_overflow_handler()
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
index 614f9f0e6500..fd9f654de269 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10818,8 +10818,15 @@ static int bpf_overflow_handler(struct perf_event *event,
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
 	if (prog) {
+		struct perf_callchain_entry *callchain = NULL;
+		int callchain_rctx;
+
 		perf_prepare_sample(data, event, regs);
+		if (data->sample_flags & PERF_SAMPLE_CALLCHAIN)
+			callchain = get_callchain_entry(&callchain_rctx);
 		ret = bpf_prog_run(prog, &ctx);
+		if (callchain)
+			put_callchain_entry(callchain_rctx);
 	}
 	rcu_read_unlock();
 out:
-- 
2.56.1.703.gf848ed807c-goog

