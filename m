Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F629AAFA
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Apr 2026 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777228112; cv=pass; b=jrCUsxISFSkY8ZyUWxjqXs9WjQfOj+K6yfNELZ5wG45uI5KMr07aFzsT8Ic27q0J7C2rAQwtGA0hnMQ3iZbSc2xDRrxvL17nISiU4B3ZUGJfcrSmufjDCEDm7WcXwYFmu82z/hxR5DmcEYgJWyNnJQIpRrhtG0HMofU0f7QBABE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777228112; c=relaxed/simple;
	bh=bZxa5rYplJEHw4K1VezKxprhBb/qoyZ5XgwwH46y188=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eLy0YUYj/lF5OvIbtaJEG+ModHBBfJGpASu059Y4J6BeblHLD0pXnGmoODgN6cYgb6M4ErdIlLDmYb4p8gOtKxKUWEbs3CtZvQoSH59n9UuPJDt2kFNkBvZ/sZzUwgTJy9jeGdK4Pu/2LEbMWL9UUCDre+F8BMDUMlkcRqY1RH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+WadnQS; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+WadnQS"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-505a1789a27so46855601cf.3
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Apr 2026 11:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777228110; cv=none;
        d=google.com; s=arc-20240605;
        b=iWCrBvMoVzAhCtvs41KlAWBhA4ce0ME0+DZJS1/yo5kdW3YAy3sDDfNjqFWL/HB3cE
         2gCRrsaabfYIOzSjfYDvPeKqWfqDGdVEYdbq5blpG7kEzETebbk3wD1o82DdLgyGpsBo
         I18YKc3SdbnU6byG2hisNsygfeZXkV2SIgTBOgkFE+Q9UbTCbrAh/ZpG3b/eX2z3S7Cv
         UwyOjGdXxgdH9xZcN6m2LP0MLweuLRre0c2NjD4lCCFahvmxcPTbMqcgvTiA2h5Nv3NK
         fzMl+rFJ4nwdmaLXcgFE0si+sVO2pPy8+5KmGHaHGeDI9O6bWEZrN9eGxrNjBnGEMzN+
         /gzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+H1DGKeH8lW96puZlUUqlUfBLwewfnuo31EhIuV813U=;
        fh=C1j0UlX0SvZQJnFQuzuN6HwLhD/OI/kg3EnSvQbQea8=;
        b=VUeJLPwI8YP6ZUf/+4wQj6UdyVYJ+VxLMMQAE3fPC0ISqp8qzx+IFTwgiTsSgRvllL
         P3BU+EPpCQmsICmVfptkBwY9zJdtdUGjyQc2a+N4Bvj+LTX1pfezsUZH7ocbb5QDj/d+
         42jqgrErze3LWro45lfG47ux9RfyDaTFUxvObeND+n5di1ikF5fNWLEwsjYHJiqVhUzt
         G2m8Za+CnRgiInAwPk+Z5I0m5dswh6DiIIzOL0yj+Ahlw4Xl4L/zpVDHeo6bFkomEwap
         rtn/6h+Z2oLKWEQ49h2Q8Ot39Ln4lAyisZBw11JwfbhMRwq/9iTqFkenAtN5ilWS0qr+
         kU4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777228110; x=1777832910; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+H1DGKeH8lW96puZlUUqlUfBLwewfnuo31EhIuV813U=;
        b=r+WadnQSdhV8USIYUymSGYlKTZ0waraYEMp8lmuNTGACDrx8Tm3jFbWnGyw0jpVMet
         mzYV5bE9+38PqRCIxEWHa0+NQQODp1rQR460cTxUORP+17lalFGAf00rVuTWo0o7JQOg
         ld44qYKAWUHgfXWW49tN0pPqGb5FinaJNKWzlJqV7O2YXZHWo4o5jlpvo1/6eb1SztYq
         vcTXYixwc2g5q1KB6XCExKamX0mrFmNY+6L2DWwS9/n8Ant0qNJeYZpskrWb6CoEOo+E
         FSlPod+TqWB4yx6RTTSFo/3TklniFpisrvrckMD4aqia3NzV4Ugg7KddWgMn1k58u7KF
         BnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777228110; x=1777832910;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H1DGKeH8lW96puZlUUqlUfBLwewfnuo31EhIuV813U=;
        b=Sd1h/Meu8f7F6s9x9LLh5mv6SHMjSMtjr1kxMPZr2sxcO3qR8KYGILnqC5VN17LDBo
         ybCO3Y+4TuEh5bRdCF6zWt02StJCWTgCYgGd5iptM/a8O5QWLVAxNZ2VCp9BGbtzrM9z
         J7wihfFilqlqWTaxDmJyyNcXf6/HtioCorEdHRyC5iw5n7xMM8Np6xCl9l+tmytuqNAe
         5GljbugwzikP9vjLGNtEzATxKFg/9jz99JK0Ftb7Q+oWglH4qCxmspJjdcF+xBndRSU+
         XwYiSIsCa9NMA1L7X3P16L3M+FKogwG9WmHPduXF/eTflwupbXhby+UxFX4DjwurMWON
         XGyQ==
