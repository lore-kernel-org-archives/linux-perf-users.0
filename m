Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702916;
	b=bo70S5CuJMcsRJ0Ei3wJaLsb1pIK16DotKX/Vt4CUBtWQMRl229GxRkrPBb3ZgBkwhY/
	 CCEOSYsWFqZtr4R4DoXLGZDc+S6GyQPcAN7OKANzbwB8ff5Q+GtAk6Gcm6oq6yA6Wp4E0
	 R0B3t5HJhxe3vCaHVjco+TE12fjyLl6pDmy0ro2+OO9Lr8Z7QJyJ0UOf3bL5+dAYk2eYy
	 30DGdNa1ePtHzlVS3+zz1TQMKrSk916RTkAeflSzn63xs2ae95AbadoY505TvqMoBeivA
	 kAKfkBDDvTi5S5ri6QXWHycV/PdaaBXJce0kQK1lNIjVtsqHTvTB5c9LWAwRJ6c61vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2nYIukBoRE89MLYt2M3FDs+Pz1fZECVW1PjFbco9lqI=;
	b=rSyMXEV++wrw393bmEMa4h8eHJai0UaaL1ShJNuo48rimSwuksPatcYIg58TO60rtYmn
	 iM70ZB1G8huPpYre1YN8MSfXUQWIBRfFx9Wr+vSeJQkTXpFjzz0PpnuKNpFEdoDrrMxKP
	 otUWDjcQH13/FVVYBywtn4Mq6PO/EqJ5up5of1CAf9hu0G6AAVT3ZRS+pnoFfcOOwHBrR
	 dnohKjSWlhegxNgG53znnxEhjcSvAQ+n3A7OKf0bkYQK4IINv780k7XxXhv783uwQDShg
	 AF/Rj/JF48IwlxoZbvQ9WgPvKrKGhzWvy2vwUwuz+qAR7VKs+inMg4BjcSVJRA3bAXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alRD4mQZ;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F56606A327
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F56606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alRD4mQZ
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67da3d03263so386330d50.1
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 16:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702915; x=1795307715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2nYIukBoRE89MLYt2M3FDs+Pz1fZECVW1PjFbco9lqI=;
        b=alRD4mQZf1yKAdYgBXU+nGRJF2V7dX6f6n7iipUFWPAHMK4eBhGkTz5n52PIMkkChB
         SODXx7LxHfLE3n+yAPm9PYfFKr9myDDH/NNqjm8jeKs842mMQIyF7UrpHWKmS7SKRVjy
         LE3tbvWRxWQWTyQWhL4AjaEOwYJy0aJC6AJd/mnLGUWvouBUYQcJYRaSVf5/41UPHJgK
         B4wVoFCcjilp8lt7V4nmJNVBwXI+JdxLgVViyiVY7/6fq0sR5x4OHsv8uPhhbkO0oU8f
         bgnt1B7/IZzX6DEj0GU/QPjkLLdBzJHIjk9QDcAkEZTxagfaEVnnq4EI86LoB6jWvsyQ
         pv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702915; x=1795307715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2nYIukBoRE89MLYt2M3FDs+Pz1fZECVW1PjFbco9lqI=;
        b=qjP8WmtDR2EbAf6sNFWBOd95VvM3u0PGPGqGismqwnTu6SRWhk9zgml9DbGm2FNYcg
         ZmU+kW8YmqYgY3bka3Ez/Z6NsLpYmGGM9opcFLeXu0g2rvgX9aIGXHUuyrzgzrL2EC0h
         icYouvVlBghqQPJJuSUlXHKhQ4elcbjE1yjxPOKsHepmPajRoRff8rK/lnY2uoztW6iA
         vUt8uIGdAMo1mxTSh7uoEDRaEczceqztKw0ioYtNKVZnYN0o3kRsRTS5g/59PBckZJl1
         7VLyjPcwtIovcjNaB3PvHT0I6warkEdb9FE+ZNww7yAENMlKzkhg5ZJWIQcSGwIKGpuq
         wHxg==
X-Forwarded-Encrypted: i=1; AL+hErFQ5jwiwACHmzfFYSSCAZub2Oh0W0kWM5yTtq8851GsUohGMSjingthPal+fiG8CVjvfcQYr6Ru0clibqgWyxEg@vger.kernel.org
X-Gm-Message-State: APuU4Z8vkXQ8qsG7/fYsL8Prv7CWVoOiAx99jNOJVcpdC7J05LSx+BOQ
	CX06NXqPQulVJSzqx70l/Mv7FLDu3sfJq8zPDywiqaSOZQF9dVB7aknG
