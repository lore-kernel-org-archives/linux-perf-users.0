Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D5217F5D;
	Tue,  8 Apr 2025 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095722; cv=none; b=pVycT+VB75Ae7XFO1joF52Q9TocIYIk54hLep+SOOydzydNy5tG7hoZCYzlqNm1kWUgf5aqkCGRrFqzLCUT20zTgB+4bTdL5tP+EvSESmv/+OuLsqzLtOWB304XH4m5UvBjZPlINSRgQSrcIzNDY/2kT6mZsUHhqUBEev5dq4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095722; c=relaxed/simple;
	bh=+tfxm+SfKKlxKosdafiilbZqnnwKi8zzkXyQ0gko/Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4nzi8PIgMOtxE4YAhxMsbpGT8jqcpNg2UooheK2790PY0fQzoV4w6t614W0582kRLEdEziuznp00FsA2xaxBLVjK8rsql56w7ZlRM1WMTPOch5KmRAt3ir3IYmeeuDkBHVlXmGuDPdz7+Skvm4M9QownTMkH4zZl451tpjUBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn75adWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn75adWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0911C4CEE5;
	Tue,  8 Apr 2025 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744095722;
	bh=+tfxm+SfKKlxKosdafiilbZqnnwKi8zzkXyQ0gko/Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dn75adWC3cEK55T7bStyYazrChFs/opJjgJ9Vu1CVc9d4PdjDXQyCTc+m5kLOwcj3
	 GyH7OFcCo/ro4xH9Ha3fMltT0Rn2PCFBMISxWohcqj7fhpyPfMgHzdH4yrF1yElP2g
	 aa1P0MJ46gEnXdcPLZGtO0tdLhRVkeyMvGGrjn498sgQLm9G2AVqx4cq/S4UAc21gw
	 MyJpNM7ky4lLebVV+EqIV3Z/i6DVrNm+MIato4OKDwjIu0NfjtkcO4Z+wjXew2jseo
	 Oiy2Q/9y+WZw6hlyMlgZQIHyIHHJM2GWECxH8BJunquXQdGzJj9Nmqyev8mgj4LhQt
	 uj0KWwBjhXuEQ==
Date: Tue, 8 Apr 2025 00:02:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Fix inconsistent failures in perf trace's
 tests
Message-ID: <Z_TJ6NHZ1v4ucd8p@google.com>
References: <20250404041652.329340-1-howardchu95@gmail.com>
 <Z_AeswETE5xLcPT8@google.com>
 <CAH0uvoiOA654mB-gjWTM8TTtVh+c6DvfgD6dh6VWkxrj7prPAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoiOA654mB-gjWTM8TTtVh+c6DvfgD6dh6VWkxrj7prPAA@mail.gmail.com>

On Fri, Apr 04, 2025 at 07:12:26PM -0700, Howard Chu wrote:
> Hello,
> 
> On Fri, Apr 4, 2025 at 11:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Apr 03, 2025 at 09:16:52PM -0700, Howard Chu wrote:
> > > There are two failures that frequently occur in perf trace's tests. One
> > > is the failure of 'perf trace BTF general tests'; The other one is the
> > > failure of 'perf trace record and replay', which, when run independently,
> > > always succeeds.
> > >
> > > The root cause of the first failure, is that perf trace may give two types
> > > of output, depending on whether the comm of a process can be parsed, for
> > > example:
> > >
> > > mv/312705 renameat2(CWD, "/tmp/file1_VJOT", CWD, "/tmp/file2_VJOT", NOREPLACE) = 0
> > > :312774/312774 renameat2(CWD, "/tmp/file1_5YcE", CWD, "/tmp/file2_5YcE", NOREPLACE) = 0
> > >
> > > In the test, however, grep is always looking for the comm 'mv', which
> > > sometimes may not be present.
> > >
> > > The cause of the second failure is that 'perf trace BTF general tests'
> > > modifies the perf config, and because tests are run concurrently,
> > > subsequent tests use the modified perf config before the BTF general
> > > test can restore the original config. Mark the BTF general tests as
> > > exclusive will solve the failure.
> 
> Yeah, I was wrong — I now suspect it has something to do with two
> augmented_syscall BPF programs running at the same time. I noticed the
> offcpu test has '(exclusive)' too. Do you think it's a BPF triggering
> issue? Like, if test A is trying to capture the clock_nanosleep
> syscall and test B is also trying to capture it, could it be that A
> ends up capturing both calls while B gets nothing? Just asking before
> I dig in further. :)

I don't think that will happen.  I suspect it may have a timing issue
like two threads are racing to setup BPF for syscall tracing and
setting up the second thread's BPF will disable the first one for a
short amount of time.  And 'mv' runs very shortly so it finished while
it's disabled.  But it's just a wild guess.

Thanks,
Namhyung

> 
> >
> > I'm not sure if the config is the cause of the failure.  Also I don't
> > see it restored.
> >
> > IIUC the export only affects child processes from the current shell.
> > So other tests running in parallel won't see the config change.
> >
> > But still, there should be something to affect the behavior.  It's
> > strange to miss the task name in COMM record.
> 
> I can look into that too.
> 
> >
> > I also confirm that running the test serially fixes it.
> >
> > Thanks,
> > Namhyung
> 
> Thanks,
> Howard
