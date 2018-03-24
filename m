From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/44] perf annotate: Introduce --ignore-vmlinux command line option
Date: Sat, 24 Mar 2018 17:02:01 -0300
Message-ID: <20180324200211.21326-35-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is already present in 'perf top', albeit undocumented (will fix),
and is useful to use /proc/kcore instead of vmlinux and then get what is
really in place, not what the kernel starts with, before alternatives,
ftrace .text patching, etc, see the differences:

  # perf annotate --stdio2 _raw_spin_lock_irqsave
  _raw_spin_lock_irqsave() /lib/modules/4.16.0-rc4/build/vmlinux
  Event: anon group { cycles, instructions }

    0.00   3.17      → callq  __fentry__
    0.00   7.94        push   %rbx
    7.69  36.51      → callq  __page_file_index
                       mov    %rax,%rbx
    7.69   3.17      → callq  *ffffffff82225cd0
                       xor    %eax,%eax
                       mov    $0x1,%edx
   80.77  49.21        lock   cmpxchg %edx,(%rdi)
                       test   %eax,%eax
                     ↓ jne    2b
    3.85   0.00        mov    %rbx,%rax
                       pop    %rbx
                     ← retq
                 2b:   mov    %eax,%esi
                     → callq  queued_spin_lock_slowpath
                       mov    %rbx,%rax
                       pop    %rbx
                     ← retq
  [root@jouet ~]# perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave
  _raw_spin_lock_irqsave() /proc/kcore
  Event: anon group { cycles, instructions }

    0.00   3.17        nop
    0.00   7.94        push   %rbx
    0.00  23.81        pushfq
    7.69  12.70        pop    %rax
                       nop
                       mov    %rax,%rbx
    7.69   3.17        cli
                       nop
                       xor    %eax,%eax
                       mov    $0x1,%edx
   80.77  49.21        lock   cmpxchg %edx,(%rdi)
                       test   %eax,%eax
                     ↓ jne    2b
    3.85   0.00        mov    %rbx,%rax
                       pop    %rbx
                     ← retq
                 2b:   mov    %eax,%esi
                     → callq  *ffffffff820e96b0
                       mov    %rbx,%rax
                       pop    %rbx
                     ← retq
  #

Diff of the output of those commands:

  # perf annotate --stdio2 _raw_spin_lock_irqsave > /tmp/vmlinux
  # perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave > /tmp/kcore
  # diff -y /tmp/vmlinux /tmp/kcore
  _raw_spin_lock_irqsave() vmlinux             | _raw_spin_lock_irqsave() /proc/kcore
  Event: anon group { cycles, instructions }     Event: anon group { cycles, instructions }

   0.00  3.17  → callq __fentry__              |  0.00  3.17     nop
   0.00  7.94    push  %rbx                       0.00  7.94     push  %rbx
   7.69 36.51  → callq __page_file_index       |  0.00 23.81     pushfq
                                               >  7.69 12.70     pop   %rax
                                               >                 nop
                 mov   %rax,%rbx                                 mov   %rax,%rbx
   7.69  3.17  → callq *ffffffff82225cd0       |  7.69  3.17     cli
                                               >                 nop
                 xor   %eax,%eax                                 xor   %eax,%eax
                 mov   $0x1,%edx                                 mov   $0x1,%edx
  80.77 49.21    lock  cmpxchg %edx,(%rdi)       80.77 49.21     lock  cmpxchg %edx,(%rdi)
                 test  %eax,%eax                                 test  %eax,%eax
               ↓ jne   2b                                      ↓ jne   2b
   3.85  0.00    mov   %rbx,%rax                  3.85  0.00     mov   %rbx,%rax
                 pop   %rbx                                      pop   %rbx
               ← retq                                          ← retq
            2b:  mov   %eax,%esi                            2b:  mov   %eax,%esi
               → callq queued_spin_lock_slowpath|              → callq *ffffffff820e96b0
                 mov   %rbx,%rax                                 mov   %rbx,%rax
                 pop   %rbx                                      pop   %rbx
               ← retq                                          ← retq
  #

This should be further streamlined by doing both annotations and
allowing the TUI to toggle initial/current, and show the patched
instructions in a slightly different color.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wz8d269hxkcwaczr0r4rhyjg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt | 3 +++
 tools/perf/builtin-annotate.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index c29c7fc93023..749cc6055dac 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -55,6 +55,9 @@ OPTIONS
 --vmlinux=<file>::
         vmlinux pathname.
 
+--ignore-vmlinux::
+	Ignore vmlinux files.
+
 -m::
 --modules::
         Load module symbols. WARNING: use only with -k and LIVE kernel.
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index fd5aac3fd949..51709a961496 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -496,6 +496,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
 	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
+	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
+                    "don't load vmlinux even if found"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
-- 
2.14.3
