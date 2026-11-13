Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583586;
	b=aSfXb2Xc5slf5vLdt5XZM2qNsZ/44ulJl7+VtSBua8/sGxhwzZlUHkr5DTRdMo6mBHhK
	 C1itKU6f7GD2klm7wNaWNrxjNmdNkRWIXAfNYoAyrYvjEWvLVhFfkPT1kKIGjIHGEhMbg
	 QatzoaxyURUwBQZVETU0CpIxjIx0SHZYo1GcjbzrycKXFALakSU33L5PJWR2eWs77C+EF
	 fzCWhjktBdSSRRUSXfvS51BRwX8f4ZZDQMg8TOkALd2yunq56Y/uU6At9lEWB40vAGZ4j
	 pxBjcVApfx8VyNnuU2dLYPy8PeUaVgYtKVA1TDpRQzqP2UgbtM8zHFKpc7ycJ+IpUBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ksCTr69aLfQdt4ltbwzxK+Z6ceS2eGNuMsyjoiqUSnw=;
	b=N4onL293YF7a83GSPXKSazlX0WJ6OjUiukjyk2XkgjmPA6DNHEOIKdEbeZ9acrv6EGDu
	 9e98P8J/V0LN51Gq+ANhvIVaiAxuoSVcc0C553y49Y14XxCQryFbYwRd3+mHHboc8iWL8
	 8S5DKDpAKS7z28WsQsIVWS+pPhBknaECIMzv+S5spwnF5jaFfWYWMwyB/1Xdbr23e+hDi
	 nf/amtjavDNpmQpbLP803BeWZcyuciHcn6CMmrKIExd1X28uW/Dm0m4bS6uoYAmu6zHnP
	 ArwG5Yj7+x6lWv6qibipnt5XnQcmoADfA4dk6PVexW3Qmd9OwZlgeZHcu8h02osMKvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qJurvt7n;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F225606A339
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F225606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qJurvt7n
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-37549877380so1382218eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 07:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794583586; x=1795188386; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksCTr69aLfQdt4ltbwzxK+Z6ceS2eGNuMsyjoiqUSnw=;
        b=qJurvt7nD+dTOQo36yFhF02sMPEU2kosVfq3Njlbti4kcieD3MWkWnxrpbPV9TvPVb
         gyRAuklYDl8nQ8QLM4Dbv67jF6wpGvd8ZxNqOz342UP4Ydl3Yx8ziOFqGn/eP40lKhRv
         /Oas1KYNaYetKnmg2PCiCfQTykYwfUw3VbwhQLa1AzzqUaGJhZYld60GgYn+NWb3Km3G
         PLmYPQ7gqZRAVr4WVwJ3AF+8aUn45CjmI91NthNfgnYqm6AcahnuMdABidgxTS03afKt
         ZwpH2WWzL59fkGENfo232qA8hEvpZGkHZRQrlTtxc4WYXHNoALZPnWOsZDv5sToHtbN/
         zdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583586; x=1795188386;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ksCTr69aLfQdt4ltbwzxK+Z6ceS2eGNuMsyjoiqUSnw=;
        b=R6SvKy99X8Xat2xomgLycALOxa9fSg3dCldzyBCmmBqs+vkhKZBy5ZKuMea4B0FVtv
         td18bOXSvSlQUOOB/UjLOG2mboCOAHL/9dkjmCO4nSmVfvXjSjXFYYtFXQAhUwQPA02Q
         jALBDGQz//l3WEihTEk/TW+dRKe3FFyCaeek//78C+bS7ORzQ70OkEY4TgOzpYLzfenL
         o5o8EjfEDq97rMCUu47jCvzbnsvuLqPDj6w7bHrJ0Wg/3vrJOWoLy7HRtvDH1mZs6so8
         Qxz+ZQdcni0KjwB8dr0fiIhWJB3aHKUCUGdqaXX3tavphEKj1CyGm8P8jrSJvOLme7h9
         DZ2w==
