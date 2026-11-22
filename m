Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795366877;
	b=YN2eTpvmcEO+PB8wOrJhR/1QxWxNatijaUHsUMY7N2KBphEM2uRklm4e9bNxORcMm8gN
	 jLAJYwRNSqbno6sJueoWzjmvzoF9G2xw2X7VqC7zNZZR0MeTQWb14YNWwpAMibEUSjdjM
	 T6H8Br0xeENLpzolTQKKj9sTtntQ0KF7xrRqzlC1QXQG6SvRYW0bGrgi4TFZQafJ4DvZ7
	 jrK+5HbvsuIC8squJa6hbYrjfjmlpnjgt14dvcoQpWmyW7geoJVTqCHIZ7trtpEeOCMbY
	 0Qfk73r0dPBuS33Mk+0bGFALojDjWhmcQNK4CnHokQiAeyp0ZsChKiz13IK5FPKFehg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DrzgiFmBm4hYbypPeeTGjMwfD3uI6h49BzMOnPTdENE=;
	b=enszb2w1E/3Sit1pK13+ac0w7gl7+TzuNon2C+LMZinHDYhMJFqGpxcZiyKXmN+Vn1DZ
	 I3+plfb/U+fSx31ZZPCbWH5uqnWAhQkmCjfPp6hxToLdgEYioVDpbXQ9+YK/ZP7IbaqjI
	 LpIbfKqpI3uRtSwblY3oCTIi5jtMkIUJY25w+abBP4XQR2vUnzjLp26Bm1zaASlXcKjb1
	 4DRF68iAR2hGrtidHY9AhqJTYQOt273dKS3iX6El2kYoPBLQYskexqGKWCHQw5L3Vzpbl
	 mRmxUhTKYfUafi4SmYUT3QGyHN1pKAzYfx8DIhDuz3hiqpL8SZpgbZGOt4dnVMtjCDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a3HCuWTl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B2606A682
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 17:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E0B2606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a3HCuWTl
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-533202fe429so252811cf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 09:01:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795366874; cv=none;
        d=google.com; s=arc-20260327;
        b=YP9BGIYyEf5VHcDVbwuXdnqnZdh+DQHwxDweK5o3g9iToHNymLOoAV8xF9bPokCyVs
         aFlWWt6ECdBznpBqxj4Y9Ukz6JJieVghMPNJSnR/cjlRWoHG7ttERk50FULl5zdQhFsR
         VdzFI0G4KfMAI41NqCUTuZJdovhjJ/1cQaStYp2rINPYGbH5wOfKGQL8ENo94AEv8sUh
         Fscmut1U/xioqAFk/WvgGCSOd1Gd2RTUb4Ex6JEAxR70OAIAZAiDANvvZ5BpEnYsWNwI
         ZZqQ/r5e6UaV01BqwmDMJNAH/0dUJ1IjMfOg0O3UdVa1uWnYTdCER/e9A1vKHGQK+rZq
         CLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DrzgiFmBm4hYbypPeeTGjMwfD3uI6h49BzMOnPTdENE=;
        fh=hTcHHCYEbzzQQ1rLTqK+NfvcWTgzPWid88LxKgdr6io=;
        b=E43aJglLZZHWPdZPMeG6XDrubN3w86cI6UoApU7Y5mfrYdKKtNPB+sWai/e0ndcfSa
         TX5GfHtojE02RRPHPsMo+oxMTF8tiOBX81q37/qOoYCnDbzcSTxzNdZpig9Giv2PoDwK
         tbgJakSpRHa1z3pbRKox4GPSYlVvBzbD6x887DFoTrKkc/apEsIkz6XEAgRaq2xrLcFs
         x5owKcsc9OcGwwkrY1g2tMxqsmkxPapCE3ghkR3UngPHx5QSghf/46k4LuV18KkS4eXv
         0tCndkVBW4Q+/ehRVG5v0uvuXI2A3IxX4ivwxoypVzsJyl/Ky4gKIfb2rAdcIdtx2rWa
         Asbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795366874; x=1795971674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DrzgiFmBm4hYbypPeeTGjMwfD3uI6h49BzMOnPTdENE=;
        b=a3HCuWTlj1VBbi4XxQexwtbCwJ2kVwkydMmHosKYha/JK0KEVYCM+u30WmzqU7kle/
         lqYkAszPMiIAIRLzL7afmK3l+ROxvNS4LZf7kC/NHi17qoETdopNXCFmDq8KKnxoJcDK
         Me2BlxT9S8oWjWvqjb2vc+gLFE+gJSO0AL5MVxYgEnayqiPLWVLnxWTuw/ADAlekBtU3
         /qkAD0YECiL5771X9+efacFLuXrWRm/Gzi0z70uBGyr/DwHevsHS8wv4LBkq6w3IrnAH
         vw+hif20G3cK053ik9yYtkbNz2bdrJPo7EICh+0LWYpyQVRA3ilGumPC+bcsBCuDJU7/
         kN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795366874; x=1795971674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DrzgiFmBm4hYbypPeeTGjMwfD3uI6h49BzMOnPTdENE=;
        b=Np4VJoYM1cBs/fVlQHYL7g0qxiySC24KzdohjaoSltgvqAwcZzqtxVXIt+xEYOdMSY
         0vJ8ZrL2z8Up92WyrgEmC6ka50zkbWfyYZO5b1trHF/nzwWcrFepGX79ND9DBKpBoMSe
         3Htnc20s7SNRFJNHBqpo+WvyGsMON+HasB/rFNv8aSPAa9gE95VEBAwtEZVa/C0WN05v
         M3niZAuQ4+0+981RRXFEiNIIGzZqQYVA4o+ceMfz9hvXPLoOVWfDRHQ5krzknbrsAvrJ
         hxAA5PjpIMYpYy+U/ML2eKhV/+JFE+qe8k0HC3CsNso6P6wnmsHVC+Fesvyo2xEjHjcf
         V7cA==
