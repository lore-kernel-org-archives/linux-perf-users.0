Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855F30C600
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012491; cv=none; b=MCz9Y617rLvZUxuNvCfz+Qa9Wl4KB+d6D9GUUbQMoKxWXM27Q7eV5xlNiOGOx9XZt5slm4GJPFojJpO33ITKPc25vsW9UzSD7+zG+ydwSOHZSxxiix2atirGHbeS04m94Fe+gXNPFhZMnvHNR4yTuMi1NsCgDmdvFu9EdZqmiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012491; c=relaxed/simple;
	bh=QPlRDZ6YtMqz4rOZY4SerLH7qXodODt7cllxEzKDofI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lyEKCn9CfOBgf9Swca59NamX/S+VZc/Y42zjTxotGp+kZMqaYrpAUoMD0k4i/UsZ+uKeCbizvk9ZG1xdgivv3Px1rmgPfbXIRdiSnt3BCHNteDvN/p66JR6696PoHCFiDOyuuMgrqjFbq36QEWhBqmhSxC2GGFSNg9pIkckS96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F9A6n5sx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9A6n5sx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801d21c411so100665e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 08:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769012488; x=1769617288; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDYdRg9fOimYCwHsfGmb8CgucK2H/5fEbqXKpOFujq8=;
        b=F9A6n5sxbHzxT3DCG+I5oON2HBAvrm0hf4VQvCIsLV58VgjlsXw8qEEQXVfnGfvTiy
         AoaYvLyMIbRm8aULvVqO8k8YqmeRkmCsCs22gCetnSifBex/oJC0q+Y26TFdl5371+Ou
         yreQPG+GYDKFBQ8NHyAi0PKO91iRBA+VSLUfk5Dx+pvKKUU5w2/Ot379yzNTw68nPM2y
         /hXRGMkm9hHcmwEYfh/MwevAFoojzYns4ptdVJqdXu/wWcN0nKeNhjl3HHj8BO2lKO9C
         Vg+NDcRXeZl0XsO7Tev19N4ZilYsNE9CpT5Gc8drISIL6KEQ7nT4qh16nnhT/fFMwQmU
         UP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012488; x=1769617288;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDYdRg9fOimYCwHsfGmb8CgucK2H/5fEbqXKpOFujq8=;
        b=RFM0Oz7c7G5jsWCA90uD6ZMQPRtUmQ0UjwphDte8CClgy+yuPLI79s2MviSEUevGcW
         nTFd/lvFWxGP5egxrr2AjMRjdYHxqlc2VgUehv3ygy4XYlh1YWPPbWh3B2Sz+sSbXmqY
         r7d95yUYjC4HP8rfo/gITbhPt9XaZ5UfFMzYYpVXb7mZCcgdh8vavI2+I6mGYW7T4TEY
         EigFZx7cFk7vbt+6PQJUWCOGdrYj03Q9VhTt1DgAlwEgJOvtZFCb4t/cigtIcXINOKEv
         5T5wuCjV9XGgD7IHPLwnOQ9qSWfSY+5Twtx9N+9hrjCsRqAr0LNM4Uyyrs6CvLdS/MlQ
         nF9Q==
X-Gm-Message-State: AOJu0YxFA06r5fGVKCEQSjyaVnm/YwDmcuu301GlRu1AdB63A0k7rCwH
	RUTZKGpq0MskSBnRCzv8jNczkjI9Jxhof9T9UVJcvpLOvtNKJCwyBBlGEvw6S3tcycA8XpOs9h8
	kV2DW
