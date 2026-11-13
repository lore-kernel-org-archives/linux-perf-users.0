Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528038;
	b=udesiQ09JMzT4Lz4mCtxgXpC4lh07N15XhCq2ffupgnV4Ne5j0bc3zbpMjpsDUiNYsYJ
	 cz6cI2ruoJhX21L3kYcDNhRY3C2wtdGhY9f+94/4wVRgnPj3LiqjXI5REzCT3YBiqnC6B
	 R5JBzb+aAm2maBavvj0iwz7ee1aifspMdA2v14lpPNpvWYUCWMioByYD0XJB8ft7sfdE2
	 4xTb8LRqCmevn5BHVrplvP1msGAPziva5btXNKTLotKjopC3j866r2Z6oKJusxobAp61s
	 JLxTU5K+J/YLFeGlLKsr4zTlARJMcM3A1BJiqbjVls1I+51/1V4ZvD1DOmSKM5v8MgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cp6xImvFmGrFAOpaPQ8hf+o9Oz+fHQB7kC4v8yWCyso=;
	b=Ou7fQLcU64RstKSV5AvIKE532wc29VqL2aJIoCYU1uVI+Gyo19mc22C/s+/XAB+iWjvg
	 jmoPX2u7g5jrtUwaSSZrMLG1moWNuvj1hUQUy2hzeGUUlUeS6Rijhx7nyHNxl5HSZ3K+r
	 jApImPUKb3TX9Mg1aT7I3SRxdlkLnivGfhge3hdkiGMN+vqz1qf7w5BPQ77Xg8w9+fN1q
	 5eDpgUaLG5om8uTUxwYyUuKBBfBJ5RRKb/eBajlDkYfGQZ5Eu8e9tFAst7x5lFZeiQMp8
	 VnhDJREw4iUT7xO4NX7ybs6eBr5hsECesdtF2gqTJapPPsFGuORbb4upOW93HfOhQZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSV3OsSF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BC606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSV3OsSF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21151F000C4;
	Fri, 13 Nov 2026 00:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794528038;
	bh=cp6xImvFmGrFAOpaPQ8hf+o9Oz+fHQB7kC4v8yWCyso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KSV3OsSFfEiTT+jqJkN1Nz+21GHzduFiYxOle/HLTKxTPvGTlqzzScEeN6nVwkPe1
	 HE4miGByRJCryvSKIQ6wGxHlTMlqKta1KgwFdkMs3FCKqyj8mzwwSlnG0mPFw+KfHA
	 BnfHc6xp/Dz+NnBNnEkOO+9/LsWxpr6bHfCmN0MV+AYKm87QjkKWwmQLPBeTMLe3FP
	 Vd4V4sYJRqM7kogm0tr1vMMsTP0YU8Wtk70KGRX+/coHrIy8Ul0PAXHpCOkdpMjxrh
	 0JdQmg7G+x7A6T8dqNM2cKsbGlPyz9S6x9LxPvVD8ZP5a0zlS5mFSmowhnTV0CZdGm
	 iWh7PGvI/8rCQ==
Message-ID: <sashiko-outbox-211971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] perf timechart: Add a --live mode to the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112233738.699031-2-irogers@google.com>
References: <20261023054952.2503540-1-irogers@google.com>
 <20261112233738.699031-1-irogers@google.com>
 <20261112233738.699031-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 00:00:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf timechart: unescaped quotes in syscall filter in
  LiveRecorder.start()
- [Low] perf timechart: unstarted control_thread.join() in
  LiveRecorder._stop()
--

commit 5178221692a3b293f71ade63d89dfc1258413569
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf timechart: Add a --live mode to the TUI

This commit adds a --live option to perf timechart and ttimechart.py that
runs perf record to stream scheduler, power, or I/O syscall events over a
pipe and displays a rolling window of recent activity in the TUI.

> diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimecha=
rt.py
> index d7ba0276a9fb4..c71afedb453ed 100755
> --- a/tools/perf/python/ttimechart.py
> +++ b/tools/perf/python/ttimechart.py

[ ... ]

> @@ -1726,52 +2210,630 @@ class TimechartApp(App):
>          self.goto_task(waker, wake_time)
> =20
> =20
> +class PerfPipeTracker:

