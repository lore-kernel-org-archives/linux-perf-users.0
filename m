Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12C28E59E;
	Wed, 28 May 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457320; cv=none; b=ULzxRsVmw/t5eR60OTpSk7sNDEHqdbBRx2ZyCWzDw7Fh4WtBLlumeu0leQ1WzEeAkI24sSOSh8MaX9m/fMlKNF/HfcJpSpi3nlimTVKyVQeK3r/33mMnbvPbBHGoK9oLdPzywLbimkrOkMlHkEF0Y0cF7Bumne8kTtZujNGdbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457320; c=relaxed/simple;
	bh=sXCVV6kdPgQbjpG0tMeOMWH6XXP1dpXHjjuJ3paPNsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0tk6CD6FrNQUs+iDbbChSDzSoHyAPWt1MXxuQgw4MxBSAgOxs1dcYT1KKX0z80ppFEpJcA3D1emIU90jtQ/6zhGTQKi9bWdJ6O33L5tW1eCmq4/rmAAciFNqxeLImcsHTRED5nt9gaZF6HhoM20TlC1L9/tPPnyIIb/HF4Bdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyxoTjOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyxoTjOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4961CC4CEE3;
	Wed, 28 May 2025 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748457319;
	bh=sXCVV6kdPgQbjpG0tMeOMWH6XXP1dpXHjjuJ3paPNsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EyxoTjOYzd2GBs/jjMwThPF5Jd3ZClDUvT3+7wSgJADitXdj0cnK2tsACSTRlwNj7
	 BF/2vi9mc/C4F/5New6v+8vKN86Zy2Qfl+rT9Ru8QfothPDJ3yOcTp9wZPnTIvo2Oe
	 e60IoR9IwQlvxhbTucbKQpHaaqpQ6DcXyKhIetLH2VQn5+jIwRXUl3CaUM/MSY2w/F
	 qCiw4I/uGpea6/6hZ+QNbCS5GgTH4e0HF4xfyqYzGE7UGmE3dw2aJYtu1B8izNfb+j
	 +FQHhIjf6Ww+Pk1RcZf/IsQ2vgNlxJCX08tQpuYQ2sEr5YsbVNMlFEgSLBZIJjj0kp
	 5H5rJxo9SEEjQ==
Date: Wed, 28 May 2025 11:35:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf test: Add AMD IBS sw filter test
Message-ID: <aDdXZJrPSJlCAcTs@google.com>
References: <20250524002754.1266681-1-namhyung@kernel.org>
 <960adb81-2c77-4e77-b685-b3f3005cb286@amd.com>
 <aDYlyY2UbBxcMb9f@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDYlyY2UbBxcMb9f@x1>

On Tue, May 27, 2025 at 05:51:21PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, May 24, 2025 at 03:17:13PM +0530, Ravi Bangoria wrote:
> > Hi Namhyung,
> > 
> > On 24-May-25 5:57 AM, Namhyung Kim wrote:
> > > The kernel v6.14 added 'swfilt' to support privilege filtering in
> > > software so that IBS can be used by regular users.  Add a test case in
> > > x86 to verify the behavior.
> > > 
> > >   $ sudo perf test -vv 'IBS software filter'
> > >   113: AMD IBS software filtering:
> > >   --- start ---
> > >   test child forked, pid 178826
> > >   check availability of IBS swfilt
> > >   run perf record with modifier and swfilt
> > >   [ perf record: Woken up 3 times to write data ]
> > >   [ perf record: Captured and wrote 0.000 MB /dev/null ]
> > >   [ perf record: Woken up 3 times to write data ]
> > >   [ perf record: Captured and wrote 0.000 MB /dev/null ]
> > >   [ perf record: Woken up 3 times to write data ]
> > >   [ perf record: Captured and wrote 0.000 MB /dev/null ]
> > >   [ perf record: Woken up 0 times to write data ]
> > >   [ perf record: Captured and wrote 0.000 MB /dev/null ]
> > >   check number of samples with swfilt
> > >   [ perf record: Woken up 3 times to write data ]
> > >   [ perf record: Captured and wrote 0.037 MB - ]
> > >   [ perf record: Woken up 3 times to write data ]
> > >   [ perf record: Captured and wrote 0.041 MB - ]
> > >   ---- end(0) ----
> > >   113: AMD IBS software filtering                                      : Ok
> > > 
> > > Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > 
> > A minor nit below ...
> > 
> > > +echo "check number of samples with swfilt"
> > > +
> > > +kernel_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^K)
> > 
> > "true" barely runs in userspace. So, many a times this "perf record"
> > generates no samples :)
> 
> Right, something else, maybe one of those workloads:
> 
> acme@number:~/git/perf-tools-next$ perf test --list-workloads
> noploop
> thloop
> leafloop
> sqrtloop
> brstack
> datasym
> landlock
> acme@number:~/git/perf-tools-next$
> 
> root@number:~# time perf record -e ibs_op/swfilt/u perf test -w sqrtloop
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.160 MB perf.data (3976 samples) ]
> 
> real	0m1.588s
> user	0m1.407s
> sys	0m0.161s
> root@number:~# perf script | wc -l
> 3976
> root@number:~#
> 
> But I'm applying the patch as is, we can replace the workload later.

Thanks, I can add some workload to create both kernel and user traffic.
I think the current workloads run in user space mostly.

Thanks,
Namhyung

