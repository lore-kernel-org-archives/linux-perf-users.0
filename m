Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62019AD93
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527378; cv=none; b=Neckgax3Pj9JP9tiW2zwgmNdaGZHzbKtrIo2c1puUWn9LDcP81Z2HvcAAgYTm2e/IQlW+gsFS7fMu6nwIXSHOJ00kuVpzf916P9sV8Ew/KANrin68+8EFKNlW0q2kktz76yBEOFNYOe4JdYTnYgpmzjpjPBy40f3KWG733k0uNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527378; c=relaxed/simple;
	bh=1vSpzhHqnLTXZVMRU0RMV33jOz9cdPE1QNjAr/9wS5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFPyU865ee28U6oVrcEHnJRZQuu5w/hckYxR3aDX+nLHzVZV2CB3DRTBFJmygwyE2OH6v8kMaH/0Nc7o55cjWnTMq3nNCRG0ARzFhbHZfczZ2Ka7rZzNl80AlASfPloh3Ix1OpQVVGdPvXDLeKmM2nf9lfuBGnQ8OmhKmk31hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEdnDmEt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEdnDmEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2080C2BBFC;
	Thu, 27 Jun 2024 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719527378;
	bh=1vSpzhHqnLTXZVMRU0RMV33jOz9cdPE1QNjAr/9wS5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEdnDmEtPhhp/g13oHp7y03fOweT5+kct6Xo7VSKrTMmQGNRZPor1Y5H3CSP3VSZ3
	 CjmNuYWtaM2dKuyrx6kavzXaUQiqvKD4YiDyLUPkyHxRQargwb4lmIIiT8E+mPz/dy
	 UmqC6WsvTcJopeAypGEoelrXOx2ltImazx5HpNsnCWnOYp+3BwOMW6SLyMLgktZo9w
	 esLvm/IiiND0y+K9cPAGT9al90PCdglmdOZpg8nFcf5+iho5Tq4BZtKhCcflv7qkJW
	 NdMgtLvlUv40e3DSRiU71QDUelJZjFDhzkmALyxqV685HGNbQpmgXzsxSj/FNZgB7g
	 oYnLHOTZhNfqw==
Date: Thu, 27 Jun 2024 15:29:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, vmolnaro@redhat.com, acme@redhat.com,
	acme@kernel.org, irogers@google.com, atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: Re: [PATCH 00/11] perftool-testsuite 2nd batch
Message-ID: <Zn3n0JwfdfFdjbzj@google.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>

Hello,

On Mon, Jun 24, 2024 at 03:07:58PM +0200, Michael Petlan wrote:
> Hello,
> 
> posting a second batch of tests from perftool-testsuite [1], as a part
> of the testsuite upstreaming effort.
> 
> This batch brings several perf-probe tests ideated by Masami Hiramatsu 
> and a perf-report test.
> 
> We have also refactored settings files and fixed shellcheck warnings.
> 
> Finally, I have noticed that the scripts are run twice, once run by the
> driver (e.g. perftool-testsuite_*.sh) and once by perf-test's testsuite
> construction feature (that adds all executable shell scripts in all
> sub directories automatically). This is undesirable, so I have fixed
> it for now by skipping "base_*" dirs in the search. I see that this
> approach is not ideal, because the aim of the search seems to be to get
> rid of various test drivers, unify the way the tests are detected and
> run, while allowing them to be in subdirectories, like the Carsten
> Haitzler's coresight tests. However, I still think this is better
> solution that just having a pile of scripts without hierarchy that
> are grabbed and ordered into one-level queue of tests. Apart from
> allowing the tests to share some setup procedure, etc., is helps to
> keep the structure more clear.
> 
> A better design for future might be to have shell tests ordered in
> directories, such as
> 
>   # cd tests/shell/
>   # find . -name \*.sh
>   coresight/asm_pure_loop.sh
>   coresight/memcpy_thread_16k_10.sh
>   coresight/thread_loop_check_tid_10.sh
>   coresight/thread_loop_check_tid_2.sh
>   coresight/unroll_loop_thread_10.sh
>   base_probe/test_adding_kernel.sh
>   base_probe/test_adding_blacklisted.sh
>   base_probe/test_basic.sh
>   base_probe/test_invalid_options.sh
>   base_probe/test_line_semantics.sh
>   base_report/setup.sh
>   base_report/test_basic.sh
>   [...]  
> 
> The directories might also contain some "header" file that would
> bear the name of the parent testcase for all the tests inside it
> (e.g. "perf probe shell tests").
> 
> Then, no separate drivers would be needed, perf-test testsuite-
> creation mechanism would search for the shell scripts as it does
> now, but it would create multilevel structure with subtests,
> such as:
> 
>   97: perf probe shell tests
>   97:1: perf probe basic functionality
>   97:2: perf probe tests with arguments
>   97:3: perf probe invalid options handling
>   98: CoreSight tests
>   98:1: CoreSight / ASM Pure loop
>   98:2: CoreSight / Thread Loop ...
>   [...]
> 
> ... similar to how C-tests can be organized. In case there is
> a setup.sh file in such a subdirectory, it would be run too.
> With properly designed names, also tag-like (substring matching)
> approach could be used to select desired tests (i.e. to override
> the tree structure and pick tests related to some topic, no matter
> if they are in base_stat or base_record subdirectory).
> 
> This plan also counts with processing the current test scripts and
> possibly putting them to best matching place in the structure.
> 
> There is already a bunch of shell tests and I thinkg it might be
> good to organize them into a structure.
> 
> Thoughts and ideas are welcome.
> 
> Thanks and regards,
> 
> Michael

