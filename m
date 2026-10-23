Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792736169;
	b=D+zM3qOoGTezCZgQouUzisP9DmrnTmb30lo4NzIVLYxvR8662/fSNYniJqduBd97/UMY
	 FR3AczGRuziCKmgK2wQAizqXuVop8AfZh9ry9evlLobWrz21bFBZxYroEEL/v4e6Z4Zr8
	 XVHcHjty9eQS23oyWJlCI8oZphVKxq5BPrGm00lq64rvmcuMDnR+HprT9lXacwshotA5q
	 3NxaYF9NJtwgBpt4H+EgKOcbGGCnJZPUmzs5c2rDTLQpLtV/gzYdrAKbaVkmlIQoEWCo5
	 Zw/nMuxRA6628Kz329Zv5HdxgixovAueo/c+gcYUkqq70FSpo2tdqZYN0591/Pq3Nsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792736169;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N5gC+D1EkOHI7XKmZxoEQi1a/eLp+W/Zz0B1IZLDm+k=;
	b=HZT/66v7J1BoG9kYK7oFQDpOVRgCVRF2a+/b884c/R/F8EXeZbWnfbco04E1fdSMIrOC
	 fTjjMxBlxdilDeWPTVPFceHM/2yPXUosE341LEovL8zyNmRMeM+l+HG7rNpRUVT1/Phcv
	 tkljVJiwhBz0AlelXAYLu4N48ola6vuSf9p+4Qydubr9yt1gMJYEqeGSIEN+981uGN/fi
	 2j+Rgaj8Vr50RXWsJC9XNnzxduLujtzIfbLd+SRN2ok0di2wXoNIMP9mgAJ9X9TSR7B20
	 MUCcrNMS0x+eb2+GYEPgmC/Jr6cwKZXVN0l70MFikhvwWb5fEYHM1f4HsZDWviDEfMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLuyBOVb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AEE606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLuyBOVb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2561F01825;
	Fri, 23 Oct 2026 06:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792736168;
	bh=N5gC+D1EkOHI7XKmZxoEQi1a/eLp+W/Zz0B1IZLDm+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lLuyBOVbM+8bV8NoF5H9TxsWqZ0D+vo7zJ+Z5tv8Z3S69tKplA/TUbkeXSRQV0735
	 RLVPZS/lLhyH3IW11paHM8xASbKjzxxWYLnYoHzE4zFcLTPVWqYg42SLjyFtoDdq3S
	 AzaiBh/PBzzSqvGUmrSwoHaTQziJ/txEDXUxASL/eVl7s3BFzDzbEi6NBgLdVv19lq
	 A8upeFEzzueEXjngMldmCnbrZuD7TZHc5piaS++WROAwZITj5k63OmRjF4neH8bzKr
	 v/vcjY988jDQxnsV1ocrXR2I7yMI2cJDaNW3tsHxdtb2lF2Vzn1zOKcVdJRgbpS6FW
	 wPS27pGQRzI9w==
Message-ID: <sashiko-outbox-182337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] perf timechart: Add a --live mode to the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023054952.2503540-2-irogers@google.com>
References: <20261023050207.2449976-1-irogers@google.com>
 <20261023054952.2503540-1-irogers@google.com>
 <20261023054952.2503540-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 06:16:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] perf timechart: broken live cursor following on zoom, reset, and=
 goto_task()
- [Medium] perf timechart: mark_gap() overwrites pending gap_at on rapid pa=
use/resume
- [Medium] perf timechart: unlocked nr_samples increment races with live_re=
fresh()
- [Medium] perf timechart: missing finished_round leaves live events buffer=
ed
- [Medium] perf timechart: incomplete syscall filter in LiveRecorder.start()
- [Medium] perf timechart: live mode stop() blocks perf record and orphans =
workload
--

commit dc903a5155a83951be9359f3695ae64ac3fc69e5
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf timechart: Add a --live mode to the TUI

