Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2138A725
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658873; cv=none; b=ASnSiwvW+lzYy5awymAVof460NwDtonLhMWKyE1gdO7Z7ic4tgNzM/2HeifFnuuqa4hHRepu2u3F7hwMl/CbPCmSRWaWx048FTS4YuPu2YvQo5YS38Gdw7yOOiq3pA4KAqjmLoQGTR9qK145vLfFIx3tbH5oLuFr5BEK326B6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658873; c=relaxed/simple;
	bh=OuO5CIiumnJDk1LuAHMkk8yZXFAOKyeOBdi/um5F54c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HEGyuJ0esqGkGlNjIHRve5gyAOVtrcUIRkh+E5cJPthklGVlIE3D1YtfGrG2ixB2SLOoQc44RaI3b70Cxp2x3WqVb4X7gIuhXvHyDgmK0NgSTBOKhakYYFTzeuK/IWMNt6lCcHtW57KlsXRRO5utocOP5aJNVO7QyxkoTF0C6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJBlDW24; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJBlDW24"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-126e8ee6227so6106185c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658873; x=1771263673; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijDnLC7lbgkDdMOI0mf/Kc7aLqDxbIaVzvPkpmj1vkc=;
        b=AJBlDW245wvl1Yw8xOdOnTfONvw6PygqzYqDtm3FT9enwjKs7iWgFBQcjQ6YeHCqjf
         AFZkumwa686PcZiBAiAncj7ruhxe3P9kZ+9Cj352T5jOHyRqndTdpVT4mfbVJKz2HqUM
         pQh7JjKT/npQiZdSCIVNUUDfNL3rIM25yAU37MSm4+4KttJ0FoUlLZFeZJ/2dVPBJkBR
         Wki6TSgvs97v8R9pSsTRikVrafzODXAJIBR7SRGC3SQB31bQk00ov/vb28OXoxBShp6S
         mr/qWODYIjyoAjCB9/DRc79/3z9F0hU8W4SDP0cdLJXDX7kLMNlXB8mahTIEJahhH3fP
         NFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658873; x=1771263673;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijDnLC7lbgkDdMOI0mf/Kc7aLqDxbIaVzvPkpmj1vkc=;
        b=E0aF+ODKAeisTsMb1xo1DC4E6dhyX41/MZXfhDY7eSM7cy3v8YeiCKGfpI1nF81d42
         To20MdoMcsBRGgjQF0k8GJZskXLT+AC5l/91bQeINF/Lf9PzLqAqj1GQ9ZgmKaNiPj1Q
         0v/fHsN3wI7LuJeqqp+J94xhMTAnO37y6LLgQ9frFBBr5dJLfAJYJEgDe/OP+5xJa0BO
         W7/8eShTXklExY2bhHWwfHd4KQBCGzaSlJH/sJNmHSdSb0cNCDVSCrwiH5LkiiaYHLC/
         /xr0OsdjQV64c8Outs+1RcaCJFn9YOWzhKK/8j15OJKzm0qkEkr2n3mSn4Bnyu2QtouN
         nJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCUVQJT64+Flpt7dC5i26nD5no2J/L2xzoImcR5rELCY+SghKm1IIlmhGoNZeY2iDloJbkst22Y935NUzQBM99Sl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7a7C0bv0ijgtgpKIE8ld6oJ4vz93xVWEI4tnnaktz1XVW7vXY
	BfFVfEOJGyoi5+nDL+u0ndgUq5XbyGWwawR5HztpOPQ81A9/g8WddoSo4jBhtclB6AmNCcCfX0p
	XCOBKBq3DoQ==
X-Received: from dlboy9.prod.google.com ([2002:a05:7022:1289:b0:127:c11:f47a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e22:b0:11b:8b4b:bff7
 with SMTP id a92af1059eb24-1270409535emr5195078c88.39.1770658872939; Mon, 09
 Feb 2026 09:41:12 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:21 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-15-irogers@google.com>
Subject: [PATCH v1 14/25] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ae7985ec2bd8..c088c7f94fac 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -793,9 +793,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 				    struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 
-	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
 		u32 count = event->lost_samples.lost;
-- 
2.53.0.239.g8d8fc8a987-goog

