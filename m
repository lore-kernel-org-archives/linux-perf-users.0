Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4291C007E;
	Fri, 28 Jun 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586239; cv=none; b=MBTGuI46DBNXTRqQNZUDQFFGvKMm5m6c9RUUdfaJSjK3iwVCgWe63EC6GwDcTf1ze4DJaFsTN8QeudwXfgt9+I+ySNJfgjDEnPuTYUHOYsDUNKWzkISptxBj/RwN0PRAYLvZiY6RvsMkJ4pzN1oSgrAibxt+Vvgprqp8N31YK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586239; c=relaxed/simple;
	bh=lJcDdBUtEdqHhkAQsZXlSsZTFyJxAY9Sza+fJg8OTcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJQEBDY2o6+bE87A6ZOicFjXyzG/txOEKy5riSBcXmgPD8GS7x2K/iSszYg86F95RVDxFJpAmk27WS7iQDbMwUAj93+3/Csgf7h8qNEKtkty5ORGUGaY/dvVAWgGH8dG3laM06KPX5RkamiNVIsSGOBFiVb2RY9CWiSgL/5k3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDqh4DAG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDqh4DAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB6BC116B1;
	Fri, 28 Jun 2024 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719586239;
	bh=lJcDdBUtEdqHhkAQsZXlSsZTFyJxAY9Sza+fJg8OTcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDqh4DAGAlslvJlAuKFdIKvnOzl6VZQRTdbyvXmSnuiFIay7WDAJuFCupMHe4sysE
	 B6qLfBAN494v1rbDjBHij0uCtIxGhyKjhqxK5bGKfd6E3YsZ452XMdnSrCZoGRLu2r
	 VvS0kgANH+zeEo4gqiKAg0YVPcqQgoLYu78pGFxLbBK3LMSqgbOjrtNkA7+tAd9y41
	 GXgp25BUzbQO+HUOBXRJlJrFofdHcpydwxLjjSvP+ki4gY6Ll1ccoom5RNZbLprKJK
	 dROFFGvXkj57g8Pv3AYnk1ADRB2b0pJSXFGAdxRsTgv5rQD4GZgN4lqFODQMSbFSpO
	 kMIdteVM6hqJw==
Date: Fri, 28 Jun 2024 11:50:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 5/8] perf test: Add landlock workload
Message-ID: <Zn7NuoUAu1pk2XdG@x1>
References: <20240624181345.124764-1-howardchu95@gmail.com>
 <20240624181345.124764-6-howardchu95@gmail.com>
 <Zn7MQUmGaZNLkrqy@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SiGRqYIMPhDZysui"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn7MQUmGaZNLkrqy@x1>


--SiGRqYIMPhDZysui
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 28, 2024 at 11:44:22AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 25, 2024 at 02:13:42AM +0800, Howard Chu wrote:
> > We'll use it to add a regression test for the BTF augmentation of enum
> > arguments for tracepoints in 'perf trace':
<SNIP>
> I'm not being able to apply this specific patch:
> 
> ⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20240624181345.124764-1-howardchu95@gmail.com
> Grabbing thread from lore.kernel.org/all/20240624181345.124764-1-howardchu95@gmail.com/t.mbox.gz
> Checking for newer revisions

<SNIP>

> I'm checking what is this, perhaps I'm using a more recent
> perf-tools-next/perf-tools-next with changes to that
> tools/perf/tests/workloads/Build file...
> 
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -5 tools/perf/tests/workloads/Build
> 1dad99af1a8211e2 perf test: Make tests its own library
> 3dfc01fe9d12a1e8 perf test: Add 'datasym' test workload
> a104f0ea99d846df perf test: Add 'brstack' test workload
> 39281709a6e2301a perf test: Add 'sqrtloop' test workload
> 41522f7442905814 perf test: Add 'leafloop' test workload
> ⬢[acme@toolbox perf-tools-next]$ 
> 
> Yeah, we need to rebase on top of what we have in
> perf-tools-next/perf-tools-next, probably something minor.

So lets get just this patch and try manually:

