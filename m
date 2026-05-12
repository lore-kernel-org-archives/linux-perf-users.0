Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC353AB281
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625071; cv=none; b=CozqbzUm0ii1Y9eXaXPaWoU6n98Ox7Accz8pxr+d/Jp4twrXMRlIQ1Y0dnqcMpiXx5LWsrxjoPkitVmDffAy7gDPuquab70kKkAfoxmf/rmOk4Iq7yDkS3bl+I+5L2Ka3AcNWtsgLHiEUaS8UBSHxv+92JT6UNEB+PSsGFm9Qzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625071; c=relaxed/simple;
	bh=Avv0T4TwgeWGf9PZ0RelVBV5DXDPY5iEUOXB3lL9O14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YiFZfcPfZW9JqfDqfIXQdokIQg5oWcK2k+hTz3EoyZdRaQm7zKePxroBJICRgdpiEEcH5EBX5U7RINbPjpnAVsLYaoB6+K4kOCxemJtg+lGvGc7ytfbrNYzqhXmRpNSaHfzp64NpQCOXeR0VgICSutAO44uTydo/6/MiO3uparw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSuNf1tG; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSuNf1tG"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ee34588671so8577574eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625069; x=1779229869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WB5RKfdEu9TRySRdZZhF264RMTBy25fKnW/9IFqYTE=;
        b=QSuNf1tG5l29xcOiSWrizNn0f5tg0VWdFewUzS++Sccv30o0Tb13ucpnj9QuTF1YhV
         Uu8NP5pQhpTaFwkHxCyqIkgoaQvCSM1wcIceiU+FyW1paQR3313lNyJx6/LGBTZFP+d6
         K/PI/QzIIJUrcVbSzypV/Ouh3hi915qkGtrYlNNbSKYY0J4p3wRX+XdSu9/Ea/oRoMNR
         4Xh9HuDrGtkAzKyD1IIibd9MCs8bPbhF5DTgieat8r/Rvg5xmFSAo8+KYDgsyHbOTMua
         J98kvudyecRquRlMK2FCaw/vJ9SXmBvIudbtMNJ0bTGocCsEHigwO04q658GwCKTHRAQ
         0mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625069; x=1779229869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WB5RKfdEu9TRySRdZZhF264RMTBy25fKnW/9IFqYTE=;
        b=MceNByvMptGMyRYhglgrhijG5alg7qLDah2wWrBeIFQ1LY6AgelRCKd+DAhMTCFkQu
         8Wpx+UkngOH09Q4/picxs1oAXR2N8BIUxBPP0SKxsyrpbs1VRTbK23/+S0ESXz5kdaGe
         FIgDveea8ditpiupPeYYsPysX7/RDlrJ+92nbH9RjJ5Vpw9INC/wZVrGfEPqby8KzQN+
         7Dpaobi+3qv8iALe0CpdxV7Y9iFdQN4hGASPzk4xLdtRFAFseCm2ZRICfiShoSZVg5hl
         KRIRrQGQBbHYLKHJbRwIi76E1YaYySzrYY9tVjQtYed3Z0bIBnOtHiM5MwoWpsnVEHp7
         QwXg==
X-Forwarded-Encrypted: i=1; AFNElJ/G08LnSmqwlNKjqutCWDIPetWeB0el1EcR91TzGif/cPVPqbCFWqpXN078fWTEBuGKLpn/iladqixdkYs2rA10@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxnnGlkh9u9jKArJmDuLcFri059vip4TGeHmxZi6arwtLPfZP
	P5s3XLw8hQmm4uym9cvZMlcjiEUUlu+ZD2KkvX8hxhVzhLHNdCuovr8ugmNZp/moQPazoANJ6kG
	lftE9vrkEHA==
X-Received: from dybhj38.prod.google.com ([2002:a05:7301:2826:b0:2f3:f2a4:6ea3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d706:b0:2ed:935:aa33
 with SMTP id 5a478bee46e88-30116e95062mr563781eec.5.1778625068614; Tue, 12
 May 2026 15:31:08 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:50 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-22-irogers@google.com>
Subject: [PATCH v13 21/32] perf evsel: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Arrange for the sample to contain the evsel and so it is unnecessary
to pass the evsel as well. This is done for uniformity, although
parsing of the sample is arguably a special case. Add bound checks in
perf_evsel__parse_id_sample by switching to using an index and
checking it doesn't become negative.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.54.0.563.g4f69b47b94-goog

