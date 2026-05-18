Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD347CC98
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119239; cv=none; b=Wg1EWbEs52WuZG3rePzXV/AMcnLAppUzB+DGi8kQG6X/lHPvl8sxGigQOlBJsVy2FBOD/kelupx8mgJJ0/X5gMuKN/86GC9fVJq9k13VHG64+2fKzGWqhh+PX9GWwnmNg2BNklXV8bhGmKmswOb2zIjN2+YCjZ0fRc7iXSIUJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119239; c=relaxed/simple;
	bh=W1AKf6HBmEZYwn59EoYtmY5+eNzGcl5c+gVy8e78TF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xlq8WXs597imxTD6l2cwBhcC85u1jC7D6OVEWvl1GFJTEaZ+EKUJ0B2DG12gGq1oWjUpsjulWnKPulQdRDe4ujoWSIcCGmvo4vbQoa7Cn7/OVf04T6/RaLB2jShZgkSnp/CpwIEm1UKcBj5LkTdS50VZRO0F6hjBlvwh52Ilxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDSWCAM9; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDSWCAM9"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2efc342ef15so3385098eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119226; x=1779724026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8Gn9u6Ay2gAeNSJD6VxHlLmg9jVbwsa1tUO88FBQSI=;
        b=CDSWCAM93WyW/HDu8uqlHfd4chVEi7mRKxeEQl8pVkQ1W7S3ntEOquUgNYHFmemc5u
         tJkpI90ikUkSz1cdn3Zk8eAYbq6RawEDyGczsE9cQAuQyxZNszYY+kAuzZ12BcZOZeKU
         oKdtj8a0oRm/Vfq1pdky+rXXQYDACBSVi3uzenUtnI+i3oYC3MzYNpmY2EIU1eOgVzBs
         50YY7E1Esu83FNukA+WMusUSxs9FpZCgmZBVNrUkIMyLeUJX2bTH6k+2fjRHectuhIqz
         KHYklyfo3q77ksNVuFAjieaSZt1YSOc301U3JxUJhr+u+vX2A/uiFS47DwRARmGtQXhu
         pDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119226; x=1779724026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8Gn9u6Ay2gAeNSJD6VxHlLmg9jVbwsa1tUO88FBQSI=;
        b=A75DQJ/kPyDruh7DS/wX07deGfzBH1JI1uY6Tr/b2aZBvN2JmHKprYeNc3GGuTU1XT
         Bz5ryALLwZqA79vw9zc90EWoY1inZGwWjzNdn5Zh1uJqzQkrl/ulsURyNIntytL2O3+7
         8l4s1nvMnwOLd/E6NLn+GhgQCqR4v8tjJT+2Iv4gZ5FcK4483bMB1Z/ibKBHlWllGpCu
         qv3p+qHHYT7ZLrunzKJgva68nHXXZ42vBdAVMYNWT1dYHzCocctIE3Seag5EWFw0SRhK
         Wf6bZPYtelQWeePDk8fYaSxO1D3g23QZ7zI5jzPRmucT3I5U2qQepkjvrTw9qTbyyeTi
         RE2w==
X-Forwarded-Encrypted: i=1; AFNElJ98a9zP9CxsphfRWvn9d9nYlVSVbCsV+WUPm9rn/jaakatHa3g5P+CRPIQkq8LnnmbN6WjjFTCdtTw5/WPRTF/w@vger.kernel.org
X-Gm-Message-State: AOJu0YxAILidj1PRDdjGfMlIh+T5Df47Ga3YIc7uPzsdUkjUogY7KikY
	ayJEOzigGp7ZVDJth1tBX9vKNikMPRm1NP6zWaAg26f31hvaUPC45UZv4Ri1Cpl+vQNbMZrQR2F
	9eRGcbR1jRw==
