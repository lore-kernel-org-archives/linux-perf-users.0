Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB74EFFA9
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013460; cv=none; b=EioYwhG+M6HOYmfWW+B3K2qIlRXacZJ5evkwh4rJY3veWFlU+hQWDGr677Wvuv5qpY63RhL2ps/mLIl8ZjjE/Fz8PXsmXTE052Sk+3Lle9+GKuC07i9eTfPE1YwJznDdf6bFL1TgXcaauueFkmyMtD6fFnVCfLR87/bUesNwGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013460; c=relaxed/simple;
	bh=gxxeVZ+Czzez9hQ5RdmahoT/9O3tt666XXtHFovWHFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R5uphEAaNEmOYofCYyhIoPYmw5MkH1Q8zF7AGRB7jMWcfhsox7rVxswZ+JluL9OtvMC2Zh2d7shoDJN8T7xTZ6GNvPPwQ2elfo4dfMyQIZaaE0maSo++IQSybDVSKcUVd+9Tpy0U1FMrfGcpSCL6gPxubyd8pMgMGkEjwDBSQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWK4gilT; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWK4gilT"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94f086fedso47738295ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790013459; x=1790618259; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HdDmKa2AFKTZLZHp779xvPgn4xciOWoVQ4wj/MC9FgA=;
        b=kWK4gilTcoudv2wlPhMCm0pFQcG6jy942oaNiLk0m0o8eMZDrvAL0hp5ZL0wfIgm84
         dFgVQTvnjasZzJsMeIjvCwAuiQ0THQXSyCaLPMWOncFx4ubwTE+RuWCbGycCAqmUdYT6
         dCQM3lp9WT7ZnpkpHU1vUw6UGxRzVpz9GeIHzFoC9Y7mtWxnG9rrWC0csIcNLlM6BqsK
         8u1j0nzdP8FRP7H3kvc3cllXYRg9qUShrdhA6UOWzgfJPAD6XZvBMxveIbKiHmQJedM2
         R4zSDqPaZ5Z/g7V5vwjw4aTmslTJU/RXiwKu49wj9Dwx9HgVhpRXFiJemF5gU0Xw5bhJ
         lMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790013459; x=1790618259;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HdDmKa2AFKTZLZHp779xvPgn4xciOWoVQ4wj/MC9FgA=;
        b=Vf4C1KFHgyI16acPdYrN+gBY5YUW2ZH/3Risy1jjUUWkEPLy7nMm9QrZ8R4VpyKAe1
         repviqLTSFonYvNkUx+Sa1KVgTgy9Jghaa9f6Fzt3NX2H9gVN7T8GTePJ26/PqpKnk/B
         p4WWEQK6Ku1t/F6uOHiz4eMUZoIHvlqWpGpEXsXxOYAxBen+Q1iGWxyd9xFu8Gg1Jtmo
         MYzkWrUNrDNuyDRHU/4CNzPCGg6YLCKauW/JQ1uChxD6faB93lWpTqE8tecFFnUOwpzB
         nLln3bGC9HdLE8o78P9R9Cw1C+gOu4eXqs7xvE+gcG+ZlhBYkuB3TCdHSBH5e4RzLvoN
         8WPA==
X-Gm-Message-State: AFuF++mCuFxUUYniiON3dBZdvcVC9KpPDdREBveh0ENhMwghJxiHTFJM
	MgjaJ8lZ+XInzB4yJ+mD2Q/O0G2IlXVziZE6FEnf4j7Di/iv6++HwKB4eQcsQq71fh9HotBmEZC
	jy1puFaNOsA==
X-Received: from dycao20.prod.google.com ([2002:a05:7301:7d14:b0:33b:ece2:d254])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19d0:b0:2dd:c053:ec75
 with SMTP id d9443c01a7336-2ddc05409a8mr109542965ad.40.1790013458666; Mon, 21
 Sep 2026 10:57:38 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:57:19 -0700
In-Reply-To: <20260921175719.846883-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ag8X7gcDw6jpJsLq@decadent.org.uk> <20260921175719.846883-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921175719.846883-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf tools: Put Python bytecode in output directory
From: Ian Rogers <irogers@google.com>
To: benh@debian.org, acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	tglozar@redhat.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ben Hutchings <benh@debian.org>

The PMU events are processed into C sources by Python scripts, which
normally results in writing bytecode for each module into the source
tree.  This prevents a fully out-of-tree build.

To fix this, set $PYTHONPYCACHEPREFIX to relocate the bytecode cache
directory in an out-of-tree build. Note, this environment variable is
only supported by python 3.8+, but the file Documentation/Changes
states the minimum supported python for builds is 3.9.x. In an in-tree
build in tools/perf setting the variable causes a single __pycache__
directory in the source tree.

Expand python-clean to also clean the __pycache__ and perf.pyi.

Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Rebase. Add clean step and commit message comment wrt older python
    versions (Sashiko). Make setting the environment variable true for
    in-tree builds, that simplifies the clean.
---
 tools/perf/Makefile.perf | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 438102bcae6c..715642630067 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -397,7 +397,8 @@ PYTHON_EXTBUILD_LIB := $(PYTHON_EXTBUILD)lib/
 PYTHON_EXTBUILD_TMP := $(PYTHON_EXTBUILD)tmp/
 export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 
-python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
+# Put Python bytecode in output directory
+export PYTHONPYCACHEPREFIX := $(OUTPUT)/__pycache__
 
 ifneq ($(quiet),)
 python_setup_quiet=--quiet
@@ -919,7 +920,12 @@ $(INSTALL_DOC_TARGETS):
 ### Cleaning rules
 
 python-clean:
-	$(python-clean)
+	$(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)__pycache__ \
+		$(OUTPUT)python/perf*.so
+	@if [ "$(abspath python/perf.pyi)" != "$(abspath $(OUTPUT)python/perf.pyi)" ]; \
+	then \
+		$(RM) $(OUTPUT)python/perf.pyi; \
+	fi
 
 $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
-- 
2.55.0.1082.g2b9226bbc0-goog

