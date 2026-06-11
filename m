Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00003DCDB9
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176441; cv=none; b=kt7Si1b76U9qfhblId3Z3QQoPUJud4eFQSBJ/jUKYKRzrkDopDcmJn23Q6pz+8GITAhRN0aed+8YH1bMHi17cGsHO7QSZhmIXVjslfR6ug8rcyVf2Zf1jjHNiVOQF2uiF55u1aqVO1cFSRvgPOx5WMyvPo8akWTq5x3Xb9KZ88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176441; c=relaxed/simple;
	bh=yyOMn7voOOX1yeWWnuZnlD0zWPd8yrmXuFoLFuKARM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P4H72oD9PWupkRAOnJaXHQIhve1yBmT/WEdmlxoQiuUlkSA4IovU5j4XB+IYfwiQfKQ7dw7cVNVdjFavCIvKVgCAl/7Y92gusvqNoyE4KBPEoNQdI8RCBNCt6alORI4V47cACJzyC0JjmXRbaTF4WDEzfnhlpTZocI7p1VdMkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kn8cBewU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kn8cBewU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b12270b3so47206755e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781176438; x=1781781238; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OL/I1lJYAZFqSuvR9Q/L0NeE9ZsXtQyi0URceTw1J7Q=;
        b=kn8cBewUGcDdgvVhCBmKv2G0111RL3Ni1O1Oz5RJWqan4zDvfplkIVwrc4ZpjGvRiv
         SDo9bQzwQTEHAEN0JKqlFfF5NZHzIUMT2ULrBkPlY7+esAQM9p40nI+pKZdhDB46rL9D
         +skg8vU+ciYi26+LDTpHFQ7RU7cBI5gMVUvOgWXUWOAO5tmDvKda4VcVF8NYoouWYRAu
         omWrFuPWPcYQnGvZHbiRsiPMVyhNd6BItGVIqjcfKl8cKYkQ5WteeRSaogRZRihFSucV
         3gR17QImK3IhmrpMApKNixuLY4QYujzLJ3KpR0YYkvp1X/GYE1XBwJp7oN1STGVq17lk
         d2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781176438; x=1781781238;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL/I1lJYAZFqSuvR9Q/L0NeE9ZsXtQyi0URceTw1J7Q=;
        b=SFzBuHGHub+LzaxnBOCSEyTWdVYzPZ5XnWiim1XfZQLyrsxhU8tSZxHY4+6HNPD4HX
         DYD3gsizl+QMucQ04LDEC6hexTwIbK50DRGNJcwM42IuSgmMl4njiAJsDPJQgTfsXsM2
         7Rv7vXlKPcsPki6IATpgF8VrD4vV+7BLyAvmyttYGTo7uJnZMj5/LdvlPGoCECfRcJSp
         SunZXNviI5etHOXsB6A1Rwo1aIIcoRE5kdMXMZ5TUMcBCtRBkMCUs92z1/DuC7PyY/dd
         JILR115rZWJXBJCZAzQM3PKWucJZfgNClIjqf5cTX995VUGZXqy7QJTXKymRfDKemxX9
         E3Sg==
X-Gm-Message-State: AOJu0YzJG5rA16SIKVVA9UqMR7TnvXlEyQESxzVHmIxYu58MNRoGf5J4
	M/Ws59RTOAYxoiq0YtSNfamG+2Bm45S7hxFkeQV914UrBArbNdT6m730sZfy/rWNh+Ql4GNo3/u
	R9u6nP58=
X-Gm-Gg: Acq92OHqzrv5KExXIFfrfBv0nf2xigWnsqseOQDyRKhfSKdHzVFNRc5ZWtWQHKWZUsZ
	y9eM1xFqaU3N22WcayVrxqKiEZiLKBWqEcToVaNLDIwc2m/zc9SCeGOZBsq+XzcGaNrbcrsBoH1
	WvfIJNs3CVsvfxMLJGvXH0XGaA9fbxCKdQShThUkNX3cTRFiYq4Ve3yhLYa/HDmLxuGad1PBqKy
	kKbrlbjiN/inwFESmqwMvpmPGWFcMIX9LN4MABNhrP62WX/KDaAK9QH6hxQ7SgBFDZw/htjPhPn
	J8TuSibKLzYtjk0KZiQHRNu1M7BOS4fMlaj0hySbyx3ca/0An5pP3xKnLoc+J0GQImz3tKny5wl
	QPWGfbcLLDwLdDJLpsQ7UtqVli7caac4u51MCQKLrC+r/3sy33nfwvEb2MUOjCOMKi679POTu5B
	1FwQp3w7HoppP2P2GY3RMrAEtHy5unA37KIS62dm0ZNkUutl0+veelbw==
X-Received: by 2002:a05:600c:a39b:b0:490:c08b:b24b with SMTP id 5b1f17b1804b1-490e5607e3cmr18134915e9.26.1781176438157;
        Thu, 11 Jun 2026 04:13:58 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c7ead0sm64587515e9.3.2026.06.11.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:13:57 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 11 Jun 2026 12:13:46 +0100
Subject: [PATCH] perf test: Compile named_threads workload with -O0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-james-cs-unformatted-per-thread-fix-followup-v1-1-3c855d93dba8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGmYKmoC/x2NQQrDIBAAvxL23AWVIKVfKT1s4tpYEpVd0xZC/
 l7pcRiYOUBZEivchgOE30lTyR3sZYB5ofxkTKEzOOO88dbiizZWnBX3HIts1BoHrCzYFmEKGNM
 XY1nX8tkrTjRFd6WR/WigJ6tw9//d/XGeP5F0pHN+AAAA
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The work loop relies on the compiler not optimizing it away, although
named_threads_work is not static for that reason, the compiler could
still do it.

Fix it by compiling without optimization. Also add -fno-inline for
consistency and in case anyone wants to look at callstacks.

Signed-off-by: James Clark <james.clark@linaro.org>
---
One trailing Sashiko fix from the "perf cs-etm: Queue context packets
for frontend" patch series that has been applied already.
---
 tools/perf/tests/workloads/Build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 75b377934a0e..7bb4b9829ba2 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -26,3 +26,4 @@ CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_inlineloop.o       = -g -O2
 CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE

---
base-commit: 7336514f41e75d44782fee7e0990d4195a3d3161
change-id: 20260611-james-cs-unformatted-per-thread-fix-followup-babf28a4e640

Best regards,
-- 
James Clark <james.clark@linaro.org>