X-Gm-Message-State: AOJu0YyOyBEzvuwhb10aV5Tczwvto6TcnsHDbTlvR1zqzVb88cjoWTn0
	Jr2FftknHCrLrVxbuTA7nAnJZYDU8dpuxkdB5IexAXuJ//MVOQBAgVyI2qGNhHiTw3NbcELH95s
	99gQiX/oFGjOS/0P/vkh5DQxLZKCbCm2quCaqF7PBVA==
X-Gm-Gg: AeBDietcW/0Tu2Kj2VlNOzXzDLwoTUihMInANfZGxdCb2WVC3LbMyr/VsgvBS+SQF6n
	E8KS60w4UrUCuRkMEwFUHMCbzYEwy4hgZYYINeS1auwOBFyNFcyoCnjTDTOZoL6lXbvI8CfWcEP
	UFjaqy0kfEU9rl7HUFnMgc+SlaJRbXZ7uk7FUXrBpoeK855K2tMbKaTOPcI6FFfaC+jPbssNYGU
	Zu2h3zCRyTE9y00smsFmUUDgVqS8CPx39OmEb/i50OAIyy+FmsBvR9Wth6fTykKrGcpFqAFtkWa
	sL9r6ZvtuHnXBGNcmFUPeBpbZpoTknUwKOPbg5yVQj/7m60W48EdJoC/7ornsAlmpxMpr3hSIZa
	/Rg7bd7K1c+bXH1WlwyAVsPSLSDa4vdTB2IWja5C5ZvbnZ4quN6AInIYAswx0LMZ1W04=
X-Received: by 2002:ac8:594c:0:b0:50d:9f02:86c7 with SMTP id
 d75a77b69052e-50e3682ee36mr605333871cf.13.1777228109679; Sun, 26 Apr 2026
 11:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Malcom Gilbert <malcomgilbert@gmail.com>
Date: Sun, 26 Apr 2026 13:28:18 -0500
X-Gm-Features: AQROBzDDy5YxLmbGvHKT7On3n4h5TNO028j-V4Da_rCLuvSzxmqvNslAOlOnHoE
Message-ID: <CAJ_TQUzM+JXDy4xo4TgeWBL7f6QA0muLxQ8kEv_0hRw6NqrmZQ@mail.gmail.com>
Subject: [PATCH] perf: add timerfd timeout exit-code handling
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Assisted-by: OpenAI:gpt-5.3-codex-spark
Signed-off-by: Malcom Gilbert <malcomgilbert@gmail.com>
---
 tools/perf/Documentation/perf-record.txt |  4 +
 tools/perf/builtin-record.c              | 94 ++++++++++++++++++++++++
 tools/perf/util/record.h                 |  1 +
 3 files changed, 99 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt
b/tools/perf/Documentation/perf-record.txt
index 178f483140ed..ea48f96fe11a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -554,6 +554,10 @@ When processing pre-existing threads
/proc/XXX/mmap, it may take a long time,
 because the file may be huge. A time out is needed in such cases.
 This option sets the time out limit. The default value is 500 ms.

+--timeout=<seconds>::
+Stop recording after the given number of seconds.
+If `perf record` stops from timeout, it exits with status 124.
+
 --switch-events::
 Record context switch events i.e. events of type PERF_RECORD_SWITCH or
 PERF_RECORD_SWITCH_CPU_WIDE. In some cases (e.g. Intel PT, CoreSight
or Arm SPE)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4a5eba498c02..e666d1d475a4 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -71,6 +71,9 @@
 #ifdef HAVE_EVENTFD_SUPPORT
 #include <sys/eventfd.h>
 #endif
