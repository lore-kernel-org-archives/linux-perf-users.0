Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CF2C234A;
	Thu, 21 May 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325892; cv=none; b=duFSx54Q4arSxOp8alvQ/2TLU2tr67qshn2wH5TQ+70PC91Vy922O0vhm+JA2jWbscee+4zMvRu9XEPOnvXOCDh8PsS5wdisU6PUoRy9fJ7J8fUrFo5j3hzKGHNDZVzXtpm678XsEFejAf5HtOVNNpGbvWcrWcF8rtLK4SsnQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325892; c=relaxed/simple;
	bh=7IvfBA+I2Jh89GcE5LEuaPDT7M9UJyefHImzYkxUGXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwJc4NhgcmwnKyPDiQNlwscpOGi5dcchCgRyPbXv/aFYfym7D9EZO9DMxWZupCHKnj+RTwj20Lucz8S2kjVrl5Ez6Z5OOw2xJzjLGS8W88WalS2nxV2cM8XUoMNZHc4l+TDPzRo2epT/wl3xeqhVF3a06bMWaYg8G1pExADLR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQLutNeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQLutNeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75711F00A3B;
	Thu, 21 May 2026 01:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325891;
	bh=ldgGERpaoZpcB1zs5XJgG6OAjIKlxZL+lrQgw++ELHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nQLutNeAQvaD0V+Oy+V3XC3KR5Ec4OckSVi7jtznyPQt5RrooUmaqurbbctP951B6
	 rdPCCMj4lMGDft1mh9OmACTvlDDvx0WjbRi6hymrKWwacDIFKSun/LFy/fGm8v07ld
	 0p1ob7sH2PMxEeUlx8tLvibbmvOZ0aD6zsa/grIY59M7PmIP771gpqU68lL6n8rw7p
	 klnexoncFCsx4K88DE46Vpu2lOufXeko0StHDyrTjUic2Wk24bzzl5sAb8cy00ms61
	 UV4EK3peGZ3A8xfHwzQBDYFW2dGb6wPvIuKF4HDHpCVIlUr6AwOmQ331Gz+OTQAJUP
	 CfrzOa2l6yP+A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 13/27] perf auxtrace: Harden auxtrace_error event handling
Date: Wed, 20 May 2026 22:09:58 -0300
Message-ID: <20260521011027.622268-14-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Fix four issues in PERF_RECORD_AUXTRACE_ERROR handling:

1. auxtrace_error_name() takes a signed int parameter, but e->type
   is __u32.  A crafted value like 0xFFFFFFFF converts to -1, passes
   the bounds check, and causes a negative array index.  Fix by
   changing the parameter to unsigned int.

2. The msg field is printed via %s without a length bound.  The
   min_size table only guarantees fields up to msg (offset 48), so
   a truncated event has zero msg bytes within the event boundary.
   Compute the available msg length from header.size, cap at
   sizeof(e->msg), and use %.*s.

3. fmt >= 2 adds machine_pid and vcpu fields after msg[64].  Older
   files may have fmt >= 2 but an event size that doesn't include
   these fields.  Add a size check in the swap handler to downgrade
   fmt before the conditional field access, and a matching size
   guard in the fprintf path for native-endian events (which are
   mmap'd read-only and can't be modified in place).

4. python_process_auxtrace_error() had the same issues: msg was
   passed to tuple_set_string() unbounded, and machine_pid/vcpu
   were accessed unconditionally without checking fmt or event
   size.  Apply the same bounds checks.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c                    | 24 +++++++++++++---
 .../scripting-engines/trace-event-python.c    | 28 +++++++++++++++++--
 tools/perf/util/session.c                     | 18 ++++++++++--
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a224687ffbc1b5be..d9770e1d2f959fc4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1759,7 +1759,7 @@ static const char * const auxtrace_error_type_name[] = {
 	[PERF_AUXTRACE_ERROR_ITRACE] = "instruction trace",
 };
 
-static const char *auxtrace_error_name(int type)
+static const char *auxtrace_error_name(unsigned int type)
 {
 	const char *error_type_name = NULL;
 
@@ -1775,6 +1775,7 @@ size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp)
 	struct perf_record_auxtrace_error *e = &event->auxtrace_error;
 	unsigned long long nsecs = e->time;
 	const char *msg = e->msg;
+	int msg_max;
 	int ret;
 
 	ret = fprintf(fp, " %s error type %u",
@@ -1792,11 +1793,26 @@ size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp)
 	if (!e->fmt)
 		msg = (const char *)&e->time;
 
