Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35312CD93
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2024 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994967; cv=none; b=bhw5BD0Sy7jR0O6Ws9fblzQrDM03uItClS0Auj4cEhma1enmCur6fLQ/9f0+cLsZ4KV2s5MqDKXbu8qJx7qpyLFiO5Ba3Qv4TMfSOVfN/u2HUJl+ZqysqNgmDMJyyLdrJIxhc1HHG8nu7ZQcQkWMW8KfMBzqnx+Z2rtxgU7ColY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994967; c=relaxed/simple;
	bh=96oc179RWU3Ol533KjGP3WF+bkUZEBTC27J5aFtD3iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFf5W2f6iaIArCCs+yKbz5mWt1rJfUsUUZgJhkWz6YzqBCVIHBcNVjhe/gQaF+/cXjOmXjAHjdjbYxLwUIh73OS54jga6vV6HTdRVdCDUQkTxK3eH0zt86J078Gtdkr0s7pfFjwgkK17TwP1f+n6bB9YVJB1SFYSWVHWcgp/ACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rc8iYNqm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rc8iYNqm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707994963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwoFam5Wgg2TH5XB3MZSUJ3jZj7mO49UMRulNfw3y+U=;
	b=Rc8iYNqmly1msKmF3XLuW9e5lv2+d5DwgieX7y3EHsckLw33gFyLleJQ5nS6LL92kj347o
	23pVzDltRc/Q6AjtO3I/CCilVD8/zjdR4mgPh9FQdIqtfkZ7NJ7D+/fNiKapP0Ybgr74kO
	LPeahcr5EmcaZwaoSOG3xJKvdyo1+Ks=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-RzU2cTqaPdieITCriSU2ug-1; Thu,
 15 Feb 2024 06:02:40 -0500
X-MC-Unique: RzU2cTqaPdieITCriSU2ug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E09F629AC036;
	Thu, 15 Feb 2024 11:02:39 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC2FE2166B32;
	Thu, 15 Feb 2024 11:02:36 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com
Subject: [PATCH v2 1/7] perf testsuite: Add common regex patters
Date: Thu, 15 Feb 2024 12:02:25 +0100
Message-Id: <20240215110231.15385-2-mpetlan@redhat.com>
In-Reply-To: <20240215110231.15385-1-mpetlan@redhat.com>
References: <20240131113951.17077-1-mpetlan@redhat.com>
 <20240215110231.15385-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Veronika Molnarova <vmolnaro@redhat.com>

Unify perf regexes for checking testing output into a single file
to reduce duplicates and prevent errors when editing.

This will be used in upcomming patches in shell tests.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/common/patterns.sh | 268 ++++++++++++++++++++++
 1 file changed, 268 insertions(+)
 create mode 100644 tools/perf/tests/shell/common/patterns.sh