X-Gm-Gg: AZuq6aIGMQ6hrqZgnwToH9mcj9d6iLcU7bucSKAHAJu7WVIB70EOIN2c66HenncCgyh
	pIMQFP8sJggNUFcREeztpvx5KkkL5AItceSHW+9vURT9D95TZWnLwWcADL/B5OoOBjb3mtoYS67
	ht5iCWoLXxA+w1JIoZ+VaS/LWIthBC8/XtqF1srQ0ZqJBVaFkb1afSW9Gp7xVgdmUCY3eoepf1J
	eO8YVVEU6IRFIk4/b4AHEJCblXm38wMRJ9fQMwn7HYZ/UUwY9L1lVkvzec1M90q4wd3j42dwThM
	xLR2QKkplmffnv2prYxQDZBnui1rlf+Pb/llfQXugQ/5YB07rbrTt1RUyBme+qhQIkvzZhC6xt0
	XsUz5WKlZsFNN0sFpgMvLoFTY9K0ShJ2SfTmADzAPysuZDTmVnja2TQ98l98wpyXXjKJ1xhnGkL
	5aOmsgdqAvT8y/xkYJbyLZ
X-Received: by 2002:a05:600c:630e:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-4801e34f6e7mr277943465e9.36.1769012487528;
        Wed, 21 Jan 2026 08:21:27 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cecasm35055233f8f.26.2026.01.21.08.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:21:27 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 21 Jan 2026 16:19:40 +0000
Subject: [PATCH v2] perf jevents: Handle deleted JSONS in out of source
 builds
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-james-perf-json-delete-fix-v2-1-2e10f895bfd7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJv8cGkC/42NQQ6CMBAAv0L27Bq2iIgn/2E4FFhgCbZkS4iG8
 HcrL/A4c5jZILAKB7gnGyivEsS7COaUQDNY1zNKGxlMaq4pmRRH++KAM2uHY/AOW554YezkjQX
 leVZnRck3hhiYlaM+4s8q8iBh8fo5Xiv97F/ZlZCwtmyovNTUNt1jEmfVn732UO37/gWfCj02x
 QAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Make the source folders a dependency for the generated folder root so
that whenever a file is deleted from the source it will force a new
fresh copy of all the JSON files and avoid stale deleted files.

JSON_DIRS_OUTPUT_ROOT needs to be a dependency of LEGACY_CACHE_JSON so
that the root folder doesn't get cleaned after the legacy JSON is
generated. But this is a no-op with in-source builds as
JSON_DIRS_OUTPUT_ROOT is unset.

JSON_DIRS is added as a dependency of PMU_EVENTS_C which also forces a
re-build for in source builds when JSON files are deleted. This could
have also resulted in stale builds, but never a broken one.

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
Changes in v2:
- Drop dependency on rsync by wiping the output folder any time a source
  folder is updated.
- Also fix the same issue for in source builds by adding the source
  folders as a dependency of PMU_EVENTS_C.
- Link to v1: https://lore.kernel.org/r/20260120-james-perf-json-delete-fix-v1-1-bae2194b1dcf@linaro.org
---
 tools/perf/pmu-events/Build | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a46ab7b612df..4f9ef624ba70 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,5 +1,6 @@
 pmu-events-y	+= pmu-events.o
 JSON		=  $(shell find pmu-events/arch -name '*.json' -o -name '*.csv')
+JSON_DIRS	=  $(shell find pmu-events/arch -type d)
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
@@ -31,16 +32,23 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 else
 # Copy checked-in json to OUTPUT for generation if it's an out of source build
 ifneq ($(OUTPUT),)
-$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
+# Remove all output directories when any source directory timestamp changes
+# so there are no stale deleted files
+JSON_DIRS_ROOT = $(OUTPUT)pmu-events/arch/
+$(JSON_DIRS_ROOT): $(JSON_DIRS)
+	$(Q)$(call echo-cmd,gen)rm -rf $@
+	$(Q)mkdir -p $@
+
+$(OUTPUT)pmu-events/arch/%: pmu-events/arch/% $(JSON_DIRS_ROOT)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 endif
 
-$(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
+$(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY) $(JSON_DIRS_ROOT)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
 
-GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON) $(JSON_DIRS)
 
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)

---
base-commit: 571d29baa07e83e637075239f379f91353c24ec9
change-id: 20260120-james-perf-json-delete-fix-71553b379e8e

Best regards,
-- 
James Clark <james.clark@linaro.org>

