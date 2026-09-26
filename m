Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3854446E1;
	Sat, 26 Sep 2026 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790455280; cv=none; b=u1A9aTJcJ/t4iIw5p7zc5x3XYgHuO/LIfswyVwPoS9cu5bau3S2dsNehvBA0ld48yrTX+pduFLeEX1ReKYjlrdR8DGrUSCUljJLUp2gxB9W2fGqt/Apw9PptjI+nWFLCqRDrTx/sGV/EDyk4cr3mq99/xKjQGcFB02I12idutV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790455280; c=relaxed/simple;
	bh=QVIPVvL40F0jH+TrImWX6f8Uu2T/ApnoUzuZrmCrUb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJy+DfHwopG8oLEWf5OqX5j7F0z0V8WR3KLak/mVdtf07YYaHDEgE7uB72SmdI9129Ro23nXYhBVhMm1yXusM4zJIUsSCS64SLW+b4e5y2eGop29gAruUVO0YWq2rkaEENALJ84kwgaiz7GnZSe0tFPSX99w98oahX17wSJ6eM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwHUWgv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwHUWgv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A841F000FF;
	Sat, 26 Sep 2026 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790455278;
	bh=0/Ue9aOV7GaX3/AYad1ce0pEPuS3AlPytYyapZ05/iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KwHUWgv9qKrEpjOG2/UQwzlDXjn9BIvaWckD42PitTfKSb7fCG+W5ESab+U9rtNXb
	 UGdWRMee1eJLflvvoNGeqeOTOh8hNZmHy8GC/nQjsr05L7JQRqmcR4r22HL+c3AyO0
	 ADvZAeoByDUsYPtksuutlsh6naMwVx/SbdMnGldLVgGI0Z/OezYiwlDcLIwPY8u9K8
	 MvNinBE2CKUmP4vg3ZJLhC+9lYjrp2Wv+phpVHffnKgbQC9k5KGVWFv9mlN5MNvvJh
	 0v8RVcC9WfKbjSJ9Fyf80zqCScZNMJDL1xCEuDC++6x55SzT0z+RuiD5GOxK3Uh8ME
	 tjEfHaHCjbIWg==
Date: Sat, 26 Sep 2026 22:41:14 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: alice.mei.rogers@gmail.com, james.clark@linaro.org, leo.yan@linux.dev,
	namhyung@kernel.org, adrian.hunter@intel.com,
	dapeng1.mi@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v4 00/49] perf: Complete transition to standalone Python
 scripts
Message-ID: <argt6raEAmM4e9PI@x2>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926062029.800743-1-irogers@google.com>

On Fri, Sep 25, 2026 at 11:19:27PM -0700, Ian Rogers wrote:
> The perf script command has historically supported running Python and Perl
> scripts by embedding libpython and libperl. That approach has several
> drawbacks:
>  - high overhead from constructing Python dictionaries for every event
>    (whether used by the script or not),
>  - complex build dependencies on specific Python/Perl libraries,
>  - threading and interpreter lifecycle complications from embedding the
>    interpreter inside perf,
>  - no unified model for standalone scripts such as ilist.py, treport.py,
>    tracepoint.py, and twatch.py.

So I applied it and tested on the containers, make -C tools/perf
build-test and 'perf test', that has some flakiness running the new
tests for these python scripts in parallel, nothing that prevents it
from being merged now tho:

=== Test Summary ===
Passed main tests : 146
Passed subtests   : 156
Skipped tests     : 28
Failed tests      : 13
List of failed tests:
   72: Test dwarf unwind
   88: daemon operations
  101: perf kvm tests
  111: perf record tests
  112: perf record sample filtering (by BPF) tests
  117: perf sched tests
  137: check-perf-trace python test
  138: compaction-times python test
  141: failed-syscalls-by-pid python test
  142: failed-syscalls python test
  144: futex-contention python test
  157: sctop python test
  159: stat-cpi python test
root@x2:~# perf test 72
 72: Test dwarf unwind                                                                                         : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
root@x2:~# perf test 88
 88: daemon operations                                                                                         : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
root@x2:~# perf test 101
101: perf kvm tests                                                                                            : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
root@x2:~# perf test 112 ; perf test 117 ; perf test 137 ; perf test 141 ; perf test 142 ; perf test 144 ; perf test 157; perf test 159
112: perf record sample filtering (by BPF) tests                                                               : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
117: perf sched tests                                                                                          : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
137: check-perf-trace python test                                                                              : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
141: failed-syscalls-by-pid python test                                                                        : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
142: failed-syscalls python test                                                                               : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
144: futex-contention python test                                                                              : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
157: sctop python test                                                                                         : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
159: stat-cpi python test                                                                                      : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
root@x2:~# uname -a
Linux x2 7.2.5-200.fc44.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Sep 11 15:11:05 UTC 2026 x86_64 GNU/Linux
root@x2:~# cat /etc/os-release
NAME="Fedora Linux"
VERSION="44 (Workstation Edition)"
RELEASE_TYPE=stable
ID=fedora
VERSION_ID=44
VERSION_CODENAME=""
PRETTY_NAME="Fedora Linux 44 (Workstation Edition)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:44"
DEFAULT_HOSTNAME="fedora"
HOME_URL="https://fedoraproject.org/"
DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora/f44/"
SUPPORT_URL="https://ask.fedoraproject.org/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT="Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=44
REDHAT_SUPPORT_PRODUCT="Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=44
SUPPORT_END=2027-05-19
VARIANT="Workstation Edition"
VARIANT_ID=workstation
root@x2:~#
