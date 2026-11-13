Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549570;
	b=irXH5+GDPSXAMBV+XtGffiTTD7Q7ygAXvC/G5I5KpZhCYvYaNSu1ZPI02thXiJq1Siat
	 l1jPc6cjAY9p3s5lDQkUKtv/M6mSCTOOxEZY06ccl+Wq94QaZz8MqiM2CpB2fFsDzNgqD
	 PTi67lQwZ0GHwD8aa/BwCWdJbpLk1QhkgwFBilleYJ84Xt+fJGMf7E4CjS1BdCO5WTTPv
	 LiU19ANFw+EE2nX7twMr+mjIktwGQDGZEdkIaT+wHMCVhM9HnHpvO5yWQy+Vcu6OfTWEc
	 4Pwp7uCyz1inyvhEwgUVu1k9kOkt76iio9ivxR+zCIVeXmvf7CG6TTYBypVLwXmgelg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uVS3sQm4/ocGwCoi1Q1djDhq/pb7pKIp/VM+esn2Vdk=;
	b=fdJ/lK3iGo6xr46ahBz22lYnblSFfFdmipfUIl9K7GX/ReO+59fams29iiyy0XpQX+8K
	 BCQU2GAprO9IL6zgPcbMX6UmK+GeXPYjAdBi8TxIXufgACGkQwObbo4QVi555m8WZjXsf
	 FjkuFMt22/pwG7kTtvjAxVlcmAxkURAdmGUHfM4AnDG+6EZQhz0uUCT15rugUimnxlyyx
	 1JqoLcTOggoeGTnF4y9H+NFEnJSypdxDnOiTBwbxqhk+kqOtCj5hQfQs9c2Q9BTb8qe3r
	 ZV1rmJGe+ZzfrY8wot1fim8vQcDdezDxm2pXC5QgAIAI+WUrrenb0Ixwkq5j6SI3AQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bEeQB+Nt;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840A606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 05:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7840A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bEeQB+Nt
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a3451ea93so631108eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 21:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794549570; x=1795154370; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVS3sQm4/ocGwCoi1Q1djDhq/pb7pKIp/VM+esn2Vdk=;
        b=bEeQB+NtAD5gpbaKuY1NawmRTvRg8xdXT1Fr2KAoNDR96lTliEHbiLznuCtzJx3SPu
         +Ie/CVtrWg3dfIivmSWUi8XyZ9LNOE0YgOKbngEvpKVBmuyKY7KoJfRxf+G3rXglUBxr
         zSpx89qzjA9ogDYtxPZxSxx8ri42qmjAH3eFfTxmGzU9NaktVc48/ZOF2A0juPx6vR+K
         p7zC1z/C7m+tCBcxX7IqYSyjSpliNNrj3DC7CxZMxUclVYdJOtYn88vS46C4LwZWt5ob
         fxOf2UEa8cA9wlIjTNULTRv4LsdY8hAJHL1EaAsWVab2+/Xo7Sx1xg0yU7oydJcRmQ4C
         S/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794549570; x=1795154370;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uVS3sQm4/ocGwCoi1Q1djDhq/pb7pKIp/VM+esn2Vdk=;
        b=pOojsRrnymojclz+z9JtBbs4jCEJ9XK5inQKV2sy4BV1FSkK50JKHN+xnRZEoNDilY
         WckhBeU1vo5rGpogqdyVdlGrv4uKw+fxVspdpgZUhKF0+Hj8Yn5CNPwt/uEsMOj+ZMR1
         8m4OtPwYpiIQosdg8Q+452ohL8sd6Cw63lX96zuhWiLMXqldZBUMXNDxax7FD0b92kuy
         DBvYdFfvI9uioRci7JIkmUq2GZ1yGoJjYVlZObusJ8+CN/SJIX2G8Aj7q3TCMGjZliat
         5PBa3HxYKiE4g2olsJjkr6cql0yzebCCqqRApF3eboSR9zSQjqcpOieKPsqe3aVAvRmJ
         dL4g==
X-Forwarded-Encrypted: i=1; AL+hErE8wdcpuCzLh2x8WOMoWSBOas8mAHlfg0zDFtDFovwSL160/v0d+4zZdg9UidUVtwrqiXYmgIFAPiiDMzWJl93E@vger.kernel.org
X-Gm-Message-State: APuU4Z9wBlTqRntoVUHSmrKZ4SfXagMjZmVODpY1mxcW4aLgHyMgNBV4
	ooiAFNzJexN6jfNdkhosiguzzXCV2nHbXm3rH1UTokenFTb3id1tlMCdBFfJeCxdlnYmhYQIamJ
	Xd2OKz4H75Q==
X-Received: from dycc8.prod.google.com ([2002:a05:693c:60c8:b0:36d:c15d:8d80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:18a9:b0:36a:12c4:8bd6
 with SMTP id 5a478bee46e88-37966e3a771mr1259911eec.22.1794549569153; Thu, 12
 Nov 2026 21:59:29 -0800 (PST)
Date: Thu, 12 Nov 2026 21:59:21 -0800
In-Reply-To: <20261112233738.699031-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112233738.699031-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113055926.1159033-1-irogers@google.com>
Subject: [PATCH v7 0/2] perf timechart: Add --live mode to the TUI and test
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
 tools/perf/python/ttimechart.py               | 1244 +++++++++++++++--
 .../tests/shell/test_ttimechart_python.sh     |  436 ++++++
 4 files changed, 1683 insertions(+), 97 deletions(-)

-- 
2.56.1.703.gf848ed807c-goog

