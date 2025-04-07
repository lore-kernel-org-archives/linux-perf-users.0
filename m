Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D06223709
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060231; cv=none; b=g9mZV6uGj4ywjmECf8XBwdodvEvqLpGjGQpZb1/orQyg5YaDZ6izoYg+5l/nr5+vwnCO2VHIhj0/DaQvl5JrcRP+vzMw7BboVesUMVa6X9DeldD6Uv2h9BkTS2SMMMFrfgJi56PyfazKvuWEtUImbgGO5IZVtEED8g0gMreLew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060231; c=relaxed/simple;
	bh=yUglDtEpwZVjaGPveMCOEFvdP87AB0tTSBss9c6TB98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BWxGX08MVlhaP7biOqbPLXFWuJcqJxD5JKg43yyeUacs2vZGSqaQRKOBnpT4TrRdTnpKDCZ0Rr8ojCd2RqUEecQgD1xI0+jgwI0RbMTPCohxHDxuJc2MhtN4p/F+Y0O1WPIEH7oEnuSMv2gnkcVB2ULgo9Jp53PQ/4KbKWuKiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4FNIBkLk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4FNIBkLk"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224192ff68bso43761445ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060229; x=1744665029; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XafRrptC07unstJw1HreG0n5lBFJ2gSj/BsZTF4fwvk=;
        b=4FNIBkLkKHPBXj6w6sLljQJ5b+3PJwnYTk/MmVivkAW+aUyjLtD3EocFDqrLbCQGcq
         EjEPt8SaTXpndqpPsBXoeMwqLSR5n8VhokwOqSKLykxCb6zeewRHYuo3tyT4gxe7Hqw0
         wrilFG/YpD5sM/NNv2upJudnbZX8mqPTSWkHrI1+P8t15yslwK4w/qhiJkTs5iIHnofw
         nROqSnQ5meLZ25PjTRDQoDlDhvvpeVsCCIu6wLpyBB7+DvfD7HoifFn/E+tn0QxIAU0x
         RmDXQZSgSWdUanHRwDZtPQt0/V3lYS5GabL+vtt2I76jDvtC9NzCfPn0Ckxj9fCXkU2S
         Jc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060229; x=1744665029;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XafRrptC07unstJw1HreG0n5lBFJ2gSj/BsZTF4fwvk=;
        b=rh/cRmgPHIbIeDCSVULF4P0bmOmbceAEcSOCcwg0rfHCcTYTHzhjnNmFh5fImLAaSy
         hfkOWRligc8aK/K9i9kv62UN/PNIk0JPP3xsmb7kejS6O75HIMae8t2ysu5Qe+UiD9ta
         E/AhfonD89PCZfVP4bJij6doPSHDH8+BwkqBG5vRrXHtn88fKiY6DnjqtslBuuocIHEf
         5yVOHESbdApRVewzDV18qmyDhAE5pmVh00MG2lMhpamZ4Q+rFPMvHYll/Hcm+N/TyYmM
         chNluplRDMMydy97X+DZjnEEs2PFb/MHTEGGgp9dsuGFOzD3lmGA/b1g5K3GqQ4cODPJ
         LdOw==
X-Forwarded-Encrypted: i=1; AJvYcCUnGUVR7hQXi7bCeDmHGAkQstyp3rYNXfJHEQcJP3vaV89gzGEy6z5UoNuDGCB3h8c6NeRxrV4s2rbcFWUCkCkO@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7jcouy1tjJFWLSulLcXNZgtqauVYsit+L7jPXUVbyk3awzIX
	zPcW+If4orxTmSRRhmIMsO3UtF4t1pIrm9LKaQ7ULyO9T/OuLMP4wcuxHHQJsIJ//csl9jcyIJl
	XXbJdXw==
X-Google-Smtp-Source: AGHT+IG9rZiysNyuhyIctDtrxbq1yit5AwHZJLJwPgP4NCKY3s30lJRz5iRQOMp/NGlivPfByMiJlgivi0VS
X-Received: from plao11.prod.google.com ([2002:a17:903:300b:b0:227:eb6c:504a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f550:b0:224:1c1:4aba
 with SMTP id d9443c01a7336-22a955a198amr151717825ad.50.1744060228980; Mon, 07
 Apr 2025 14:10:28 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:26 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-6-irogers@google.com>
Subject: [PATCH v3 05/16] perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
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

