From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/24] perf docs: Correct and clarify jitdump spec
Date: Tue,  1 Oct 2019 08:12:06 -0300
Message-ID: <20191001111216.7208-15-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Steve MacLean <Steve.MacLean@microsoft.com>, Steve MacLean <Steve.MacLean@Microsoft.com>, Stephane Eranian <eranian@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Brian Robbins <brianrob@microsoft.com>, Davidlohr Bueso <dave@stgolabs.net>, Eric Saint-Etienne <eric.saint.etienne@oracle.com>, Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>, John Salem <josalem@microsoft.com>, Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Tom
List-Id: linux-perf-users.vger.kernel.org

From: Steve MacLean <Steve.MacLean@microsoft.com>

Specification claims latest version of jitdump file format is 2. Current
jit dump reading code treats 1 as the latest version.

Correct spec to match code.

The original language made it unclear the value to be written in the
magic field.

Revise language that the writer always writes the same value. Specify
that the reader uses the value to detect endian mismatches.

Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
Acked-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brian Robbins <brianrob@microsoft.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Keeping <john@metanate.com>
Cc: John Salem <josalem@microsoft.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Tom McDonald <thomas.mcdonald@microsoft.com>
Link: http://lore.kernel.org/lkml/BN8PR21MB1362F63CDE7AC69736FC7F9EF7800@BN8PR21MB1362.namprd21.prod.outlook.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/jitdump-specification.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
index 4c62b0713651..52152d156ad9 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -36,8 +36,8 @@ III/ Jitdump file header format
 Each jitdump file starts with a fixed size header containing the following fields in order:
 
 
-* uint32_t magic     : a magic number tagging the file type. The value is 4-byte long and represents the string "JiTD" in ASCII form. It is 0x4A695444 or 0x4454694a depending on the endianness. The field can be used to detect the endianness of the file
-* uint32_t version   : a 4-byte value representing the format version. It is currently set to 2
+* uint32_t magic     : a magic number tagging the file type. The value is 4-byte long and represents the string "JiTD" in ASCII form. It written is as 0x4A695444. The reader will detect an endian mismatch when it reads 0x4454694a.
+* uint32_t version   : a 4-byte value representing the format version. It is currently set to 1
 * uint32_t total_size: size in bytes of file header
 * uint32_t elf_mach  : ELF architecture encoding (ELF e_machine value as specified in /usr/include/elf.h)
 * uint32_t pad1      : padding. Reserved for future use
-- 
2.21.0
