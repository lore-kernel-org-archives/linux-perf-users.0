Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B238F62D
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633195; cv=none; b=gCWeX3dg5vm7hnBe/GU2u01Vq5WZI2fz1Ai4j2Sr9i9Bu2er3svGibaAOC3NqVYyOhgaCtgOKDBXbZv4aaXYEllFdSG4dNn0r2rSV4LfHduuTriVqid1yYR09Ijzswm8mFRar23FaOkSd7dT/svdpNFaAUEW2SD4Wf0GKmHC7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633195; c=relaxed/simple;
	bh=cLWE7bs+0Cxg9cEMpw2DCvBK22szFSANqxVQJFFr1kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T3LC2ampB+cosRgMffkySZI9pB9FIakCmuB4q03MbNJ9W/6fRO8OJH7+PL5fnAX9KUrBjIDedrB+cYG8YC8pnhRe8o1dL/7Ea57GeCVgjc0oQWosvpY17ccNM+GRT6yAX4THt2A9RWpJva11uv9/A1YUUHZ/07K44+kjdeXaLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRqm/e0v; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRqm/e0v"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128ba70cc99so6519192c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633194; x=1776237994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=rRqm/e0vqrJ4Qb1bOidQYZvOVU0en4dTwl+MHP1jVl4XIvr/eqi+mhlFPNR8SHci/q
         BUF9nvDrQlxUXozmlKjFt0JuRzJSxwREUQQmyCAMMF6KBh3MoCMpvx0ZCcUJNTCEnrvm
         o4JSUIvitfkg3R02uEwiGV9bGuZS1+w9e2Tq9/IwjhJ5fA49XCeEWIT/xOjIhyWdhSW2
         eDn37j+BtUpchUPdC5wgH9vqACVpVaOA8Lk7U4W3qFjlvyMC6tUb07mVSyco9drAhKA7
         f3wPN5J4EHDfwipm1O8dOGXl/0SMOV2+JfLGBjQRb12lmVfuDhxKe4GxfFRZj4jkyTZW
         G5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633194; x=1776237994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=dNMJgqKhuKKt9/Od/KmrLTJcZAh68nKMg7YEGSqBMKMMNGjesoCZqtw46OgDNYFYjU
         oS9OqEerWJqouffX7o/PfJ8yv+x2cKi6bsNkKylPxNtaZOmlHMFjZ68Zd9toOnf48d9E
         3RMIxVJshSIChZzkepiyYuLju9zcykFFWfIEGS3ckiJf4R2v81XlTh2qZLByJoOBe3Tg
         IRWHp3NEUt7SgW5b9r3onSEsT0m+/0v14vB/iHGgM8JNzb+JimRvHxN7bffLeRoY2sxs
         6jS3wKB9DF0Xul9flSg3zke8dWEbl3eBqFbZSWsFLPVBWnc/sjZul3BxWbJasnptHZEW
         OzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8FHiHjUscmbrqK1EQt2OhQq1XVk4USOitVPNlmZKuog7RX/EjJY5hWCVb35Vak+r1Ci75DVEPLT0+93gwRGi7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vYd9wjAXFU3PUQR/IZ7VwAQP/qy35Kx0QhjE2V4LCsAiWy4W
	xaL4IjixCmgwOZ7z165113vVMTt7lkRPRyZ1YVWrzQmp4UhbGAcSpA43KzeDIEfZd0HJpmRtd4m
	g7basbBk4WQ==
X-Received: from dlbvv21.prod.google.com ([2002:a05:7022:5f15:b0:12c:1286:e1ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d0a:b0:128:d7a7:5250
 with SMTP id a92af1059eb24-12bfb787772mr10770206c88.33.1775633193553; Wed, 08
 Apr 2026 00:26:33 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:25:50 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-13-irogers@google.com>
Subject: [PATCH v7 12/23] perf report: Directly use sample->evsel to avoid
 computing from sample->id
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

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ff7117c5470f..3deb21f4d781 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -788,9 +788,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
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
2.53.0.1213.gd9a14994de-goog

