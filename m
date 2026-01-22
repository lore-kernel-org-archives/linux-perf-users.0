Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D5318EF7
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117737; cv=none; b=SiUEibLGLQ0TCAdzrxkL59etlAGOqg+lhtIOLB/B84NlxuVxYWB5e7qGAYtXGHlPQGoxVk4DfivB+BsZICbUAuCUCMdl9iSutdiCINstbGyyJD7plRuk7DDUykbx/GkQSHjJ48MF887NBl/DBWgNi2RH8HYwYYItjTi9wLN+Ano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117737; c=relaxed/simple;
	bh=U3CxrbAAlN8gTA3wMaXLOq+KQ2KCxALBwEtyEmQVEng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IgteoOaCWT9dnlKllHABYlDSlV4Ma5FRaNUUhKhXSRujeTxXmn+bVeB4JdUCSI8DHaxdg3Oj0b6Pjqf/XA4I0OJM5GzQewTrSxM6/oYJEB1LODItTwxG47LLOVbnrPlS8XYq90ARJ4XYkEX/YAF4sm3JPp6OaRZKLDx9AMX4WU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yANl44qH; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yANl44qH"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12338749ea9so2028349c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 13:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769117725; x=1769722525; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zalmwLrK8cPj7cYoTUj/KkGE6/xfnap/Tev3VqTduZw=;
        b=yANl44qHNJ1er8muLcjEqtLhDdjFZ0Qq8NLCQ4MOZqLvuO2YBZDcaI34QXWTR80iLA
         JwK6cpBb4R/wsWd3ylbjM9lKcr20sjCnh01segm7L/GqGTekZleJ4PR8gclcqE5u57Vy
         J+j/tES/8RgQ6oVhmPeRIPX//WQoe8omlk5s0ODlTw/1AMOXa7hDUhlTYIWqEuZ2mcpi
         PxtrAdYIcBECIn3cMxBL71wtXrc6CsunxX744SQpdUQVW/5uVaYavUJRjsGL7lK4NBH8
         Ah+jCZuxoTc55Lv5Ojfmo3Tlk6kO4d1n3KjrddLnurV8zZVOipmO4BNuw6Mg1qucDPlA
         GwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769117725; x=1769722525;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zalmwLrK8cPj7cYoTUj/KkGE6/xfnap/Tev3VqTduZw=;
        b=aPGeF9Lg4pX1kJzOi7+v3O+M3C7wK6z13sxXnEF+n/AnXgsI0N+pX8nDKQ2x12nRQe
         6v+lwdvRYhGaPykde1YdPYNlrQYbvzOADrXumgO66HIVr9OVf4qnqocrOGqw7OqLZLMs
         wev3ofBjMFknl+g9bd5Nen+OVks8o0RxuujbugQWiLUlIMPxYvoRh7wS6oi6wsLdPsxe
         x+8P8bXm3i9Y/lpb/uYP/FYbfdKhD23xLCm1Q0BMwCsYW+aEIQWaB8rxIiCGpuFkbNJA
         /Kwz5HiQ5LxP0W0jNA5TuvWVn2nFP9FAnHAPLtlbTrBkAtirlSPxT4Nm8uJsl9usDzWD
         QtXg==
X-Forwarded-Encrypted: i=1; AJvYcCXey/Bxvwrcy09k7Fz8U3jVQGKC/4BbWs/9PRaYd0l5cUiV0N/AZcW6aVbIr/7BIIZ6d/wTAOsPD/5wUH5Qo9FB@vger.kernel.org
X-Gm-Message-State: AOJu0YwSw+VxXsVmMhABK06DFtPId94/zgFQHfqYu9sWN6zpWaWp2mVA
	u4tLnnapu0+Fhu+dYVq2lQ/URuUjuzVeruid1s7WfZEzL16gB3jk4Fse5/UT0BUl9DxeEDFMJbq
	mXlFcPxqwfw==
X-Received: from dlii17.prod.google.com ([2002:a05:7022:4191:b0:11d:cd2a:4c1b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2397:b0:119:e56b:91ea
 with SMTP id a92af1059eb24-1247dbf80ecmr276440c88.27.1769117724953; Thu, 22
 Jan 2026 13:35:24 -0800 (PST)
Date: Thu, 22 Jan 2026 13:35:05 -0800
In-Reply-To: <20260122213516.671089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122213516.671089-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122213516.671089-2-irogers@google.com>
Subject: [PATCH v3 01/12] perf header: Fix memory leaks in process_cpu_domain_info
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

