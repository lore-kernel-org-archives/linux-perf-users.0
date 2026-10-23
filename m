Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733139;
	b=rjPSB1DLID1quXtzLTpVgqwIRd2dZI9m4+1WQEWQ6mWMveE/I+fwxpt5bBQbjjQBQcrl
	 dj1wpJNdSq6LC+gARHkqbLTLSVr/9rFZkWNSX0zxV5v/ZK0TBYfCPP74cpSihiaQsD3Q4
	 1WLZfAHrGnb2XFNoC++lcVod9Y1Q1KvceSbsc/+M7kl9g3B27c/eqmZ6LgmQWGMqgg4jW
	 lBqwVcjn6ZFyU6QSwOmeeHGMccC4loYe7jU7uj5D6uNdrnYM+iiyPqGPHBDNdoLzMHm1s
	 Sazpi8jC3amca3j9KEccwOA0zbgC3LSGM7DmqLBfgCGoJzD5rjg2nvuNnyusoH+5MlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PgCVIhb5Gat9h7Q09t8qgBLwu1qeMpDt831Fn39JDA4=;
	b=GJMfUmGDA+KTx9Xq2SWGHHO41o1/SpkN7cMy4DXKuLiZFOlvxIbavPBH/aZGuLX0ZLcl
	 yvrPFmi2x2bvyUD4Qh2w2SlZGdgQZWvHScbyxgWPODL1BfHyfK/XASeJyl4aC0mpTJYrg
	 zb4MTk+wTL5DWtPJ8GH4bNAJhJ1+rHd2A/qVCjaQrOFcnadaNo4kDmSvuKUKXMYoMa72X
	 3kai5lACcPl0U6xVahWJBxmJUpI2QvPT45n38/a+Jjav3n9r/lwfxOqv57M4G65P3YFxa
	 P5Enu8XkfOn90lf/4ITm9sq5uqPHZ1gKMO+mjamox9y1soLZcQJ9P38P8k50q6mSJbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tw6hphYL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACE60A2633
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 05:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tw6hphYL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D121F031E1;
	Fri, 23 Oct 2026 05:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733138;
	bh=PgCVIhb5Gat9h7Q09t8qgBLwu1qeMpDt831Fn39JDA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tw6hphYLn5XNwpDOKkOkoZCDcZ7XYLJD+UCxm9/yW59tlKl2IXZls9EN+8/C/gbDl
	 e8Jnhuyb3axmoZGG239ecw/luxv1ktb3yplNmE8uSybU37d5dcQ77fj43ljlXcmUj2
	 lfx9MT5Xk/vw9X9jcgvFDSY5fWPkFi26FGYd+osUVp5+X6A8r0mtzVzyt32s45lism
	 pQ6EvOQpFILgoBDfMWPbRrHuhMnKItGw02zZmftgcviYqLte8Um5iiU9eF8s0EDVIQ
	 AYavC82xwtxbGNfgw+5Yzmmf9d119s1W5AvJnUftExCQO4RY+eTxlfGUzK1jtaMxra
	 D5lRMLYb6sXMA==
Message-ID: <sashiko-outbox-182309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] perf timechart: Add a --live mode to the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023050207.2449976-2-irogers@google.com>
References: <20261023041819.2361900-1-irogers@google.com>
 <20261023050207.2449976-1-irogers@google.com>
 <20261023050207.2449976-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 05:25:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf timechart: missing -a in LiveRecorder.start() breaks worklo=
ad timelines
- [Medium] perf timechart: backward prev.since reset in sched_switch() corr=
upts totals
- [Medium] perf timechart: unsynchronized concurrent teardown in LiveRecord=
er.stop()
--

commit 154f81d15ad61319be3006e45c11ac5951330583
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf timechart: Add a --live mode to the TUI

This commit adds a --live option to perf timechart and ttimechart.py to
record scheduler, power, or I/O events with perf record and display the
most recent window of events interactively in the terminal UI.

> diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimecha=
rt.py
> index 34ecf84e68c1d..168f64c6b0fec 100755
> --- a/tools/perf/python/ttimechart.py
> +++ b/tools/perf/python/ttimechart.py

[ ... ]

> @@ -363,9 +524,14 @@ class TimechartData:
>          if c.cur_tid =3D=3D -1 and prev_tid !=3D 0:
>              # Assume the task was running from the start of the trace.
>              c.cur_tid =3D prev_tid
> -            c.since =3D self.first_time
> +            c.since =3D self.state_start()
>          if c.cur_tid > 0:
>              c.run.add(c.since, time, 1, c.cur_tid)
> +            if c.cur_tid !=3D prev_tid:
> +                # The switch away from the task that was running was los=
t.
> +                old =3D self.tasks.get(c.cur_tid)
> +                if old and old.state =3D=3D STATE_RUNNING and old.cpu =
=3D=3D cpu:
> +                    old.change_state(time, STATE_UNKNOWN)
>          c.cur_tid =3D next_tid
>          c.since =3D time
> =20
> @@ -373,7 +539,7 @@ class TimechartData:
>              prev =3D self.task(prev_tid, prev_comm)
>              if prev.state =3D=3D STATE_UNKNOWN:
>                  prev.state =3D STATE_RUNNING
> -                prev.since =3D self.first_time
> +                prev.since =3D self.state_start()
>                  prev.cpu =3D cpu

