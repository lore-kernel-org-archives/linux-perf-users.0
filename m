Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF633093AB
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923546; cv=none; b=JbTrWxB9FkCr5g1histwudCfYA56uyOezc5QrmuUNFJ42J2f1hPZmpC0ocWVgJaTLW8raSREWCEhzur+52CteKO4rl/gTaPUjQxaM6lOXPU0++JcOxAZaNoNp6jUk7/1QIWrIkcrGaC5IOHV4R61O84xFAh2tIo9vhwlgf2+fFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923546; c=relaxed/simple;
	bh=fRsf/FEB4GjuaGWyi/d9cHIRU0MmCx8JFwRy6Zni2Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lKbc4DhHRV0aePnmpzG5lrnMMxfmYwBCUAmxH0bzyXmC6KV3dBEuPhHgRtBmzUHzV0FnXDLQerHDfXSfpBGA0kl5vnvWHNkgavVxiR7lZVkODy22WBJghcG+qoMMU0lMB/Z0TS8kvCHTzxIPRSDwcecsFlXvCaKqpE9b5tyKASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fr8tFHkn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fr8tFHkn"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so5032141f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768923542; x=1769528342; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sj9dRhbBSv6PKEmM/O/5RJygiIW/moxPpbnXDMDVNw=;
        b=fr8tFHkntkN8xDi5cssK8tqbhv7k0P5v46Dvs73/AV2knHRh4O2UjOwkv/TZwTDCFI
         RGie2lWnemIdorOmnKiF/XtmyhIAUddUbVLYieiVTODkIQfdZqhnHvWrCP9J77+VkyMF
         qsfbDt6TwUyhy7+YNSsCchjx+SInQzxYu12PKGsY3Ix9ejhZjpt5TdRaiQyfyy/MqsxW
         YIi5RaQfH1OVXlc1s3MCuYHB2JKVjnGZ4ng4xXdXpzzsmT228sQv8mzNgKSO00TWK32Y
         eenk78eAmw44q2Uyo7R1sT96RYHd5YLT37OtpFX63oejo3O4RhUClZd5rU5LCEwJChl5
         OG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768923542; x=1769528342;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sj9dRhbBSv6PKEmM/O/5RJygiIW/moxPpbnXDMDVNw=;
        b=gyPmxzR3izOLC1TKSC6O3eptkjtUFKXop276IFVOAw/AfYDGzhS2MK28oR3jaxFmJM
         u3Mr68kDuJE9rWNrnNXnfYYnPJ8FRrvzID42iRKkcNS3rwA+pY8Hf7pz9pALj3d28g1j
         CRR/LhO0OcZEen/2abegXX5X4aLEIWikfx3HLugy2cWAJ9Ye7a0Hvw0XUzgbTPEsWMCk
         5dcjuwXDQ2swMBeSWCypu68YKRKU/H+Ptz14l+rcb6hK4iEXdCIYplX5JvzubfB+MgB1
         cCKiO8/EVm8ICB/oanc2WClGwoUADvlb4XY8V4xLWidPY440pXsJxJ6bCwy9wfbOTT50
         3M2A==
X-Gm-Message-State: AOJu0YwjQE9Xv0kMRqfxb5BdZ9ALFMngqvGwPNdIgkMW8cS8xiWh0ZLO
	OjZvfmdNy8mJiv9LNKfOQHuYqLvPcPb8wBZC1I3BWkIHWdNPbKZYO3Q7zGy0ZWA2uEw=
X-Gm-Gg: AZuq6aKwZlB6zpE1FxUY6G1HjjGzffgxZiRpPHolDF0UUaixdbWCwpKxsZJGu17piFJ
	/rDeGA2VFYx4+Xv0cgSi8gf+LJ5w5sUTApFPqVXLw5dZkWtj010PQk4NKVKBqzPHaYIME8iwPrT
	uxA0PxHQbE0YUF+iAukunR8/gt/gFy9weIhQdvYVwLGSM+8ZcZp1U602N2G5i/ytySk+6QwcZpn
	Aym02TBDVkb2ji5pp805clZRs9mXd5fxWPNg3Ipgc5D4VRy73axQsJhjIsDgdhy0gI1CadYA0u2
	l/9cY1sU2G8ioPkeQ2yMGsFIKVgh4N/8Aw6aEHhLMjbpeKKLezK/rmHEBCW0o887fccG8pmSrCY
	zPH5cdWAxARZIvrsR/v07xPgdIiDqEAlGsZeAQypMqwYiydwNdIxRq7+NbraByEJoNs8O79j3JL
	DLxh9k+e7u+fkIDP6MijXI