X-Forwarded-Encrypted: i=1; AL+hErE6WKon9UphqYLNfaio68a8Xrp0wZa02iDYs9Qmd4pnjROSiQQV9Q/XokBNSxhJiI0hbsX9TzHaZxohAvNjmNJW@vger.kernel.org
X-Gm-Message-State: APuU4Z9of+BNK96DkuE4Mlb5tJLkU9SefVohMMiwWYOwuT22irl9w28v
	fM4r+IRdxhg2azl2WQ+u41xXNa1tbtHJeWR0hMV3eWgQdQX0zCVkW/cZilH6aC8Og0MMjyCQ5fx
	1IHoL7PnnVw==
X-Received: from dldz18-n2.prod.google.com ([2002:a05:701b:4192:20b0:1a7:2bf1:46cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b0c4:b0:176:2095:1ac4
 with SMTP id a92af1059eb24-1b5030f291fmr2234768c88.18.1794583585059; Fri, 13
 Nov 2026 07:26:25 -0800 (PST)
Date: Fri, 13 Nov 2026 07:26:18 -0800
In-Reply-To: <20261113055926.1159033-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113055926.1159033-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113152622.1991001-1-irogers@google.com>
Subject: [PATCH v8 0/2] perf timechart: Add --live mode to the TUI and test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	atrajeev@linux.ibm.com, changbin.du@huawei.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tanze@kylinos.cn, thomas.falcon@intel.com, wutengda@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

Add a '--live' option to 'perf timechart' and 'ttimechart.py' that streams
live scheduler, power, or I/O (-I/--io-only) events from a 'perf record'
subprocess over a pipe and displays them in the Textual TUI with a rolling
time window (--window, default 10s), pause/resume via the control pipe, an
optional workload after '--' that stops recording when it exits, and
optional output recording (-o), along with headless shell tests in
test_ttimechart_python.sh.

Assisted-by: Antigravity:gemini-3.1-pro

v8: Address Sashiko review feedback:
    - Patch 1: Track switch-out timestamps explicitly on Task rather than
      inferring switch counts from pruned STATE_RUNNING segments, and
      accumulate Task.totals from the actual clipped duration returned by
      SegmentList.add() while keeping Task.since monotonic.
    - Patch 1: Keep each I/O syscall as its own unmerged segment and avoid
      same-timestamp clipping so Task.io_bytes and syscall counts never
      drift across pruning.
    - Patch 1: Extend open STATE_WAITING and STATE_BLOCKED task states in
      checkpoint(), preserve non-sleeping states across prune(), and clamp
      live_prune() to last_time - 1 so open or finished states at last_time
      are not deleted when idle past --window.
    - Patch 1: Refresh comm names from perf.session on syscall lookups and
      periodic live intervals (ignoring perf's unset ':tid' placeholders) so
      pre-exec names update after execve(), and ignore scheduler-only tasks
      in dump() and the UI when -I is set.
    - Patch 1: Snapshot flush_round_target with a sequence counter before
      draining perf record's pipe so concurrent or split-record flushes are
      not dropped, and synchronize LiveRecorder.backlog() with
      close_data_fds() under fd_lock.
    - Patch 2: Add synthetic regression tests for all cases.

v7: Address Sashiko review feedback:
    - Patch 1: Pass the comm/PID filter expression as a positional
      argument to /bin/sh so the shell preserves the quotes around comm in
      --live -I mode instead of stripping them before execing perf record.
    - Patch 1: Clear LiveRecorder.control_thread if starting it raises so
      stop() does not call join() on an unstarted thread and skip FD/comm
      cleanup, and ignore OSError if perf record exits concurrently during
      stop().
    - Patch 2: Test the /bin/sh --filter quoting and control_thread
      startup failure cleanup in the synthetic live test, and add a live
      -I workload recording subtest when syscall tracepoints are permitted.
    v6: https://lore.kernel.org/lkml/20261112233738.699031-1-irogers@google.com/

v6: Rebase onto perf-tools-next and address Sashiko review feedback:
    - Patch 1: Queue pause/resume gap timestamps in a deque so rapid
      pause/resume cycles before buffered events arrive still close
      pre-pause open task and CPU states at each gap.
    - Patch 1: Increment nr_samples inside TimechartData.lock and check/update
      refreshed_samples in the same lock acquisition as checkpoint() in
      live_refresh() so final buffered events aren't missed when paused.
    - Patch 1: Keep cursor following in sync when zooming in/out, resetting
      zoom with '0' after moving the cursor, or jumping to a waker ('w').
    - Patch 1: Filter out all threads of ttimechart.py (via comm) and the
      child perf record process (via $$) on syscall tracepoints in --live -I
      mode, and ignore filtered I/O events before counting nr_samples.
    - Patch 1: Track record boundaries in LiveRecorder's pipe pump and emit a
      synthetic PERF_RECORD_FINISHED_ROUND when perf record goes idle or
      pauses so ordered_events does not hold back the latest round.
    - Patch 1: Always drain perf record's stdout on stop so perf record can
      flush and terminate its workload cleanly without blocking on pipe writes,
      and kill its process group if wait times out.
    - Patch 2: Gate the LiveRecorder task-clock subtest on system-wide
      task-clock permissions so unprivileged runs under perf_event_paranoid > 0
      skip cleanly, and add synthetic tests for multiple pause gaps, round
      tracking, and cursor following.
    v5: https://lore.kernel.org/linux-perf-users/20261023054952.2503540-1-irogers@google.com/

v5: Address Sashiko review feedback:
    - Patch 1: Always record system wide, as 'perf timechart record'
      does, as switches into a task and idle states aren't seen by
      per-task events when only a workload was recorded.
    - Patch 1: Don't move a task's state start back before its recorded
      history when its switch out and back in were lost, which inflated
      its running time.
    - Patch 1: Serialize LiveRecorder.stop() calls from the UI thread and
      the thread processing events.
    - Patch 2: Only run the live recording test when scheduler events can
      be recorded system wide.
    v4: https://lore.kernel.org/linux-perf-users/20261023050207.2449976-1-irogers@google.com/

v4: Address Sashiko review feedback on patch 1:
    - Don't prune live history past the last event, so open states aren't
      lost when no events arrive for a window, and don't count a still
      running task's open segment as a switch.
    - Keep showing the window at the end of recording, rather than jumping
      back to already pruned history, and prune events flushed as perf
      record exits.
    - Close open task, CPU and I/O states when resuming after a pause,
      rather than extending them across the unrecorded gap, and close the
      running task when a switch away from it was lost.
    - Stop perf record and close the files and pipes if
      LiveRecorder.start() fails after starting it, and close the data pipe
      read ends in LiveRecorder.stop().
    v3: https://lore.kernel.org/linux-perf-users/20261023041819.2361900-1-irogers@google.com/

v3: Address Sashiko review feedback:
    - Patch 1: Explicitly include <string.h> in builtin-timechart.c.
    - Patch 1: Reject non-finite --window values (e.g. 'inf') that
      overflowed converting to nanoseconds.
    - Patch 2: Stop the fake recorder in a try/finally in the synthetic
      live UI test so a failed check can't leave its background thread
      running and hang the test.
    Rebase onto the latest perf-tools-next.
    v2: https://lore.kernel.org/linux-perf-users/20261014042249.2379829-1-irogers@google.com/

v2: Rebase the remaining 2 patches onto perf-tools-next after patches 1-11
    of v1 were merged.

Alice Rogers (2):
  perf timechart: Add a --live mode to the TUI
  perf test: Test perf timechart --live

 tools/perf/Documentation/perf-timechart.txt   |   20 +-
 tools/perf/builtin-timechart.c                |   80 +-
 tools/perf/python/ttimechart.py               | 1334 +++++++++++++++--
 .../tests/shell/test_ttimechart_python.sh     |  591 ++++++++
 4 files changed, 1899 insertions(+), 126 deletions(-)

-- 
2.56.1.703.gf848ed807c-goog