[ ... ]

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
> +            self.wake_r, self.wake_w =3D os.pipe()
> +            os.set_blocking(self.wake_r, False)
> +            os.set_blocking(self.wake_w, False)
> +            ev_names =3D self.events()
> +            if any(name.startswith("syscalls:") for name in ev_names):
> +                own_comm =3D self.set_own_comm()
> +                # common_pid is a thread ID; matching comm excludes all =
threads
> +                # of this process, and $$ excludes the perf record proce=
ss that
> +                # replaces sh via exec.
> +                filt =3D (f'comm !=3D "{own_comm}" && common_pid !=3D $$=
' if own_comm else
> +                        f"common_pid !=3D {os.getpid()} && common_pid !=
=3D $$")
> +                ev_args =3D " ".join(
> +                    f'-e {shlex.quote(name)} --filter "{filt}"'
> +                    if name.startswith("syscalls:") else f"-e {shlex.quo=
te(name)}"
> +                    for name in ev_names
> +                )
> +                script =3D ('perf_exe=3D$1; ctl=3D$2; shift 2; '
> +                          'exec "$perf_exe" record -q -o - -R -c 1 -k mo=
no '
> +                          f'--synth=3Dtask --control "$ctl" {ev_args} -a=
 "$@"')
> +                cmd =3D ["/bin/sh", "-c", script, "sh", self.perf_exe, f=
"fd:{ctl_r},{ack_w}"]

[Severity: Medium]
Does /bin/sh strip the inner double quotes around own_comm when expanding
--filter "{filt}"?

When set_own_comm() succeeds, interpolating filt into --filter "{filt}"
produces --filter "comm !=3D "ttimechart:..." && common_pid !=3D $$", so the
shell removes the quotes around the comm string before execing perf
record. The kernel tracepoint filter parser requires string operands for
comm to be quoted and rejects the filter with -EINVAL, causing perf
timechart --live -I to fail on startup.

> +                if self.workload:
> +                    cmd +=3D ["--", *self.workload]
> +            else:
> +                # Quiet so that only errors are written to stderr, see e=
rror_text().
> +                cmd =3D [self.perf_exe, "record", "-q", "-o", "-", "-R",=
 "-c", "1", "-k", "mono",
> +                       "--synth=3Dtask", "--control", f"fd:{ctl_r},{ack_=
w}"]
> +                for name in ev_names:
> +                    cmd +=3D ["-e", name]
> +                # Record system wide, as timechart__record() does. Switc=
hes into a
> +                # task and idle states aren't seen by events following t=
asks. With
> +                # a workload, recording stops when it exits, otherwise w=
hen stopped.
> +                cmd.append("-a")
> +                if self.workload:
> +                    cmd +=3D ["--", *self.workload]
> +            self.origin =3D monotonic_ns()
> +            # A new session so that signals for the terminal aren't rece=
ived.
> +            self.proc =3D subprocess.Popen(cmd, stdin=3Dsubprocess.DEVNU=
LL, stdout=3Dsubprocess.PIPE,
> +                                         stderr=3Dself.stderr, pass_fds=
=3D(ctl_r, ack_w),
> +                                         start_new_session=3DTrue)
> +            assert self.proc.stdout
> +            proc_fd =3D self.proc.stdout.fileno()
> +            self.grow_pipe(proc_fd)
> +            self.tee_r, tee_w =3D os.pipe()
> +            self.pump_thread =3D threading.Thread(target=3Dself.pump,
> +                                                args=3D(proc_fd, tee_w, =
output),
> +                                                daemon=3DTrue)
> +            try:
> +                self.pump_thread.start()
> +            except BaseException:
> +                self.pump_thread =3D None
> +                os.close(tee_w)
> +                raise
> +            # Closed by the pump thread.
> +            output =3D None
> +            self.data_fd =3D self.tee_r
> +            self.grow_pipe(self.data_fd)
> +            self.control_thread =3D threading.Thread(target=3Dself.contr=
ol_loop, daemon=3DTrue)
> +            self.control_thread.start()
> +        except BaseException:
> +            self.stop()

[ ... ]

> +    def _stop(self) -> None:
> +        """Stop perf record and the threads, stop_lock must be held."""
> +        proc =3D self.proc
> +        if proc is not None and proc.poll() is None:
> +            try:
> +                proc.send_signal(signal.SIGINT)
> +                proc.wait(timeout=3D2)
> +            except subprocess.TimeoutExpired:
> +                # Kill the whole session so a workload isn't left runnin=
g.
> +                try:
> +                    os.killpg(proc.pid, signal.SIGKILL)
> +                except OSError:
> +                    pass
> +                proc.kill()
> +                proc.wait()
> +        if self.pump_thread and self.pump_thread is not threading.curren=
t_thread():
> +            self.pump_thread.join(timeout=3D1)
> +        if self.control_thread and self.control_thread is not threading.=
current_thread():
> +            self.control_thread.join(timeout=3D1)
> +        self.close_control_fds()
> +        self.close_wake_fds()
> +        self.close_data_fds()
> +        self.restore_own_comm()

[Severity: Low]
If self.control_thread.start() fails in LiveRecorder.start(), can
self.control_thread.join() here raise RuntimeError and skip the cleanup
that follows?

Unlike self.pump_thread, self.control_thread is not reset to None if
starting the thread raises an exception, so self.stop() -> self._stop()
attempts to join an unstarted thread and aborts before closing the pipe
file descriptors and restoring /proc/self/comm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112233738.6990=
31-1-irogers@google.com?part=3D1
