From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/63] perf tests: Use shebangs in the shell scripts
Date: Tue, 18 Dec 2018 19:06:33 -0300
Message-ID: <20181218220733.15839-4-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

Since the first line was used as a test identification, it needs to be
skipped by shell_test__description() function now.

Further notes from Hendrik:

It might be worth to note that adding the shebang is necessary to spot
them as scripts.

Using /bin/sh looks fine to.  Just briefly checked whether the scripts
contains some bash-specifics, which is not the case.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
LPU-Reference: 2127419430.57657104.1542836358464.JavaMail.zimbra@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c                           | 3 +++
 tools/perf/tests/shell/probe_vfs_getname.sh               | 1 +
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh     | 1 +
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 1 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh         | 1 +
 5 files changed, 7 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 12c09e0ece71..9852b5d624a5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -424,6 +424,9 @@ static const char *shell_test__description(char *description, size_t size,
 	if (!fp)
 		return NULL;
 
+	/* Skip shebang */
+	while (fgetc(fp) != '\n');
+
 	description = fgets(description, size, fp);
 	fclose(fp);
 
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 9b7635184dc2..46e076e3c537 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # Add vfs_getname probe to get syscall args filenames
 #
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index cab7b0aea6ea..61c9f8fc6fa1 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # probe libc's inet_pton & backtrace it with ping
 
 # Installs a probe on libc's inet_pton function, that will use uprobes,
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index ba29535b8580..9b073e7fa88c 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # Use vfs_getname probe to get syscall args filenames
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 4ce276efe6b4..50109f27ca07 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # Check open filename arg using perf trace + vfs_getname
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
-- 
2.19.2
