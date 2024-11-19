Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9014C59B
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979077; cv=none; b=X+E1ONDCzrywVRgTBDpDapVH6JwIw2E0VozG/BNon1bAv6Xy3IA6PknCZk5paJO0rC8WGJ/klFTo/XlUfiYtWavny9qHaEeQWsQimBCVXHtXNfFVzX19DIDbyJAUHyISzHaTR7X9w4mBr0pUfw1diLP02dZyPfsHk3fOCPRYQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979077; c=relaxed/simple;
	bh=lWHfr2rYjjTAVvjKQhVFfqILAs+IvHGudhgoCfezPS0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=a6NkRudFF9OhFJEYZspc8SXCXhgdwiFh1KK4ayOgvvImX3qkJerW3gwImP57xXk0E1CfgsvA6REKezlYgtDLo+d1H+Q75aLDwGpBYMZkrXxOYbUgg+R+yDQKLjYPi8LE8YRV8MLszvg6eCZq4fU2dzCBB0BnIOzaBfYMiqXkjeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vk8fSqqm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vk8fSqqm"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8794f354so35944467b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979075; x=1732583875; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVLESGGD1kSFTjeckLJ+J+mJtCw8XRUyS8gkZ96eGT0=;
        b=Vk8fSqqm7LPFrPH7aZex0Fpp66p9eCveWkpl9jKMVAq+iGKBNxftHqhVszrKIoJZoS
         c06fxpdKmHD2SOHyQveicPp7V+5aGtCbTQN5tAT9eLkW18+/9udNByqd2WaKlUlVawIr
         n35QnO2D69gKYSkBoBZgf/7qd32THCjHNubXtju16Emfzipxn+0c6hyta6p/nI5cgLAy
         gLsVCilFG/Y9G1EGghxil2OKrRNJlrpSbUVjcAP4QEUn8WwusMnqnkrOzPBzC170/5T+
         PlS/53+bH0psm7nzpbDyVhlm3w9faPo8zwozbiombVSinFhEH+nE+nyGOKpy4JtR1CTz
         1Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979075; x=1732583875;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVLESGGD1kSFTjeckLJ+J+mJtCw8XRUyS8gkZ96eGT0=;
        b=cWCcllqIb9RA2Y9NOMo9db6IbTBVAEWDlw/hqHboibk7ZjMK0PPetH+LIClNmCwYeR
         woXd1RjdICEffx6LbrTYlULnuVCgav4BBo6wFjYIVR1HRJsHbeS6Fb2B5gAF/z1fbbHG
         Io7gabr/UGJnPqx0+B7DcPzxQ8k07y0KmxogYOjrKhf+8hicd41t3fnSUnFJxXquwA5z
         1uzz797NMNTeYHoUfWKwwWsuQb4cbHPqXI/oEMrrtQx7ddxL70W5BoJcpgE+GaWg2K8A
         /4xOnAx4rLM3BEW347aSlg9mn0vglE5kZkc3FmEkvWTT+YVANpyXMrubUftraQTB8ynH
         pJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvNl4CYg++/k3XJPLuDBenmuQhbqf3kihlJ8iuQnH5CTCUsS1cVw0vfadIQPwEgA6Wlk/KbgQ6LfoYnyrOgOjB@vger.kernel.org
X-Gm-Message-State: AOJu0YySFS9cgGbOD58KaYuh4khK8NXxSjb3bm1Wzv2xYvmzibcLWKKP
	MfS+7S2/WrDvsMoalmgYMaAD7vCpneCp1xlE8JLOmkqRoc2hf+ahXJAqMJy5bwu3qIDArsyzTJX
	bwqwNaQ==
X-Google-Smtp-Source: AGHT+IEa1qgxPOPkryHjLaB1j5uAeGIL4ppdRyvhyXVa78wKwCUiL+ccAaiAMsuVazxhkO7Sfql52w79TUtg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:8c1b:b0:6ea:decd:84e with SMTP id
 00721157ae682-6ee55c8bd7amr491357b3.5.1731979074935; Mon, 18 Nov 2024
 17:17:54 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:34 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 12/22] perf x86: Define arch_fetch_insn in NO_AUXTRACE builds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

