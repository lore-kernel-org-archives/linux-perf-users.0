Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163564;
	b=SEvC39CyNF4ZAXN19eWcpMHEz59z/K9IKpGECL0MFlmFQoF1bqMjNOpvPZbrPupFO7ux
	 3U2Xo4Gzz9MuLs2OgCU+cfKVvH+0EjSJN/WsRkBm0Fk/fBl8V3QMGWdqPaI2mdxJwK34a
	 n8yZcFd8VNnT1BIYBD0Z5EbMB1cOC4aaDAoNyB8jf4TglDmGkwgX3Xfo0mg63SZiq0f7I
	 gVZQSPa1Q/KUpyNil/WeLkte6xT+0nDs9kodOZhMsoDH+cj62vWNMM6OaO32VeNGSefVV
	 0kbGRzTcnAMp+KI5WRL3Yyy22RZTlaMHeXhu6Ky2oNcLKvAUIpavCljFNiaaseB3i2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=j1sJ/9YGm5C/rib3cghBM+5FlV732aX+12bHjvjsrbE=;
	b=Qm+jR/DNJs3ytl3HQMv3xUxg78y15aT5RuB1qfR+PhOBCPsSVmgNtbhBxJEXBMzHk1ub
	 0KJiyTI0DZD3elmi9K5exVECD/WQnLZKC6nJq9aJofVf/cq3g6STIEg0yBciyPm4RtN1q
	 1e2xtn4a4eNA9CjvZ2ru8skebudHr3aah4gmkz7+aRvOTME+IbS/rQ2efG4OclP5NxL88
	 SFc1tYUZSJfw0M+o4cTQp2lL70SeWCIa+9nkvb3VwGX6qWKQDo5iIRoHU+09W3jSMIDlX
	 ajzA7xB01rMD/kuZZoM9zabYqwvFSM+UOI3V2ndzjRohsnRjvaPApkeaM1hSNEh71wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZSzrZ4v;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58219606A326
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 18:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58219606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZSzrZ4v
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so558074eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Nov 2026 10:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794163563; x=1794768363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1sJ/9YGm5C/rib3cghBM+5FlV732aX+12bHjvjsrbE=;
        b=yZSzrZ4vK20wQlrZIB3Sbp19mP7sEOxJpc5rOtSrrsunDn44bnEQP0Cd0vLNkg7Lh/
         4zJ4uDuz+6Lv2hQ9mGY6hgZDnBdB1AqH1rJS7+i2lH+wDbOA+HW4zpjA6QUID+S4qiE6
         uP34e901SHxw203NolOPZTHcSRohWcJH6qe2kooxErHdyz7elfxMVc/qVgycodnbfk8O
         jMYYhgHll8M22Ydc5YBBOnIq3gvSn7t7gsu+ND8mMGGwu2CcK7OcUVzwrMuRnJAsX7ZZ
         1ak60R14/nh8s3P9jbOatf/XcyUoSRYw1zVdyUY3IwT3RuydYrkk2/84Dr0k2hhBW13w
         Bpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794163563; x=1794768363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1sJ/9YGm5C/rib3cghBM+5FlV732aX+12bHjvjsrbE=;
        b=yA3Va+cILue0ll78DPiav0NaJDbcgy3h2gjHRI7eWr8sBNuEVPXgbYZYsALuhlrrlh
         nVpcPzwEXRC21zehf+x280d3/9KpRaLLgbG1TUVeWWMHfcFUu3h7px2OsKAwsVVJq15o
         95Rcf8Sm4mQRNDlSNOTq8co3Qst3wtFyjERx52DSGtnY+mfRnGjzSspJvc/Ocxr4CuUr
         54DwYTL2zBEU3M+yJEIXgHUfOhjRYDL6WbM/p0un9DOVy+Ut4DPTS/ug2lorSHJQSo0n
         uYxKQqo0gqdbo/AV29rJlGRfhfaCp6sEtOor3bkU5bI9RomRvgckd8c3E5lvlODyWxCw
         N5xg==
