Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB662F2E;
	Fri, 19 Sep 2025 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314752; cv=none; b=qXUlc6bC9T7KKydMYWH1PKcl5NP5sC/jAY93jauO5YPIxGX3URAduqk1QmmG32VDRBXbRbHG232i1cCzmoSrqXYiJSjAS8xQJAgKS1Lb71gAHuLPymfn9+4yCaTRMaW0fpCldFpk/bL1P/qChdHlusyP40gfuMQrmxKVOz8YNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314752; c=relaxed/simple;
	bh=/I/ElfEsESrKXvo/7SZWI8j2Df/vAwaq55/AlS3/VY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=logpXpykkN0trNvgpJqvItnHQrAdQOYYnMsnpHxPsHQItx1gWPAZfQZZtQf5lXteAXuy2+0qtaMdXc+ZeEDw8SGvzNdP5BSTSKHxY6D01ffKVC57pVHfOsw+mYNhCiAQyboYPW/p8oyKadduYU/PuPk7dSFkp+QSDriLZkmS3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSnOJpAo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSnOJpAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8757DC4CEF9;
	Fri, 19 Sep 2025 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758314751;
	bh=/I/ElfEsESrKXvo/7SZWI8j2Df/vAwaq55/AlS3/VY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSnOJpAodsk4rA1TXcuQxXubRHOL15jWUwmrqPmIEt2A/toBwU49MPpZKELByCvvE
	 dz4wey4/D+orhDcvwB1Tp68xECImxFuLW10vkl4f6blCQyfu7HfZNgmdDZmbOSd7fv
	 JD16R5+gSpPs1Z7LKTm+6VFNHw+5LZIvW+Q0w9RrnddxgzsLDFDUPuI8S8UNMgbhcw
	 z9K0vtWdiJpGIb5NEqhEIr1seTkAKwUP0TkL+f/HHvwPDZgDGeeoJPYrsbALVn9u3A
	 zD3eCNzy10pFCcNCGcJuPTrLTmegkVJnXtp4PfD+dNXBtl5aUCKMQIa4ZtxYOwbZZk
	 rVF0uLnCNHMBA==
Date: Fri, 19 Sep 2025 17:45:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Test fixes and debug logging
Message-ID: <aM3A-2kYse8nMP9K@x1>
References: <20250914182900.1960567-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914182900.1960567-1-irogers@google.com>

On Sun, Sep 14, 2025 at 11:28:56AM -0700, Ian Rogers wrote:
> Testing in a hypervisor guest showed some issues that these patches
> try to address, or improve the debug situation upon.
> 
> Ian Rogers (4):
>   perf test: Be tolerant of missing json metric none value
>   perf parse-events: Add debug logging to perf_event
>   perf test: Don't fail if user rdpmc returns 0 when disabled
>   perf stat-shadow: Display metric-only for 0 counters

Applied, but while checking before/after on a host, I see that these are
quite unstable:

root@x1:~# perf test -r10 linter
 94: perf stat CSV output linter                                     : FAILED!
 94: perf stat CSV output linter                                     : FAILED!
 94: perf stat CSV output linter                                     : FAILED!
 94: perf stat CSV output linter                                     : FAILED!
 94: perf stat CSV output linter                                     : FAILED!
 94: perf stat CSV output linter                                     : FAILED!
 94: perf stat CSV output linter                                     : FAILED!
 94: perf stat CSV output linter                                     : FAILED!
 94: perf stat CSV output linter                                     : FAILED!
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : FAILED!
 99: perf stat STD output linter                                     : FAILED!
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : FAILED!
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : FAILED!
root@x1:~#

root@x1:~# for a in $(seq 20) ; do perf test linter ; echo "------" ; done
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : FAILED!
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : FAILED!
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
 94: perf stat CSV output linter                                     : FAILED!
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
------
root@x1:~#

root@x1:~# uname -a
Linux x1 6.16.5-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Sep  4 16:37:21 UTC 2025 x86_64 GNU/Linux
root@x1:~# grep -m1 "model name" /proc/cpuinfo 
model name	: 13th Gen Intel(R) Core(TM) i7-1365U
root@x1:~#

All is well on AMD land:

root@number:~# perf test linter
 94: perf stat CSV output linter                                     : Ok
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
root@number:~# perf test -r 5 linter
 94: perf stat CSV output linter                                     : Ok
 94: perf stat CSV output linter                                     : Ok
 94: perf stat CSV output linter                                     : Ok
 94: perf stat CSV output linter                                     : Ok
 94: perf stat CSV output linter                                     : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 97: perf stat JSON output linter                                    : Ok
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : Ok
 99: perf stat STD output linter                                     : Ok
root@number:~# uname -a
Linux number 6.16.7-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Sep 11 17:46:54 UTC 2025 x86_64 GNU/Linux
root@number:~# grep -m1 "model name" /proc/cpuinfo 
model name	: AMD Ryzen 9 9950X3D 16-Core Processor
root@number:~#

acme@number:~/git/perf-tools-next$ git log --oneline -5
58c26aeac5132152 (HEAD -> perf-tools-next, perf-tools-next/tmp.perf-tools-next) perf stat-shadow: Display metric-only for 0 counters
f46533cc149e39bd perf test: Don't fail if user rdpmc returns 0 when disabled
9bb146fd8a342ae1 perf parse-events: Add debug logging to perf_event
64b3eae288bb4370 perf test: Be tolerant of missing json metric none value
0dc96cae063cbf9e perf build-id: Ensure snprintf string is empty when size is 0
acme@number:~/git/perf-tools-next$ sudo su -
root@number:~# perf -v
perf version 6.17.rc6.g58c26aeac513
root@number:~#

- Arnaldo