X-Forwarded-Encrypted: i=1; AL+hErGswpNFxVt4rD/WHdeOilebddc7HQI7xw+nTRm6HYXtpxO1FKpzvb9YB7iJSaQ85auiQkKSYztrKAmzepOt7nr2@vger.kernel.org
X-Gm-Message-State: APuU4Z/89t8noxwhJyj7scgeWDHQDjOeY3CiLToz0jnpRMqQlPiVO/hX
	D6rCkAgdQQU29/+jIGjphRp7YhJK0FRDGVGEj06IafgRPJaH0j0aZdi2vOP7nqBUVGPEihK40k/
	XPymJ7IuGuhlY2kcnxtS9j/BNeokmQotqSe6pTBLX
X-Gm-Gg: AZFdTZft8LYLHOXCqG8pa4JArKOdA5BdL+NzbHFL9hrKAQxINPv/CmzgSUEhiJLN0xy
	vPIB0WSBN6TZUxa9WPpDGnx4WhWkT50Y0JEQGya7erVnW/iVWI2WIPVEP33scs8w0yt/PeUGp6g
	Hbib8W9jC0vvySgry0d4TCQd0C+L5VaVhX8mBnYZRq/YogNRbAbzA5oF0Nk9qn1qfOm2CTl46UT
	d+eJbJXCAoBTSE4eBBSiEXkUQXAAf7+xVSo4ddv+8kGM8/FLGI0HF89a/AG5K+yLh2G895yf8Gm
	/T0luM8p5ZAxruf6KwWzXIkayrctODKQD5pfYQLX9oHdUH3xXqA40vHUPJeV28Gj2qCV0vS3jth
	ybUWsxGKft1PPtl0AhvW8yyXkCW9Z4lzHwvO8
X-Received: by 2002:ac8:5cd5:0:b0:55b:d494:187f with SMTP id
 d75a77b69052e-55d881708admr22080771cf.5.1795366873162; Sun, 22 Nov 2026
 09:01:13 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113055926.1159033-1-irogers@google.com> <20261113152622.1991001-1-irogers@google.com>
