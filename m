Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551357;
	b=UoSd21KEmyqzWr6MPQ3p+M4Puui96Lt8JclIoqJWK0Fehbsb1FQkb8StE1eTtlCpfV8B
	 mSXnbKAKxSXA9OsFchRU6EEx1QBbjrSr+fAOgScxLp97cs/2jQAzoQbH0OoDw70AtKh8L
	 3wsFPb5rcF/x8MfMhT2NE1pEEdiHF32e93aW1YVtOex09rbxRJqStmyyIvblOhQvpZc1w
	 Gw/Nm0hYOJVj3ATtM1S+vrb0+Kb+0hBA0kqx6BfVMrMNhL6go4+snl2a2zBwy27iZT4Zs
	 guVd+MN9m7HbYs0yQGUtQmYGRrkVVp+GcPQsehnx1EeORWqqgEBdkRPC/6g6izpCzjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551357;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7p3rZE5bg+4z/EoiiZ8gaIrRFFee42/7j42BuvG/kvU=;
	b=xK+qKwIksLcf+SmN9PKlCa+xAhLMNorUz1+QSOadfQ8pqRXekTpcuxTfBm12wYlszylG
	 v3suhA2Ce0cJH50NYR1gC0nZZCcpdhaVkpaxsRN88Yau6F+KovXsMbpiFfcyF1vGwKFek
	 r6mIoz5G5kcJ6IoXHQlKgxu6U3xAA14h58eH8JQs4YMrzd5TyZzkxpxJqbnlNfBgw1COV
	 vTwfE/3J262eM5yqrHjzQmwsYwh0L7e3oVofCQiv3LsSgamPM6INqZy0GDLmxMx6pqM4y
	 xaio/ew8o7Oi0io7mT8koAFiA6QDrtfqGe2mjeK0C6s8XZdIrw6J+TvXEUW14YOkZ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBeKcPJq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3404606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBeKcPJq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677F71F000C4;
	Fri, 13 Nov 2026 06:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794551357;
	bh=7p3rZE5bg+4z/EoiiZ8gaIrRFFee42/7j42BuvG/kvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBeKcPJqW4wV5xdpP5ountIiFjM9Se0ctwe2FRtUWDmWsLfRtRWVvjJtwf4uldmcR
	 AmJxZg9HcepzuLA4a16jG+ORQD78lFvdJbF8ZPYlWEXpWepVIyXBP1ITx6ulfkddnA
	 LGw78CYrJMMAJSF47CcT6m7QEhDUkPoflvTuDC3HDkUU4UPSSlEJdZi2pbwjfibQoP
	 ACl6PPZzlxh50HVAAKHW0tu+DXwu3YTRhSKWOyTtFV9EwjVzTfsYsxEDjG0dGEyOgC
	 vA8F6nTynESuNUZ8DvFNWiOxzBpSvbhqg5gaGCk6vBXhUN0a35FgHzQpHYjQbzZlVV
	 hee3/Qxft89cQ==
Message-ID: <sashiko-outbox-212273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] perf timechart: Add a --live mode to the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113055926.1159033-2-irogers@google.com>
References: <20261112233738.699031-1-irogers@google.com>
 <20261113055926.1159033-1-irogers@google.com>
 <20261113055926.1159033-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:29:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [Medium] perf timechart: live_prune() at last_time deletes all open
  states
- [Medium] perf timechart: checkpoint() and prune() drop blocked and
  waiting states
- [Medium] perf timechart: stale pre-exec comm in task() during live I/O
  mode
- [Medium] perf timechart: io_bytes and switches drift in add() and
  prune()
- [Low] perf timechart: Task.totals drift after checkpoint() and
  change_state()
- [Low] perf timechart: update_views() and dump() use sched tasks with
  -I
- [Low] perf timechart: fix switch count underflow in Task.prune() after
  gaps
- [Low] perf timechart: race in LiveRecorder.pump() clearing
  flush_round_target
- [Low] perf timechart: race on data_fd in LiveRecorder.backlog() during
  stop()
--

commit bf97da434173bd983d47c0d1625c5c56ef3fbfc7
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf timechart: Add a --live mode to the TUI

This commit adds a --live mode to perf timechart and ttimechart.py that
streams events from perf record into the TUI and prunes history outside a
sliding time window.

> diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimecha=
rt.py
> index d7ba0276a9fb4..253116d96c717 100755
> --- a/tools/perf/python/ttimechart.py
> +++ b/tools/perf/python/ttimechart.py
[ ... ]
> @@ -265,6 +319,42 @@ class Task:
>              return True
>          return any(f =3D=3D str(self.tid) or f in self.comms for f in fi=
lters)
> =20
> +    def prune(self, time: int) -> None:
> +        """Discard history ending at or before time, removing it from th=
e totals."""
> +        segs =3D self.segs
> +        num =3D segs.num_ending_by(time)
> +        # A still running task's last segment, extended by checkpoint(),=
 ends
