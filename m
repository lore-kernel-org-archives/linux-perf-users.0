Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310018CBE1
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969243; cv=none; b=k5cLg+8sJ0OL7pwtXtLzXhXbcJsQWI7sPRq1ZE/EpoE48hYLvz3Gosx1J41pPZr0jMku9yy5L0xMiFiBxMv7ZIdVcar0PHAY4DwB8OQiyo2jlSSkM48NU1uvPkDbDgU2i8VZw4oSqgJUnDwSZFLYu4qSXk04NwY8pEf2OSwm0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969243; c=relaxed/simple;
	bh=DgDF3WhnZk9l9uKfLhq44aHaPlmyozIqgEYp3gKKdwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCUQFIezcqmyArFauADs1v6VrYu3iSMyOuKjRXPWIksaDb8Ur4iXVl0IbfqU5d2FLTDTzhbSf4zL6TAxrXbQbHz4U/SzbDxL1lpt8W52OMAkf9Kr237BxfeAisgKXcIH/qVF01VZJvNIKd6j6V9pgHvRhfSarRQ74a0+xY5y49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx1+OiNH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx1+OiNH"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9aea40d799so642419a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784969241; x=1785574041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w3PcKv37KY3SekHvAurcVufQl385V/ea4OF48uYkD+A=;
        b=Gx1+OiNHHrSJ4Ksv7Ka5EFFtfqWfFTX0zg40XNY1CHD4V562qCSng0GcvVIgdVYNeO
         4sINcOfJkZSBFr8OgfhaOJWEcHgIlV2ZsBmmvPVMdo0nbCij1YA7h0B6MnC3klvzWe1g
         DbHJFK7303sb7doCZdhUxR/48N2KDf0h7AQ/75li3jGjnxN6tT+XNaT2E5XAb+TlbFjE
         jf4ROFMvYq/QF+PFiyaZTSwfqM85jJtk76bGpNK04QzaWUwwGZ1EtoiZqowCWbuSew4v
         85OkkFsB1gwutOzOX8z2TdcW7NuyQ2nDQRgU7YSXCOB4Yv+LI64zStGlc0eTpGiyYUd3
         P15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969241; x=1785574041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3PcKv37KY3SekHvAurcVufQl385V/ea4OF48uYkD+A=;
        b=JvmDCZmZVo4rEHIhlDC4Pjj+UdWFaYLU2fCYl9j5cSzRyXjWOQufS6c4rECgiBHTdT
         GvrZQc1+bKhAYOszZp1ZBLbWEakHV2GvcR71JTnuiseQ13XZQ6Vf/m3zNQAem/PKsXur
         PrwHTlJ2cqAkJpJmvOrW6MrggI9KWCPhGn5yKrNtvSb4r5AsEwi9yvxtNEVQJtPSgCYX
         1lDZ4OI6XcCtYKSSBmwmfRyOzt7OB6dqVdYcAHiFV0GhxLBgmbPrPfB+0qdRZerpU7uG
         nVK2HnLX+A4DApIMI9jIWY0w6HSloFS296xdPyHNGHZy4/v6w5vywjWlgM/sboVL7LyG
         xlMA==
X-Gm-Message-State: AOJu0YwIQsJGcK4CHYf9u/oVhVfYPjELT4H4oBlN0gYVHaIY7TW351DC
	GEKeF7ef7Un6RSRjllBBAj9nMoDHPD8pqwA9bcac2it2AZZC9gH7J3YAGyyKLEEEqFk=
X-Gm-Gg: AR+sD1343LKUkdtlGWab0UeSoAis7/3d8UzUXGCZpNY153lIwXoiNOYD4+UKtnFld4M
	Sl5TVZmeAxRthCYX/TbqQ/AToPpPSIxdvFWk8taoOLoCfEsf9yuUwyapeZLZwKvSoi0jLAoeB41
	gCnwYaqt5lW+O/BL2CT+UmF3pEtMfnCgBUXbp4jzCMVxZE2t/EEbA+WJMOk5Ai2ymLyJ4sj0OK+
	umLtVVifi2ynA+nhf1ywXgOjjcTHzjxJ/JA3+w7O+2hbQkQA6/PrA11UrnpM6jDrhlntEHpm7HH
	BSiynthuhIh2q6fOryG7u5rIOpr8enoBfj42JhvgpY9ZfDB2GuNlSVL5cdcPxvKu3IPb5RddUKK
	xdUSyYFnT2Ag4Zp8dchAZgTFBpJO64l0LKXVibjHmeTL5vMUnpeItlHUXlFDTFdEcV9LUfJJDes
	wXa2ZVZGVVg5v0w8t/nyssetO5QbFox+1GFjD5DwMgXovqMtPOwMW95oYt4wBu0v8dcnCR9FAEf
	8oxl6hIBilSoKNK
X-Received: by 2002:a05:6a20:728d:b0:3bf:a0e5:999f with SMTP id adf61e73a8af0-3c67da7543fmr1503753637.22.1784969241106;
        Sat, 25 Jul 2026 01:47:21 -0700 (PDT)
Received: from volcano9f6e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5a04b2sm7580774eec.28.2026.07.25.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:47:20 -0700 (PDT)
From: PVS Narasimha Rao <venkatasuryapala@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	PVS Narasimha Rao <venkatasuryapala@gmail.com>
Subject: [PATCH] perf test sample-parsing: Validate PERF_FORMAT_GROUP values without LOST
Date: Sat, 25 Jul 2026 14:17:04 +0530
Message-ID: <20260725084704.15463-1-venkatasuryapala@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sample parsing test only validates grouped read values
when PERF_FORMAT_LOST is present.

For PERF_FORMAT_GROUP without PERF_FORMAT_LOST, the contents of
read.group.values[] are not validated, allowing corruption of
parsed value and id fields to go undetected.

Validate value and id for grouped reads and continue to
validate lost when PERF_FORMAT_LOST is present.

Use next_sample_read_value() to walk the variable-sized group
entries.

Signed-off-by: PVS Narasimha Rao <venkatasuryapala@gmail.com>

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 55f0b73ca20e..e44b01e5cd14 100644
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
-- 
2.43.7

