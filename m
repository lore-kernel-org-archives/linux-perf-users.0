Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142C28DEF4
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652528; cv=none; b=a8CjahjKrpuGdsW3yOJvPs+80uX73ELoi54y+xUWFx61l9flsp22stHPMcXgjQXvxi+ZJQEHGo8rAgbnqovdb33jLX73tOrxCsa6ENyj+ggztfxgI2Dg9yAKRYF1Qp3Z3hTZmQd83hwSiP2jhUHzSW1fa4IY/R7/gjXg00kvtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652528; c=relaxed/simple;
	bh=DFjxBYDyDfEAtlYSsxu3IuiLYb25T54vCkre2zk9ReI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=L6op4KZoHHT9gFSM4mMRMngS6in1IXn+2qQTNHrFuW5QUp1Il7uwaxxoJUCko2wh6roPq0LiXXdUkYsq9slv6lS3NvmuvXydlUWGqeyxpSRfU7Gz6d/kN9x1pd3534MwE7gzNqSO0lToQns1uWEUQVxNT4sneobtc4ukd5mIKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQYeeKP6; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQYeeKP6"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-72b7d15aa72so4285430a34.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652525; x=1745257325; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6B+tTNmgbE+npKfz9VIYvdTpAi1BUpsjCK1/o5jdOk=;
        b=qQYeeKP6DpOyQbZ8QhtwVOnZp0LLeWrDGMquyhR68bAt/5BHOBkrO2bvbrAjdIokVD
         GvKJnNolbR8okjvNH9A01mH2wggVsqRXKfYGYkBV7wutYWguAz9ZI9i1ebuedlmQCzhc
         7bp0uUmEPRt/FryhIQPTC6ce6LiyWI5uTPg/YyOTOurlCvTfxTgpR5XSY+3siN1x2mAx
         qeJhvjpIauvDxNGlbdYfRTr0fT4kZyYt1s0RKT9ob+whyOn3PUquLeTzCFsyl6HHFwBj
         Z26hsYN9/Gf8GPg5RxukvssX3n9Q6ZOkGcIsHPtnUBvoNI3uOtjt11QKC4VsbPxwrWxy
         HCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652525; x=1745257325;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6B+tTNmgbE+npKfz9VIYvdTpAi1BUpsjCK1/o5jdOk=;
        b=mCicHjsNDtBLkXfzZkLKd5//Qt5S7IvFz6ADBCxH8gCP8sWbq64a0jT3DvqPJG3NO0
         qevABV1kDT1UeuDx63D2YEtg/rU6OuWjkQ7dOjvPwddLjUkWEMzr9AxuQvHIzLbtEp1U
         SCmS/iuvygJT6UqXAvpWBGr4Lu3KTryT84Q5Gx2A4LdUod4WBW2vJ8MYJHRGG+O6stPF
         CPK7g+w8DUvohIgUkBtVd4kAeuZYTASGfeg8Zd3eyCWux3rsmmffBuHEyBezOiGl3kE7
         JUZDXF45WsmW8/hqSe9H4m92fjt0oSThCWRhec6CB2jqywMco0NAQKnKskNwd8EWOy1y
         v4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoQilvbR/6M4xrjKIpcGlhD25Offf90Q879MnLBopkvf1oKZj/UlLzx1kG2WKr81uRuCrmGuX1RfkJBfFmfriJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/3oWNHyg1JrlYkjbUiH/vMxyrQNjkLwqGdiZzwGHYNy6PfeI
	Lj9+4onOTARbSHppbmhyZ4hWoE5DhcNjwg9YvoThLagvS9AvocTcUS1F3Ehr9pyTa+Tiqp/5Pd8
	L3q+Z/A==
X-Google-Smtp-Source: AGHT+IFZfQRoFisi7/6v7utCC2NsJldmcEFv3ovdDOV3Vl+uF2EaQpByAfXxRfOr3QgYOXe434yeoSfClnHM
X-Received: from oacoz11.prod.google.com ([2002:a05:6871:788b:b0:29d:f69c:1743])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:2aa5:b0:72b:8aec:fbd4
 with SMTP id 46e09a7af769-72e862d8597mr9409860a34.3.1744652525506; Mon, 14
 Apr 2025 10:42:05 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:23 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-6-irogers@google.com>
Subject: [PATCH v5 05/16] perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

The buffer holds the cpumap to pass to the perf record command, so
move it down to the perf record function. Make this function an evsel
function given the need for the evsel for the cpumap.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.49.0.604.gff1f9ca942-goog

