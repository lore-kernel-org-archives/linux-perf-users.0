Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7531A3A86
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Sep 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302806; cv=none; b=KpDtiq9jzTj9jnG8Ixyow3fjiRkIXB0JaYWkKxHG1xY7sTtTA3DgBnMKyjIxR+9yu4YG3CU5YzgwMaXynZp1AFHi+pL1GVlBTiWSAA8tEQDzPMSj5wrymWXfafSIzVIBYS508Z0o3cPKICBGwaYb9LY4DCRWCkGxoiUpp1Irg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302806; c=relaxed/simple;
	bh=C4dnQsyuiAjoGPXHd0sENzdetaRE2dLUj+/4dKwLoBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLnzAqj/1k7x+UttvmodOT6ecdYJJCon5SGNGUtZyk7m+gOtrfRUs7bGCQikixhHGm6QUFONZDk/gedHBfqC4ZH9LtU1Nrr3CzihAwQJdKJQORS+DEa8peh0L/klMznl/GUbFCP6NEQHy1uJ+YNmjZuqatRObS+ciYcxSsSKzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THuE/nFM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THuE/nFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CA3C4CEC2;
	Mon,  2 Sep 2024 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725302806;
	bh=C4dnQsyuiAjoGPXHd0sENzdetaRE2dLUj+/4dKwLoBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THuE/nFMo9YJVNXqvWwUi/IEQPLiciqUaEzmzQvmiHULRHJ+Bt5U0ndrXQJ6xWxWG
	 XxcOUmWTO4A8UnB7d4jUmVpC6VR/FEzIXamwlGiX1bMuecixLRzyciciyT7vJAT6SY
	 JINBqD767Y9NxtiINUH1JYO80aQ/AH3lePPNt3bhK6V0DS7Shv7cdE0FEB8TPG5ZBr
	 OJbA3QCilL2k9GSg928qb96ydN17G0FVxMvsYDL7+jxNGUBxGHAUkXCjD2sGG0jgcq
	 8/1q50WjrcnQ1dcI2OAeDlNtkbAG0TH81hg5GolxqnM/20HlOafUYDOVL/F8eVhkFK
	 TkvwkKiDYcJdQ==
Date: Mon, 2 Sep 2024 15:46:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
	mpetlan@redhat.com, irogers@google.com, atrajeev@linux.vnet.ibm.com,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
Message-ID: <ZtYIElLzMIzEVH9t@x1>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
 <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com>
 <Zs-LEEutfp0hkjh5@x1>
 <ZtHk6Tj7KioLRd10@x1>
 <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>
 <ZtXMRffIGVmjptcf@x1>
 <ZtXOrJdxvrI7Kk6n@x1>
 <b87e2c58-8696-48bc-92ca-93964917bf9a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87e2c58-8696-48bc-92ca-93964917bf9a@redhat.com>

On Mon, Sep 02, 2024 at 05:10:48PM +0200, Veronika Molnarova wrote:
> 
> 
> On 9/2/24 16:41, Arnaldo Carvalho de Melo wrote:
> > On Mon, Sep 02, 2024 at 11:31:36AM -0300, Arnaldo Carvalho de Melo wrote:
> >> On Mon, Sep 02, 2024 at 04:05:04PM +0200, Veronika Molnarova wrote:
> >>> On 8/30/24 17:27, Arnaldo Carvalho de Melo wrote:
> >>>> On Wed, Aug 28, 2024 at 05:39:48PM -0300, Arnaldo Carvalho de Melo wrote:
> >>>>> On Wed, Aug 28, 2024 at 04:10:55PM +0200, Veronika Molnarova wrote:
> >>>> So, is there some other knob to get further output from that FAIL case?
> >>>> Like the command that is failing? I'll try to take a look at the
> >>>> sources, but are you seeing this problem with what is in
> >>>> perf-tools-next/perf-tools-next?
> > 
> >>> Couldn't reproduce the issue on multiple systems. There is no further way
> >>> of getting more logs from the test case. The output of the failure is from
> >>> the regex checking when a line wasn't matched to any possible regex.
> >>> Looking at the test case "adding blacklisted function warn_thunk_thunk",
> >>> the failure is caused by command 'perf probe warn_thunk_thunk', which is
> >>> a blacklisted function taken from "/sys/kernel/debug/kprobes/blacklist".
> > 
> > root@x1:~# grep thunk_thunk /sys/kernel/debug/kprobes/blacklist
> > 0xffffffff97004af0-0xffffffff97004b20	warn_thunk_thunk
> > root@x1:~#
> > 
> > <SNIP>
> > 
> >> /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err:A function DIE doesn't have decl_line. Maybe broken DWARF?
> >> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err
> >> A function DIE doesn't have decl_line. Maybe broken DWARF?
> >> A function DIE doesn't have decl_line. Maybe broken DWARF?
> >> Probe point 'warn_thunk_thunk' not found.
> >>   Error: Failed to add events.
> >> root@x1:~#
> >> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted_list.log 
> >> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.log 
> >> root@x1:~#
> >>
> >> So is it just a matter of adding this output to the expected outputs?
> >> In test_adding_blacklisted.sh?
> > 
> > Did the patch below, now it passes, Ack?
> > 
> > root@x1:~# export PERFTEST_KEEP_LOGS=y
> > root@x1:~# perf test 88
> >  88: perftool-testsuite_probe                                        : Ok
> > root@x1:~#
> > 
> > Or am I missing the point? :-)
> > 
> > - Arnaldo
> 
> Yeah, that would fix the test case, the question is whether we should

I was lazy, but yeah, that thought crossed my mind, good thing you did
the due diligence and found that patch! Looking at it now.

> accept it as a possible output. Found some old patch that should have
> fixed the mentioned issue: 
> https://lore.kernel.org/all/20230628082337.1857302-3-georgmueller@gmx.net/

I updated Masami's e-mail to a more recent one, Masami-san, wdyt? Can I
have your opinion on the patch pointed out by Veronika?

Thanks in advance!

- Arnaldo
 
> > 
> > diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> > index b5dc10b2a73810b3..14290d08a4a96eaf 100755
> > --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> > +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> > @@ -42,7 +42,8 @@ REGEX_ERROR_MESSAGE="Error: Failed to add events."
> >  REGEX_INVALID_ARGUMENT="Failed to write event: Invalid argument"
> >  REGEX_SYMBOL_FAIL="Failed to find symbol at $RE_ADDRESS"
> >  REGEX_OUT_SECTION="$BLACKFUNC is out of \.\w+, skip it"
> > -../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
> > +REGEX_MISSING_DECL_LINE="A function DIE doesn't have decl_line. Maybe broken DWARF?"
> > +../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" "$REGEX_MISSING_DECL_LINE" < $LOGS_DIR/adding_blacklisted.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
> > 
