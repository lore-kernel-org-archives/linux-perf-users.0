Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911436494F
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342806; cv=none; b=ceM5r8NGNz0DqSbMVYsFBSj5zCLbWRq23tTDz3vvhtI2nQ4tdcNAliLL+2Qbdz4JcN9B/rfxz3RrxXR+EJDGOmd1UpcT8llrmuysJaYnqbnGFGbEGw3EebNfLSTgkJOABApwS+Vb8cWL39aZtGrrtPXeyYaxIGuDRrPDxXSYlEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342806; c=relaxed/simple;
	bh=NafIeehy7qAQk5pJ2vGMUMh/svzPfCoNwcbtcWhGzmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ0FkUuLo2PF+pARCgyNC5jMt8YA3WJdoSWaGwUeqTPDqmQSSNwRK2qEGoGu7OPvW+m4OcJpPKfNe1yEEf9Irgbu0wO9hZOq4IrN4HkojP5oKQNxrR3XYymzKWnVT93qwBEbGHtNIm+bj0z6/0VdF+MtipGVwXjIAbudTMyNxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZOmyjLe; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZOmyjLe"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1275319a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 23:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786342804; x=1786947604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHBpsljhkqQJ5C4TvXDTCIZZMXkTz5hdy5kUG8mhWQc=;
        b=PZOmyjLeiuo9kbb5Tdsf0rr3d+WFhyMU26dSinj6Cm0/m5gmXO1yxMxFAaaJPMGZwW
         5VKub2iFykYRgUVcQw6Yx/v8cNwdeAPKqfrCvWHvUq90l7LCMVTTDbK4bI4ZIgrO9efO
         bGBu84qG8LMLg/S/s2rar89wForQPSIlYXXanhVLsJDVnyPxQaeg7ykUjXm5a6XKASO9
         h692t7fRm1CN9Cu9SHfX+WsFePojcleS5OSrn4ty5zauxILXc41TzsQtnqXoPskNDOH8
         1LfsgVt4+X4CHYfBW2Wvd4pF2Lpg46BcPUGbU5GTzUSjx3kF2o2/qFbuVT+svKwOKDSU
         13jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786342804; x=1786947604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DHBpsljhkqQJ5C4TvXDTCIZZMXkTz5hdy5kUG8mhWQc=;
        b=TC/o7z/NJjTc07YJ5SYn0WppHK+EwHrfcQ9Euy34UT0OplWL6Gds+1KltBSufp1aba
         AHMBgL7fMbUIqSp0dA+1Ia5wIA7ljSRhZUi5ApeOBPfSdCZbOzk+mxNVvK50jXfwC6SW
         BlnXc2vvAIzdz+sJGySxFMVkgwyz4fqlDYjXAcVSLdgldr8y3WRhIYwbQ9THc0hQtG40
         RdeaamwL7JHAGgprutzeoGMP7iiHAzjBXU1dU/tX3KEq+CdeB3sHJ8En3AjjfhEHClDC
         JmjkT1ELqaVq/4M/JkR9iXaCw3h5iH76IL9b6LyAqYkmFewxO9N2FNdseo6Xz/xEAj/6
         fImw==
X-Gm-Message-State: AOJu0YyKdby6wfp7NzuxyJlZjm+NMCVcsfAUgBZpztK0gZ6b8pohtpDz
	q10XzV/YqPQBLfV+siTEg6d81DBDyegZhTQw9o1NWWB4gxSk95YjVKfOZ6MwgUwZ
X-Gm-Gg: AR+sD10QWLqDAyXIpe4Wi3mcFLyBXpafutM3Kk3dnzBvLhv8K75Pk5q4qD9gH13Bk72
	WojGZSLNZ2DX6f6VP5uZtA5R1qCYlUYcKYkx6+rG5bqYyl9te5uIuOfOCvY/cmU6S0V5jM/SKum
	Uz48tq9m9nfvRe1FmZYsUFQwoqphyQp2laXvQcOGuBumc77jMQplg5qfgplj8rDjpfLo+HE/ALQ
	xnd7Gr0uPxXYBObMTWvQaDqlwki6YiE2raD+2iLKqQukpH2rRLo8hSEP12+m3HnMJIx5cZ/f5V/
	025u0WlhhubO57/y5AZVGnoSddcUTGjXGaIjbBDKQJUQvSZnx9gVGb2B/f27xJ0BK5qTAPkeu52
	vSKQ0QR/aIqy/MGPrkxKgaHCHm7KqGG3QCyeahZ85JhC9imuAwqfiYjPjEpsiR14+/963sRkJ4B
	jYG8z6HbQGDuf9RVW63pQNil93YOx9vzIWBoW5IflahWKgOexsjGMNnYj9TroA4xQ7BMsKXH9AE
	LVTCvj3Q6BUTDM=
X-Received: by 2002:a05:6a20:c91c:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3cbc0103aedmr27214181637.7.1786342803624;
        Sun, 09 Aug 2026 23:20:03 -0700 (PDT)
