Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F4477998;
	Fri, 15 May 2026 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845574; cv=none; b=kqkOTKo44fBm1MSeX9k2FdiDu8PbX2ULXwoPZG3T9oNPBnNjCNFwOF/RpM92FEMRlrf9V/TGDSkQXJUyAVcT7/GgPVbuEJKLz2eVPmqhJNCrgc20PGWv7LwZB07uiurgyIyxN1qL+KhqxtMqFPdyddIwCOt3qS9jGJgD4Ro6qMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845574; c=relaxed/simple;
	bh=FJSOpKb4IBRGd6WtMG0E3q6TYaGui30TfQ/QF6Uypts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Mz8mbevvDnRLg1BEKesI5MEm4+qzg8xzARil/R/5dz3hiXelrmcAL6kc0LxGlVi+STOFdz9/LIsCwKTVMhYrEHMbPxAk2aBmUOzCoc5WMnM/H/D3d17bZQUCeP4CDDPPA55TZSl/IWksu9ZA3riCs9hNmnlr93MqVfbUPRUI2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OLS3RpG6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OLS3RpG6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=DM57PNW1ikJ4Lvl2x5pK6VC+oJ7aeN5lfo2onilfOxY=; b=OLS3RpG6uh4U7+PRuuNFXaeDu+
	0mQPM+P58rnlrutbWibjoG/+/3URR/Pif6NkWN3L4XSmAguo/tks7xgN/evoIcgIfliO/cxgd3Btr
	2O+WS64Nuy/+ffkfxVfSvlesCaU/EcBKI9abs2eXWIZU1fZSFzJqejI+3eMon4HjlwxMDooDlULLv
	I74rHl3CRcBK/DIiYWXWkJha24DHtJaXGLQFEmX+PuxIFneqJ72bGBPlqez3uhr9NTw+iCR+QzNGz
	Z2ksBnnOQj3DO32L2OIwbCeOTOTAL5nZLc5an5lSTz5iqQ3YrW+/RRQV+S0RTV545rDKk1FFPgIRv
	GakLe/kw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNqzN-004htZ-1V;
	Fri, 15 May 2026 11:45:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 04:45:26 -0700
Subject: [PATCH] perf bench: add --write-size option to sched pipe
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-perf_bench_pipe-v1-1-3c5b805ba178@debian.org>
X-B4-Tracking: v=1; b=H4sIAFUHB2oC/yXMQQrCMBAF0KsMf91AG6yBXEWkNOOvHRcxJCpC6
 d1FXb7N29BYjQ1RNlS+rNk9I8rQCXSd85XOLogC3/tjPw6jK6zLlJh1nYoVujTTU0MIekjoBKV
 ysfdvPJ3/bs90oz6+Dfb9A7FbDgBzAAAA
X-Change-ID: 20260515-perf_bench_pipe-bae2ec777c4b
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4976; i=leitao@debian.org;
 h=from:subject:message-id; bh=FJSOpKb4IBRGd6WtMG0E3q6TYaGui30TfQ/QF6Uypts=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBwdwjVc0qcXwFlDm3xJ6rHvNxshE5yFJ8HIGq
 3ZBPDVr1oiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagcHcAAKCRA1o5Of/Hh3
 baO+D/9dqps0dGxRxNYJSKK3IlPG2UJzaWG71/gtGMjkrp/QZ/t7BhIyT/T8L7/1eUuul7OodjZ
 TSJ/p5uv7J3tE3mu6wRdUT4CMw9J9vGMIJBa5H4TpP8I/+l9oLLqIYZPAt93kvhpBGpZC8T/0Wh
 xS7Nf3KwqAYfhS7n8C6m9mbvTYlPXRBeP9FyqWnZMcfZQ6OaUcEvBa3YErMgEtdb+i+nFtSIbSX
 dvEjodBmwgOhfKMx79rAAHtziUwzDAoCAuLY/xvPyAzhxvo9WhmEDZD94yj5tgS2eOeK85MKMgF
 Bo0p9N6HxQ593VAZeyl2BeUtO4dVXOfeI3EqZc7WV3ptdw6c6YnrrpikRgQAix5anJR9OtxPRpC
 fkDNSmYhiIXx9jjFptbz3R89qnEs3B4a8dC3IoVXrZ3FYrpR+ix5/se0hzYZJkvyoiSinPkHQ18
 mGLkIkXl+ExI/WeCD8B3VSP4gsjSl1PlH4d5pieqcn2PkybbEaVGjGV+fvr/u59yiqYHrr2/wG6
 iNrgrfUXgBjtA5OASxHh+ioBzKugh40sDAxpXcNNtEZPZnNyZPlX803nKrlb3X76iYxvRTZv6vc
 /Z97SkgxSAwAR81n6hFPrJ7A3NLpjZHRk4K6n3tweoe5XqEcKV78l2x2meGEnKIz7Je07zl3opC
 XWpexnrIYXlsEeQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The default ping-pong uses sizeof(int) (4 bytes) per iteration, which
