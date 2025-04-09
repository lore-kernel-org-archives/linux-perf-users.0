Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E2B1E1A3B
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178885; cv=none; b=W1OzEFFc+o1tknll/LYKhfrdul0lkFz1WImS8mWzsdOyLDe0bNrBUUV/HhBIiXEy+QFV1ElFjRgP/0fulLfoJre5nZnbz5AWyZHlk2LKgxIjxlMI1YmlPTBIUFW8jAQxsbe0LHoqBZkJhaAVJY8Ny2EfsRW56nMMWjIhF3Xi5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178885; c=relaxed/simple;
	bh=yUglDtEpwZVjaGPveMCOEFvdP87AB0tTSBss9c6TB98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mBMA6nCmTyxsdKwXzwAXYVv/pLz2SzxYRp/SES9FXyQWq4LudOlb7O4icWRv5/Wy80ERnJ51yVn1ergu7JYSlsYXqdBRMMLnHMe9E+exXI21PBMF5a1NbzUVnkZabfF0KeRNdgbpEyjKL9PF5C+v6TRrxiBonJVQzIOsouhF36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qr8bX68B; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qr8bX68B"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2264e5b2b7cso54347175ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744178883; x=1744783683; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XafRrptC07unstJw1HreG0n5lBFJ2gSj/BsZTF4fwvk=;
        b=qr8bX68BwTUh/ECQry1/KbYxJTyru54XR2XAXetp88viomUnzuo58iImTshths1CHT
         G68t76duWFIydoCx9PhgqI1KOp6rNfiO7Ob7GsyLOWLFey/bLCIM/EVYi9sS4BRZWabX
         d/kH4Qe+x/iAHVH718BphjrbU36xlyXJA2YLN4iX7SQC6lU7iil4NQlCM+6qCfErRR6W
         DAwKA727vV1d01zHSI6DQ3Qze57WXRGVadbShwTqFqcdoymt8048q2rT0w8O+ZEUnJ1l
         GFbIRiP13EEBKah5MOLObOR8/ZpvNOcEJKf5Ka2Y+ELwIhou9MsyjiclSHO/D9Cjwb3J
         s8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744178883; x=1744783683;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XafRrptC07unstJw1HreG0n5lBFJ2gSj/BsZTF4fwvk=;
        b=KMSd+68Ev0xhrLhtidOMwbt6piF7hsRZjKfbfOcGU4iKYbvGVxGDWLEzZAKDV4TE+w
         DLIgaeW2M2titsIugrYGoMMJ5z7Jth7b3d3bl21NIrCY6PMSkNlJ6C8t24giqWeFX1n5
         5K6vJvEkn4gvBZ3Iv7zHZjDUbN+5wnCuD0j1eIOL6E0Nk5j4c1OqRXx9huACvYnar+SQ
         q44Ep6OFXrNj0t8G3RntVIFgMQwZ4M5xk/BeHJXd0yM1FKOPvHdQ54lwETcfxaUTni+0
         1fWsdRXdbUkf2e27zHgf6HDSGAAasCDhGVpcbI5Ky8DeA8Ia7zL2GahnPeuj5wuUz8cK
         5OlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBD4uUBWXVqn3H4hymVx8xbMST2W4DiOhtMzAC6ZS3FlbhcntOtojD6wSTAm16fNXapZcuWHt+CD9BdzNV+i+h@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ED4xdmutq5NBRbDVsipyQ0qSDazCCdFV8f1XG/0fjpeCnlrx
	GLNENz9J/CuDshNkHIKI3PQKqU4sUANmpiVebm4WM21/wHOm1RcaFPI+UmjIWDZJrhD7IpXpqg8
	OQHGruA==
X-Google-Smtp-Source: AGHT+IG1t5cGUkVzWEt5u7hTXXjvZhkM2WZpchTlIgJSc1XitOD5BysYz1RHQBjDDP1/1goEacQRAxREI2SB
X-Received: from play12.prod.google.com ([2002:a17:902:e18c:b0:227:e9e8:7153])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:124c:b0:224:1781:a950
 with SMTP id d9443c01a7336-22ac29916demr27017675ad.14.1744178883586; Tue, 08
 Apr 2025 23:08:03 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:07:32 -0700
In-Reply-To: <20250409060744.698511-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409060744.698511-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409060744.698511-6-irogers@google.com>
Subject: [PATCH v4 05/16] perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The buffer holds the cpumap to pass to the perf record command, so
move it down to the perf record function. Make this function an evsel
function given the need for the evsel for the cpumap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 2186818b2c9b..2b04deaf66ff 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -83,12 +83,15 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 	return 0;
 }
 
-static int start_perf_record(int control_fd[], int ack_fd[],
-				const char *cpumap_buf)
+static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
 	const char **record_argv;
 	int ret;
 	char buf[32];
+	char cpumap_buf[50];
+
+	cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
+			 sizeof(cpumap_buf));
 
 	scnprintf(buf, sizeof(buf), "--control=fd:%d,%d", control_fd[0], ack_fd[1]);
 
@@ -287,8 +290,6 @@ int evsel__tpebs_open(struct evsel *evsel)
 		return ret;
 
 	if (tpebs_event_size > 0) {
-		struct evlist *evsel_list = evsel->evlist;
-		char cpumap_buf[50];
 		struct pollfd pollfd = { .events = POLLIN, };
 		int control_fd[2], ack_fd[2], len;
 		char ack_buf[8];
@@ -305,10 +306,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 		}
 
-		cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf,
-				 sizeof(cpumap_buf));
-
-		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
+		ret = evsel__tpebs_start_perf_record(evsel, control_fd, ack_fd);
 		if (ret)
 			goto out;
 
-- 
2.49.0.504.g3bcea36a83-goog

