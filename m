Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F97C2BCF7
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636855; cv=none; b=Xy3+AW9novi3xJRC/LKMeIWSJPyrisp4gnm+IikaTZ3CfCF49tVtJ4DinllPfC0bLc7B3IAtZsqrDEcC97+qQt62J/c5lWzMdIlF3hPms01Px/fw/15/4XFTihH9XtRurwfsVx7dlG/pAjWxDtdYEqaNwTVLje1XWHHtHSER+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636855; c=relaxed/simple;
	bh=ZWJL2IZGB4Jyl+Jh8k0ovfzFTLaNCadDQOMYSgkyOUA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZbbozsuVA7tjXVhb0RjVvId5p1TwT7nuJySvJW5vr3ZIrFApvac4fV8OZwEoPvCdCu9C11jMKc13Xx0nlTlFDlIWpYzy0Mpc7sGUsETP8JDq5ZZFjFTF3gDW6w2mOak5qPgUMcO+rocumMsGlPUUXZ+K6KeVC1pxmE8inNohsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irtwE8JP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irtwE8JP"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0364085c67so1038273276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636852; x=1720241652; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Py2DKOjmjxOtoOnuVu083IR5IZMLkEQbnPoATbWiYI=;
        b=irtwE8JP+bTj9QW5ZNplAhm4IKPdC3t7F6ym+F+vatfxSI605cmfBWdipiyM1Z8ab9
         50pdPhEai06v0EGTaTQuMQBt1Rl1MAwASaqIDLR+PCR6WkzPcIT742+ewTHZpr9wH+bt
         p/C2+t+AZoOaErXrhXwrbg6sSGmpRYoLq3fkLkL2j4lgEs8zvEwY0Md1HMB/0W3bipWi
         FfNaJKPah/sfbOYUtZdRh0MhAcgp8uqUq1AuhYcA1pze+8hRP50i8bp6o9pQboHVBJQa
         aJk6C/FpIGdQ+CND9HR7QLDvMuFjXbw2er107wl4Ege7tJgwAKDenweZeYcR6qvvKKuK
         DnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636852; x=1720241652;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Py2DKOjmjxOtoOnuVu083IR5IZMLkEQbnPoATbWiYI=;
        b=aN84A3TRpd1H6wgiM9IPbVwc26OPRyLMAx0JTaXkg98V228qOmHu6Powo6wYmm2DLn
         TcmP32JfVDVrxCPoyG/4Mdxfa5aZPdlo8lrF/65cB7gECodpB2I+3ocAMBiVxnNkOzMX
         drsSWCEJbQ/6LaCkgxnlarBJAWHfqF/BylCveGE2vCDWBZssdWCx29LP73ATvKe5tZEl
         XGgg81CyZsRNdGID7Q36arGSnupoXcSj9UYXAd2+tOOGNxCInO1K+jaI/COhIWcAq/Co
         3jNodiK9L3RhL3kvbMbj8Uks48GuAUtun4hc8CzSntYlZygokaIPE9SXujxGSSpPj0Gw
         7/pA==
X-Forwarded-Encrypted: i=1; AJvYcCWTFLbuQvVfDHeseNI0Xvr5r0zg2dOqOjp4bgeNQ28pAysdTjDYFaGZnxqDhXGSM/vfgVHB80ste2IDDHhjucIG0pXNo2Zu/8T2gIwCUrkR8Q==
X-Gm-Message-State: AOJu0YyAtMXGAtCELHBx5wN6uXbgVfPOE4uBgIdNWdGWn6aUe/ZZ9Z4K
	yUpU6SM/cEue3Lr+2Upy2Gtdiz8ERFMdzyrwSg/NJNvYUY6ihUE7ExyUtys2/vVAM+ywjIQEoIQ
	VrP36gA==
X-Google-Smtp-Source: AGHT+IH2+W3iClgJSmJE2byX19nmxCZcdn3WNsd1JolO2htIsab6d+nKnVHk5sfOXGj6K2Gy8Ju4VzejR8iq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a25:2684:0:b0:e03:61bb:6032 with SMTP id
 3f1490d57ef6-e0361bb6162mr42020276.1.1719636852532; Fri, 28 Jun 2024 21:54:12
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:24 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 02/28] perf s390-cpumsf: Remove unused struct
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
2.45.2.803.g4e1b14247a-goog

