Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111353BBFC4
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149909; cv=none; b=F0l//puZYd47TDvlRfzymjW8UeznqUQNdCNcjf/xzgqoly8FKAUbuXh9gFqYF89bnzV9RWENk74DYlJGYSH4U4emjBlsu0ER/6ajoOLv7pXXElbQXLk6KJc0TLjy0niyU1TQjwPbpWBit/bSsmG1xg4gvlkr8WLv8ECFC0/O3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149909; c=relaxed/simple;
	bh=Qq5HLLPi/RDu4k1d4ku+64gqjDrY9ls+1rsUUbon/mQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AmF/z1hMl7OtRi9KFZxDI39UyzjzgyBGZdl7jAUmE86AatQz2lN2dysWWH5xM6mDQQcMfzmKhIzIq5r5zoFAV4fZxTjPq7+YdVcMuVlVRShcQTokxVpWZn8vnTfeMPsVGrtWo5+3dLTK6z1SEnM2A2puQiLLoYnddHSpjH+gA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AK4aWnwx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AK4aWnwx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc88e22f92so121166295ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784149907; x=1784754707; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QbWYV5bitSipF/MG5q7Ovi0rWcapgXqZpsLurFZxTZA=;
        b=AK4aWnwxPka3M+8b+ASG8KfN8YrQdBaFrL5I1lhwXnMTpG8e/URDXVk3Qosl5foFwy
         Ic3fDuAWq/Sw4WShVLz0wMkjTDDUn2yZ5s2AEU1Gm/1hbKZUChRk0nrw5o4gCDUShlWT
         NpD/QNAsE3y5QrAVXas0anmLj3DhYe7KbJteog3KnCPMCV1MvKPB0YyO2eo9vM8HGIiI
         WP+cWusHt1AFTF4uskP46ZH/lmQJZDORk/FgDGIZFM2oDHduCvNNQWMRSm1nEEGu1r0b
         Z8uOOjlr2EY0oEBj4upsQd+WGL56ZQZmbubAoUNOFZ0z69a7179OpZaRU5Iqz88f9b90
         sojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149907; x=1784754707;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QbWYV5bitSipF/MG5q7Ovi0rWcapgXqZpsLurFZxTZA=;
        b=oXimYRrB2m6x7SZ9wzeKelkWVJRL1OLSn2ePi8Q2jwDz0DCJo4Mc3ojfa4dKWF6bLE
         u0VVCw3aEw/JrqsWmgRnxXCL6R6Xub5poxCOA8WBjcy+Y2TBXb7yoePf5lvUL/DrVBBP
         WBeFgr/u9pdmc5O8jANQIhAy0p/E+VMaEofPrEPTZOnQBPEz6we1QPhbH0J9/rZgXRAm
         1ETUywShbQdzDgqlGXqb11miP2ATKLWCBofxhvzXMh84eXqRS1UPOKb8Dm4CoHN2cCKG
         invLPJSg5l3DQqPlsDVazzH/YkmbGPWDM9dqeNmOCjd6U7BpeyNMrzWVyDBdb38Vd1/U
         rPtA==
X-Forwarded-Encrypted: i=1; AHgh+RrxqCnTKuw7LuStomsBuczt3cfUuNec1dh5qbUAilEAcOTPXRbSir2PPnYBTEiyW0nGeiNEHPKSi3B0ynq2yfAS@vger.kernel.org
X-Gm-Message-State: AOJu0YzhLHNJBzkWBAvhIBVUH542IfBeKxOB0XksibXrH6I769mHDd6e
	JiBbOlqjBfmya/6sN7I7E2Z74wwDRRQ8+3lVhXc9Iho3c+fWNtLm5dFVqRxqzFl8SnFY2i38Rf6
	NWA9gSg==
X-Received: from plbms8.prod.google.com ([2002:a17:903:ac8:b0:2ca:cf09:91ca])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15c3:b0:2cc:d807:369c
 with SMTP id d9443c01a7336-2cf03e0f454mr43190395ad.45.1784149906812; Wed, 15
 Jul 2026 14:11:46 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:11:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260715211144.3144895-1-ctshao@google.com>
Subject: [PATCH v1] perf arch x86: Zero-pad CPUID model for GenuineIntel in get_cpuid_str()
From: Chun-Tse Shao <ctshao@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	afaerber@suse.de, mani@kernel.org, dapeng1.mi@linux.intel.com, 
	thomas.falcon@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Change the model formatting in get_cpuid_str() for GenuineIntel CPUs from
"%X" to "%02X", while preserving unpadded "%X" for non-Intel vendors.

Intel vendor events in mapfile.csv (generated by create_perf_json.py
from the upstream perfmon repository) use 2-character hex model strings
(e.g. "GenuineIntel-6-9A", "GenuineIntel-6-BE", "GenuineIntel-18-01").
When an Intel model number is a single hex digit (e.g. 0x01 or 0x03),
formatting with "%X" yields "GenuineIntel-18-1", which fails to match
mapfile entries expecting "01".

Non-Intel vendors (such as AMD) use unpadded model numbers in mapfile.csv
(e.g. "AuthenticAMD-23-([12][0-9A-F]|[0-9A-F])"). Zero-padding non-Intel
vendors would break AMD CPUID matching by causing single-digit AMD models
(like Zen 1) to match "01" against "AuthenticAMD-23-[[:xdigit:]]+" (Zen 2).

Restricting "%02X" zero-padding specifically to GenuineIntel CPUs ensures
both Intel and AMD CPUID strings match their respective mapfile entries
without regressions.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/arch/x86/util/header.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 412977f8aa83..4b6d619fb8f9 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -66,8 +66,17 @@ get_cpuid(char *buffer, size_t sz, struct perf_cpu cpu __maybe_unused)
 char *get_cpuid_str(struct perf_cpu cpu __maybe_unused)
 {
 	char *buf = malloc(128);
+	char vendor[16];
+	unsigned int lvl;
+
+	if (!buf)
+		return NULL;
+
+	get_cpuid_0(vendor, &lvl);
+	/* Intel mapfile entries use 2-character hex model numbers */
+	const char *fmt = !strcmp(vendor, "GenuineIntel") ? "%s-%u-%02X-%X$" : "%s-%u-%X-%X$";
 
-	if (buf && __get_cpuid(buf, 128, "%s-%u-%X-%X$") < 0) {
+	if (__get_cpuid(buf, 128, fmt) < 0) {
 		free(buf);
 		return NULL;
 	}
-- 
2.55.0.141.g00534a21ce-goog

