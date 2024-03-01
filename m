Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73C69972
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279226; cv=none; b=KaN234ZfjBZl/ElBq+X2ZtB+ijHyooovVCeMSMWbXTqg3OT/TucdLy9e7zymFzBK2NLwGQ9T+AqeyUhP2okrKTOG4DW7LERCGX443k7GR9R9VeER4O2wWClBH+DRVF5mFiaUuYw6C4s/DiiZ18xqfdJ5T6/ZINKdlcjJpFEv3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279226; c=relaxed/simple;
	bh=VOm7IPIBVo5PZ4RqJQ+la336Qu+bZ3B28KGc7lbQY1c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k6E+JbUBzTNXwWfANvzhKQoscXMyFAsjY60rPkW11hzbWxsaRAChEMHcXJnWMr+nL3N2qRmcxR7wI2Rh75UInpZNxuYqO5rs819hXUDdadrs6GicLVjHAxJZP8/BGt4e88Ec2J2UJ+fWhctWjxdq2ELVa8Zv+cBBK+tD24NuDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0FlNYgO2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0FlNYgO2"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso38366497b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 23:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709279224; x=1709884024; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Hog9+5whTjGin5G0M4AR3EFSxPaJm96RaOiuDoEPKc=;
        b=0FlNYgO2kqOhGSyfpAQQBJL1dd7rKBTXhz3pINcsFfaMqmJcqnTG38B6jaOJlZXlQY
         WlsuBT/nNTGPGC//5tqc4rpTUVLgYs4rpPPNsIzpypx8lnlebYPINeUbAMKDXKQ29chz
         LmHhrF1YPf+sJ4JZiSSvs1CnCaeR+eszxK/wEI/buDluavltGj5Zp0Ht9VOag+wmoP5l
         VDoLtK/uit8Qwl7HUGHYZa0xIVsnJ23fCW6CxulTSv6DVMQdI+l5fAmJTaQz5xPSYsXV
         NstLWqmsKtuX1zhq9l/EYAI9DC1uZmnzCfFvv/fUdPRFx4qfsdp+2pFqqs9yh4+jcOSO
         oIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279224; x=1709884024;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Hog9+5whTjGin5G0M4AR3EFSxPaJm96RaOiuDoEPKc=;
        b=gWMEM8rwSdrfdyisvoBCtGzCHVSV3gs6nFtVxu8sA//FWcjd/aoRrVQxhLr7jH7ojQ
         E+ndR3nUqZfJHfOHS6NQbdPKjpiLFTBcMQmfS+mPUGKhaA/tfVmrxPFM0WJuETjTyGub
         cRwbOYgCeZ9wAHqP1ObLBEdxh3QrHpX7qqncEr2OG5MoAZRYo9bs3nxqM7HLeXj2ZY9Y
         T2IpzeHELfWUxytngkZmX4u34oNInTujFMCaa4rRAFCqTyKGeINqonjTjbZuskIrgqt6
         hd0191gHD1kX3uHESRjAl8ILVAZR05LbbCfxGOihzbIqkwRmd+qGhYAbb21Pw2A2/r81
         asJw==
X-Forwarded-Encrypted: i=1; AJvYcCWXlyB9c+Vd9Hjb3PHP9Bj9U4/TZtoPpnQ2c7SOn6lumpWna+jtncSzm9uM90iXGtkWpyPGgmNPGlbMr+Dv+JYNM31wBKhhtYmlhIbd66CPaA==
X-Gm-Message-State: AOJu0Yy31LhPwvoTSbLg/gtou9h/5EiO1sjlX1CP41HGZAUl1fGc2e2T
	h7D2+65R5+WCM6lZ641mVKJhL2zmbfQXPZtcdKPBkhMjFxTamEEctzZsi+zbAJumd7P7KKGvQxi
	A0DWRqg==
X-Google-Smtp-Source: AGHT+IHKnx/facVcMyKr/hM0f0jmf4jq5UVVg3iquQ7IDVrMzo2HlC4fnlqQ5hwy6KtgmHf4sM/6I4lkCclf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1249:b0:dc7:7655:46ce with SMTP
 id t9-20020a056902124900b00dc7765546cemr280153ybu.2.1709279223896; Thu, 29
 Feb 2024 23:47:03 -0800 (PST)
Date: Thu, 29 Feb 2024 23:46:37 -0800
In-Reply-To: <20240301074639.2260708-1-irogers@google.com>
Message-Id: <20240301074639.2260708-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301074639.2260708-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 2/4] perf test: stat output per thread of just the parent process
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Brauner <brauner@kernel.org>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Disha Goel <disgoel@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Per-thread mode requires either system-wide (-a), a pid (-p) or a tid
(-t). The stat output tests were using system-wide mode but this is
racy when threads are starting and exiting - something that happens a
lot when running the tests in parallel (perf test -p). Avoid the race
conditions by using pid mode with the pid of the parent process.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/stat_output.sh  | 2 +-
 tools/perf/tests/shell/stat+json_output.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index c81d6a9f7983..9a176ceae4a3 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -79,7 +79,7 @@ check_per_thread()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat --per-thread -a $2 true
+	perf stat --per-thread -p $$ $2 true
 	commachecker --per-thread
 	echo "[Success]"
 }
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 2b9c6212dffc..6b630d33c328 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -105,7 +105,7 @@ check_per_thread()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-thread -a -o "${stat_output}" true
+	perf stat -j --per-thread -p $$ -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-thread --file "${stat_output}"
 	echo "[Success]"
 }
-- 
2.44.0.278.ge034bb2e1d-goog