This commit adds a --live mode to perf timechart and ttimechart.py that
runs perf record into a pipe and displays a rolling window of scheduler,
power, or I/O events interactively in the terminal UI. It also supports
pausing and resuming recording via perf record's control pipe and adaptive
refresh intervals.

> diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimecha=
rt.py
> index 34ecf84e68c1d..acd1a8651244e 100755
> --- a/tools/perf/python/ttimechart.py
> +++ b/tools/perf/python/ttimechart.py

[ ... ]

> @@ -326,21 +425,83 @@ class TimechartData:

[ ... ]

> +    def mark_gap(self, time: int) -> None:
> +        """Note that recording, paused for a while, resumes at time, the=
 lock must be held.
> +
> +        Events weren't recorded while paused, so the states at the pause=
 aren't
> +        known to have continued. They are closed before the first event =
after
> +        time is processed, the events are processed in time order.
> +        """
> +        self.gap_at =3D time
> +
> +    def _close_gap(self) -> None:
> +        """Close open states at the last event before the gap, see mark_=
gap()."""
> +        end =3D self.last_time
> +        for task in self.tasks.values():
> +            task.change_state(end, STATE_UNKNOWN)
> +            task.io_pending =3D None
> +        for c in self.cpus.values():
> +            if c.cur_tid > 0:
> +                c.run.add(c.since, end, 1, c.cur_tid)
> +            c.cur_tid =3D -1
> +            if c.cstate_cur:
> +                c.cstate.add(c.cstate_cur[0], end, 1, c.cstate_cur[1])
> +                c.cstate_cur =3D None
> +            if c.pstate_cur:
> +                c.pstate.add(c.pstate_cur[0], end, 1, c.pstate_cur[1])
> +                c.pstate_cur =3D None
> +        self.resumed_at =3D self.gap_at
> +        self.gap_at =3D 0

[ ... ]

> @@ -527,6 +701,8 @@ class TimechartData:
>      def _process_event(self, sample: perf.sample_event) -> None:
>          """Update the data from a sample, the lock must be held."""
>          time =3D sample.sample_time
> +        if self.gap_at and time >=3D self.gap_at:
> +            self._close_gap()
>          if not self.first_time or time < self.first_time:
>              self.first_time =3D time
>          self.last_time =3D max(self.last_time, time)

[Severity: Medium]
What happens in TimechartData.mark_gap() and TimechartData._process_event()
if the user pauses and resumes live recording again before an event from
the first resumed interval has been processed?

In TimechartApp.action_toggle_pause(), resuming from pause calls
self.data.mark_gap(monotonic_ns()), which sets self.gap_at =3D time. Open
task and CPU states from before the pause are only closed when
TimechartData._process_event() sees a sample with time >=3D self.gap_at and
calls self._close_gap().

Because perf record flushes periodically on ping and perf.session buffers
events in ordered_events until a subsequent round marker, a user can resume
at T2, pause at T3, and resume at T4 before any sample with time >=3D T2
reaches TimechartData._process_event(). When mark_gap(T4) overwrites
self.gap_at =3D T4, buffered samples from [T2, T3) have sample_time < T4 and
bypass _close_gap(), stretching pre-pause task and CPU states across the
first pause gap.

Should mark_gap() avoid overwriting a smaller non-zero self.gap_at, or
close the pending gap immediately before recording the new timestamp?

[ ... ]

> @@ -1486,6 +1726,204 @@ class TimechartApp(App):

[ ... ]

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
> +                    self.live_prune()
> +            self.update_views()
> +            self.update_live_status()
> +        # Measure the cost of the refresh including drawing the screen.
> +        self.call_after_refresh(self.live_refreshed, start)

[Severity: Medium]
Can TimechartApp.live_refresh() race with TimechartData.process_event() and
miss rendering the final buffered event when paused?

