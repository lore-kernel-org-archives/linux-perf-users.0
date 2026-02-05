Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088B3AEF2C;
	Thu,  5 Feb 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309238; cv=none; b=LyDJxOTWrmivGztUeoL8tIQIjoJ1ToR8TJmudlK9vcq/ESPcysg85c540GBTfjsNbMlOL8iX7jUIlpzckMHhBGL+CEuWJKpRcKtaZV+Y7AxE+v7uaY7/3ln2IQ+P+iI8qA3gSfw0ss4WDf5sQpVIzIfI9k1swqZR3YfJ1YTRzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309238; c=relaxed/simple;
	bh=BLI/zMNrmQIvE57V26wq0ZwGLj2DA0B86x+ZIdWSLDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpPiyjVYqanqT2usexplaEftApVDLjvyYSms7gOQ/qypMYlb7e8XGmJMMSsbkLfenv6SCWdeqKNlqvIwD55DfW9bySAmkk0Wg4QS9mvyuidBJ54rkiw+lla7bGS86a9s1wKkDJz0atKHTXnOh1RG+WiEy9GDIlZ4rNmTLmY66Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPAVCssN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPAVCssN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85F0C4CEF7;
	Thu,  5 Feb 2026 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770309238;
	bh=BLI/zMNrmQIvE57V26wq0ZwGLj2DA0B86x+ZIdWSLDA=;
	h=From:To:Cc:Subject:Date:From;
	b=JPAVCssNpbgJDK6FNKoYIFuvX0Wc+CZwDFwtbLXVvKfxTavA5bMZtPN+/ZdLUoMWw
	 EjXPURkPInExeh3ANGao8+9sPWqTC//GoaECVf0xF1L4SLjhhEd/NPfkwtgvDlMDnn
	 I0pL/RJyjWkNBZmLL11aS6VK0WgmjVDskQ7AvSeyey5dqI5xYbFoLa9tX6MCtj95kt
	 H3+2cgBOZSigpJ1fk65jAgZlzTtX961T0QTjOuAkJP6avo2XfnXH1jcvzQrSlzWuGe
	 fFiQELpzwJpciYrRNxaMxI5/lKKqzdwed9l2VeI6/4NNwsLzMlpdbEnE4oE5zZWZ6K
	 r1TlHYE1Shfgw==
From: Tycho Andersen <tycho@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2] perf: fix segfault in `lock contention -b`
Date: Thu,  5 Feb 2026 09:32:50 -0700
Message-ID: <20260205163250.1980640-1-tycho@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

When run on a kernel without BTF info, perf crashes:

    libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
    libbpf: failed to find valid kernel BTF

    Program received signal SIGSEGV, Segmentation fault.
    0x00005555556915b7 in btf.type_cnt ()
    (gdb) bt
    #0  0x00005555556915b7 in btf.type_cnt ()
    #1  0x0000555555691fbc in btf_find_by_name_kind ()
    #2  0x00005555556920d0 in btf.find_by_name_kind ()
    #3  0x00005555558a1b7c in init_numa_data (con=0x7fffffffd0a0) at util/bpf_lock_contention.c:125
    #4  0x00005555558a264b in lock_contention_prepare (con=0x7fffffffd0a0) at util/bpf_lock_contention.c:313
    #5  0x0000555555620702 in __cmd_contention (argc=0, argv=0x7fffffffea10) at builtin-lock.c:2084
    #6  0x0000555555622c8d in cmd_lock (argc=0, argv=0x7fffffffea10) at builtin-lock.c:2755
    #7  0x0000555555651451 in run_builtin (p=0x555556104f00 <commands+576>, argc=3, argv=0x7fffffffea10)
        at perf.c:349
    #8  0x00005555556516ed in handle_internal_command (argc=3, argv=0x7fffffffea10) at perf.c:401
    #9  0x000055555565184e in run_argv (argcp=0x7fffffffe7fc, argv=0x7fffffffe7f0) at perf.c:445
    #10 0x0000555555651b9f in main (argc=3, argv=0x7fffffffea10) at perf.c:553

Check if btf loading failed, and don't do anything with it in
init_numa_data(). This leads to the following error message, instead of
just a crash:

    libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
    libbpf: failed to find valid kernel BTF
    libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
    libbpf: failed to find valid kernel BTF
    libbpf: Error loading vmlinux BTF: -ESRCH
    libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
    Failed to load lock-contention BPF skeleton
    lock contention BPF setup failed

Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>
CC: K Prateek Nayak <kprateek.nayak@amd.com>
---
 tools/perf/util/bpf_lock_contention.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 7b5671f13c53..8cd991b3f209 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -117,6 +117,9 @@ static void init_numa_data(struct lock_contention *con)
 	long last = -1;
 	int ret;
 
+	if (!con->btf)
+		return;
+
 	/*
 	 * 'struct zone' is embedded in 'struct pglist_data' as an array.
 	 * As we may not have full information of the struct zone in the

base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
-- 
2.52.0

