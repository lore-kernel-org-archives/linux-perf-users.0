Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85140309A48
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191528; cv=none; b=s28YRJq5NE7qK9vjE7Uy5070E8EtpLJQY1fBvZT1OqXOpZlY8UFhadO9YVsZ4wB5Ah/0V+sP1DlY6P2AGoba5Av/YGcyvJcYLf7prDvyb/dBIqYcThcdOLaRfgzzKRDaSXAWrkfK/B5tnQnuM4Cf0BpMLCIPHCRXRI1LRApNKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191528; c=relaxed/simple;
	bh=gv1i3DNEGxqaAyeBCm8oJ3IImT0PmMzZRaQt45Qua7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hwoNh976ba46780CdYz/+M3CmZVpHO8hZMYsMuKyXdSd1r8fSdLdn4qlQ2/vSaxYiSaicpNObD4+8bMCV1rRbwvXzskul5IdlXf68gW7kaOeFCtODmP6UQrAkTvfPGRziIgV15bIhHeqz/n7V/817uHTpT1+w3PMPeIrfkEXwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJbawKBd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJbawKBd"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so1146679a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191527; x=1752796327; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHFbmZZJXyMo6toKRekC1Kog8DjIMtKrGBEtrtRAi4A=;
        b=AJbawKBd11qgB2xmABcsQN/zKaiEweQH6A9ZkLPB3BJHXOprZBS9tBHcLZP0b3mVKl
         DjBMVTJ/1oHlEOHItYn4FVFFqB6FDo61+6zMDCa/hxewTFhjubwzkj/FH1nHCNhVtnjl
         yQH0rnI2sm17WBZKdHFC4sTAOVlRbf3hwI1FDIn95QljZEvodH+Nhjwmqqp70oSf4e+T
         HfnbrEtVO2UfttWf6wskyBEXaG932HkMElLfJq0rD3RZTLC8bVv2DTSQhGBbJV3EMcQo
         HvLWCqWP507uyAhdnItQR8pmXEBP6QV1N8uUxvBM/NfHL+bu1gHSXHk/DHRJfdWColf3
         jLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191527; x=1752796327;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHFbmZZJXyMo6toKRekC1Kog8DjIMtKrGBEtrtRAi4A=;
        b=D72qSjKvmn1ocCZeACcLAP4LMsZoU3gudSxL+0z+6raPpWSVEKSmtTP8ykJq2TRXGr
         XQ5ycT33taj2tReeLOj8msnVkX+2USlscqbY8ZriP4o90bjEnP2TJm9Q4/U9+oS4Pm3q
         zxeSsDURZzD/mN5ikbbmNQr8TAaa9I6LjWxqJ5WTyFRiUN9V94ojRiF6GzI4bocbnRz2
         /bfhwCbA0sJz2mT+0OVqtgC/tQQPX4iv7PphJpgnstaOpNqBH5eQJpH+ZRmdxZBvzcqg
         ENfIVI0IDSQ6iAtjZD0FPuKYiBrqUltypTnwNwK1QKAl48EGF8XDxfZupA3XNunGUP9N
         zdMA==
X-Forwarded-Encrypted: i=1; AJvYcCUt2gcjyrZ+fRFcCKgCGx/MXUgelt4j+Qr/qgOyrqMIJabhEmQsMROnO2Crk57CLRQNJMNXwqVuKCuOtKCfHxDs@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0FTlRM8GKzN82bvLmlI7PEUXHgPeWuPsgbajGqSa4kwPwK2D
	dBAINK0r8+ugWxOREqjzypCe5iK2ZBGGwiYG/x5N0FZWu1Ydghd5ps5p4hFfhg3s2af2xSaWp7a
	gP8sIBCMkdg==
X-Google-Smtp-Source: AGHT+IGxVkRUBkrU23Iuy028HmTd6f1O0vsX3aB33ymJ13pw4jtm5YKvpLkoaVw9+YgZTXWB3mE1TOSYqRv0
X-Received: from pjbof7.prod.google.com ([2002:a17:90b:39c7:b0:31c:4a51:8b75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:f944:b0:31c:3c45:87c
 with SMTP id 98e67ed59e1d1-31c4f4af646mr640793a91.13.1752191526857; Thu, 10
 Jul 2025 16:52:06 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:20 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-8-irogers@google.com>
Subject: [PATCH v2 07/13] perf expr: Accumulate rather than replace in the
 context counts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics will fill in the context to have mappings from an event to a
count. When counts are added they replace existing mappings which
generally shouldn't exist with aggregation. Switch to accumulating to
better support cases where perf stat's aggregation isn't used and we
may see a counter more than once.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 6413537442aa..ca70a14c7cdf 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -166,8 +166,12 @@ int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 	data_ptr->kind = EXPR_ID_DATA__VALUE;
 
 	ret = hashmap__set(ctx->ids, id, data_ptr, &old_key, &old_data);
-	if (ret)
+	if (ret) {
 		free(data_ptr);
+	} else if (old_data) {
+		data_ptr->val.val += old_data->val.val;
+		data_ptr->val.source_count += old_data->val.source_count;
+	}
 	free(old_key);
 	free(old_data);
 	return ret;
-- 
2.50.0.727.gbf7dc18ff4-goog

