Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AF40F8D8
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962676; cv=none; b=VwZ+3b2PUSMtoWqKQajrz9WmRrK/5o1xjkdjIPOB/Md/VNWRnrTKXnyZhj5yyBUa/7Cd/5ObcOK4Sz/iRAKwB7AKYM8PxIC/s2+BfBL0e3v66iOIINdegsVkWc29rJx17XWSK+8bSVT5Ul1R0RD9WLbFvi2SPsmyLdopBfxGuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962676; c=relaxed/simple;
	bh=Px3kvXNISBtpkk8Yg/YzO2B/LDlP1VbH2wUqa3xN3DY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RDK9o/NV8UcXCwuxA2rJbWTVGV5mrNu66eiLKRb7KXKU07BsLNWkRnfgWczHa4vD+6Fd9ez/CJ7sW5LsMPz3EIdWhm5Z/45CWt6lKpm8JjeXOCYSZwEFFUACQsFTr4443Z9H2cBnnEognqqL2TyI//WGKhJrMuzFnA6e+PIuJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VuQFxI8z; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VuQFxI8z"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12776bebeb3so3354251c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962674; x=1774567474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJxIIiDIQ59GOTFf+kVAJjN1YJAohx4635ngGk36Q3M=;
        b=VuQFxI8z9RMdC5uKlVHxl/caOCYcEf29VbrLOxJd1AtwIwob1I/4BR/Wf5pUCzYbvn
         8fk9+WQa4fRFPkEMF7Nb22Cv6mdn8ZhT8nbLjxGlglDzUj+kxPfQcSVZ4S45WFsVz3RY
         I1nTGPGgD0UfM+9pQ3EFX+oOj3Fgmp+LQ4bMz4YrrX1cNBVCcwJluaML04/y06rZCcWF
         hu01IbcqWNrHiaxZXmvhfLhUzfNIkHVEokaSbUEkeAHrfVGxQ7MSUqlQq6ZJtXp+jALa
         ItS4/fbasPZXggqRpTde0KU7yAxMj0H0ZdbdmqFIT6jwIoNqNASgxIE20I4IfMzkAqyI
         oLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962674; x=1774567474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJxIIiDIQ59GOTFf+kVAJjN1YJAohx4635ngGk36Q3M=;
        b=ihlYj0rNFHVWXGVPDuunybyRUvD4x3ehu4TLbD6bmkapocfvIL7z+oEj8+QZNL7dGF
         i+DgpgKbbwDQF1P0eudFFdJVZCEcZQAwsP0eXQt9UvHOYoQ2XunbLhHJSmjzBH+K34xF
         li6pKNcnQ9QGEMNOBS9Nll83USdykL8xADQY1HR5mDXtw8COtQKx070LZpSNkVlZAO7/
         uCdhj4989OTR9e+rPkvYL1fXS/xRQvISyjCpKSon1rLOtnAKDWCUeBlAJeOS25A7aGBG
         7KErgANtg+38pSvavZczD03jjBfvPAqAPCsisxaOaKcbgH49j/otGiukCw60yaDrOabm
         ZCug==
X-Forwarded-Encrypted: i=1; AJvYcCV+nz9vgG8OqhnrLfYi4j4duXviWOz9Lu821W2wG+ewZ05kGtnIHs/vQMG8Tm6br8TOZQge2r/VlvxFU9RnEIsb@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCPW2LeZowJZUsAWtAUWaMXrnrWsmtMqKhisifXageIVFWLMt
	ZIusSKS81LYmIPIrvRDGlCIbmzCONj4/bZUuCI7dimJrH5ZYVhB01Stckv8+fq5tgxs56qFFskb
	3cnHM0g1L5Q==
X-Received: from dyff16.prod.google.com ([2002:a05:693c:8050:b0:2c0:d493:ae08])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2382:b0:2ba:8018:cc53
 with SMTP id 5a478bee46e88-2c109833e87mr664893eec.35.1773962674232; Thu, 19
 Mar 2026 16:24:34 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:24 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-16-irogers@google.com>
Subject: [PATCH v2 15/25] perf annotate: Don't pass evsel to add_sample
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
index 041f5dc92ea8..894e57aa50cd 100644
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
2.53.0.959.g497ff81fa9-goog

