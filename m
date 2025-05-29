Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F52571C5
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493624; cv=none; b=V5O+sXMDUablfJ6cMK/kbmK3LE0CJpt3cJBR9ISufuD2bFk0/YiwZ2Kesdp9R0grLeIqVu4XXwklWSRym43EcCim3x72aC0Vgx34VnEGHdNxft/GcnuXx38jPgXMqGTSyTzdC83+yr6Itt/EWNjv0QbW8gCMynh5hT22qqjxqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493624; c=relaxed/simple;
	bh=jsmqbC1vJZbprPguR7zwDCDHxB4zTIIrDoxTqEFx1LE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hIcTLkgAnS15Ttrz0tdabRIFi4GGY0TlZq7aTM6rQ4Nvtw9jkhBEpDmaH4SseCi8xyJZOxz7CWslzNte+HRl/6K3A9KzTKz8j0v0RKF3N5dYnxDeeO0UDnDY8wyd7pYTCcOi5gj6jQ9BALUoYaCOrpSzzIQnQN7WKs+kUVC56sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IKZ74dQb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKZ74dQb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-745e89b0c32so651252b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493623; x=1749098423; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JPEQx1UgA1kK0W1Kyi7k61uvOJ0V0RbXR9RGxgMDm8=;
        b=IKZ74dQbqtQhtAx25lDdHPwJTlggU2wkcLgJclnBJQ0EA3Qa2+RcHIN4Qj3Jf+AzSg
         0y0GX14mzJL8qzW8tko9HSCj1r7ZuogfSVf5EZK69MxZp0hnMaU1s4JBjPYzAY68wMmt
         5hP0SCAb3bbVTn1msWzfusUa8AX38cuxGj/p59NgplppR2DIHCmx3mc3QQLt/0P1KeYJ
         Dtn/A6shrzS6ReFS1ZJw+au002BhkRMdEqWdPK/FVVx6IViB90t7ySkhwkOOnX+T2NSL
         pRnh8NUEZnoIsjhx3sInOlrCnZiSMFHcHfapBi8lBe7Ijj1qyfzMpXBxXEupQJiCxnaj
         L0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493623; x=1749098423;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JPEQx1UgA1kK0W1Kyi7k61uvOJ0V0RbXR9RGxgMDm8=;
        b=eLQD511NHYK3BRySCpJjWs04bMwVhdMCTI+6DTZabuLHsIU+OKtauTTvwXT0CA0jJH
         VBAW1Nlu145m7aDY9v4FZftmnHy5lHiE3s3f9i/s1un7ps06v9zxxogO1q8X3rjPBw8h
         Dnn++cuve2s0NcLOTrFrY59i9ffY4HjLnGXwzMlbmCzn7kOqjfICapniWAfRbNvHYqXF
         WNClIF5Ireh4JV+yGE2Fn0wLIbuNzAq719xl5RT+umRZjPcAgu3mhBG6tvp/0C3uexAs
         hr/gdi0bOfh5wWVYnSIz+ih5bBcTEDVDlwmPJ9sOzxfXL4A4xXMtGSj2gnzimuQq+5iI
         9czA==
X-Forwarded-Encrypted: i=1; AJvYcCXIv73lqFbR2uovkS6Yiw4Z13P0D1cSv0i8V700fhD6DQd7hj4E4cPd2zXaHsJWfYrmd3WoW7/M49XG34oAHWUD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8BFpB39xj4X0BssYbOS8w2kHH19X/lbW38YATzaBxWKrxqwWQ
	yjCO6VuwFDxAE2k7Nrp2lu7z3+KE8SCenyk/uOoGgQ6tBTHuYTcB9Mra3TTYVrqWqGspvVCJr0d
	+7L1OS7Cz7g==
X-Google-Smtp-Source: AGHT+IFW4ud+zMcCHcIRcWhv614Og93PmqbrPfMTEVygcvH8Yldeies4S+HKGdGovs+R0RbQObY2hlDVTQ72
X-Received: from pgbcp3.prod.google.com ([2002:a05:6a02:4003:b0:b2c:4287:b413])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9984:b0:215:de13:e212
 with SMTP id adf61e73a8af0-2188c2406a3mr30902424637.15.1748493622489; Wed, 28
 May 2025 21:40:22 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:44 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-9-irogers@google.com>
Subject: [PATCH v4 08/24] perf jitdump: Directly mark the jitdump DSO
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The DSO being generated was being accessed through a thread's maps,
this is unnecessary as the dso can just be directly found. This avoids
problems with passing a NULL evsel which may be inspected to determine
properties of a callchain when using the buildid DSO marking code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jitdump.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 624964f01b5f..b062b1f234b6 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -14,9 +14,9 @@
 #include <sys/mman.h>
 #include <linux/stringify.h>
 
-#include "build-id.h"
 #include "event.h"
 #include "debug.h"
+#include "dso.h"
 #include "evlist.h"
 #include "namespaces.h"
 #include "symbol.h"
@@ -531,9 +531,22 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	/*
 	 * mark dso as use to generate buildid in the header
 	 */
-	if (!ret)
-		build_id__mark_dso_hit(tool, event, &sample, NULL, jd->machine);
-
+	if (!ret) {
+		struct dso_id dso_id = {
+			{
+				.maj = event->mmap2.maj,
+				.min = event->mmap2.min,
+				.ino = event->mmap2.ino,
+				.ino_generation = event->mmap2.ino_generation,
+			},
+			.mmap2_valid = true,
+			.mmap2_ino_generation_valid = true,
+		};
+		struct dso *dso = machine__findnew_dso_id(jd->machine, filename, &dso_id);
+
+		if (dso)
+			dso__set_hit(dso);
+	}
 out:
 	perf_sample__exit(&sample);
 	free(event);
-- 
2.49.0.1204.g71687c7c1d-goog

