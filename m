Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792619943;
	b=GZig3j/SYmwKv3wYLeqinzs98ePeGKuB6BsUBUt0/mYZSqXBzn2xBWG9iNNinNK9+bDa
	 gSX4Jk7LfMN8wg70n3RXwTLeeSC2Z10FmGfbhjW4YOOtE+P8TQtqZz3VVNwYdkpRjbdyr
	 mnelp2xuD0YgfcztmdWVySNt2FVuHNAPv6dMAFBZuEqOMaVxR9XTl77OGBB/9IZQbCZkc
	 aJpfzCWtVwYjn3ZEheGafWRYOw4mZCcZ+cK0HXWMKHxltSPcmf6uUdWL7PQbYhVDL6ieJ
	 WauFziyy9yYZ5ewJD522RiWdF+Kw7Ud5RyZm3hytBlrRC373drA5CaqtaxJAK29pFyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619943;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=hnt5rpQ+dEQf/CxMlso7zrx05MX8Ig8of5Z8Xwbs3AE=;
	b=CxU87G5esUXLUd/f+0c+fRk21QNq2U3qT5V59VJlAB5apIEP/6wgxmqVtQNgAsVHht/o
	 ZL7o2WuknyAz+Gj5/MH1+oqX/Xa1W5+hF3wNcaLwLFNYGdP7xBGjFTXt3/wPSDuRzYVun
	 gZhwtK6HRD28bCOmi+z27l9eeZy+aRY9bVrte0nwOiZ2QQobA3c/NgbYGYNtkOj87w3zT
	 pbsIK8yzpZGXPRCA21Vj2DfuF+xjatxbPmFI5vpcoqEvhz+yTNB2zjBXt20CXfuYOixVE
	 2RdFGFdYYhreq3qdA/cE8Sr6dYlCZt8xUzm7RichAaeeI5+Hy76ml/KvFLOAwv2sg5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RWBl+/Wv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32A606A319;
	Wed, 21 Oct 2026 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWBl+/Wv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7591F000C1;
	Wed, 21 Oct 2026 21:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792619942;
	bh=hnt5rpQ+dEQf/CxMlso7zrx05MX8Ig8of5Z8Xwbs3AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RWBl+/WvDfXCk5/Md7UygAbHzxp4nETQVmSQH2tjd7bc6sMRiqMiDCH/uSA7+q0pU
	 Dk6oTmj8RpahtznEO4otKBDpW/V0eTATreBje0oxRbM0NoWX7IYjFCQ5hZyYM1HSm9
	 yb+hBGBpSI8X26H61aHdXbnMgGX0QeEvSB0fOgiaX0xUBsS8sNtst0zHljp+JpP5sp
	 0hx9MBmokW6rxWV4JNXYhffHKWoOwqPsirycFE4PdGrSH4RNcS4opLHljIgDtL2a88
	 X2bAoQHO91Z/ET9CpVyItTXVx/pv29yVjXcZ1CATzoE2ZE5Fekq8l01X7jGb95PTBs
	 Ps7EXIeEn7Gxw==
Date: Wed, 21 Oct 2026 18:58:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Francesco Nigro <nigro.fra@gmail.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	kan.liang@linux.intel.com, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v2] perf test: Add test for events re-armed with
 PERF_EVENT_IOC_REFRESH
Message-ID: <atk1o-g0alZNiKf_@x2>
References: <20261021141736.2414170-1-nigro.fra@gmail.com>
 <CAP-5=fVB1LWLfvXm97TpjjKL6037mHZW0GzuR94wSaOOoGR8_w@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVB1LWLfvXm97TpjjKL6037mHZW0GzuR94wSaOOoGR8_w@mail.gmail.com>

On Wed, Oct 21, 2026 at 10:33:42AM -0700, Ian Rogers wrote:
> On Wed, Oct 21, 2026 at 7:17 AM Francesco Nigro <nigro.fra@gmail.com> wrote:
> >
> > Open a sampling event with sample_period 1, re-arm it with
> > PERF_EVENT_IOC_REFRESH from its overflow signal handler, as
> > self-profilers such as async-profiler do, and check that each of 1000
> > events delivers a signal. One case uses a software event (page faults),
> > the other the syscalls:sys_enter_getppid tracepoint. The signal is a
> > real-time one, so overflows cannot be coalesced, and the page fault
> > buffer is marked MADV_NOHUGEPAGE so that each touched page faults once.
> >
> > The tracepoint case fails since
> > commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage"):
> > only the first overflow is delivered. The re-arming ioctl succeeds,
> > but the event count stays at 1. It passes on the parent commit. The
> > software case passes on both.
> >
> > The test was written with an AI coding assistant (Claude) from a
> > standalone reproducer; I reviewed it and ran it in QEMU on current
> > mainline, on that commit and on its parent.
> >
> > Link: https://github.com/async-profiler/async-profiler/issues/1813
> > Signed-off-by: Francesco Nigro <nigro.fra@gmail.com>
> 
> Thanks Francesco, testing locally I see a failure on  7.1.6:
> ```
> $ sudo /tmp/perf/perf test -v IOC_REFRESH
> Not taking turns using the perf mlock budget: nothing can exhaust it
> 20: Event re-armed with PERF_EVENT_IOC_REFRESH                        :
> 20.1: Software event                                                  : Ok
> ---- start ----
> test child forked, pid 187381
> 1000 events, count 1, 1 overflows (1 POLL_HUP), re-arm errno 0
> ---- end(-1) ----
> 20.2: Tracepoint event                                                : FAILED!
> 
> === Test Summary ===
> Passed main tests : 0
> Passed subtests   : 1
> Skipped tests     : 0
> Failed tests      : 1
> List of failed tests:
>   20.2: Tracepoint event
> ```
> I believe this is currently expected until the kernel is fixed, which
> is somewhat unfortunate. The code looks okay and the build isn't
> regressed.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks Francesco for writing the test!

Applied to perf-tools-next, for v7.4.

- Arnaldo