⬢[acme@toolbox perf-tools-next]$ b4 am -P5 -ctsl --cc-trailers 20240624181345.124764-1-howardchu95@gmail.com
Grabbing thread from lore.kernel.org/all/20240624181345.124764-1-howardchu95@gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Nothing matching that query.
Analyzing 11 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v3 5/8] perf test: Add landlock workload
    + Link: https://lore.kernel.org/r/20240624181345.124764-6-howardchu95@gmail.com
  ---
  ✓ Signed: DKIM/gmail.com
---
Total patches: 1 (cherrypicked: 5)
---
Cover: ./v3_20240625_howardchu95_perf_trace_augment_enum_arguments_with_btf.cover
 Link: https://lore.kernel.org/r/20240624181345.124764-1-howardchu95@gmail.com
 Base: not specified
       git am ./v3_20240625_howardchu95_perf_trace_augment_enum_arguments_with_btf.mbx
⬢[acme@toolbox perf-tools-next]$ patch -p1 < ./v3_20240625_howardchu95_perf_trace_augment_enum_arguments_with_btf.mbx
patching file tools/perf/tests/builtin-test.c
patching file tools/perf/tests/tests.h
patching file tools/perf/tests/workloads/Build
Hunk #1 FAILED at 6.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/tests/workloads/Build.rej
patching file tools/perf/tests/workloads/landlock.c
⬢[acme@toolbox perf-tools-next]$

1 out of 1 hunk FAILED -- saving rejects to file tools/perf/tests/workloads/Build.rej
patching file tools/perf/tests/workloads/landlock.c
⬢[acme@toolbox perf-tools-next]$ cat tools/perf/tests/workloads/Build.rej
--- tools/perf/tests/workloads/Build
+++ tools/perf/tests/workloads/Build
@@ -6,6 +6,7 @@ perf-y += leafloop.o
 perf-y += sqrtloop.o
 perf-y += brstack.o
 perf-y += datasym.o
+perf-y += landlock.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
⬢[acme@toolbox perf-tools-next]$ 

So just that '+perf-y += landlock.o' line that needs to become
'+perf-test-y += landlock.o'.

See the updated patch attached.

- Arnaldo



--SiGRqYIMPhDZysui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename*0=v3_20240625_howardchu95_perf_trace_augment_enum_arguments_wit;
	filename*1="h_btf.mbx"

From git@z Thu Jan  1 00:00:00 1970
Subject: [PATCH v3 5/8] perf test: Add landlock workload
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 25 Jun 2024 02:13:42 +0800
Message-Id: <20240624181345.124764-6-howardchu95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c       |  1 +
 tools/perf/tests/tests.h              |  1 +
 tools/perf/tests/workloads/Build      |  1 +
 tools/perf/tests/workloads/landlock.c | 39 +++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 tools/perf/tests/workloads/landlock.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3d84b67ca8e..470a9709427d 100644
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
index 3aa7701ee0e9..6ea2be86b7bf 100644
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
index a1f34d5861e3..cc5cbf5909ea 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -6,6 +6,7 @@ perf-y += leafloop.o
 perf-test-y += sqrtloop.o
 perf-test-y += brstack.o
 perf-test-y += datasym.o
+perf-test-y += landlock.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/landlock.c b/tools/perf/tests/workloads/landlock.c
new file mode 100644
index 000000000000..35df2389155a
--- /dev/null
+++ b/tools/perf/tests/workloads/landlock.c
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/compiler.h>
+#include <uapi/asm-generic/unistd.h> // for __NR_landlock_add_rule
+#include <unistd.h>
+#include "../tests.h"
+#include <stdlib.h>
+#ifdef __NR_landlock_add_rule
+#include <linux/landlock.h>
+#endif
+
+/* This workload is used only to test enum augmentation with BTF in perf trace */
+static int landlock(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+#if defined(__NR_landlock_add_rule) && defined(HAVE_LIBBPF_SUPPORT)
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
+#else
+	return 2;
+#endif
+}
+
+DEFINE_WORKLOAD(landlock);
-- 
2.45.2


--SiGRqYIMPhDZysui--
