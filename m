Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621759;
	b=m88Wh5ypI7Wd0Ap/QYkivsT1ZXJ50jA2ugSOr0UPUB824uw99tRqOQuvX0KCG9HYCp+y
	 4xY2qenbRTxg2EumYeKkxZRwpx6eB0QO/6Op7V9IBAS4XRuQG5s5GtxdHqSISV5f62A/H
	 9Eeok4djc/s8YgZOk7vJehpRXdu6uF/2lC/Ug3oOj4YO4rtrANdCNV+dH0CsuCKqfBhIR
	 Ec1CviEHk5YTTfy+ZhMqWIVXHBvIFustPzCI0UqpAghjGedJRL8VT9DcxPs9RSmiUAjWt
	 0RQECcTpL8Yy0qYQmGUhySMbX67yj6qC/ShBkti5KLO/P4TyX6uYWv/uW0qxm6VhI6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZFE+K6ibkytnijDp2/HAIN0tLVK/PlyfhjsWm9snroY=;
	b=tqWzIoE5RDFW2rMcyzYxBKk3kIysjpmWGEMTk91Yd09MiIC4T45g/vLYudEcPtuld0eI
	 Cqi33DmE2cBy3uZWxUdQW0kplV3jXQsnbvCf8TXUQxjATjzMBtTLXfWld1KjfxlUW44Q7
	 bFS7rUMDb4pWc4V7zPl+/6+1EvrLncLt9G0cIti/nGu6E4Cw/Ym3W1ZRX+s8JO+AtUW9w
	 ZDLIJ1Kl0iaQ2Yq5RmSty9wyGh6uG0qs/2XyV9Bqf3YOWFmjZomzj7C4L5xObfEpGErT/
	 vbNPcrGm9GJne66LoIfF7reIei1AzxK7g0oeN9w+RgeCJg3+rEWWS0hZpW+YqeFXYuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fXz9aRkJ;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745C60A6F5F
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6745C60A6F5F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fXz9aRkJ
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214af2076so22142965e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621758; x=1794226558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFE+K6ibkytnijDp2/HAIN0tLVK/PlyfhjsWm9snroY=;
        b=fXz9aRkJLaTjV7AFiNRlStVsxEPcmpqoMgyZdeveE7a+PwAt+A367A7z7367lernMI
         7He/3xoNkO3bQ6u9QZRG/sL6M+xeYI+IC/F65/mPI+C8y4Izs7n6F0us6MWkE1VNdx44
         KJBuJISsh7YIz+5l2mvQXRjguygG4/jCLjIE6Jo2Gg6/xoWZ9FzmARLaAnQXJUvxTvcu
         grFlDfuJoR9vM88vl5BWKr/VqEaOx5rj3Vt7HNOWZJH1cx5apR1S4+gAprj6udNpFXmr
         N30SZsmyfh0bk4PWnUUfFbgwEMc8zaclRU6RMJQupou5q50bYTXLPAkK6Tfz1glZZ2xn
         hSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621758; x=1794226558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFE+K6ibkytnijDp2/HAIN0tLVK/PlyfhjsWm9snroY=;
        b=X11F309GdhUULKSclRLoiKFli88fiHGR7BQh9bbzC+WpdsCT5Hhhe7VhVxEb/Ybv6C
         eUA72mjh4Ed4CjYJVSgk6HzsgKPKecOZzQRY5k7gtuUXWJ64ITdyxqjbhT0fp0C/gsJF
         dYfYwgAd6Oev0+QvJvxpn7MDwI2koj9kMn/AEFelYkH0FqqlsrKJBw736nmzEX3BSvwV
         AukrfhR0jerkAarsyyqI3UW5GRjTbbhXyhGzatmV8W/u09o4ZuRdirJZTM90spjWl5xM
         K3+ntWZnLTbA/QKLZyi6MYjGhFuqJ7ellKv7zy965YZnDDGkquPyRUegEdbglEZbuNam
         +IBw==
X-Forwarded-Encrypted: i=1; AKwUvBwN0jQuUqnM/EeZOlz4oAJehj88H0ZPQUorzE+sJW5aOMzGBrlpoxFh1AtOtt4cpW/awNjJI7vocGjR5CRNUx0K@vger.kernel.org
X-Gm-Message-State: AFq9FYIFk7WLZJhiOkEM3Nysr0fEn49eVRv9TcOVliI6qI1llLtS1kbB
	PzAwStiZNKVw5vhbOHe9glwj0IfZrmpF7e8fenz0SJYA0ekc9QE+XN+iKDOvasv/5t4=
