Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448082;
	b=sc51OBhlnrXHjGwVyEO09t7LHU7AUft3uyhmOTIWalK+89I4dvMGoFLNdm1fZUNWOUJ3
	 zMgyRen/a6+BvwzQM71enXECpjagsUQWuvuI6yc+L9NHyQ+BCtqk1kfTyoqKPqoXo57hW
	 eAStrXa2Uzd2lWblNsDNEhaRhlmRAxrSJddV6TgvaLtMs/jhmTDAWaIJq3KRPmc9W/w+Z
	 gwn5lqY5aKrjxJzwmZCD06d8woHIgLA0QeYHBEq8Nx3YNGnffaJCHAh4leMNHUm157uTR
	 IvLF2ifRRAJHKkf4cwsF3EpgB4l56WU3BBOefDHsKcqF/g2hQLrKk4riIBCD6bY2k8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=R2Rh2yIbdTeaHuI1xztP993wm7ZrZNAfJr4c+tXkXFQ=;
	b=cTQo8nuV/SeS7I6Sq8G1lH5vHkTYs7gPDYM6I2KTAXcE/t9HWRC5JndKIyMVeQOw2at4
	 +JqJo09jnYiUUfE7RJBz5CjBp91Vxn2O2VRjcvKb1f8NuAGEnmPNfRycSSFhbIja+/2t4
	 odgud7k13RhJBAsxdV7mHVf/s089YL/zKrWEvuvUg5GshvfhNs/1iAl6GHOzyF1JGx2U5
	 eHPIBEbuDqVcqKp3rAzdNklaGoM+O1eIMojamoe+nCbmWrQOd3hwztfFQoGElUpEMYBmO
	 nWarDmvkcpxSQWxONQTZPhz2zGLa5r+ikrEwm6AXc22PlEtb+tgODdvVKElKEiHZJ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Z63ObqCR;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01E606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 15:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F01E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Z63ObqCR
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so27143245e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795448080; x=1796052880; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R2Rh2yIbdTeaHuI1xztP993wm7ZrZNAfJr4c+tXkXFQ=;
        b=Z63ObqCR/9NvjwLJ3EtP1HgFONQ/gN8IkB6HSzLhwKctqWX8Bq1fyNR7AODqxdLcIR
         CTTABF4LSN+K2IK1U/KOC3ryVVGvC01Lm+jEhVEOZu9p1yTRXO4PxhrsFXq5GoCRTNSS
         aPjsX8achvUJG30kTVMjSX5fAoPv0sDooHIODwDk7lQlZTn2Ed4HR2wR36/NUtwtdJjr
         wQdFEOhQtQ0RX1HZyqlZUe9R+ZnDYO9kVSHgaNAkCXBhTvwLBjvw688XqNK+GvYyFVkI
         yyduB384pb7+t5ZGawVrEHVPfUjIqqwBOFaBiQEToRh9tTKtFKBnj3KlDmHKrLvKvRNN
         aVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448080; x=1796052880;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=R2Rh2yIbdTeaHuI1xztP993wm7ZrZNAfJr4c+tXkXFQ=;
        b=1FMd8Urk8D8djCUnK3fLAqGJVvkr28tsW2DIUyIrZD86Ty1N5R9F8CGfl+4wCYBlGu
         iljbvLTezTjFfAklcfBbETINIXqVenx7/BcOfzth7L9vHpi1eaFVU+0Ad9+KFqYlIzD7
         oGbR+RGk+QlGHJoD5thb5ASo4Riiu6Kd0fB5njhXJxcXP9otNTy3xRDrrQdRHrVCU8iG
         kjw7zdcOb0kVjHpCBY/sLuqtiUbXZe7aXilvwrB4Ngs6DPQXWsdVx33fpJnk3Nkyd/cF
         wSOKXa56Ds7R/NvgFTxZn2ROTxkbpIUTM/OECgfIidO85XxFfVdy0oBT5TaPPXvvgTrl
         pabQ==
