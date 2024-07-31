Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0317543;
	Wed, 31 Jul 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447980; cv=none; b=DWr5u6B/qDV5dhPUEJ4QGEZWsM1pfukd9OrfpApn2DLjQpb3skulh6BR10an2Z1zstGpK0vfWs/3IYE22h1mNFZWYYDSJ1hmP0nQNmFHqKcHOgmmCUDrIsMxSoeHeIpNSNpavS/gx7IgOBY5Q3Pq1yRfFg0B6aCITuYE4pz9cyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447980; c=relaxed/simple;
	bh=mN4AzkHcZ8t5bi6d8byokj2Qx2ejqlM5/0spdzLu6AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sErXbTqZTrEzGi03O1tlkFG07/Y/gSJyIBmHGcJTUxIDxSClMsEU762wb1NRxJeYqGh6B1zhXHcQLJPywBYZq9+45dGOfvyjjD1TZOYm8oOYif5USDQfKrAcc3QW2VvYMmljaFhZY+GR71iUbUJsgjBjmC1TvTBoiUtf1whlG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb9TII54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb9TII54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA426C116B1;
	Wed, 31 Jul 2024 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722447980;
	bh=mN4AzkHcZ8t5bi6d8byokj2Qx2ejqlM5/0spdzLu6AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cb9TII5475M2bjHwyrbzr2NQWe6D/sCd4X0uwI55ofwuP1Gyu2XGjlpzr3+D8LLM/
	 J2i53JShqxTSSOh4dVG4AHa3hJI8mP7NJ0GckUhdmfVgPab+0F86Ow7uWetTlK32V+
	 7XO1bLHzzHQ9Wrw8NQwNe24fhZYtalOQi0DKtSNkCLntGbWTP5aO2xjSAkYj8283in
	 OeX/1ecuBxjw8BR1G+V58W1gkf4jBqSlgHOwA+oibTk3A7QSOU+5HV3YE7m/ai7ozs
	 xHsEu4hRneZUfQATNrgcWZAhJ8Cvpj+lLO+17v4RBYKW0Q3Ly8ScMLBIJgQIBHG2QY
	 LtwZuKZC+Tj4Q==
Date: Wed, 31 Jul 2024 10:46:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Dump off-cpu samples directly
Message-ID: <Zqp4aoqhPgW7AOQA@google.com>
References: <20240726102826.787004-1-howardchu95@gmail.com>
 <ZqbutBvHOJ0SPd64@google.com>
 <CAH0uvogRFE_gXhSQTbXJiu-Yj2b+H1U4K40bDOgwTFyTOtHFDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvogRFE_gXhSQTbXJiu-Yj2b+H1U4K40bDOgwTFyTOtHFDA@mail.gmail.com>

On Mon, Jul 29, 2024 at 11:24:47PM +0800, Howard Chu wrote:
> Hello Namhyung,
> 
> Thanks for reviewing this patch.
> 
> On Mon, Jul 29, 2024 at 9:21 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello Howard,
> >
> > On Fri, Jul 26, 2024 at 06:28:21PM +0800, Howard Chu wrote:
> > > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323
> > >
> > > Currently, off-cpu samples are dumped when perf record is exiting. This
> > > results in off-cpu samples being after the regular samples. This patch
> > > series makes possible dumping off-cpu samples on-the-fly, directly into
> > > perf ring buffer. And it dispatches those samples to the correct format
> > > for perf.data consumers.
> >
> > Thanks for your work!
> >
> > But I'm not sure we need a separate event for offcpu-time-direct.  If we
> > fix the format for the direct event, we can adjust the format of offcpu-
> > time when it dumps at the end.
> 
> Thank you and Ian for this advice, I'll do that.
> 
> >
> > Anyway, as far as I can see you don't need to fill the sample info in
> > the offcpu-time-direct manually in your BPF program.  Because the
> > bpf_perf_event_output() will call perf_event_output() which fills all
> > the sample information according to the sample_type flags.
> >
> > Well.. it'll set IP to the schedule function, but it should be ok.
> > (updating IP using CALLCHAIN like in off_cpu_write() is a kinda hack and
> > not absoluately necessary, probably I can get rid of it..  Let's go with
> > simple for now.)
> >
> > So I think what you need is to ensure it has the uncessary flags.  And
> > the only info it needs to fill is the time between the previous schedule
> > and this can be added to the raw data.
> 
> Sure thing, thank you. Other than the off-cpu duration, do you think
> we should collect the callchain as well?

