Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466703264E4
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959749; cv=none; b=VgFVf9llmZm3v5SwVm3Uz5ezqRWMWMhUl0XxZAiUbtNJN2X3vRTkpJUiG3jbaaq/VlONfGJIE/Hh3Fy7BYJR1LnFSUi6PoZtHsDs4fJj/yGGWz5f9X55FDzfYfG/gYuBHLA5zFVc6EdBaj6lwo6/caa3Lrij6AoFvsT9EfeLkAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959749; c=relaxed/simple;
	bh=cLWE7bs+0Cxg9cEMpw2DCvBK22szFSANqxVQJFFr1kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mKuq9Bp5Oav3MQNQ+hqCkygkbsApB6D3N8b6H2OYQoYDQifcP3v6sAUuq/dilxfhUCf9CaOFmpcXTASRwZKe4G4BaMhfwGXshFRmaQJua0G0MRaaEukqQAhS/nEP4ahsTRecgluCcS5vM6Q3w0pMvipv9or2EkAzbNH2XyxHYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XpRZ0Q/4; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpRZ0Q/4"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so4424864eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959747; x=1776564547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=XpRZ0Q/4foSNQKWLmGOM59fM2u2lTlqL0ZC/EAeP6jLZvNfMT020jRMHfmtjcPxNeD
         sK6kMC/jssKsu7mMiYs29998fGkmAv+ORFrxv964y4Ny4AZHAMUuvpl1Kh7NF3aFwfYH
         c5qQE2RI035n131RzXcqad3lK78x2/hB4CJHjV71E50ncUyE79jYIIQeN/oEznrVxKJO
         TMig4DsOnk/TAjChC1HtN8MKFF3B007ppTDWkDN60cOF5eu3yofCXJb/VIQxZnoecVx2
         BvMRgyNlP5dYeFyqpuGt0K3Ncj4hzvcSZSHSsz3EoSp9iIDcdip1LmnyJqovWB0qAZ02
         uaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959747; x=1776564547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=JBHOyv7CREohlWdJUn+UuKAcXbjifw+Hk7/4g85YBG3zZDJ9vh0Re0XLEFfDm411EB
         YH4QTU2X4Y2ih98+vTmzpcb0Beik5515VXXsouZZV0igeL426wLkuCGhYSoMwuxPwV5c
         Eo8uAbnCHrXD0WeEnyuHFO+6/WD7iU7sYV+UtpuCFBCe23rkR5pKoOPo1fJljPJ+cijb
         3/tTXL1ZXx6FsRCbEIP8mMizQ3fvGkqb8g8HaxFM6xQbsi07TBjGfRV8r984Yf51eCnH
         AqsvncRO1r9e7WuLQvHXXb+FQFKPKAjbEukpI7Pc9/14mMfUMe5T5RU1sfyl3MNZpVqe
         74nA==
X-Forwarded-Encrypted: i=1; AFNElJ8jQV5ObIZm0G1NfaMBGGOVqgGyRwqfQk2AF4hf9DYZHhl4FIq3u0feJYXKqTSi5+dR3zv5FFNCbIXs4ip1dvqY@vger.kernel.org
X-Gm-Message-State: AOJu0YztcSc0sAkGEAymO2/DUDLnFDdq1JM/NLscMiLZ6OFUnf7noNxc
	9Sv3uBlC9Tx7eeiHnr77y9WweqetQET63GDgl284nufeADMp+LLXdgavX+/me47bSZ3OrP8e4jr
	MSIPR/cGvXA==
X-Received: from dycmz22.prod.google.com ([2002:a05:7300:ea16:b0:2cb:735c:182c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6446:b0:2c1:7afc:df06
 with SMTP id 5a478bee46e88-2d586eaa01cmr4807274eec.5.1775959747114; Sat, 11
 Apr 2026 19:09:07 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:15 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-13-irogers@google.com>
Subject: [PATCH v10 12/29] perf report: Directly use sample->evsel to avoid
 computing from sample->id
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

