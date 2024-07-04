Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61E4D112;
	Thu,  4 Jul 2024 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120995; cv=none; b=D71MlbRFjU7Z6aqZbdoU8AyrP3wFzCFoujuHGrGAOo/KDDQ5XdqHyXVhsbJJd/q0FhIuU36rxTEnp6wdoZKM6Z++bbTh9ANrhpe5bWoG/JAC9Ex6PDj7cCuwfuibDj0rEQQmNtC4//boJXbtlgnAtBBU+k/AoGfhmpkvoAnSBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120995; c=relaxed/simple;
	bh=WzUa1uOyto0LZNEJQgFaEiFUaiHBHy+nsNMOuopGxsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6YWRV/+fpgxLq8j9HoCC6txqv+pIPE0+aDeWruVedDGU4CBWOuEC/snto4XfRUrHfy44QTn6Wyjdqasum9LYUMTpBLWyARMOxhXog3/bi36EFimMWa2BE5N8rM36E13ccFLtpHo8lfvi8VPwPVFLX0n6Xb3SljP5moSsNjJdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAAKeGV7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAAKeGV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DF0C3277B;
	Thu,  4 Jul 2024 19:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720120994;
	bh=WzUa1uOyto0LZNEJQgFaEiFUaiHBHy+nsNMOuopGxsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAAKeGV7ssL/IV+1v6t0iQJXRv0q77FvTPwbnspdFQDS0IT0fey2wfh1MLueFZ2po
	 5ZIwpXx3Lki498gl3LOEtn8NWl/QF+d7BPs2apj8b6qGG4oA7IoDeeHPTK5GOwVISu
	 xqnIaeziA19vmUyIJ4g/zswr/1Do8kno2bLEX/3pzT+KE8PQ0tWuKzZLpahnNL7NYa
	 jPrUzPoA2Ytjw+KK5gQJ5TaH8C+CLeakKsXtWUEJfARJuqVQI1TbSBDXEBDP/3d6/0
	 xq5rhViDdaL/harXRvxxm6DcOjsjSr55AM0rmaVigTpue2g9waYfIkPY42eLqmHBH2
	 KlbU7F6yqNrYA==
Date: Thu, 4 Jul 2024 16:23:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, irogers@google.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] perf trace: Augment enum arguments with BTF
Message-ID: <Zob2n61NsenmtfpC@x1>
References: <20240624181345.124764-1-howardchu95@gmail.com>
 <Znnt4sTOx6ANJZPV@x1>
 <Zn8TfuQi0iq7bMVD@google.com>
 <CAH0uvogL+QU+H4cjF7-bjMXmUKHaORKUy7uN7LVkrQBfwB4+tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH0uvogL+QU+H4cjF7-bjMXmUKHaORKUy7uN7LVkrQBfwB4+tg@mail.gmail.com>

On Sat, Jun 29, 2024 at 08:27:42AM +0800, Howard Chu wrote:
>    Hello Namhyung,
> 
>    Thank you for testing this, I will fix this.

So for this case I further updated the patch introducing the workload to
the patch at the end of this message, but then there is still this
problem I'm looking at:

  43     7.54 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 
    tests/workloads/landlock.c:27:15: error: packed attribute causes inefficient alignment for 'allowed_access' [-Werror=attributes]
             __u64 allowed_access;
                   ^~~~~~~~~~~~~~
    tests/workloads/landlock.c:28:15: error: packed attribute causes inefficient alignment for 'parent_fd' [-Werror=attributes]
             __s32 parent_fd;
                   ^~~~~~~~~
    cc1: all warnings being treated as errors
    /git/perf-6.10.0-rc3/tools/build/Makefile.build:158: recipe for target 'workloads' failed
    make[4]: *** [workloads] Error 2
    /git/perf-6.10.0-rc3/tools/build/Makefile.build:158: recipe for target 'tests' failed
    make[3]: *** [tests] Error 2

-----------------

Which is real and a problem when building with those landlock patches on
32-bit arches, probably that was considered a non-issue and so I'll just
disable that warning when building this specific file with perf.

- Arnaldo

-----------------

