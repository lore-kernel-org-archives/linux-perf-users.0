Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD929D0E;
	Sun,  1 Jun 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798839; cv=none; b=FgpdceX/9gsymX3XtQdmNQ8hhSTCwLWVxOTGHJ40KmrBkGxxcGIgb0BiZ7Ii032qC6KNU6wG/FYhoXKYmZcyaHIxguqjp/k1bJrDCmZRkPivDGBwPp+3BtRrykm9lFDzHvu4QgqlwR/CtdDL0XIp6EtnjaVthqnSGVKUTdy3S6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798839; c=relaxed/simple;
	bh=0JIw9pnhtVwSmprjc3gPKxQnCvRU3b0Jw7lMThUT+j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l01VM6lkrXrGZCUXnWsytele2JiupYVQJZCmRfNC//onXVzViUB5O5rvi3J69RDePbQoUck9ZIJn1EhmpD0CkgTOWBu63q/2xa7to/Tjo7vfokq+BYRA1WH/SBInvUq+siwE4S81hyrxvUZv4sFnOD3kelQvWiaOr7mk0NzR5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFEpT9b7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFEpT9b7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c9907967so3814642b3a.1;
        Sun, 01 Jun 2025 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798836; x=1749403636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qvHjG4CO77bT7r3bkmdR5FN9ms4HdQC9iQON6aBJJ4Q=;
        b=CFEpT9b75UdfoZ6WWASGwSe7wIwqkQ+lCD6RLcQL2nj8w1sZLF1+crkClWmwNlqBRA
         nEcZziO+vadd9kRTrJoueRgw8209mWdWETWEqgvQu7memO0bo3y2sWSdOE/N0JCYATWE
         sUd28aHQJpal2uyhJyknHiHVY/wcucMsvBSoCqifcFmtVsQpqLc1nH71NBPAHZdPbAiR
         rc74+uv7wx2Q0NMKwptZDzl4Gn8pqZ3jBF/yZvoUwElI1bdFBjl74JpvTQg4xUysQm/n
         4O+zAyPa1up6NzSgsx2b9W5borFSqBtEZXvsb+YNTWr030IWGLuxdBK9r0QKJacuM1V8
         2tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798836; x=1749403636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvHjG4CO77bT7r3bkmdR5FN9ms4HdQC9iQON6aBJJ4Q=;
        b=W3tzKeqgEtyGWmEGKMBOkqZBWEwVNIVj2dz3W9wf3dOy9Nj7yiIfGvlJV2M28oC+Jd
         QGRBtNocdXiSehwC9dowzOtssFLLeckq7OSx/Wo8OvqE+MIs8KDbcJg91miQqV+AR1vD
         3D87kJetkdDnsrrEbXu5FlVdLT0s0/fJWpnGVe0DR+gqcATiloEvU7G7qirdjHKACH3X
         Tcp7aP/liQOuLMX6vnLEGCzBR7ieOoPrcBNd176PZ110jhKnwAxVUEViwIYGHBnHc+rn
         lA2R3ACd+THbATwnOyV30RNaToe0/sfPXO6mezCt3iMr+61XD284HhAZ66KCHiYvKlQo
         dKyw==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZfBXTnf0Or5NfaGImU9OeUXdSZTkziq9ksKpmEbN4goBpAK8+chaXLiE7M/ZtjkWfcLW+etG5bhRQak=@vger.kernel.org, AJvYcCV+fuGkvUFKmke1Mm2D684ZHQ8K5Evus5ws3qCBdInJ7IETyDXDaGagn/lzEhUWYnSlDrCoHryE8oKRmiNmV3UZjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00SAMyWflv63Bn5I+rvgAqFQmopP8izvJaV/xn9IckJZgLbzB
	vIAHBXMoPcXO2VnGON2JQkLv1qk4Z3BoBIZ3Y2uT8ushpqm2CPuv5EGU
X-Gm-Gg: ASbGnctoqD1dqi1bymFaWJtbFyMzt9DiJWZGFvlcQulJFQdE2j4NzD6mTswxo2oRlBV
	+H2q1KBNWGtJDBeS9+XWymOa39BZaqmEvtXY6ALuA9+W7cJYslxD9cUFDulj+cawpfhg+SXkjWu
	kmmNwJOqigRkxhRPEOom0ItAZ/YIXfI1TVP54NuvR27IUVN9hgwK58C2URicWmPGJjyhDv8WbVK
	F/71i9viBe5xAaNOVvSAr9bM4Z2/hkc4g37y4pRaAWS4uAKBGpFh60ATw1/wLzytX1W+HfkeFBv
	/NopKEDWX1CU5edvj5bCj5VWCER/XzhrhgotIpAlH8n54fCcpkPnCu+NBGQlTcX6kO81yP7tSkm
	M1cfhWWFtntSwdWh213FCdN2kkwsxJi+C/RGuAE1Apw==
X-Google-Smtp-Source: AGHT+IF1PiEGfKnZbZ92ZYamfQLHjj5IrW00BlwLQgui6Z4Bza85MSb7padK61VHTmmtCZM56IKM0g==
X-Received: by 2002:a05:6a00:2301:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-747d1835b73mr6725109b3a.6.1748798836019;
        Sun, 01 Jun 2025 10:27:16 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe963cdsm6168675b3a.23.2025.06.01.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:27:15 -0700 (PDT)
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
Subject: [PATCH] perf doc trace: Remove --map-dump documentation
Date: Sun,  1 Jun 2025 10:27:11 -0700
Message-ID: <20250601172711.714695-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --map-dump option was removed in (5e6da6be3082: "perf trace: Migrate
BPF augmentation to use a skeleton"), this patch removes its remaining
documentation.

Fixes: (5e6da6be3082: "perf trace: Migrate BPF augmentation to use a skeleton")

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

