Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1E12CDBF
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575312; cv=none; b=npOqOcCJgeWqLQpC6k2BE57tchP2Fh/b639NFykOfUbczG0LpPL0ILPG4xSujjr79Rg3L/tjvaDg3qy21X3rvB1Q6aOpmJ0BboHdoHPvn3X5E8WnABQG4jPOEDhvs9n1iFhmm9cA+ydUG2UBgP/z3W6qFUE8kO6zvJrCPq8Nhfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575312; c=relaxed/simple;
	bh=Npf3NhRL7c1CD2/bCw5eVzzSy3huaUxt7Y1LpvyB08c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJsEyBtnVcP7CeO/f9yIKEfZTJI7axQCkdVg2uiMcodEIrzvr9IzU+Ehqsu9Pb1Eha2S9H3ih7aXmfHQsurA3p4g+zv6MFOICnHfbLgN3ipWFYqMcSauL/oCNBXkeUfuNRU1rDZgG7ljK1MqRy/+38qzs90Mt8j49mW9nkIcFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7NZpMJd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7NZpMJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC71C4CEC3;
	Tue, 22 Oct 2024 05:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575312;
	bh=Npf3NhRL7c1CD2/bCw5eVzzSy3huaUxt7Y1LpvyB08c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7NZpMJdKHpdtn7kmAxK30izqbSyY2t5W9mzE6ctcntIqAdBBCGu+rTpzKf0vGHGA
	 jo9qhqIMygm+uMhomA0BsScfSbeJLDTVTTmyTd94Kx6HMtFMJ9VWvRfAy/ppHUtM6X
	 xUpVnKgYfZ03tMsy72XCeOmi+KCg28ymjgVxSSBUcuWl5AvIR/u0Ev/kdgFEYDZVTE
	 2ea4DLOX9ObUX/6Qz4G5u4ws/HGKsrSXJPwj1JFIZ/lVzou5pukv3sJFsjLvcqw9uS
	 nag19euDFTnn46tq2mRmpLlQAypzY3SfmtzO+lAAJ63tGANSnO1wqB3I359BvkJ8dC
	 sPui40fkcZ4yw==
Date: Mon, 21 Oct 2024 22:35:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Using the perf python module with address sanitizer
Message-ID: <Zxc5jlkvV4D2MLv5@google.com>
References: <CAP-5=fVX4hOUq-Tni8ZRHcX6p3nrLuWaNTx8PvCU0sbaO=XvMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fVX4hOUq-Tni8ZRHcX6p3nrLuWaNTx8PvCU0sbaO=XvMA@mail.gmail.com>

On Thu, Oct 17, 2024 at 09:20:07AM -0700, Ian Rogers wrote:
> Hi,
> 
> I just wanted to capture/share the steps I used for getting the perf
> python module working with address sanitizer. The process isn't ideal
> so hopefully others can suggest improvements and possibly how we can
> make this more automatic in the build, or use for automated testing,
> etc.
> 
> To build perf with address sanitizer you add to the CFLAGS by passing to make:
> EXTRA_CFLAGS="-fsanitize=address"
> 
> However, this yields a python module that fails with an undefined symbol:
> ```
> $ perf test python -v
> --- start ---
> test child forked, pid 712715
> python usage test: "echo "import sys ; sys.path.insert(0,
> '/tmp/perf/python'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>  File "<stdin>", line 1, in <module>
> ImportError: /tmp/perf/python/perf.cpython-311-x86_64-linux-gnu.so:
> undefined symbol: __asan_option_detect_stack_use_after_return
> ---- end(-1) ----
> 18: 'import perf' in python                                         : FAILED!
> ```
> 
> To resolve this issue add "-shared-libasan" to the CFLAGS:
> EXTRA_CFLAGS="-fsanitize=address -shared-libasan"
> 
> The build needs to find (on x86) libclang_rt.asan-x86_64.so which for
> me on a Debian derived OS wasn't on the LD_LIBRARY_PATH. I found it
> with:
> ```
> $ dpkg -L libclang-rt-16-dev|grep libclang_rt.asan-x86_64.so
> /usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.asan-x86_64.so
> ```

I think we can use llvm-config like below.

  $ find $(llvm-config --libdir) -name libclang_rt.asan-$(uname -m).so
  /usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.asan-x86_64.so

Thanks,
Namhyung


> I then built with:
> ```
> $ LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/llvm-16/lib/clang/16/lib/linux
> make EXTRA_CFLAGS="-fsanitize=address -shared-libasan"
> ```
> 
> However, still using the module wasn't successful:
> ```
> $ LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/llvm-16/lib/clang/16/lib/linux
> perf test python -v
> --- start ---
> test child forked, pid 720500
> python usage test: "echo "import sys ; sys.path.insert(0,
> '/tmp/perf/python'); import perf" | '/usr/bin/python3' "
> ==720503==ASan runtime does not come first in initial library list;
> you should either link runtime to your application or manually preload
> it with LD_PRELOAD.
> ---- end(-1) ----
> 18: 'import perf' in python                                         : FAILED!
> ```
> 
> I resolved this with LD_PRELOAD but there is a leak sanitizer issue
> that doesn't relate to importing the perf module:
> ```
> $ LD_PRELOAD=/usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.asan-x86_64.so
> perf test python -v
> --- start ---
> test child forked, pid 720967
> python usage test: "echo "import sys ; sys.path.insert(0,
> '/tmp/perf/python'); import perf" | '/usr/bin/python3' "
> 
> =================================================================
> ==720971==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 13628 byte(s) in 6 object(s) allocated from:
>    #0 0x7fda504e8b42 in __interceptor_malloc
> (/usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.asan-x86_64.so+0xe8b42)
>    #1 0x4de57f in PyMem_RawMalloc build-static/../Objects/obmalloc.c:586:12
>    #2 0x4de57f in _PyObject_Malloc build-static/../Objects/obmalloc.c:2003:11
>    #3 0x4de57f in _PyObject_Malloc build-static/../Objects/obmalloc.c:1996:1
> 
> SUMMARY: AddressSanitizer: 13628 byte(s) leaked in 6 allocation(s).
> ---- end(-1) ----
> 18: 'import perf' in python
> ```
> 
> To clean that up I added "ASAN_OPTIONS=detect_leaks=0":
> ```
> $ LD_PRELOAD=/usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.asan-x86_64.so
> ASAN_OPTIONS=detect_leaks=0 perf test python -v
> 18: 'import perf' in python                                         : Ok
> ```
> 
> So somewhat convoluted but it is possible.
> 
> Thanks,
> Ian