X-Forwarded-Encrypted: i=1; AL+hErHS9VHab4W5R6ENcnrYIVJuPnnYTO+38MaAkgkUqkarczbXsNRuWMLs5hwbFQ53BPeNtsN2KbyeWc74qXi7K9ms@vger.kernel.org
X-Gm-Message-State: APuU4Z8rajY5Qy5tuVfsj7PSb6OF0kZO78l9tTfOwjRFqC9V2mlsD1VI
	KL1cHL//4F45FRYJAzYHp7xYpzBmPCTNfziSKQIvnoNxSeaJ/gIEVFb+4n1NTxvrKv0=
X-Gm-Gg: AZFdTZcphnp1vVdz4ir7SnQemSSc1DWgIE1n5k6eqLa2TQPO24rIeJlHpGLIEMxmL5s
	mFuTARkrxzG1XGQaGIYUQB2W0ta4jm4yZtzqz3RdxeyPMIhNR4Kg/jk5fOw+g4En5kTnT9As0YN
	r+KPJSzFBEPR4UbENTRD3S4qJZTQ6OPIaHZMdhhtB0zSEx9IHAea5L+wQnqDcxX3CjN+1hOwsqV
	mDOYK9yJDRWIwj0phW0uRUjE9nMGfyu6COLgZgGZ3ko6FAp3qz/FkN4ldMKUsXdFc+RPkDZapYU
	ojXrQxwSbtpaDf3OTfHC227x/qokU+NUyD7Viv+ke3VmarhOW7DNr8L00PnG4sY1UroA9yEi1hV
	fupHpiBitKeCv2cGZxQMmD1sz5Y8IRnhD+F0jpIx+Yc8aJkr7Ra2JkQqsr/kMQPtDmDP696ghoy
	lbamn8gqBnnv7k2lzWEGWLkDOo1TdQzf15rABork1WSRsymvn2aNvEN6FLcTvMRNhqSJKJpNw9C
	LlpKcs2ZtdX1lA7QS2emYea8LhKjbeHn115+2+IL//nQKJ0harbvA1M3xEyon5FH6tVYsG4XkiE
	SAwTnxMCaTZ7QxOvVEak5wo2tjXr78pp
X-Received: by 2002:a05:600c:6092:b0:4a1:d537:1c8d with SMTP id 5b1f17b1804b1-4bb8892bb67mr228098905e9.19.1795448080631;
        Mon, 23 Nov 2026 07:34:40 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm319681185e9.9.2026.11.23.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:34:40 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 23 Nov 2026 15:34:29 +0000
Subject: [PATCH] perf test: Fix race in "Event re-armed with
 PERF_EVENT_IOC_REFRESH"
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-james-perf-event_refresh-v1-1-571efa5395ab@linaro.org>
X-B4-Tracking: v=1; b=H4sIAARdBGsC/yXMUQrCQAyE4auUPBtwV1zEq4hIm87aFFxLUotQe
 ndXffwY5l/JYQqnc7OSYVHXZ6kIu4ZkaMsdrH01xX1MIcQDj+0DzhMsMxaU+WbIBh9YBMecuj7
 lk1C9T3XQ9y99uf7tr26EzN8ebdsHHnI8kXwAAAA=
X-Change-ID: 20261123-james-perf-event_refresh-cce5f6bd6f8c
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Francesco Nigro <nigro.fra@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

trigger() is invoked without blocking, but the test expects N events to
always be received for N triggers. After each trigger, the event is
disabled and only re-enabled by the signal handler. If the next trigger
happens before the event is re-enabled, then an event count will be
dropped. This is possible because signals are delivered asynchronously.
Fix it by blocking signals then unblocking while waiting for the event
after each call to trigger().

Blocking results in a 1:1 relation between trigger and signal counts,
even when there are extra page faults, so remove the comment and change
>= to == on the final test assert.

Timeout after 2 seconds because we already know there are broken kernels
for the tracepoint test, and the default 120s timeout would be annoying.

