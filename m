Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792730252;
	b=0z1XEqNaujcbPil0P1bQ6ZbIvl/68f8yUayx58ooVr0GZMaeBfUWWx7TAeLKRujKkC/G
	 OeEp5AhrAWngXGFhNyIkz1T3QfuAuA2X7QshIoQ8HjjvP/Dd7hKmOW50LcFHPqRR7CVXg
	 JX1T3Pns6b223rqNqQxBf8KRPYOebSud+nhcH8TDmy2IyfFknJsvPuGnLa4++cdcwfj+g
	 oIV4bc5b/NoZjjKkQFS6dzHwOx9W6kZadCzXwAXtwk1Lnd9J3sROEdecjMzkj8WyiLGyC
	 3yzEyfpuKawkQwrJeWQHGxWybKjLnSH3bTvlpYcvh9iuMbvSCozURymbU/9QytmHlrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792730252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RsbxBuBNjL+V+AUQ+wdJH2DnvG72cwiooAWhf7Zn0+I=;
	b=ryQtqmGrVQ0nUQxXy0MJ8g7LkdBeQCxBTmo7ftzIeAKFQI8tkftrs+Ul+gv1cWr9dhUG
	 aNMbquMf9dSkLmUnRJCvhrhu9sE+VMinCeR1vNC3uNu1pvfUBqstgzU+iUCe8KhbeffPc
	 6NxTwpMMTXPyjS9TNcuG3n6Ywt9/yExh1lFKg+05+hf42YwgpzYOf2ApCwCx+rdiGBeqc
	 DWZy0NACB4+ccVku69qssam/ioQ8iUMKbx9X3hDnAu4H7k1JQCIJBdNSYHVpC3R3TGZIn
	 vsKzG8lWwJ3R+++AQQ/HTYY4kjCxTWUf0ulR4l9074ru7HTod9fN5Q4grlsf+YNWQKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIBDiAmY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32C606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIBDiAmY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B181F01828;
	Fri, 23 Oct 2026 04:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792730252;
	bh=RsbxBuBNjL+V+AUQ+wdJH2DnvG72cwiooAWhf7Zn0+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIBDiAmYTdP7769tCgesYNKd837m6LPANGSMpb9r5VY05WYvCEqaFH9bK5jco1v6+
	 20/0VrpffKqaa+t8j0QHld6n8iKfg7YCYPRj1bosgpyVxbPuu3StbzTOLvuDC71vqp
	 jPtjUGkjU1LXmT+VjFXKc62vHqjmweGV102sgp+OyJig+TAvWRkEKYKouy6OgHX9jR
	 EFRukrSC72mSFqyElHvNZru8t+0pgFraXvOzmXjZYOFJeKkGpdkiIn/yzSa23SSdtb
	 2ryc1Nxk6HXTpxmbdMiGwVdu5drIWKZAeY++1uCzfntZhfi0TfurAW06f0HKDf62NA
	 M0/QwrnRcrtfw==
Message-ID: <sashiko-outbox-182290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf timechart: Add a --live mode to the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023041819.2361900-2-irogers@google.com>
References: <20261014042249.2379829-1-irogers@google.com>
 <20261023041819.2361900-1-irogers@google.com>
 <20261023041819.2361900-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 04:37:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] perf timechart: checkpoint() uses last_time while prune() uses m=
onotonic_ns()
- [Medium] perf timechart: recording_finished() jumps live_bounds() to prun=
ed history
- [Medium] perf timechart: action_toggle_pause() leaves task and CPU states=
 open
- [Medium] perf timechart: LiveRecorder leaks tee_r and stdout pipe file de=
scriptors
- [Medium] perf timechart: LiveRecorder.start() leaks perf record process o=
n pipe error
--

commit 082000f3148508f20fda16552cb18e198341c26e
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf timechart: Add a --live mode to the TUI

This commit adds a --live option to perf timechart and ttimechart.py to
record scheduler, power, or I/O events with perf record into a pipe and
display a sliding window of recent history in the interactive TUI.

> diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimecha=
rt.py
> index 34ecf84e68c1d..083ab39dd3308 100755
> --- a/tools/perf/python/ttimechart.py
> +++ b/tools/perf/python/ttimechart.py
[ ... ]
> @@ -265,6 +317,38 @@ class Task:
>              return True
>          return any(f =3D=3D str(self.tid) or f in self.comms for f in fi=
lters)
> =20
> +    def prune(self, time: int) -> None:
> +        """Discard history ending at or before time, removing it from th=
e totals."""
> +        segs =3D self.segs
> +        num =3D segs.num_ending_by(time)
> +        for i in range(num):
> +            state =3D segs.keys[i]
> +            self.totals[state] -=3D segs.ends[i] - segs.starts[i]
> +            if state =3D=3D STATE_RUNNING:
> +                # Running segments end when the task is switched out.
> +                self.switches =3D max(self.switches - 1, 0)
> +        if num < len(segs.starts) and segs.starts[num] < time:
> +            self.totals[segs.keys[num]] -=3D time - segs.starts[num]
> +        segs.prune(time)
[ ... ]
> +        if self.since <=3D time:
> +            self.since =3D time
> +            if not segs and self.state !=3D STATE_RUNNING:
> +                self.state =3D STATE_UNKNOWN
[ ... ]
> @@ -281,6 +365,17 @@ class Cpu:
>          self.pstate =3D SegmentList()
>          self.pstate_cur: Optional[Tuple[int, int]] =3D None
> =20
> +    def prune(self, time: int) -> None:
> +        """Discard history ending at or before time."""
> +        self.run.prune(time)
> +        self.cstate.prune(time)
> +        self.pstate.prune(time)
> +        self.since =3D max(self.since, time)
> +        if self.cstate_cur and self.cstate_cur[0] < time:
> +            self.cstate_cur =3D (time, self.cstate_cur[1])
> +        if self.pstate_cur and self.pstate_cur[0] < time:
> +            self.pstate_cur =3D (time, self.pstate_cur[1])
[ ... ]
> @@ -562,6 +688,32 @@ class TimechartData:
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
> +        for c in self.cpus.values():
> +            if c.cur_tid > 0 and end > c.since:
> +                c.run.add(c.since, end, 1, c.cur_tid)
> +                c.since =3D end
> +            if c.cstate_cur and end > c.cstate_cur[0]:
> +                c.cstate.add(c.cstate_cur[0], end, 1, c.cstate_cur[1])
> +                c.cstate_cur =3D (end, c.cstate_cur[1])
> +            if c.pstate_cur and end > c.pstate_cur[0]:
> +                c.pstate.add(c.pstate_cur[0], end, 1, c.pstate_cur[1])
> +                c.pstate_cur =3D (end, c.pstate_cur[1])
[ ... ]
> @@ -1486,6 +1674,186 @@ class TimechartApp(App):
[ ... ]
> +    def recording_finished(self) -> None:
> +        """Called on the UI thread when perf record exits, such as when =
the workload ends."""
> +        self.data.finish()
> +        self.recording =3D False
> +        self.paused_at =3D 0
> +        self.loaded =3D True
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
> +            now =3D self.data.last_time
> +        last =3D max(now, self.live.origin + self.live_window)
> +        return max(self.live.origin, last - self.live_window), last

[Severity: Medium]
In tools/perf/python/ttimechart.py, when perf record exits and
TimechartApp.recording_finished() sets self.recording =3D False before call=
ing
TimechartApp.update_views() -> TimechartApp.live_bounds(), can the displayed
window jump backwards into already-pruned history or leave final flushed
events unpruned?

While self.recording is True, TimechartApp.live_bounds() computes the window
from monotonic_ns(), and TimechartApp.live_refresh() prunes history prior to
monotonic_ns() - self.live_window (stored in self.data.pruned_to).

Once self.recording becomes False, live_bounds() switches now to
self.data.last_time without clamping the lower bound to at least
self.data.pruned_to. If no events arrived shortly before the workload exited
(for example, during a sleep or between I/O bursts with -I),
last - self.live_window falls earlier than self.data.pruned_to, shifting the
view back into a time range whose segments were already discarded.

Conversely, if perf record flushes buffered events on exit in read_events()
after the last timer refresh, recording_finished() does not call
self.data.prune(self.live_bounds()[0]) and self.prune_rows(), leaving histo=
ry
older than the final window in the task totals and segments.

> +    def live_refresh(self) -> None:
> +        """Show newly recorded events and discard those no longer in the=
 window."""
> +        start =3D monotonic()
> +        with self.data.lock:
> +            samples =3D self.data.nr_samples
> +        # When paused, once the buffered events are shown there's nothin=
g new.
> +        if not self.paused_at or samples !=3D self.refreshed_samples:
> +            self.refreshed_samples =3D samples
> +            with self.data.lock:
> +                self.data.checkpoint()
> +                if self.recording and not self.paused_at:
> +                    self.data.prune(self.live_bounds()[0])
> +                    self.prune_rows()
> +            self.update_views()
> +            self.update_live_status()
> +        # Measure the cost of the refresh including drawing the screen.
> +        self.call_after_refresh(self.live_refreshed, start)

