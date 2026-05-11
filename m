Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F737AA70
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501453; cv=none; b=U29vpwpK+BtOrS0hJEWkIePWpIsM1yginv/4YeU1NAOYYH2a2YUauVeL+ge3V853ryOtDx9DfkTJNtW6By5QLkA7vD5uvOMTqQVidajdabT/uc5wBZFgdGHtmPf9xyWGF4E5g+BIm3bUnVFN9XanuBBXuXTcH/xK0V3QfxF1Dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501453; c=relaxed/simple;
	bh=0BomszMGiOxdV6FznN32uKEm1zwH/EqmlPOFaV6I5KY=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d2Ix/w9eDeEOoyQkCaPUm0PC9hCD8oCVjei0RWHccp05fnxZzTaHCiGueBTtL/24NrW+hdQj+6mewn8MFt5m+AYa7UW5XYZlAPDRXUDZ+Y3JWV46C7cH50ucFurVUTVQ1wB9oK0lci4+r4p/cWItZW2I0Ga0pSA/SpwR4c5nwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFrTyaOs; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFrTyaOs"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1309f4ee97fso5112665c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778501451; x=1779106251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mI+NnshFv+rVKIicHj2ZZN9lAF3QcmIDhnwGPdhoHU=;
        b=RFrTyaOsB7sb5ISA6QdoU7rcvy5saMazmKyXfNzMvzLjiFE/fLrP+KlKMHJcTuoUvF
         wpTTUCkL9V0ro3Jh1XI0wxSjlGTFYWtm0UaeUhXcJC6dvwjI+VwPlQgywWR5ImH4OD37
         1P12w95uE7h+EfAHVkElwuw0/QG2DURzy9vPZm01a7DRn4AhnKdTHUBeXO293iigq6YC
         0sDRJwxRPeVO8G7oeRmPK/nUUBSuI8hwDDCnMxDWyykCFYoyE1dWxPCWkVcqBnOHKv/Z
         RseYvGx1t9raKr7/krA7+07FM46MpXYl4b0HfFYKvVyXs6nMkk0qJEgYweBhvgVyaGjG
         yviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778501451; x=1779106251;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8mI+NnshFv+rVKIicHj2ZZN9lAF3QcmIDhnwGPdhoHU=;
        b=Goek3L8fGPfTfqSmtd046FNYtXJsb+/GP81SQJXKMLy+wLMNj8oNOve2pmujUjS3mL
         /2hZ9w6opGiy224wI+BZ3dM1B302AOpePA9OufiIbiYrE9HMKBTgKz317o+QvxYBRA+A
         YBKk8FR3mmcUGIGCmzQ6E9fEngyMUjPrdICIrYykDX39pKp3iCVTSblDEL5WHXqwtb0M
         AA317Sz2zHIPLpZftQpSWFG/0kcVyd/oDFgDo78Vy1qK1hbtYyr4Tj9nA7UEGxIaV81e
         ILRMvEpyFReOyzUtEN8EZ/nDBBuEWooPIyJchA6HQy3u6qGaeyLljuCPJYXmsxalSKlt
         tEhg==
X-Forwarded-Encrypted: i=1; AFNElJ+Mogxm1PIwIV9ACtcjm3DsqU3ADxbT1bpkLH02dr883NJC10ISYnGYZb+JA7fgocHOETgPEcOu03n0SobPWCs0@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDvAgVqHS8BYYUkusP2hjA2XZAOUPGBPmKvz3It+kGWODQz3P
	oSQKIJT6XLipGGArOb8y0Kilk+XVk6vF1/SzJLVGAyNL0u3VglBeVngM
X-Gm-Gg: Acq92OHIbSbGWovgOsL/ukSLGONKUvOL2GdaL9kriwYxcj5eBS01k8avK7QSq2sTeqC
	jxxawAqDAI1Vju1x8dGIMMzGi0plQlv/CCoyvgxtwp9Mh891xsSCkG4V97HWP1TMUh9JR0Dw2UL
	P7slnihSHrSuqjhnjRtV6jJ5d1T/iR4p9Fkm2bimnQQVjGnzDDNNgPRAoKM5DYhInLEKQgLkiNH
	IjnpAxU2nYxym3yjipvsYg4cxb+x+/piraRNzHlWe7HDjPFdlOF1TbLPi/YJy2PkkN6voHDL0x1
	27yfJun15pWlX5hoNtQUmgmePip9B+B5UYZ9IXe3uYVWvwKGQ9/GDY1+tUyDsFjCCPmT22CmmhJ
	53hUUQs+7qqUAFUjOAsYIxK/HnywqrV5EmBtDihbwOP126qP9T1gXJgij6UiA9Qd6wXEQuBe9kq
	MY/wlXGJS9wVHXNYS4gg==
X-Received: by 2002:a05:7022:20b:b0:132:270d:7bb4 with SMTP id a92af1059eb24-132270d7ddemr9934959c88.21.1778501451072;
        Mon, 11 May 2026 05:10:51 -0700 (PDT)
Received: from localhost ([2804:2bf0:60e7:ae00:e8ae:88c:cb1c:61f3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13277bb2b14sm18095288c88.0.2026.05.11.05.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:10:50 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Mon, 11 May 2026 09:10:47 -0300
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tests data_validation: Fixup test header
Message-ID: <agHHR56pFGeDJOxE@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

We made a mistake by having the SPDX comment in the second line, where
'perf test' shell support expects the test title, fix it.

Now we can specify a substring and have that test selected:

  root@number:~# perf test truncat
   84: Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).: Ok
  root@number:~# perf test -vv truncat
   84: Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).:
  --- start ---
  test child forked, pid 62890
  ---- end(0) ----
   84: Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).: Ok
  root@number:~#

Fixes: 24be50a54cb38cb4 ("perf test: Add truncated perf.data robustness test")
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/data_validation.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests/shell/data_validation.sh
index 649f71b6cdb93202..f8fcc4c0448b0c51 100755
--- a/tools/perf/tests/shell/data_validation.sh
+++ b/tools/perf/tests/shell/data_validation.sh
@@ -1,7 +1,6 @@
 #!/bin/bash
+# Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).
 # SPDX-License-Identifier: GPL-2.0
-# Test that perf report handles truncated perf.data gracefully
-# (no crash, no segfault — clean error exit).
 #
 # Exercises the bounds checking and minimum-size validation added
 # by the perf-data-validation hardening series.
-- 
2.54.0