X-Gm-Gg: AYBFou1vc39OjtSYX2MtBgnmGqjAWMnazyJLlWZE+Tod49ITUuLpvWMJcgh+Kv6S7SH
	lJLV6HamdxALv8Q0d81VtaTnNoty9d3ELOUiENR65HEVxwQ2fTnGnz8IwcOW+9gNfQlwFoluTWG
	/ahzhrV4e8NX6i8sK03h/6r/5ksbLMa2ErxHbIcMYx9dAMCI0f2J2/JS1LV5lK3ybVbKFgPsq3L
	dUjDV78ExuESf1zRWoFOB4A1aNaP2Y4cNx8zLYffnL3o2YkzUPAtOdFjc/VooUZe2diuz0zS9xY
	wKX+xGzFJzBJP1ReS6AL1OqBcBRZhjMqpStnUbh4AF7XKy7tyr4cd96u+uDDsV7SJJfRo9u84/V
	L0NyKNuJ68uZa/Q2rTLTUxnaJmLUpyODLqhC3qqbP2DC8u0lVce4fZxeKodqbb4wodqtpgq1UhJ
	bTfX0nnASASV2ERQcTENUGN2X0lKwY8ssL658R58PSRdgvnC78rTDq6RAM+IW+Il6BHPj+RC5Iw
	JnGHDnYmXHf1/3IDPCCzjZHguruxOVwnW2NpXqkn55hW9Zn87XAigbbNWIpnQId3UAvBTV9SiIl
	f5gQfmk9JHNxmvuL44DdhjqUTCMqzcN9krBC1BfdK55iLXXPJw6cUA==
X-Received: by 2002:a05:600c:1d07:b0:4a5:87a:50ba with SMTP id 5b1f17b1804b1-4ac18e5dbaamr222388115e9.33.1793621757770;
        Mon, 02 Nov 2026 04:15:57 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:57 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:25 +0000
Subject: [PATCH v3 11/18] perf arm-spe: Use generic snapshot search
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-11-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

The new generic snapshot search gives a similar result as the
reimplemented version of it here. One slight difference is in the
pointer fixup. SPE has:

  *head += mm->len;
  *old = *head - mm->len;

Which gives exactly the same result but written in reverse order to the
generic one:

  *old = *head;
  *head += mm->len;

SPE also had a special fixup cases (if (head >= buffer_size)):

 * head > isn't needed because the SPE driver always wraps them, and
   __auxtrace_mmap__read() handles that anyway.
 * head == buffer_size isn't wrapped by the driver, but it just
   indicates 'full' which doesn't mean wrapped any more or less than any
   other index in the buffer.

Both of these cases are covered by the 512 byte search.

It also didn't have the special case for old > head for when the wrap
heuristic fails but the pointers showed a wrap had happened.

The other feature lost is that this search only looked from head to the
end of the buffer, rather than always at the last 512 bytes. This was
flawed because once head is close to the end, it's likely it could
contain zero padding from actual SPE data and a wrap would be missed.
It's better to err on the side of caution and mark as a wrap, rather
than trying to optimize by limiting the search from head onwards. This
can mistake old data as evidence of a wrap, but for false positives
[head..mm->len] contains zero data. This should be fine, as zero data
are treated as PAD packets and discarded during decoding.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 147 +----------------------------------
 1 file changed, 2 insertions(+), 145 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1ba803a8d9b4..8d6a2bde2892 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -26,7 +26,6 @@
 #include "../../../util/record.h"
 #include "../../../util/header.h"
 #include "../../../util/arm-spe.h"
-#include <tools/libc_compat.h> // reallocarray
 
 #define ARM_SPE_CPU_MAGIC		0x1010101010101010ULL
 
@@ -37,8 +36,6 @@ struct arm_spe_recording {
 	struct auxtrace_record		itr;
 	struct perf_pmu			*arm_spe_pmu;
 	struct evlist		*evlist;
-	int			wrapped_cnt;
-	bool			*wrapped;
 };
 
 /* Iterate config list to detect if the "freq" parameter is set */
@@ -497,146 +494,6 @@ static int arm_spe_snapshot_finish(struct auxtrace_record *itr)
 	return ret;
 }
 