[Severity: Medium]
What happens in TimechartApp.live_refresh() when self.data.last_time lags
behind the prune timestamp returned by self.live_bounds()[0]?

In TimechartApp.live_refresh(), self.data.checkpoint() extends open running,
idle, and frequency states only up to end =3D self.last_time (the timestamp=
 of
the last processed sample). Immediately afterwards, self.data.prune() is
called with self.live_bounds()[0], which is computed from
monotonic_ns() - self.live_window.

When no new events have been processed for --window seconds (for example, a
CPU-bound single-threaded workload without context switches, steady power
states under -P, or an idle period), the prune timestamp time becomes great=
er
than or equal to self.data.last_time:

1. In Task.prune(), the checkpointed running segment for a still-running ta=
sk
   ends at self.last_time <=3D time, so segs.num_ending_by(time) includes i=
t.
   Task.prune() deletes that segment, subtracts its duration from
   self.totals, and decrements self.switches as if the task had switched ou=
t,
   causing the active running task to lose all segments and disappear from
   TimechartData.sched_tasks().

2. Both Task.prune() and Cpu.prune() then advance self.since,
   self.cstate_cur[0], and self.pstate_cur[0] to time without checkpointing
   the open state across [self.last_time, time], permanently dropping active
   task and CPU state across that interval.

Should TimechartData.checkpoint() or TimechartData.prune() ensure open stat=
es
are extended at least up to the prune timestamp (or avoid pruning past
self.data.last_time) and avoid decrementing Task.switches for the open edge
of a still-running segment?

[ ... ]
> +    def action_toggle_pause(self) -> None:
> +        """Pause or resume live recording, resuming shows the latest eve=
nts again."""
> +        if not self.live or not self.recording:
> +            return
> +        if self.paused_at:
> +            self.paused_at =3D 0
> +            self.following =3D True
> +            self.follow_cursor =3D True
> +        else:
> +            self.paused_at =3D monotonic_ns()
> +        self.live.set_paused(bool(self.paused_at))
> +        self.update_views()
> +        self.update_live_status()

[Severity: Medium]
When pausing and resuming live recording in TimechartApp.action_toggle_paus=
e()
via LiveRecorder.set_paused(), how are open task and CPU states handled acr=
oss
the unrecorded gap?

While perf record is disabled via the control pipe, no sched_switch,
sched_wakeup, cpu_idle, or syscall tracepoints are recorded, but open states
in TimechartData (task.state, task.since, c.cur_tid, c.since, c.cstate_cur,
and task.io_pending) are left open at their pre-pause timestamps.

When recording is resumed and new events arrive:

1. TimechartData.checkpoint() and subsequent event handlers extend open
   segments from the pre-pause timestamp to the post-resume timestamp,
   attributing the entire paused period as continuous running or idle time.

2. If a task that was in STATE_RUNNING on a CPU when paused switches out or
   exits while recording is disabled, its sched_switch out is missed. When
   events resume on that CPU with a different prev_tid:

   TimechartData.sched_switch() {
       ...
       if c.cur_tid > 0:
           c.run.add(c.since, time, 1, c.cur_tid)
       c.cur_tid =3D next_tid
       c.since =3D time
       if prev_tid !=3D 0:
           prev =3D self.task(prev_tid, prev_comm)
       ...
   }

   only prev_tid and next_tid are updated, while the old task (c.cur_tid)
   remains in STATE_RUNNING forever and is extended up to self.last_time on
   every subsequent TimechartData.checkpoint() call.

Should pausing (or resuming) close or reset open task, CPU, and pending I/O
states across the disabled interval, and should TimechartData.sched_switch()
also handle the case where c.cur_tid > 0 and c.cur_tid !=3D prev_tid?