In TimechartData.process_event(), the worker thread increments
self.nr_samples before acquiring self.lock to call _process_event(sample):

    def process_event(self, sample: perf.sample_event) -> None:
        """Callback from perf.session for each sample."""
        self.nr_samples +=3D 1
        ...
        with self.lock:
            self._process_event(sample)

Meanwhile, TimechartApp.live_refresh() reads self.data.nr_samples under
self.data.lock, releases the lock, updates self.refreshed_samples =3D sampl=
es,
and then re-acquires self.data.lock to call self.data.checkpoint() and
self.update_views().

If live recording is paused (self.paused_at !=3D 0) and live_refresh() reads
the incremented self.data.nr_samples before the worker thread acquires
self.lock and finishes _process_event(sample), live_refresh() records
self.refreshed_samples =3D samples and renders the views before the sample =
is
added to self.data. Subsequent live_refresh() ticks while paused then see
samples =3D=3D self.refreshed_samples and skip refreshing.

Should self.nr_samples be incremented inside with self.lock: in
TimechartData.process_event(), and read inside the same lock acquisition in
TimechartApp.live_refresh()?

[ ... ]

> +    def user_window(self, window: TimeWindow) -> None:
> +        """Change the window for the user.
> +
> +        In live mode, zooming or panning so that the whole window isn't =
shown
> +        stops the view following the latest events.
> +        """
> +        if self.live:
> +            whole =3D window.start =3D=3D window.first and window.end =
=3D=3D window.last
> +            if window.cursor !=3D self.window.cursor:
> +                self.follow_cursor =3D False
> +            elif whole and not self.following:
> +                self.follow_cursor =3D True
> +                if self.data.last_time:
> +                    window =3D replace(window, cursor=3Dmin(max(self.dat=
a.last_time, window.first),
> +                                                        window.last))
> +            if self.following !=3D whole:
> +                self.following =3D whole
> +                self.update_live_status()
> +        self.window =3D window

[ ... ]

> @@ -1569,14 +2012,23 @@ class TimechartApp(App):

[ ... ]

> -        if first or last:
> +        if self.live:
> +            live_first, live_last =3D self.live_bounds()
> +            win =3D self.window.extend(live_first, live_last)
> +            if self.following:
> +                win =3D win.reset()
> +            if self.follow_cursor and last:
> +                win =3D replace(win, cursor=3Dmin(max(last, live_first),=
 live_last))
> +            self.window =3D win
> +        elif first or last:
>              self.window =3D self.window.extend(first, last)

[Severity: Medium]
Does cursor following in TimechartApp.user_window(),
TimechartApp.update_views(), and TimechartApp.goto_task() stay in sync when
zooming, resetting zoom, or jumping to a waker in live mode?

There appear to be three related cases where self.follow_cursor and
self.following diverge:

1. When zooming in or out via TimelineView.action_zoom_in() or
action_zoom_out(), TimeWindow.zoom() keeps window.cursor =3D=3D
self.window.cursor whenever the cursor is within [self.start, self.end].
In TimechartApp.user_window(), whole becomes False and self.following is
set to False, but self.follow_cursor =3D False is only run if window.cursor
!=3D self.window.cursor. Because self.follow_cursor remains True, every
subsequent live_refresh() -> update_views() overwrites win.cursor with
last, dragging the cursor out of the zoomed view.

2. If the user moves the cursor without zooming or panning, user_window()
sets self.follow_cursor =3D False while whole and self.following remain Tru=
e.
Pressing 0 (TimelineView.action_zoom_reset()) then calls
user_window(self.window.reset()), where elif whole and not self.following:
is skipped because self.following is already True, leaving
self.follow_cursor stuck at False.

3. Pressing w (TimechartApp.action_goto_waker() -> goto_task()) assigns
self.window =3D self.window.with_cursor(time) directly instead of calling
self.user_window(), leaving self.follow_cursor (and self.following) True so
the next refresh snaps the cursor and view back to the latest event.