-static int arm_spe_alloc_wrapped_array(struct arm_spe_recording *ptr, int idx)
-{
-	bool *wrapped;
-	int cnt = ptr->wrapped_cnt, new_cnt, i;
-
-	/*
-	 * No need to allocate, so return early.
-	 */
-	if (idx < cnt)
-		return 0;
-
-	/*
-	 * Make ptr->wrapped as big as idx.
-	 */
-	new_cnt = idx + 1;
-
-	/*
-	 * Free'ed in arm_spe_recording_free().
-	 */
-	wrapped = reallocarray(ptr->wrapped, new_cnt, sizeof(bool));
-	if (!wrapped)
-		return -ENOMEM;
-
-	/*
-	 * init new allocated values.
-	 */
-	for (i = cnt; i < new_cnt; i++)
-		wrapped[i] = false;
-
-	ptr->wrapped_cnt = new_cnt;
-	ptr->wrapped = wrapped;
-
-	return 0;
-}
-
-static bool arm_spe_buffer_has_wrapped(unsigned char *buffer,
-				      size_t buffer_size, u64 head)
-{
-	u64 i, watermark;
-	u64 *buf = (u64 *)buffer;
-	size_t buf_size = buffer_size;
-
-	/*
-	 * Defensively handle the case where head might be continually increasing - if its value is
-	 * equal or greater than the size of the ring buffer, then we can safely determine it has
-	 * wrapped around. Otherwise, continue to detect if head might have wrapped.
-	 */
-	if (head >= buffer_size)
-		return true;
-
-	/*
-	 * We want to look the very last 512 byte (chosen arbitrarily) in the ring buffer.
-	 */
-	watermark = buf_size - 512;
-
-	/*
-	 * The value of head is somewhere within the size of the ring buffer. This can be that there
-	 * hasn't been enough data to fill the ring buffer yet or the trace time was so long that
-	 * head has numerically wrapped around.  To find we need to check if we have data at the
-	 * very end of the ring buffer.  We can reliably do this because mmap'ed pages are zeroed
-	 * out and there is a fresh mapping with every new session.
-	 */
-
-	/*
-	 * head is less than 512 byte from the end of the ring buffer.
-	 */
-	if (head > watermark)
-		watermark = head;
-
-	/*
-	 * Speed things up by using 64 bit transactions (see "u64 *buf" above)
-	 */
-	watermark /= sizeof(u64);
-	buf_size /= sizeof(u64);
-
-	/*
-	 * If we find trace data at the end of the ring buffer, head has been there and has
-	 * numerically wrapped around at least once.
-	 */
-	for (i = watermark; i < buf_size; i++)
-		if (buf[i])
-			return true;
-
-	return false;
-}
-
-static int arm_spe_find_snapshot(struct auxtrace_record *itr, int idx,
-				  struct auxtrace_mmap *mm, unsigned char *data,
-				  u64 *head, u64 *old)
-{
-	int err;
-	bool wrapped;
-	struct arm_spe_recording *ptr =
-			container_of(itr, struct arm_spe_recording, itr);
-
-	/*
-	 * Allocate memory to keep track of wrapping if this is the first
-	 * time we deal with this *mm.
-	 */
-	if (idx >= ptr->wrapped_cnt) {
-		err = arm_spe_alloc_wrapped_array(ptr, idx);
-		if (err)
-			return err;
-	}
-
-	/*
-	 * Check to see if *head has wrapped around.  If it hasn't only the
-	 * amount of data between *head and *old is snapshot'ed to avoid
-	 * bloating the perf.data file with zeros.  But as soon as *head has
-	 * wrapped around the entire size of the AUX ring buffer it taken.
-	 */
-	wrapped = ptr->wrapped[idx];
-	if (!wrapped && arm_spe_buffer_has_wrapped(data, mm->len, *head)) {
-		wrapped = true;
-		ptr->wrapped[idx] = true;
-	}
-
-	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
-		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
-
-	/*
-	 * No wrap has occurred, we can just use *head and *old.
-	 */
-	if (!wrapped)
-		return 0;
-
-	/*
-	 * *head has wrapped around - adjust *head and *old to pickup the
-	 * entire content of the AUX buffer.
-	 */
-	if (*head >= mm->len) {
-		*old = *head - mm->len;
-	} else {
-		*head += mm->len;
-		*old = *head - mm->len;
-	}
-
-	return 0;
-}
-
 static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
 {
 	struct timespec ts;
@@ -651,7 +508,6 @@ static void arm_spe_recording_free(struct auxtrace_record *itr)
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
 
-	zfree(&sper->wrapped);
 	free(sper);
 }
 
@@ -674,7 +530,8 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	sper->arm_spe_pmu = arm_spe_pmu;
 	sper->itr.snapshot_start = arm_spe_snapshot_start;
 	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
-	sper->itr.find_snapshot = arm_spe_find_snapshot;
+	sper->itr.find_snapshot = auxtrace_record__default_find_snapshot;
+	sper->itr.snapshot_search_bytes = 512;
 	sper->itr.parse_snapshot_options = arm_spe_parse_snapshot_options;
 	sper->itr.recording_options = arm_spe_recording_options;
 	sper->itr.info_priv_size = arm_spe_info_priv_size;

-- 
2.43.0

