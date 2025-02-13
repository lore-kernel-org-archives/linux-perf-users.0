Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9128A2D4;
	Thu, 13 Feb 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473200; cv=none; b=iH61+tKMSTNC7GxMcPLtHLICwpro4HAooj/Lo79LjJZ7DD5YhTf5G0h26ay56Gbm8jCG2lDL5GZCL7F8VEk+8+7wIl1FNJbjXEXg3BRT7E0YUVBBVPSFnfwKV/XeUyTZzhX9Y6yEvSctyJ6kj/BvK6tQO48JNCGd63cZhcM1NUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473200; c=relaxed/simple;
	bh=8F9snmZrkpo7E1ldWFGNJm87w37VI6wK4eqE/ZTj7K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7fjza5wyHWiwA59rRXuXHF5nMfPoDFDOymY+MmVFPuLhzD3MCAkJqtX0zt4IxIwyoIRByS/XLg1jElTXjNAtV9p/l2wm0XIU9qa/7FTT+ZPhFepbhbLNu1nYKtIiBtdSl6h57ZwCxOOOzyNgBeCOOJWF1eU+p7HiP/Ib9oV270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxu6vReW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxu6vReW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC81C4CED1;
	Thu, 13 Feb 2025 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739473199;
	bh=8F9snmZrkpo7E1ldWFGNJm87w37VI6wK4eqE/ZTj7K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mxu6vReW3B1zY7C54rwbwgf3C+mD7Qr6mZRv6XrMp3iOaRPuACRP2ndXcsc+YkS1t
	 nJdAI2O12XZ+nC6ZgagLE3BVzprmVekVOSXu1gOPMk6fPlO8uvzEFVlcr6Ap5+AJp4
	 P8YtR0Ukubv0/ePKt5FtSAslNjLmalPTI8OQ/hXYjv25GzNabr0xw5hIDG8VjJRoEi
	 1qt7ApRfQnZ0ZbI104HACV6K4snhGl//seUcDg5RuQpe5a85ViHm3tmPhdbYNxOnLQ
	 U4c7Q44Yzwes+416NVq3Dl8V4GunuUdidjLaJj4qRG1l+SMFXj7dRq40wNbIhMSr+F
	 VZc7vCDBX1fnA==
Date: Thu, 13 Feb 2025 10:59:57 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
Message-ID: <Z65BLfBlWpvp2xr4@google.com>
References: <Z6v-mPJq6m61pFA4@google.com>
 <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
 <Z6zslLa8XM1ubwXj@google.com>
 <CAP-5=fUrzPvV3sD1_wMzQ7dF8xk3hL9_nkdS6toFjt7L+SRsgg@mail.gmail.com>
 <Z60nBQCetMzhRg5b@google.com>
 <CAP-5=fWG7JOmQhTa+OccOxSLhik6Du-qy9d90q-zhDTu0P=q3A@mail.gmail.com>
 <Z61OeArP-P-I5NjU@google.com>
 <CAP-5=fXTLBb1+PghPCraJQcXY518Jtt3AwPLpoXvjXErW79U5w@mail.gmail.com>
 <Z64wSRTXxC6CXey7@google.com>
 <CAP-5=fW3TsODN6+5WF8c8wBa+JYHZKqT5oMTq2MSg9XuSOx2jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW3TsODN6+5WF8c8wBa+JYHZKqT5oMTq2MSg9XuSOx2jA@mail.gmail.com>

