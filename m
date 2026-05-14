Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE623644DA
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776498; cv=none; b=Iy3biA7WfM1ARVuebcfcs2hYYTg36hXQwT+KIimrpbBJiRS7yCIfQyhipYAExnnrDjlKREn4gs9D+N75oqdfwSJjM4TtfJIrdrsFH1gaeOOMauKg5FHNdIO7+hRcO6aTsTXLO9y0UvTC5EnrFMnvu0x9N25Xg7qCERUWFqY0SKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776498; c=relaxed/simple;
	bh=OlJMLHxTvdwWkQUQIlnjX9l+g8QHwmLvUu+ZPddFRfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7/9CVayOuF4S6RjL6oUc12T6hlozbwfRVFurVw7LLRfbW15qY9ehXZ5/s5XkVAJGbm0cmYGFtXb1mHSWYd80Qx931sLLpKrrF3RJZqzghtLzj2Inc927O+La42hyp1ZH0PMuqTYYzBMUaofoREsOgjkYQ2NiA77o6RzyMLqYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGQ+niPp; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGQ+niPp"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ee34588671so10946108eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776496; x=1779381296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfDc1bcKEUhtiGECvbeIiNM7pgIl+LxxIRj7Nb+DgBU=;
        b=ZGQ+niPpz17TzlcZa/l0fkpKZWcrNrxVoZzUhSsobVWLBRL7zK/5ZsA6GAxtlyi5Zd
         T6Jo485rbsv6pmGIqmtC4vX7ejgzdV7mYLRFKMVtoflUgsNdgEGQqALv9tE+eZSTNEky
         QNZ5F7Yi8u9vLW2tfcNIYyupo1F88/G8mmUAXuEYmRsxWvkp61jKdkvXUnmI9Q9/uvTJ
         4/D+EdNFwOW1K1bTrCT4ouMiu3UOlGPaNFJKuHgJqxlEyeVmC08gjgsnqjpWbtbbfIV7
         dPCgVHRGxFnbd5/anM8CCE41GlsnJqNLE8KTXycGOe0E4a/Ik7DpVJeJh8dO+LxMfMND
         bS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776496; x=1779381296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfDc1bcKEUhtiGECvbeIiNM7pgIl+LxxIRj7Nb+DgBU=;
        b=kgpwdpiuGM+SrvSBpERlaaKAdpUxInu54ydt/rg3zQIx7TOZONfSvEHS9945Kmg0fK
         nHOYGpKyvNk7NI/rjtQDroZzBFj8DFfDtGaJtvfGuFNhSfl0YZPURoOxkKj+vk+3bRmr
         oAoN0zZIdAr9Z5T5x9GAyRUdJypuDDN2On90kakgyuLHZTs86M9bSOQ4G+PUjd80JoHS
         Ktd+u3tG71Ky8YIylolMiwhgQoqbW/vxSa/3B7LR1vdal2EUrJJZnPqranI+RbSjsFhF
         lLygnQTXresx8HDgFS1S7/+s5+brt3RUyoOOhi6GrnHfjqRBDMp/YXmrK6AHHG/W+0NX
         UTCg==
X-Forwarded-Encrypted: i=1; AFNElJ+75zSkZnUeOZIIQRNAME5541ucJH2s3rwXnBbNRWLMGQVqBh2tO6v5PYshf+DRAJCwzBFikXvv9wBALf7Z6KEl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4apouvAzE3ic6bOrvMKB170s5WH9Kz9KRMi5EsFHWisvkT18v
	pDO9jdBsnH5lgRbRi/W765w0GTd7rpvgeXwau/WL03ZZFqejWaJ8zYs6sLRqj0IoZ91VHQFZQ3s
	BzhR/xq8Qdg==
X-Received: from dyz15.prod.google.com ([2002:a05:693c:408f:b0:2f9:af7:5040])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6884:b0:2ea:5057:a2f9
 with SMTP id 5a478bee46e88-3039867f58bmr92041eec.16.1778776495689; Thu, 14
 May 2026 09:34:55 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:05 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-14-irogers@google.com>
Subject: [PATCH v3 13/17] perf pmu-events: Split big_c_string storage into
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
pmu-events-string.c, keeping the build fully self-correcting.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore            |  1 +
 tools/perf/Makefile.perf         |  4 ++--
 tools/perf/pmu-events/Build      | 16 +++++++++++++++-
 tools/perf/pmu-events/jevents.py | 20 ++++++++++++++++----
 4 files changed, 34 insertions(+), 7 deletions(-)

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
index 01da32cd8988..3be0be5eb43b 100644
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

