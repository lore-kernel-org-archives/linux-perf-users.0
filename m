Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE823ACEE3
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192956; cv=none; b=nOcpEZEDpw4HHkRzPZroEOS3jqI1VjgYzKkQK1LOTbq+YUNtcljjNSstjqWEe6cF1SzV0goIXqSppm6uGNg97eoZTqB7DYoS6OKgFdjucAwD4HqcwdGGG/2aTkOieUvyaZGHAm/9vJhDtW2JTq5NZ2O9cASu0TrgonK0x8nKSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192956; c=relaxed/simple;
	bh=KlYhtie9kRYganFnx4be6fvUdEBiWcUOg5zv9BCX9d4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYCrB2rfBYgIbSKMqteyOnzuZpB5fQt0lhd/521rQbnIvsRkuBBJLL/gw2LrlAwS+o4Z8rVS7hZhwgMbIT7VSl945R/tGvZ9bDLoeO0L1/H9SP4rKrBq2ZZwvgtNhuBCVrlSiiVSGsqd0mmLXxpRp9Xb/971tP9EM35OjGCaYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ey0tOHxD; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ey0tOHxD"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137fc6f8e9fso5746053c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192954; x=1782797754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wbFMxKxHyf7RmGfuzIAI5gMAzOQzZ5Jp1NThLEoyVo=;
        b=ey0tOHxDiIciHGZ++ASDNnyEMllfaM1S199wprkKD+GtbHx1/scXDH1Yr3H+RXpxyX
         wKB3Mb4jGsd7zDVTMdt7f23e8O+EO64FI5Bfy72W7hgSa7+SYFe0RnTaeau/SFz4vS0l
         cp7Qu5n2znvACOPuKqbLYTS6/UkOZ2nyzK64utJF8uWSZLdcb94RcePDivBWEHg602OA
         rNLSECgKuuq5ejk2r9kpm7B4ks2avpPdS5t3zFa8oWosVEHjNfH4qRNYrRz0+0uTA/Pl
         NFVIFLTvcQWopAzYLfxAazvxAbNyDvkAKoCPX71F78LF87rTBBOsMdcIKE6kBlG12RBD
         1KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192954; x=1782797754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wbFMxKxHyf7RmGfuzIAI5gMAzOQzZ5Jp1NThLEoyVo=;
        b=amVgC5Ko51eON6v/RBgUk7ZFcVasBLecMg5udqXUU4sZEHgSErAB3MhfxqcK5dytHt
         OMn+3Ec/Gy7CzavO/svPtkTb3z02kZfJYl6a+sobAjtPbRkkbVRODsu9IjEKH7KYVBl+
         Zpu2p2Yv3cKL0Ny3MRHgDgSAT8cEzwP8ZKx5R2AzoO8uAr8yJgQ8Yx2WCA0sOXvai+Fg
         c4l+oMJW1Lr5aGWKO9gWSA7MUnEpq4eWwfRzNJAGanEL6wBiEcXhADkiUMb0MJ0HE2A0
         KH1nPRjxl4SHqEBE8Cg4PYW2HptTffsjRz5slsuGmcceesD48RtHm0uMCLY1raJnF1l+
         lREQ==
X-Forwarded-Encrypted: i=1; AFNElJ+BMekz/55adl8XgF/CZkWQyxQdl8kRi6I/POmQyaVTXjglcB9Ll9pIuzEAZjUYJYMyga+1OpPHetkLuiQekKI0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8GGauyQ+sqyXYxt3zZBne7wtRiuhX8YBVCqCGx7b0HDOdkbJ
	HvPUzUO1Lq3niHZYfewkr35MDExQ3PpY1SZBLOqQlOblSp9JNw7s8dxLmsLs+M04475DprNd7+h
	Krzp1gWhunQ==
X-Received: from dleb4-n1.prod.google.com ([2002:a05:701b:4244:10b0:139:b9a8:f222])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e13:b0:137:edc4:a5e6
 with SMTP id a92af1059eb24-139a367d1aemr11179305c88.29.1782192954181; Mon, 22
 Jun 2026 22:35:54 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:13 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-12-irogers@google.com>
Subject: [PATCH v1 11/13] perf python: Zero initialize perf_data in pyrf_data__init
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace path clearing with memset so the entire struct is zeroed,
preventing uninitialized fields from causing errors later.

Fixes: 4cd0142f7dec ("perf python: Add wrapper for perf_data file abstraction")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e277c89b8347..03b4e8809107 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3607,7 +3607,7 @@ static int pyrf_data__init(struct pyrf_data *pdata, PyObject *args, PyObject *kw
 	if (pdata->data.open)
 		perf_data__close(&pdata->data);
 	free((char *)pdata->data.path);
-	pdata->data.path = NULL;
+	memset(&pdata->data, 0, sizeof(pdata->data));
 
 	if (fd != -1) {
 		struct stat st;
-- 
2.55.0.rc0.786.g65d90a0328-goog

