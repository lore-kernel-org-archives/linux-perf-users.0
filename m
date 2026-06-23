Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAA3AB498;
	Tue, 23 Jun 2026 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194779; cv=none; b=PPKnKvqsgsW3Jz/QiArl7UD/ANTbqzHjFyvrcitoxHY3/J+Y5wbD6sdTc7OmQSXkV30w7FIatEFxutsVRkaOXfZ7G1nJPjvrDPzaIiuCg3bq2uW4wFJFD7YgEDGqdbBQod9Vx9zqbQPyAbqMaTBMDReZmWpMVy0MvUSHtRwFsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194779; c=relaxed/simple;
	bh=Mi+E53XlHsNCECOe4MYY+y5xjc7n1rZ/6tY33l4iPCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8ipBYLMCisGF6UfRQKm5k9mtE1O3jkbqoEp9IQw+jesnUKZyXeAfoXNfAL4ms8B4MV2STHr2VR+vlkm2zmsBqIlTjcUugc0IQY8jtgjqGrthhLEcZ6mzAGolEsQM2E3iv4+A6r7gr1Wofbdu6Dv2PpdFKjOkmIxVjBG46OYkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaJe2KfL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaJe2KfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96881F000E9;
	Tue, 23 Jun 2026 06:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782194774;
	bh=P/VcoxarpCvnN8n9tYenvyX9+N8fpxhGJUjj0zwSBfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kaJe2KfLEdANVXm5OQxShn0mJZ7E3KHm3WiFTRNiS9jnp5GxnCH3ybJaX2FxAyR0S
	 8z+JS31ChyNaMTrTJEygeNPuC9K47JvVmMBX3uaeDyhNe4N67fIjf4Mb2tRL3zeJlj
	 CGQIe58fOF8ALiZtP468KYiu7NAzL0qFZZNwl01a6jyWXa+GlSCYnDYDVi+FWf8rg3
	 u87xlVNyt2ReVyV0AIDPcQR9N42ysaM2s5oxgTNdtU6451MWPwgSlnq1YetjTOxSX3
	 Es7SkYAy1iuklGPRmaY9R67xTuIjOblDeEi31Sd/2iR0ReMBbhsligAO37yzX5Bjtu
	 3lg4KzFTD2I+Q==
Date: Mon, 22 Jun 2026 23:06:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, thomas.falcon@intel.com,
	tmricht@linux.ibm.com
Subject: Re: [PATCH v3 04/13] perf tests: Add robust record retry helper and
 use subsecond workloads
Message-ID: <ajoiVNOuDTzGxVDM@z2>
References: <20260616061404.41929-1-irogers@google.com>
 <20260616164819.370939-1-irogers@google.com>
 <20260616164819.370939-5-irogers@google.com>
 <ajMhklrFodxJmb2F@google.com>
 <ajPxqM3s0fGP4fFi@x1>
 <CAP-5=fVwvX01JpjJarBBYUnKwWmQ-1WKPBAj3ZDL9cwTCHvqpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVwvX01JpjJarBBYUnKwWmQ-1WKPBAj3ZDL9cwTCHvqpQ@mail.gmail.com>

On Mon, Jun 22, 2026 at 04:59:15PM -0700, Ian Rogers wrote:
> On Thu, Jun 18, 2026 at 6:25 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Jun 17, 2026 at 03:37:06PM -0700, Namhyung Kim wrote:
> > > On Tue, Jun 16, 2026 at 09:48:09AM -0700, Ian Rogers wrote:
> > > > Introduce `perf_record_with_retry` and `perf_record_cleanup` in a shared
> > > > library `tests/shell/lib/perf_record.sh` to prevent record test failures
> > > > caused by transient recording or workload delays.
> > > >
> > > > Update `record.sh`, `record_lbr.sh`, `pipe_test.sh`, `kvm.sh`, and
> > > > `stat_all_pfm.sh` to use this robust record retry logic. These tests now
> > > > start with very short durations (e.g. 0.01 seconds) and scale up if the
> > > > initial recording failed to capture samples, significantly improving test
> > > > execution speed on success while remaining resilient to slow systems.
> > > >
> > > > Assisted-by: Antigravity:gemini-3.1-pro
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > [SNIP]
> > > > @@ -60,22 +71,29 @@ test_kvm_stat() {
> > > >  test_kvm_record_report() {
> > > >     echo "Testing perf kvm record/report"
> > > >
> > > > -   echo "Recording kvm profile for pid ${qemu_pid}..."
> > > > -   # Use --host to avoid needing guest symbols/mounts for this simple test
> > > > -   # We just want to verify the command runs and produces data
> > > > -   # We run in background and kill it because 'perf kvm record' appends options
> > > > -   # after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
> > > > -   perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > > > -   rec_pid=$!
> > > > -   sleep 1
> > > > -   kill -INT "${rec_pid}"
> > > > -   wait "${rec_pid}" || true
> > > > +   local duration
> > > > +   local success=false
> > > > +   for duration in 1 2 4 8; do
> > > > +           echo "Recording kvm profile for pid ${qemu_pid} (duration ${duration}s)..."
> > > > +           rm -f "${perfdata}" "${perfdata}".old
> > > > +
> > > > +           perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > > > +           local rec_pid=$!
> > > > +           sleep ${duration}
> > > > +           kill -INT "${rec_pid}"
> > > > +           wait "${rec_pid}" || true
> > >
> > > Can this be just like below?
> > >
> > >               perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" sleep ${duration}
> >
> > Right, looks equivalent and simpler,
> >
> > I was making notes to address the flakiness that is making me use the
> > end summary of entries that fail (great feature) to run them in
> > isolation to check if they work that way, which most do :-\
> 
> Here is an explanation from antigravity (sorry I have some typing
> issues atm), but it comes down to how the command line is built up:
> 
>   Normally, we could just write:
> 
>     perf kvm --host record -p "qemuₚid" - o"{perfdata}" sleep
> ${duration}
> 
>   However, on Intel x86 architectures, if no  -e  option is supplied
> to  perf kvm record , it calls architecture-specific setup logic (
> __kvm_add_default_arch_event_x86() ) which automatically appends  "-e"
>  and  "cycles"  to the end of the  argv  array.
>   Because  perf record  option parsing stops at the first non-option
> (which is  "sleep" ), any arguments appended after the workload name
> are forwarded directly to the workload command. This turns the
> executed command into:
> 
>     sleep 1 -e cycles
> 
>   Which causes  sleep  to crash with:
>    sleep: invalid option -- 'e'
> 
> I'll revise this in v4 to be clearer, but we should probably also fix
> the option parsing issue.

Thanks for the explanation!  I found it's in the deleted comment.

Let me think about the option parsing issue.

Thanks,
Namhyung

