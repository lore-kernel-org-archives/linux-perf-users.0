Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315281FF039
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026405; cv=none; b=SMfDQMJw3EvfQeVqtKN0IYyUxgLH0Sz61p6Y8ZKDfblBivh55/U2So6w9LGjwV9mGZ/qCM4RqcWmDaqy5hE3cTxuREi4MJqG3QPPX/a2mUnUUb7L8KwojJwgFdkWvKRfqUPPGS21TURu+M3m065FTfbQnREQ7h63HpOWRnCyfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026405; c=relaxed/simple;
	bh=+SQm6ToLAWNpvrKCrPvkCkWCwHhZuo/XlKSY+rp30bA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LYRiSHC37jbvOAZFrpmuO2g6vraZBO2ri3NEAgr0CFytSbHggIOUzP6yrU61z9X6NJCiJD5WCNjCezkGhrjbIpNQiq2uaIFtflAmCoXEIzy4aYFKpx5afAaxi6aNI1jpLxfLnpYC3598jHiZHnhmfPwknxOIJsVvyuhHBZPXwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+WhKirv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+WhKirv"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2954ada861so3701092276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729026403; x=1729631203; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRKQqH4Tzsyn1CLHPprrZshwHHnu4oMEFPacs+PDqiY=;
        b=Y+WhKirvLRpan+9onwEFGxBteaSSnBrRpnd3EQxwUDJLeUFAbgqe0gZHLCPoMyIxPO
         VU/sWAFA++lO6G9f+BbTaV4nR4q4DJiucn+k6IuSokZpr4O27Cy54ExAsHE1qCBw4Yrr
         mZ+m09c7veyNoVS92J+vIvU1UoCVhbZGTTmo70sy5V3CMLZeg6bOAJEVUOpCbm1YynKU
         8MbYItU6kycRJkI2Vj6N/q3Kt/Uzw/NUC/88GlWye2d6ptpUg6fctFyZqMdWd1OvzhUb
         eXRMw77FJhW6yZxpBa2JGFNWQP+o+KJ8lTjQhPaxdlrXFbnbLlkcKJdG6bz662lLFiTy
         OBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026403; x=1729631203;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRKQqH4Tzsyn1CLHPprrZshwHHnu4oMEFPacs+PDqiY=;
        b=jltD8vYDy06vFLYaKX5utyzQrNCjlfiqwfFgp41RiVU95tZE38m7i4wmjhHdI1bIbO
         ovbxqOq8a/2Yd1K+quzbAOkuWFEUVRDlch4pMlAwT0GVMdxU/7cRTA5zBefg6QnzJ8vH
         gQb61Um0gvKPWNKBhdLoUiwv3bglFbKnp/4RN9QanmWX2zEh0upxYwn5luXg8YyrbaO9
         YvQgGpmm8WN95at7hH2Uaw94xj35LDZa/Nz2/u2Shi8Zzg/wAu3R/bl8jpidJCMUHdW9
         vNP+IX3pPYB9UCstPsbuI+sPGig6tzSptG7Se5j8lydklZ6A+J8e+AzXs8uXV6ZvMHPG
         eMKw==
X-Forwarded-Encrypted: i=1; AJvYcCX/NtXcr/0cA3YMZaEFhQ/mFhLLaTR9ibk9yiXA7do3/ominrIqZ/kZC5B9ocP6hULBBlKfi0jIBjf980havyGH@vger.kernel.org
X-Gm-Message-State: AOJu0YwctEj1N5wzo47B2yNJxQV9zJo5PmL/ZwRSUn5U75bet1iB473e
	Cy9vXqHI1sF9m+lJ/Zo1tqVywR9ZpGXRKXxYkCn5WX+A9NghEfhwxvgpKr1D6B7RkuOxridYbVV
	eyejXNg==
X-Google-Smtp-Source: AGHT+IED+Vp1JVzDA8jd99+Eah7CILHxbTgCUnpTT9+NNJfG5lamnYAH4xlDurRkKmIkkbuifualo82lAQFu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a25:9e0a:0:b0:e29:7454:a4dd with SMTP id
 3f1490d57ef6-e29782db2aemr1382276.4.1729026403091; Tue, 15 Oct 2024 14:06:43
 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:06:28 -0700
In-Reply-To: <20241015210629.1150428-1-irogers@google.com>
Message-Id: <20241015210629.1150428-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015210629.1150428-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v4 5/5] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14621f39b375..d0c65fad419a 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -243,6 +243,21 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
+TOOL/HWMON EVENTS
+-----------------
+
+Some events don't have an associated PMU instead reading values
+available to software without perf_event_open. As these events don't
+support sampling they can only really be read by tools like perf stat.
+
+Tool events provide times and certain system parameters. Examples
+include duration_time, user_time, system_time and num_cpus_online.
+
+Hwmon events provide easy access to hwmon sysfs data typically in
+/sys/class/hwmon. This information includes temperatures, fan speeds
+and energy usage.
+
+
 TRACING
 -------
 
-- 
2.47.0.rc1.288.g06298d1525-goog

