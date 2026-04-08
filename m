Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0930390220
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633198; cv=none; b=QHo+Qj7sY89pOS58d9k2oHn3LqYVIgIamoqMBsgwQvpHWLbp86Ipyvy1/6iFjTfCVNeaCrXjeqzTsIs58E41QiI5ty0lEyYT7rhPJpCYwYbmsAMVZEB92Oq9MOLgv7BbTd0GA59LSylUoYpYBI6nz2v4DVHsE34REOqyHQES98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633198; c=relaxed/simple;
	bh=wLe5Z0hoYL92ZfH30Bm/yipbxb3RvT+h3ODBZmIn3cE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYGwC/zQGjylhw+ZwO6K2SRjefWmm3JuQJTt9godkikkdzetjcu8ENaKjlaztFCWyuIoqwl1LXK7W6m9Hm+2yaQlogvLBSLVCsZharpqjWPYFqSmWTjDannNpAnCfdoHUsr+3e/Vv6wUiy3NrhgqV1DcKQobTcSlu9KLQKLob/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZ2+JiJt; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZ2+JiJt"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c21dbc9c1so1708057c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633196; x=1776237996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KG+vPQuqDQ75dTcoSgMioh1cuW1jaRrF2toCLPYvk8E=;
        b=pZ2+JiJtjON0i9bmgKMXSG1soq3uL41wSG+PGPpHvV8npHP8YhkHqa79K2ArgsTYKQ
         nUIz5AS+DDDcnW20h1oYTPSNXknFF0K5Wjbu5NQrIJcJ4ZZ130TfnYYw3XW3BpBdb2iI
         lvERIrnuSs+d1NB9/v/dVRNpD9irVHD+jQTtpD93kUpJrSJDLkWZWzdv/sqo1VoniCR9
         J2zylB9HZc3bKUPiUtOJ2BpoZPUJBIDa1Rt4NsS4boq/9T9iIzKIGSNA9qW2Ba+v5ROr
         EIMFhtls5uza06uUPIfiPCZreUwzz6leVLliw6Lb5iOgrJq8luj0vpj5EXKuLzdaaGVb
         xvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633196; x=1776237996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KG+vPQuqDQ75dTcoSgMioh1cuW1jaRrF2toCLPYvk8E=;
        b=sRWx7PbeeyEMzupfdAn9ny3zCneLUzhJclImsebE33icrOPFgEicd5fx7WgXQ3/RLS
         iZgwqI2Enyur4Hdb5/tSrYTdXvJuuUlNZU9XKy8x9KS7GslWfYWSJfm0LAJYUrYfJa6O
         teCjLazkpfRtccYepUOKeyHocIVzh/qJvYk63WglTJZtpyUDK50zU/7kcetk0IauWGmy
         gRL1myPzFh/yu7cXjlAm1wkCuuhXUyDgPExMBwqTTZt4+e2MVubsXKxqHGwkHI+sbJ7c
         3jPHtcmODKSOC1nqVNSpTddmSY+ZPNsJkkeFkCkDJNuupFK40ru50l34mj2aAX1Ed12A
         npXA==
X-Forwarded-Encrypted: i=1; AJvYcCXg650b/cgs1PFx/dBg8fMYe1xq9P2ACqe60FLuz41IXNwAFKGSriX1UKIKpMnKST+kTHpLgI15L+rwiaGardJi@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5HJ4A7+rjQx6bvE7RjUsseaa0GURGtEcOAnXLhEhqwlMek07
	/UPx2xv+DtAoYA1MvI+zyMxf7qFBPDQ2CO7j8uvdOrWV21ITNzYmOxTWQ3jRa/M9wUyNg3qSFt6
	yZU+36NU1cw==
X-Received: from dlbrx12.prod.google.com ([2002:a05:7022:170c:b0:12b:f977:8848])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f0e:b0:12c:14df:a510
 with SMTP id a92af1059eb24-12c14dfa614mr3006388c88.28.1775633195902; Wed, 08
 Apr 2026 00:26:35 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:25:51 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-14-irogers@google.com>
Subject: [PATCH v7 13/23] perf annotate: Don't pass evsel to add_sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
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

