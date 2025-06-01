Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF813AA2E;
	Sun,  1 Jun 2025 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748799177; cv=none; b=NLqeC13An8ei3iWEXm2VvJV52b6OBj4X4KotxJqGnqqQ+2W9k/8blJfJavwBjgcz9bR2YlLL2hH/1+/fB8/0UN9QJci1aLMCSJbViNA7QsUIVpqzoTjXF0U4DhWWE0CPommV5erwwCZ9vI4pQrIGEVPBp/c8rDuWQY0Ug5FC/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748799177; c=relaxed/simple;
	bh=CXCDkqc3HY6PJJ55Qx1TyU2PeMArvJtCEHSeg/VHZMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7g2gxnjCo6YZ24vDU3oRz5yTx7mviuuAX0bWM+i6Vgrubvy5KDBd4xi09xy9aVS+U/fZ9WPCg3BCPZ5DQKXTmVDHVtRl3AzQJfiv++7N3vBakmULeTUY2q7ka7Q9C+K5VqMMoru/8+zVu9EFtKPHiJGnzv4WVyqaMsz6HwP/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihyLVks9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihyLVks9"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so2421234a12.3;
        Sun, 01 Jun 2025 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748799175; x=1749403975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1+o6RtULl3mTWS1CrGZdbkjEyWAPKzUw62Egq5PIGE=;
        b=ihyLVks9S1jDo5dZkr99gLRHR5XNSSuKqiq6L9HsKImxVGCxyP22GhTI0KDjmY37ib
         XUcbzf2ARdulGdt820x2OkrLaOVOfIFNjbH17CGS/VVbOx6STr9eXxvRA/r6CQzAr5Sa
         j8C1YupRykW1uhZ92fHPyUCUIHMdnPnmO+4/y1HkNXZbkMqF5CU4u+0sU6OR4TefHEo0
         MWMKOJqwwK/vJn2upM/OTZp6OAR2rEt4GtKJOHs5g5/GjfrhPl2RUbcg/sFZgSZ7LEDC
         +iO9EY2BeOfvacsqVwoJcBwC+NvXP6Yh4IuSXyiHQP8jrg9oVwWeojQLnfAlMT1df+zU
         hxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748799175; x=1749403975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1+o6RtULl3mTWS1CrGZdbkjEyWAPKzUw62Egq5PIGE=;
        b=cqqzWuhplTYG9ifJPHbUqSMz6v9jHizw6gCGMO/5zGGQ+wfeiZR12l0A4H0WPuQnRI
         lv0UjM5vB66TIi0kwg0q7L0UBpRFQO87+EW3RYsohdMRP6noqUUbF3lyT/yMiZwDavCE
         IG8gaebDx1hXk/yHQAcvK0ULp9ECZoZvLQdCnAmZfyWbv6nQ7IPOVxYvu3ahC/BDe30m
         MEmNASb9FZMMA8C3ECm6J+OYz1t2UaDHj4Q59q6ECSkotA0nh/RKcFt1a15T+DKGAEO1
         myJbBUQGymUu/5Q6Cd6K31h4XzdNU/OzNwCloN/V2FUeMJMKlzeHsmfJ5L7ZRThODCeb
         xuOA==
X-Forwarded-Encrypted: i=1; AJvYcCWZGoM4ce6v5R3tPJMvvHgdpX2p7m9BafMr+RKVYJvDAXViMezlngJIeYAlCgI7LurUU/KDFM+/tFgndOA=@vger.kernel.org, AJvYcCXghCWJmScBoaU/fhPq1h4KrT9Ha2EA9esqP5sKaVwbrvzvNA0vK7IouhyIcwC89P9S9PVzfVcZ/UjKXOp8YGNvBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0TZ5aB3y7hlVr3JFLlkUu8wKzlA1hRwnATcGZyj53v/liG/u
	g8NzKTzADQwctu/BmhU7QfX9/xAJmvT12kCbHPvf4XGi32t5o1HhAP7m
X-Gm-Gg: ASbGncvadhfp+ZS5LFW8eziPzHoWbkjwXyGdNvAsIlU3bHbxzGzAkR5oYDnwtI/mLTU
	dnl31aKHytI3JIYXkcckpXbPBSXk2fZHMtzlUyh5j36uIVGLNI3TTwKNaMERzO4S4/vns4rJx03
	t7xb9VrDPukA1uu+fd3W4RO0yIV8o9Cn0TjvgCKmEDpD0O8YVY7jpgj+cs8I3qm0ByPQdbfT0Nf
	vlhF2AXkFHTeUUFN8/rSTPh3DE3q+uNcl0KWFQZnGDsoH1NnLCBLNx6KJ7yCjwT6MWZLQEOeSlE
	9cvlaTL/ZpVXvYcpYlOXi1un7jJ2I0wobgLlZvPt/JPlLM9ApNXZuJRjMZlBI2sR6uCvkVUWQm3
	U2uU9k01jXy305BWGirF1
X-Google-Smtp-Source: AGHT+IGpWuebZEN8XIRXmDyaNBUyrPUAgC66ultV2VrLU7U9h1pAbJdpOORsPz+ia37EPuJEtEJ46Q==
X-Received: by 2002:a17:90b:3e84:b0:311:e8cc:424e with SMTP id 98e67ed59e1d1-3127c74306dmr9167596a91.24.1748799175535;
        Sun, 01 Jun 2025 10:32:55 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3327b4sm4232625a91.48.2025.06.01.10.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:32:55 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2] perf doc trace: Remove --map-dump documentation
Date: Sun,  1 Jun 2025 10:32:52 -0700
Message-ID: <20250601173252.717780-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --map-dump option was removed in 5e6da6be3082 ("perf trace: Migrate
BPF augmentation to use a skeleton"), this patch removes its remaining
documentation.

Change in v2:
- Correct the commit log format

Fixes: 5e6da6be3082 ("perf trace: Migrate BPF augmentation to use a skeleton")
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/Documentation/perf-trace.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index c1fb6056a0d3..973fede403a0 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -238,14 +238,6 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	the same beautifiers used in the strace-like enter+exit lines to augment the
 	tracepoint arguments.
 
---map-dump::
-	Dump BPF maps setup by events passed via -e, for instance the augmented_raw_syscalls
-	living in tools/perf/examples/bpf/augmented_raw_syscalls.c. For now this
-	dumps just boolean map values and integer keys, in time this will print in hex
-	by default and use BTF when available, as well as use functions to do pretty
-	printing using the existing 'perf trace' syscall arg beautifiers to map integer
-	arguments to strings (pid to comm, syscall id to syscall name, etc).
-
 --force-btf::
 	Use btf_dump to pretty print syscall argument data, instead of using hand-crafted pretty
 	printers. This option is intended for testing BTF integration in perf trace. btf_dump-based
-- 
2.45.2