> +        # at since. It hasn't been switched out yet.
> +        open_edge =3D len(segs) - 1 if self.state =3D=3D STATE_RUNNING a=
nd segs and \
> +            segs.ends[-1] =3D=3D self.since else -1
> +        for i in range(num):
> +            state =3D segs.keys[i]
> +            self.totals[state] -=3D segs.ends[i] - segs.starts[i]
> +            if state =3D=3D STATE_RUNNING and i !=3D open_edge:
> +                # Running segments end when the task is switched out.
> +                self.switches =3D max(self.switches - 1, 0)

[Severity: Low]
Does decrementing self.switches for every pruned STATE_RUNNING segment cause
the switch count to drift when running segments are closed without a switch?

TimechartData._close_gap(), TimechartData.finish() and the lost-switch path
in TimechartData.sched_switch() transition a running task to STATE_UNKNOWN
and add a STATE_RUNNING segment without incrementing task.switches.  When
those segments are later pruned, i !=3D open_edge is true and Task.prune()
decrements self.switches anyway.  Conversely, if a switch-in was lost so
prev.state is not STATE_RUNNING in sched_switch(), prev.switches is
incremented without a matching STATE_RUNNING segment to decrement it on
prune.

> +        if num < len(segs.starts) and segs.starts[num] < time:
> +            self.totals[segs.keys[num]] -=3D time - segs.starts[num]
> +        segs.prune(time)
> +        io =3D self.io
> +        for i in range(io.num_ending_by(time)):
> +            ret =3D io.data[i][1]
> +            if ret > 0 and io.keys[i] in (IOTYPE_READ, IOTYPE_WRITE, IOT=
YPE_TX, IOTYPE_RX):
> +                self.io_bytes -=3D ret
> +        io.prune(time)

[Severity: Medium]
Can SegmentList.add() merging or clipping segments cause Task.io_bytes and
syscall counts to drift across Task.prune()?

SegmentList.add() merges a new segment into the previous one when
start =3D=3D self.ends[-1], key =3D=3D self.keys[-1] and data =3D=3D self.d=
ata[-1], and
drops segments that clip to end <=3D start.  In TimechartData.io_exit(),
task.io.add() uses iotype as key and (fd, ret) as data, while task.io_bytes
is incremented by ret on every call.  If two consecutive syscalls on the
same fd have the same type and return value and meet at self.ends[-1] (or
share the same timestamp so the second is clipped out), only one segment is
kept in task.io while task.io_bytes is incremented twice.  len(task.io) then
undercounts syscalls and Task.prune() only subtracts ret once, leaking ret
bytes in task.io_bytes.

> +        if self.io_pending and self.io_pending[0] < time:
> +            self.io_pending =3D (time, self.io_pending[1], self.io_pendi=
ng[2])
> +        del self.wakeups[:bisect.bisect_right(self.wakeups, (time, sys.m=
axsize))]
> +        if self.since <=3D time:
> +            self.since =3D time
> +            if not segs and self.state !=3D STATE_RUNNING:
> +                self.state =3D STATE_UNKNOWN

[Severity: Medium]
Does pruning a task whose state is STATE_BLOCKED or STATE_WAITING drop its
current state and history?

TimechartData.checkpoint() only extends open segments for tasks in
STATE_RUNNING, leaving STATE_BLOCKED and STATE_WAITING tasks unextended.
While a task remains blocked or waiting, that state is not shown in the live
timeline until a later event transitions the task, and once the prune window
reaches self.since, segs becomes empty and Task.prune() resets self.state to
STATE_UNKNOWN, allowing TimechartData.prune() to delete the task altogether.

[ ... ]
> @@ -342,13 +500,13 @@ class TimechartData:
>      def task(self, tid: int, comm: Optional[str] =3D None) -> Task:
>          """Find or create a task."""
>          task =3D self.tasks.get(tid)
> +        if not comm and self.session and (task is None or task.comm =3D=
=3D f"[{tid}]"):
> +            try:
> +                thread =3D self.session.find_thread(tid, tid)
> +                comm =3D thread.comm() if thread else None
> +            except (OSError, ValueError, KeyError, RuntimeError, TypeErr=
or, AttributeError):
> +                comm =3D None
>          if task is None:
> -            if not comm and self.session:
> -                try:
> -                    thread =3D self.session.find_thread(tid, tid)
> -                    comm =3D thread.comm() if thread else None
> -                except (OSError, ValueError, KeyError, RuntimeError, Typ=
eError, AttributeError):
> -                    comm =3D None
>              task =3D Task(tid, comm or f"[{tid}]")
>              self.tasks[tid] =3D task
>          else:

