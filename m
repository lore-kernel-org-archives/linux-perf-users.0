Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95216AD21
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeZwC0qu"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CC9182
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5a16fa94so348804276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280343; x=1698885143; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgEoz0HJkgI3Htj/k2k/xpjtT3B+sjoHWzaw+oBkReo=;
        b=GeZwC0qulzJRua3wr/OzXTDoAZRbp8AIFRhJmxsOG5t1f6f6MskqRPetZ8HvL046tb
         se052U1uMJgjQtkkxUZSeZTEFqT3wEHgsBj2baCmyYek3ClWR13gUFE+sGGsmt9H53jE
         tk3M32gvWGaQ0QcxKT4mX95492QSCyyIeyISBkHyUvfKhnle+TUtVyeWKlYaUZwe6/bp
         yRB+l4wDiA5ZLmIh5zmniUh616bm1PJ+bMqUf4gRYYVWqvocxnxuzWRfUQ4jIs19XahW
         74Qv2uidAg1iq7lCcaqrOrz6NYiNbJN9AIpnzEtKua5J7xv1x7QtXGyWLshWdx2pGRUr
         9h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280343; x=1698885143;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FgEoz0HJkgI3Htj/k2k/xpjtT3B+sjoHWzaw+oBkReo=;
        b=n8y1n0VA0aNSYW0MWAvDOHXNoMzmvkriyE7lWVk7toosbamHSzL1HO1eVNu3dPuu/P
         NzVwcfe8VNDRoqxAPWFDzF426gBcQ6FHt7BgjqUG3skj+o2/QO0ye+HbhKCLCzfzqslU
         5Nz7flE73xWFAyAfAHf+1OrmHZ8NA1Z3ZtBLUJ2lacdn3Q4FqiKnsOyGJJfFjoLtaqzp
         pBl7JCdjHp/YTCjcWu6B3aDYkN/5k2FLM/9mQ0F/ZgeLgQptv4pHP2g0qd0sp4HERbJq
         TB9NSyFrhvx7Sq5EvClm+m2jfQJNG1Vp61lDq9cSCc55JG2YifzhB2HQEzoNsCBwTIiw
         1UTQ==
X-Gm-Message-State: AOJu0YzmQ+3WSmm10RcVQHMOYYvsSb2ocvph2JDM7gsuUtXlC3G0JCvm
	K+BAk1jGpuyG3k/Kg8IXKQtqEgvxMbKi
X-Google-Smtp-Source: AGHT+IGX4t3mc7gYcHTxGkFn0KiWK7fXhEzT6fN1z0upW+CidFVN3Uaf7zPfQNxwIrFqQ1j/qiaecaMU7VYy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a25:800f:0:b0:da0:6216:7990 with SMTP id
 m15-20020a25800f000000b00da062167990mr44686ybk.3.1698280343193; Wed, 25 Oct
 2023 17:32:23 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:31:44 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 4/9] perf vendor events intel: Add typo fix for ivybridge FP
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a missed space.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json b=
/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
index 87c958213c7a..89c6d47cc077 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
@@ -73,7 +73,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULsand IMULs, FDIVs=
, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish =
an FADD used in the middle of a transcendental flow from a s",
+        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULs and IMULs, FDIV=
s, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish=
 an FADD used in the middle of a transcendental flow from a s",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.X87",
         "PublicDescription": "Counts number of X87 uops executed.",
--=20
2.42.0.758.gaed0368e0e-goog