diff --git a/tools/perf/tests/shell/common/patterns.sh b/tools/perf/tests/shell/common/patterns.sh
new file mode 100644
index 000000000000..21dab25c7b7f
--- /dev/null
+++ b/tools/perf/tests/shell/common/patterns.sh
@@ -0,0 +1,268 @@
+# SPDX-License-Identifier: GPL-2.0
+
+export RE_NUMBER="[0-9\.]+"
+# Number
+# Examples:
+#    123.456
+
+
+export RE_NUMBER_HEX="[0-9A-Fa-f]+"
+# Hexadecimal number
+# Examples:
+#    1234
+#    a58d
+#    aBcD
+#    deadbeef
+
+
+export RE_DATE_YYYYMMDD="[0-9]{4}-(?:(?:01|03|05|07|08|10|12)-(?:[0-2][0-9]|3[0-1])|02-[0-2][0-9]|(?:(?:04|06|09|11)-(?:[0-2][0-9]|30)))"
+# Date in YYYY-MM-DD form
+# Examples:
+#    1990-02-29
+#    0015-07-31
+#    2456-12-31
+#!   2012-13-01
+#!   1963-09-31
+
+
+export RE_TIME="(?:[0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]"
+# Time
+# Examples:
+#    15:12:27
+#    23:59:59
+#!   24:00:00
+#!   11:25:60
+#!   17:60:15
+
+
+export RE_DATE_TIME="\w+\s+\w+\s+$RE_NUMBER\s+$RE_TIME\s+$RE_NUMBER"
+# Time and date
+# Examples:
+#    Wed Feb 12 10:46:26 2020
+#    Mon Mar  2 13:27:06 2020
+#!   St úno 12 10:57:21 CET 2020
+#!   Po úno 14 15:17:32 2010
+
+
+export RE_ADDRESS="0x$RE_NUMBER_HEX"
+# Memory address
+# Examples:
+#    0x123abc
+#    0xffffffff9abe8ae8
+#    0x0
+
+
+export RE_ADDRESS_NOT_NULL="0x[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*"
+# Memory address (not NULL)
+# Examples:
+#    0xffffffff9abe8ae8
+#!   0x0
+#!   0x0000000000000000
+
+export RE_PROCESS_PID="[^\/]+\/\d+"
+# A process with PID
+# Example:
+#    sleep/4102
+#    test_overhead./866185
+#    in:imjournal/1096
+#    random#$& test/866607
+
+export RE_EVENT_ANY="[\w\-\:\/_=,]+"
+# Name of any event (universal)
+# Examples:
+#    cpu-cycles
+#    cpu/event=12,umask=34/
+#    r41e1
+#    nfs:nfs_getattr_enter
+
+
+export RE_EVENT="[\w\-:_]+"
+# Name of an usual event
+# Examples:
+#    cpu-cycles
+
+
+export RE_EVENT_RAW="r$RE_NUMBER_HEX"
+# Specification of a raw event
+# Examples:
+#    r41e1
+#    r1a
+
+
+export RE_EVENT_CPU="cpu/(\w+=$RE_NUMBER_HEX,?)+/p*"
+# Specification of a CPU event
+# Examples:
+#    cpu/event=12,umask=34/pp
+
+
+export RE_EVENT_UNCORE="uncore/[\w_]+/"
+# Specification of an uncore event
+# Examples:
+#    uncore/qhl_request_local_reads/
+
+
+export RE_EVENT_SUBSYSTEM="[\w\-]+:[\w\-]+"
+# Name of an event from subsystem
+# Examples:
+#    ext4:ext4_ordered_write_end
+#    sched:sched_switch
+
+
+export RE_FILE_NAME="[\w\+\.-]+"
+# A filename
+# Examples:
+#    libstdc++.so.6
+#!   some/path
+
+
+export RE_PATH_ABSOLUTE="(?:\/$RE_FILE_NAME)+"
+# A full filepath
+# Examples:
+#    /usr/lib64/somelib.so.5.4.0
+#    /lib/modules/4.3.0-rc5/kernel/fs/xfs/xfs.ko
+#    /usr/bin/mv
+#!   some/relative/path
+#!   ./some/relative/path
+
+
+export RE_PATH="(?:$RE_FILE_NAME)?$RE_PATH_ABSOLUTE"
+# A filepath
+# Examples:
+#    /usr/lib64/somelib.so.5.4.0
+#    /lib/modules/4.3.0-rc5/kernel/fs/xfs/xfs.ko
+#    ./.emacs
+#    src/fs/file.c
+
+
+export RE_DSO="(?:$RE_PATH_ABSOLUTE(?: \(deleted\))?|\[kernel\.kallsyms\]|\[unknown\]|\[vdso\]|\[kernel\.vmlinux\][\.\w]*)"
+# A DSO name in various result tables
+# Examples:
+#    /usr/lib64/somelib.so.5.4.0
+#    /usr/bin/somebinart (deleted)
+#    /lib/modules/4.3.0-rc5/kernel/fs/xfs/xfs.ko
+#    [kernel.kallsyms]
+#    [kernel.vmlinux]
+#    [vdso]
+#    [unknown]
+
+
+export RE_LINE_COMMENT="^#.*"
+# A comment line
+# Examples:
+#    # Started on Thu Sep 10 11:43:00 2015
+
+
+export RE_LINE_EMPTY="^\s*$"
+# An empty line with possible whitespaces
+# Examples:
+#
+
+
+export RE_LINE_RECORD1="^\[\s+perf\s+record:\s+Woken up $RE_NUMBER times? to write data\s+\].*$"
+# The first line of perf-record "OK" output
+# Examples:
+#    [ perf record: Woken up 1 times to write data ]
+
+
+export RE_LINE_RECORD2="^\[\s+perf\s+record:\s+Captured and wrote $RE_NUMBER\s*MB\s+(?:[\w\+\.-]*(?:$RE_PATH)?\/)?perf\.data(?:\.\d+)?\s*\(~?$RE_NUMBER samples\)\s+\].*$"
+# The second line of perf-record "OK" output
+# Examples:
+#    [ perf record: Captured and wrote 0.405 MB perf.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB perf.data (~109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB /some/temp/dir/perf.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB ./perf.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB ./perf.data.3 (109 samples) ]
+
+
+export RE_LINE_RECORD2_TOLERANT="^\[\s+perf\s+record:\s+Captured and wrote $RE_NUMBER\s*MB\s+(?:[\w\+\.-]*(?:$RE_PATH)?\/)?perf\.data(?:\.\d+)?\s*(?:\(~?$RE_NUMBER samples\))?\s+\].*$"
+# The second line of perf-record "OK" output, even no samples is OK here
+# Examples:
+#    [ perf record: Captured and wrote 0.405 MB perf.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB perf.data (~109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB /some/temp/dir/perf.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB ./perf.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB ./perf.data.3 (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB perf.data ]
+
+
+export RE_LINE_RECORD2_TOLERANT_FILENAME="^\[\s+perf\s+record:\s+Captured and wrote $RE_NUMBER\s*MB\s+(?:[\w\+\.-]*(?:$RE_PATH)?\/)?perf\w*\.data(?:\.\d+)?\s*\(~?$RE_NUMBER samples\)\s+\].*$"
+# The second line of perf-record "OK" output
+# Examples:
+#    [ perf record: Captured and wrote 0.405 MB perf.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB perf_ls.data (~109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB perf_aNyCaSe.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB ./perfdata.data.3 (109 samples) ]
+#!    [ perf record: Captured and wrote 0.405 MB /some/temp/dir/my_own.data (109 samples) ]
+#!    [ perf record: Captured and wrote 0.405 MB ./UPPERCASE.data (109 samples) ]
+#!    [ perf record: Captured and wrote 0.405 MB ./aNyKiNDoF.data.3 (109 samples) ]
+#!    [ perf record: Captured and wrote 0.405 MB perf.data ]
+
+
+export RE_LINE_TRACE_FULL="^\s*$RE_NUMBER\s*\(\s*$RE_NUMBER\s*ms\s*\):\s*$RE_PROCESS_PID\s+.*\)\s+=\s+(:?\-?$RE_NUMBER|0x$RE_NUMBER_HEX).*$"
+# A line of perf-trace output
+# Examples:
+#    0.115 ( 0.005 ms): sleep/4102 open(filename: 0xd09e2ab2, flags: CLOEXEC                             ) = 3
+#    0.157 ( 0.005 ms): sleep/4102 mmap(len: 3932736, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3   ) = 0x7f89d0605000
+#!    0.115 ( 0.005 ms): sleep/4102 open(filename: 0xd09e2ab2, flags: CLOEXEC                             ) =
+
+export RE_LINE_TRACE_ONE_PROC="^\s*$RE_NUMBER\s*\(\s*$RE_NUMBER\s*ms\s*\):\s*\w+\(.*\)\s+=\s+(?:\-?$RE_NUMBER|0x$RE_NUMBER_HEX).*$"
+# A line of perf-trace output
+# Examples:
+#    0.115 ( 0.005 ms): open(filename: 0xd09e2ab2, flags: CLOEXEC                             ) = 3
+#    0.157 ( 0.005 ms): mmap(len: 3932736, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3   ) = 0x7f89d0605000
+#!    0.115 ( 0.005 ms): open(filename: 0xd09e2ab2, flags: CLOEXEC                             ) =
+
+export RE_LINE_TRACE_CONTINUED="^\s*(:?$RE_NUMBER|\?)\s*\(\s*($RE_NUMBER\s*ms\s*)?\):\s*($RE_PROCESS_PID\s*)?\.\.\.\s*\[continued\]:\s+\w+\(\).*\s+=\s+(?:\-?$RE_NUMBER|0x$RE_NUMBER_HEX).*$"
+# A line of perf-trace output
+# Examples:
+#    0.000 ( 0.000 ms):  ... [continued]: nanosleep()) = 0
+#    0.000 ( 0.000 ms):  ... [continued]: nanosleep()) = 0x00000000
+#    ? (         ): packagekitd/94838  ... [continued]: poll())                                             = 0 (Timeout)
+#!    0.000 ( 0.000 ms):  ... [continued]: nanosleep()) =
+
+export RE_LINE_TRACE_UNFINISHED="^\s*$RE_NUMBER\s*\(\s*\):\s*$RE_PROCESS_PID\s+.*\)\s+\.\.\.\s*$"
+# A line of perf-trace output
+# Examples:
+#    901.040 (         ): in:imjournal/1096 ppoll(ufds: 0x7f701a5adb70, nfds: 1, tsp: 0x7f701a5adaf0, sigsetsize: 8) ...
+#    613.727 (         ): gmain/1099 poll(ufds: 0x56248f6b64b0, nfds: 2, timeout_msecs: 3996)           ...
+
+export RE_LINE_TRACE_SUMMARY_HEADER="\s*syscall\s+calls\s+(?:errors\s+)?total\s+min\s+avg\s+max\s+stddev"
+# A header of a perf-trace summary table
+# Example:
+#    syscall            calls    total       min       avg       max      stddev
+#    syscall            calls  errors  total       min       avg       max       stddev
+
+
+export RE_LINE_TRACE_SUMMARY_CONTENT="^\s*\w+\s+(?:$RE_NUMBER\s+){5,6}$RE_NUMBER%"
+# A line of a perf-trace summary table
+# Example:
+#    open                   3     0.017     0.005     0.006     0.007     10.90%
+#    openat                 2      0     0.017     0.008     0.009     0.010     12.29%
+
+
+export RE_LINE_REPORT_CONTENT="^\s+$RE_NUMBER%\s+\w+\s+\S+\s+\S+\s+\S+" # FIXME
+# A line from typicap perf report --stdio output
+# Example:
+#     100.00%  sleep    [kernel.vmlinux]  [k] syscall_return_slowpath
+
+
+export RE_TASK="\s+[\w~\/ \.\+:#-]+(?:\[-1(?:\/\d+)?\]|\[\d+(?:\/\d+)?\])"
+# A name of a task used for perf sched timehist -s
+# Example:
+#     sleep[62755]
+#     runtest.sh[62762]
+#     gmain[705/682]
+#     xfsaild/dm-0[495]
+#     kworker/u8:1-ev[62714]
+#     :-1[-1/62756]
+#     :-1[-1]
+#     :-1[62756]
+
+
+export RE_SEGFAULT=".*(?:Segmentation\sfault|SIGSEGV|\score\s|dumped|segfault).*"
+# Possible variations of the segfault message
+# Example:
+#     /bin/bash: line 1:    32 Segmentation fault      timeout 15s
+#     Segmentation fault (core dumped)
+#     Program terminated with signal SIGSEGV
+#!     WARNING: 12323431 isn't a 'cpu_core', please use a CPU list in the 'cpu_core' range (0-15)
-- 
2.43.0

