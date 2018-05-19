From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/18] perf tools: Fix kernel_start for PTI on x86
Date: Sat, 19 May 2018 07:55:07 -0300
Message-ID: <20180519105507.16450-19-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Opickn x86_64, PTI entry trampolines are less than the start of kernel text,
but still above 2^63. So leave kernel_start = 1ULL << 63 for x86_64.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526548928-20790-7-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 107bae7676b1..e011a7160380 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2321,7 +2321,12 @@ int machine__get_kernel_start(struct machine *machine)
 	machine->kernel_start = 1ULL << 63;
 	if (map) {
 		err = map__load(map);
-		if (!err)
+		/*
+		 * On x86_64, PTI entry trampolines are less than the
+		 * start of kernel text, but still above 2^63. So leave
+		 * kernel_start = 1ULL << 63 for x86_64.
+		 */
+		if (!err && !machine__is(machine, "x86_64"))
 			machine->kernel_start = map->start;
 	}
 	return err;
-- 
2.14.3
