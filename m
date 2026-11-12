Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526665;
	b=hM+b4rr/9wmicmz47/Uml3nQQIaNr28/+zbVPB3kZHfWDMTtpwtuWRres96YOwlYKR4d
	 +ufC299/6oMBohla3b5I9uf0H2MAPVQ0z8xtgH3y7KUhPWkYvIMcu4Uf1BRiBxVng1gqF
	 CgOy+lGY7nmH/gXuvl95Ny774pxgq5tuhg2XTBij191kOjnu+9UBcFuSpqs0QeK952Bhl
	 lAfgHou0ph44Gr0a+hSNG334uNH2KR/4srATiRx9EhRhxzajqXgkOG6fqEkaD3AXLuvcg
	 TsJWX7cKLFUkubIwgPkbEGgQDpaZ1SQGVbCrpurebwl4PVLD/fzKYBEbRHL8EKoUDBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Rfpzb/ezDwI38PLxzrjqkaoWvyzmkf9DKdXHTzqeDHo=;
	b=wX1IN6M5yfZjpi8tl8Df1NYEej2XhYUbgE+kbZtoa54rvaK+e7awmzzfowYQ0OrXYS7J
	 pT5ol0l0lozYj3DRVDedTSPoF1BhV56rKQSescshB9+t1X0QldRmI59N+4v6t9Xw1hCTG
	 ig5NsgJcXFBnFb5GI+ZmW87KyCBR9eGNWLA0PL6mPE2ppHPjtknFWJAVs6MCxDfu3E8o7
	 4SYQTlT6brWshcDOqsxEVXsOSFLUcZc7CWSf5g/WQxqexeigoTPFQDgESJ+XYK5Ep4Ckk
	 UI5SeSsKR8ZqTnF4jfTKWRgOOQnqMhzX+yjJgmBdPs+/fsYuU2q+Lg/zv0cHhHtn/xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dRjwUjW2;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61750606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 23:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61750606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dRjwUjW2
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375bac6bd21so255273eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 15:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794526663; x=1795131463; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rfpzb/ezDwI38PLxzrjqkaoWvyzmkf9DKdXHTzqeDHo=;
        b=dRjwUjW2UKdovWxEID3EkzbnWLLTHk2mgUZYMXCc51U73cat8RdI8KiDjgQ5Uc11vw
         SuRF/vhkgtERht4/+O0rSeJT96rCH3XJXROwsEIrxr/6NzaNNubG52l9olc63khmh7Kt
         HKDTO58AJOp8CupoVuNzGzUMgNdQbu9dF4hoMJcDOiQUU8twttGMZAaapuK6wxQPtXx9
         +ZnrrJJi04kY4HVmjalrqkG9qTZ4QshMocNKYWs06nZ1jL34m2L6Pp+lB1wWQNH6CyF7
         ZBfCshH5ZAkIpFA6TAaZL/97ryAP5eEYyYIYuj6fp+c3VB++Vt+Pkgk4FLaf4JTEO6Zu
         ycvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794526663; x=1795131463;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rfpzb/ezDwI38PLxzrjqkaoWvyzmkf9DKdXHTzqeDHo=;
        b=G3N/yg3tyy0aG/cwzWKFIA+OoYhyIsO4ttSX44jNpJEP9MX10Gs7P7/yQEIiA8vH1p
         ZKib1A0CUyv24/le6PXWnIBGojnXxIEUOZaStCS21fUqk8q4gHBfzShpAqlGIdvQgh47
         yFYkaAbYnHeQynJi7prg8m1ifNRIUbBC2oMhMdi8SF47Hvf/GO5gedN3h7lY3itpKmZY
         iemN7NC7iWJwI6+hopjwxN4nFTC3xPsIR790r25dipRlroWs1Egd/suv/tdOoP4uq2q5
         /si+aMuJxRVm4MK0Q3vIJ0HDJf4U15DA8OK8779VO9lemxf/SCynhl9USgJ49jzO9Dkg
         S0dw==
X-Forwarded-Encrypted: i=1; AL+hErEu2RmiyS1/G79TDELvgY9Oll6Oj8Tz22E5y4ftb84Kl5gpD+ISta1ZbU8FGKY/hl0scI2fioqOJ37UhqVbDISP@vger.kernel.org
X-Gm-Message-State: APuU4Z8a6eSezvlnicvyIo78aLi2GtDZJSVFTuHoDy85LJ31R+E8ltQ6
	EOz/eqEYQ+r1E9gpxwaAgO8dOmx+45RSvR++JMGnc4J6CUJkQbzyjj6vDv0nulBwGNP4FrXGK3R
	9UhLlV+s7fA==
X-Received: from dybpd9.prod.google.com ([2002:a05:7301:4549:b0:36a:1c45:2f79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2103:b0:36a:1a7b:d1bb
 with SMTP id 5a478bee46e88-377e1af5c7bmr3672824eec.22.1794526663031; Thu, 12
 Nov 2026 15:37:43 -0800 (PST)
Date: Thu, 12 Nov 2026 15:37:33 -0800
In-Reply-To: <20261023054952.2503540-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023054952.2503540-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261112233738.699031-1-irogers@google.com>
Subject: [PATCH v6 0/2] perf timechart: Add --live mode to the TUI and test
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
 tools/perf/python/ttimechart.py               | 1232 +++++++++++++++--
 .../tests/shell/test_ttimechart_python.sh     |  355 +++++
 4 files changed, 1590 insertions(+), 97 deletions(-)

-- 
2.56.1.703.gf848ed807c-goog

