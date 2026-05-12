Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DB3E5A11
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608041; cv=none; b=udESNBm51V0f1dERyQjHsrKvUQ0Xxk2BQXvcxtVduDe9MNFRPe8n9w6AzNy7lT6S98k9UCMp+5NSrlZaah7H7xCH0tZeFGb4RYmCw8FiX5K6U+s+vC+pjRtTxHzXuHxpUfnuoP4pTRnF3THIisr0Nrcua3SdA6Cfc5ALkOSTL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608041; c=relaxed/simple;
	bh=aVeetu0i9pJvvdQlKW2orztydFPaYslh6O+fJ92QNxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l01pIjpZuoYZwLZDrOkSt/+KOR8eYi7ilU/mqUYsRgOhDxaXyA0mkTXv0YfBlhaImFK2dcGxCkArDo7WKz+TsKFsyvsPh0B6W++sMIObq53jX4TYjONdrbYqBiLIghi2Zt6wOH4Z/xhQSOPneekQvLJom5rJ+yPdsEM4dAnn814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbhhac6n; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbhhac6n"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fded513994so7816565eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608039; x=1779212839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LcYsFf4HI19tCNBxoq7qOzkOfWxUuLxu2pXUmt71oU=;
        b=kbhhac6n6D3B4Q6Ni8rIbhnojgR8pyM24jLaVmz0cfAUw9T9dNHm2Xx84h034yn2ki
         +HQ0jH3m6GCqJJ5fdreFehtj5zqcmVZTilI3cpl5SWfhWoudWWp9NOMZIGNRi0jj7+/5
         j4xhCX0cU8uaWqCeqjE7kmA/SyrzPNfCI8PvLVtsgdkF+GRo3VgO3gIy7RqoUP6aWllb
         yzSCmkx/YFQ6m1/6z2ZVk6qLSMvGO+3WIL9YDIoowHFcxdI3l5KzgiR1LmnsLKsHqpcZ
         M1xxHVX6MDOlbeXXzuONTX6Iv3NG+bGjmxTGhG1gq9s/mXIuAsbazli3M3hFMLHf9Hwr
         LXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608039; x=1779212839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LcYsFf4HI19tCNBxoq7qOzkOfWxUuLxu2pXUmt71oU=;
        b=h440UboNDDm/oWlTn+x1Qrv56An0zJv76AQymyPur/IO128P4BLCib9XCWXFRijzXX
         /Y5AxPLJGfL9yZhpcJ9fSK31+odgMDLqXkiL117hH2mQJN1oQou4oVvbZi6PaUmYjPMp
         cC5AbovGs8oYTGKr96BPaZcelVmDNQAbpMsl+qTeWezHJ3Ir9urkDvPvmvd1X7doqB0y
         RmdapnTU2W1sfB7FtOhPjJvmliGVAoIqeuF5cq8HD0gjCUq5VroAYFbIpXlTkPMJAfYF
         dvaSYq5c5VeoFa1ujNwWbs91ddlPwJYEqUJwMyml6eAk+NEU3/0LCjj8ZC8AP5bX0r7X
         oOTg==
X-Forwarded-Encrypted: i=1; AFNElJ+kCGA/t6DWVT7XroCPe5lJbOrxObCwbmm6rZPgbKa7DutmT1YhuR96BFZiKjZa/YvzlWzwX/fG0G114SlB7miP@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgI1DGwcedXQtn/kgrWkKk9eEqLYSBNvrdfEnhWP0vzMLzY4Q
	rFHROI+kXj2kInSvdmJYSvV3k6lIoSwWUT9uw/PimT4MJ+uNSrGpi/acwTEw5rS2U18m2FH9Zem
	ZZNw7TmKblw==
X-Received: from dycnr8-n1.prod.google.com ([2002:a05:7300:e9c8:10b0:2f3:e5fe:f565])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1486:b0:2da:4216:7ea3
 with SMTP id 5a478bee46e88-30117a7b8camr59716eec.14.1778608038494; Tue, 12
 May 2026 10:47:18 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:34 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-15-irogers@google.com>
Subject: [PATCH v2 14/18] perf pmu-events: Split big_c_string storage into
 standalone compilation unit
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Currently, jevents.py emits both the massive 2.8 MB big_c_string literal
and tens of thousands of compact_pmu_event struct arrays into a single
pmu-events.c compilation unit. Compiling this giant file takes ~2.2 seconds
on a single CPU core during Kbuild startup.