[Severity: Medium]
In live I/O-only mode, does this leave a task's pre-exec comm stuck after
execve()?

Syscall tracepoints call self.task(tid) with comm=3DNone.  When a child
process (such as a workload started by perf record with comm "perf-exec")
performs an I/O syscall before execve(), self.session.find_thread() sets
task.comm to the pre-exec name.  After execve() emits PERF_RECORD_COMM,
task.comm is neither None nor "[{tid}]", so self.task() never queries
self.session.find_thread() again, and TimechartData.update_comms() is never
called in live mode because self.progress is None.

[ ... ]
> @@ -562,6 +752,32 @@ class TimechartData:
>              except (OSError, ValueError, KeyError, RuntimeError, TypeErr=
or, AttributeError):
>                  pass
> =20
> +    def checkpoint(self) -> None:
> +        """Extend open running, idle and frequency states to last_time.
> +
> +        Live mode calls this before displaying and pruning so that state=
s that
> +        haven't changed recently are shown up to the latest event, rathe=
r than
> +        only once they end. The lock must be held.
> +        """
> +        end =3D self.last_time
> +        if not end:
> +            return
> +        for task in self.tasks.values():
> +            if task.state =3D=3D STATE_RUNNING and end > task.since:
> +                task.segs.add(task.since, end, STATE_RUNNING, task.cpu)
> +                task.totals[STATE_RUNNING] +=3D end - task.since
> +                task.since =3D end

[Severity: Low]
Can extending all running tasks to self.last_time cause Task.totals to drift
when a subsequent flush delivers an earlier event on another CPU?

checkpoint() advances task.segs.ends[-1] and task.since to self.last_time
for every running task.  If the next round flushes an event for one of those
tasks with sample_time < self.last_time, Task.change_state() sets
self.since =3D time (which is now earlier than self.segs.ends[-1]).  On the
following state change, change_state() adds the unclipped time - self.since
to self.totals, whereas self.segs.add() clips the segment start to
self.segs.ends[-1]; when Task.prune() later removes that segment, it
subtracts the clipped length from self.totals, leaking the difference.

[ ... ]
> @@ -604,7 +820,8 @@ class TimechartData:
>                         if len(t.io) and t.passes_filter(filters)),
>                        key=3Dlambda t: -len(t.io))
> =20
> -    def dump(self, power_only: bool, tasks_only: bool, filters: Sequence=
[str]) -> None:
> +    def dump(self, power_only: bool, tasks_only: bool, filters: Sequence=
[str],
> +             io_only: bool =3D False) -> None:
>          """Print a plain text summary, for use without a terminal UI."""
>          duration =3D self.last_time - self.first_time
>          span =3D max(duration, 1)
> @@ -613,7 +830,7 @@ class TimechartData:
>          print(f"Duration: {fmt_duration(duration)}, CPUs: {len(self.cpus=
)}, "
>                f"tasks: {len(tasks) or len(io_tasks)}, sched events: {sel=
f.sched_events}, "
>                f"power events: {self.power_events}, I/O events: {self.io_=
events}")

[Severity: Low]
When io_only is true on a perf.data file that also contains scheduler
events, shouldn't dump() and TimechartApp.update_views() ignore
sched_tasks()?

In both dump() and TimechartApp.update_views(), tasks is still populated
from data.sched_tasks(filters) when io_only is set.  If a recorded file
contains scheduler events as well as I/O events, -I reports the scheduler
task count and fills the Summary tab with scheduler tasks instead of
io_tasks, and pressing Enter on a task without I/O fails to jump to the
hidden Tasks tab.

[ ... ]
> @@ -1486,6 +1743,218 @@ class TimechartApp(App):
[ ... ]
> +    def recording_finished(self) -> None:
> +        """Called on the UI thread when perf record exits, such as when =
the workload ends."""
> +        # Keep showing the window at the end of recording, or when pause=
d,
> +        # which is after the history already discarded.
> +        self.finished_at =3D self.paused_at or monotonic_ns()
> +        self.data.finish()
> +        self.recording =3D False
> +        self.paused_at =3D 0
> +        self.loaded =3D True
> +        with self.data.lock:
> +            # Discard history from events flushed when perf record exite=
d.
> +            self.live_prune()
> +        self.refresh_bindings()
> +        self.update_views()
> +        self.update_live_status()
> +
> +    def live_bounds(self) -> Tuple[int, int]:
> +        """The time range kept and shown in live mode, the last window o=
f the recording.
> +
> +        Until a window of time has been recorded the range is the first =
window,
> +        so the timeline fills from the left, after that it moves with ti=
me.
> +        """
> +        assert self.live
> +        if self.paused_at:
> +            now =3D self.paused_at
> +        elif self.recording:
> +            now =3D monotonic_ns()
> +        else:
> +            now =3D self.finished_at
> +        last =3D max(now, self.live.origin + self.live_window)
> +        return max(self.live.origin, last - self.live_window), last
> +
> +    def live_prune(self) -> None:
> +        """Discard history before the live window, the data's lock must =
be held.
> +
> +        Open states are only extended up to the last event, see checkpoi=
nt(),
> +        so history after it isn't discarded. Otherwise, when events have=
n't
> +        been seen for a window, a still open state would lose its histor=
y.
> +        """
> +        self.data.prune(min(self.live_bounds()[0], self.data.last_time))
> +        self.prune_rows()

