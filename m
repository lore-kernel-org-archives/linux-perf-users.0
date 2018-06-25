From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/19] perf record: Support s390 random socket_id assignment
Date: Mon, 25 Jun 2018 14:40:27 -0300
Message-ID: <20180625174045.25765-2-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

On s390 the socket identifier assigned to a CPU identifier is random and
(depending on the configuration of the LPAR) may be higher than the CPU
identifier. This is currently not supported.

Fix this by allowing arbitrary socket identifiers being assigned to
CPU id.

Output before:

  [root@p23lp27 perf]# ./perf report --header -I -v
  ...
  socket_id number is too big.You may need to upgrade the perf tool.
  Error:
  The perf.data file has no samples!
  # ========
  # captured on    : Tue May 29 09:29:57 2018
  # header version : 1
  ...
  # Core ID and Socket ID information is not available
  ...
  [root@p23lp27 perf]#

Output after:

  [root@p23lp27 perf]# ./perf report --header -I -v
  ...
  Error:
  The perf.data file has no samples!
  # ========
  # captured on    : Tue May 29 09:29:57 2018
  # header version : 1
  ...
  # CPU 0: Core ID 0, Socket ID 6
  # CPU 1: Core ID 1, Socket ID 3
  # CPU 2: Core ID -1, Socket ID -1
  ...
  [root@p23lp27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180611073153.15592-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 540cd2dcd3e7..59fcc790c865 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2129,6 +2129,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	int cpu_nr = ff->ph->env.nr_cpus_avail;
 	u64 size = 0;
 	struct perf_header *ph = ff->ph;
+	bool do_core_id_test = true;
 
 	ph->env.cpu = calloc(cpu_nr, sizeof(*ph->env.cpu));
 	if (!ph->env.cpu)
@@ -2183,6 +2184,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
+	/* On s390 the socket_id number is not related to the numbers of cpus.
+	 * The socket_id number might be higher than the numbers of cpus.
+	 * This depends on the configuration.
+	 */
+	if (ph->env.arch && !strncmp(ph->env.arch, "s390", 4))
+		do_core_id_test = false;
+
 	for (i = 0; i < (u32)cpu_nr; i++) {
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
@@ -2192,7 +2200,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		if (nr != (u32)-1 && nr > (u32)cpu_nr) {
+		if (do_core_id_test && nr != (u32)-1 && nr > (u32)cpu_nr) {
 			pr_debug("socket_id number is too big."
 				 "You may need to upgrade the perf tool.\n");
 			goto free_cpu;
-- 
2.14.3