Refactor jevents.py to emit big_c_string into a dedicated
pmu-events-string.c compilation unit. This allows Kbuild to compile
pmu-events.o and pmu-events-string.o simultaneously in parallel across
two separate CPU cores, preserving 100% string deduplication and zero
dynamic ELF relocations while cutting C compilation latency in half.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf         |  4 ++--
 tools/perf/pmu-events/Build      | 15 +++++++++++++--
 tools/perf/pmu-events/jevents.py | 20 ++++++++++++++++----
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d2e673d5e5be..98b6f9fda8d1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -921,7 +921,7 @@ bpf-skel-clean:
 pmu-events-clean:
 ifeq ($(OUTPUT),)
 	$(call QUIET_CLEAN, pmu-events) $(RM) \
-		pmu-events/pmu-events.c \
+		pmu-events/pmu-events*.c \
 		pmu-events/metric_test.log \
 		pmu-events/test-empty-pmu-events.c \
 		pmu-events/empty-pmu-events.log
@@ -929,7 +929,7 @@ ifeq ($(OUTPUT),)
 		-name 'extra-metricgroups.json' -delete
 else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
 	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
-		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/pmu-events*.c \
 		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
 		$(OUTPUT)pmu-events/empty-pmu-events.log
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index dc1df2d57ddc..e957aa2fcb48 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,12 @@
 EMPTY_PMU_EVENTS_C = pmu-events/empty-pmu-events.c
 # pmu-events.c will be generated by jevents.py or copied from EMPTY_PMU_EVENTS_C
 PMU_EVENTS_C	=  $(OUTPUT)pmu-events/pmu-events.c
+PMU_EVENTS_STRING_C = $(OUTPUT)pmu-events/pmu-events-string.c
+
 pmu-events-y	+= pmu-events.o
+ifneq ($(NO_JEVENTS),1)
+pmu-events-y	+= pmu-events-string.o
+endif
 
 # pmu-events.c file is generated in the OUTPUT directory so it needs a
 # separate rule to depend on it properly
@@ -9,6 +14,10 @@ $(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
+$(OUTPUT)pmu-events/pmu-events-string.o: $(PMU_EVENTS_STRING_C)
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
 # Message for $(call echo-cmd,cp), possibly remove the src file from
 # the destination to save space in the build log.
 quiet_cmd_cp   = COPY    $(patsubst %$<,%,$@) <- $<
@@ -118,6 +127,7 @@ CUR_OUT_JSON	:= $(shell [ -d $(OUT_DIR) ] && find $(OUT_DIR) -type f)
 
 # Things in the OUTPUT directory but shouldn't be there as computed by
 # OUT_JSON and GEN_JSON.
+
 ORPHAN_FILES	:= $(filter-out $(OUT_JSON) $(GEN_JSON),$(CUR_OUT_JSON))
 
 # Message for $(call echo-cmd,mkd). There is already a mkdir message
@@ -222,8 +232,9 @@ endif
 
 # Finally, the rule to build pmu-events.c using jevents.py. All test
 # and inputs are dependencies.
-$(PMU_EVENTS_C): $(JEVENTS_DEPS)
+$(PMU_EVENTS_STRING_C) $(PMU_EVENTS_C) &: $(JEVENTS_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUT_DIR) $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) \
+            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
 
 endif # ifeq ($(NO_JEVENTS),1)
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 3a1bcdcdc685..70a45e62f5d1 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1422,6 +1422,8 @@ such as "arm/cortex-a34".''',
   )
   ap.add_argument(
       'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
+  ap.add_argument(
+      'output_string_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=None)
   _args = ap.parse_args()
 
   _args.output_file.write(f"""
@@ -1463,10 +1465,20 @@ struct pmu_table_entry {
     ftw(arch_path, [], preprocess_one_file)
 
   _bcs.compute()
-  _args.output_file.write('static const char *const big_c_string =\n')
-  for s in _bcs.big_string:
-    _args.output_file.write(s)
-  _args.output_file.write(';\n\n')
+  if not _args.output_string_file:
+    _args.output_file.write('static const char *const big_c_string =\n')
+    for s in _bcs.big_string:
+      _args.output_file.write(s)
+    _args.output_file.write(';\n\n')
+  else:
+    _args.output_string_file.write('/* SPDX-License-Identifier: GPL-2.0 */\n')
+    _args.output_string_file.write('/* Autogenerated by jevents.py */\n')
+    _args.output_string_file.write('const char big_c_string[] =\n')
+    for s in _bcs.big_string:
+      _args.output_string_file.write(s)
+    _args.output_string_file.write(';\n')
+    _args.output_string_file.close()
+    _args.output_file.write('extern const char big_c_string[];\n\n')
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
-- 
2.54.0.563.g4f69b47b94-goog

