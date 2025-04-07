Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8A185B4C
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002081; cv=none; b=hsefmYT5SY4Fzwpi4VHVfMVRSackiGlbo9tLXW/BhweaHw8aRRPGuDkg+csokzNCzOViD1e9B6dJAAQY2SiZq6mt/1PH/xGpWLb9mcaNLIfRqD9GNhASHq4dLEcBSmxvq5AzkRFyNIo4xIJ1eR/hPR8ERNBsTNX702LYbMNi2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002081; c=relaxed/simple;
	bh=yUglDtEpwZVjaGPveMCOEFvdP87AB0tTSBss9c6TB98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YLQjQf4ZE3L/tSBFvWnvblbQUmWl+tvliRKjbWcwR9hRhE21CIP2mR1cJzWe0PWTsy3Q+pull8EOH9NWpi7dhwJ1EerADxkYgSun9ra/i/Ag7u67WHaPsEgVU8DIfOYX4oyUypQC4V296BzbeEm0ynhDrHJ1RQCrxULsPzf2HLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2CEREzz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2CEREzz"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af8f28f85a7so2489130a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002078; x=1744606878; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XafRrptC07unstJw1HreG0n5lBFJ2gSj/BsZTF4fwvk=;
        b=v2CEREzzT0G1l1d2+QGgLHi8m0SEY9N2AELXY5mu43Mv+FWyni+zta4CYXkciJCupH
         AFdM6UBFYWE06GGGnpPXBAQq82y2RdBO0Burh7koshOdqnovR+R4p9/b5L7B1xOLN4Mq
         GbyZP+BeiZ/LXBBkwTcY/3B/5B9DomNExkttKhTBusNxnPfiPy6Unn/A3BYNvYtWVltt
         yciUT49BoaWgV3zg9qQVvqGvMqaQsyla+8KwPPy+Ux3AOn6O67UVYsdWHufLKAlE3MaB
         kd+RYnCMnpy9pmBjA+w5Om5iieDzDJoJLNF87wWAvZET28GAi9sTNXne7yyQuI6Jts5k
         1YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002078; x=1744606878;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XafRrptC07unstJw1HreG0n5lBFJ2gSj/BsZTF4fwvk=;
        b=rBzEm9qoTOOAQvbvR3LiSHwr1f9B1uqXvSy1r2Zllpv6KxC6Qui/i1NYmpm33qtonN
         Aj6XXf9TWXbzzptV4NCrvomtmHBNU9IRa2mI4SnfdKzx1UdpJN7n6O9WUfyKF4S4thJY
         3DGBwJHt8bhZO6kWwVhgiINa/Rq/hWH5d9Wdiyt7fcp02PypxDVeUQC4Im87KukttH0v
         UUCcc87jv6A0becxX5C2SHFiRUtEHY2tcCZ6RVEiHqurYKqIvf2ndzopLdiJFjWj1W8M
         gpl0eLZZ2FAuQjwABD9Ir04E7KJATmtaxhnTygtkC7ufqmXjmLIokrQIsmuizpt9DmM/
         EP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMpmcMAyiQ6M5Y30tuBk58int7ESieEQpZNO5bsUGQYkzHL4NZc2U5PVuODkodiBG14v/ncsrcrVpsUM/rbJxZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhVxLEHC9msDtrUkI2mHTtHxLkf6zkDUnk13NyLI+uul08SUS
	6T2VGjF0gDLyM+wPWzAbAkrflqwsXeX3pW8m5FSIRVFesbMwu1rnNTzADwhrRTLnfdt/zMkAvjo
	1nEEEOg==
X-Google-Smtp-Source: AGHT+IH+ztOPbx3Kmwe9F+goW9ZQVGpeYeUrP+qUHa4YPTewYdbk5u8w73AsM92dGciR8tHBXeL8YUcOoDgw
X-Received: from pjbsk12.prod.google.com ([2002:a17:90b:2dcc:b0:2ff:5516:6add])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48d:b0:223:66bc:f1de
 with SMTP id d9443c01a7336-22a8a06b382mr147697185ad.21.1744002078144; Sun, 06
 Apr 2025 22:01:18 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:00:50 -0700
In-Reply-To: <20250407050101.1389825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-6-irogers@google.com>
Subject: [PATCH v2 05/16] perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
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