[ ... ]
> @@ -1727,52 +2110,329 @@ class TimechartApp(App):
[ ... ]
> +    def start(self) -> None:
> +        """Start perf record, the data is then read from data_fd."""
> +        output =3D open(self.output, "wb") if self.output else None
> +        ctl_r, self.ctl_fd =3D os.pipe()
> +        try:
> +            self.ack_fd, ack_w =3D os.pipe()
> +        except OSError:
> +            os.close(ctl_r)
> +            self.close_control_fds()
> +            if output:
> +                output.close()
> +            raise
[ ... ]
> +        try:
> +            # A new session so that signals for the terminal aren't rece=
ived.
> +            self.proc =3D subprocess.Popen(cmd, stdin=3Dsubprocess.DEVNU=
LL, stdout=3Dsubprocess.PIPE,
> +                                         stderr=3Dself.stderr, pass_fds=
=3D(ctl_r, ack_w),
> +                                         start_new_session=3DTrue)
> +        except OSError:
> +            self.close_control_fds()
> +            if output:
> +                output.close()
> +            raise
> +        finally:
> +            os.close(ctl_r)
> +            os.close(ack_w)
> +        assert self.proc.stdout
> +        self.data_fd =3D self.proc.stdout.fileno()
> +        self.grow_pipe(self.data_fd)
> +        if output:
> +            # Save the data as it is passed on to be processed.
> +            tee_r, tee_w =3D os.pipe()
> +            self.tee_thread =3D threading.Thread(target=3Dself.tee,
> +                                               args=3D(self.data_fd, tee=
_w, output),
> +                                               daemon=3DTrue)
> +            self.tee_thread.start()
> +            self.data_fd =3D tee_r
> +            self.grow_pipe(self.data_fd)

[Severity: Medium]
In LiveRecorder.start(), if os.pipe() for (tee_r, tee_w) raises OSError aft=
er
subprocess.Popen() has already launched perf record with
start_new_session=3DTrue, will the detached perf record subprocess and open
output file be leaked when main() catches OSError and exits?

Also, if the first os.pipe() call for (ctl_r, self.ctl_fd) raises OSError,
output is not closed before the exception propagates.

> +        self.control_thread =3D threading.Thread(target=3Dself.control_l=
oop, daemon=3DTrue)
> +        self.control_thread.start()
> +
> +    @staticmethod
> +    def grow_pipe(fd: int) -> None:
> +        """Make the pipe bigger, if allowed, to absorb bursts of events.=
"""
> +        try:
> +            fcntl.fcntl(fd, fcntl.F_SETPIPE_SZ, LIVE_PIPE_SIZE)
> +        except OSError:
> +            pass
> +
> +    def tee(self, src: int, dst: int, output: Any) -> None:
> +        """Copy the data from src to dst and the output file."""
> +        os.set_blocking(dst, False)
> +        forwarding =3D True
> +        try:
> +            while True:
> +                buf =3D os.read(src, 1 << 16)
> +                if not buf:
> +                    break
> +                output.write(buf)
> +                view =3D memoryview(buf)
> +                while forwarding and not self.stopping.is_set() and view:
> +                    try:
> +                        view =3D view[os.write(dst, view):]
> +                    except BlockingIOError:
> +                        select.select([], [dst], [], 0.1)
> +                    except OSError:
> +                        # The data is no longer processed, keep saving i=
t.
> +                        forwarding =3D False
> +        finally:
> +            output.close()
> +            os.close(dst)
[ ... ]
> +    def stop(self) -> None:
> +        """Stop recording, perf record then writes any remaining data an=
d exits."""
> +        self.stopping.set()
> +        self.commands.put("")
> +        proc =3D self.proc
> +        if proc is not None and proc.poll() is None:
> +            try:
> +                proc.send_signal(signal.SIGINT)
> +                proc.wait(timeout=3D1)
> +            except subprocess.TimeoutExpired:
> +                # Probably blocked writing data that is no longer proces=
sed.
> +                proc.kill()
> +                proc.wait()
> +        if self.tee_thread and self.tee_thread is not threading.current_=
thread():
> +            self.tee_thread.join(timeout=3D1)
> +        if self.control_thread and self.control_thread is not threading.=
current_thread():
> +            self.control_thread.join(timeout=3D1)
> +        self.close_control_fds()

[Severity: Medium]
Does LiveRecorder leak the tee_r pipe file descriptor (assigned to
self.data_fd) and self.proc.stdout?

When read_events() creates perf.data(fd=3Dsource), pyrf_data__init() in
tools/perf/util/python.c duplicates the file descriptor with dup(fd), so
destroying the perf.data object only closes the duplicated descriptor and
leaves live.data_fd open.

Because tee_r (self.data_fd) and self.proc.stdout are never closed in
read_events() or LiveRecorder.stop(), LiveRecorder.tee() will also never see
BrokenPipeError on os.write(dst, view) if read_events() stops reading early,
and instead will hit BlockingIOError once the pipe fills until self.stopping
is set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023041819.2361=
900-1-irogers@google.com?part=3D1