Thanks for the work, but it doesn't apply to the current
perf-tools-next.  Can you please rebase?

Thanks,
Namhyung

> 
> 
> [1] https://github.com/rfmvh/perftool-testsuite
> 
> 
> Michael Petlan (2):
>   perf tests shell: Skip base_* dirs in test script search
>   perf testsuite: Install perf-report tests
> 
> Veronika Molnarova (9):
>   perf testsuite: Merge settings files for shell tests
>   perf testsuite: Fix shellcheck warnings
>   perf testsuite probe: Add test for blacklisted kprobes handling
>   perf testsuite probe: Add test for basic perf-probe options
>   perf testsuite probe: Add test for invalid options
>   perf testsuite probe: Add test for line semantics
>   perf testsuite: Add common output checking helper
>   perf testsuite report: Add test for perf-report basic functionality
>   perf testsuite report: Add test case for perf report
> 
>  tools/perf/Makefile.perf                      |   2 +
>  tools/perf/tests/shell/base_probe/settings.sh |  48 -----
>  .../base_probe/test_adding_blacklisted.sh     |  65 ++++++
>  .../shell/base_probe/test_adding_kernel.sh    |   3 -
>  .../perf/tests/shell/base_probe/test_basic.sh |  78 ++++++++
>  .../shell/base_probe/test_invalid_options.sh  |  77 +++++++
>  .../shell/base_probe/test_line_semantics.sh   |  53 +++++
>  tools/perf/tests/shell/base_report/setup.sh   |  30 +++
>  .../shell/base_report/stderr-whitelist.txt    |   5 +
>  .../tests/shell/base_report/test_basic.sh     | 188 ++++++++++++++++++
>  .../shell/common/check_errors_whitelisted.pl  |  50 +++++
>  tools/perf/tests/shell/common/init.sh         |  31 ++-
>  tools/perf/tests/shell/common/settings.sh     |  28 ++-
>  .../tests/shell/perftool-testsuite_report.sh  |  23 +++
>  tools/perf/tests/tests-scripts.c              |   2 +
>  15 files changed, 627 insertions(+), 56 deletions(-)
>  delete mode 100644 tools/perf/tests/shell/base_probe/settings.sh
>  create mode 100755 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
>  create mode 100755 tools/perf/tests/shell/base_probe/test_basic.sh
>  create mode 100755 tools/perf/tests/shell/base_probe/test_invalid_options.sh
>  create mode 100755 tools/perf/tests/shell/base_probe/test_line_semantics.sh
>  create mode 100755 tools/perf/tests/shell/base_report/setup.sh
>  create mode 100644 tools/perf/tests/shell/base_report/stderr-whitelist.txt
>  create mode 100755 tools/perf/tests/shell/base_report/test_basic.sh
>  create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.pl
>  create mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh
> 
> -- 
> 2.43.0
> 
