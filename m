Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F11FBCAD;
	Tue, 27 May 2025 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379084; cv=none; b=TiNDk+uxJUDCmiuajJoRnRq6wayxOsflLJEXQ+E9O175CPqLPWJwhNErzoNVsvalLHRLFZXhMi941UoKNOcbzLUzybrUusQx2Z1J2VG4isThpeXHdPlgnhQuGdrxwKlCDXMjruvetePSR6AsSLOpSCy4hdgH8EECKA9jCMHVqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379084; c=relaxed/simple;
	bh=rSmJ6ADFLH/wBcq8wOaVmnyHaDptWwFCFtJ0GNuh1KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4F8Gd833twZKluwwNszjLJxXON++mQPpuO0vH+XMbgCr+w9AQGH8eBIYlS/Ssz6J0CZO5AmIDo5n3e+oYd7PR7camcdIKlADLSeGWVAqphLXUmXS46UFbb0Z6Csq5Gb9QELNeHC/w6payxOTp5ylT9OKJVunLw1Lpb1AubNJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYlAVFij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYlAVFij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF917C4CEE9;
	Tue, 27 May 2025 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748379084;
	bh=rSmJ6ADFLH/wBcq8wOaVmnyHaDptWwFCFtJ0GNuh1KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYlAVFij615sG3//AtDlg5Mlw2SI2IHGjiMbc9uKWxdWdw/FkG0cRB3xCPOJO+4fV
	 me8Uzv7mH/CHkIAbi5IXrYj8OVy3AbeBvTQM9KGp6yizz+MVcFsg43zCx1CIK3lT+Q
	 H7H/5jrvYPRIC6g1W7T3avC0iBJRU5aQLA2/m7glhCso6GQzm+5bt9+kUUND9bGNrX
	 XGKZ577isIoxRul6aqY1qSmL+0/A8NYDKywkUYMz4U9EPjmBMYEuminMBg+UC6oHcz
	 aIdT9GbD5s3SqxTAk+H8gmBuM7wyHKjqDnGpFlZMKipiMMXyMI7OpmWkdO5mlAP2ac
	 CqijHSG+LaYoQ==
Date: Tue, 27 May 2025 17:51:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf test: Add AMD IBS sw filter test
Message-ID: <aDYlyY2UbBxcMb9f@x1>
References: <20250524002754.1266681-1-namhyung@kernel.org>
 <960adb81-2c77-4e77-b685-b3f3005cb286@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960adb81-2c77-4e77-b685-b3f3005cb286@amd.com>

On Sat, May 24, 2025 at 03:17:13PM +0530, Ravi Bangoria wrote:
> Hi Namhyung,
> 
> On 24-May-25 5:57 AM, Namhyung Kim wrote:
> > The kernel v6.14 added 'swfilt' to support privilege filtering in
> > software so that IBS can be used by regular users.  Add a test case in
> > x86 to verify the behavior.
> > 
> >   $ sudo perf test -vv 'IBS software filter'
> >   113: AMD IBS software filtering:
> >   --- start ---
> >   test child forked, pid 178826
> >   check availability of IBS swfilt
> >   run perf record with modifier and swfilt
> >   [ perf record: Woken up 3 times to write data ]
> >   [ perf record: Captured and wrote 0.000 MB /dev/null ]
> >   [ perf record: Woken up 3 times to write data ]
> >   [ perf record: Captured and wrote 0.000 MB /dev/null ]
> >   [ perf record: Woken up 3 times to write data ]
> >   [ perf record: Captured and wrote 0.000 MB /dev/null ]
> >   [ perf record: Woken up 0 times to write data ]
> >   [ perf record: Captured and wrote 0.000 MB /dev/null ]
> >   check number of samples with swfilt
> >   [ perf record: Woken up 3 times to write data ]
> >   [ perf record: Captured and wrote 0.037 MB - ]
> >   [ perf record: Woken up 3 times to write data ]
> >   [ perf record: Captured and wrote 0.041 MB - ]
> >   ---- end(0) ----
> >   113: AMD IBS software filtering                                      : Ok
> > 
> > Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> A minor nit below ...
> 
> > +echo "check number of samples with swfilt"
> > +
> > +kernel_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^K)
> 
> "true" barely runs in userspace. So, many a times this "perf record"
> generates no samples :)

Right, something else, maybe one of those workloads:

acme@number:~/git/perf-tools-next$ perf test --list-workloads
noploop
thloop
leafloop
sqrtloop
brstack
datasym
landlock
acme@number:~/git/perf-tools-next$

root@number:~# time perf record -e ibs_op/swfilt/u perf test -w sqrtloop
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.160 MB perf.data (3976 samples) ]

real	0m1.588s
user	0m1.407s
sys	0m0.161s
root@number:~# perf script | wc -l
3976
root@number:~#

But I'm applying the patch as is, we can replace the workload later.

- Arnaldo
