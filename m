Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE116DEA6
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720820; cv=none; b=MbaNEfxHZDT4gz9zH4x7IO9pGJ5hSyLs13NGsgFrox9qhP3LxMuC5gafnJZBnRHXv9LBHhqXXGJFzIKzmVE3IcEyrjrlXWtIHXg0h5dtIvThQ8Ax41g/c7PH7gt367H3+wz2pFi+xFxXHiY4TXAxt3YkWaXJUZp1eIbJVqShhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720820; c=relaxed/simple;
	bh=LctEg2Je3fRQdJP1aZySQP64dlbQCviuGkAlqwvn5oA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Wk6DW1PttqKAV7UfRg2Q4ICjoyBH8+RYpqBqPkZ781MT0iNFaLxYAvthKEjPiqauaOJZH2Vm7fevNErfDQL5o6oQm2z/IJQtPcZ9IcmkP6j4wRbDcOztgYb7KM7YRD9LjfnPnpj97/bgNw52lftQboZRYLSkREls/uOOU0g0qPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nnfwzFT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nnfwzFT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6590a57788aso18025587b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720818; x=1721325618; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbSFIAjgELn8En/ODTzECP6YTzi/bZUaiF8JxVDqD4U=;
        b=0nnfwzFTMJA3TwWBy/o/JeiG/UXbrr7liokMprepstpUAY1Rg5RBdx7RXbyGX8ly+1
         DF/GKlpLu/P7gPWe5tCevM2lG3lw5CqOEQXbrrOCWbInlF/0oTuxfRssCxsu602tWzx1
         ECkK8tlzNSH9qK/QOTd55OdtH2TiP49vJG9f0hUh0tTF0u682h1rHALsh4b7nAtCpEJK
         QWpVvGzbFM/Wi0OwO8/K1QkXbqp4sE+ftnAftxeEAeStew+hpB5XlqsojfTa1D7F0TSl
         L01pm/ZzeJ9QhQ/a4O0PiT0srNTzpZ2sMwZm/hawkmRjMXbaok0mdFRDQNLO3v703p2+
         0vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720818; x=1721325618;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbSFIAjgELn8En/ODTzECP6YTzi/bZUaiF8JxVDqD4U=;
        b=Gzfc8ScYHzCnuriEDIL3SESB8kCwOBm27+nJFL+kMGCtdk6O8l60olyxaEDoXAw172
         FaRCtw4EPUpYXlQi8Wk46VIUcBM+Ibb0yNE/P7ZBuUhBx170Jn5Y70p9IJjB+6n7GM6i
         Z4yipFqvjMX41HohO6QlTZ0EIbB5whQTt5zwyQ4Ylbx0psMGdfnWziCo5FYlfuZ7tFWq
         BJDL2sG08NL86JVwu30x0Cbk47u9JfNmbjMLTIEaxoZQODIuWCOj+4Ed7EPeEIs9XKNZ
         gBRMZCmYU3WO3j/YMS0BSD2Clu2XkNmfuGvfCF8rk0jkiGLc9jqiK+m8zrz0cin1LAUx
         +3MA==
X-Forwarded-Encrypted: i=1; AJvYcCVd7XWjCSCt3S869IUuME21j1hphIyKkNM5OMKYwSG7YZOL8IQ7E+a693gq0eNc6ziRWY5JW5ViGyYaKwWCaRsgiaZg+7uU0d9kL8QFKIN31g==
X-Gm-Message-State: AOJu0YyR6o6dq39I25XFQzo3ZlTTrSi8cZJGwOwS2z9P/loYgX6HHSyt
	uhQnaKYcE0+QkGRz/+J5WbP7dfJtEz3zDoj06rahFN8w79lbCUbJ7xc9IL/V8KURGP3HVOE7Rv5
	Z8g7hHQ==
X-Google-Smtp-Source: AGHT+IGeXhaeoNjn7pRRBMER91nAV7MjXLe7mlhn6vY1im3CgeEvPZqQsZteJ+XWeT5joa2vWOBK1cIwB1BE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1025:b0:e03:5a51:382f with SMTP
 id 3f1490d57ef6-e041b1153f4mr804588276.8.1720720817740; Thu, 11 Jul 2024
 11:00:17 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:42 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 02/28] perf s390-cpumsf: Remove unused struct
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

struct s390_cpumsf_synth was likely cargo culted from other auxtrace
examples. It has no users, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-cpumsf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6fe478b0b61b..4ec583e511af 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -952,11 +952,6 @@ s390_cpumsf_process_event(struct perf_session *session,
 	return err;
 }
 
-struct s390_cpumsf_synth {
-	struct perf_tool cpumsf_tool;
-	struct perf_session *session;
-};
-
 static int
 s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 				   union perf_event *event __maybe_unused,
-- 
2.45.2.993.g49e7a77208-goog

