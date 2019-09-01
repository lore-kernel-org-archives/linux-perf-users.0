From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/47] objtool: Update sync-check.sh from perf's check-headers.sh
Date: Sun,  1 Sep 2019 09:23:25 -0300
Message-ID: <20190901122326.5793-47-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To allow using the -I trick that will be needed for checking the x86
insn decoder files.

Without the specific -I lines we still get the same warnings as before:

  $ make -C tools/objtool/ clean ; make -C tools/objtool/
  make: Entering directory '/home/acme/git/perf/tools/objtool'
    CLEAN    objtool
  find  -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
  rm -f arch/x86/inat-tables.c fixdep
  <SNIP>
    LD       objtool-in.o
  make[1]: Leaving directory '/home/acme/git/perf/tools/objtool'
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/inat.h' differs from latest version at 'arch/x86/include/asm/inat.h'
  diff -u tools/arch/x86/include/asm/inat.h arch/x86/include/asm/inat.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/insn.h' differs from latest version at 'arch/x86/include/asm/insn.h'
  diff -u tools/arch/x86/include/asm/insn.h arch/x86/include/asm/insn.h
  Warning: Kernel ABI header at 'tools/arch/x86/lib/inat.c' differs from latest version at 'arch/x86/lib/inat.c'
  diff -u tools/arch/x86/lib/inat.c arch/x86/lib/inat.c
  Warning: Kernel ABI header at 'tools/arch/x86/lib/insn.c' differs from latest version at 'arch/x86/lib/insn.c'
  diff -u tools/arch/x86/lib/insn.c arch/x86/lib/insn.c
  /home/acme/git/perf/tools/objtool
    LINK     objtool
  make: Leaving directory '/home/acme/git/perf/tools/objtool'
  $

The next patch will add the -I lines for those files.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: http://lore.kernel.org/lkml/20190830193109.p7jagidsrahoa4pn@treble
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-vu3p38mnxlwd80rlsnjkqcf2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/objtool/sync-check.sh | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 66f1575b80f3..6fa87de1c765 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -12,18 +12,39 @@ arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 '
 
-check()
-{
-	local file=$1
+check_2 () {
+  file1=$1
+  file2=$2
 
-	diff ../$file ../../$file > /dev/null ||
-		echo "Warning: synced file at 'tools/objtool/$file' differs from latest kernel version at '$file'"
+  shift
+  shift
+
+  cmd="diff $* $file1 $file2 > /dev/null"
+
+  test -f $file2 && {
+    eval $cmd || {
+      echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
+      echo diff -u $file1 $file2
+    }
+  }
+}
+
+check () {
+  file=$1
+
+  shift
+
+  check_2 tools/$file $file $*
 }
 
 if [ ! -d ../../kernel ] || [ ! -d ../../tools ] || [ ! -d ../objtool ]; then
 	exit 0
 fi
 
+cd ../..
+
 for i in $FILES; do
   check $i
 done
+
+cd -
-- 
2.21.0