archinsn.c containing arch_fetch_insn was only enabled with
CONFIG_AUXTRACE, but this meant that a NO_AUXTRACE build on x86 would
use the empty weak version of arch_fetch_insn - weak symbols are a
frequent source of errors like this and are outside of the C
specification. Change it so that archinsn.c is always built on x86 and
make the weak symbol empty version of arch_fetch_insn a strong one
guarded by ifdefs.

arch_fetch_insn on x86 depends on insn_decode which is a function
included then built into
intel-pt-insn-decoder.c. intel-pt-insn-decoder.c isn't built in a
NO_AUXTRACE=1 build. Separate the insn_decode function from
intel-pt-insn-decoder.c by just directly compiling the relevant
file. Guard this compilation to be for either always on x86 (because
of the use in arch_fetch_insn) or when auxtrace is enabled. Apply the
CFLAGS overrides as necessary, reducing the amount of code where
warnings are disabled.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/Build                 |  2 +-
 tools/perf/util/Build                          |  2 +-
 tools/perf/util/intel-pt-decoder/Build         | 18 ++++++++++++++----
 .../intel-pt-decoder/intel-pt-insn-decoder.c   |  3 ---
 tools/perf/util/trace-event-scripting.c        |  4 +++-
 5 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 848327378694..06d7c0205b3d 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -15,6 +15,6 @@ perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
-perf-util-$(CONFIG_AUXTRACE) += archinsn.o
+perf-util-y += archinsn.o
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index cc6962407376..21b497df440b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -123,7 +123,7 @@ perf-util-y += iostat.o
 perf-util-y += stream.o
 perf-util-y += kvm-stat.o
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
-perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
+perf-util-y += intel-pt-decoder/
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
 perf-util-$(CONFIG_AUXTRACE) += arm-spe.o
diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 30793d08c6d4..f99d150059b9 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -9,14 +9,24 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
 
 # Busybox's diff doesn't have -I, avoid warning in the case
 
-$(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/intel-pt-insn-decoder.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
+ifeq ($(SRCARCH),x86)
+  perf-util-y += inat.o insn.o
+else
+  perf-util-$(CONFIG_AUXTRACE) += inat.o insn.o
+endif
+
+$(OUTPUT)util/intel-pt-decoder/inat.o: $(srctree)/tools/arch/x86/lib/inat.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-CFLAGS_intel-pt-insn-decoder.o += -I$(OUTPUT)util/intel-pt-decoder
+CFLAGS_inat.o += -I$(OUTPUT)util/intel-pt-decoder
+
+$(OUTPUT)util/intel-pt-decoder/insn.o: $(srctree)/tools/arch/x86/lib/insn.c
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
 
 ifeq ($(CC_NO_CLANG), 1)
-  CFLAGS_intel-pt-insn-decoder.o += -Wno-override-init
+  CFLAGS_insn.o += -Wno-override-init
 endif
 
-CFLAGS_intel-pt-insn-decoder.o += -Wno-packed
+CFLAGS_insn.o += -Wno-packed
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 47cf35799a4d..8fabddc1c0da 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -11,9 +11,6 @@
 #include <byteswap.h>
 #include "../../../arch/x86/include/asm/insn.h"
 
-#include "../../../arch/x86/lib/inat.c"
-#include "../../../arch/x86/lib/insn.c"
-
 #include "event.h"
 
 #include "intel-pt-insn-decoder.h"
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index c5a122e3acec..ab90778b8172 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -272,11 +272,13 @@ void setup_perl_scripting(void)
 #endif
 #endif
 
-__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+#if !defined(__i386__) && !defined(__x86_64__)
+void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
 		     struct thread *thread __maybe_unused,
 		     struct machine *machine __maybe_unused)
 {
 }
+#endif
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 		       struct machine *machine, bool native_arch)
-- 
2.47.0.338.g60cca15819-goog