[Severity: Medium]
What happens in live_prune() when no new events arrive for --window seconds
so self.live_bounds()[0] reaches self.data.last_time?

TimechartData.checkpoint() and TimechartData.finish() only extend open
segments up to self.last_time, and SegmentList.num_ending_by(time) uses
bisect.bisect_right(self.ends, time), which selects all segments with
end <=3D time.  Once self.live_bounds()[0] >=3D self.data.last_time, clampi=
ng
the prune time to self.data.last_time passes self.data.last_time to
self.data.prune(), which deletes every segment in the trace (including open
states just extended to self.data.last_time by checkpoint()).  In
recording_finished(), self.data.finish() also sets every task's state to
STATE_UNKNOWN before self.live_prune() runs, so all tasks become empty and
are deleted as well.

[ ... ]
> @@ -1726,52 +2210,642 @@ class TimechartApp(App):
[ ... ]
> +    def pump(self, src: int, dst: int, output: Any) -> None:
[ ... ]
> +                while True:
> +                    try:
> +                        buf =3D os.read(src, 1 << 16)
> +                    except BlockingIOError:
> +                        break
> +                    except OSError:
> +                        eof =3D True
> +                        break
> +                    if not buf:
> +                        eof =3D True
> +                        break
> +                    if output:
> +                        output.write(buf)
> +                    with self.round_lock:
> +                        tracker.feed(buf)
> +                    if forwarding and not self.stopping.is_set():
> +                        # Keep draining src if dst is no longer read.
> +                        forwarding =3D self.write_pump(dst, buf)
> +                if eof or not forwarding or self.stopping.is_set():
> +                    continue
> +                flush =3D False
> +                with self.round_lock:
> +                    target =3D self.flush_round_target
> +                    self.flush_round_target =3D None
> +                    if (target is not None and tracker.at_boundary() and
> +                            tracker.unflushed_round and
> +                            (target < 0 or tracker.rounds =3D=3D target)=
):
> +                        tracker.unflushed_round =3D False
> +                        flush =3D True

[Severity: Low]
Can pump() clear self.flush_round_target before reading the data that
control_loop() wanted to flush?

pump thread                       control thread
-----------                       --------------
os.read(src) -> BlockingIOError
                                  send("ping")
                                    perf record writes round + FINISHED_ROU=
ND
                                    perf record writes ack
                                  with self.round_lock:
                                    self.flush_round_target =3D -1
                                  wake_pump()
with self.round_lock:
  target =3D self.flush_round_target
  self.flush_round_target =3D None  <-- cleared before new data in src is r=
ead

On the next loop iteration pump() drains the new round from src (setting
tracker.unflushed_round =3D True), but self.flush_round_target has already
been reset to None, leaving the final round unflushed in ordered_events
while paused.  Snapshotting self.flush_round_target before draining src (and
only clearing it if it wasn't updated in the meantime) would avoid losing
the flush request.

[ ... ]
> +    def backlog(self) -> float:
> +        """The fraction of the data pipe filled with data waiting to be =
processed."""
> +        try:
> +            pending =3D array.array("i", [0])
> +            fcntl.ioctl(self.data_fd, termios.FIONREAD, pending)
> +            size =3D fcntl.fcntl(self.data_fd, fcntl.F_GETPIPE_SZ)
> +        except OSError:
> +            return 0.0
> +        return pending[0] / max(size, 1)

[Severity: Low]
Can backlog() race with close_data_fds() when recording stops and raise an
uncaught ValueError on the UI thread?

worker thread                     UI thread
-------------                     ---------
record_events()
  live.stop()
    close_data_fds()
      self.data_fd =3D -1
      os.close(tee_r)
                                  live_refreshed()
                                    tune_refresh()
                                      live.backlog()
                                        fcntl.ioctl(-1, ...)  <-- raises Va=
lueError
  call_from_thread(recording_finished)
    self.recording =3D False

In Python, passing -1 to fcntl.ioctl() or fcntl.fcntl() raises ValueError
rather than OSError, which is not caught here.  In addition, if
close_data_fds() closes tee_r right after backlog() reads self.data_fd, a
concurrent open() (such as restore_own_comm() opening /proc/self/comm) can
reuse that file descriptor number before ioctl() runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113055926.1159=
033-1-irogers@google.com?part=3D1
