From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/28] perf script: Add newline after uregs output
Date: Thu, 22 Nov 2018 00:35:57 -0300
Message-ID: <20181122033611.15890-15-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

This change makes it much easier to easily distinguish between
consecutive samples by keeping the empty line between them, like we see
when we do not enable uregs output.

Before:

  cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
              7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...
  cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
              7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...

After:

  cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
              7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...

  cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
              7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181107093705.16346-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b5bc85bd0bbe..daf73832743e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -603,6 +603,8 @@ static int perf_sample__fprintf_uregs(struct perf_sample *sample,
 		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 
+	fprintf(fp, "\n");
+
 	return printed;
 }
 
-- 
2.14.5
