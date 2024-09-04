Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03684D29
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426378; cv=none; b=d9PVxy4unCpwt+U84Gj/ZKN+wfbL7oXrdRAvKzlB2bWtcOU3Oqi2Vg1NjPTJe55yT31yFYTSKmR57ilIzUAEnpaskFqP5VSvzoDfcCmN++zjmw+6edga2XJT1YtgLIB3ZcmZwFKDZnMyYB0lBphG1KLSyiePUzHBKeZq2zWTC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426378; c=relaxed/simple;
	bh=5gbFoYoAAv+z9iYcQzJxmKjtjoR9rkjq5SseKmfmyZc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VXlkK5kvk2ZRKdoDEkjnbrOqSClApKSFhMSAgnh1SbL/1g50FubK1LxZU2/YLB5ry2yKny/kqFxSxGWTdRMh7JYnoQ1Zuo2V0b5QMAh+fVF7pCwHhUcEPu/i112e7b6PEENnFvhb5dtMPY3GSuwSir+rNEicGujan9FWN15/ycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tztzv8sQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tztzv8sQ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159159528so647041276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 22:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426377; x=1726031177; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHNCvvAGAccTwrROKiH6oXmaoTXEGMqssDdptckzxqE=;
        b=tztzv8sQBQjiRA1VeX5nVNRlBSYdHFzcislanjCphEJc8wzoeLVYF1j44NZRrExz+I
         wAmrCMoogW5mgFSwA3qqy6BOVYeSe+dVutr9p2haww2z0SbBgf8rqxC/PKHVoBEdKPGV
         DamfKhaG8RpZD3aMM4Pvvy2lpSHjeMU85sK65qCR04jQFCoRPsK9UUW1z2iQzmB/sbtz
         0df3IinYmz4XU2OZwjETsoVTj4m/AUntVSbBXdafMqPBAZGxwqZobV4Nkjy1ysAPnhaI
         FiClOltYhsT+u18Lo2mlqEt8SB534/o+mXtwzejfXlNm600nXKIwRnRUOT8hhtP+iX/T
         Jfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426377; x=1726031177;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHNCvvAGAccTwrROKiH6oXmaoTXEGMqssDdptckzxqE=;
        b=OHu1EJ6FLXjJb+dOwk54pSqfQlzdR+19dEbrs8VzLx6SiJ01+L/lHToEwmkTljXm67
         3MfMflfIuZyiTcRp5X1cd0EWIUsT3oMa2Wzw0huT5vb+AVUj327I/pCthRyCy0mr+EMc
         jBKV8Otro6F6KCbuVSMhm4PlhNOVn8Vhgf/akN4N5jYzdyUmiY4BUPO8szBBSNFKrDfl
         /4+SHAvwTEuZcqt+tlrClGi3EVHmQu5AlbGhghBEkgo6MOkZjhZAsL0ELMATp5dlKGlc
         DwYs3QWzl+SDdN+evWAQIlpqHwqLlyGcIfbBBggAXjUNvsUl1vEpXs7FuYvqSme3clbE
         4Jsw==
X-Forwarded-Encrypted: i=1; AJvYcCVkTgrCJHrhGuN3RTpmC/Lj135/QhUoGyQNHQ3AQnbWLj83AnTTNXI1G78WIYqUzGwL1h33kOvgRQGgY0rxoHQa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xn4vkLfW/Ul0tUX2TKc9XNKtj0srkG/inc+7Az5HNkcM3ID7
	W8XHZDww5jvr2JV8NH9Yr8JSNQUS3ooTXRWCpbWwdxuSg1NpzWywuimxvg4/HFTq6XvkqsvCjMP
	Ep6LidA==
X-Google-Smtp-Source: AGHT+IEupBwmUm23ZC3atPykx32oeSSY4wdjHgf0pXl/xtwsMA3w4GLoNXNlyNOOpoOYurol5dpFUa5UWNpw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a25:c754:0:b0:e16:6b7e:5d81 with SMTP id
 3f1490d57ef6-e1d10adf9demr11060276.6.1725426376549; Tue, 03 Sep 2024 22:06:16
 -0700 (PDT)
Date: Tue,  3 Sep 2024 22:06:03 -0700
In-Reply-To: <20240904050606.752788-1-irogers@google.com>
Message-Id: <20240904050606.752788-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904050606.752788-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v2 3/6] perf test: Skip uprobe test if probe command isn't present
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The probe command is dependent on libelf. Skip the test if the
required probe command isn't present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 82bc774a078a..33387c329f92 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -4,6 +4,13 @@
 
 set -e
 
+# Skip if there's no probe command.
+if ! perf | grep probe
+then
+        echo "Skip: probe command isn't present"
+        exit 2
+fi
+
 # skip if there's no gcc
 if ! [ -x "$(command -v gcc)" ]; then
         echo "failed: no gcc compiler"
-- 
2.46.0.469.g59c65b2a67-goog