-	if (e->fmt >= 2 && e->machine_pid)
+	/* Bound msg to the bytes actually within the event, capped at the array size */
+	msg_max = (int)((void *)event + event->header.size - (void *)msg);
+	if (msg_max < 0)
+		msg_max = 0;
+	if (msg_max > (int)sizeof(e->msg))
+		msg_max = sizeof(e->msg);
+
+	/*
+	 * Unlike the swap path which downgrades fmt in place,
+	 * native-endian events are mmap'd read-only — check size
+	 * instead to avoid accessing machine_pid/vcpu OOB.
+	 */
+	if (e->fmt >= 2 &&
+	    event->header.size >= offsetof(typeof(event->auxtrace_error), vcpu) +
+				  sizeof(event->auxtrace_error.vcpu) &&
+	    e->machine_pid)
 		ret += fprintf(fp, " machine_pid %d vcpu %d", e->machine_pid, e->vcpu);
 
-	ret += fprintf(fp, " cpu %d pid %d tid %d ip %#"PRI_lx64" code %u: %s\n",
-		       e->cpu, e->pid, e->tid, e->ip, e->code, msg);
+	ret += fprintf(fp, " cpu %d pid %d tid %d ip %#"PRI_lx64" code %u: %.*s\n",
+		       e->cpu, e->pid, e->tid, e->ip, e->code, msg_max, msg);
 	return ret;
 }
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 8edd2f36e5a95829..cee1f32d70225cc7 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1607,6 +1607,9 @@ static void python_process_auxtrace_error(struct perf_session *session __maybe_u
 	const char *handler_name = "auxtrace_error";
 	unsigned long long tm = e->time;
 	const char *msg = e->msg;
+	s32 machine_pid = 0, vcpu = 0;
+	char msg_buf[MAX_AUXTRACE_ERROR_MSG + 1];
+	int msg_max;
 	PyObject *handler, *t;
 
 	handler = get_handler(handler_name);
@@ -1618,6 +1621,25 @@ static void python_process_auxtrace_error(struct perf_session *session __maybe_u
 		msg = (const char *)&e->time;
 	}
 
+	/* Bound msg to the bytes within the event, ensure NUL-termination */
+	msg_max = (int)((void *)event + event->header.size - (void *)msg);
+	if (msg_max <= 0) {
+		msg_buf[0] = '\0';
+	} else {
+		if (msg_max > (int)sizeof(msg_buf) - 1)
+			msg_max = sizeof(msg_buf) - 1;
+		memcpy(msg_buf, msg, msg_max);
+		msg_buf[msg_max] = '\0';
+	}
+
+	/* Only access fmt >= 2 fields if the event is large enough */
+	if (e->fmt >= 2 &&
+	    event->header.size >= offsetof(typeof(event->auxtrace_error), vcpu) +
+				  sizeof(event->auxtrace_error.vcpu)) {
+		machine_pid = e->machine_pid;
+		vcpu = e->vcpu;
+	}
+
 	t = tuple_new(11);
 
 	tuple_set_u32(t, 0, e->type);
@@ -1627,10 +1649,10 @@ static void python_process_auxtrace_error(struct perf_session *session __maybe_u
 	tuple_set_s32(t, 4, e->tid);
 	tuple_set_u64(t, 5, e->ip);
 	tuple_set_u64(t, 6, tm);
-	tuple_set_string(t, 7, msg);
+	tuple_set_string(t, 7, msg_buf);
 	tuple_set_u32(t, 8, cpumode);
-	tuple_set_s32(t, 9, e->machine_pid);
-	tuple_set_s32(t, 10, e->vcpu);
+	tuple_set_s32(t, 9, machine_pid);
+	tuple_set_s32(t, 10, vcpu);
 
 	call_object(handler, t, handler_name);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dad482d7e800984d..5b089da2245457e7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -738,8 +738,22 @@ static int perf_event__auxtrace_error_swap(union perf_event *event,
 	if (event->auxtrace_error.fmt)
 		event->auxtrace_error.time = bswap_64(event->auxtrace_error.time);
 	if (event->auxtrace_error.fmt >= 2) {
-		event->auxtrace_error.machine_pid = bswap_32(event->auxtrace_error.machine_pid);
-		event->auxtrace_error.vcpu = bswap_32(event->auxtrace_error.vcpu);
+		/*
+		 * fmt >= 2 adds machine_pid and vcpu after msg[64].
+		 * Older files may have fmt >= 2 but an event size
+		 * that doesn't include these fields — downgrade to
+		 * avoid swapping out of bounds.
+		 */
+		if (event->header.size < offsetof(typeof(event->auxtrace_error), vcpu) +
+					 sizeof(event->auxtrace_error.vcpu)) {
+			pr_warning("WARNING: PERF_RECORD_AUXTRACE_ERROR: fmt %u but event too small for machine_pid/vcpu (%u bytes), downgrading fmt\n",
+				   event->auxtrace_error.fmt,
+				   event->header.size);
+			event->auxtrace_error.fmt = 1;
+		} else {
+			event->auxtrace_error.machine_pid = bswap_32(event->auxtrace_error.machine_pid);
+			event->auxtrace_error.vcpu = bswap_32(event->auxtrace_error.vcpu);
+		}
 	}
 	return 0;
 }
-- 
2.54.0