X-Received: from dlbsj9.prod.google.com ([2002:a05:7022:f909:b0:132:8d92:4d68])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41a7:b0:130:6904:8c17
 with SMTP id a92af1059eb24-1350451e28dmr6652405c88.18.1779119225401; Mon, 18
 May 2026 08:47:05 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:34 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-11-irogers@google.com>
Subject: [PATCH v7 10/14] perf pmu-events: Split big_c_string storage into
 standalone compilation unit
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
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

Add pmu-events-string.c to tools/perf/.gitignore to ensure in-tree Kbuild
runs do not leave untracked generated files in the working directory.

To guarantee 100% backward compatibility with GNU Make 4.0+ (avoiding the
Make 4.3+ grouped target &: syntax which causes older Make versions like
4.2.1 to spawn multiple concurrent jevents.py processes during parallel
builds), implement a robust dependency chaining pattern:
  $(PMU_EVENTS_C): $(JEVENTS_DEPS)
  $(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
          @:
This ensures jevents.py is invoked exactly once. If jevents.py aborts
early, Make's .DELETE_ON_ERROR: purges pmu-events.c, guaranteeing that
subsequent Make invocations correctly re-execute the script and overwrite
pmu-events-string.c. In jevents.py, explicitly close output_file first
and output_string_file second at the tail of main() to guarantee that
pmu-events-string.c receives a filesystem timestamp greater than or equal
to pmu-events.c, completely avoiding redundant incremental rebuilds.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore            |  1 +
 tools/perf/Makefile.perf         |  4 ++--
 tools/perf/pmu-events/Build      | 16 +++++++++++++++-
 tools/perf/pmu-events/jevents.py | 23 +++++++++++++++++++----
 4 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 0f9451a6e39c..3b968c5158b8 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -38,6 +38,7 @@ arch/*/include/generated/
 trace/beauty/generated/
 pmu-events/arch/common/common/legacy-cache.json
 pmu-events/pmu-events.c
+pmu-events/pmu-events-string.c
 pmu-events/jevents
 pmu-events/metric_test.log
 pmu-events/empty-pmu-events.log
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 96a68723109f..b8a81c9749a8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -925,7 +925,7 @@ bpf-skel-clean:
 pmu-events-clean:
 ifeq ($(OUTPUT),)
 	$(call QUIET_CLEAN, pmu-events) $(RM) \
-		pmu-events/pmu-events.c \
+		pmu-events/pmu-events*.c \
 		pmu-events/metric_test.log \
 		pmu-events/test-empty-pmu-events.c \
 		pmu-events/empty-pmu-events.log
@@ -933,7 +933,7 @@ ifeq ($(OUTPUT),)
 		-name 'extra-metricgroups.json' -delete
 else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
 	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
-		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/pmu-events*.c \
 		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
 		$(OUTPUT)pmu-events/empty-pmu-events.log
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index dc1df2d57ddc..95172a2a851f 100644
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
@@ -224,6 +234,10 @@ endif
 # and inputs are dependencies.
 $(PMU_EVENTS_C): $(JEVENTS_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUT_DIR) $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) \
+            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
+
+$(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
+	@:
 
 endif # ifeq ($(NO_JEVENTS),1)
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 3a1bcdcdc685..7344940e776a 100755
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
+    _args.output_string_file.write('extern const char big_c_string[];\n')
+    _args.output_string_file.write('const char big_c_string[] =\n')
+    for s in _bcs.big_string:
+      _args.output_string_file.write(s)
+    _args.output_string_file.write(';\n')
+    _args.output_file.write('extern const char big_c_string[];\n\n')
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
@@ -1476,6 +1488,9 @@ struct pmu_table_entry {
   print_mapping_table(archs)
   print_system_mapping_table()
   print_metricgroups()
+  _args.output_file.close()
+  if _args.output_string_file:
+    _args.output_string_file.close()
 
 if __name__ == '__main__':
   main()
-- 
2.54.0.563.g4f69b47b94-goog