On Thu, Feb 13, 2025 at 10:13:57AM -0800, Ian Rogers wrote:
> On Thu, Feb 13, 2025 at 9:47 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Feb 12, 2025 at 11:27:38PM -0800, Ian Rogers wrote:
> > > On Wed, Feb 12, 2025 at 5:44 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Wed, Feb 12, 2025 at 03:17:35PM -0800, Ian Rogers wrote:
> > > > > On Wed, Feb 12, 2025 at 2:56 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Feb 12, 2025 at 12:00:42PM -0800, Ian Rogers wrote:
> > > > > > > On Wed, Feb 12, 2025 at 10:46 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > It's not completely broken and works sometimes.
> > > > > > >
> > > > > > > No this is the definition of completely broken. If it only works
> > > > > > > sometimes then you can't use it, we can't put a test on it, there is
> > > > > > > no point in it. Even when it doesn't fail on perf_event_open, does it
> > > > > > > work for processes that start after /proc is scanned? No, it is
> > > > > > > completely broken.
> > > > > >
> > > > > > Ok, we have a different definition for it.  Let's ignore the imaginary
> > > > > > users of the broken features.  Have you added a test for this change?
> > > > > >
> > > > > > Anyway I've tested your change and found some issues:
> > > > > >
> > > > > > 1. It silently exited when BPF-skel is not built.  Better to put some
> > > > > >    messages at least.
> > > > > >
> > > > > >   $ sudo ./perf record -u $(id -u) -- sleep 1
> > > > > >
> > > > > > 2. Even with BPF-skel, perf record doesn't work well.  It did something
> > > > > >    but failed to get sample data for some reason.
> > > > > >
> > > > > >   $ sudo ./perf record -u $(id -u) -- sleep 1
> > > > > >   [ perf record: Woken up 1 times to write data ]
> > > > > >   [ perf record: Captured and wrote 0.045 MB perf.data ]
> > > > > >
> > > > > >    Oh, I think you now need to pass -a because it now works in
> > > > > >    system-wide mode and drops samples for other users.
> > > > >
> > > > > This is a pre-existing problem, no?
> > > >
> > > > No, it worked without -a in the past.  Please see my previous reply.
> > > > I think -u/--uid is one of the supported target in the perf tool (not
> > > > for the system call) and it used to disable system-wide mode if -u is
> > > > used at the same time.
> > >
> > > As I keep repeating the '-u' option has never worked in the past, it
> > > either early exited or missed recording new processes.
> >
> > I agree the early exit of existing process is a problem of '-u'.  But
> > I'm not sure it would miss all new processes.  IIUC '-u' is a shortcut
> > for '-p' with all processes belong to the user.  That means it'll have
> > perf_event with attr.inherit set then it can track new processes from
> > them.  Of course, there's a race between /proc scanning and process
> > creation so it will miss some.  But even '-p' has the same race.
> >
> > >
> > > The documentation for `perf record` is:
> > > ```
> > > ...
> > >        -a, --all-cpus
> > >           System-wide collection from all CPUs (default if no target
> > > is specified).
> > > ...
> > >        -u, --uid=
> > >           Record events in threads owned by uid. Name or number.
> > > ...
> > > ```
> > > So `-a` is implied without a target/workload but you are specifying a
> > > workload and `-u`. So do you want samples from the workload or from
> > > the user's processes? I can tell from your command line being sleep
> > > that you want it to imply `-a` but would that be true if it were a
> > > benchmark? For the benchmark case you probably don't want `-a`
> > > implied. If you specify `-p` and `-u` should the processes that don't
> > > match -u be sampled or are you expecting implicit system wide
> > > profiling now?
> >
> > I don't follow.  You cannot specify two targets at the same time.  If
> > you use -a and -u together currently, you will see:
> >
> >   $ perf record -a -u $(id -u)
> >   Warning:
> >   UID switch overriding SYSTEM
> >
> > And for -p and -u:
> >
> >   $ perf record -p 1 -u $(id -u)
> >   Warning:
> >   PID/TID switch overriding UID
> >
> > And specifying a target and a workload means it will profile the target
> > while the workload is running.
> >
> >   $ perf record -u $(id -u) -- sleep 1
> >
> > So the above command will profile all processes belong to me for 1
> > second.  As you're doing system wide for 1 second with below command.
> >
> >   $ perf record -a -- sleep 1
> >
> > You can change sleep with any other workload but it's not the target of
> > the profile unless it matches to the target specifically.
> >
> > >
> > > I agree the behavior in the patch series doesn't match the existing
> > > behavior, but I'm not sure the existing behavior agrees with the
> > > documentation nor working as expected. Having the `-u` not select
> > > system wide, as in the patch, seems to agree with the documentation
> > > better. You have specified a target workload/process/eventual pid and
> > > you want samples owned by the uid, why should you now start getting
> > > samples from other processes? With `-p` you wouldn't expect `-a` to
> > > suddenly get implied, I'm not sure it makes any more sense with any
> > > target/workload.
> >
> > As I said, the existing behavior doesn't imply system wide.  But your
> > change now requires it.
> 
> The existing behavior doesn't work. If we can't put a test on it, it
> doesn't work.

Ok, then I'd be happy to see a test case with this series.

> 
> I'm asking what should the behavior be? You are asking to match
> something that doesn't work, why? Pointing out warnings ignores my
> question, you just seem to be out to prove you can find fault with the
> patch series as-is.

Sorry if you felt that way.  I just pointed out the behavior changes in
the series.  You can freely use BPF filters if the condition is met.
Otherwise it can fallback to the existing behavior or at least fail with
a message explaining the situation and hopefully how to fix it.

> 
> The major use-case for `-u` I find being perf top and not perf record,
> largely because if you are trying to do perf record you are less
> tolerant to the brokeness that is the existing -u behavior. perf top
> doesn't have a workload and system wide is implied.

I agree it'd be useful to perf top more than perf record.  And it will
be run as root mostly so it should be good to go.  But that doesn't mean
you can leave perf record in a broken state.

> 
> Should the behavior be with -u to imply system wide or should it be a
> filter to the user's other options or should we scan /proc and have
> that brokenness again? The latter has been your expressed preference
> as you don't see -u as broken.

I think it's natural to imply system-wide.  And as I pointed out, it's
not (used to be) possible to mix -u with other target options.

But it now requires higher privilege and/or perf_event_paranoid.

Thanks,
Namhyung

> >
> > >
> > > > > > 3. With BPF-skel, non-root users will see this.
> > > > > >
> > > > > >   $ ./perf record -u $(id -u) -- sleep 1
> > > > > >   cannot get fd for 'filters' map
> > > > > >   failed to set filter "BPF" on event cycles:P with 13 (Permission denied)
> > > > > >
> > > > > >    I think it's confusing and better to tell user that you need to run
> > > > > >    'perf record --setup-filter pin' as root first.  But maybe due to the
> > > > > >    issue #2, you still need to run it as root.
> > >
> > > I think that is an okay addition to BPF filters in general. I'm wary
> > > of having patch series feature crept into requiring the entire tool
> > > being reimplemented.
> > >
> > > Thanks,
> > > Ian
