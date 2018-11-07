From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf script: add newline after uregs output
Date: Wed,  7 Nov 2018 10:37:05 +0100
Message-ID: <20181107093705.16346-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>
List-Id: linux-perf-users.vger.kernel.org

This change makes it much easier to easily distinguish
between consecutive samples by keeping the empty line
between them, like we see when we do not enable uregs
output.

Before:

```
cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
            7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
            ...
 ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...
cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
            7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
            ...
 ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...
```

After:

```
cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
            7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
            ...
 ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...

cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
            7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
            ...
 ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...
```

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/builtin-script.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b5bc85bd0bbe..daf73832743e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -603,6 +603,8 @@ static int perf_sample__fprintf_uregs(struct perf_sam=
ple *sample,
 		printed +=3D fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
=20
+	fprintf(fp, "\n");
+
 	return printed;
 }
=20
--=20
2.19.1
