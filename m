Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5969126C13
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Mar 2025 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741921726; cv=none; b=QGBrszixj7tubSuRecLQX1IzwF9aV7ZSVGbJy6F2c720BXY/2xC2IA0LVQS1VZRZysieJMGPvoDppxOaBMvbkXyjpXMFs5UZKMET/yE9b/MlwK1N65N8mF8mdCBG5dgfXwXiExpXRQ8kEjHyyZPYLfPkr5syvd/5RdVYP4EGJzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741921726; c=relaxed/simple;
	bh=d5/SPH6Xszn1gnN5qqSdZHDkkc8zw3ZG8Oun46aesZk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gj5kpckM3HUA+7aRpjA27MU57mBTUTFbToxBcO3AEPFzPAe/7tq0t5l+VFd+Sy/h18l6aoXMpu9xv9QkqjU4uUX9raGy+q9ebndhvPhec/sPxtU5tq5Qhw/PHbg9VeRdnSA5tBVMglHNS++CpVbTjLn4SAUigfT8iz+cZYbo7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRHJKWcA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRHJKWcA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ff0787203cso26317277b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 20:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741921724; x=1742526524; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUkAIINDzOsP+PuNVteX8o8oIwqX+sSmcLnHXIaoPro=;
        b=CRHJKWcABOZleXSzaYaowi8YdacNU3Acd65Fal/30tcHMr5UR0s0Rh2S+ccy5td9Gm
         Ts/Qce6euUozDZF/Xb3EubWNq+UTXFt0bywEEmMvwd0evWWyL6AGj+NNP1rBLICikYbD
         CrZbMOKq3/d1RryyNmFu+VlQ7hjByYBVg4CGDfQrRXH5xBRpFy5ganELhI5zJI6a88tr
         WUAPir5lauOZJPOWX3DEiJYemsU5kGX26BObbCqeh413nTGJDkA6SxLmslElW+ug2zCz
         b6PB9eHukqj6HW3ldtwW/Kz8d0sK9lbSSWcCFO6D0T4PXfE0EC7pU+iL6mV0gxx0sMy1
         HIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741921724; x=1742526524;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUkAIINDzOsP+PuNVteX8o8oIwqX+sSmcLnHXIaoPro=;
        b=Gno9OTHWFKHMEhclQB7BN6sJy8niZRncZXYswxnoG/klKGjTazFB8d/Dr6f9FPPDrc
         ojrwZMSSoeDgkLbtpMxv1+ssmS3tzCzEG7bhDjmkvTMAIgED7sjpZOAwIHoMjXVysk39
         AHGYP60NcXilsQkLKyrz43N7xaNEBLM92CYlZ0rScp05EmfjWfur9XH+2Wg6Ezgs1W5C
         Bdy9fUFteE1Te+Vep6MpmAUDJxdotJuKBJlii7aMFH/oZqk5KbniMUInmGJR1OmXzCIH
         vtAwvxXl6Nfxp125lW8XmGUFlCOYIAmktjn/eNzKoJT0KoCoCk7+lSkwHR1J0bsvuKsO
         hdFw==
X-Forwarded-Encrypted: i=1; AJvYcCUESR5GqlDngEMpKwGw/T8zLG95M/KY6dwuujfyYGSLVNPsElY6pHnMY+LQHdMXbrMTeH5ibmGCFT8eWpicxyZd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9zV72y6+5LbaOIDz3OCULAVo13qu42RP1zNZgA7DuAsHXCoY
	1vTb4ldOI7vAn0XRHh/n0TyVUAOqMqrgM7WcNRZ9PfLkPPZryoS/b5Grtoj0k2EBirg1sh5TWsQ
	4udojgQ==
X-Google-Smtp-Source: AGHT+IFeZSQ6rnJMp5IT1dpxWmBkpE3AhCMkxOx806OwFLXIlbl7ox4KxEF8TFHDzBYOQROlnLKgPDFGnp+O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:cc2:382:11b4:a6ba])
 (user=irogers job=sendgmr) by 2002:a81:ad23:0:b0:6fb:b18e:1469 with SMTP id
 00721157ae682-6ff45ebda93mr3147b3.1.1741921723720; Thu, 13 Mar 2025 20:08:43
 -0700 (PDT)
Date: Thu, 13 Mar 2025 20:08:36 -0700
In-Reply-To: <20250314030836.1129407-1-irogers@google.com>
Message-Id: <20250314030836.1129407-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250314030836.1129407-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v1 3/3] perf test dso-data: Correctly free test file in read test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, James Clark <james.clark@linaro.org>, 
	Yunseong Kim <yskelg@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The DSO data read test opens a file but as dsos__exit is used the test
file isn't closed. This causes the subsequent subtests in don't fork
(-F) mode to fail as one more than expected file descriptor is open.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dso-data.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 06be7c5d8495..a1fff4203b75 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -114,6 +114,17 @@ static int dso__data_fd(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
+static void dsos__delete(struct dsos *dsos)
+{
+	for (unsigned int i = 0; i < dsos->cnt; i++) {
+		struct dso *dso = dsos->dsos[i];
+
+		dso__data_close(dso);
+		unlink(dso__name(dso));
+	}
+	dsos__exit(dsos);
+}
+
 static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine machine;
@@ -172,7 +183,7 @@ static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __
 	}
 
 	dso__put(dso);
-	dsos__exit(&machine.dsos);
+	dsos__delete(&machine.dsos);
 	unlink(file);
 	return 0;
 }
@@ -222,17 +233,6 @@ static int dsos__create(int cnt, int size, struct dsos *dsos)
 	return 0;
 }
 
-static void dsos__delete(struct dsos *dsos)
-{
-	for (unsigned int i = 0; i < dsos->cnt; i++) {
-		struct dso *dso = dsos->dsos[i];
-
-		dso__data_close(dso);
-		unlink(dso__name(dso));
-	}
-	dsos__exit(dsos);
-}
-
 static int set_fd_limit(int n)
 {
 	struct rlimit rlim;
-- 
2.49.0.rc1.451.g8f38331e32-goog

