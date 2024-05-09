Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5410979
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220936; cv=none; b=GyrZnyhP54oMGy5hQxw5umzhCjV25T12T15iIKstpTi7XHtOxFinEApifxE88yKaKMcdTl9jjzTWLcGRdO5Z9P1BRPwap/x+wx3tCm0rg9DLtadUILBRToj2qPNA9Ks31HPt+vhxsmaecNQy0YkmDKmSZXsvfF40J6MIFC78Fzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220936; c=relaxed/simple;
	bh=cEBY9zNad/CbVuGio2649yYUayh6sDVpr/Fwie/CGc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmVPZ5OdaI3ii26k6TKHvGB3QiERFoyWdIbr4uL3dVQhSfexaTVgAHoDy1pUP+fKIQLz9+T6a1bsI098CfCrDarxFVRi5B/m6VbXwDTyVaUu74dxiITk2xFSA4QFyLgbAPhEvFXyyDnX69CSJMeeiCIA1BpOgVR8pVnOrS4Lk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=T6SvkGKx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T6SvkGKx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1edf506b216so2459325ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 19:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715220934; x=1715825734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/LxNtjaBbEya4wTYzu0ZSg1ZgQ6teLqCU1lCSZ0Jy4=;
        b=T6SvkGKxt/e3Wq5eIrCHWoFpM9hBTc5CUzWdHwa32ypYKakVRAC3DdUzDOtJuebRnh
         GybAVe3R6cF8t9nR6ZzqNCcUX46/a5baO4La73fEMku9TFCMtox2yllkw/egsPck9iQ1
         r4pnKwuRIGLD7mb63bxdqzbIGMTZrKJc70gS66kQ1snSbd9wVZFIZwAHk2vj6ZfoUgqi
         Z7AY7+rU7T50RrU5T6xZcvxvzHtraC3SeCaruFCsAxVK/sX11B/fxPQDclUbYv7lOK7f
         coThIfF2RuVBW6VDFBggQGvWlo6ReWZOr+njHXVb/IB2a+6bo2x4hbZ4/n6ZoKWglrJo
         qa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715220934; x=1715825734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/LxNtjaBbEya4wTYzu0ZSg1ZgQ6teLqCU1lCSZ0Jy4=;
        b=PQNCkENbX4Wf3UKILlNo5BmCtKPJkNUoSVtklUnjEqd5k3Zt2ldojq/T7kSMbYzpmb
         OkzXnywSJz5Tsx05Zv6sJI1ncrzlzv6rlOjHd7bnhXsHBYtNugkjvEasK1UAI0yrqK9n
         UxrCCbMaIjvCsh5jlcQ/rVL93y5kWc24pRPfzMJnneWRTvdfjnn4W0xBYhDYLDkIAqDa
         8a97+bimsqz+1++ZOvGth8D9YbHhJKJt0w+mVelW5/N7gchjeeG2W63AbNCQnhfy1Y9w
         YlUOKsnlDhGH5jMPfQaWyDXBkHqLaQCPy835z1xfMoZNqjd/ThZc5gXv8zsnJLwQ1omU
         lEwg==
X-Forwarded-Encrypted: i=1; AJvYcCUKHJbW8ER4E8R2HjA8Oq7mTiQzg5S0fr3hZP57E193M0fJMboPSK2BNblEIrZCE+uA3vOh01/gMcIp6fmpoINouqdCi8DAqNpI5VcrJmxA1g==
X-Gm-Message-State: AOJu0YxG+GRpKULhkBc9GoCmSdHEHkDNIA1FyI6rnGtv97bvYjrYPVk9
	zHyJ+RRnP16dQmIvyS5TUbN3UC5WARyV8o4SVl0wR5wz8KfLVyO5DUIqG4EyO0g=
X-Google-Smtp-Source: AGHT+IEUdYLF+SIrKnTybz5q+/qUgnD4Zn7N0xrM5xio8TfCy6F6RqUL0Lawo+zsRRgrUQlvnUoJwA==
X-Received: by 2002:a17:902:bb17:b0:1e7:8d21:7fd7 with SMTP id d9443c01a7336-1eeb0594cf3mr41828135ad.28.1715220934604;
        Wed, 08 May 2024 19:15:34 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm2339115ad.58.2024.05.08.19.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:15:34 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 1/7] perf vendor events riscv: Rename U74 to Bullet
Date: Wed,  8 May 2024 19:14:54 -0700
Message-ID: <20240509021531.680920-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509021531.680920-1-samuel.holland@sifive.com>
References: <20240509021531.680920-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of PMU event descriptions applies not only to the SiFive U74
core configuration, but also to other SiFive cores that implement the
Bullet microarchitecture (such as U64, P270, and X280). Rename the
directory to be more generic.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 tools/perf/pmu-events/arch/riscv/mapfile.csv                    | 2 +-
 .../pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json  | 0
 .../sifive/{u74/instructions.json => bullet/instruction.json}   | 0
 .../pmu-events/arch/riscv/sifive/{u74 => bullet}/memory.json    | 0
 .../pmu-events/arch/riscv/sifive/{u74 => bullet}/microarch.json | 0
 5 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json (100%)
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74/instructions.json => bullet/instruction.json} (100%)
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/memory.json (100%)
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/microarch.json (100%)

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 3d3a809a5446..521f416b0006 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -14,7 +14,7 @@
 #
 #
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
-0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
+0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/bullet,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/firmware.json
similarity index 100%
rename from tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
rename to tools/perf/pmu-events/arch/riscv/sifive/bullet/firmware.json
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
similarity index 100%
rename from tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
rename to tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
rename to tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
rename to tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
-- 
2.44.0