I think the kernel will do that for you once you set the
SAMPLE_CALLCHAIN flag in the event attr.

Thanks,
Namhyung

> 
> This idea is great because it minimizes the data we need to transfer
> from kernel space to user space. But with this, the whole
> "full-fledged sample in BPF output" is not the case anymore, because
> we only take a couple of things(such as the time between the
> schedules) from the raw data. This idea is more like an extension of
> the sample data, I think it's interesting, will try to implement it.
> 
> Thanks,
> Howard
> >
> > Thanks,
> > Namhyung
> >
> > >
> > > Changes in v3:
> > >  - Add off-cpu-thresh argument
> > >  - Process direct off-cpu samples in post
> > >
> > > Changes in v2:
> > >  - Remove unnecessary comments.
> > >  - Rename function off_cpu_change_type to off_cpu_prepare_parse
> > >
> > > Before:
> > > ```
> > >      migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  ffffffff90d2e8aa record_times+0xa ([kernel.kallsyms])
> > >             perf  770116 [001] 27981.041375:          1    cycles:P:  ffffffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
> > >             perf  770116 [001] 27981.041377:          1    cycles:P:  ffffffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
> > >             perf  770116 [001] 27981.041379:      51611    cycles:P:  ffffffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
> > >      migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  ffffffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
> > >      migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  ffffffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])
> > >
> > > sshd  708098 [000] 18446744069.414584:     286392 offcpu-time:
> > >           79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
> > >           585690935cca [unknown] (/usr/bin/sshd)
> > > ```
> > >
> > > After:
> > > ```
> > >             perf  774767 [003] 28178.033444:        497           cycles:P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
> > >             perf  774767 [003] 28178.033445:     399440           cycles:P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
> > >          swapper       0 [001] 28178.036639:  376650973           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> > >          swapper       0 [003] 28178.182921:  348779378           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> > >     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time-direct:
> > >           7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> > >           7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> > >           7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
> > >           7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
> > >           7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> > >           7fff24e862d8 [unknown] ([unknown])
> > >
> > >
> > >     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time-direct:
> > >           7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> > >           7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> > >           7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
> > >           7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
> > >           7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> > >           7fff24e862d8 [unknown] ([unknown])
> > >
> > >
> > >          swapper       0 [000] 28178.463253:  195945410           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> > >      dbus-broker     412 [002] 28178.464855:  376737008           cycles:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
> > > ```
> > >
> > > Howard Chu (5):
> > >   perf record off-cpu: Add direct off-cpu event
> > >   perf record off-cpu: Dumping samples in BPF
> > >   perf record off-cpu: processing of embedded sample
> > >   perf record off-cpu: save embedded sample type
> > >   perf record off-cpu: Add direct off-cpu test
> > >
> > >  tools/perf/builtin-record.c             |   2 +
> > >  tools/perf/builtin-script.c             |   2 +-
> > >  tools/perf/tests/builtin-test.c         |   1 +
> > >  tools/perf/tests/shell/record_offcpu.sh |  29 +++++
> > >  tools/perf/tests/tests.h                |   1 +
> > >  tools/perf/tests/workloads/Build        |   1 +
> > >  tools/perf/tests/workloads/offcpu.c     |  16 +++
> > >  tools/perf/util/bpf_off_cpu.c           |  53 ++++++++-
> > >  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 143 ++++++++++++++++++++++++
> > >  tools/perf/util/evsel.c                 |  16 ++-
> > >  tools/perf/util/evsel.h                 |  13 +++
> > >  tools/perf/util/header.c                |  12 ++
> > >  tools/perf/util/off_cpu.h               |   1 +
> > >  tools/perf/util/record.h                |   1 +
> > >  tools/perf/util/session.c               |  23 +++-
> > >  15 files changed, 309 insertions(+), 5 deletions(-)
> > >  create mode 100644 tools/perf/tests/workloads/offcpu.c
> > >
> > > --
> > > 2.45.2
> > >
