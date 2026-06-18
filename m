Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9C3859D4;
	Thu, 18 Jun 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789101; cv=none; b=uPbmpPr9W8vYaYSq/QuvWdQCTnc7dJY+k+/XnexCWC+z1DxSU/bzMWHfQ9SiVWzTX6OXGve4hY1C3f/iG/aiaqeT6nAzvud614pDGU14mXAK1ztNO3r5RuvTs7XCQXYR5YQbnGGPyEWiSopRU4DY0kZnyVCqSVTqbzPRQX67X7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789101; c=relaxed/simple;
	bh=feTRN1Nn8C2PTueTaY8TPy6u4zXsmlI9qiGC98fX0/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU0hwxTEurZ7Ih8gw42S5dZBOU/YYYLP042W2x/r/vtdXhfpcM20ghv2GG1NgvAy82oUjvWsX8Q07X6dRdCEzL556P+4LbcOcVq4r3BMRbgrbTdGKH4MjGLAfjH0rfFizfgWV3WZO4IVqm95MxhMf4+8MZnTmo3ho3+lc5hjed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0gy2oUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0gy2oUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F61C1F000E9;
	Thu, 18 Jun 2026 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781789100;
	bh=FaUO+EZBvv9klZ3q2dPQUUCXLMlCwpN8qQmGXn/BuvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d0gy2oUYOnbuLjcSqLY0OvzRSW+Od/sBXcOL34P5uYlScyiNGUwJChLNE+jk2Jkqy
	 bEvf7ld17IE6O7oX0/N3JGVLuQqC5WLPMHu+hfGrgKDae4OgM59DQee8snybtQqdmI
	 HyLcBdeaj26G4nFBVeTLeJ7AJKZmw0mZBFfbqUGEJQ6Ifmr/+UV+Xt1lkDFAalZlsP
	 yIDWink25W7wZjypHoEC0gCdX1Giyhm0TWAjKVGk8nMQ+6Rk1Ag4ANbexFPN3RHoir
	 DyhHpPultVZN44P4sxCo95pwddHajYgLOmxyqg6ok5aMgrEriwtYNuRT5jyBeQdxgj
	 uneRyjPiOArpA==
Date: Thu, 18 Jun 2026 10:24:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, thomas.falcon@intel.com,
	tmricht@linux.ibm.com
Subject: Re: [PATCH v3 04/13] perf tests: Add robust record retry helper and
 use subsecond workloads
Message-ID: <ajPxqM3s0fGP4fFi@x1>
References: <20260616061404.41929-1-irogers@google.com>
 <20260616164819.370939-1-irogers@google.com>
 <20260616164819.370939-5-irogers@google.com>
 <ajMhklrFodxJmb2F@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajMhklrFodxJmb2F@google.com>

On Wed, Jun 17, 2026 at 03:37:06PM -0700, Namhyung Kim wrote:
> On Tue, Jun 16, 2026 at 09:48:09AM -0700, Ian Rogers wrote:
> > Introduce `perf_record_with_retry` and `perf_record_cleanup` in a shared
> > library `tests/shell/lib/perf_record.sh` to prevent record test failures
> > caused by transient recording or workload delays.
> > 
> > Update `record.sh`, `record_lbr.sh`, `pipe_test.sh`, `kvm.sh`, and
> > `stat_all_pfm.sh` to use this robust record retry logic. These tests now
> > start with very short durations (e.g. 0.01 seconds) and scale up if the
> > initial recording failed to capture samples, significantly improving test
> > execution speed on success while remaining resilient to slow systems.
> > 
> > Assisted-by: Antigravity:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > @@ -60,22 +71,29 @@ test_kvm_stat() {
> >  test_kvm_record_report() {
> >  	echo "Testing perf kvm record/report"
> >  
> > -	echo "Recording kvm profile for pid ${qemu_pid}..."
> > -	# Use --host to avoid needing guest symbols/mounts for this simple test
> > -	# We just want to verify the command runs and produces data
> > -	# We run in background and kill it because 'perf kvm record' appends options
> > -	# after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
> > -	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > -	rec_pid=$!
> > -	sleep 1
> > -	kill -INT "${rec_pid}"
> > -	wait "${rec_pid}" || true
> > +	local duration
> > +	local success=false
> > +	for duration in 1 2 4 8; do
> > +		echo "Recording kvm profile for pid ${qemu_pid} (duration ${duration}s)..."
> > +		rm -f "${perfdata}" "${perfdata}".old
> > +
> > +		perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > +		local rec_pid=$!
> > +		sleep ${duration}
> > +		kill -INT "${rec_pid}"
> > +		wait "${rec_pid}" || true
> 
> Can this be just like below?
> 
> 		perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" sleep ${duration}

Right, looks equivalent and simpler,

I was making notes to address the flakiness that is making me use the
end summary of entries that fail (great feature) to run them in
isolation to check if they work that way, which most do :-\

- Arnaldo

> 
> Thanks,
> Namhyung
> 
> > +
> > +		if [ -e "${perfdata}" ] && \
> > +			perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
> > +			success=true
> > +			break
> > +		fi
> > +		echo "No samples or report failed, retrying..."
> > +	done
> >  
> > -	echo "Reporting kvm profile..."
> > -	# Check for some standard output from report
> > -	if ! perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
> > +	if [ "$success" = false ]; then
> >  		echo "Failed to report kvm profile"
> > -		perf kvm -i "${perfdata}" report --stdio 2>&1
> > +		perf kvm -i "${perfdata}" report --stdio 2>&1 || true
> >  		err=1
> >  		return
> >  	fi