exercises only the pipe-buffer merge path and keeps allocation entirely
out of the picture. That makes the bench a useful scheduler / context-
switch latency probe but unable to surface anything from the pipe
page-allocation hot path.

Add a -s/--write-size option that sets the bytes written and read per
ping-pong iteration. The buffer is allocated for each side via
struct thread_data and replaces the on-stack int previously used. The
default remains sizeof(int) so existing invocations are unchanged.

With --write-size set above PAGE_SIZE the bench drives anon_pipe_write()
through alloc_page() (or the bulk pre-alloc, if the relevant patch is
applied), which is what we want when measuring pipe locking and page
allocation work.

The bench is a ping-pong: both sides call write() before read(), so a
single write_size payload must fit entirely in the pipe buffer or both
sides deadlock waiting for the other to drain. Resize the pipe via
F_SETPIPE_SZ to match write_size (skipped at the sizeof(int) default),
and error out cleanly when the request exceeds
/proc/sys/fs/pipe-max-size.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
This patch has been valuable for testing and verifying the pipe
enhancements currently under discussion at
https://lore.kernel.org/all/20260515-fix_pipe-v1-0-b14c840c7555@debian.org/
---
 tools/perf/bench/sched-pipe.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 70139036d68f0..77a7e35d7d809 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -39,6 +39,7 @@ struct thread_data {
 	int			epoll_fd;
 	bool			cgroup_failed;
 	pthread_t		pthread;
+	char			*buf;
 };
 
 #define LOOPS_DEFAULT 1000000
@@ -48,6 +49,7 @@ static	int			loops = LOOPS_DEFAULT;
 static bool			threaded;
 
 static bool			nonblocking;
+static unsigned int		write_size = sizeof(int);
 static char			*cgrp_names[2];
 static struct cgroup		*cgrps[2];
 
@@ -88,6 +90,9 @@ static const struct option options[] = {
 	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
 	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
+	OPT_UINTEGER('s', "write-size", &write_size,
+		     "Bytes per ping-pong write (default 4-bytes). Use larger "
+		     "values to exercise the pipe page-allocation path."),
 	OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
 		     "Put sender and receivers in given cgroups",
 		     parse_two_cgroups),
@@ -172,14 +177,14 @@ static void exit_cgroup(int nr)
 
 static inline int read_pipe(struct thread_data *td)
 {
-	int ret, m;
+	int ret;
 retry:
 	if (nonblocking) {
 		ret = epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
 		if (ret < 0)
 			return ret;
 	}
-	ret = read(td->pipe_read, &m, sizeof(int));
+	ret = read(td->pipe_read, td->buf, write_size);
 	if (nonblocking && ret < 0 && errno == EWOULDBLOCK)
 		goto retry;
 	return ret;
@@ -188,7 +193,7 @@ static inline int read_pipe(struct thread_data *td)
 static void *worker_thread(void *__tdata)
 {
 	struct thread_data *td = __tdata;
-	int i, ret, m = 0;
+	int i, ret;
 
 	ret = enter_cgroup(td->nr);
 	if (ret < 0) {
@@ -204,10 +209,10 @@ static void *worker_thread(void *__tdata)
 	}
 
 	for (i = 0; i < loops; i++) {
-		ret = write(td->pipe_write, &m, sizeof(int));
-		BUG_ON(ret != sizeof(int));
+		ret = write(td->pipe_write, td->buf, write_size);
+		BUG_ON(ret != (int)write_size);
 		ret = read_pipe(td);
-		BUG_ON(ret != sizeof(int));
+		BUG_ON(ret != (int)write_size);
 	}
 
 	return NULL;
@@ -239,6 +244,22 @@ int bench_sched_pipe(int argc, const char **argv)
 	BUG_ON(pipe2(pipe_1, flags));
 	BUG_ON(pipe2(pipe_2, flags));
 
+	/*
+	 * On custom write_size, set the pipe size to acommodate write_size
+	 */
+	if (write_size > sizeof(int) &&
+	    (fcntl(pipe_1[1], F_SETPIPE_SZ, write_size) < (int)write_size ||
+	     fcntl(pipe_2[1], F_SETPIPE_SZ, write_size) < (int)write_size)) {
+		fprintf(stderr, "--write-size %u exceeds /proc/sys/fs/pipe-max-size\n",
+			write_size);
+		return -1;
+	}
+
+	for (t = 0; t < nr_threads; t++) {
+		threads[t].buf = calloc(1, write_size);
+		BUG_ON(!threads[t].buf);
+	}
+
 	gettimeofday(&start, NULL);
 
 	for (t = 0; t < nr_threads; t++) {
@@ -287,6 +308,9 @@ int bench_sched_pipe(int argc, const char **argv)
 	gettimeofday(&stop, NULL);
 	timersub(&stop, &start, &diff);
 
+	for (t = 0; t < nr_threads; t++)
+		free(threads[t].buf);
+
 	exit_cgroup(0);
 	exit_cgroup(1);
 

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260515-perf_bench_pipe-bae2ec777c4b

Best regards,
--  
Breno Leitao <leitao@debian.org>

