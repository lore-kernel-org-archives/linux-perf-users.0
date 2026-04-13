Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4130C371;
	Mon, 13 Apr 2026 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098435; cv=none; b=nJMz0XYZ4ycQWKZnNovMFZiCYeq+XSrDLvBpXduLrryoWRl0SumlZsBWzKMXUEMvQhUmRn2SM4mhmDa0vJ0x5fdvja/nN2a3IuhY0Yvo7WjtSnLBhirI9e0P5nKp7HCp8p3kY3MTB2rZXZjJB8K9cO6mONdb7Ru9Pau3u2G20Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098435; c=relaxed/simple;
	bh=YVI39lR3cV+40AZ9e6h8jfPlcy1NuTOPThf97w0qasI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyexufN2TtWBMvUBwXB6ptxn0noinvirNKICY961mQ1d2KKhjkzosKfc4nImlseL3uKSOd/r5J7tMK3ej+vVKKCAHmn+a15qs4arXN7RpRB72n6HhCJw220ZPt7GYf1vSUZC0kdX5XaQ4JNYu6xyryDjSTs4Zt8kV5dsy9Qgdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqWo1ukt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqWo1ukt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE75C2BCAF;
	Mon, 13 Apr 2026 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776098435;
	bh=YVI39lR3cV+40AZ9e6h8jfPlcy1NuTOPThf97w0qasI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqWo1uktMXm8MW7B8hPR1MNz4f2wPvPIGlcrXDczT8TzVOLlJj1D4nWW+dFdfp25G
	 mdYxuWslaWbnwnDpxG2wO7jgMDi6/xYblCfeBudZVSKvUAv1Kw/sMWaHEyVx8rkVn7
	 vnu39oN1s57vTXFSE8vcxCoZKYIwaCQH2P9okIxluIJnVBJ21L3F0Np0iRYDlc/bXj
	 LWGAWcBkI9T5LZGXVBve1B/5GBsMCB/yJdcw/Wrnijjs89g9AArxnekDimruOw3ge0
	 LOlFb1bfTsfSMs1S/tbSViykkSRjJSn8Suitxv/ZwEFUkPz8M6MfYWEqC/+X3lbNKi
	 pOeC3cvLAQKQg==
Date: Mon, 13 Apr 2026 09:40:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v10 00/29] perf tool: Add evsel to perf_sample
Message-ID: <ad0cfz-gUKea5bI8@google.com>
References: <20260411191710.524998-1-irogers@google.com>
 <20260412020833.641177-1-irogers@google.com>
 <adv8Ka16pvgVkm8R@google.com>
 <CAP-5=fVc-Ac09cnXYPUVcNwzHOqFod0v=-YjjDf_oVHvM7cHDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVc-Ac09cnXYPUVcNwzHOqFod0v=-YjjDf_oVHvM7cHDw@mail.gmail.com>

