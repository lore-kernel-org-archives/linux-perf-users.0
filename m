Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ED834BA24
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770367065; cv=none; b=oxnnmoY1e6M2aCWHq2Qqe3t8QVaZYG5+8LH71jxSwCrhgMf/MRbtQnaGAo5qlIdw4U0EtMV5xxDNhom/LLQkAJwS9YanJgpeq8zWjP3P+JQHxrywoMA9h4pkFMWK1ofZocVGbtBq4mlcpP0MoBmAGjucBlDaEMBvn0dlvaLJbQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770367065; c=relaxed/simple;
	bh=7cf3Q4KHmiVi4dSbCQPoMApQCDUBQx8oKPaRX9XDLRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cryKlP7IroPePzZy6OovxQeT2UoL1e1kYWcibJ2ZHDtRfO89q6NM3UO6Geg3RGwBidIxYmYMZZh7SLw3Fi6YjCz5gbqVhSpSxXEs+IgU7bonvfSUwLGsYKV2MZGIF5lkaFJ6JWdWPII3YHj72E4rQPQ/FJqFxGMAqY8Lessse40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa+Qw1mt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa+Qw1mt"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so1050352b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 00:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770367064; x=1770971864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7+MBNlta4+CsUo9Y4/iyQi9VZ5Wuh/1sqTFilAIbn0=;
        b=aa+Qw1mtisTiIvJ68d6My9jCE0ylXL4NgckQ6i5cIuDEBc/6zuqiqSh3bQzrCumhV5
         yJSZJ1xGb4tEnSSwLsm5wkAFzZq1HJYteDT15DzMtovHZ6b3lgEYKG48UlEMNUfYv6vl
         HVDg61z0Z5+cB0bIe2UaM3PH/MR46at124UnEv7hw/74OVQ/Ca9mtB6YaWKOsaMw5/ls
         vc64b/L1IVCAxuoEVnAyhbckfqcvzGuuYjTcM4+Bd5y0iV8bLn7cbKKZl729wW57+KOr
         6jC/X8VLTidPvRjdFr4fiIbuhrexZXOWUuhX3cZZzjR4HgUD9iZDALT+GDPpeBo50iUi
         bbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770367064; x=1770971864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7+MBNlta4+CsUo9Y4/iyQi9VZ5Wuh/1sqTFilAIbn0=;
        b=eJqyFwgUqJQFkKd3D9EJW8XApuXXCcuX9Z/0FQJICpyzmSTGwjwPcha5PJXcwczsCS
         0pDdsu5CbSMoIYrysWOpNhTZXlupUgY2HB6oskY5DCbTcBYk4jX9Rozb34bh7shzIMu7
         WXnS/qJ+SQjtiN/AJwcl+XvMcyvrAy73hJX9ZjXrmlf+PdFELjoAd7fsL2RYhVgiGEaM
         ySGjlVepIrifIo5IlX57NyIDNxEbm8T0ykvNcMUsq/qCshUovQvRP4MiCQw9THPEpUuv
         Po04x56iGnLDVsljyLAyORRxDppse3Pa8Eva1sSTEIMNiQ/hmyepimDHbPD6aC0AEaaN
         6Ikg==
X-Forwarded-Encrypted: i=1; AJvYcCWMTwn5J/uokOQnWVaLiud4okWKJJgFXzlc3itedfsbxvUiUfs1xogc6nEp9SYXjDk5capNnJGqbr5f22hP01qG@vger.kernel.org
X-Gm-Message-State: AOJu0YzAfnk2+YGPdsjExzr9O7x7soU5s0OhTyCp19ep+dE6QHzZjymt
	rrwO8xBmtdkUPl4OO8f65rGn+ypmALSXjy2hk7TGoUxCq/ku2Cu3jc0i
X-Gm-Gg: AZuq6aLnvdSkc76GgnUv/CEbS34PXWcL/W8LTz5hk3gLOpz8x/xNBS9wXEsetkmpK2+
	7WNp67V2tqrb2y838Ttf4x8aHupiUt3ctKDSqeseo59Nt9ilz9WTM7vx0u7KSNrSvhQLTyn6aug
	4ko17aAE/IP8A4w2XPErwz2csr6B3EsTFZy5pal2yeVr2D9Cjlm/srF5LuAmJlcMbftkl5Zt3wf
	2b1UHQOhnvbZIh6HzmINMnNAb59ViBbGjInVKmk885sLbI5De0xTlYj4Z44a56yDuVlgMNkD9i1
	1ofLEUa2mkbnAj+T0nV4BDyMbl/RpqrH6J5AsUfzyBYks1NQzNT5yg0icFt7UH2EIN5o86IErf+
	UmhHeJp3A2tLDJ3LH6HKGwBFlbN0jWVf1H1FeYLN/FzZyQtv9C21NXTBN5uGWmNeY2GAmcA+WZm
	6ZZB9SlWUkAheowmU445zaPaszrcBUIPailMQ=
X-Received: by 2002:a05:6a00:1945:b0:81f:1a4b:bf50 with SMTP id d2e1a72fcca58-824416f72aamr1699730b3a.36.1770367064489;
        Fri, 06 Feb 2026 00:37:44 -0800 (PST)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418812d2sm1788185b3a.43.2026.02.06.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:37:43 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH] perf header: Validate build_id filename length to prevent buffer overflow
Date: Fri,  6 Feb 2026 17:37:21 +0900
Message-ID: <20260206083721.2277438-1-suunj1331@gmail.com>
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
perf_header__read_build_ids() and the ABI quirk variant.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 tools/perf/util/header.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f5cad377c99e..208ccaa62399 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2335,6 +2335,9 @@ static int perf_header__read_build_ids_abi_quirk(struct perf_header *header,
 			perf_event_header__bswap(&old_bev.header);
 
 		len = old_bev.header.size - sizeof(old_bev);
+		if (len < 0 || len >= PATH_MAX)
+			return -1;
+
 		if (readn(input, filename, len) != len)
 			return -1;
 
@@ -2377,6 +2380,9 @@ static int perf_header__read_build_ids(struct perf_header *header,
 			perf_event_header__bswap(&bev.header);
 
 		len = bev.header.size - sizeof(bev);
+		if (len < 0 || len >= PATH_MAX)
+			goto out;
+
 		if (readn(input, filename, len) != len)
 			goto out;
 		/*
-- 
2.52.0

