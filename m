Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38824306B22
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033193; cv=none; b=nY4hgcT4scWgwEUizdArwZr5x0Ht8XSfXs9xCc6rO527AI3KS+up4Ot6NIwcwUtTPuzkXprNBIrRpBse7i2TGjlRihROWx/6mb400zM+4SJzosmjwyEgcXR97csuX5QH2PRH26Ajg3qACMMFJwYPy+tLfJsNxm/jB/55BBjGsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033193; c=relaxed/simple;
	bh=/ak66Fqyjal2rJ4DrC6EBQbTSaJknE/hth1kaiHUZ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab8FZr6hcLszuDeRSdwtMT54m34c2G1dzhflo3PkL9Btprnz98d/Pp+hjE9s+AsAlzN6gzniN4E16fgXlbFYReS1C7Evv5gNDXDgQUsqwC0OFbGj+W9zv4t5POfDPsDN7f8lCL590HYEVlcOul0h3cNeO+1g/KyxVx28okirZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEU//ZVa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEU//ZVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C99C4CEEB;
	Tue, 16 Sep 2025 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033191;
	bh=/ak66Fqyjal2rJ4DrC6EBQbTSaJknE/hth1kaiHUZ/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hEU//ZVafuS1UiDgCEPL9MbJV4rj4AcaG5MItSGzKj9UpOk41RnZPjtDDudKile0O
	 Fxlzy33Fpaylq2bXqrvWleZOy74CXbLtn/YUchpLmfTsYEa2useL6PkWVqIDp2HEdW
	 515WN79faAJNUzi6PHKcohk0gi3Ww5F1BTzxCy8CXG6WdNYQdTS5dfx8Dhgbsc2SRB
	 CO//7rXJgqPV+VGFKU1hS4jiPhupXtblbMMb3Usz3I6Q+JVoX+FPoJrru+m2vN2jK5
	 vobNs8PGPu03VuARrU92ZI4QkVuT0N8XOFXl/qZ+dufYZvNEeeExDLl2a0yd+5GaoU
	 1Y8BO9nqmPgaA==
Date: Tue, 16 Sep 2025 11:33:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, namhyung@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: don't show comm/tid for regular syscalls for
 single-pid traces
Message-ID: <aMl1JSe9kuZpfVnA@x1>
References: <20250821165831.184569-2-ashelat@redhat.com>
 <CA+G8DhK4tqVLMdNhM-bfYSc_8C2PrYeOVEJnGOb2nomHsaAhNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G8DhK4tqVLMdNhM-bfYSc_8C2PrYeOVEJnGOb2nomHsaAhNg@mail.gmail.com>

On Thu, Sep 11, 2025 at 11:27:15AM -0400, Anubhav Shelat wrote:
> pinging
> 
> On Thu, Aug 21, 2025 at 12:59 PM Anubhav Shelat <ashelat@redhat.com> wrote:
> >
> > Previously when attaching perf trace to a specific pid the output would
> > look like this:
> >
> >          ? (         ): vest/616160  ... [continued]: clock_nanosleep())                                  = 0
> >      0.041 ( 0.013 ms): vest/616160 fstat(statbuf: 0xfffff2c60038)                                        = 0
> >      0.073 ( 0.008 ms): vest/616160 read(buf: 0x3bede330, count: 4096)                                    = 17
> >      0.090 (1000.095 ms): vest/616160 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0xfffff2c601d8) = 0
> >   1000.210 ( 0.136 ms): vest/616160 openat(dfd: CWD, filename: "/tmp/something.txt", flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) = 3
> >   1000.361 ( 0.004 ms): vest/616160 fstat(fd: 3, statbuf: 0xfffff2c60088)                                 = 0
> >   1000.375 ( 0.018 ms): vest/616160 write(fd: 3, buf: SOME TEST STRING\10, count: 17)                     = 17
> >   1000.395 ( 0.072 ms): vest/616160 close(fd: 3)                                                          = 0
> >   1000.476 (         ): vest/616160 exit_group()
> >
> > which would cause an error in the perftool-testsuite since the comm/tid
> > shouldn't be in trace lines for regular syscalls. With this change the
> > output looks like this:

But it is still appearing in some cases, no? The first one and the
exit_group() ones. Can you please try to make it be suppressed there as
well?

- Arnaldo

> >          ? (         ): vest/612038  ... [continued]: clock_nanosleep())                                  = 0
> >      0.039 ( 0.012 ms): fstat(statbuf: 0xfffff8e94cb8)                                        = 0
> >      0.069 ( 0.008 ms): read(buf: 0x3b997330, count: 4096)                                    = 17
> >      0.086 (1000.436 ms): clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0xfffff8e94e58) = 0
> >   1000.545 ( 0.136 ms): openat(dfd: CWD, filename: "/tmp/something.txt", flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) = 3
> >   1000.700 ( 0.006 ms): fstat(fd: 3, statbuf: 0xfffff8e94d08)                                 = 0
> >   1000.720 ( 0.024 ms): write(fd: 3, buf: SOME TEST STRING\10, count: 17)                     = 17
> >   1000.750 ( 0.073 ms): close(fd: 3)                                                          = 0
> >   1000.833 (         ): vest/612038 exit_group()
> >
> > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> > ---
> >  tools/perf/builtin-trace.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index fe737b3ac6e6..4cc38ee6aad9 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2955,11 +2955,17 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
> >         if (trace->summary_only || (ret >= 0 && trace->failure_only))
> >                 goto out;
> >
> > -       trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
> > -
> >         if (ttrace->entry_pending) {
> > +               if (trace->opts.target.pid) {
> > +                       if (trace->show_tstamp)
> > +                               printed = trace__fprintf_tstamp(trace, ttrace->entry_time, trace->output);
> > +                       if (trace->show_duration)
> > +                               printed += fprintf_duration(duration, duration_calculated, trace->output);
> > +               } else
> > +                       trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
> >                 printed = fprintf(trace->output, "%s", ttrace->entry_str);
> >         } else {
> > +               trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
> >                 printed += fprintf(trace->output, " ... [");
> >                 color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
> >                 printed += 9;
> > --
> > 2.50.1
> >
