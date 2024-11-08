Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABF1A9B4D
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091678; cv=none; b=snvhFygQDTTTOwZl6ZUgbIKPZAPUZ7ugffJmkVVko+SqRqD/dJxqLLVRZC/UTyA6UFAvOpVcPUBT3StnDvTRsCFmGSRX5EZ0uleL/nJKrIdGsRWA5Ti0BsnzqM+RkY3QF2YaKjXVqN0POWdoALWNKubc0ULMCOJm6CbLTQWnFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091678; c=relaxed/simple;
	bh=dniWuxuylHQooe/+O9kS+u+5yRkbVYD7nCVtuNvJa6Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NSL6VsixMaXd6eRPPKFkWNm+d34Qkc1LZljvTvJEYzIMnVbVkmKFRKafOoN5c5DGSL1DXVGXn1mdgtvugao0GM26egqrVSj+7wlu40S2eMVLWp9tJdtBzJD6rd5j2UMMOnNmsF4QxnbOyJ7PSg9fgSiazPhhsuTFA3xlxCRV2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i3rzw5I9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3rzw5I9"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea82a5480fso48459527b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 10:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091676; x=1731696476; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfQP4ZowKoUcMreOGn+KjRxwFgZW88CzOPZZCNSZnMI=;
        b=i3rzw5I9cOgZzJf6jVId1Gi8pFfonDCIq1su10GHG0s8xAKzocyZfJMNgGUvAbBJLs
         8ONnvl8yPjVLcQ2t8/BzbJ/fWQan+vb3mdmozzqLpqzQEnDVtY8Et9mALAlp0wjvo7V9
         1cjtSuHUZD+USaqI9Fv4A30OS4kXdgbyTbGowTWINi9goEhNXI5fwLCB8S6l6oYP11x5
         phzty9neXDeZSQano7HWZTjGTzMSsRDZ2UXKNjcgTkSrbqxQakmXmj2X5NQ2arya99m+
         WPQqX+YRm7OsQlyDYvAHowT3Q036ytjXY1yF0GHdsKWK2D4cdNdJXv8uaNaEMnWcREX2
         yGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091676; x=1731696476;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfQP4ZowKoUcMreOGn+KjRxwFgZW88CzOPZZCNSZnMI=;
        b=fsIWauE321qUhtgxdFVC0cqcqi4Zb4XwjyGZoOXv3vAmZAJBpBokxIEgBOFiH0Bua6
         Kum88vENrsITIXUr1g25tCTP6ltozRfrrJk3qTO4AU1aR5HyBKnHmrZJjdnApFExzYpS
         EW87Czp/BcreI5x0CFj+3HL8lwWagHzLBKXtqS+C+SbAbymep9NfcFT2TppIl50M+7PO
         kaH/HjhQRlhQR69QVdn5Sn+vmbh0AIWIWpTF1DC4ub1JRbep7tMv8tVH5c+9kNDQV509
         oRrq2wznmlJU6eWWzYm3LL9a5mPgu0SRUETA8Vkc6N/ZRAEMDlfXoGDbp7CdHwlOyniF
         XKCg==
X-Forwarded-Encrypted: i=1; AJvYcCVsBVmlAc6SVJ2fLvwi1Km7NyvNYSzX0KDc76jNAdoxSo3GbyyOk+xv1bLClnej2YsZPgSFbrWREwG4c/iKRf+F@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjnVNQPjWiov6GwJXq58o1/0UzZJ3CRBsJNOrIZAapT8xxYwQ
	tjk9J6ON1ykuEvhKy2wrEy6FHL9joJ1nj1jbQpjw3e7wt4mSZvbJx1dxIk9m26l2Hj+MknvSZH4
	GmfTh1Q==
X-Google-Smtp-Source: AGHT+IHSUecJfqyP6yo6pYHHwXlmFb3TtyJAgM28FJPeh82MRvOLqxptoEEBE92c8/yyBMaC2YcowXN+ItIJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP id
 3f1490d57ef6-e337f8ed8bbmr2368276.6.1731091676429; Fri, 08 Nov 2024 10:47:56
 -0800 (PST)
Date: Fri,  8 Nov 2024 10:47:46 -0800
In-Reply-To: <20241108184751.359237-1-irogers@google.com>
Message-Id: <20241108184751.359237-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 1/6] tool api fs: Correctly encode errno for read/write
 open failures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Switch from returning -1 to -errno so that callers can determine types
of failure.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 337fde770e45..edec23406dbc 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -296,7 +296,7 @@ int filename__read_int(const char *filename, int *value)
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = atoi(line);
@@ -314,7 +314,7 @@ static int filename__read_ull_base(const char *filename,
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = strtoull(line, NULL, base);
@@ -372,7 +372,7 @@ int filename__write_int(const char *filename, int value)
 	char buf[64];
 
 	if (fd < 0)
-		return err;
+		return -errno;
 
 	sprintf(buf, "%d", value);
 	if (write(fd, buf, sizeof(buf)) == sizeof(buf))
-- 
2.47.0.277.g8800431eea-goog