From da1681838fcb36450b17f2ff4b0c7aed742a8a57 Mon Sep 17 00:00:00 2001
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 25 Jun 2024 02:13:42 +0800
Subject: [PATCH 1/4] perf test: Add landlock workload

We'll use it to add a regression test for the BTF augmentation of enum
arguments for tracepoints in 'perf trace':

  root@x1:~# perf trace -e landlock_add_rule perf test -w landlock
       0.000 ( 0.009 ms): perf/747160 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd8e258594, flags: 45) = -1 EINVAL (Invalid argument)
       0.011 ( 0.002 ms): perf/747160 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd8e2585a0, flags: 45) = -1 EINVAL (Invalid argument)
  root@x1:~#

Committer notes:

It was agreed on the discussion (see Link below) to shorten then name of
the workload from 'landlock_add_rule' to 'landlock', and I moved it to a
separate patch.

Also, to address a build failure from Namhyung, I stopped loading
linux/landlock.h and instead added the used defines, enums and types to
make this build in older systems. All we want is to emit the syscall and
intercept it.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/CAH0uvohaypdTV6Z7O5QSK+va_qnhZ6BP6oSJ89s1c1E0CjgxDA@mail.gmail.com
Link: https://lore.kernel.org/r/20240624181345.124764-1-howardchu95@gmail.com
Link: https://lore.kernel.org/r/20240624181345.124764-6-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c       |  1 +
 tools/perf/tests/tests.h              |  1 +
 tools/perf/tests/workloads/Build      |  1 +
 tools/perf/tests/workloads/landlock.c | 66 +++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100644 tools/perf/tests/workloads/landlock.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3d84b67ca8e775d..470a9709427ddaad 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -152,6 +152,7 @@ static struct test_workload *workloads[] = {
 	&workload__sqrtloop,
 	&workload__brstack,
 	&workload__datasym,
+	&workload__landlock,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 3aa7701ee0e939f7..6ea2be86b7bf8bb4 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
 DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
+DECLARE_WORKLOAD(landlock);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 48bf0d3b0f3d6ebe..5af17206f04d16fd 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -6,6 +6,7 @@ perf-test-y += leafloop.o
 perf-test-y += sqrtloop.o
 perf-test-y += brstack.o
 perf-test-y += datasym.o
+perf-test-y += landlock.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/landlock.c b/tools/perf/tests/workloads/landlock.c
new file mode 100644
index 0000000000000000..0c2bcdaf22636a89
--- /dev/null
+++ b/tools/perf/tests/workloads/landlock.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <unistd.h>
+#include "../tests.h"
+
+/* This workload was initially added to test enum augmentation with BTF in perf
+ * trace because its the only syscall that has an enum argument. Since it is
+ * a recent addition to the Linux kernel (at the time of the introduction of this
+ * 'perf test' workload) we just add the required types and defines here instead
+ * of including linux/landlock, that isn't available in older systems.
+ *
+ * We are not interested in the the result of the syscall, just in intercepting
+ * its arguments.
+ */
+
+#ifndef __NR_landlock_add_rule
+#define __NR_landlock_add_rule 445
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_READ_FILE
+#define LANDLOCK_ACCESS_FS_READ_FILE	(1ULL << 2)
+
+#define LANDLOCK_RULE_PATH_BENEATH	1
+
+struct landlock_path_beneath_attr {
+        __u64 allowed_access;
+        __s32 parent_fd;
+} __attribute__((packed));
+#endif
+
+#ifndef LANDLOCK_ACCESS_NET_CONNECT_TCP
+#define LANDLOCK_ACCESS_NET_CONNECT_TCP	(1ULL << 1)
+
+#define LANDLOCK_RULE_NET_PORT		2
+
+struct landlock_net_port_attr {
+	__u64 allowed_access;
+	__u64 port;
+};
+#endif
+
+static int landlock(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	int fd = 11, flags = 45;
+
+	struct landlock_path_beneath_attr path_beneath_attr = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+		.parent_fd = 14,
+	};
+
+	struct landlock_net_port_attr net_port_attr = {
+		.port = 19,
+		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+
+	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
+		&path_beneath_attr, flags);
+
+	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
+		&net_port_attr, flags);
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(landlock);
-- 
2.45.1

