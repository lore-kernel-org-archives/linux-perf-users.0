Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5F12D1F5
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Mar 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675724; cv=none; b=TK730YG7LHJbGHhAhCDQiUugdB8whWpcjXH8F+fONa1QBZw/aij0lfIdyawIk60GJCrKQ6WBq39AaPGvMMNlbeeZX+PEYkQpb5lQmWHgkXR32G6Yf1M8xmV38r69zY+S4a1IWYSEB/RW2uM0jm04b/2+aR7Z6nc898d682NtKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675724; c=relaxed/simple;
	bh=TgZ3Px/XzdTPa5lHem6QGeScqdN4L92XV53JwqcaNt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kK9PmxPbBV0fO9VKrQyQMXr3PPoc6xrgadpht9wEgsZvntebdAPP2Np0lARV/s5YdRHeSiDWms2VHf9OrLjSs11wmG9iLl+pkeN+J3XJwdoxHidnf5UxsFhipimS0pTQxYTJgi/E/BKXYWiaZvhwgd6WsnhA7PzDfNUKVQr+mos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvyDdqV4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvyDdqV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709675723; x=1741211723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TgZ3Px/XzdTPa5lHem6QGeScqdN4L92XV53JwqcaNt8=;
  b=MvyDdqV4cWSbqk5bDbb2c8HqiEeKpMKdFxlO5p7yRs3rzoP9w/99ObVB
   JA7hacJ1KaUN/ZJaxCQd+hVPtEAQKR9qwGLTEbvPR/S/mKj8RFHe7F2q/
   Hy0Cg6wrJS19LqLfcM8CzU+ov5ZQym1kPwW+kbZVekdhPnLgy6at/9VxS
   ccNpZv6l7DLR2KsOxARv3vPBrolPg97djCkicfEvIZuQ4kr/+J2u7aE5F
   EU//casyRdhfH3rtMe62VbAVgJhKS+a63vzTdqqKa4215/DNtUEtvhB+H
   46xTpDHjAW1ayOJ77S11aizkIpOgvgWjzctu10iqOkw7cBeszCTwQ1+Vy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4838842"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4838842"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9942492"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:55:22 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: changbin.du@huawei.com,
	adrian.hunter@intel.com,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 1/2] perf, capstone: Support 32bit code under 64bit OS
Date: Tue,  5 Mar 2024 13:55:15 -0800
Message-ID: <20240305215517.695988-1-ak@linux.intel.com>
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
v3: Pass down al
---
 tools/perf/builtin-script.c  |  9 +++++----
 tools/perf/util/print_insn.c | 28 ++++++++++++++++++++++++----
 tools/perf/util/print_insn.h |  2 +-
 3 files changed, 30 insertions(+), 9 deletions(-)

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
index 459e0e93d7b1..8e3e2bc23811 100644
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
@@ -93,17 +95,35 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
 	return printed;
 }
 
+static bool is64bitip(struct perf_sample *sample, struct thread *thread,
+		      struct machine *machine,uint64_t ip,
+		      struct addr_location *al)
+{
+	bool is64bit = machine__is(machine, "x86_64");
+	struct dso *dso;
+
+	if (thread__find_map(thread, sample->cpumode, ip, al) &&
+		(dso = map__dso(al->map)) != NULL &&
+		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
+		map__load(al->map);
+		is64bit = dso->is_64_bit;
+	}
+	return is64bit;
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
+	bool is64bit = is64bitip(sample, thread, machine, sample->ip, al);
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
-	ret = capstone_init(machine, &cs_handle);
+	ret = capstone_init(machine, &cs_handle, is64bit);
 	if (ret < 0) {
 		/* fallback */
 		return sample__fprintf_insn_raw(sample, fp);
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
2.43.0

