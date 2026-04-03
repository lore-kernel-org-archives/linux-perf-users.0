Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB43DA5A0
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248884; cv=none; b=Td314dAekI0uQP6Gav5F17TUncGBn4BfR6caZRHVSfsrLbKsceoqpx38MCIAJQNEwxHXQGBaHVpu0mDbeDyrP5QnTlkuTclJt30FHUnEBOzRyTxEeYUSED21lSZO5VZm0rSgqXrw2ZKAmv1Dex8rjWCqW1aZXSY3FsM7mWFEzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248884; c=relaxed/simple;
	bh=16je8wZ9rqScgL6yvcnuQStJyi53pIb8IMjgAO7kLG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WuiHrlwWjC/X5yRoaSGZ8mfsZtwK4DM7YMWWddwz5ddTO+Dc0Y0yHb+sfAXePJEwMedYyJXnOKOLul/DS7xolHgGNckjoULZNncVD5EtbVomztAcbZU3TSfMA3f2L/qE2hBb2bWjBRTsJEckf/GVU9hkqr8hhFskBxO29kv6huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vz2fUIpp; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vz2fUIpp"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1279caef718so3684449c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248882; x=1775853682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BhGwcxOOVNWLaxv+kx7m7Po7gy72tR+Ml143+1jEuZI=;
        b=Vz2fUIppIuS+Ph2MRCuYXP95QHPnEsm45EKqiotUDL23EL44XzqIcBjbaBs9ZonvVb
         AsO0vu4yu6qwP8N/e6XfkUF9tIywSBJ4FGGAzDrrzpHdkADILCK3bHgRxs8WMcDeNOqv
         FZnsVz91d4xNTr2bgi/ThZK3jblDBfCE1hIZ8ngnTcdv2clhv70G7Xm+FB/FicaeZ0bH
         bHi8VtVKO7WbNeX/QGxpqWiJJjmlztMn/2Tv6NA1AWzpdYFAu727ODqcTtLV/urpL+bE
         HzvO2zORYpVM8OCF4nsTEUJj1BvQKNQlQNaFTPGBimvo7OPLakeAD7JWKywG5KewUnhp
         gFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248882; x=1775853682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhGwcxOOVNWLaxv+kx7m7Po7gy72tR+Ml143+1jEuZI=;
        b=WfUdHZGtjstOl/TJheONL+wm8kX8yOXOGI/XMCd2qCv5rwz5gL9QZMZmoyiIrmux22
         EyOoGI+6tzLKAzTGBA1JeXW0y7d1Q/9VS1M+CckQOWxRNu96hTm9E11bvRPBaOZFzrE0
         Gd/zBX1y6sdcIp0QAFXqsUZP8JA2JQ38TYIykcQRo+kIMiIF/MXjtQhxTvrgr5ay7kxG
         gDl+ytuBlFpPGqnDXZAiMpSzNDslVimEhVvBbe1FW+WPFW55vQOfRtpjqSsrzxKZHH5f
         jJ/w0Xz2cgfiMhGcMzUPOsgbyf5AjyaU1edSxQQdZMaa3rVAYsB8515BLsKAHBjogc06
         LkGA==
X-Forwarded-Encrypted: i=1; AJvYcCWxTkxUn4IEuidSRAEY7aOWvmgmoiFHXMZHL0Q9Zs2fdpTS37Ir6mIRYffkDNUQrqObflzNH8PPkMRoXhwJZcE3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9EztmrkGyacvzDm5ObNBNmaXZfCG9T/5UUTFMO78vJsFRby47
	gXmVokWqX04tWijBF9STWb0xImjmN+fZOWD83Sl3zdFsjMCm4a2GWbANxr8ob2jLblDUUK2kKZQ
	eptLQTJtSyw==
X-Received: from dlaf28.prod.google.com ([2002:a05:701b:241c:b0:128:ee69:eb75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:112:b0:128:e6d0:d7c3
 with SMTP id a92af1059eb24-12bfb73eec9mr1976455c88.20.1775248882399; Fri, 03
 Apr 2026 13:41:22 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:17 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-26-irogers@google.com>
Subject: [PATCH v5 25/25] perf evsel: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Arrange for the sample to contain the evsel and so it is unnecessary
to pass the evsel as well. This is done for uniformity, although
parsing of the sample is arguably a special case. Add missing bound
check in perf_evsel__parse_id_sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 53 ++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3ff4e466ced9..9df30f83b764 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3002,24 +3002,39 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 	return ret;
 }
 
-static int perf_evsel__parse_id_sample(const struct evsel *evsel,
-				       const union perf_event *event,
+static int perf_evsel__parse_id_sample(const union perf_event *event,
 				       struct perf_sample *sample)
 {
+	const struct evsel *evsel = sample->evsel;
 	u64 type = evsel->core.attr.sample_type;
-	const __u64 *array = event->sample.array;
+	const __u64 *array, *array_begin = event->sample.array;
 	bool swapped = evsel->needs_swap;
 	union u64_swap u;
 
-	array += ((event->header.size -
-		   sizeof(event->header)) / sizeof(u64)) - 1;
+	if ((type & (PERF_SAMPLE_IDENTIFIER |
+		     PERF_SAMPLE_CPU |
+		     PERF_SAMPLE_STREAM_ID |
+		     PERF_SAMPLE_ID |
+		     PERF_SAMPLE_TIME |
+		     PERF_SAMPLE_TID)) == 0)
+		return 0;
+
+	if (event->header.size < sizeof(event->header) + sizeof(u64))
+		return -EFAULT;
 
+	array = array_begin + ((event->header.size - sizeof(event->header)) / sizeof(u64)) - 1;
 	if (type & PERF_SAMPLE_IDENTIFIER) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		sample->id = *array;
 		array--;
 	}
 
 	if (type & PERF_SAMPLE_CPU) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		u.val64 = *array;
 		if (swapped) {
 			/* undo swap of u64, then swap on individual u32s */
@@ -3032,21 +3047,33 @@ static int perf_evsel__parse_id_sample(const struct evsel *evsel,
 	}
 
 	if (type & PERF_SAMPLE_STREAM_ID) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		sample->stream_id = *array;
 		array--;
 	}
 
 	if (type & PERF_SAMPLE_ID) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		sample->id = *array;
 		array--;
 	}
 
 	if (type & PERF_SAMPLE_TIME) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		sample->time = *array;
 		array--;
 	}
 
 	if (type & PERF_SAMPLE_TID) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		u.val64 = *array;
 		if (swapped) {
 			/* undo swap of u64, then swap on individual u32s */
@@ -3243,15 +3270,18 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
-		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
-
+		if (evsel->core.attr.sample_id_all) {
+			if (perf_evsel__parse_id_sample(event, data))
+				goto out_efault;
+		}
 		return 0;
 	}
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
-		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+		if (evsel->core.attr.sample_id_all) {
+			if (perf_evsel__parse_id_sample(event, data))
+				goto out_efault;
+		}
 		return 0;
 	}
 
@@ -3613,12 +3643,13 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		struct perf_sample data = {
+			.evsel = evsel,
 			.time = -1ULL,
 		};
 
 		if (!evsel->core.attr.sample_id_all)
 			return -1;
-		if (perf_evsel__parse_id_sample(evsel, event, &data))
+		if (perf_evsel__parse_id_sample(event, &data))
 			return -1;
 
 		*timestamp = data.time;
-- 
2.53.0.1213.gd9a14994de-goog

