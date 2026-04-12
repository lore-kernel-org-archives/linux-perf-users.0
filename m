Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC432D43C
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959751; cv=none; b=nmcHJb9SGfH0XzepGbQYA6AlEdzYl0AA7LieXZdY9FEgs28ZpuLH9sBFftacYTxaJc3Ttmry3lWCcNxcI5Y/zDL/K8jI9LRRRZCxLjBXntTI7BPwclFIt7PSM8Vm0ybhBwyXq9Yla4U48BS3FmbkRlgVA9VChbkXC7oscv3WnaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959751; c=relaxed/simple;
	bh=s03PR3NdhraoAct+z3ztP2wak5yT9JPVUBwMWmour+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HwZOB89gnfIkBysrYNXTt53SSrqAnQhmjoQsubCE/CScW6ksrYNCbXI8AO9hWMSWCxp1o+ZKSWl7kzm5picE7CehT7Kfa/MVBSyl715dgwNMKblsAwLgHJ427eZw3aVob+ap7H0ppr7dYVG+MJhC5VGJ7+VRaxjI7UGP1yTHclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aD0ksokA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aD0ksokA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so4424920eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959750; x=1776564550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=aD0ksokAdjvkTgoGLrQNuqSsFW7VI1TkrQZbOPNs4dDMDW0XyqLKsB7roi0A+HoX+u
         seVwdgE7rZx/2EFwW9xIA6nM3wtmGa8U+4TwN6Cvxo/7Qb/S2KGzPK/9szKzQSVaPOut
         KKTi5xtxpw5Y4zfvJVri+rE6u8jrUiwUBWC2aBE64mfoRbNoFrqgNIKjLTrfGItQEp/L
         AilGENjTzxL2Igmuqa1i6/OD2KA+fhmAvWBpEK4C/pW/8sblXU8ENMby8zNcS/TtVM1Q
         pQ6uIjlg5nqgYnZQcy4UeLPjJk9hM6RIbvuY2g1yWcSIEVZPtgNqopSQPp766KuUMHL7
         k7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959750; x=1776564550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=YTOqKWGxWFFru79za6O2+Gz7MptFQ2aF7KtbZJSQa12uApNqw51qEDkLZYw3vbVJ2B
         azVYi04cN9vrC3e7Iwg2atQVfQMvZ8xThhWiBKMnyrKX18I8Ck+bTpZorGel3y2oVXW7
         BoybowRUJBMZ4uqzHPn+FM7GMHJS+8KxEL8sTOJ0eqVV0PqtSm/W59+xhp2oVMR8Q0Yt
         k0aKSLT/1gHpS/7yZIM60iA80NTptj1+4tsYHOch6M6/+M20KWL2mO39ZIW2tPzFMeEW
         BYpWFgl47Q5PUbvBpuZ0RTN4Ke/q1SVU0vXza7de9eAkPL0B4dFK8wOuVswnh8YNgfqA
         P8fA==
X-Forwarded-Encrypted: i=1; AFNElJ9meesiDXrgDkx789apbiMDPiyAjxyNBaOYrHhtYsdA+M/4AEDPwN/gRzGl5V0QxTOBiQ8iA1GYuSMYwPm0ARFG@vger.kernel.org
X-Gm-Message-State: AOJu0YyOibxuv/UiZ2jWekDiozdkU8TJyaMSkfRLiurO5aIZbWtyvQtB
	CiT9CUmv4ilXY33qTNoM8C7T/bpi/ygyBsdw7v3vKi1bb56uUGpplQrYKFHdOQkOfQSMJvkB3pF
	tmJNYr+OZsw==
X-Received: from dyt12.prod.google.com ([2002:a05:693c:808c:b0:2d7:37d5:85cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3709:b0:2d2:b3a1:4a89
 with SMTP id 5a478bee46e88-2d589fa2e9fmr5058696eec.30.1775959749697; Sat, 11
 Apr 2026 19:09:09 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:16 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-14-irogers@google.com>
Subject: [PATCH v10 13/29] perf annotate: Don't pass evsel to add_sample
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

