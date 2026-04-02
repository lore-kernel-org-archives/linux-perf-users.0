Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8D3EC2EB
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145881; cv=none; b=IBI/UQ3lRFgj12DGYpXjX/RZpwtLrsWeHptoyT2/DvkQP2cIYytA7jXiFrH1L83wHs4/JK+IqCq+bY1PDlauDnk4O/Wh2G06Zg5kWAkyMWFEH2sLGcXZlBxXbYodI84VfwPN19Rj16NFQEVeOGzIlUBWVljp4CqZDcF1dPa/te4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145881; c=relaxed/simple;
	bh=vbR9luJi2b5bo/PrlmldXqoQ6slG09mFuhpP189oVoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inOoJ88JJFPKRRlAqwHgHAUcWypWthF1FviAevurp5pOf8TiEvDBHmQ2NICG99cq7FK7B67kLYBzGEH/50G1L7j/SjDdv+96fLsw1mP/b3pDK1N2yyLQ85yenRT38GgHB8QwvztCyJlqivw730RhoeaH9aBx1Gm3zQEIw6E69P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWyBXilU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWyBXilU"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8296d553142so493391b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775145878; x=1775750678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=prBjVrj8/bfyqPL6p9NnkzgN1t0pLTHzzXHQ/VzSqEA=;
        b=dWyBXilU7p9gu4PeZY1vyxV7rHmbImctKB5DTvxtzeZ+VauA2EUW8c/3GMaokh+or+
         bxpByONyHDf7wM67FVzcnIYd2wjh5erM3qpl8fWIpoXbKRbgcsjcf0CuM3IgEcD0CMD+
         sZtBksbeIHxe6wwf4Brvp9cPNR1epHHaTVFt+CgKdAAQQbqSn9eCcblyga4Zjp8yhr2Y
         4juDHdiqzQ/hfsdZ4FAKeREiqGP/qc2e7STh0wMrYK6o6pSXZT5fdoJ6trXb2yGXRO5p
         mFKO9nAK/67tz+uPIz8oPDSPVj01mVoNynY/TX06eIsyyoVVwDplnLbppUIfAYinQB23
         EDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145878; x=1775750678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prBjVrj8/bfyqPL6p9NnkzgN1t0pLTHzzXHQ/VzSqEA=;
        b=iiJ+L6OgvZN/yDZkvMXbKaYueT89JgeD84ChOQoGeCZjuQBScba6WQBRotI2SpGoav
         HFLaIlesUHaKNHARO2NQ5JBH5BjpPFjBqVU2JpGm1fI1t2I5j7k/SkD3IT+Do0n4kIdM
         3GBtuORjmq0H6cneJFuj/uo7tNP42FfpIxe+XEaaDVtVp49uqCkfZtJr6Kcm5oLTaVvB
         nnTJzeMrN+dOkeWzBLWlhBNbrahsrSC/zjoL9G9exURqtaDZjNPKgTCo9ERzS1ooVNDF
         AGB2Jr4wu/reqttJyG6y2dmMxO/BtZzrlr2IArEfXzwH2PHYMBBgnCUltnykMs/IJRld
         oITw==
X-Forwarded-Encrypted: i=1; AJvYcCUetm3GVm6inNmd/lmrVvBwdf2bjmALntNT3sNeN1oC9yRSRWwxtyRlazLGjDAaV+qfHKdW8yqo0F3xWv/qEaNQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJQkbtIt1w0uy5hrPbWwDBFmVMXP/9lSGB0dd7EGljW4YkAh5
	5IFLbBFk64AqNDRllXoGtW2i57SCduFD3vadr89L07EyddERtnKmZAHB
X-Gm-Gg: ATEYQzxSl0lKTgU04/uSMX1rIJOeL1ouRElUuYiiwEYG7HY1iC0v5T49h8LHuCWLhL/
	ZOLyB83qvV3OwG18KjE+j4v7HVXwNCOdBcUg8xfzWtGkfB1B7HhCakB+uj6k/vVz06NqBw9SrnB
	GpGkoqMlCtj9h7s/sE5UZcUnoCHWEeGT/dl8Q2OOQxaRvnSjab9THAorN8N2QIHnK/wgFOiTJ4H
	wvM28bpxUeRGLMHM3idvdnFpRuW7Ut5w45lTHVwvGx/zukxM8v/Ulb8SrCkkkzpS2bKjE2PnRj5
	E1LGKUUuyy8dXI23x6W3RJx6ttXJ8H7v58cx8reaYEVkrbkKDwENqfZ59Cgi0IWcJyIo39lpEUm
	okgyr+AueG02cN5lPFYGycPt6/hTrUvsvyT8MHU7ezG0IcR1nHrxii6Hj6QIlw2UfGBPXXAVaOg
	AQDKMY7ADWmzgBTgH0gwN20li0/HSnpcLwoNl2m1kLP+y8g9Q=
X-Received: by 2002:a05:6a00:298e:b0:82a:7f1a:758c with SMTP id d2e1a72fcca58-82ce88c0f1emr7664298b3a.11.1775145877863;
        Thu, 02 Apr 2026 09:04:37 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cfebe5b23sm2822987b3a.59.2026.04.02.09.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:04:37 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	me@brighamcampbell.com,
	shuah@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v3] perf header: Validate build_id filename length to prevent buffer overflow
Date: Fri,  3 Apr 2026 01:04:10 +0900
Message-ID: <20260402160410.425978-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The build_id parsing functions calculate a filename length from the
event header size and read directly into a stack buffer of PATH_MAX
bytes without bounds checking. A malformed perf.data file with a
crafted header.size can cause the length to be negative or exceed
PATH_MAX, resulting in a stack buffer overflow.

Add bounds checking for the filename length in both
perf_header__read_build_ids() and the ABI quirk variant. Print a
warning message when invalid length is detected.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
v3:
 - Fix printf format specifier: %d -> %zd for ssize_t (Sashiko)
v2:
 - Add warning message when invalid filename length detected
---
 tools/perf/util/header.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9142a8ba4019..9ffc0f4ca6d1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2545,6 +2545,11 @@ static int perf_header__read_build_ids_abi_quirk(struct perf_header *header,
 			perf_event_header__bswap(&old_bev.header);
 
 		len = old_bev.header.size - sizeof(old_bev);
+		if (len < 0 || len >= PATH_MAX) {
+			pr_warning("invalid build_id filename length %zd\n", len);
+			return -1;
+		}
+
 		if (readn(input, filename, len) != len)
 			return -1;
 
@@ -2587,6 +2592,11 @@ static int perf_header__read_build_ids(struct perf_header *header,
 			perf_event_header__bswap(&bev.header);
 
 		len = bev.header.size - sizeof(bev);
+		if (len < 0 || len >= PATH_MAX) {
+			pr_warning("invalid build_id filename length %zd\n", len);
+			goto out;
+		}
+
 		if (readn(input, filename, len) != len)
 			goto out;
 		/*
-- 
2.52.0

