Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF130AABE
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303989; cv=none; b=G2lpMZaUK1aRHayYr1+kbZKCrO5xlcPU4ckLyBg8Y3KNGEHhKNAzoatK6AXc0ekSDkdyckdRPAAY9TuALICdiTuuTJT6+7B329Cux1wdsL21+HelZtvtHdNuWgnxNQLWcu4h+nJD/MJeI81busqMH//+PGDypfl3lYagZ51Dwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303989; c=relaxed/simple;
	bh=vy9gFtxicEvRQRhH1oNkjKBCnnTRmSyz8w9SefOu5Nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fEJFXGkg60DFh5tU0eavk+W/MJG5q9IiqBEnXYm/txB/5h023cpAgYD471mgeMLnQK3Ui2qWIkAhNPu9xL9wgfKpjthtJWYMi/SL8pArbvN+L/lBGyjRXUzdA0Bq/HcRqZliJeMe52CH6Ircjccu42rlvwM2vTuYNDf7qSYgSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ob9L5kfz; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ob9L5kfz"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1361d52b3a0so1151760c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303987; x=1779908787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C91qOHURWTNDFdyNm82ZF7Zgtjl+yaK/jp0Ihx0VYt4=;
        b=ob9L5kfzEd8neeUceMG6Fv4/iefYcSfTyGh8edbIKSqUVey92aR0rUWvxZT8cbb2Z6
         KFf6pn+N24FI5MUnkc0TEWarnzQ3FuR5LWP8nb0HoOdkLe7nAeF06PetkA1rcbC7Z7cV
         dlGvERaq+XrgiiSt6lRMdWcrkMyVP1TA0rSVtwnAJLAWZ/P1VUPWng+DRkVugnA9fAFf
         AAuaHB2vSe9YKIuRZ9xprYa2Rxr1Gw+kwuNqzoi038QodtckaUuKwQFkdt7/kfnSRPlP
         N1qnehp6Oi5t+7fPD1yp60pVTDAOOXMMvy5nEF/SUchtT60IBZJ4IzEIqDJgB71g572y
         Zdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303987; x=1779908787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C91qOHURWTNDFdyNm82ZF7Zgtjl+yaK/jp0Ihx0VYt4=;
        b=IuTgKhfL1aUuylhvZYiOWx5NqOa4/CHPDbHBw4ZnwVvdfY1zStArPGv7ZwsVqwBSag
         YLkLb1kGTOeekzLqUP7cJwrwzBwruvmPVjHK8CAFXcvlPvAdbHbaAKjDrtFlMCsUGKej
         xkw+xXSYIx0lJbRwUOqdQB9HVHJy0ait790iLBSnPspxdUSkJh5QmQ0FjXaVtCoUXR9W
         XLQiiz76YHvyLt5opsBxykifMyE8HcfJ5eirOM2jxJ/EadGyjqZQs/IlgfZCeDMJCxFo
         B5+SZcmAKVAoE3jxXM4I47LRYfr3ckl5O+ctkpb9DvjoJzKvtxklS9DIhL+Uw/XRU7Pc
         Wr2w==
X-Forwarded-Encrypted: i=1; AFNElJ95D8U+1u+x73yfcaClrdZQNGiK1QyUCSifFaw1+dFETovwsv1zFS8TIbXiDx6wo/LqAdQE8Zadrx7ExXpfJnZW@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPIXQdLeSQIDKO5n+yiVlyaLs5tGKxh+TUUcaOshgTBLjekAp
	PIsSYVk50k/RTe/hooTmMCSGq7x3WbfoJUzCtwG4IuECd/39sIPdWN0NbVYh86bjKNmB+Ej4AuV
	xuEsnuQIUxg==
X-Received: from dleb1-n2.prod.google.com ([2002:a05:701b:4241:20b0:135:d2a6:35f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:221a:b0:135:e455:e1e0
 with SMTP id a92af1059eb24-135e455e2eemr2203259c88.10.1779303987158; Wed, 20
 May 2026 12:06:27 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:27 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-22-irogers@google.com>
Subject: [PATCH v14 21/32] perf evsel: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.

Remove the redundant evsel parameter from evsel-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 61 +++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ee30e15af054..bb48568b8101 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3003,52 +3003,62 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 	return ret;
 }
 
-static int perf_evsel__parse_id_sample(const struct evsel *evsel,
-				       const union perf_event *event,
+static int perf_evsel__parse_id_sample(const union perf_event *event,
 				       struct perf_sample *sample)
 {
+	const struct evsel *evsel = sample->evsel;
 	u64 type = evsel->core.attr.sample_type;
 	const __u64 *array = event->sample.array;
 	bool swapped = evsel->needs_swap;
 	union u64_swap u;
-
-	array += ((event->header.size -
-		   sizeof(event->header)) / sizeof(u64)) - 1;
+	int i = ((event->header.size - sizeof(event->header)) / sizeof(u64)) - 1;
 
 	if (type & PERF_SAMPLE_IDENTIFIER) {
-		sample->id = *array;
-		array--;
+		if (i < 0)
+			return -EFAULT;
+
+		sample->id = array[i--];
 	}
 
 	if (type & PERF_SAMPLE_CPU) {
-		u.val64 = *array;
+		if (i < 0)
+			return -EFAULT;
+
+		u.val64 = array[i--];
 		if (swapped) {
 			/* undo swap of u64, then swap on individual u32s */
 			u.val64 = bswap_64(u.val64);
 			u.val32[0] = bswap_32(u.val32[0]);
 		}
-
 		sample->cpu = u.val32[0];
-		array--;
 	}
 
 	if (type & PERF_SAMPLE_STREAM_ID) {
-		sample->stream_id = *array;
-		array--;
+		if (i < 0)
+			return -EFAULT;
+
+		sample->stream_id = array[i--];
 	}
 
 	if (type & PERF_SAMPLE_ID) {
-		sample->id = *array;
-		array--;
+		if (i < 0)
+			return -EFAULT;
+
+		sample->id = array[i--];
 	}
 
 	if (type & PERF_SAMPLE_TIME) {
-		sample->time = *array;
-		array--;
+		if (i < 0)
+			return -EFAULT;
+
+		sample->time = array[i--];
 	}
 
 	if (type & PERF_SAMPLE_TID) {
-		u.val64 = *array;
+		if (i < 0)
+			return -EFAULT;
+
+		u.val64 = array[i--];
 		if (swapped) {
 			/* undo swap of u64, then swap on individual u32s */
 			u.val64 = bswap_64(u.val64);
@@ -3058,7 +3068,6 @@ static int perf_evsel__parse_id_sample(const struct evsel *evsel,
 
 		sample->pid = u.val32[0];
 		sample->tid = u.val32[1];
-		array--;
 	}
 
 	return 0;
@@ -3244,15 +3253,18 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
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
 
@@ -3614,12 +3626,13 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 
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
2.54.0.746.g67dd491aae-goog

