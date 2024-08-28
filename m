Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDB1AC890
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877588; cv=none; b=WqA/O3IVbEgoxfGHfe1mssmVHFfYDt0drwcfidFWfv8jhfL8LMnbYVP9r7HV1lMlPq9Hdnzmq9jp6zes0HxTfGRtv3sdj+GXWgB2rJsk0rxJ0TROT8zXMcMfoBRhGOqZ9hJnxoT4pRgo2OR4VDrpNyN1VWzlrJxzigictwyz27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877588; c=relaxed/simple;
	bh=tDchGxAlNcs3df/AxtPBcJgCizYcXOvwwJ+ZGHkYmOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlZLX6S+5YI/fD8LbDe9iJfrWfKv/ieOr/LWsXQw1UWc7WvZb57YdTOyHxofMvjS0c7m0wAhsIvUGUmmA6ppIjn1ojtgbsvfMepoWw00LW53BNdzQitYFDjxSNPpC5+38jRtlgY0q17Tcdtyp4stHzx3v8MpR/+K1EJ0ZADZUnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn/zqTb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn/zqTb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AEAC4CEC2;
	Wed, 28 Aug 2024 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724877587;
	bh=tDchGxAlNcs3df/AxtPBcJgCizYcXOvwwJ+ZGHkYmOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fn/zqTb2+fOA9MjVkNPgW9RvtWOwm8m/RxZtQlwEk1YPJcmyA1FMKH2O1RhriY1bv
	 s9M1r5x1zfneecpiv0mHrbEzdZIiOV+/RzGpQ7I0bzBF8vfJqno99o9fXVNKHDRG5a
	 GbhExxJNoOqvlJk8e9JWVUG/VV7c2JZahsHjg3HeWOMe6+H6VBdgtrCACqoHEInPmO
	 ugje39uaj+EWpLJPyS0qCOInqIxdKNA8bT5SweFIFC2WPDLItS0fyOn3Cke0kZ/H1B
	 3uEtHRvaQB4erd/PwWbfqkTR/rk9k05FDXG5mz0p0Z3eRSt3Zh9YJawH8RCeKvSf36
	 rabEwI+NS3oOQ==
Date: Wed, 28 Aug 2024 17:39:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
	mpetlan@redhat.com, irogers@google.com, atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
Message-ID: <Zs-LEEutfp0hkjh5@x1>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
 <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com>

On Wed, Aug 28, 2024 at 04:10:55PM +0200, Veronika Molnarova wrote:
> Ping

Since this v2 series came from you, we need to have your Signed-off-by
in Michael's patch, please provide them in response to this message.

I'm adding them tentatively to my local branch, but I need your public
confirmation to follow the rules.

- Arnaldo
 
> On 7/2/24 13:08, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Hello,
> > 
> > rebased the patches for the current perf-tools-next branch in v2 as it
> > was not applying.
> > 
> > Thanks for the notice,
> > Veronika
> > 
> > Michael Petlan (2):
> >   perf tests shell: Skip base_* dirs in test script search
> >   perf testsuite: Install perf-report tests
> > 
> > Veronika Molnarova (9):
> >   perf testsuite: Merge settings files for shell tests
> >   perf testsuite: Fix shellcheck warnings
> >   perf testsuite probe: Add test for blacklisted kprobes handling
> >   perf testsuite probe: Add test for basic perf-probe options
> >   perf testsuite probe: Add test for invalid options
> >   perf testsuite probe: Add test for line semantics
> >   perf testsuite: Add common output checking helper
> >   perf testsuite report: Add test for perf-report basic functionality
> >   perf testsuite report: Add test case for perf report
> > 
> >  tools/perf/Makefile.perf                      |   2 +
> >  tools/perf/tests/shell/base_probe/settings.sh |  48 -----
> >  .../base_probe/test_adding_blacklisted.sh     |  67 ++++++
> >  .../shell/base_probe/test_adding_kernel.sh    |   3 -
> >  .../perf/tests/shell/base_probe/test_basic.sh |  80 ++++++++
> >  .../shell/base_probe/test_invalid_options.sh  |  79 ++++++++
> >  .../shell/base_probe/test_line_semantics.sh   |  55 +++++
> >  tools/perf/tests/shell/base_report/setup.sh   |  32 +++
> >  .../shell/base_report/stderr-whitelist.txt    |   5 +
> >  .../tests/shell/base_report/test_basic.sh     | 190 ++++++++++++++++++
> >  .../shell/common/check_errors_whitelisted.pl  |  51 +++++
> >  tools/perf/tests/shell/common/init.sh         |  31 ++-
> >  tools/perf/tests/shell/common/settings.sh     |  28 ++-
> >  .../tests/shell/perftool-testsuite_report.sh  |  23 +++
> >  tools/perf/tests/tests-scripts.c              |   2 +
> >  15 files changed, 640 insertions(+), 56 deletions(-)
> >  delete mode 100644 tools/perf/tests/shell/base_probe/settings.sh
> >  create mode 100755 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> >  create mode 100755 tools/perf/tests/shell/base_probe/test_basic.sh
> >  create mode 100755 tools/perf/tests/shell/base_probe/test_invalid_options.sh
> >  create mode 100755 tools/perf/tests/shell/base_probe/test_line_semantics.sh
> >  create mode 100755 tools/perf/tests/shell/base_report/setup.sh
> >  create mode 100644 tools/perf/tests/shell/base_report/stderr-whitelist.txt
> >  create mode 100755 tools/perf/tests/shell/base_report/test_basic.sh
> >  create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.pl
> >  create mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh
> > 
