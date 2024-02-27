Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE757300
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077697; cv=none; b=gKDllofszuecDUFu5ICXiI1HAkSNGD+Gdtc/0VwIXawoYfv2pI4mzc8+iMowmF2f/rAIlTgHCxdpQCnrUf1NahIzG05NhJBkmzgT1U+VPd23JBP3kyABnM7d2N3KE5nxJni1NobtT1HB3M9c0YhXShogVOxEXqDh+rrOFLujw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077697; c=relaxed/simple;
	bh=uQE/lPWntFV0hRplNXgWkKxMROcwNWhfV+snlkfR0rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SEFWrpFLo4a/uUG8UQSZfpvxgBQ5vok0us5jPG57B2isdnSU1TfxUa849WlLGejY/U6/3RVtaTP0afEth2Z4fUOQQOkwcUi89F+tye8b4cV1Sg7rHFUGqcsaVdfUzgG9jzzE8nMY4ICikBtgl/VDKWky6N/qs6JjZTXDdkNceig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCNm4u/o; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCNm4u/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709077697; x=1740613697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uQE/lPWntFV0hRplNXgWkKxMROcwNWhfV+snlkfR0rs=;
  b=TCNm4u/oMj0EJ5JVPnNwONVAtknaEdsbaMKO5EshPG8caLV6f3IuV/pq
   cUrEvUEcS2IdsSMW9zP3ioXvntUhAOurN47xAumN6agJTHiRXn9N13l02
   Tnzocb25SKRv8Vp7kjCSMrryzLE3AC0Eh3xQqk1TNAXnQ4N4EU/ggQFnZ
   Yl26Zu3j0eom8/wey3ICCq8RAZua1bKXyGFwBjyO+FcXydzskw6gIn+ic
   paYhCkMXZmALw7kzfAZK0YUhYdemVlsdCpwB+sdEd7fEzO9rywXF5TiFd
   5LG9Ycr0H7Te5dc2OaA3bjtfAE7246Z0M79k+dVLhM19VkymPOx+iR3TG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3311768"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3311768"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 15:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11783010"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 15:48:15 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: changbin.du@huawei.com,
	adrian.hunter@intel.com,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/2] perf, capstone: Support 32bit code under 64bit OS
Date: Tue, 27 Feb 2024 15:48:04 -0800
Message-ID: <20240227234806.82694-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
 tools/perf/util/print_insn.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index 459e0e93d7b1..bd7a95e64ce5 100644
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
@@ -101,9 +103,21 @@ size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *threa
 	size_t count;
 	size_t printed = 0;
 	int ret;
+	struct addr_location al;
+	bool is64bit = machine__is(machine, "x86_64");
+	struct dso *dso;
+
+	addr_location__init(&al);
+	if (thread__find_map(thread, sample->cpumode, sample->ip, &al) &&
+		(dso = map__dso(al.map)) != NULL &&
+		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
+		map__load(al.map);
+		is64bit = dso->is_64_bit;
+	}
+	addr_location__exit(&al);
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
-	ret = capstone_init(machine, &cs_handle);
+	ret = capstone_init(machine, &cs_handle, is64bit);
 	if (ret < 0) {
 		/* fallback */
 		return sample__fprintf_insn_raw(sample, fp);
-- 
2.43.0

