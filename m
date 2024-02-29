Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D122D79D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170716; cv=none; b=sPJ/BoY7djFVzO54FZYMxWz54G3TuZaswB85kbxvIk4dwovVb66nSUryH9pDn9fKIhNmDBHNnVG+kzDHlU44pbHk0Q2HB6iaBb2AEEGcOS9Vltuit0KUyrPE95+zpAiefX4ktLlihU3b18YbvcQkJSOdCmP6P0JNF9cOMXhCujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170716; c=relaxed/simple;
	bh=8DknlmoTkzGb2r0h/S5TVcLFsE0CqipKzj4rpMogQLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1oAjuPFxXlf7tC1lJcxorbF6ZU351uGXKIjTwf/3YmF8kr8qoNQjb0FgbjNEbQeicGuD7lrk09KrTng2JoIlwVRTpFEmi9Tve8WLh47g4XDuapKGXg8SmiEAvib46jWJQVAllSd1k5mfkeQ/dAMygLjWQ1uc5WxJ8lfjKw17og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7Y/A+2z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7Y/A+2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709170715; x=1740706715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8DknlmoTkzGb2r0h/S5TVcLFsE0CqipKzj4rpMogQLg=;
  b=Z7Y/A+2zLz+ve9GhTR4KGjoasLNCgwljOmJx1k7/eH1/pXYuB4G4sVJX
   FfvF9XngS5G7cr6VyKsZDXXu3lZFDnfimI9eVSwNiwzt3QepyIcIoJFOL
   0vPoUXHOGnE/BNOp/BnWkxJ6sIiwjR8j4bd2e32stcEhCBCmRqkf5Lylo
   Ti2tdHPRwFeyXLNN+CJ3tfQYlIEX3W5g2mX7Ox7GN2gYNsZS73Da9oz/z
   Tffa1YMxh5OH4N4crc/rA/YrpnI7HhN19lJOXHXf7MW7UrxWNuOXMkwnI
   ZrRj5TP3as+5DAO6MzoXryd5BpOo4gOAxfj6roas5d/mP1UjLuTXPs745
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3537383"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3537383"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 17:38:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12346524"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 17:38:31 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: changbin.du@huawei.com,
	adrian.hunter@intel.com,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/2] perf, capstone: Support 32bit code under 64bit OS
Date: Wed, 28 Feb 2024 17:38:23 -0800
Message-ID: <20240229013826.329549-1-ak@linux.intel.com>
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

v2: Factor out DSO lookup into separate function
---
 tools/perf/util/print_insn.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index 459e0e93d7b1..eca20dded45f 100644
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
@@ -93,6 +95,24 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
 	return printed;
 }
 
+static bool is64bitip(struct perf_sample *sample, struct thread *thread,
+		      struct machine *machine,uint64_t ip)
+{
+	bool is64bit = machine__is(machine, "x86_64");
+	struct dso *dso;
+	struct addr_location al;
+
+	addr_location__init(&al);
+	if (thread__find_map(thread, sample->cpumode, ip, &al) &&
+		(dso = map__dso(al.map)) != NULL &&
+		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
+		map__load(al.map);
+		is64bit = dso->is_64_bit;
+	}
+	addr_location__exit(&al);
+	return is64bit;
+}
+
 size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
 				struct machine *machine, FILE *fp)
 {
@@ -101,9 +121,10 @@ size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *threa
 	size_t count;
 	size_t printed = 0;
 	int ret;
+	bool is64bit = is64bitip(sample, thread, machine, sample->ip);
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
-	ret = capstone_init(machine, &cs_handle);
+	ret = capstone_init(machine, &cs_handle, is64bit);
 	if (ret < 0) {
 		/* fallback */
 		return sample__fprintf_insn_raw(sample, fp);
-- 
2.43.0