[Severity: Medium]
Can resetting prev.since to self.state_start() in
TimechartData.sched_switch() move prev.since backwards before existing
segments and corrupt Task.totals[STATE_RUNNING]?

When c.cur_tid !=3D prev_tid above, a previously running task old is
transitioned to STATE_UNKNOWN via old.change_state(time, STATE_UNKNOWN),
which appends a segment ending at time (old.segs.ends[-1] =3D=3D time) and =
sets
old.since =3D time.

If that task's subsequent switch-in event is also missed and the task is
next seen switching out as prev_tid at time2 > time while still in
STATE_UNKNOWN, setting prev.since =3D self.state_start() moves prev.since
backwards to self.state_start() < prev.segs.ends[-1].

When prev.change_state(time2, new_state) then runs:

    if self.state in (STATE_RUNNING, STATE_WAITING, STATE_BLOCKED) and time=
 > self.since:
        self.segs.add(self.since, time, self.state, self.cpu)
        self.totals[self.state] +=3D time - self.since

SegmentList.add() clips start to self.ends[-1] (time), so the added segment
has length (time2 - time), but Task.change_state() adds the unclipped
(time2 - self.state_start()) to self.totals[STATE_RUNNING]. When
Task.prune() later discards that segment, it only subtracts (time2 - time),
leaving self.totals[STATE_RUNNING] permanently inflated by
(time - self.state_start()).

Should prev.since be set to max(prev.since, self.state_start()) here?

[ ... ]

> @@ -1727,52 +2178,358 @@ class TimechartApp(App):
>          self.goto_task(waker, wake_time)
> =20
> =20
> +class LiveRecorder:

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
> +            # Without a workload record the whole system until stopped.
> +            cmd +=3D ["--", *self.workload] if self.workload else ["-a"]

[Severity: Medium]
Does omitting -a in LiveRecorder.start() when self.workload is specified
break task, CPU, and power timelines for the recorded workload?

Unlike timechart__record() and timechart__io_record() in
tools/perf/builtin-timechart.c, which always pass -a, LiveRecorder.start()
omits -a when a workload is given. That causes perf record to open
sched:sched_switch, sched:sched_wakeup, sched:sched_wakeup_new,
power:cpu_idle, and power:cpu_frequency as per-task events attached only to
the workload tasks.

In the kernel's __schedule() in kernel/sched/core.c:

    trace_sched_switch(preempt, prev, next, prev_state);

    /* Also unlocks the rq: */
    rq =3D context_switch(rq, prev, next, &rf);

trace_sched_switch() runs before context_switch() activates next's per-task
perf_event_context, and TRACE_EVENT(sched_switch) does not target next via
__perf_task(). As a result, per-task sched:sched_switch events only fire
when a workload task switches out as prev, and never when an untraced task
(such as swapper/idle or another process) switches into the workload task as
next.

In TimechartData.sched_switch(), when a workload task wakes up via
sched:sched_wakeup (which does use __perf_task(p)) or is preempted, its
state becomes STATE_WAITING. Because the subsequent switch-in from idle or
an untraced task is never recorded, task.state remains STATE_WAITING across
the entire CPU execution interval until the workload switches out, recording
its running time as STATE_WAITING instead of STATE_RUNNING and leaving
c.cur_tid on the Cpu object at 0 or at the previous untraced next_tid.

In addition, trace_cpu_idle() only runs in the idle task (PID 0), so
per-task recording on a workload captures no power:cpu_idle events, and
running perf timechart --live -P -- <workload> exits with "Error: no
scheduler, power or I/O events were recorded." if no CPU frequency change
occurs within the workload's own task context.

Should -a always be passed to perf record even when self.workload is
present?

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
> +        self.close_data_fds()
> +
> +    def close_data_fds(self) -> None:
> +        """Close the read ends of the data pipes.
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
Can concurrent calls to LiveRecorder.stop() from the UI thread and worker
thread race during teardown?

When quitting during live recording, TimechartApp.action_quit() (or
TimechartApp.on_unmount()) calls TimechartApp.cancel_loading() on the UI
thread:

    loading =3D self.loading
    if loading is not None:
        loading.cancelled =3D True
    if self.live:
        self.live.stop()

At the same time, the background worker in TimechartApp.record_events()
exits read_events() (either via LoadCancelled or when perf record closes the
pipe) and runs its finally block:

    finally:
        self.loading =3D None
        live.stop()

In LiveRecorder.stop(), both threads can concurrently inspect proc.poll()
and call proc.send_signal(), proc.wait(), and proc.kill() without
synchronization. If one thread reaps proc in wait() while the other calls
send_signal() or kill(), an uncaught ProcessLookupError can be raised.
Similarly, in LiveRecorder.close_data_fds(), self.tee_r and
self.proc.stdout.close() are accessed without self.fd_lock (unlike
LiveRecorder.close_control_fds()), allowing both threads to race on closing
the pipe file descriptors and buffered stdout stream.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023050207.2449=
976-1-irogers@google.com?part=3D1
