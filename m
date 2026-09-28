Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B748033B;
	Mon, 28 Sep 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585731; cv=none; b=j5st+GECwHIrLu3D2Pqfzk8eIxmmL/T4H7YimEXHt/bSPkeSWKxW7FlXlfPeUsEFmQFXq0Kp9mqZo5NkE1bEIzk7pQ9OWIAFb51D/7nvTtxQLukUahNZ6IgR4z0hSHaES1OXqETn7dLaRZTrFE9p68ul07XMEfZdvr2Xor6pCs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585731; c=relaxed/simple;
	bh=7JO8dxuk8jDeO2p75M18t5o0Vt8Dw9oWBRE48A0uX5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XG9vl29B9RlXhOwf1GVxVYhrWUPpFLOhIEDAun0Dvk6g9DrB1S60eplYZvYyCwKJc1IrNg0GgE5Kx/RHBqwt5KrbiHnTE4gfcJ0EoWo3M1+8haAUoDl0v32So5z7p2wA6vm7Fqd5lc18yd4QBVQHKbSLhWI3ZXAUo2XVkQkUuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TFsE7Fqq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TFsE7Fqq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DCC151A0FD3;
	Mon, 28 Sep 2026 08:55:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A7948601BD;
	Mon, 28 Sep 2026 08:55:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BA8C102F1EAB;
	Mon, 28 Sep 2026 10:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790585725; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=VqYIFU7sk1sYX8fcITGxpl1lYD9JNJhksfNfAU0tdKQ=;
	b=TFsE7Fqq7Oz+d3IzqGEnf69MdHD5PFOWdjfj0qTxONGCQ2mdtLwV8v/iZybBC0DCtg5QuH
	9tR+mYEerlVcY5RGkBQuOKeHwjSPlTsyQ6BCwF7OZFBDfRh/p3Jw7mYOG5yA0lMN56W510
	+g2yaklKVeVIfpvofhlRXG9kJu7W8rHuDSnC2RNf3aExzVOEAYnrLiFdvVSfgu6j4/Seld
	8rsnloaEiior9O/5MKA0/ElA664efsZj6TwPJ08gehjDnDT31Jg4BWt7dqwKFhzzPW2U1M
	fP8GaDmV3lvqawJhvvtJ2OUxLhGWItUbnwcZvofq+9lHVyuCPzfcsV74twZh4Q==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Mon, 28 Sep 2026 10:55:09 +0200
Subject: [PATCH] perf build: Improve fix for "argument list too long" error
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260928-perf-orphan-args-v1-1-8cacf784621e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAG0rumoC/yXMwQqDMBCE4VeRPXchCRjQVxEPGke7HjTstqUgv
 nujPX4M8x9kUIFRWx2k+IjJvhX4R0XpOWwLWKZiCi5E14SaM3TmXXMZedDFuEZ0I9LkGx+p3LJ
 ilu+d7Pq/7T2uSK+rQ+f5AzYg2Rl0AAAA
X-Change-ID: 20260925-perf-orphan-args-5e60becd1916
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Markus Mayer <mmayer@broadcom.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The orphaned pmu-events JSON files are passed to the shell via
`echo "$^"`, which puts the whole list into a single argument. With
a long enough output directory path and enough files, exec'ing
/bin/sh fails with:

  make[5]: /bin/sh: Argument list too long
  make[5]: *** [pmu-events/Build:228: prune_orphans] Error 127

This only happens with out-of-tree builds, when setting O= to a
relatively long path.

To reproduce, build once with JEVENTS_ARCH=all, then rebuild with
a smaller JEVENTS_ARCH without cleaning first, so the leftover files
become orphans. Using nds32 (which leaves ~1100 orphans), an output
path of only ~70 characters is already enough to trigger it:

  OUT=/any/long/path (at least 70 characters)
  make -C tools/perf JEVENTS_ARCH=all   O=$OUT -j$(nproc)
  make -C tools/perf JEVENTS_ARCH=nds32 O=$OUT -j$(nproc)

Express the orphan file list as paths relative to $(OUT_DIR) by
stripping the common prefix and restoring it with printf, the same
approach used in scripts/Makefile.clean, so the shell arguments stay
short.

Fixes: b6712d91f8f5 ("perf build: Prevent "argument list too long" error")
Suggested-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
Tested-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 tools/perf/pmu-events/Build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 372773b998e4..4c7b082cb2bb 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -223,9 +223,11 @@ ifneq ($(strip $(ORPHAN_FILES)),)
 # of a build step.
 quiet_cmd_rm = RM      ...$(words $^) orphan file(s)...
 
-# The list of files can be long. Use xargs to prevent issues.
+# The list of files can be long. Remove the $(OUT_DIR)/ prefix, and
+# restore it with printf, to prevent "Argument list too long"
+# (see scripts/Makefile.clean).
 prune_orphans: $(ORPHAN_FILES)
-	$(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
+	$(Q)$(call echo-cmd,rm)printf '$(OUT_DIR)/%s ' $(patsubst $(OUT_DIR)/%,%,$(ORPHAN_FILES)) | xargs rm -f
 
 JEVENTS_DEPS += prune_orphans
 endif

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260925-perf-orphan-args-5e60becd1916

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

