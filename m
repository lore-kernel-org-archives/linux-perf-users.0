Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731732;
	b=XSnt34QJne/QY1ayKGnb0sp+rSWmuhci1ZhymDZXsbTlcvVE9JU+uBhlOG5LPVqWTxNI
	 JHmMctAgiyVTEfyuWtAzTqZYsPcbAEes0MXZkVWTXxrOzjfI7iNHSyB2M8PEpC1tQkhvG
	 jsRXMMoQ9LCpGnNMLUAP5Q0itsyEyyoZSic5K0YMaMjvhidrkxXbU8upvtvwJtJ9GVmo7
	 mXywEF5JI7bqQkBvKIv7JQuWr5wa885F78jPFe5uzwf9pdCDFEqzu0smy30iRRbI4e87v
	 +bc822GkE9uEKDJat7UAn91mYxBpHB4sMQShfx/LX4xXIayyDuNPGKqb1dq74hknzeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=j0KfvoStPE/oWeU/D6LwKAOgnsFDdhuJc9bCzRL10U0=;
	b=nBix5ca/J8F9sS4qswZ82O+VfsCT12c/dd17Y79fGmsYU77xtnU6AcMg+XfEUpsgkVL/
	 3F28UzvQ/464dUj6SNHXAh+e2p3yaxL605lNh9Ze/8qCa5rthcs1IBmJiiAHKStBE1gJD
	 +zhZ1IdKOqUU5/VPHvACudp63SJq+TEGISeqiKbqsTkjnx682NZLq7nXCvGWJMvk3KG9Y
	 NczB+wfL3GdWe6zH/lcHzFK9B2yb1J4U69PzWbffgdTRUXfOMTSN3jnRHVo4FtnUfXrN8
	 H8pWgIp8Pj1DcsEtVbAK7R1j95qawBrJORoL7j8wSkSrPW07VrREUNlERMuFmEfF5Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IT6teL8P;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA828606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 05:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA828606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IT6teL8P
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7e92f36f9so402512a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792731731; x=1793336531; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j0KfvoStPE/oWeU/D6LwKAOgnsFDdhuJc9bCzRL10U0=;
        b=IT6teL8P/8WJyg2Qmivyk5+1CTe93ZN2wGCDi/jVdJ8uxQdhxn3ZElylxQVR65sck5
         fZ95ac+Q7wDuAZ83/yNmjQpgLWXhEV14IjXwybedVgJo935vTDgvkwJKW8AKp35l02BM
         TDGgUYpLd03GYE9HakwHXRmo+adEAb12vQikZ48bnJMVfqoI7treKusHSGgkaHz4nWPf
         nKlKwTcigDWG8/HYmoh18r6QXQxW2YpZsRMqAQ5d3HtzhaUQ/T/e5Mk0ma7cJh8AB59g
         X7zDZb1D0M1QKubFjdzprc2cjnnIAJfyPkcZ9+zeVoI59Bvuh3iwU1XGymk+A7v/30nu
         hYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792731731; x=1793336531;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0KfvoStPE/oWeU/D6LwKAOgnsFDdhuJc9bCzRL10U0=;
        b=QqmUArFRan+exkbbOtqJuW7ZsGetAjsD6junljm1+kbBY5gBnB8GUaQjn9ZrTw8ddC
         aG70SiCXNtKfPASqWhsol3s/137iWKixSL9oi7R2IRpDNzQe7TIBi/X16eqndefdiW7S
         X+wujCw4BcB9kNEt2nCV40rC7EeEsQF6fDaeqp9B5ThfOaxrtn+0EOIqdHmd58S1Omrh
         xIPulH6sCyeINAuQzo47JHcuGKDIJtQP+xllpewuNC7xsSQr7IGnyPgORkBvNL48+ZKC
         58kWxpRQCQ2uSVv4RbO7iND0UVpDouz1VqYqzryIVB8UFgMJlBs4kjVoobJ5ls3ZGfPM
         MeSw==
X-Forwarded-Encrypted: i=1; AKwUvBxLQHkMm9mo81WW9tGo+slKkbz2xj1S6DJ9dSy9fb7ma8txZ4wtT/EyFb5DHDVon6euYVX7jGU8h6obQT+VjDrq@vger.kernel.org
X-Gm-Message-State: AFq9FYLCijDfXCOV2agNltiLDzm58mndSqfXh6uryqYc5XsNjs4hQo9Q
	dPd/FiEwmlBkmu5qIHzR+4Rmqfj9Vuv2FCbRWeH67pMkt9HuyWGzXR2Vq1Z/kyCaAfG1QtJyP+G
	yQ7VsYxxvJA==
X-Received: from pgmc14.prod.google.com ([2002:a63:1c4e:0:b0:cc7:cb66:8df9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9149:b0:3e1:c08f:16dd
 with SMTP id adf61e73a8af0-3e37666562bmr898625637.27.1792731730576; Thu, 22
 Oct 2026 22:02:10 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:02:04 -0700
In-Reply-To: <20261023041819.2361900-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023041819.2361900-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023050207.2449976-1-irogers@google.com>
Subject: [PATCH v4 0/2] perf timechart: Add --live mode to the TUI and test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, atrajeev@linux.ibm.com, changbin.du@huawei.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tanze@kylinos.cn, 
	thomas.falcon@intel.com, wutengda@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

Add a '--live' option to 'perf timechart' and 'ttimechart.py' that streams
live scheduler, power, or I/O (-I/--io-only) events from a 'perf record'
subprocess over a pipe and displays them in the Textual TUI with a rolling
time window (--window, default 10s), pause/resume via the control pipe, an
optional workload after '--', and optional output recording (-o), along
with headless shell tests in test_ttimechart_python.sh.

Assisted-by: Antigravity:gemini-3.1-pro

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

 tools/perf/Documentation/perf-timechart.txt   |  20 +-
 tools/perf/builtin-timechart.c                |  81 +-
 tools/perf/python/ttimechart.py               | 883 ++++++++++++++++--
 .../tests/shell/test_ttimechart_python.sh     | 303 ++++++
 4 files changed, 1212 insertions(+), 75 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