This fixes the following failure seen on Arm64:

  $ perf test -vv -r 30000 -S "Event re-armed"
  ...

  ---- start ----
  test child forked, pid 1087
  1000 events, count 999, 999 overflows (999 POLL_HUP), re-arm errno 0
  ---- end(-1) ----
   20.1: Software event                   : FAILED!

Fixes: 3dabc8ad8ae0 ("perf test: Add test for events re-armed with PERF_EVENT_IOC_REFRESH")
Signed-off-by: James Clark <james.clark@linaro.org>
---
Assisted by Claude Opus-5.5
---
 tools/perf/tests/event_refresh.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/event_refresh.c b/tools/perf/tests/event_refresh.c
index 726e5de4c795..0750cbb63866 100644
--- a/tools/perf/tests/event_refresh.c
+++ b/tools/perf/tests/event_refresh.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
+#include <poll.h>
 #include <signal.h>
 #include <string.h>
 #include <unistd.h>
@@ -44,6 +45,7 @@ static void sig_handler(int signum __maybe_unused, siginfo_t *info,
 static int count_overflows(struct perf_event_attr *attr, void (*trigger)(int i))
 {
 	struct sigaction sa, old_sa;
+	sigset_t mask, old_mask, wait_mask;
 	uint64_t count = 0;
 	int fd, i, err = TEST_FAIL;
 
@@ -68,6 +70,13 @@ static int count_overflows(struct perf_event_attr *attr, void (*trigger)(int i))
 		return TEST_FAIL;
 	}
 
+	/* Block signals so we only receive while waiting after each trigger() */
+	sigemptyset(&mask);
+	sigaddset(&mask, REFRESH_SIGNAL);
+	sigprocmask(SIG_BLOCK, &mask, &old_mask);
+	wait_mask = old_mask;
+	sigdelset(&wait_mask, REFRESH_SIGNAL);
+
 	if (fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC) < 0 ||
 	    fcntl(fd, F_SETSIG, REFRESH_SIGNAL) < 0 ||
 	    fcntl(fd, F_SETOWN, getpid()) < 0) {
@@ -82,20 +91,35 @@ static int count_overflows(struct perf_event_attr *attr, void (*trigger)(int i))
 		pr_debug("PERF_EVENT_IOC_REFRESH failed: %s\n", strerror(errno));
 		goto out;
 	}
-	for (i = 0; i < NR_EVENTS; i++)
+	for (i = 0; i < NR_EVENTS; i++) {
+		struct timespec timeout = { .tv_sec = 2 };
+		int before = overflows;
+
 		trigger(i);
+
+		/* Unblock signal to count and refresh event before triggering again */
+		while (overflows == before) {
+			if (ppoll(NULL, 0, &timeout, &wait_mask) == 0)
+				break;
+		}
+		if (overflows == before) {
+			pr_debug("no overflow signal for trigger %d\n", i);
+			break;
+		}
+	}
 	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
 
 	if (read(fd, &count, sizeof(count)) != sizeof(count))
 		pr_debug("failed to read the event count\n");
 	pr_debug("%d events, count %" PRIu64 ", %d overflows (%d POLL_HUP), re-arm errno %d\n",
 		 NR_EVENTS, count, overflows, hups, refresh_errno);
-	/* Unrelated page faults can only add overflows, never hide one. */
-	if (overflows >= NR_EVENTS)
+
+	if (overflows == NR_EVENTS)
 		err = TEST_OK;
 out:
 	/* Close first: a late signal must still find our handler. */
 	close(fd);
+	sigprocmask(SIG_SETMASK, &old_mask, NULL);
 	sigaction(REFRESH_SIGNAL, &old_sa, NULL);
 	return err;
 }

---
base-commit: eb79d2fbc230d41b009e49f20671303c6efbd946
change-id: 20261123-james-perf-event_refresh-cce5f6bd6f8c

Best regards,
--  
James Clark <james.clark@linaro.org>