[ ... ]

> @@ -1727,52 +2180,374 @@ class TimechartApp(App):

[ ... ]

> +    def start(self) -> None:
> +        """Start perf record, the data is then read from data_fd."""
> +        output =3D open(self.output, "wb") if self.output else None
> +        # perf record's ends of the control pipes, closed once it is sta=
rted.
> +        child_fds: List[int] =3D []
> +        try:
> +            ctl_r, self.ctl_fd =3D os.pipe()
> +            child_fds.append(ctl_r)
> +            self.ack_fd, ack_w =3D os.pipe()
> +            child_fds.append(ack_w)
> +            # Quiet so that only errors are written to stderr, see error=
_text().
> +            cmd =3D [self.perf_exe, "record", "-q", "-o", "-", "-R", "-c=
", "1", "-k", "mono",
> +                   "--synth=3Dtask", "--control", f"fd:{ctl_r},{ack_w}"]
> +            filt =3D f"common_pid !=3D {os.getpid()}"
> +            for name in self.events():
> +                cmd +=3D ["-e", name]
> +                if name.startswith("syscalls:"):
> +                    cmd +=3D ["--filter", filt]

[Severity: Medium]
Does the tracepoint filter common_pid !=3D os.getpid() in
LiveRecorder.start() exclude I/O syscalls made by the child perf record
process and ttimechart.py's worker threads when running with --live -I?

In kernel tracepoints, common_pid is current->pid (the thread ID, not the
process TGID). Unlike builtin-timechart.c:timechart__io_record(), which
runs cmd_record() in-process on a single thread, LiveRecorder.start() spawns
perf record as a child process and runs control_thread, tee_thread,
record_events, and Textual workers on separate Python threads whose TIDs
differ from os.getpid().

While TimechartApp.__init__() adds os.getpid() and proc.pid to
self.data.ignore_pids to hide them from live TUI rows, all of their
read/write/poll/select syscalls are still recorded by the kernel. Those
events increment self.nr_samples in TimechartData.process_event() before
io_enter() and io_exit() check ignore_pids, and tee_thread writes them into
any file saved with -o, polluting the saved perf.data when later viewed
with perf timechart or perf timechart --tui.

[ ... ]

> +    def control_loop(self) -> None:
> +        """Send queued commands, otherwise pings that flush perf record'=
s buffers."""
> +        try:
> +            while not self.stopping.is_set():
> +                try:
> +                    cmd =3D self.commands.get(timeout=3Dself.flush_inter=
val)
> +                except queue.Empty:
> +                    if self.paused:
> +                        continue
> +                    cmd =3D "ping"
> +                if not cmd or self.stopping.is_set() or not self.send(cm=
d):
> +                    break
> +        finally:
> +            self.close_control_fds()
> +
> +    def set_paused(self, paused: bool) -> None:
> +        """Pause or resume recording."""
> +        self.paused =3D paused
> +        self.commands.put("disable" if paused else "enable")

[Severity: Medium]
When pausing recording or running in --power-only mode, can the latest
round of events remain buffered in perf.session's ordered_events queue
without being delivered to TimechartData.process_event()?

In tools/perf/util/ordered-events.c:__ordered_events__flush(), handling
OE_FLUSH__ROUND (on PERF_RECORD_FINISHED_ROUND) calls do_flush() up to the
previous oe->next_flush before advancing oe->next_flush =3D oe->max_timesta=
mp:

    err =3D do_flush(oe, show_progress);

    if (!err) {
        if (how =3D=3D OE_FLUSH__ROUND)
            oe->next_flush =3D oe->max_timestamp;

        oe->last_flush_type =3D how;
    }

TimechartApp.tune_refresh() sets self.live.flush_interval =3D
self.refresh_interval / 2 so that two pings occur per refresh. However, in
tools/perf/builtin-record.c:record__mmap_read_evlist(), perf record only
writes finished_round_event when new bytes were actually read from the
ring buffers during that pass:

    if (!record__threads_enabled(rec) && bytes_written !=3D rec->bytes_writ=
ten)
        rc =3D record__write(rec, NULL, &finished_round_event, sizeof(finis=
hed_round_event));

