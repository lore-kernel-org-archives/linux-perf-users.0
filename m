Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758A4086A;
	Mon,  4 May 2026 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777874946; cv=none; b=bv0GQqbEzB6EZ740vP0aBtxIlmu7CMTABCwF3DgehYZ4vNs/e9ulTCPLgAc4gsmZ74u4iy9pk6bxvz6KskKQorF2D7gxc5qYb8kwFtLe1QZ0XJhO5/3fN5UNyTSejyb97zaEPLfVF5IMzBbiWOr6uWECqTNqnyzncNCCbTP1x70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777874946; c=relaxed/simple;
	bh=hUGJZL3RZt2LIlxfbLcQWSchR9tyewETq9K0HRHhWQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrWPINYbJk/PIdduJbDGJNpU7agBkGprdRGUpthlOCtj9QTIjlFAZqxIV5imGUdqiN0OkhZX4mTaGxuEfvhjgLs1RW6/39dyhtW6zGkW9p3gXzfP90HXn7+kN2Q/dD+XfhebL54P9VPef6i5Qn5JfB6Q/fuoK/3Pt0DHuIwAliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ9Fzk6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ9Fzk6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C472C2BCB8;
	Mon,  4 May 2026 06:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777874946;
	bh=hUGJZL3RZt2LIlxfbLcQWSchR9tyewETq9K0HRHhWQs=;
	h=From:To:Cc:Subject:Date:From;
	b=XZ9Fzk6fFzBh054K5LtYDBqy/bTQepju9bK4wRbze7jfuwAypB0z8Cym8i0VtkfhZ
	 vQRIf8chwcIsJEgpMUGeuWsb16syiMuxzH9Sx5W+DSOJXOXBI+lrcyPPDGFf/+AA33
	 QQFo9O0uzKPrRp1cygqJ1YO4hT5X4SdKcbzloAhsQM5kOuBcsX4NuVDOHy2hU+Nvet
	 MxJbt+2FiYuRH5+cy4JkuFAdPNJwzrcHbdJLKE3aH/Up2/VW2bDK69azY0u9q6OYZ6
	 lyFsWezy4owdnViVhHADMUtcrE/pOpByONIb5KT+fRk7yjwKVbNc6e/dLs2ibu5pAV
	 JXdmX+S7eGkfA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Chun-Tse Shao <ctshao@google.com>
Subject: [PATCH] perf lock contention: Allow 'mmap_lock' in -L/--lock-filter
Date: Sun,  3 May 2026 23:08:59 -0700
Message-ID: <20260504060859.84987-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -L/--lock-filter option is to specify target locks by name or
address.  It's basically for global locks where name or address is known
and fixed.  But 'mmap_lock' is a per-process lock so it cannot be used
for the -L option.

  $ sudo perf lock con -ab -L mmap_lock
  ignore unknown symbol: mmap_lock
  libbpf: map 'addr_filter': failed to create: -EINVAL
  libbpf: failed to load BPF skeleton 'lock_contention_bpf': -EINVAL
  Failed to load lock-contention BPF skeleton
  lock contention BPF setup failed

However, it's still a common source of contention especially in a large
process so we want to use it for the -L/--lock-filter option.  As there
is check_lock_type() to check mmap_lock at runtime, let's used it to
filter mmap_locks as a special case.

Of course, this only works with -b/--use-bpf option.

  $ sudo perf lock con -b -L mmap_lock -- perf bench mem mmap -f demand -t 2
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

         2.679184 GB/sec/thread	( +-   1.78% )
   contended   total wait     max wait     avg wait         type   caller

           1     15.22 us     15.22 us     15.22 us      rwsem:W   __vm_munmap+0x7e
           1      7.72 us      7.72 us      7.72 us      rwsem:R   lock_mm_and_find_vma+0x97

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lock_contention.sh      | 11 +++++++++++
 tools/perf/util/bpf_lock_contention.c          | 12 +++++++++++-
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 11 +++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 6dd90519f45cec1d..52e8b9db9fbd8844 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -208,6 +208,17 @@ test_lock_filter()
 		err=1
 		exit
 	fi
+
+	perf lock con -b -L mmap_lock -q -- perf bench mem mmap -t 2 -l 10 > /dev/null 2> ${result}
+
+	# find out the type of mmap_lock
+	test_lock_filter_type=$(head -1 "${result}" | awk '{ print $8 }' | sed -e 's/:.*//')
+
+	if [ "$(grep -c -v "${test_lock_filter_type}" "${result}")" != "0" ]; then
+		echo "[Fail] BPF result should not have non-${test_lock_filter_type} locks:" "$(cat "${result}")"
+		err=1
+		exit
+	fi
 }
 
 test_stack_filter()
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index cbd7435579feaf8e..cd7ee5d1d1dd654e 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -186,6 +186,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	int ncpus = 1, ntasks = 1, ntypes = 1, naddrs = 1, ncgrps = 1, nslabs = 1;
 	struct evlist *evlist = con->evlist;
 	struct target *target = con->target;
+	bool has_mmap_lock = false;
 
 	/* make sure it loads the kernel map before lookup */
 	map__load(machine__kernel_map(con->machine));
@@ -244,6 +245,11 @@ int lock_contention_prepare(struct lock_contention *con)
 		unsigned long *addrs;
 
 		for (i = 0; i < con->filters->nr_syms; i++) {
+			if (!strcmp(con->filters->syms[i], "mmap_lock")) {
+				has_mmap_lock = true;
+				continue;
+			}
+
 			sym = machine__find_kernel_symbol_by_name(con->machine,
 								  con->filters->syms[i],
 								  &kmap);
@@ -264,7 +270,10 @@ int lock_contention_prepare(struct lock_contention *con)
 			con->filters->addrs = addrs;
 		}
 		naddrs = con->filters->nr_addrs;
-		skel->rodata->has_addr = 1;
+		if (naddrs > 0)
+			skel->rodata->has_addr = 1;
+		else
+			naddrs = 1;
 	}
 
 	/* resolve lock name in delays */
@@ -298,6 +307,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	skel->rodata->aggr_mode = con->aggr_mode;
 	skel->rodata->needs_callstack = con->save_callstack;
 	skel->rodata->lock_owner = con->owner;
+	skel->rodata->has_mmap_lock = has_mmap_lock;
 
 	if (con->aggr_mode == LOCK_AGGR_CGROUP || con->filters->nr_cgrps) {
 		if (cgroup_is_v2("perf_event"))
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 96e7d853b9edf3b5..45ec2fb739842403 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -184,6 +184,7 @@ const volatile int has_type;
 const volatile int has_addr;
 const volatile int has_cgroup;
 const volatile int has_slab;
+const volatile int has_mmap_lock;
 const volatile int needs_callstack;
 const volatile int stack_skip;
 const volatile int lock_owner;
@@ -214,6 +215,8 @@ int data_map_full;
 struct task_struct *bpf_task_from_pid(s32 pid) __ksym __weak;
 void bpf_task_release(struct task_struct *p) __ksym __weak;
 
+static inline __u32 check_lock_type(__u64 lock, __u32 flags);
+
 static inline __u64 get_current_cgroup_id(void)
 {
 	struct task_struct *task;
@@ -295,6 +298,14 @@ static inline int can_record(u64 *ctx)
 			return 0;
 	}
 
+	if (has_mmap_lock) {
+		__u64 lock = ctx[0];
+		__u32 flag = ctx[1];
+
+		if (check_lock_type(lock, flag) != LCD_F_MMAP_LOCK)
+			return 0;
+	}
+
 	return 1;
 }
 
-- 
2.53.0

