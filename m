Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A180BEF
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708990; cv=none; b=fVSzxVSAPr5xPSuAywgT9e521wYXmjM74WZePgBFxDpI52c7DnQGog1Ggrew0XEwzczYPklsGsdFfrfwEPK2hVyRkIVbyHEMN/NlgJTEa6P8N99+/icIaORlm1NvC+6CFPeVNW1tDT9vfALbJv++IWpgbI1E3a063SLAdRNF/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708990; c=relaxed/simple;
	bh=u2dme1MUFaWQF1BSStVrUjjYLnHIqMsZ+Wjfwetyd+o=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ESjZZp5/+tUACIiAQEUjiqdDEUb5US82Z5l9U9k+BnBopxpmopXwN8BGsa33mEDPFPYo9gyr+zDWl8cmpAoZjumvYSVlfGWKhd3bXO9YiwJKmrXkjYO3jwONQbOt8F/oMYkna36QC+OUeCuhWaX5o/JrjkcTMfMk5Jluou2IIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPdCq7EN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPdCq7EN"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso1868709276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706708988; x=1707313788; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TRAmZ7zfR7GIpS+aIsz6syaxM6Q4TrPavG5oF05xWJs=;
        b=XPdCq7ENDKCH03IYWpJWWzcDbG4raKx2XumxlXaJJevXX00oTKTWX3gHAWyUBXtzIU
         1Oy2YV4FOV+GXeGSYj4Kbng5P2avdJbN2eytRr4Ed1NK1DLu8DbJIngkCqDrl8KijmUz
         9PMilDUg/C0CvHP0K/dHPFk6+UxS88zyGm1CiYCpuPFOKYzeLvBxYUJQ1kJoFaLAg/Z1
         BpXMDur1nrdknuhK7eg7kc4OHg+CevQSNPA3glys5LDOMbnLXKAPg7kKV0NV7q/yazsP
         bhiAbj0mQO5Yp2QGCmPbHXzkX6/x4H0JU8FrPAXTwYnEfQyPbegJC//qxB6S4rgaiOMV
         Mffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708988; x=1707313788;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRAmZ7zfR7GIpS+aIsz6syaxM6Q4TrPavG5oF05xWJs=;
        b=iIEfoC8/MWwR7YmpmuH10bhthlD68y2wUwPkwAQMiaEdS2Ixh/saZFsppzQUofn6/D
         oFsN52LHv1z8xFf7IM7CJvXI6QK/3hZn086vZuTevBpqrW5kyTB9yiMRQSU1D7ZA4CzH
         NcgBGRFVkEMMFkjO9Pb7dI3eJGTJi2Nu8aP7o9v0G4wyyFMNcatJIEr/tof8yE+YXmQL
         7mxw9rsGSezgRO7e2obMyRmilPcVpjXepgF57mTURWjqs+yboMC6c+1JH3pg1oQKwmTK
         uV7Lh2CsGSKu+pJtjY6a2R+XfD1CxC2eWPNRfZ/sK9AZppLa46Wz+zi6G7s04REhJ05/
         xlbg==
X-Gm-Message-State: AOJu0YwVr6t06X3pHNQWwkqmwxxiuge5Iiqf1HBdJfvqs40tiNO2tS2t
	G0DoxkjOCUme5OXxFrwQO6WZksWRv3aroCWAR6gCS+uZnaAikMWy7lHswvVd5ZZvOu4VKPCtwhB
	C16W45g==
X-Google-Smtp-Source: AGHT+IGgH9VGUNbP6lTtRKVCwmmsOcX/L3HvdfE06R8+BcjhYIuCAG2dqmf3z8P9FHQAPg2aDpRvX5PKpcMV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d0ab:43c6:7969:62ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:1793:b0:dc6:519b:5425 with SMTP
 id ca19-20020a056902179300b00dc6519b5425mr468454ybb.11.1706708988337; Wed, 31
 Jan 2024 05:49:48 -0800 (PST)
Date: Wed, 31 Jan 2024 05:49:38 -0800
Message-Id: <20240131134940.593788-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 1/3] perf tsc: Add missing newlines to debug statements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tchen168@asu.edu, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"

It is assumed that debug statements always print a newline, fix two
missing ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
This patch was inspired by bad debug output in:
https://lore.kernel.org/linux-perf-users/CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3OiBHV_BJ3QtFjyKAs7Sgg@mail.gmail.com/
---
 tools/perf/arch/x86/util/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 9b99f48b923c..e2d6cfe21057 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -33,7 +33,7 @@ static double cpuinfo_tsc_freq(void)
 
 	cpuinfo = fopen("/proc/cpuinfo", "r");
 	if (!cpuinfo) {
-		pr_err("Failed to read /proc/cpuinfo for TSC frequency");
+		pr_err("Failed to read /proc/cpuinfo for TSC frequency\n");
 		return NAN;
 	}
 	while (getline(&line, &len, cpuinfo) > 0) {
@@ -48,7 +48,7 @@ static double cpuinfo_tsc_freq(void)
 	}
 out:
 	if (fpclassify(result) == FP_ZERO)
-		pr_err("Failed to find TSC frequency in /proc/cpuinfo");
+		pr_err("Failed to find TSC frequency in /proc/cpuinfo\n");
 
 	free(line);
 	fclose(cpuinfo);
-- 
2.43.0.429.g432eaa2c6b-goog

