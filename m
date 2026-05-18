Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AF3876AF
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079700; cv=none; b=cGjuGLYMRg1NTXZUQiJ6tMW6VRglsUcHnMdgcqkqHCZfEoULdr/pNpBzH3gHUYLFV9v0SG5z1UVRzL7RMJtiXeF72F9X25ApOulnE7l3eh83wfw6x5CpSTBct4pci4jtQMY5YICkJfhDJNhBuyAFohKcP+LF7GFcyaLHiEl5Vic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079700; c=relaxed/simple;
	bh=W1AKf6HBmEZYwn59EoYtmY5+eNzGcl5c+gVy8e78TF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o1PJK8VE7ggMkbCJ5HV9oj56LrFEjavct9DElctikduN3WHKB8yjwJlpmA0wmDuwcisG/8bR5IXQD8Br9YkpAid6jm/v4rJK1yt7p1cFrBFxgObu3Bd6Rt8nUtMibiST7sm4Kjgm4NM5c7uySQTf8+VT3iaBbTa6IYuWuuN65XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8dOgxeU; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8dOgxeU"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13537722193so3346861c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079694; x=1779684494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8Gn9u6Ay2gAeNSJD6VxHlLmg9jVbwsa1tUO88FBQSI=;
        b=G8dOgxeU8ZqRgeH2hCEEDhIDXUWtDnYIqduW9GDfbACf7N2o6SsT5cOOQGGxpueUnu
         0rH06ZONa/du0BlfxVowPBA5+0Lzwn/2Stzt1xMsV6xgIlXN2CJty7as7slpsJupIm7F
         7KXuclsoR61UZwdVRXpy07Vt/LWOhmoYANw9zkE//PSODu6IM17BixFT14S6PimHIzct
         WwSyKOIp0LRzy2pf+GS1Gx5hj4T/l566OgNNyco6cjSHQUPWlw730fr5amzDNeCREE6d
         Tb/v1p3QB0tRLYkYh6bIBjnZ1wrE3gI8dUXydkp+N//QXt1WRnQM65MLHXKfxc22hiVv
         sKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079694; x=1779684494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8Gn9u6Ay2gAeNSJD6VxHlLmg9jVbwsa1tUO88FBQSI=;
        b=I1q1jgj0TH5KI3ftDFulmm22+HZfz0cxNK1GQl1fO2+viNXYd9iJGdOSoDmqa1TTo+
         fMvgsRe7bCyqnhw+30oZiWuVcRxhmslKY17FcvFp9uN4wMllBFK1wy7llhmjuKZ+cAtA
         v8cS/yUj8MqbdgIdwlQ3VdtyH1VdrKdWK6nAQemLWnKpQPHN/DunNbh7lLyDvK0sdtnW
         CWHgyo1ZmKO3aAwFnYwHQXLn/EL4ovxj5gtkNORI4DOy62WWajV5XGbeOHgUNlJgMtQa
         f8fQ3SucXzBb1ioPiWyyXwdZwldTr1Cu5K1cHCh3TkWDQ6NRkDuBEhINXFrQB2rjazlr
         typg==
X-Forwarded-Encrypted: i=1; AFNElJ9WzQMpcUTfVHH647dCA3Rke8i2l4H9R436UvjIeUyqSps8tJQ+iibw07jdTiY6vqxs6y2hs4FZsgN8m5cxhgzv@vger.kernel.org
X-Gm-Message-State: AOJu0YyVcYk/kPFymUjzYA9Baw/gaqtyxlirr3sWRU6/k8XpOqLAkU9K
	Msg6zGKLHJabdZIpwVSXgT8eHtBFOZfwGyhU3yfqwVy1BzoiLJHBrABWola59ddSnxQvBpn1WKi
	k6L6/W7FQtg==
X-Received: from dybgs18.prod.google.com ([2002:a05:7301:2092:b0:2d9:3459:1de6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3212:b0:2e6:e504:5431
 with SMTP id 5a478bee46e88-303986978b0mr6075608eec.22.1779079693815; Sun, 17
 May 2026 21:48:13 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:36 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-11-irogers@google.com>
Subject: [PATCH v6 10/14] perf pmu-events: Split big_c_string storage into
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