Received: from volcano9dee-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be568bd3sm37991648eec.0.2026.08.09.23.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 23:20:02 -0700 (PDT)
From: PVS Narasimha Rao <venkatasuryapala@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	PVS Narasimha Rao <venkatasuryapala@gmail.com>
Subject: [PATCH v2] perf test sample-parsing: Validate PERF_FORMAT_GROUP values without LOST
Date: Mon, 10 Aug 2026 11:49:25 +0530
Message-ID: <20260810061925.32498-1-venkatasuryapala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725084704.15463-1-venkatasuryapala@gmail.com>
References: <20260725084704.15463-1-venkatasuryapala@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sample parsing test only validates grouped read values when
PERF_FORMAT_LOST is present.

For PERF_FORMAT_GROUP without PERF_FORMAT_LOST, the contents of
read.group.values[] are not validated, allowing corruption of the parsed
value and id fields to go undetected.

The values are also handed to the synthesis as a plain array of struct
sample_read_value, which always has a 24-byte stride, while
read.group.values is expected to be packed according to read_format --
evsel__parse_sample() points it into the event data.  Without
PERF_FORMAT_LOST the stride is 16, so both the synthesis and the
comparison walk overlapping bytes and the test passes regardless of the
contents.

Validate value and id for grouped reads and continue to validate lost
when PERF_FORMAT_LOST is present, walking the entries with
next_sample_read_value().  Also build the input packed using
sample_read_value_size() so the compared fields are the real ones.

Verified with a deliberate stride bug in copy_read_group_values(): the
test still passes without this change and fails at read_format 0xc with
it applied.

Signed-off-by: PVS Narasimha Rao <venkatasuryapala@gmail.com>
---
Changes in v2:
- Also build the input values packed according to read_format, using
  sample_read_value_size().  v1 only fixed the comparison, but the input
  was still a plain struct sample_read_value array with a 24-byte stride,
  so without PERF_FORMAT_LOST the fields being compared were overlapping
  bytes and the new checks could never fail.
- Expand the commit message to describe the stride problem and how the
  change was verified.

v1: https://lore.kernel.org/linux-perf-users/20260725084704.15463-1-venkatasuryapala@gmail.com/

 tools/perf/tests/sample-parsing.c | 39 +++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 55f0b73ca20e..08dddab443c9 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -86,10 +86,27 @@ static bool samples_same(struct perf_sample *s1,
 			COMP(read.time_running);
 		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
 		if (read_format & PERF_FORMAT_GROUP) {
+			struct sample_read_value *v1 = s1->read.group.values;
+			struct sample_read_value *v2 = s2->read.group.values;
+
 			for (i = 0; i < s1->read.group.nr; i++) {
-				/* FIXME: check values without LOST */
-				if (read_format & PERF_FORMAT_LOST)
-					MCOMP(read.group.values[i]);
+				if (v1->value != v2->value) {
+					pr_debug("Samples differ at 'read.group.values[].value'\n");
+					return false;
+				}
+
+				if (v1->id != v2->id) {
+					pr_debug("Samples differ at 'read.group.values[].id'\n");
+					return false;
+				}
+
+				if (read_format & PERF_FORMAT_LOST &&
+				    v1->lost != v2->lost) {
+					pr_debug("Samples differ at 'read.group.values[].lost'\n");
+					return false;
+				}
+				v1 = next_sample_read_value(v1, read_format);
+				v2 = next_sample_read_value(v2, read_format);
 			}
 		} else {
 			COMP(read.one.id);
@@ -283,6 +300,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		},
 	};
 	struct sample_read_value values[] = {{1, 5, 0}, {9, 3, 0}, {2, 7, 0}, {6, 4, 1},};
+	struct sample_read_value packed_values[ARRAY_SIZE(values)];
 	struct perf_sample sample_out, sample_out_endian;
 	size_t i, sz, bufsz;
 	int err, ret = -1;
@@ -302,8 +320,19 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		*(i + (u8 *)regs) = i & 0xfe;
 
 	if (read_format & PERF_FORMAT_GROUP) {
-		sample.read.group.nr     = 4;
-		sample.read.group.values = values;
+		size_t vsz = sample_read_value_size(read_format);
+
+		/*
+		 * evsel__parse_sample() points read.group.values at the event
+		 * data, where the entries are packed according to read_format,
+		 * so build the input the same way.  Otherwise the fields
+		 * compared afterwards are just overlapping bytes.
+		 */
+		for (i = 0; i < ARRAY_SIZE(values); i++)
+			memcpy((void *)packed_values + i * vsz, &values[i], vsz);
+
+		sample.read.group.nr     = ARRAY_SIZE(values);
+		sample.read.group.values = packed_values;
 	} else {
 		sample.read.one.value = 0x08789faeb786aa87ULL;
 		sample.read.one.id    = 99;
-- 
2.43.0

