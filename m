Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE3286436;
	Wed, 28 May 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447831; cv=none; b=na6V1yS9zGNrvZVcnOMCHyPaBr3AhDMHn13JB2u8v6fodMqAy9b9QKBlsk8QQ9nO8HygzUMnM+FgrsOSOtsi9usTdss0v0rZqnukYOotoXzJ5umz3WCkGcVlGO7uCAbk6bDvn1bVkFGnYz5X9Ql96nFoZkPRkS2O9I5RjAseEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447831; c=relaxed/simple;
	bh=cunEx1GQ+Vp/hksXrb/eoFZg/bDuO6fnKXClUzKr/m0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BxCB3PxWLwY1fZhHAS/r9UznnqDWAwSRnINoqCtzccj6/vZuLEZMlUlhK1BJuleZ8L4IKA55wSqSTtMoqbWaTrGwdqeQacmXuIoBsgYdN/QHTRbnCNPFZJMMZLBvojRrhFhHi4JCcnNmRY/VeYcFAbQ6DVcuOX4KwSc13GOxXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr6kWEEw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr6kWEEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A8AC4CEE3;
	Wed, 28 May 2025 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748447831;
	bh=cunEx1GQ+Vp/hksXrb/eoFZg/bDuO6fnKXClUzKr/m0=;
	h=Date:From:To:Cc:Subject:From;
	b=Nr6kWEEw6soS8hsA4ePXvWPyPI+PUVJvlTNOxbL8fLYXLSXmRIVvIUjCb/ZRjHMjg
	 Nf+P234/HSWhq1aIc5c5y539DTTOTyd3QRxFXZzpJMHRqh4VlNHPaAQooz4mQuKbKu
	 7zYjPS8X0zhxPYplXmkfin0n/17u5ZBDxToUU18B9hP83Blil+h9USSOOT4BDnR1Lx
	 nqHd1LkgoXLNkAFdBXocOO+CyKnxgbvINSbf7t1irM4mrJgemqkvoqmEBm/wY9ai1m
	 XharRn5flp7HFNBlzROLzpXJoKFIJnFZIjeiX/71vdM/3N/O3R0DpuyMEpr0Y4d2it
	 MK+ggwblqeDuA==
Date: Wed, 28 May 2025 12:57:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Fei Lang <langfei@huawei.com>, Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] Revert "perf thread: Ensure comm_lock held for comm_list"
Message-ID: <aDcyVLVpZRui1ole@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit 8f454c95817d15ee529d58389612ea4b34f5ffb3.

'perf top' is freezing on exit sometimes, bisected to this one, revert.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Cc: Fei Lang <langfei@huawei.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/comm.c   |  2 --
 tools/perf/util/thread.c | 17 ++++-------------
 tools/perf/util/thread.h |  9 ++++-----
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 9880247a2c3364cb..8aa456d7c2cd2d74 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -24,7 +24,6 @@ static struct comm_strs {
 static void comm_strs__remove_if_last(struct comm_str *cs);
 
 static void comm_strs__init(void)
-	NO_THREAD_SAFETY_ANALYSIS /* Inherently single threaded due to pthread_once. */
 {
 	init_rwsem(&_comm_strs.lock);
 	_comm_strs.capacity = 16;
@@ -120,7 +119,6 @@ static void comm_strs__remove_if_last(struct comm_str *cs)
 }
 
 static struct comm_str *__comm_strs__find(struct comm_strs *comm_strs, const char *str)
-	SHARED_LOCKS_REQUIRED(comm_strs->lock)
 {
 	struct comm_str **result;
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index c202b98b36c29215..415c0e5d1e751a47 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -41,7 +41,6 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 }
 
 struct thread *thread__new(pid_t pid, pid_t tid)
-	NO_THREAD_SAFETY_ANALYSIS /* Allocation/creation is inherently single threaded. */
 {
 	RC_STRUCT(thread) *_thread = zalloc(sizeof(*_thread));
 	struct thread *thread;
@@ -203,29 +202,22 @@ int thread__set_namespaces(struct thread *thread, u64 timestamp,
 
 struct comm *thread__comm(struct thread *thread)
 {
-	struct comm *res = NULL;
+	if (list_empty(thread__comm_list(thread)))
+		return NULL;
 
-	down_read(thread__comm_lock(thread));
-	if (!list_empty(thread__comm_list(thread)))
-		res = list_first_entry(thread__comm_list(thread), struct comm, list);
-	up_read(thread__comm_lock(thread));
-	return res;
+	return list_first_entry(thread__comm_list(thread), struct comm, list);
 }
 
 struct comm *thread__exec_comm(struct thread *thread)
 {
 	struct comm *comm, *last = NULL, *second_last = NULL;
 
-	down_read(thread__comm_lock(thread));
 	list_for_each_entry(comm, thread__comm_list(thread), list) {
-		if (comm->exec) {
-			up_read(thread__comm_lock(thread));
+		if (comm->exec)
 			return comm;
-		}
 		second_last = last;
 		last = comm;
 	}
-	up_read(thread__comm_lock(thread));
 
 	/*
 	 * 'last' with no start time might be the parent's comm of a synthesized
@@ -241,7 +233,6 @@ struct comm *thread__exec_comm(struct thread *thread)
 
 static int ____thread__set_comm(struct thread *thread, const char *str,
 				u64 timestamp, bool exec)
-	EXCLUSIVE_LOCKS_REQUIRED(thread__comm_lock(thread))
 {
 	struct comm *new, *curr = thread__comm(thread);
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 56e08c8ae005e82b..cd574a896418ac94 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -236,15 +236,14 @@ static inline struct rw_semaphore *thread__namespaces_lock(struct thread *thread
 	return &RC_CHK_ACCESS(thread)->namespaces_lock;
 }
 
-static inline struct rw_semaphore *thread__comm_lock(struct thread *thread)
+static inline struct list_head *thread__comm_list(struct thread *thread)
 {
-	return &RC_CHK_ACCESS(thread)->comm_lock;
+	return &RC_CHK_ACCESS(thread)->comm_list;
 }
 
-static inline struct list_head *thread__comm_list(struct thread *thread)
-	SHARED_LOCKS_REQUIRED(thread__comm_lock(thread))
+static inline struct rw_semaphore *thread__comm_lock(struct thread *thread)
 {
-	return &RC_CHK_ACCESS(thread)->comm_list;
+	return &RC_CHK_ACCESS(thread)->comm_lock;
 }
 
 static inline u64 thread__db_id(const struct thread *thread)
-- 
2.49.0

