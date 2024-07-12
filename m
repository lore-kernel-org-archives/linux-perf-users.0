Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480AC179675
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807946; cv=none; b=Pm9AOsqCbWW1hji/66HtqIBy3kcUwFpve6pcYD1YSLxsBF1v+bjoLuE4S9s6Y+Nv10VY/3capVR9SFVol6CgOKHUKnbB4vRIuSn8C8TrmOEexE4lcawnfVZlmJ9DAN7L8jQ09AygKRNuuy7sBJ9DhjJgDIBiFztU6YLs5Hz4yrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807946; c=relaxed/simple;
	bh=z5wXs6v0oTEwyKPVEdDTOwtt2S/GFG3uzWXLUE9bRVQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HasKXJAZXzGiiusRHW0FL/T2Hv43ltVurYh5v/rQhp42MkGs7vHHR2tqQvS7i8yKWR7wxTLfsJA6z2TobOmAg3aduoz7q6rznWkX7lBK9hM/kGzNfSdMSqrZGOQZBEvdtSnR8W7dtG5udfvssEMQltk42lsKWoDi8620F9NEIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPt0Sz3b; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPt0Sz3b"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e037c3d20a6so4128990276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807944; x=1721412744; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTWyT8gKTKays8rE64DnYrzhErijM5o6wos0PD63SLQ=;
        b=XPt0Sz3bc5GB3E1NZRuWYy8zR6ciwmI9Q7Qt3WY4w9jK9SOFVaiW5f+6Zwxtvg9L0O
         HwxiwKVfN/9tijFPK6sr48/5bjSxGLbQXCN1x2t7gXm0MvWpGkSRPn/j0X7O42awHIxu
         PPINkLzJYNTIogySjof6Fauw+Bk3t9+60BmVQ1ukI1YcYJ746nSytCxqDeL4CaC8g9H4
         nAGXzyU7kZbh0YwzKAarY90DO5W6GtWA00xiL2zynRhswoLe4ZRBwElwOwmVlUpWknCY
         QrntscG1bZXim1mvtEgwdybUQ9BfwFuxQPCUQYPM47+CGokoUeOb1ygDhtQoPhMvaE4M
         DSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807944; x=1721412744;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTWyT8gKTKays8rE64DnYrzhErijM5o6wos0PD63SLQ=;
        b=d7/7ktah0gM9SIqUd1EnYExr9OJzclM7bHhVClHvrKc6hqXMYjUmosMO8/waJS0TzD
         JAmFGCEDERph4w4a02wjinNf3jlyh8SDQRaG5G6JNb9HfC/CUP5fGUjOO4AL30sHuZ0Q
         gbmynrjgWrfjEaAf2dN2rA9HEieYlg3zI6GpISKoafLs3SewP4d6+FmKrpXviVd1v365
         ulaN51FR240SGaIM3mWzMZe6iTyRACmdHcL+amJT4/MypUyCD/+fiSbkcgIdzwAHpf8p
         4jaDfjeoDhPUcHHJ6ykgy5z/jvZrDfc42BgC8aW8E3QMIyNVhSoPoonQPUQHXNMvkKZE
         IwzA==
X-Forwarded-Encrypted: i=1; AJvYcCV/5+pTZHGKTdDtYcniKrsi/d7UEtDI23UNsYG0DXCDS27k9NQvXPOO1/PAD4JZTsR69WjNa+infjj5/RUhAs0igyS/7UXJ4szQkrh98ohkdQ==
X-Gm-Message-State: AOJu0YzmRkM5Nm27C/ZmOzNv51m2QPQz9hm+WmVnIwovv7dwHZPqfM7T
	uohPSHXLXWgmrbqEvU5Z9D9cv1iZyj4M1Oiy+OgxwWLIBnOxrrKxnm/xM/oCBXCLo8YdWvGpGPg
	bRJwbAw==
X-Google-Smtp-Source: AGHT+IFDEg4qCvDKsL+VVqYz1OMCn926w9P2XUU2yFncmeWDbh5Ial6YC4Tg3xMQVgD4UPTtY6N8u5MhM92P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:100d:b0:dfa:b47e:b99f with SMTP
 id 3f1490d57ef6-e041b0314afmr26058276.2.1720807944323; Fri, 12 Jul 2024
 11:12:24 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:47 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 06/27] perf kmem: Use perf_tool__init
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

Reduce the scope of the tool from global/static to just that of the
cmd_kmem function where the session is scoped. Use the perf_tool__init
to initialize default values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 859ff018eace..b3cbac40b8c7 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -986,15 +986,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return err;
 }
 
-static struct perf_tool perf_kmem = {
-	.sample		 = process_sample_event,
-	.comm		 = perf_event__process_comm,
-	.mmap		 = perf_event__process_mmap,
-	.mmap2		 = perf_event__process_mmap2,
-	.namespaces	 = perf_event__process_namespaces,
-	.ordered_events	 = true,
-};
-
 static double fragmentation(unsigned long n_req, unsigned long n_alloc)
 {
 	if (n_alloc == 0)
@@ -1971,6 +1962,7 @@ int cmd_kmem(int argc, const char **argv)
 		NULL
 	};
 	struct perf_session *session;
+	struct perf_tool perf_kmem;
 	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
 	int ret = perf_config(kmem_config, NULL);
 
@@ -1998,6 +1990,13 @@ int cmd_kmem(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&perf_kmem, /*ordered_events=*/true);
+	perf_kmem.sample	= process_sample_event;
+	perf_kmem.comm		= perf_event__process_comm;
+	perf_kmem.mmap		= perf_event__process_mmap;
+	perf_kmem.mmap2		= perf_event__process_mmap2;
+	perf_kmem.namespaces	= perf_event__process_namespaces;
+
 	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.993.g49e7a77208-goog

