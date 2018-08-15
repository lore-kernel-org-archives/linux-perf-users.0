From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/35] kallsyms, x86: Export addresses of PTI entry trampolines
Date: Wed, 15 Aug 2018 12:06:10 -0300
Message-ID: <20180815150611.32080-35-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>, Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Currently, the addresses of PTI entry trampolines are not exported to
user space. Kernel profiling tools need these addresses to identify the
kernel code, so add a symbol and address for each CPU's PTI entry
trampoline.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1528289651-4113-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/mm/cpu_entry_area.c | 23 +++++++++++++++++++++++
 kernel/kallsyms.c            | 28 +++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index b45f5aaefd74..fab49fd5190f 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -2,6 +2,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
+#include <linux/kallsyms.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/pgtable.h>
@@ -150,6 +151,28 @@ static void __init setup_cpu_entry_area(int cpu)
 	percpu_setup_debug_store(cpu);
 }
 
+#ifdef CONFIG_X86_64
+int arch_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+		     char *name)
+{
+	unsigned int cpu, ncpu = 0;
+
+	if (symnum >= num_possible_cpus())
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		if (ncpu++ >= symnum)
+			break;
+	}
+
+	*value = (unsigned long)&get_cpu_entry_area(cpu)->entry_trampoline;
+	*type = 't';
+	strlcpy(name, "__entry_SYSCALL_64_trampoline", KSYM_NAME_LEN);
+
+	return 0;
+}
+#endif
+
 static __init void setup_cpu_entry_area_ptes(void)
 {
 #ifdef CONFIG_X86_32
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index aa31aa07f2ef..02a0b01380d8 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -432,6 +432,7 @@ int sprint_backtrace(char *buffer, unsigned long address)
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
 struct kallsym_iter {
 	loff_t pos;
+	loff_t pos_arch_end;
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
 	unsigned long value;
@@ -443,9 +444,29 @@ struct kallsym_iter {
 	int show_value;
 };
 
+int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
+			    char *type, char *name)
+{
+	return -EINVAL;
+}
+
+static int get_ksymbol_arch(struct kallsym_iter *iter)
+{
+	int ret = arch_get_kallsym(iter->pos - kallsyms_num_syms,
+				   &iter->value, &iter->type,
+				   iter->name);
+
+	if (ret < 0) {
+		iter->pos_arch_end = iter->pos;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int get_ksymbol_mod(struct kallsym_iter *iter)
 {
-	int ret = module_get_kallsym(iter->pos - kallsyms_num_syms,
+	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
@@ -501,6 +522,7 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 	iter->nameoff = get_symbol_offset(new_pos);
 	iter->pos = new_pos;
 	if (new_pos == 0) {
+		iter->pos_arch_end = 0;
 		iter->pos_mod_end = 0;
 		iter->pos_ftrace_mod_end = 0;
 	}
@@ -515,6 +537,10 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 {
 	iter->pos = pos;
 
+	if ((!iter->pos_arch_end || iter->pos_arch_end > pos) &&
+	    get_ksymbol_arch(iter))
+		return 1;
+
 	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
 	    get_ksymbol_mod(iter))
 		return 1;
-- 
2.14.4
