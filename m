Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBA59B6D
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Mar 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799934; cv=none; b=Q3UT6xUsb31wvHVp5AXHVflbu7mDcnJn4kN1SP5IiWpUmxAOTCSCMf9a/9hCzcvVoqGVKL/FMD7Til1UidMRwzTXwIe9N44Owvy72dgEG7fNYVqIm0op4C4z3KNWkVOfxRp0PZkd37QZIR+66PhR4KqBfVI2kabKs1hH0fn4+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799934; c=relaxed/simple;
	bh=R42TYGbP8gEaIF+ZxfgCRuC8Qr9P9wDxS0GNUN7qdy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhVaQ5UVjl1/61YA10Xygc0skS6pN9M2KL8BcXHgOnYmWZpccZ087GaSepEFfhiTVAFb09LVRmHM8gXl8GotYZyCb0Wij/9SIwTHFaGpQvCS/2eYYRoQo0jPQFMaLC/auebfFWnmyOvtEk7kUvXrDFuJDd6gmG0KxXCMjsjxVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlhhWI3E; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlhhWI3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710799932; x=1742335932;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R42TYGbP8gEaIF+ZxfgCRuC8Qr9P9wDxS0GNUN7qdy0=;
  b=BlhhWI3E1rfO7BS2+7GFiq94XfDch8qf6tFveK1o+ueinSvKNDQYFqUY
   E3EgbH6+8Cub+5j1fgu+LqlrfnCB7gBp12Nw8MQ6DrOofNW8+sNWOf70M
   jK5kgqfE2+XHh8NaUgX2j5EdMbgP/Q/pNmwEg/NsVLrQBvzvustQ9f4Wo
   og8rLIcCZHbbsZynAhP17du4SMO7avJVRskznuv7E0ToWNbf9BlshjIyn
   ZAMzDr8j5idmW+94nYr6mOFe+uPG2EhB7R4+fAjgIbcZTdLZDKJluQPuC
   hNnKciOjM9tVOsQLRW7B1yW8Jm6yGkZ6R3c/yEjd977SKuyx6/sIO0PV0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5854505"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5854505"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13648406"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:12:11 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 1/2] perf, capstone: Support 32bit code under 64bit OS
Date: Mon, 18 Mar 2024 15:12:04 -0700
Message-ID: <20240318221206.30089-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the DSO to resolve whether an IP is 32bit or 64bit and use that to
configure capstone to the correct mode. This allows to correctly
disassemble 32bit code under a 64bit OS.

% cat > loop.c
volatile int var;
int main(void)
{
	int i;
	for (i = 0; i < 100000; i++)
		var++;
}
% gcc -m32 -o loop loop.c
% perf record -e cycles:u ./loop
% perf script -F +disasm
            loop   82665 1833176.618023:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
            loop   82665 1833176.618029:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
            loop   82665 1833176.618031:          7 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
            loop   82665 1833176.618034:         91 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
            loop   82665 1833176.618036:       1242 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Factor out DSO lookup into separate function
v3: Pass down al
v4: Simplify is64bitip
v5: Fix fallback
---
 tools/perf/builtin-script.c  |  9 +++++----
 tools/perf/util/print_insn.c | 27 ++++++++++++++++++++++-----
 tools/perf/util/print_insn.h |  2 +-
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 37088cc0ff1b..0299b1ed8744 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1517,7 +1517,8 @@ void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
 				     struct perf_event_attr *attr,
 				     struct thread *thread,
-				     struct machine *machine, FILE *fp)
+				     struct machine *machine, FILE *fp,
+				     struct addr_location *al)
 {
 	int printed = 0;
 
@@ -1531,7 +1532,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 	}
 	if (PRINT_FIELD(DISASM) && sample->insn_len) {
 		printed += fprintf(fp, "\t\t");
-		printed += sample__fprintf_insn_asm(sample, thread, machine, fp);
+		printed += sample__fprintf_insn_asm(sample, thread, machine, fp, al);
 	}
 	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
 		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
@@ -1606,7 +1607,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 	if (print_srcline_last)
 		printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
 
-	printed += perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
+	printed += perf_sample__fprintf_insn(sample, attr, thread, machine, fp, al);
 	printed += fprintf(fp, "\n");
 	if (PRINT_FIELD(SRCCODE)) {
 		int ret = map__fprintf_srccode(al->map, al->addr, stdout,
@@ -2259,7 +2260,7 @@ static void process_event(struct perf_script *script,
 
 	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
-	perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
+	perf_sample__fprintf_insn(sample, attr, thread, machine, fp, al);
 
 	if (PRINT_FIELD(PHYS_ADDR))
 		fprintf(fp, "%16" PRIx64, sample->phys_addr);
diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index 459e0e93d7b1..32dc9dad9cf2 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -12,6 +12,8 @@
 #include "machine.h"
 #include "thread.h"
 #include "print_insn.h"
+#include "map.h"
+#include "dso.h"
 
 size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 {
@@ -28,12 +30,12 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 #include <capstone/capstone.h>
 
-static int capstone_init(struct machine *machine, csh *cs_handle)
+static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
 {
 	cs_arch arch;
 	cs_mode mode;
 
-	if (machine__is(machine, "x86_64")) {
+	if (machine__is(machine, "x86_64") && is64) {
 		arch = CS_ARCH_X86;
 		mode = CS_MODE_64;
 	} else if (machine__normalized_is(machine, "x86")) {
@@ -93,17 +95,31 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
 	return printed;
 }
 
+static bool is64bitip(struct machine *machine, struct addr_location *al)
+{
+	const struct dso *dso = al->map ? map__dso(al->map) : NULL;
+
+	if (dso)
+		return dso->is_64_bit;
+
+	return machine__is(machine, "x86_64") ||
+		machine__normalized_is(machine, "arm64") ||
+		machine__normalized_is(machine, "s390");
+}
+
 size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
-				struct machine *machine, FILE *fp)
+				struct machine *machine, FILE *fp,
+				struct addr_location *al)
 {
 	csh cs_handle;
 	cs_insn *insn;
 	size_t count;
 	size_t printed = 0;
 	int ret;
+	bool is64bit = is64bitip(machine, al);
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
-	ret = capstone_init(machine, &cs_handle);
+	ret = capstone_init(machine, &cs_handle, is64bit);
 	if (ret < 0) {
 		/* fallback */
 		return sample__fprintf_insn_raw(sample, fp);
@@ -128,7 +144,8 @@ size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *threa
 size_t sample__fprintf_insn_asm(struct perf_sample *sample __maybe_unused,
 				struct thread *thread __maybe_unused,
 				struct machine *machine __maybe_unused,
-				FILE *fp __maybe_unused)
+				FILE *fp __maybe_unused,
+				struct addr_location *al __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index 465bdcfcc2fd..6447dd41b543 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -10,7 +10,7 @@ struct thread;
 struct machine;
 
 size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
-				struct machine *machine, FILE *fp);
+				struct machine *machine, FILE *fp, struct addr_location *al);
 size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
 
 #endif /* PERF_PRINT_INSN_H */
-- 
2.44.0