+#ifdef HAVE_TIMERFD_SUPPORT
+#include <sys/timerfd.h>
+#endif
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <sys/types.h>
@@ -154,6 +157,9 @@ struct pollfd_index_map {
 struct record {
  struct perf_tool tool;
  struct record_opts opts;
+ int timeout_fd;
+ int timeout_pos;
+ bool timed_out;
  u64 bytes_written;
  u64 thread_bytes_written;
  struct perf_data data;
@@ -721,6 +727,77 @@ static void sigsegv_handler(int sig)
  sighandler_dump_stack(sig);
 }

+static int record__setup_timeout(struct record *rec)
+{
+#ifndef HAVE_TIMERFD_SUPPORT
+ pr_err("perf record --timeout is not supported on this platform\n");
+ return -1;
+#else
+ struct itimerspec new_value = {};
+ int fd;
+ int pos;
+
+ if (!rec->opts.timeout)
+ return 0;
+
+ fd = timerfd_create(CLOCK_MONOTONIC, TFD_NONBLOCK);
+ if (fd < 0) {
+ pr_err("Failed to create timeout timerfd, error: %m\n");
+ return -1;
+ }
+
+ new_value.it_value.tv_sec = rec->opts.timeout;
+
+ if (timerfd_settime(fd, 0, &new_value, NULL) != 0) {
+ pr_err("Failed to start timeout timer, error: %m\n");
+ close(fd);
+ return -1;
+ }
+
+ /* Recv all timer expirations in one-shot mode. */
+ pos = fdarray__add(&thread->pollfd, fd, POLLIN, fdarray_flag__nonfilterable);
+ if (pos < 0) {
+ pr_err("Failed to add timeout timerfd to poll list\n");
+ close(fd);
+ return pos;
+ }
+
+ rec->timeout_fd = fd;
+ rec->timeout_pos = pos;
+
+ return 0;
+#endif
+}
+
+static int record__process_timeout_event(struct record *rec)
+{
+ uint64_t expirations;
+ int pos = rec->timeout_pos;
+ struct pollfd *timeout_pollfd;
+
+ if (!thread || !thread->pollfd.entries || pos < 0)
+ return 0;
+ if (pos >= thread->pollfd.nr)
+ return 0;
+
+ timeout_pollfd = &thread->pollfd.entries[pos];
+ if (!(timeout_pollfd->revents & POLLIN))
+ return 0;
+
+ if (read(rec->timeout_fd, &expirations, sizeof(expirations)) < 0) {
+ if (errno == EAGAIN)
+ return 0;
+ pr_err("failed to read timeout timerfd, error: %m\n");
+ return -1;
+ }
+ (void)expirations;
+
+ rec->timed_out = true;
+ done = 1;
+
+ return 0;
+}
+
 static void record__sig_exit(void)
 {
  if (signr == -1)
@@ -2438,6 +2515,9 @@ static int __cmd_record(struct record *rec, int
argc, const char **argv)
  float ratio = 0;
  enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
  struct perf_env *env;
+ rec->timeout_fd = -1;
+ rec->timeout_pos = -1;
+ rec->timed_out = false;

  atexit(record__sig_exit);
  signal(SIGCHLD, sig_handler);
@@ -2647,6 +2727,10 @@ static int __cmd_record(struct record *rec, int
argc, const char **argv)
  if (rec->off_cpu)
  evlist__enable_evsel(rec->evlist, (char *)OFFCPU_EVENT);

+ err = record__setup_timeout(rec);
+ if (err)
+ goto out_child;
+
  /*
  * Let the child rip
  */
@@ -2814,6 +2898,10 @@ static int __cmd_record(struct record *rec, int
argc, const char **argv)
  err = record__update_evlist_pollfd_from_thread(rec, rec->evlist, thread);
  if (err)
  goto out_child;
+
+ err = record__process_timeout_event(rec);
+ if (err)
+ goto out_child;
  }

  if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
@@ -2919,6 +3007,10 @@ static int __cmd_record(struct record *rec, int
argc, const char **argv)

  if (rec->off_cpu)
  rec->bytes_written += off_cpu_write(rec->session);
+ if (rec->timed_out) {
+ signr = -1;
+ status = 124;
+ }

  record__read_lost_samples(rec);
  /* this will be recalculated during process_buildids() */
@@ -3639,6 +3731,8 @@ static struct option __record_options[] = {
      "\t\t\t  Optionally send control command completion ('ack\\n')
to ack-fd descriptor.\n"
      "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and
used as ctl-fd / ack-fd.",
       parse_control_option),
+ OPT_UINTEGER(0, "timeout", &record.opts.timeout,
+     "Stop recording after the given number of seconds"),
  OPT_CALLBACK(0, "synth", &record.opts, "no|all|task|mmap|cgroup",
      "Fine-tune event synthesis: default=all", parse_record_synth_option),
  OPT_STRING_OPTARG_SET(0, "debuginfod", &record.debuginfod.urls,
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..576513ed3b60 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -80,6 +80,7 @@ struct record_opts {
  int      ctl_fd_ack;
  bool      ctl_fd_close;
  int      synth;
+ unsigned int  timeout;
  int      threads_spec;
  const char    *threads_user_spec;
  u64      off_cpu_thresh_ns;
--
2.43.0


Malcom
