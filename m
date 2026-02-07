Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A3082899
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770425401; cv=none; b=N6eodzTTeH9bHmGZ8QTxsmEH29ia0Ed9a5Q5yGfC/PWahx5PEl0HllhDnQFiEkJoEJhlUnUyY9jXPx42axGNEMXbPiLKfmnxkP2WH5t9R8IS8au8XdsLAwzRB0iAWgtFFdhlxDuMm24tsLtZHMkpEX0FfMIBXNLBjjQnwnIAbcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770425401; c=relaxed/simple;
	bh=f+runZoEza7jJOLrHjcpbqFLHZsP7k33/O/E7Exxgug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDOyNqwk6S5RcNDbPsOou/kdVpM8ya7YLcm3wQRY5c+4BU9CJFWBqiujxl7ioH2PViG4p+MWqOx7Vq1lKWEFBQdtF2ZZrpceKt9X5OqiUYb6pzO9FKnt+/UtbFvzI63P1zqZKgdTBmjSBLxhR1FsoFcUIidCOeuV4gRV8tfG1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8Va4H4I; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8Va4H4I"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b7eddde359so1688370eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770425400; x=1771030200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FI58l4Db6Gvmd0p9AohQ8uhApAmdK0WUeG1k9fnDSu4=;
        b=m8Va4H4ImoOf7jWWGrJKnGIdUOgsgo76SaF0JNkRC4Tv+iDPXwRyFM3Mu79XKr+AfN
         jnUTk2TYJiXTINZDZJcjtiZJdD2npn4SnsihEx+wreGoK1OiDxApPcJ03sgJhNtC5L9J
         WILaCis9uwz0YjnF9/S5NpEBc845yHWHd2oCN2xYYLP5lclhswdkLvPFtcl27Y55WTg5
         TmP7M6qXvSsxfJqwcXEtwLsxe2BPjGemOEpc1TF/868PkJmpADwrhZD8ldGGa1oebqIi
         SaoRw4nIFsBdE6uCaGyf9Ry/iMB6n5mb47g6/kLKJ4WMiSBfSkukQ/dnoIWG1C0BnGcq
         40KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770425400; x=1771030200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FI58l4Db6Gvmd0p9AohQ8uhApAmdK0WUeG1k9fnDSu4=;
        b=uBN4gMJee8q3Dz+GwEflZ1IfACJV22dfz2BTYu43Dw7jecnzrWbMg1EX30rAadz8hj
         pFBlRDACoctEPJUfUzGAfQC8W+R+W4M+liS2lf+y6/u+SCOiVCXIsRMbNTCzoJYXWRIl
         ei4UmlT1OWl69WjjtihUsV9k5C1ciqKnP+51dCPgbdAzoTHgsaKmLxKGzVE2ca0rC2+h
         STFHXmxY300y/ZLmnt6OlERDK98/HpeB0U1eS7nvyPyNvHsyGyJKJG0Lz6LLx6cV3SO9
         9z+jLRlBtStgX0CqxH5Z2VL9E2tAVWKrPOzEVZmFtFeVFf0tXPKk4kjW2YoCLI4rZwwb
         mGjg==
X-Forwarded-Encrypted: i=1; AJvYcCUw8q3c9klKeXEN1YhQvirthOQ0SoAxEPK5urx2nNjw1gCwLH31sIAOOoPQ8CjbO0J57MpxswLJ6q2BZR/nnn6v@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7Si6X/9LSp8qellszOaSdrwyMV78XrEa0mPPD6evOh6hK9he
	wTSSP5IKtE8mdZyoLFFepLZ3Klsl8E3NUWNRY09HBf0xQrj41oDRf2UG8FU8I/907/QZwPu4mOb
	5dvEoaPWscA==
X-Received: from dykh9.prod.google.com ([2002:a05:7300:5709:b0:2b7:75b:cf5a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3105:b0:2b7:da62:a611
 with SMTP id 5a478bee46e88-2b856450035mr2274978eec.6.1770425400463; Fri, 06
 Feb 2026 16:50:00 -0800 (PST)
Date: Fri,  6 Feb 2026 16:49:56 -0800
In-Reply-To: <CAP-5=fXPsOuqr+4DZmscoWGr1VHHJci4jRGxbOtJyy_Mp9Oa9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXPsOuqr+4DZmscoWGr1VHHJci4jRGxbOtJyy_Mp9Oa9w@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260207004956.610458-1-irogers@google.com>
Subject: [PATCH v1] perf metricgroup: Fix metricgroup__has_metric_or_groups
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Use metricgroup__for_each_metric rather than
pmu_metrics_table__for_each_metric that combines the default metric
table with, a potentially empty, CPUID table.

Fixes: cee275edcdb1 ("perf metricgroup: Don't early exit if no CPUID table exists")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 46bf4dfeebc8..7e39d469111b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1605,9 +1605,9 @@ bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_gr
 		.metric_or_groups = metric_or_groups,
 	};
 
-	return pmu_metrics_table__for_each_metric(table,
-						  metricgroup__has_metric_or_groups_callback,
-						  &data)
+	return metricgroup__for_each_metric(table,
+					    metricgroup__has_metric_or_groups_callback,
+					    &data)
 		? true : false;
 }
 
-- 
2.53.0.239.g8d8fc8a987-goog

