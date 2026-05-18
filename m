Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874732F7EF5
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142956; cv=none; b=sIa0OW1UfwOdukkl/hvKj3Q/VTfkKQ/ClXnhZGyxLbBkyPzitNEYhlOq+we1B7rxtl7fRfr5AxN4SpwONXhn0w9eDD++qwqwC76Mpvb6Bh3dZNPnI/6Pg5oLghs8KBgHlzhMwVPQ9+Nd5OtDnMImVZDvBbbb50hti6Ue/VFFzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142956; c=relaxed/simple;
	bh=Dm1dRXMcj8LHggSUomlhbdBytPSZTwFogeXZK3/CgVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=U9WRk6fvEFRu4/CTNC85jiJZuNImnhjT+pSajXP2X91kHa5mjbEZbsd0mWCOcmJ/VMpNcsE99MiOnlyzdqUibYGuSDjCHnJ+JMDXXcdAjIRhx8xz8O8qEhGbU3/E5pZlqBB4w+yavtKUjFtwmZkiXQvpY1wpqM3Kl9UgnwWGW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLNstwaF; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLNstwaF"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc3d81736so2233336c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779142954; x=1779747754; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpNAlzgW5SSa1ZsBC1HKHkIDD3KLaNZAgkWCJbzVU4w=;
        b=aLNstwaF7hfN/VrUghmetjjL4iu0RB0HRppQN7ceM1wztPcn1rXHhlnJ6+6B1xz0mA
         zqvGUkjJm2kNn10efiacY4q/jfsaFuNX09wsHPcjm1rkVnbZDtPga84puiudWDaciDO/
         2fl6wibUSZxhnkKcAhhQgBR21kRE27svxTo78ig6k8vwWgcnfv6UvEOEvhCjyMgn5LKE
         ja0VUgkLEV3fEprHOOezY0x5GLBfxEXA5OVAivKaaEHsNzM1crti0PeqjU1E2HEI/Zr/
         19+hVr7zhSudbVbs0Hwm3dQpsQI18DyKrlMWgG0NPPooYk1SK/c6BCJMwqQitBVagWBq
         E0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779142954; x=1779747754;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNAlzgW5SSa1ZsBC1HKHkIDD3KLaNZAgkWCJbzVU4w=;
        b=sB0cC1za/Ms5xr0LgoSaVX3W/T2bIXb2EULUdzMdjAj5KfxnrcSIrYu53rYbS56x2v
         yaqDYlil2xPJpDDe8f5fddW0SAtpqb4Lmi+KoQ9LUdA4D0VDAVUN1u4ezQb9zlt3wybg
         U705MRyb/2S0s64dzzx4+oW64fUQEY5plMKeCWEyauJ2RG+25PjUUTom3mMZbZ5FBbo4
         IP+vT/rPpXszXaBcatOGO4wsD2KEV2hUyAuQV1ciMoqDYS37yGKLynj3MY+CvwksyKOk
         xhgABlZBmEihV/46DItisfB4/yEduPu3x0MNLvK2vPS4kiajBo6XpR8yLSRz4ip0Xk+J
         0Zlg==
X-Forwarded-Encrypted: i=1; AFNElJ+KuuTr203j2oZIkmCxpJQW5+ko2QDlm0QlmUPD8SqdniwGvQoc/4OtBMxienOio4xsG+dMlr2rauSLLYGdlU++@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSyjmXrnkE0BLj4//67stMuokGNlMEj1D6AYmWB4I58PXhdNm
	2TCw3oHyGrx8bnzYsLy61ou+aHq0JWAub4Bx0XIZuOqBIELs89Bqx8Xloix4NablyRO1yQyCFEY
	5dSXE3/5jeQ==
X-Received: from dlan21-n2.prod.google.com ([2002:a05:7022:eb55:20b0:132:8d92:4d72])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2586:b0:12c:856:ddcc
 with SMTP id a92af1059eb24-1350474133dmr7772190c88.27.1779142953579; Mon, 18
 May 2026 15:22:33 -0700 (PDT)
Date: Mon, 18 May 2026 15:22:27 -0700
In-Reply-To: <20260518222228.3027004-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518222228.3027004-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518222228.3027004-2-irogers@google.com>
Subject: [PATCH v1 1/2] perf stat: Propagate supported flag to follower cgroup
 BPF events
From: Ian Rogers <irogers@google.com>
To: skanev@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When using BPF counters with cgroups, follower events (for cgroups
other than the first one) are not opened. Because they are not opened,
their `supported` flag was left as `false`.

During metric calculation, `prepare_metric` checks if the event is
supported. If it is not supported (like the follower events), it
explicitly sets the value to `NAN`, which eventually causes the metric
to be reported as `nan %`.

Fix this by propagating the `supported` flag from the "leader" events
(the ones opened for the first cgroup) to the "follower" events.

Reported-by: Svilen Kanev <skanev@google.com>
Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter_cgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 519fee3dc3d0..dd1851634087 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -186,6 +186,21 @@ static int bperf_load_program(struct evlist *evlist)
 		i++;
 	}
 
+	/*
+	 * Propagate supported flag from leaders to followers. Follower events
+	 * are not opened, so their supported flag remains false.
+	 */
+	{
+		struct evsel *leader;
+		int num_events = evlist->core.nr_entries / nr_cgroups;
+
+		evlist__for_each_entry(evlist, evsel) {
+			leader = evlist__find_evsel(evlist, evsel->core.idx % num_events);
+			if (leader)
+				evsel->supported = leader->supported;
+		}
+	}
+
 	/*
 	 * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
 	 * whether the kernel support it
-- 
2.54.0.631.ge1b05301d1-goog

