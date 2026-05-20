Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4E402BB7
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304007; cv=none; b=WBiKi49jldUtzDPEAsFDZb0gpLv61oR+VBijPlUOOZxJ1U6ey+sOjs0irI0vDhtHz4eQxKfpfL0gy3pIS7Bw+WasYTBNQWnpx0oLdAxOO+6UDSedN7f/Gd8L7jRONly9oZRfGuQJygHsOncxv5TpjlPiXjeMJ8RVSTsHUp5Ubrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304007; c=relaxed/simple;
	bh=IJf9f5gBGPXQRyqhuKQ8MtrZco6GI6Yl/g2IJKS86uY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gkr6hBFxR/XaP8JpQpxmdAHHzx8zekpQPEwszZ63SgleP07+ZCJcXHz88W7hwSBiAgdRdHLk6UxBdsZnXFf4RCcm5K+h0OdCZSxwCUn/rghU6+KeQX1bLbaSglBBcwk7hLu43cvajEIyCn7/n0Oe8W4Lx8uw5lsS4zAjMvLhjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xrs6ZtOL; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xrs6ZtOL"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so4216095eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779304006; x=1779908806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwoetoWzL8SUKh5c5P4WcC62lyplDGclzx4nbXOsyhw=;
        b=Xrs6ZtOL5KVMawUujleStpgky3q5nzdt1dUjFHwiNhNZF/NUK/rCBjoImh/0ZArM1k
         bBxENnX3Rfp3yDGfoswOMfbCOZOCG4RCDeegv1KLcIWJHWuWb6suhjFZPRMOGO6qreHu
         m94WNJl1iJCivgfydZnexAbHzDo6lwNPx1v7MH3F3J3U5MbVw0cGYUsGVHdk37sWRRKG
         UglEyzSAbABoX6jwSOBtZg+rSJFHBYO9Fn1LBYyFK4zYCNI43wBCibX5Iq56JsNX6uD7
         QNN1HZrEPX1GRCDHb5jSM3Fj1vv9XJ+QQkXn7P+KVn9UQRw+UV1RM+Ka3D5Q870TBu5L
         itBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304006; x=1779908806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwoetoWzL8SUKh5c5P4WcC62lyplDGclzx4nbXOsyhw=;
        b=eDqWkIE1VWGRhAvgFMs5fbVDj/rFAy4RvQwzy9RIBdxgEWtD3BOIeTltIbqS5aFiAS
         OzdVlh5it+23SOd8HthyH4iuhLDEY/5fevc83RllHrqbzLURFBZtt9BM+pnrxlfVIkZu
         1SKzwM3OisP6TEw+tqgLMNgHAttNrE0wQMrkVnoy12LiA63jxcd+CoA7BY/ihjmjEJKb
         40VowBcr+d+kSucvUVL85w9mEiuhRYT1bEEjw0ojXtrv3aCSj3dCF4+/twsn3qkM+ZH3
         QHYX4EWgdFd30Hj3NtZiYaJ1UA24z9ybkprcl59yI1KrCIdK1LpezQSO305z81gohkld
         pSXA==
X-Forwarded-Encrypted: i=1; AFNElJ8tWK+sWg1YfhI40zUlqloKpsDCvJSm68QFGR5RQCc/8xFy5Au5xVUWk50BB3TqvmhyT8G74bl5fM06QTznVrzW@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkgpCTc5zzTQPClRrqdA218pCXWO/xckiG/2ggm9JNX+QoJHD
	AwQQhNZaL28X2Ppw5NkB2W1QXjw9sSlJVTedF4P4MDeukwkpqIzHhgSeAR7aI6fSzUpbxWkT4Lb
	UGbEtWaLC5w==
X-Received: from dycaj11.prod.google.com ([2002:a05:7300:fb8b:b0:2e6:f22b:f849])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6ca6:b0:2df:7882:1cf3
 with SMTP id 5a478bee46e88-3042b30768dmr470549eec.2.1779304005319; Wed, 20
 May 2026 12:06:45 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:36 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-31-irogers@google.com>
Subject: [PATCH v14 30/32] perf evsel: Add bounds checking to trace point raw
 data accessors
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

Prevent out-of-bounds memory reads when parsing corrupted or maliciously crafted
perf.data files by introducing robust bounds validation to raw data accessors.

- Add a helper out_of_bounds() to check if field offsets and sizes exceed the
  sample's raw_size boundary, preventing heap read overflows.
- In perf_sample__rawptr(), properly resolve newer relative dynamic tracepoint
  fields (__rel_loc) by checking the boundaries before and after reading the
  dynamic field descriptor.
- Byte-swap dynamic field offsets and sizes dynamically when endianness varies,
  ensuring cross-endian parsing is robust.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 54 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bb48568b8101..713a250c7374 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3700,22 +3700,63 @@ struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *na
 	return tp_format ? tep_find_common_field(tp_format, name) : NULL;
 }
 
+static bool out_of_bounds(const struct tep_format_field *field, int offset, int size, u32 raw_size)
+{
+	if (offset < 0) {
+		pr_warning("Negative trace point field offset %d in %s\n",
+			   offset, field->name);
+		return true;
+	}
+	if (size < 0) {
+		pr_warning("Negative trace point field size %d in %s\n",
+			   size, field->name);
+		return true;
+	}
+	if ((u32)offset + (u32)size > raw_size) {
+		pr_warning("Out of bound tracepoint field (%s) offset %d size %d in %u\n",
+			   field->name, offset, size, raw_size);
+		return true;
+	}
+	return false;
+}
+
 void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
 {
 	struct tep_format_field *field = evsel__field(sample->evsel, name);
-	int offset;
+	int offset, size;
 
 	if (!field)
 		return NULL;
 
 	offset = field->offset;
-
+	size = field->size;
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
-		offset = *(int *)(sample->raw_data + field->offset);
-		offset &= 0xffff;
-		if (tep_field_is_relative(field->flags))
+		int dynamic_data;
+
+		if (out_of_bounds(field, offset, 4, sample->raw_size))
+			return NULL;
+
+		dynamic_data = *(int *)(sample->raw_data + field->offset);
+
+		if (sample->evsel->needs_swap)
+			dynamic_data = bswap_32(dynamic_data);
+
+		offset = dynamic_data & 0xffff;
+		size = (dynamic_data >> 16) & 0xffff;
+
+		if (tep_field_is_relative(field->flags)) {
+			/*
+			 * Newer kernel feature: Relative offsets (__rel_loc).
+			 * If the relative flag is set, the parsed offset is not
+			 * absolute from the start of the record. Instead, it is
+			 * relative to the *end* of the dynamic field descriptor
+			 * itself.
+			 */
 			offset += field->offset + field->size;
+		}
 	}
+	if (out_of_bounds(field, offset, size, sample->raw_size))
+		return NULL;
 
 	return sample->raw_data + offset;
 }
@@ -3726,6 +3767,9 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 	u64 value;
 	void *ptr = sample->raw_data + field->offset;
 
+	if (out_of_bounds(field, field->offset, field->size, sample->raw_size))
+		return 0;
+
 	switch (field->size) {
 	case 1:
 		return *(u8 *)ptr;
-- 
2.54.0.746.g67dd491aae-goog