In-Reply-To: <20261113152622.1991001-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 22 Nov 2026 09:01:01 -0800
X-Gm-Features: Aa3M54r5y9zALy56FUMMZIGiaMMrZkldEYrkffk8BjbH0vBHaQ1b36eXP6PTRU4
Message-ID: <CAP-5=fUFYGsixZCAT9dWi0oHj546oLS4YN=R3Zc9-+7JPzXdsg@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] perf timechart: Add --live mode to the TUI and test
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	alice.mei.rogers@gmail.com
Cc: adrian.hunter@intel.com, atrajeev@linux.ibm.com, changbin.du@huawei.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tanze@kylinos.cn, 
	thomas.falcon@intel.com, wutengda@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 7:26=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Add a '--live' option to 'perf timechart' and 'ttimechart.py' that stream=
s
> live scheduler, power, or I/O (-I/--io-only) events from a 'perf record'
> subprocess over a pipe and displays them in the Textual TUI with a rollin=
g
> time window (--window, default 10s), pause/resume via the control pipe, a=
n
> optional workload after '--' that stops recording when it exits, and
> optional output recording (-o), along with headless shell tests in
> test_ttimechart_python.sh.
>
> Assisted-by: Antigravity:gemini-3.1-pro
>
> v8: Address Sashiko review feedback:
>     - Patch 1: Track switch-out timestamps explicitly on Task rather than
>       inferring switch counts from pruned STATE_RUNNING segments, and
>       accumulate Task.totals from the actual clipped duration returned by
>       SegmentList.add() while keeping Task.since monotonic.
>     - Patch 1: Keep each I/O syscall as its own unmerged segment and avoi=
d
>       same-timestamp clipping so Task.io_bytes and syscall counts never
>       drift across pruning.
>     - Patch 1: Extend open STATE_WAITING and STATE_BLOCKED task states in
>       checkpoint(), preserve non-sleeping states across prune(), and clam=
p
>       live_prune() to last_time - 1 so open or finished states at last_ti=
me
>       are not deleted when idle past --window.
>     - Patch 1: Refresh comm names from perf.session on syscall lookups an=
d
>       periodic live intervals (ignoring perf's unset ':tid' placeholders)=
 so
>       pre-exec names update after execve(), and ignore scheduler-only tas=
ks
>       in dump() and the UI when -I is set.
>     - Patch 1: Snapshot flush_round_target with a sequence counter before
>       draining perf record's pipe so concurrent or split-record flushes a=
re
>       not dropped, and synchronize LiveRecorder.backlog() with
>       close_data_fds() under fd_lock.
>     - Patch 2: Add synthetic regression tests for all cases.
>
> v7: Address Sashiko review feedback:
>     - Patch 1: Pass the comm/PID filter expression as a positional
>       argument to /bin/sh so the shell preserves the quotes around comm i=
n
>       --live -I mode instead of stripping them before execing perf record=
.
>     - Patch 1: Clear LiveRecorder.control_thread if starting it raises so
>       stop() does not call join() on an unstarted thread and skip FD/comm
>       cleanup, and ignore OSError if perf record exits concurrently durin=
g
>       stop().
>     - Patch 2: Test the /bin/sh --filter quoting and control_thread
>       startup failure cleanup in the synthetic live test, and add a live
>       -I workload recording subtest when syscall tracepoints are permitte=
d.
>     v6: https://lore.kernel.org/lkml/20261112233738.699031-1-irogers@goog=
le.com/
>
> v6: Rebase onto perf-tools-next and address Sashiko review feedback:
>     - Patch 1: Queue pause/resume gap timestamps in a deque so rapid
>       pause/resume cycles before buffered events arrive still close
>       pre-pause open task and CPU states at each gap.
>     - Patch 1: Increment nr_samples inside TimechartData.lock and check/u=
pdate
>       refreshed_samples in the same lock acquisition as checkpoint() in
>       live_refresh() so final buffered events aren't missed when paused.
>     - Patch 1: Keep cursor following in sync when zooming in/out, resetti=
ng
>       zoom with '0' after moving the cursor, or jumping to a waker ('w').
>     - Patch 1: Filter out all threads of ttimechart.py (via comm) and the
>       child perf record process (via $$) on syscall tracepoints in --live=
 -I
>       mode, and ignore filtered I/O events before counting nr_samples.
>     - Patch 1: Track record boundaries in LiveRecorder's pipe pump and em=
it a
>       synthetic PERF_RECORD_FINISHED_ROUND when perf record goes idle or
>       pauses so ordered_events does not hold back the latest round.
>     - Patch 1: Always drain perf record's stdout on stop so perf record c=
an
>       flush and terminate its workload cleanly without blocking on pipe w=
rites,
>       and kill its process group if wait times out.
>     - Patch 2: Gate the LiveRecorder task-clock subtest on system-wide
>       task-clock permissions so unprivileged runs under perf_event_parano=
id > 0
>       skip cleanly, and add synthetic tests for multiple pause gaps, roun=
d
>       tracking, and cursor following.
>     v5: https://lore.kernel.org/linux-perf-users/20261023054952.2503540-1=
-irogers@google.com/
>
> v5: Address Sashiko review feedback:
>     - Patch 1: Always record system wide, as 'perf timechart record'
>       does, as switches into a task and idle states aren't seen by
>       per-task events when only a workload was recorded.
>     - Patch 1: Don't move a task's state start back before its recorded
>       history when its switch out and back in were lost, which inflated
>       its running time.
>     - Patch 1: Serialize LiveRecorder.stop() calls from the UI thread and
>       the thread processing events.
>     - Patch 2: Only run the live recording test when scheduler events can
>       be recorded system wide.
>     v4: https://lore.kernel.org/linux-perf-users/20261023050207.2449976-1=
-irogers@google.com/
>
> v4: Address Sashiko review feedback on patch 1:
>     - Don't prune live history past the last event, so open states aren't
>       lost when no events arrive for a window, and don't count a still
>       running task's open segment as a switch.
>     - Keep showing the window at the end of recording, rather than jumpin=
g
>       back to already pruned history, and prune events flushed as perf
>       record exits.
>     - Close open task, CPU and I/O states when resuming after a pause,
>       rather than extending them across the unrecorded gap, and close the
>       running task when a switch away from it was lost.
>     - Stop perf record and close the files and pipes if
>       LiveRecorder.start() fails after starting it, and close the data pi=
pe
>       read ends in LiveRecorder.stop().
>     v3: https://lore.kernel.org/linux-perf-users/20261023041819.2361900-1=
-irogers@google.com/
>
> v3: Address Sashiko review feedback:
>     - Patch 1: Explicitly include <string.h> in builtin-timechart.c.
>     - Patch 1: Reject non-finite --window values (e.g. 'inf') that
>       overflowed converting to nanoseconds.
>     - Patch 2: Stop the fake recorder in a try/finally in the synthetic
>       live UI test so a failed check can't leave its background thread
>       running and hang the test.
>     Rebase onto the latest perf-tools-next.
>     v2: https://lore.kernel.org/linux-perf-users/20261014042249.2379829-1=
-irogers@google.com/
>
> v2: Rebase the remaining 2 patches onto perf-tools-next after patches 1-1=
1
>     of v1 were merged.
>
> Alice Rogers (2):
>   perf timechart: Add a --live mode to the TUI
>   perf test: Test perf timechart --live

Ping. The Sashiko feedback is now clean on these final 2 remaining patches:
https://sashiko.dev/#/patchset/20261113152622.1991001-1-irogers@google.com

Thanks,
Ian

>  tools/perf/Documentation/perf-timechart.txt   |   20 +-
>  tools/perf/builtin-timechart.c                |   80 +-
>  tools/perf/python/ttimechart.py               | 1334 +++++++++++++++--
>  .../tests/shell/test_ttimechart_python.sh     |  591 ++++++++
>  4 files changed, 1899 insertions(+), 126 deletions(-)
>
> --
> 2.56.1.703.gf848ed807c-goog
>
