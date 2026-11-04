Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825993;
	b=ODy+W/RIcHhI/UNNnBONROwfCy+MW2m3tYYQW2LotP1olm7gZf7a7jWd1BSjV4QVtBbZ
	 Mo7S5srRAp/IgiNGYPlipJRnMAkMP0nj9bfq7767LYc03EZ5sgK5N2R2B4DIKD86QwezH
	 SJTJCF1DsPPu+Vn9Gnxg+yh+SmMT67lYZanZ8pfz3DnxebVtVZaw9JT7FqjKPUtgSWUQN
	 UwqettTNC8+9wG4XFBTp3B0KyD6If05dzydSqgIbs8563a4INyKMkpmZcravV8KowjKYc
	 8+F7r8CufDnvp7h/JoQSOZtKVz+1l4W5IWSv7fMy5WztZMxNEmbYndZL4s8zNSDfKzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=71mJGJZNH6cogPzlP4IDLPHHrA5MvoABWmVXrE7uP/E=;
	b=YE1ozvqug8vjtTi1ri19o52N5CeaPdiRfRrqYsiwdZEI5fXAdt1xRzB3I3IncqoLwbBZ
	 OHymgnBpuoHCiP3Rgs5umGQzyUn+p62cd1HM+FaF9RD0kAV9nTgsVZ3bP0vQ9IB5IUWl1
	 Zqa6eNxC9F2fW8/80t6NQRgT+tAjKDBafOSwMY7dFu9tQc+fRwYy0LPqwuXewAkzIYLem
	 1iInFqBL8lpUDYjamCKyGPSRi728csU8uu15hl5gnlUJ/oqAe7Jb+XYPfL1vqqBMN1pEp
	 V2PHQST3ni52vjkXyGdezW6rj6TH3h1LaqaEJuBHzBvs9oBHinKNriUpYf0V4pTpnbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NmXgZieE;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58360E7517
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A58360E7517
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NmXgZieE
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1993343eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825992; x=1794430792; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71mJGJZNH6cogPzlP4IDLPHHrA5MvoABWmVXrE7uP/E=;
        b=NmXgZieEPu9xzhYc1SSPkZ41Vz12oOSCYrzihpXJzXFeyT6qcRvksFlU86WEEcNKlh
         aokgrX5/OrW0+MpCgA4rCSkvCKh9hiVloVNm8XBuSMRtZoRjHPv249M05BV10pydIxyJ
         vhjRe2AZEKJLpRPeve5SY+jT1efSyk28hXkM4PLST8+pZCKVbsIU5+OcHUXVhw3NdX58
         vGH7fB5fNEpddsF05r+BLxCGDinO2wRLlmVYDOWEuO7kWDSIljK4edKXwhvQlZTp6DJg
         cCmqKgn9dpY+Qa2sMa93hVT4aT38csX3D/b2zP/1E5jURlcYPeUuO71FnDojwMVojkaJ
         G4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825992; x=1794430792;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=71mJGJZNH6cogPzlP4IDLPHHrA5MvoABWmVXrE7uP/E=;
        b=u5TbId5CQLf4Qt8aSEl61wH2isQVHJtIEKID+uwKaTOEoEffpC6hsudLOvVr2U6fT7
         ojW2VCbcsGhKVLzGUCon0ipY1yeXQxW51Vdi2SDYLZ18aK5TFvDFSMeRoHaFANdTXEHV
         HOL+9Uau3cWAbncuAqy5SbCl9XSHEaWucorWG9me8s/XDvRazX4XZKLGigPJr9p8xqe4
         QU8EL3IKlaZhHxjhz3wcf582Zdc6sTke6Xr4YaJog62z/GyHaGs3wTjm+gOfGDTQg1ip
         yinwiSiuMh/zRltlmEq72/BRGaNE2fRB4qlhZeTg4sx00Bn7EhgXX+sC+M5P8PXvCuh5
         9y2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwMUR5elDnbhT2cJSTSpmlp1iC6k8pThyPS+bZaC1ZvvyK2mJZxtGSVPsAlL9ohha4SeS/2jHz0brdB3IJ+Kusk@vger.kernel.org
X-Gm-Message-State: APuU4Z/MlrDgvtncsSdL8huFfnjzJ+DxNd9mROAVYdo7QNii9WpeRYH/
	UjuQPAQTQjkueooS/q5AbE9HsMBVX+u9b0OISobgVAWB3wgj0sSW/6PDLtV3NUypKZoNIwIYkxI
	rzHpf9odmsQ==
