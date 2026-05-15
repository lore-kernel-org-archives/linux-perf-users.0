Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9243F39FC
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866763; cv=none; b=pcpbt6tOLqZF1jkoe42iIpKJ0N+YQCOF7mLyfeRoPucl20w7j0lj5BTIAb09yvHassbVFKt71BKlAo50Os0918yQUFZ7OHl9jDNvftPEeSOJ+mjYDB1TEIKFqAACKsuiNTp0rIk4EsJavYwFYh1h8FAq0lMGqy5BNPpGbcWwsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866763; c=relaxed/simple;
	bh=YNZMnwp36O+5m9Gs5CHfzAd/xLtfl/djByV/FzOnEFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XYmhW48zq1WYbXcc4N0M3PDm+I9eA7IEFN31gaCTpycixAWLLZuz2wi9rO8/vtpMXFdo0nkprDDJ/FVZ0ohtkvSVNeXRTBKzqKu7w/XbT+DqqPE8bpANrWOK/N0EXAxSX5np16dd0Nh5sjtyjzG/9bMnF/Pd0xFHYhhJOvzHpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaNqZ7d0; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaNqZ7d0"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13537722193so254553c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866760; x=1779471560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuWrkD0BVu1tmlnEr1DinCWOGt+Ctx4gpJp+Vh/5zAI=;
        b=MaNqZ7d0rLN5pwA3oIx/K4UXqIL6Iqw29qxRghT8+Uxhv7BNGD27vHtFa47GoktY3R
         6l1Y9O0/9tZEcBTK4v289I39/yiwAqCBO6n4Dyvl/qvD5OrosmwoOR1Vj64aP7vwvX7B
         uqEbebKjgm4AAodiryxRoyxLrEEzwpCq6pRV3yehBUg9W0244wKdn+L5vcOkTLjQe73I
         5egcQfnhW7YW3w6Ru+GvJRyYjH1ouhTvJ2c1D8sP0o44V2XnpsI0ZWonMIYOylNvT8az
         odW3YpUcq8Ae96xOkramnJfHOK8S3eBPcN1Zobjo24xISSfnKbzMrik01ig37B/3NYgv
         cCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866760; x=1779471560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuWrkD0BVu1tmlnEr1DinCWOGt+Ctx4gpJp+Vh/5zAI=;
        b=LLsAXgcRkheehdPQ6ENcjQEtJqG1li9eCSRs1Ron2OVhdvQCq2v2SwPx5VLaJDq7k/
         ZT8Nyo75osGVzyT4Gt9oJrzAjdVxdyK0kExvJ4tFPQL490hHjtgUmMn/XKZzjTVFbsFW
         wY+MBoJQ1LPJHSDgGSTHkWG4jlHQPmQVy1DX8XY47RbZmm773juGZu5d9m0P837nyyFX
         UzJ3hdJIA5Fkhg6OkhA3+b90kPWnrDGFURtVHqwjgPBHLY1qCyMhQ5ZNwLwdD+cv7FjT
         4Xus0lgqe9jFvaVVvlphozmTyuiPhoBrwh2C2qTgLKrKMJX5kG9Ivv+2Ojo4xknNTMkJ
         5iXw==
X-Forwarded-Encrypted: i=1; AFNElJ+iELi4sp87NF2aBOsOlcOYioZBxT9Nah8rRq6KrPDxy5K8WqqXmp5uI3aOj4hz7rQU2a2h0rVLEDPE7qakoUHD@vger.kernel.org
X-Gm-Message-State: AOJu0YwFbtsua7Q+myHUJaqSY7GG3DwJ01gEds1nRQPa/oZ6y9AW8GrP
	NHlsFirzMeCCFV/RQOIx2B0uZIly8dXUoa64i9Gng0iDz+RmwzKNxHvpyBLV6XocmoNaQI1PcHs
	c8B+1bTpobg==
X-Received: from dlbrl27.prod.google.com ([2002:a05:7022:f51b:b0:134:a84d:d459])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:388a:b0:12d:e126:b7c8
 with SMTP id a92af1059eb24-13504416318mr2198425c88.13.1778866760223; Fri, 15
 May 2026 10:39:20 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:47 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-11-irogers@google.com>
Subject: [PATCH v4 10/14] perf pmu-events: Split big_c_string storage into
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
 tools/perf/.gitignore              |  1 +
 tools/perf/Makefile.perf           |  4 ++--
 tools/perf/pmu-events/Build        | 16 +++++++++++++++-
 tools/perf/pmu-events/jevents.py   | 21 +++++++++++++++++----
 tools/perf/pmu-events/pmu-events.h |  2 ++
 5 files changed, 37 insertions(+), 7 deletions(-)

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
index dc1df2d57ddc..00ae173cdb5c 100644
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
+	$(Q)test -f $@ || { rm -f $<; $(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events; }
 
 endif # ifeq ($(NO_JEVENTS),1)
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 3a1bcdcdc685..6adf4b30e1ba 100755
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
@@ -1463,10 +1465,19 @@ struct pmu_table_entry {
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
+    _args.output_string_file.write('#include <pmu-events/pmu-events.h>\n')
+    _args.output_string_file.write('const char big_c_string[] =\n')
+    for s in _bcs.big_string:
+      _args.output_string_file.write(s)
+    _args.output_string_file.write(';\n')
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
@@ -1476,6 +1487,8 @@ struct pmu_table_entry {
   print_mapping_table(archs)
   print_system_mapping_table()
   print_metricgroups()
+  if _args.output_string_file:
+    _args.output_string_file.close()
 
 if __name__ == '__main__':
   main()
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index d3b24014c6ff..fb4eb5b7ec16 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -141,4 +141,6 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data);
 
 const char *describe_metricgroup(const char *group);
 
+extern const char big_c_string[];
+
 #endif
-- 
2.54.0.563.g4f69b47b94-goog