When LiveRecorder.set_paused(True) queues "disable" and stops sending
"ping" in LiveRecorder.control_loop(), perf record disables the evlist,
drains the final pre-pause events in one pass, and writes only one
PERF_RECORD_FINISHED_ROUND (which flushes the prior round and sets
oe->next_flush). The next pass reads 0 bytes from the disabled ring buffers
and emits no second PERF_RECORD_FINISHED_ROUND, leaving the final round of
pre-pause events buffered in ordered_events while paused. The same happens
in --power-only mode when a subsequent ping pass sees no new power events.

[ ... ]

> +    def stop(self) -> None:
> +        """Stop recording, perf record then writes any remaining data an=
d exits.
> +
> +        Called from both the UI thread and the thread processing the eve=
nts,
> +        so they don't both signal, reap and close perf record's pipes at=
 once.
> +        """
> +        self.stopping.set()
> +        self.commands.put("")
> +        with self.stop_lock:
> +            self._stop()
> +
> +    def _stop(self) -> None:
> +        """Stop perf record and the threads, stop_lock must be held."""
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
> +        self.close_data_fds()
> +
> +    def close_data_fds(self) -> None:
> +        """Close the read ends of the data pipes, stop_lock must be held.
> +
> +        perf.data() duplicates the file descriptor it reads from, so they
> +        aren't needed once processing has started. Closing them means wr=
ites
> +        to them fail, rather than block, once they are no longer read.
> +        """
> +        self.data_fd =3D -1
> +        tee_r, self.tee_r =3D self.tee_r, -1
> +        if tee_r >=3D 0:
> +            try:
> +                os.close(tee_r)
> +            except OSError:
> +                pass
> +        # Unless the tee thread is still reading from it.
> +        if self.proc and self.proc.stdout and not (self.tee_thread and
> +                                                   self.tee_thread.is_al=
ive()):
> +            self.proc.stdout.close()

[Severity: Medium]
When quitting live mode, can TimechartApp.cancel_loading() and
LiveRecorder._stop() cause perf record to block on pipe writes, get killed
with SIGKILL, and leave the workload child process running as an orphan?

When quitting, TimechartApp.cancel_loading() sets loading.cancelled =3D True
before calling self.live.stop():

    loading =3D self.loading
    if loading is not None:
        loading.cancelled =3D True
    if self.live:
        self.live.stop()

On the worker thread, TimechartData.process_event() raises LoadCancelled at
the next PROGRESS_INTERVAL (1000 samples), causing read_events() to exit
and close perf.data's duplicated pipe fd while LiveRecorder._stop() sends
SIGINT to perf record and calls proc.wait(timeout=3D1). However,
self.close_data_fds() is not called until the end of _stop(), so
self.proc.stdout remains open while nobody is reading from it.

In tools/perf/builtin-record.c:__cmd_record(), perf record flushes all
ring buffers to stdout before sending SIGTERM to its workload child:

    record__mmap_read_all(rec, true);
    goto out_free_threads;
    ...
    if (forks) {
        int exit_status;

        if (!child_finished)
            kill(evlist__workload_pid(rec->evlist), SIGTERM);

Once the pipe fills, perf record blocks in write(), hits
subprocess.TimeoutExpired after 1 second, and proc.kill() sends SIGKILL
only to proc.pid (even though perf record was started with
start_new_session=3DTrue), leaving any workload started after -- running
in the background. (Even if close_data_fds() were called before
proc.wait(), an early EPIPE/SIGPIPE during record__mmap_read_all() would
still terminate perf record before it reaches the kill(..., SIGTERM) call.)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023054952.2503=
540-1-irogers@google.com?part=3D1