X-Gm-Message-State: APuU4Z8+FmnHGEzg84Xlxtaz9FUmjp0DAdVg6phH1S43iRdlV12EuXNu
	ExPVmEVk1NZdNd+gIEd/HQU7YjhXUAKHmK3XvgBkVaVpu7glNnauqgOmeECqBg==
X-Gm-Gg: AYBFou09BNS7vwEt1Vqa4xsJsH4WLyc+HrHzSGyYXR5iHcBAM0NEItIQ3hCg/qmjbpp
	EQUPunet9n99ykoHZ0wysXrLNCoOtLue7RmYxNum3DeltC7hlECKrgJbZpVlWP5sNQBjt9KU76o
	10/zNc6qCRH4OGG6v5MNm/9ETDmXHiWbaYAladickrTi+7nRMrvDLb/48qoqCF0LXK17H4GzahL
	4FAYol5N4g+hbzqT1ip78U2MG7zlj42PaS20AmJZWBt9URBh+3Lkv8qJli+meeNdaOKknM9P191
	tWyop69/jwnZMbHoKJNROb5ZeIZmnQPs4QJ1nC/N6GePifR1bPo7h9xdQBkA+0GZTlbFewxzGX4
	D5+ZTVmmhIbCWrz6cMhOam2zJ4ZvX7stM8CGjE4DuoSErCXeCL9zHeoT/Xqipq7oXio2+9f/ArC
	1lrUuCrCbDN2gLyNU2jziTNbT5dG8PQMzfRfsQwk8nA/2QEfYbH70bwkkvm0FzTPP/uNcfmJZ9I
	Vr7khV4cg6N8BgB9qnoBalQ1UNerhAUviOJWW/xN1rt5CCkDG1l1cwjslOYp6r5AoFwjv/3C4nX
	suetZJoKDrSN+ouHgAhPDzY+BgXTuLQ2bk58o4blYQ==
X-Received: by 2002:a05:693c:8059:b0:35d:f7f4:bc1c with SMTP id 5a478bee46e88-3725d781ba8mr4321414eec.6.1794163563300;
        Sun, 08 Nov 2026 10:46:03 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265ff3415sm6429023eec.18.2026.11.08.10.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:46:02 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH] perf vendor events amd: Fix a misspelled JSON key
Date: Sun,  8 Nov 2026 18:46:00 +0000
Message-ID: <20261108184600.3810059-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
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

ls_inef_sw_pref.all is listed without a description on Zen 4, Zen 5 and
Zen 6.  Its three JSON entries spell BriefDescription as
"BriefDescript6ion", and jevents.py reads the keys it knows by name, so
the text is dropped and the generated table ends up with an empty
description field.

Spell the key correctly.  Only the key changes; the text, event names,
codes, umasks and expressions are untouched.

Fixes: 658448281d19 ("perf vendor events amd: Add Zen 4 core events")
Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
Fixes: 2f42fb0661d9 ("perf vendor events amd: Add Zen 6 core events")

Written with Hermes Agent, an LLM assistant.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/pmu-events/arch/x86/amdzen4/cache.json      | 2 +-
 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json | 2 +-
 tools/perf/pmu-events/arch/x86/amdzen6/load-store.json | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
index e6d710cf3ce2..01c848a9dbb3 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
@@ -182,7 +182,7 @@
   {
     "EventName": "ls_inef_sw_pref.all",
     "EventCode": "0x52",
-    "BriefDescript6ion": "Software prefetches that did not fetch data outside of the processor core for any reason.",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core for any reason.",
     "UMask": "0x03"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
index b1994539ece8..774da0bfa0dd 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
@@ -351,7 +351,7 @@
   {
     "EventName": "ls_inef_sw_pref.all",
     "EventCode": "0x52",
-    "BriefDescript6ion": "Software prefetches that did not fetch data outside of the processor core for any reason.",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core for any reason.",
     "UMask": "0x03"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
index 4291eb59426f..4adba70bffb1 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
@@ -351,7 +351,7 @@
   {
     "EventName": "ls_inef_sw_pref.all",
     "EventCode": "0x52",
-    "BriefDescript6ion": "Software prefetches that did not fetch data outside of the processor core for any reason.",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core for any reason.",
     "UMask": "0x03"
   },
   {

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.53.0

