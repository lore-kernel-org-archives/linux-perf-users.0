Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02962E06EF
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794314; cv=none; b=LGBodMYvIB9Z/ZbqMfpF9SbBgc6GorGEThdLhqIeifnvad0d3t4q1rYHu1rGwmuiWkUo51OBOSaZBHw6coM44hEuAqo3MRdjFE7mYAue+ILQCn/Pd0uV0RiSw0QwYSIUKB3OX3srSOiaUzic24vHyalI4ffKAGGIB042sA0fmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794314; c=relaxed/simple;
	bh=eyA829iLXKDV2aXN/zMNIAyNupu1EE+3JDyACL8MmxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nfsUAlmq/ZcK1EWo/NlzA8GdyeMiqDVa4LRXD36RdldaXArbdAMVnqTG/pkM654XEcIakYzeC3uNGGCKDs78XifqPSwZvrPfWz1mvCS/th0SNg5E5iJMjxs54Lbyc/NUB7AbauGDpvs65MhSN+dIK5RsnnrP+Wo8bhk6XYfkrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYLRkxMi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYLRkxMi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806eab4so14450335ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794312; x=1756399112; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzxYkTMP6IjvFIINqgjg2uV8ks/7NGouvlIDUbYRfdg=;
        b=pYLRkxMiuNnaubXwwWYnth9NbT/d1s9oNEmb1qokkQQY+bhZGdM69/p0XtFQOpcydh
         Ows8UEFpDc8TujZdSyRY7pivo5GCF/NO3FSKo9ChGw4eXirXCwDuby0HxhPslTOTsjs5
         enOmaTheMHMdXCrOUF3Cmrs0/Pqwmrm+2wVS3RjB2GptyqUwJ2ZZ18WF7RN0rBnUYfM9
         /TyBhnwdePFCKRVGK+MhAb1TBjV/L2Zqg/L2pZ1Nd816cR68aU7ycFhzEK58304jbESp
         jgbNX+p8ZikHcVYC8SLlatBiz8ij7BFAGehYd95vxjTqLE24q6m+42R8/H60iFCF9VC2
         3e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794312; x=1756399112;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzxYkTMP6IjvFIINqgjg2uV8ks/7NGouvlIDUbYRfdg=;
        b=Yivd9vmzO2aQlQ4wVMshQfQO/UiHAGzJc5wahWc8qzALXdN9tOOAfXeALAiA7YpXuP
         3R2xE3tjcM1chMTrb2FsLMXJxr4MS0MkpGCwl6lifG/YhS12g1UUG+02BXpXt1pVL9Dz
         Fs8xUpWHgl8LHeqpKmoe3axXiPyC5j0sQhEXo5d4qz/LVZ2gOfp9CWRqtpAKlMtmCEkG
         Mgx0ipDyNId7Kp2NQXwx5+G8BRUp0+SqZGQmaarPAALlrWmxZkKrvia3r3O2DzbmAkDw
         C6jOl/qjMUBmfKO/L1NEDzcs+/5GtLjwOTIe8ufKt6qyREdhf9AY22fyYlO+2YBhEO4J
         6+vw==
X-Forwarded-Encrypted: i=1; AJvYcCVFrXl8HxnM0VNY9zMkNFjFn26EV4cI1xL8w1KLPfIbfqd3PhwjZqi2tbO08URZw8y1kkMDaDYmGnHrhZ7/rea6@vger.kernel.org
X-Gm-Message-State: AOJu0YwbJDJx6rXduH92E8IFCvCl7UhfnkHpv2NdlwnnmzgSGAQrLAI/
	5zHk474tuygLLb/YlQj0LjUapnu0KKab8rX6n3sk7PzLD68w3SR4M0MGu7I/sYIlndSNli35akk
	wf3upjV8fyA==
X-Google-Smtp-Source: AGHT+IFuEyc/k68SiPnvKZHreOAHcRO5VQTmY+lSWGvRBKsZHoGobugZ/jQ8sxPqHUjGsGhHdE3Org0x44xq
X-Received: from plxm13.prod.google.com ([2002:a17:902:db0d:b0:246:17d2:ab51])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0a:b0:242:c66f:9f87
 with SMTP id d9443c01a7336-245ff87a0acmr33871625ad.51.1755794312333; Thu, 21
 Aug 2025 09:38:32 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:16 -0700
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821163820.1132977-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-3-irogers@google.com>
Subject: [PATCH v2 2/5] perf test trace_btf_enum: Skip if permissions are insufficient
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Blake Jones <blakejones@google.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Modify test behavior to skip if BPF calls fail with "Operation not
permitted".

Fixes: d66763fed30f ("perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 572001d75d78..03e9f680a4a6 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -23,6 +23,14 @@ check_vmlinux() {
   fi
 }
 
+check_permissions() {
+  if perf trace -e $syscall $TESTPROG 2>&1 | grep -q "Operation not permitted"
+  then
+    echo "trace+enum test [Skipped permissions]"
+    err=2
+  fi
+}
+
 trace_landlock() {
   echo "Tracing syscall ${syscall}"
 
@@ -56,6 +64,9 @@ trace_non_syscall() {
 }
 
 check_vmlinux
+if [ $err = 0 ]; then
+  check_permissions
+fi
 
 if [ $err = 0 ]; then
   trace_landlock
-- 
2.51.0.rc1.193.gad69d77794-goog

