Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32103815E9
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658876; cv=none; b=jGulVHvnlnHBgM+TSJRGRSjpM4sPQAVaO0O6SrCyfsJR8H9VAl7GzQaTsmjZyJJxvuQN7Tcc/ok98AYi+uoXjYuXBoJ9QQhi9/CXJ+dmga8YxIuM9AkZfg+ZTIVrbFJsplVuIJAck4FrBBI1u/pFQUFHN+mBLzxnWAhsuD3D3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658876; c=relaxed/simple;
	bh=4vIp3JkK7iP8+43rYoniicXXa4ejSKScPHrdD8BnCTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MkQ8TSvJ10pNTgHO2vylZx42tWTcIflQyZ4pPIPgZvKIJLIPwydWYF1egkGBVNe7zcyTJVVWinJE88lIJdLA4JpwwZAjzTr+FTcNL8pE++99FzU3YYGchbv7wrI6YsjiFDUfNxxTS3ukQUNtIxrvasIJAx3akcQOabl3SPrKC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xyDLoN8x; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xyDLoN8x"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124a95b6f61so23136096c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658875; x=1771263675; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZ3o2ywCUqKHmgaeYXLFe19LpJk8p9qRFFPz4XQZX9k=;
        b=xyDLoN8x1ZgCGrSW/17JtU0QbYfIFg1aBD9nq4tkywAPo2DS0OmPt/xVy8wEiyuWFX
         vA7N3tLZUvEmpSmxbhdrBs7MHACWOBgPb7QGMrD5NX+CiVp0SRW3r5gKtLAMv7x9iO0U
         5k+2aAKyILACGuV/nwJ17j0zB//bT/R9DX43BXkqUsuA9NrMieuPDCoq22o2DR7n0ap7
         5LgsoPlko5KQqJ/gz+KI0SYhrCNFCwLOYxnDskIBqMFyc0vsl93CpiCqTssIT4GrOsqM
         JdEwX9KOntSVZ3nUSJMfYjEa+NyWuRF62bJrUlgdLlAzVyODGpCmjwFjRvp9Ase3UMuM
         5JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658875; x=1771263675;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ3o2ywCUqKHmgaeYXLFe19LpJk8p9qRFFPz4XQZX9k=;
        b=WJSQ/2/vC799UwNUQkhemaHRmuQqcqvvAT/LF8mts+4XWZtHrDGkGwPY/qhRBbu+4o
         AZlA41FPc8XOci8PY+a06WYJgBHdRbCrbICs9TkCna+Vij2qFZaHlXB4pDaREo74eBG1
         QhiJk8iIeTf7QxgYfRKtOQt6i7WnlS75kkqCbiyoL8An8JFhp9jUYRJY00NWSaDkqMo5
         yBK5RUuBG5aWU7wX7BrTPTC9iD1pYlh6Lppwqv/zEGL0WHTJznXs1+S+dXmiyi9uh5Pm
         YDFYP91gLrGUXSXjWndLj+S3rC5s+3Pu1nL52Z9knxQOgLUSxMFJKwe4cvd47tSD89Wu
         jbjw==
X-Forwarded-Encrypted: i=1; AJvYcCX5n7kEHwOInOjrlWUoKusHaxysx913xjtEqBnza9GRDEEhtKeRC+Fl36XZUD1e9FWq0aJ0viURV+ZHW996HuZL@vger.kernel.org
X-Gm-Message-State: AOJu0YxRuXhNBg1eH7KC9NprbMG+Yhj6QaW3do4r+tqVl2v3H07x0QKj
	7/NcRhN1K7kmceQEZi5rqCJmYYYyJcXeyJy+ufpkjTBxkWQA2l87EXLe6M92ubgwlaLY2qiMeAE
	F3NwT5KvI6A==
X-Received: from dlw12.prod.google.com ([2002:a05:7022:4c:b0:126:f7ed:3a69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6894:b0:122:153:d161
 with SMTP id a92af1059eb24-12704001972mr6324898c88.17.1770658875082; Mon, 09
 Feb 2026 09:41:15 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:22 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-16-irogers@google.com>
Subject: [PATCH v1 15/25] perf annotate: Don't pass evsel to add_sample
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

The sample contains the evsel so read it rather than pass it. Update
call site.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 26fe2cb93833..44ba6ba8ffb8 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -233,11 +233,11 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
-			     struct addr_location *al, struct perf_annotate *ann,
-			     struct machine *machine)
+static int add_sample(struct perf_sample *sample,
+		      struct addr_location *al, struct perf_annotate *ann,
+		      struct machine *machine)
 {
-	struct hists *hists = evsel__hists(evsel);
+	struct hists *hists = evsel__hists(sample->evsel);
 	struct hist_entry *he;
 	int ret;
 
@@ -299,7 +299,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
+	    add_sample(sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.53.0.239.g8d8fc8a987-goog

