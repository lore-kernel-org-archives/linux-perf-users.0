From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/27] perf test bpf: Improve message about expected samples
Date: Wed, 10 Jan 2018 18:28:18 -0300
Message-ID: <20180110212844.12441-2-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752724AbeAJV3A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Jan 2018 16:29:00 -0500
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When failing on one of the BPF tests we were just stating:

  BPF filter result incorrect

Add some more info to help figuring out the problem:

 BPF filter result incorrect, expected 56, got 0 samples

This came out while investigating this failure, first seen after
updating the kernel to the 4.15.0-rc6 tag:

  [root@jouet ~]# perf test bpf
  39: BPF filter               :
  39.1: Basic BPF filtering    : FAILED!
  39.2: BPF pinning            : Skip
  39.3: BPF prologue generation: Skip
  39.4: BPF relocation checker : Skip
  [root@jouet ~]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-403npu7daupv6b2bmxliv5pk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index c433dd30975a..057c6b8fdb53 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -190,7 +190,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	}
 
 	if (count != expect) {
-		pr_debug("BPF filter result incorrect\n");
+		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect, count);
 		goto out_delete_evlist;
 	}
 
-- 
2.14.3
