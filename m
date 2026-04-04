Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7BD2D77F7
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274253; cv=none; b=hkfpEIWQqzeEcsvy7JgDCF21HyXv6tgDdz71cuvjRCdLmvZcdVDqReFMkVk0fVttnNzi+xbt0ZbafsV3PXEW6Bio8LNrhcWK0Qh4985tB5riiWnXH/GUtZCjiPruin1Rt0qj6oTTp73roNg04AFK42z06S0L2EzmbdvLxlwUhTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274253; c=relaxed/simple;
	bh=wLe5Z0hoYL92ZfH30Bm/yipbxb3RvT+h3ODBZmIn3cE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WuCWRHAwrW4s0SNzoKnXlCz9opea2q67KBn2e1xfCZXT5fnWeXYRBi2gEmom5NM+jx9D2sD3lLLwKrGtL6uwDa0XYqFvM+6XubRP/RVv724mZtUTAsQWDRpbyM4FgK9GBJWo8N5KZvrkPPdEPx+G/Vu9jk4EaIp196Q1887U/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3xIz/Ef; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3xIz/Ef"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso3454444eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274251; x=1775879051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KG+vPQuqDQ75dTcoSgMioh1cuW1jaRrF2toCLPYvk8E=;
        b=q3xIz/EfmID96KafW/nEfxY4RfTGYAjo9+U621Nd3OTvgRkilfSHkAhPCEhQqh66nU
         NG+2MPcurA83FxP8A0gGSNmrpFS7aPAOHbH8CoN93zC18tmp+GP8wvcquSOU6MkpzQT1
         cGqoHmAeDX4iAL39HlbpGNkWEgrsqN9V/tfNPPoadg9VoMWZyI9GMmlBv7pfef+yCqZf
         hIT3G+rtKvc9od2cFgC2yA6i9p4FMrZXYsAHMiW5tAHaC5DoHZxCdDds92l95+4qomfG
         EMtZreVj85hh05S0n8dY8Cl6M/HekziMLG6dZM7zFfIx/5HNN6dPSXCEvWJuWnBwe99Z
         3xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274251; x=1775879051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KG+vPQuqDQ75dTcoSgMioh1cuW1jaRrF2toCLPYvk8E=;
        b=EqFXCGGXAjSjd5QxVq4OFqCEwcuq/TfsGMaLxeUY0TYbAR/cd1381qoZw6OwS3KLJ8
         E/Cvjow6B+DBhL8sXoj73OtWkiiGpmMMs96wDmVVEAhyW6iSGJQbBWdPoWzZKDjdQDKs
         ugGRlxqpfKtCBlPk59JhyK0mnhRqbaPAKA+Uj2czAlWBifhh1Rohi/SngguMQKLWxOM9
         2hjKFfisBA31GqxWyvAZ7Esbt1QQFHl5wmdWvALNan7vzF5UPoXSnMrWEMP7EBw/RiwY
         Ll9uh+vaPiEULDtbaQNxMgbn+RpuW0z12MI6jC0tFRi0gYdCJthhazeJoYs13vwqjUWD
         oPnA==
X-Forwarded-Encrypted: i=1; AJvYcCVMIYgjDGzWea/P4aCQOe4UNDqZOJj02xhkStoMrShWQjZwQGkB6TzoAn6cS6vInHqZppPvcgxo8zQmxPXA7L+J@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAqOarLhb3ZBgXVo6C6mEPtvhkSSGRmKLCsuF/4OOtkWiHzKL
	cDpb27XI/Y+w1L12yq0P8awOMjyEh4EALGCHGtQ9alYrmhmsWn43AUAQ/XpWaiOmBcIfMxqzxCg
	9Hx7Fm8ZIcA==
X-Received: from dydr4.prod.google.com ([2002:a05:7300:50e4:b0:2c1:baf:2b92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:bc0c:b0:2b7:2664:ae9f
 with SMTP id 5a478bee46e88-2cbf9af9223mr2693918eec.1.1775274250932; Fri, 03
 Apr 2026 20:44:10 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:15 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-16-irogers@google.com>
Subject: [PATCH v6 15/25] perf annotate: Don't pass evsel to add_sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel so read it rather than pass it. Update
call site.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 04fecaf4d1c8..542ce5459ec7 100644
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
2.53.0.1213.gd9a14994de-goog