X-Received: from dybgk1.prod.google.com ([2002:a05:7301:181:b0:351:1da6:c2e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3a94:b0:34d:2c1a:9892
 with SMTP id 5a478bee46e88-36a424988b7mr24518883eec.40.1793825991963; Wed, 04
 Nov 2026 12:59:51 -0800 (PST)
Date: Wed,  4 Nov 2026 12:59:05 -0800
In-Reply-To: <20261104205909.2078411-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104205909.2078411-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-16-irogers@google.com>
Subject: [PATCH v9 15/19] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In tpebs_stop(), read tpebs_reader_thread into a local variable before
releasing tpebs_mtx to call pthread_join().

Transfer ownership of tpebs_cmd.out to __sample_reader() by passing it as
the thread argument and setting tpebs_cmd.out = -1 in
evsel__tpebs_open() so tpebs_stop() does not double-close the fd closed
by perf_session__delete(). Also reset tpebs_cmd.pid = 0 and tpebs_cmd.out = -1 and return early if
start_command() fails in evsel__tpebs_start_perf_record(), as
start_command() closes the pipe internally and may leave cmd->pid = -1
on error, and join tpebs_reader_thread on error in evsel__tpebs_open()
if it was already started.

Include <pthread.h>, <signal.h>, <stdint.h>, <stdlib.h>, <string.h>, and
<unistd.h> explicitly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 51 ++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 7c0b8b15bd10..47c939fc2058 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -27,6 +27,12 @@
 #include <errno.h>
 #include <poll.h>
 #include <math.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
 
 #define PERF_DATA		"-"
 
@@ -120,10 +126,15 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel)
 	tpebs_cmd.out = -1;
 	ret = start_command(&tpebs_cmd);
 	zfree(&tpebs_cmd.argv);
+	if (ret) {
+		tpebs_cmd.pid = 0;
+		tpebs_cmd.out = -1;
+		return ret;
+	}
 	list_for_each_entry(t, &tpebs_results, nd)
 		t->started = true;
 
-	return ret;
+	return 0;
 }
 
 static bool is_child_pid(pid_t parent, pid_t child)
@@ -220,13 +231,13 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static void *__sample_reader(void *arg __maybe_unused)
+static void *__sample_reader(void *arg)
 {
 	struct perf_session *session;
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = PERF_DATA,
-		.file.fd = tpebs_cmd.out,
+		.file.fd = (int)(intptr_t)arg,
 	};
 	struct perf_tool tool;
 
@@ -236,8 +247,10 @@ static void *__sample_reader(void *arg __maybe_unused)
 	tool.attr = perf_event__process_attr;
 
 	session = perf_session__new(&data, &tool);
-	if (IS_ERR(session))
+	if (IS_ERR(session)) {
+		close(data.file.fd);
 		return NULL;
+	}
 	perf_session__process_events(session);
 	perf_session__delete(session);
 
@@ -331,12 +344,19 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_get())
 	/* Like tpebs_start, we should only run tpebs_end once. */
 	if (tpebs_cmd.pid != 0) {
 		pid_t actual_pid = tpebs_cmd.pid;
+		pthread_t reader_thread;
 
 		tpebs_stopping = true;
 		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
+		/*
+		 * tpebs_results is empty when stopping; clear pid so
+		 * process_sample_event() ignores any late samples while
+		 * draining the pipe.
+		 */
 		tpebs_cmd.pid = 0;
+		reader_thread = tpebs_reader_thread;
 		mutex_unlock(tpebs_mtx_get());
-		pthread_join(tpebs_reader_thread, NULL);
+		pthread_join(reader_thread, NULL);
 		mutex_lock(tpebs_mtx_get());
 		if (control_fd[0] >= 0) {
 			close(control_fd[0]);
@@ -515,6 +535,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 	int ret;
 	bool tpebs_empty;
 	bool started_process = false;
+	bool started_thread = false;
 
 	/* We should only run tpebs_start when tpebs_recording is enabled. */
 	if (!tpebs_recording)
@@ -567,12 +588,15 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 
 		if (pthread_create(&tpebs_reader_thread, /*attr=*/NULL, __sample_reader,
-				   /*arg=*/NULL)) {
+				   (void *)(intptr_t)tpebs_cmd.out)) {
 			kill(tpebs_cmd.pid, SIGTERM);
 			pr_err("Could not create thread to process sample data.\n");
 			ret = -1;
 			goto out;
 		}
+		/* __sample_reader now owns and closes the output fd. */
+		tpebs_cmd.out = -1;
+		started_thread = true;
 		ret = tpebs_send_record_cmd(EVLIST_CTL_CMD_ENABLE_TAG);
 	}
 out:
@@ -586,9 +610,22 @@ int evsel__tpebs_open(struct evsel *evsel)
 
 		if (started_process) {
 			if (tpebs_cmd.pid > 0) {
-				kill(tpebs_cmd.pid, SIGTERM);
+				pid_t actual_pid = tpebs_cmd.pid;
+
+				tpebs_stopping = true;
+				kill(actual_pid, SIGTERM);
+				tpebs_cmd.pid = 0;
+				if (started_thread) {
+					pthread_t reader_thread = tpebs_reader_thread;
+
+					mutex_unlock(tpebs_mtx_get());
+					pthread_join(reader_thread, NULL);
+					mutex_lock(tpebs_mtx_get());
+				}
+				tpebs_cmd.pid = actual_pid;
 				finish_command(&tpebs_cmd);
 				tpebs_cmd.pid = 0;
+				tpebs_stopping = false;
 			}
 			if (tpebs_cmd.out >= 0) {
 				close(tpebs_cmd.out);
-- 
2.56.0.455.g6c5a503b38-goog