X-Gm-Gg: AYBFou1trmoslS8wBmEhMJxeNkduqIYqeoTXqwdxhCLPcMk40Jpkol3BjieObpHEBab
	MFZrM8svAi/Ewwb99OISNu2v2FQQ6EVglq63K23JmRIJZkeLlxPutxfX2/1v+jYudYoSnZT3c9P
	CCqDl7NPfjnet2jOVbBztXFnKSFO2uCuSRGW+Dwv6l0H/AyxtpQoZtAdum5hq3ewkG0O7F7HREp
	KBWfWYJHFfsVt+/2rTZDRsZu/HooBy6wyZk9FEv9pgIowKy6IL6LwEa2JX/zpuBwJQbKacmWjyI
	6Bro1wDl1jg+wWhqYYd9j67GToF7q5Ya/z1DETQve/BGipSAI8DYngFTqUpf8kR8KPh3TabaB+l
	9kUwr3XjDS4eSDrSNbdkg/rgdr9ISJe+5u/nrUsCMSe0cudr71DOeL2H5YXwjBiJga5Zc1Z0Wef
	M+jtUL+dIeH0nbmQjNWQOZusQb0wEqN7Aw6qpHiG7JL1yWus2MRCz36e+Xype0KseuPatcaNXlY
	Jq+lVnIQqvWLOnT+l/nuj1C8xx3mARKyWwzxruhz9Vr0yI2AVUMpjG92S6CKvI1FOzqiq+c5jFv
	zkf121HSJmBrN6YpT9RpZgQWcor/IdHjRYk0Yq8W7aAVJWT2/FdmLt8kpGUAmc9HGKgc0JbQsyT
	FXA==
X-Received: by 2002:a05:690e:a47:b0:67d:a95e:27d2 with SMTP id 956f58d0204a3-67da95e2a0emr689331d50.84.1794702914732;
        Sat, 14 Nov 2026 16:35:14 -0800 (PST)
Received: from codey.attlocal.net ([2600:1700:22f5:3930::a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a55b09esm6013734d50.6.2026.11.14.16.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:35:14 -0800 (PST)
From: Lalit Maganti <lalitmaganti@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: adrian.hunter@intel.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leo.yan@arm.com,
	Lalit Maganti <lalitmaganti@gmail.com>
Subject: [PATCH] perf tools: Stop using the deprecated argparse.FileType
Date: Sun, 15 Nov 2026 00:35:07 +0000
Message-ID: <20261115003507.1872482-1-lalitmaganti@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Python 3.14 deprecates argparse.FileType, and pylint 4 warns about each
use of it. The perf build runs pylint and treats its warnings as errors,
so the default build fails:

  pmu-events/jevents.py:1494:26: W4904: Using deprecated class FileType of module argparse (deprecated-class)
  pmu-events/jevents.py:1496:33: W4904: Using deprecated class FileType of module argparse (deprecated-class)
  tests/shell/lib/perf_json_output_lint.py:23:31: W4904: Using deprecated class FileType of module argparse (deprecated-class)

Take plain file names and open the files after parsing, as the
deprecation warning suggests. The output of jevents.py is unchanged.

Fixes: 5fe83fb352c8 ("perf build: Make pylint build test opt-out (NO_PYLINT=1)")
Link: https://lore.kernel.org/linux-perf-users/20261018070110.927636-1-lalitmaganti@gmail.com/
Assisted-by: LLM
Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>
---
 tools/perf/pmu-events/jevents.py                    | 12 ++++++++----
 tools/perf/tests/shell/lib/perf_json_output_lint.py |  8 ++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..99b9813ca242 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1490,11 +1490,15 @@ such as "arm/cortex-a34".''',
       type=dir_path,
       help='Root of tree containing architecture directories containing json files'
   )
-  ap.add_argument(
-      'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
-  ap.add_argument(
-      'output_string_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=None)
+  ap.add_argument('output_file', nargs='?', default=None)
+  ap.add_argument('output_string_file', nargs='?', default=None)
   _args = ap.parse_args()
+  if _args.output_file:
+    _args.output_file = open(_args.output_file, 'w', encoding='utf-8')
+  else:
+    _args.output_file = sys.stdout
+  if _args.output_string_file:
+    _args.output_string_file = open(_args.output_string_file, 'w', encoding='utf-8')
 
   _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
 /* THIS FILE WAS AUTOGENERATED BY `jevents.py arch={_args.arch} model={_args.model}` ! */
diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 8cde22ac9d97..1324dd8c9ec6 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -20,10 +20,14 @@ ap.add_argument('--per-die', action='store_true')
 ap.add_argument('--per-node', action='store_true')
 ap.add_argument('--per-socket', action='store_true')
 ap.add_argument('--metric-only', action='store_true')
-ap.add_argument('--file', type=argparse.FileType('r'), default=sys.stdin)
+ap.add_argument('--file', default=None)
 args = ap.parse_args()
 
-Lines = args.file.readlines()
+if args.file:
+  with open(args.file, encoding='utf-8') as f:
+    Lines = f.readlines()
+else:
+  Lines = sys.stdin.readlines()
 
 def isfloat(num):
   try:

base-commit: a1c3b14c28ebfa79dd56e2743c2fbad0c02a7146
-- 
2.56.0

