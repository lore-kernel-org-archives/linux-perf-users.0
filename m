From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/13] tools lib bpf: Fix double file test in Makefile
Date: Mon, 21 Aug 2017 16:25:37 -0300
Message-ID: <20170821192549.17251-2-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Daniel Díaz <daniel.diaz@linaro.org>

The Makefile verifies the same file exists twice:
  test -f ../../../include/uapi/linux/bpf.h -a \
       -f ../../../include/uapi/linux/bpf.h

The purpose of the check is to ensure the diff (immediately after the
test) doesn't fail with these two files:

  tools/include/uapi/linux/bpf.h
  include/uapi/linux/bpf.h

Same recipe for bpf_common:
  test -f ../../../include/uapi/linux/bpf_common.h -a \
       -f ../../../include/uapi/linux/bpf_common.h

This corrects the location of the tests.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1502814810-960-1-git-send-email-daniel.diaz@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index e87b5903f4bb..4ed0257dc1f3 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -154,10 +154,10 @@ all: fixdep $(VERSION_FILES) all_cmd
 all_cmd: $(CMD_TARGETS)
 
 $(BPF_IN): force elfdep bpfdep
-	@(test -f ../../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
+	@(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
 	(diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
-	@(test -f ../../../include/uapi/linux/bpf_common.h -a -f ../../../include/uapi/linux/bpf_common.h && ( \
+	@(test -f ../../include/uapi/linux/bpf_common.h -a -f ../../../include/uapi/linux/bpf_common.h && ( \
 	(diff -B ../../include/uapi/linux/bpf_common.h ../../../include/uapi/linux/bpf_common.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf_common.h' differs from latest version at 'include/uapi/linux/bpf_common.h'" >&2 )) || true
 	$(Q)$(MAKE) $(build)=libbpf
-- 
2.13.5
