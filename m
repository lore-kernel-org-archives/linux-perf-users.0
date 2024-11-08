Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBB1E0DC0;
	Fri,  8 Nov 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054729; cv=none; b=qzTHpQTP7FeTKLS/9k3Zz5GIbS4u1mHVZHdQ8kAvNRyXSWmJ5bkGUhRN/Th8mnK5tfDAqJXuaTHWBgXxk0BcH1dXR5LKE7VdEWL+42My4OrD2S56nev5mV7zmuORyQx6zNXY+Qp3rLgMnj9ieA/1quT7fNWPqw27g6V8xx7BA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054729; c=relaxed/simple;
	bh=3sJBkEayavAL/421qn0gT4SVknVTqUEE7ecWyEnSIrU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvQ7xFvaPInf+4+b9VTJ6M7DI2UVs3I9oS+4gy5Lmg6egl76GrbHw4FlO4WzOVd0Lm9pSi5QTxQPwCOIoIDR4czcMxT6And/F+5Vlj/0sNIQZbrDpMId4YPXVpuT95h3ReN66/A+K44wFVQz6q3IPz7XtWEUMji5GWH96AeVG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rXBKJ/RC; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rXBKJ/RC"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A87x3Tg006360;
	Fri, 8 Nov 2024 09:31:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=g5vbFCIwc88VwLAO+iZ3xE
	3NYbiL6yyK4IunucNImMc=; b=rXBKJ/RCfmEIc24dq4R+1o9ylg43unllI8IhAC
	67NMl4wSwwQSc9jCJo6F9izUwPmBp2+lglkcFigzKsN9gL5JJeEc5rVkeTwm7jEh
	tVjUmAJEDUPskBFrmmGFPDmVDrly0E7sIPVI6faSm9/2qbCBZKxzM6hIGBo/FD9p
	fdioELXwzz/XuirYL7yjpj39KmSvwOUFFou6NSXaG7eOZHe279cE9lJmBo7TBPZR
	K4I4vqhsAGJBzrhY90TbVFfWO2uYgB7pWdLaKPWfoM813VsvGXTmVaxllfYSPF6v
	WNvcFySv6+ezc9Fcgd/tZy/H7S/PVZVu4bQF7bTYu5vJPRMA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42s6g521j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 09:31:49 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6674740044;
	Fri,  8 Nov 2024 09:30:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 850C7284780;
	Fri,  8 Nov 2024 09:30:00 +0100 (CET)
Received: from localhost (10.252.14.62) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 8 Nov
 2024 09:29:59 +0100
From: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
To: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo
	<acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland
	<mark.rutland@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Liang
 Kan <kan.liang@linux.intel.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH] perf list: fix arguments order issue for events printing
Date: Fri, 8 Nov 2024 09:29:59 +0100
Message-ID: <20241108082959.10319-1-jean-philippe.romain@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Misalignment of callbacks with print_event:
- pmu_name and topic arguments to reverse

Signed-off-by: Jean-Philippe ROMAIN <jean-philippe.romain@foss.st.com>

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 65b8cba324be..c5331721dfee 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -112,7 +112,7 @@ static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
 	}
 }
 
-static void default_print_event(void *ps, const char *pmu_name, const char *topic,
+static void default_print_event(void *ps, const char *topic, const char *pmu_name,
 				const char *event_name, const char *event_alias,
 				const char *scale_unit __maybe_unused,
 				bool deprecated, const char *event_type_desc,
@@ -353,7 +353,7 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
 	fputs(buf->buf, fp);
 }
 
-static void json_print_event(void *ps, const char *pmu_name, const char *topic,
+static void json_print_event(void *ps, const char *topic, const char *pmu_name,
 			     const char *event_name, const char *event_alias,
 			     const char *scale_unit,
 			     bool deprecated, const char *event_type_desc,
-- 
2.34.1

