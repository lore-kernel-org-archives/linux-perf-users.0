Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2A202C48
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043381; cv=none; b=ACzzCoydGvfE8MYr0PmfuOJbqx6xp+2qQVsYQx7+B8DzgiCZyT5/hHl+8CFB0/3HeiNk/y6r59zwfxLygN9N0M+EAtdXiFfqgGq37B8lOHLW+jCKWZ7RaQrKBHoBcG+x6gLuV8GwGFi8TjvQtnTRXIIboAN/iZnojbz7PiQLrcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043381; c=relaxed/simple;
	bh=s03PR3NdhraoAct+z3ztP2wak5yT9JPVUBwMWmour+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p1S1ZAQGZnzv+n34VW6qEcWO2YSlgcttQhzMpfyKVpVWHT4NXwdcWCE/Fxl/M6esOl5nqFjC23M1+qdJ+yBVRTp5/nucUOXRrgNp9Yber1Jkmevi15gLp0VsiieOUG9Mkk0GB1A/sHMLubD1RxUThdbZYNJMWZ6EHohRUPfeH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2xqSPe9; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2xqSPe9"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so16136259c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043378; x=1776648178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=N2xqSPe9uwuorFW12HlekK1HDrZeG5BXevOb2hxOvpOqIFEpCSCcOpGLbxGQYjlm5K
         0TFhwuPf6WTN990TG2KSeb2BCqXN9BZqmt1R7E0KZmGvnGZQfXrztbKJhysAxvge7yE6
         19uKphHl+1of29A8uk0mpS0o6oSCm4/sMvmvXG0+exd/ZeWcaKKFc0sns9C9pLkL/jNa
         pZzSYa4B3/7mhbfzzdqvmQbPL+54VFSXsVvn2PW80syuMsYVIaf/GcuRUYTfuwfGSPVU
         Uv4EuStyBMStH/mP03aW65FjgYyf4Jn+Sop4/ZoSB4IH6OYGruEMFvSZtdCrYcws7A6M
         zOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043378; x=1776648178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=AHfMCs4unLFCUcnT7q4GLmbPg/FmTEpTDBH4IvjAELlCZ9Up9h0wFomvaBBJdHf1J9
         LrSJ1r+7zPV8nSdb1ZeqImFgnjmXiuGoPDsnG1GQonVq53I85TkwLlms1+Zg+YDjprfy
         e2liHpUjt0L6qveXLbM6TrbgRnfwQMzzuzTZ+SFYPM2QyhEEZnPvBrsutpKowOn9DhUK
         BkwPKXrUJyU26jd8jkiQYCsaRQF2GWnSPRfvC6ujo8Eh4EKJuoQlh1G+dWldzbemO38z
         HLey1zMPHaCBkhtov4E1M+EBOm9EX/06DOrL+i+kRXjfp39cJ9h4v1K7M7nbbdL81pvL
         3Q+g==
X-Forwarded-Encrypted: i=1; AJvYcCWzHbimVRSv63gIDxh1q0GLJsWfrc+G0mKdNUfJ9yBkge8unJehP0ALBLBQ5TWE9QL//A/fotGrOrw3oReEFdIa@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKOIO/NfDljf7qqeHmSYOoEtEP+YzgfPJiYd8waZScb3dhBfP
	VGQvN5NDOLNw2nkx0aFGxBcg0ukX6OylQXQHPSoCbhQ+MezM/Goz0mS4xnHGOJtnDC/M5GZep2N
	x3qKaMeUiRA==
X-Received: from dycue6.prod.google.com ([2002:a05:7300:86:b0:2d7:2fce:704c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2915:b0:12c:3d30:37cd
 with SMTP id a92af1059eb24-12c3d303aa7mr2038467c88.0.1776043377520; Sun, 12
 Apr 2026 18:22:57 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:06 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-13-irogers@google.com>
Subject: [PATCH v11 12/33] perf annotate: Don't pass evsel to add_sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel so read it rather than pass it. Update
call site.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6f8be9ead43b..719b36d4eed5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -232,11 +232,11 @@ static bool has_annotation(struct perf_annotate *ann)
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
 
@@ -298,7 +298,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
+	    add_sample(sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.53.0.1213.gd9a14994de-goog