X-Received: by 2002:a05:6000:2486:b0:430:f3ab:56af with SMTP id ffacd0b85a97d-4358ff3026amr3361684f8f.48.1768923542189;
        Tue, 20 Jan 2026 07:39:02 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435924ae723sm3375552f8f.41.2026.01.20.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:39:01 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 20 Jan 2026 15:38:19 +0000
Subject: [PATCH] perf jevents: Handle deleted JSONS in out of source builds
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-james-perf-json-delete-fix-v1-1-bae2194b1dcf@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGqhb2kC/x3MQQqDMBBG4avIrB1IIja2VxEXWv/UkTZKRkQQ7
 27o8nuLd5IiCZRexUkJu6gsMcOWBb2nPn7AMmaTM+5hrDM89z8or0iBZ10ij/hiAwc52Nu6rob
 KP9GA8mBNyPk/b7vrugG+E5h2bAAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The cp command here doesn't remove files that have been removed from the
sourcetree. That means incremental builds can either succeed with stale
events or will fail completely if a stale json file has a broken
reference in it.

Fix it by using rsync instead of cp. legacy-cache.json has to be
excluded as this is a generated file isn't present in the source tree.

This only happens when deleting a JSON file, which has only happened
once since the linked commit. The fixes commit is marked as the origin
of the problem in case any future changes that delete JSONs are back
ported, rather than the first commit that deleted a JSON file.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/linux-next/aW5XSAo88_LBPSYI@sirena.org.uk/
Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
Signed-off-by: James Clark <james.clark@linaro.org>
---
This is a bit of a hack and I thought that making jevents.py handle
multiple input folders would be a much better solution than this. Then
we could have "gen-pmu-events" for only generated files and "pmu-events"
for only in-tree input files. It would be very clear what's generated
and what's not and all copying rules and special clean rules just
disappear (and this isn't the first time these rules have caused build
issues).

Unfortunately, after a while of trying to modify the script I thought it
was too invasive for now. The script does output per-file at the very
bottom of the logic in process_one_file(), so adding files in another
folder ends up re-emitting section headers when another chunk is output.
Although other parts of the script do build things up in memory before
outputting so it was possible to make those parts work with multiple
folders transparently.
---
 tools/perf/pmu-events/Build | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a46ab7b612df..079d04c4f7d8 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -12,13 +12,16 @@ METRIC_TEST_LOG	=  $(OUTPUT)pmu-events/metric_test.log
 TEST_EMPTY_PMU_EVENTS_C = $(OUTPUT)pmu-events/test-empty-pmu-events.c
 EMPTY_PMU_EVENTS_TEST_LOG = $(OUTPUT)pmu-events/empty-pmu-events.log
 LEGACY_CACHE_PY	=  pmu-events/make_legacy_cache.py
-LEGACY_CACHE_JSON = $(OUTPUT)pmu-events/arch/common/common/legacy-cache.json
+LEGACY_CACHE_SYNC_PATH = arch/common/common/legacy-cache.json
+LEGACY_CACHE_JSON = $(OUTPUT)pmu-events/$(LEGACY_CACHE_SYNC_PATH)
 
 ifeq ($(JEVENTS_ARCH),)
 JEVENTS_ARCH=$(SRCARCH)
 endif
 JEVENTS_MODEL ?= all
 
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
+
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
@@ -31,17 +34,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 else
 # Copy checked-in json to OUTPUT for generation if it's an out of source build
 ifneq ($(OUTPUT),)
-$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
+SYNC_PMU_EVENTS := $(OUTPUT)pmu-events/.synced
+$(SYNC_PMU_EVENTS): $(JSON)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)cp $< $@
+	$(Q)$(call echo-cmd,gen)rsync -a --delete --exclude=$(LEGACY_CACHE_SYNC_PATH) \
+		--include="*.json" --include="*.csv" pmu-events/arch $(OUTPUT)pmu-events/
+	$(Q)touch $@
+
+$(GEN_JSON): $(SYNC_PMU_EVENTS)
 endif
 
 $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
 
-GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
-
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)

---
base-commit: 571d29baa07e83e637075239f379f91353c24ec9
change-id: 20260120-james-perf-json-delete-fix-71553b379e8e

Best regards,
-- 
James Clark <james.clark@linaro.org>

