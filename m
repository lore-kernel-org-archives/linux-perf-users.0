Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9E1E0E00
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179064; cv=none; b=DTFpuZ4yjpaOLyBfKJ49MGnoqQIPp8/YKwB17K3wrJs9Dsrw5nhzDCxSrsSH+tdthuIOu37jp85SdTqhGTJ+PDV1y9+XEZZCxacVu9yJfqPJINARtNlPmKpxiLsyDHWgfg5r2Ezjsj7UwgZi1zPqnxDihZNC0OkmxF9ir/odtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179064; c=relaxed/simple;
	bh=yUglDtEpwZVjaGPveMCOEFvdP87AB0tTSBss9c6TB98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=p1d8W4RLZC8MZTNUKpNW92i96AwL8l73aD1yWseBxpO+qLkRse0Js3F5JVI4ZqbBEq0PEI5f1S9WameCgubPV5gQP5Q0Rt1VT/Gbc03xZaoYCY707ZlMttchm5CzJZFjCS9+ySnZs/gV1VVMYpeZBuQZWVyiLWOShEpRd2Qgt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3//U1kr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3//U1kr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227ed471999so53514375ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179062; x=1744783862; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XafRrptC07unstJw1HreG0n5lBFJ2gSj/BsZTF4fwvk=;
        b=w3//U1krDENNW54Mgc8dkdn/RH1PBFufqJbfe9aftDkaLfuNVJcihdI0Ln/ENHqOiE
         lJ8gZIlXVGSAJ44o2RrWl0zqzjCwBFkPzjamAN7wXshSZ6VzXhOOq9xFgDmQhE6eHzgM
         Cs8QGPQn+xtRftvmCQRDHjDSfOxxjJJbJL0eXHfdD6IqA9RrHEIdVWuVpEHd0BRS22SB
         +77kzi3HyLLWBFNf+tcQim23rwUYC/KdSSkvyyp3LwvipMPhxOZRBmNMMnN53W19RgbN
         sxZh/EOCvMr32uMsLXxs/VujxGL3xI2HngfehIQdqG71Tm48hfFee15rrkkJevf+p8xC
         1Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179062; x=1744783862;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XafRrptC07unstJw1HreG0n5lBFJ2gSj/BsZTF4fwvk=;
        b=mVyMHL6grMcF6YJg6Ul8AngN8sWt9f/QHzcLoOkD/mIcgB4TTsT0kkpH36IjDkYtc1
         FgrekDhFOql0ofO+LBIaJSnq0F9bDP8b5NliwTkS9skjEz0JyxkwKidhLoqKZ62Mhbgq
         jCvwmMuGodKeH5QVH00kune/3gzDptsU04KrcXNhWigkBoaPiVkA+3nXtk8IPITaXK63
         9nP/tmlzFCX+A8bhz9SaaCDby7YvVMJPih+O62HcND/3dB1IYp6VWo8zfE5V9Lo54hd8
         uLRIKZiWbGF5ib9jQYSWhcRLfHscrLYu12ScF+64XIT0t0h6UdnQj67mHvZco4gMCzww
         OFRA==
X-Forwarded-Encrypted: i=1; AJvYcCXl1Y1LudGJUwdPykGHFFbzmUFF5cpRtOeBE1GBzyjsb+tb7MyrNRVtEnLYZkK8hD9RemQ5r2EwMGXsBC/ply+m@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7y54lXnqCNHg+1MEa7DtsIJqSgP4CZMO9B3GaF/8iGdr6G8Rd
	2jrQhAHchTcl9OrwAG2Od0zR3VKk/gC5UGOOl66KMp0q0REVcIRrJb6RVHca96GjGyzLqvWTVu/
	uWwEFlg==
X-Google-Smtp-Source: AGHT+IEBeLFisPAqUiTchaGbpoO4ST/mLlKRoEISv+smJtgjEjtjnZMTLV06vQsaAYIzaoP6don6AGG5jumO
X-Received: from pltl6.prod.google.com ([2002:a17:902:70c6:b0:223:4c5f:3494])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98b:b0:224:910:23f6
 with SMTP id d9443c01a7336-22ac2a2e856mr28630585ad.45.1744179062007; Tue, 08
 Apr 2025 23:11:02 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:32 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-6-irogers@google.com>
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

