Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEF937649A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100868; cv=none; b=ZGzM6Cf9NIRRftAj7VKgVC39B4MDj4IWrG3vVsQi4XGOr3dsp9gsVOtYLUqAVxmegboNmDZRuJjcRnsuZt5Ey9NDnDDAzzQLIQFtyg4/QNYpRTkIQ4KmdO260SHg/8YaqGv0ggSuw/DapICT0MnsMPaQ4AeZ+uionW6YOsMEl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100868; c=relaxed/simple;
	bh=U3CxrbAAlN8gTA3wMaXLOq+KQ2KCxALBwEtyEmQVEng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RTT1gqYWLUmdyxrYkKUCaCdN7senwyJMflKiaFUARQ3sURb4FK0xbZC2BV1OzpKsNi7o4Q9K7A9CY7kFZmRsVrLYRrGdg+RF+cwX5ugfBtYVWKHm74r0TXxuZm71WwRnTc6r+J3Gm5F5Xs5FE7rKf6TZjdpzZLeqnQTMZdofPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEImuKVd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEImuKVd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b7155ca88cso921462eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100856; x=1769705656; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zalmwLrK8cPj7cYoTUj/KkGE6/xfnap/Tev3VqTduZw=;
        b=oEImuKVdED36izjuwCT+ZZuLoE4ZtXRodRbC7Z5dfZhJO/A3UO/nxuoeLZmrvPq1n4
         UwUaOVfvYxuqxx/060C3wvyLW/AATEEx3HJwYmkZFlDVpCiUDp+6xMoCImKS/mZEkxuO
         58ZeIRXe83rbDmu0afEZGyIGIEnjUEAZFFInRRvK9XUCWoDBVbd/2BELtkrJbSffcvwm
         ojBHUKbVvZHtrPJJchO5hiydHyxNpp8dQQv5aSmAaGtpuE2jiQ9gPoNQupSpQPgBrSD0
         1Ulbu8dnaPpfeshjO/QmVhhl6agiPifTUsS/qugjs3WW/ncDmCmZpqxGPGis7OIHrY/p
         ANaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100856; x=1769705656;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zalmwLrK8cPj7cYoTUj/KkGE6/xfnap/Tev3VqTduZw=;
        b=K14iL0qFcw5T4U57odQOkcsXUc06PT/LACPQpSSzgymcLUZfEaOfTdDKoVmf55qiel
         VSkgJMWlaH9uk9I7/HALM/gvpb1eZwWuL8jfRzArC1jYFGrKhgbws0mA4T+W0xRZ2Zai
         8gYM6m0T0hC3GatKXpeAKQcHPGWJSaPA+qK0XguIQH54hyxz8gjvxTJfTqyGomZE1bcz
         62MxCFjuAUR0tFnAV6hzOVXnh54h18fU2luIdqLKXu08CCo7zmor3z9M745qR89nyxOR
         mhpcbR0zu04LdHNVVYYmgjLaw7Zj7Zx34jXop4VCXyx7ZGGbD1CHfOzNz1WnkrdIiORz
         C7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp0VSmhlqsrh7YGxHJwKw/8eSRktG2OEEv+2RAyTByFNm7qoPzlC/TKVdS5C+V87JPMGnnpPnbiW6qyBx5Np26@vger.kernel.org
X-Gm-Message-State: AOJu0YwuC0ebKx36QWdV0BZDHdaSoT1Qz4OpewrUrQalAfXTQCx7X7fl
	1Y7WB0QKGqnB4HV8lKbZ2A36p8D0f/ZGrTG2Y7i1dl/AdfZHfnH5RocPTkzZuJnTeybHSCMyt5F
	kWKscsibHnw==
X-Received: from dlbqj5.prod.google.com ([2002:a05:7022:ec05:b0:123:2b17:f461])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4582:b0:11b:95fe:bee3
 with SMTP id a92af1059eb24-1246aabf3f6mr7269627c88.37.1769100856331; Thu, 22
 Jan 2026 08:54:16 -0800 (PST)
Date: Thu, 22 Jan 2026 08:53:56 -0800
In-Reply-To: <20260122165407.561888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122165407.561888-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122165407.561888-2-irogers@google.com>
Subject: [PATCH v2 01/12] perf header: Fix memory leaks in process_cpu_domain_info
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

do_read_string returns a string in allocated memory, for some reason
there was unused memory allocations and unnecessary strdups. Remove
these and make the "perf annotate basic tests" leak sanitizer clean.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
---
 tools/perf/util/header.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9a15dd4b7640..eefd1cd73b6a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3634,6 +3634,7 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 			if (!d_info)
 				return -1;
 
+			assert(cd_map[cpu]->domains[domain] == NULL);
 			cd_map[cpu]->domains[domain] = d_info;
 			d_info->domain = domain;
 
@@ -3642,30 +3643,20 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 				if (!dname)
 					return -1;
 
-				d_info->dname = zalloc(strlen(dname) + 1);
-				if (!d_info->dname)
-					return -1;
-
-				d_info->dname = strdup(dname);
+				d_info->dname = dname;
 			}
 
 			cpumask = do_read_string(ff);
 			if (!cpumask)
 				return -1;
 
-			d_info->cpumask = zalloc(strlen(cpumask) + 1);
-			if (!d_info->cpumask)
-				return -1;
-			d_info->cpumask = strdup(cpumask);
+			d_info->cpumask = cpumask;
 
 			cpulist = do_read_string(ff);
 			if (!cpulist)
 				return -1;
 
-			d_info->cpulist = zalloc(strlen(cpulist) + 1);
-			if (!d_info->cpulist)
-				return -1;
-			d_info->cpulist = strdup(cpulist);
+			d_info->cpulist = cpulist;
 		}
 	}
 
-- 
2.52.0.457.g6b5491de43-goog

