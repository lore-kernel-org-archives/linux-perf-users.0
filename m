Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD7397E76
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080417; cv=none; b=LvoIKfIERAAqErPSd/8igji8xBHp5FDgdCe0CCil98o8UFVuTXr0Gna2EGZhbo+aSq1nGMbDQQHpTRFqPe27jOoP+YG8OE9g98GvoNFASW2K1W/GryMI/kVB/mNG88LUmh2CykQfhLKXODmPYxG5rg+fwKHGZEVa9vS12KppS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080417; c=relaxed/simple;
	bh=P1A/B5SEhFNrspl1jpQ5Vp/mmn/KnDLxr4+YZIHBwb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2z9VJQMqcdLQds6S0x7LVqUPj2Wuum3vK3JEnyE0GIcZeA5x89u0pExvqu/LBbJrBIpo+ROIsdpbNa2PuIgb13ghwkMwhyZ0zuwPbffgAfAxz+6vMt0cBH+C7lT37mSCs5P6ReoNU6iO+meFoBqyNJKXN2+uib7YEqm/HE1qzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbWa1+Bi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbWa1+Bi"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35691a231a7so100862a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 14:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775080416; x=1775685216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYk7+CLAHHn5x54H7ZOq36QjL/LAFfK40g57iglkRIM=;
        b=RbWa1+BicwEj21KKRfxLFuhmsEKcEIDIKGWsKQID1s+qDNaVGzpeJfE6ANUirZwxCY
         TbGncspF1aGq3WdSgszT/h0hOjfLqiucBxgJY/eksx7DSiz4amzwC9LFlp1Sz6efCBIF
         ZWxTI8imB9d3IIRAD+mmfc2UFDo5gyU5gm8tHybggcDJ8qRrY/7X7j2UP8/z2UTu0YHp
         Ehc1q3HhmSg+qiKnNJg+ptBZnnw5l7cxXGqM0S3P/9BbKzLKDNgLbu8+s3t2aZ7gM9aO
         WHUYzm1w/gPFTXdEOOZh+pfw71TW8k4eRftqZgRwKl7oEgE7Si6VKAL1YUkmR0I9TUGg
         mLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775080416; x=1775685216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYk7+CLAHHn5x54H7ZOq36QjL/LAFfK40g57iglkRIM=;
        b=imE6T32peQnYLE0z67ghXIsmVGzhfjleWpsvFOjF/F8GXogfjnTl5p2hLW9xExz5SW
         vLXZcrCbme+kclSXjaD1Vg9UBeBM89M0EiTW4E5Xymj72Th3bJ8A7apLvh+Qob+hwlX9
         Hi2djY09PqQYRAbyZWYC8Pxplv2A83KV14COWqu2WWgGXC9NEllB/Hq2qxXWBoL0NFzV
         liAq56hCBOJzofPKLt8Kf+Q26XvEk7hsC71bwEasQ6Z/7zxB7DD8gv9tbWAx6DaO/pN0
         2y5Yo/eHxB77oKQeKcAFqWhSfDoFeNrGKGvRKZtROD69dK3izmFg9dhZGtiGFxtOa1fT
         YYgA==
X-Forwarded-Encrypted: i=1; AJvYcCVOk6EqRc3kaoCvm+lKv/TIoKtxagsHL7VPW3khdmv+/JERwW02+/rIEZe25QiUkRaODiFJh+CDoc38r1WiDJiW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80aDvuiaA0qgAI3Xpt3YvdNQls4JM3MfGbhTKLDbTGpUNS4NF
	AGCES7RZS6Rq1BlzQbfUhdrMg/MIGVNX47lCxpiwg2qsEnV0MJKFC6iayHvq+caF
X-Gm-Gg: ATEYQzw/xx2/5Xk6CKBv+lwJTRicfrxAv/H8IKHgakPX9AL+HpSJR0CgnNb4ywPLgoa
	G2rxYjF7D6xaGHc/HgI3tfE/Y5Nq/DrBMPgo+prBWZIoHlwz9nrgRtwTykVTwF/rQnOhfaZJZB+
	EYPY+KA4BvsH8WQXEnanWg17bTITAKTvhfhzZnahJpS9vUldjo8OCF/fPk/57Ejru/jlr4vACXI
	b7DYWwDTZGRJERA+4iQL2AhPat71pPfjVGW2payQgR8/LTKFXTWhNhO2mEUHUvZK/EiuRGGmwJz
	hDxkAhxD2HY04d1qkohtGfwDJSEcC2hgoakdGsg0nozoP91xU0GOHn41uqMozpsj4oh8jxLpSUY
	RUWNeeeLoMndIlo3sBXRuVj1SKPGTdjtoDXzlkys10iyXCHniAeHmUknHd18dtBl7Xc8k3tp/ZE
	md2g1MVXIhNTDPHDRuWsIqtFjeGs2amG1WMgVorq7USBB+OcY=
X-Received: by 2002:a17:90a:e7d0:b0:35b:97ba:acee with SMTP id 98e67ed59e1d1-35dc6edc2edmr4890117a91.17.1775080415644;
        Wed, 01 Apr 2026 14:53:35 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34f9sm733641a91.1.2026.04.01.14.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:53:35 -0700 (PDT)
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
	brcampbell@google.com,
	shuah@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v2] perf header: Validate build_id filename length to prevent buffer overflow
Date: Thu,  2 Apr 2026 06:53:10 +0900
Message-ID: <20260401215310.348463-1-suunj1331@gmail.com>
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
v2:
 - Add warning message when invalid filename length detected
---
 tools/perf/util/header.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9142a8ba4019..132d360d716a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2545,6 +2545,11 @@ static int perf_header__read_build_ids_abi_quirk(struct perf_header *header,
 			perf_event_header__bswap(&old_bev.header);
 
 		len = old_bev.header.size - sizeof(old_bev);
+		if (len < 0 || len >= PATH_MAX) {
+			pr_warning("invalid build_id filename length %d\n", len);
+			return -1;
+		}
+
 		if (readn(input, filename, len) != len)
 			return -1;
 
@@ -2587,6 +2592,11 @@ static int perf_header__read_build_ids(struct perf_header *header,
 			perf_event_header__bswap(&bev.header);
 
 		len = bev.header.size - sizeof(bev);
+		if (len < 0 || len >= PATH_MAX) {
+			pr_warning("invalid build_id filename length %d\n", len);
+			goto out;
+		}
+
 		if (readn(input, filename, len) != len)
 			goto out;
 		/*
-- 
2.52.0