On Sun, Apr 12, 2026 at 05:52:57PM -0700, Ian Rogers wrote:
> On Sun, Apr 12, 2026 at 1:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Sat, Apr 11, 2026 at 07:08:03PM -0700, Ian Rogers wrote:
> > > Nearly all perf code ends up passing an evsel with the perf_sample,
> > > which is problematic if you want to rewrite the evsel such as with
> > > off-CPU processing - all uses of the evsel need fixing up. Previously
> > > I'd mailed this patch as an RFC with everything combined:
> > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> > > and there was a request to break it up.
> > >
> > > v10: Changes to some of the bounds checks as prompted by Sashiko.
> > >
> > > v9: Clean up some error path nits caught by Sashiko and simple bound
> > >     checks Sashiko recommended.
> > > https://lore.kernel.org/linux-perf-users/20260411191710.524998-1-irogers@google.com/
> > >
> > > v8: Fix address sanitizer issues with kwork and move patches, along
> > >     with bound check additions, to end of series.
> > > https://lore.kernel.org/linux-perf-users/20260411065718.372240-1-irogers@google.com/
> > >
> > > v7: Separate out kwork work->name to a strdup into its own patch, now patch 4.
> > > https://lore.kernel.org/linux-perf-users/20260408072601.210837-1-irogers@google.com/
> > >
> > > v6: Address more Sashiko feedback.
> > > https://lore.kernel.org/lkml/20260404034325.3172592-1-irogers@google.com/
> > >
> > > v5: Address feedback from Sashiko and Namhyung.
> > > https://lore.kernel.org/lkml/20260403204017.2919994-1-irogers@google.com/
> > >
> > > v4: Fix more sashiko issues: bounds checks, memory safety, making
> > >     refactors better, inconsistent evsels, mmap2 buildid injection
> > >     choice of evsel, mismatched function arguments.
> > > https://sashiko.dev/#/patchset/20260320080835.724836-1-irogers%40google.com
> > > https://lore.kernel.org/lkml/20260320192627.368357-1-irogers@google.com/
> > >
> > > v3: Fix various sashiko review comments particularly about unintended
> > >     behavior changes.
> > > https://lore.kernel.org/lkml/20260320080835.724836-1-irogers@google.com/
> > >
> > > v2: Add review feedback on the first 2 patches from Namhyung, fix a
> > >     missed evsel assignment running event2evsel in builtin-inject.
> > > https://lore.kernel.org/lkml/20260319232334.287517-1-irogers@google.com/
> > >
> > > v1: https://lore.kernel.org/lkml/20260209174032.4142096-1-irogers@google.com/
> > >
> > > Ian Rogers (29):
> > >   perf sample: Fix documentation typo
> > >   perf tool: Remove evsel from tool APIs that pass the sample
> > >   perf kvm: Don't pass evsel with sample
> > >   perf evsel: Refactor evsel tracepoint sample accessors perf_sample
> > >   perf trace: Don't pass evsel with sample
> > >   perf callchain: Don't pass evsel and sample
> > >   perf lock: Only pass sample to handlers
> > >   perf lock: Constify trace_lock_handler variables
> > >   perf hist: Remove evsel parameter from inc samples functions
> > >   perf db-export: Remove evsel from struct export_sample
> > >   perf hist: Remove evsel from struct hist_entry_iter
> > >   perf report: Directly use sample->evsel to avoid computing from
> > >     sample->id
> > >   perf annotate: Don't pass evsel to add_sample
> > >   perf inject: Don't pass evsel with sample
> > >   perf kmem: Don't pass evsel with sample
> > >   perf kwork: Don't pass evsel with sample
> > >   perf sched: Don't pass evsel with sample
> > >   perf timechart: Don't pass evsel with sample
> > >   perf trace: Don't pass evsel with sample
> > >   perf evlist: Try to avoid computing evsel from sample
> > >   perf script: Don't pass evsel with sample
> > >   perf s390-sample-raw: Don't pass evsel or its PMU with sample
> > >   perf evsel: Don't pass evsel with sample
> > >   perf kmem: Add bounds checks to tracepoint read values
> > >   perf sched: Bounds check CPU in sched switch events
> > >   perf timechart: Bounds check CPU
> > >   perf evsel: Add bounds checking to trace point raw data accessors
> > >   perf kwork: Fix address sanitizer issues
> > >   perf kwork: Fix memory management of kwork_work
> >
> > I've picked the first 23 patches to tmp.perf-tools-next as the rest
> > still has some issues.  Also I've touched some commits to either remove
> > some parts or split them into separate commits.
> >
> > Please take a look.
> 
> Hi Namhyung,
> 
> thanks for doing this but I've done a similar clean up. To totally
> separate the evsel refactoring from the rest of the changes, to fix
> the address sanitizer issues with kwork, etc. I'll incorporate your
> changes and then resend the series.

Thanks, I'd like to merge what's in the tmp.perf-tools-next unless
there's a serious mistake.  You can rebase the rest changes on top.

Thanks,
Namhyung

