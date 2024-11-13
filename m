Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5FA14F114
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516964; cv=none; b=fnycdk/nBJ5Gowto6FEOHaNHoTxa4pKALpK48IzIFTHd+E6v+sFjm6EB4/P0vXR63PPcf/SkRDmAfO3PAK9oem0l1F8e2fEX8igwyjOswoFz1tHgq76jjP1JwkqtH/Dq3nTP7IwnrIY4U+Q/s5oMEFJ7SXbDPEEs0ex67+Y9No4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516964; c=relaxed/simple;
	bh=KhrrPKe7vIHE0T1AZ9VXSsNl1IkVw8BKbNVwlgzjjoQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=mNKGq2Xqf1sOGmOwM46IYs8abl63bd4r6DigXeTyLVgST1G+l+d/lKdATXrOwwy9G1tgJDqnSzcE5MylHJiBX/lEACnq2qDaP3npVzVgPXejb/YiUXI13bgI7O3Qv+q6RweHRDj1UJMBI0y9ZDsBYpkxdJCeg/zs0hu46DCw5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVr+GHjt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVr+GHjt"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3805bc9c43so671303276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731516962; x=1732121762; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L+V0k3XPAXmnG43u3p674HXKA6KoBO29C9FYM4hkixQ=;
        b=uVr+GHjtAtj/2xp52uanYsGfYzbhbWVEWbXLjO2Vmq8yOXxe1/V/RrKf2UE6Cnzbnw
         w7q/EWHq/2Pjwh64Q3q8s9lplfuLj34Hz6n+9cw1xsqySoAvyEgYBPJ7K9kDAibLLtGK
         anFgpWFGCDg3Pd9L/sCYfFKo1RUy9jCEJ+FGEAo6zkF7vlRKVpFylCNu2OXXO+OSLxrC
         IlPfd0B1syF/75APuWnW97Thyb9BzCKi3ODS/SDybZ0bx4ySKRvk6UNIHfryhCD1gWcw
         0cXe1lynIbFAuC5fvwnYJcA5IYT2OlS88F8O6+X71wiTP8IOxR7ZnkcCQyqkDITDT2bG
         j3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516962; x=1732121762;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+V0k3XPAXmnG43u3p674HXKA6KoBO29C9FYM4hkixQ=;
        b=EE2PnBhjGT3rUsbTR9f+YYkiH+uXtYT+9C0Mdio4BxJbtlgwOno0+exbvbKV/mgSTp
         EjnVIBPhsUji+tAZzxYQyFbLJRI0lnwlS18Hfvh9DA2eCNaU+FdCxxPdJEXYGVNktIzc
         hHPQxH4eI9lqh/3G2MyzHy/mC340WwPIaSjM5zy1KzqmZRGsgOSDiLpjAm5fJUivQ4GJ
         ouf9uhqYCHoLmqu7aVNBbpPmnhYte1UuMvFXeeRIHz2/EtI1g4sNzf1qzpAlRkBokoOe
         iuVjMhoHovcxWVcV4ReIGzBKJzFqh3Wawb0x5qKnInVdS+78eaPjGZ/JMuUZXWhEKA3T
         4hjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwe8KDB7fvXaCsyQHBx1zV98hy5+DogN1zOpy0fxI2IebXCtSsaH+0G/APNzoJwipNJrmig0kfRJMQ/VNiiw/V@vger.kernel.org
X-Gm-Message-State: AOJu0Yxssa9/opsXejb2KfghL1e9CRV0SuLyum+ihydQJpnJnRROZK43
	Oe0aQkgG5xa7JGsN444+ly6rFxsZNsvCVU/oT06HA/eMzmD8Y2gaWMVoNKp1+kJXeit0thyaZ5p
	zJ3YSwg==
X-Google-Smtp-Source: AGHT+IGvQ+kdAce1NUAauszdwhpxP1WrhuGqEC/mW/M0hscdCrhGUXjO2u2QURd78mtp7VKccYIOr8ZSDXW5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba3:1d9a:12e0:c4af])
 (user=irogers job=sendgmr) by 2002:a25:9004:0:b0:e24:a28e:9399 with SMTP id
 3f1490d57ef6-e337f85ef60mr16884276.4.1731516962118; Wed, 13 Nov 2024 08:56:02
 -0800 (PST)
Date: Wed, 13 Nov 2024 08:55:58 -0800
Message-Id: <20241113165558.628856-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v1] perf jevents: Fix build issue in '*/' in event descriptions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For big string offsets we output comments for what string the offset
is for. If the string contains a '*/' as seen in Intel Arrowlake event
descriptions, then this causes C parsing issues for the generated
pmu-events.c. Catch such '*/' values and escape to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 6e71b09dbc2a..028cf3c43881 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -430,8 +430,11 @@ class JsonEvent:
   def to_c_string(self, metric: bool) -> str:
     """Representation of the event as a C struct initializer."""
 
+    def fix_comment(s: str) -> str:
+        return s.replace('*/', '\*\/')
+
     s = self.build_c_string(metric)
-    return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
+    return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
 
 
 @lru_cache(maxsize=None)
-- 
2.47.0.277.g8800431eea-goog

