Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC71A2648
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Sep 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288176; cv=none; b=JH5OF+Ozo4cjT4SOLuUKKLbmf6ayO+Nu8i51Rf4eV84McSOiXO1jAVtCgNsX9hrS4DfGSbZZp2BFgk3SQGp0WaaEODE7ggo56B6gTGgiUsidRLa/G6KCHcmSepnThv1wbCWPVvt+O34KzoJPxx3Yw2r+onmGCnB3rx99xKuCpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288176; c=relaxed/simple;
	bh=mgbvWKuBHmhUIgeerphz2Rn3TXUOO/FvxA1mbVx615E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4Byw3uUzQOkt0JcMiRouwkJB2CZp+BHsjO+clyVjVVvox7jTByzWr6GpgUmyVIOzYtFRoLI+q/BSFQ4e11TpiKsgv2ePdz8jvk25cDoyaEGvu86qo6ZPnUKtTKD6ZmFARurCEfyYuhAi5fqd1Q23OKXPfL38dvGigR6eM06sMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPHmXe0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPHmXe0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E37CC4CEC2;
	Mon,  2 Sep 2024 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725288175;
	bh=mgbvWKuBHmhUIgeerphz2Rn3TXUOO/FvxA1mbVx615E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPHmXe0Ml+eEbDJ8Sd+8vCUR09uczKbis6Gext+SxkRA1HoRII8rzkyzF4Ge9iPOT
	 4puyZjAIxgT0BVDvb5QYDmjC03HhBekPIkAP5V6lXdqo+EzAsmLMW44uNHpRnpPXEr
	 AlItVHOeNTVabziea8lWeE/R4tuRIjJ6JF9hsyvB+MTRYeZtmZodWcefKb/OBdsLDA
	 piFb+R20tBH39axVnnUNYeTFwuqOy7+MP7TnmhJOOMyscpbJUhB4+vgxsn/+AOo4uj
	 9I/R+QlZFP6gObyI91m2kyBwLs+gQ1Y5az/DSxpo3eX+SDpUd0fXY2QJwFBQNNoubS
	 jNoSclPFpkpsQ==
Date: Mon, 2 Sep 2024 11:42:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
	mpetlan@redhat.com, irogers@google.com, atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
Message-ID: <ZtXO7HfRH2LMrrE8@x1>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
 <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com>
 <Zs-LEEutfp0hkjh5@x1>
 <ZtHk6Tj7KioLRd10@x1>
 <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>
 <ZtXMRffIGVmjptcf@x1>
 <ZtXOrJdxvrI7Kk6n@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtXOrJdxvrI7Kk6n@x1>

On Mon, Sep 02, 2024 at 11:41:52AM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 02, 2024 at 11:31:36AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Sep 02, 2024 at 04:05:04PM +0200, Veronika Molnarova wrote:
> > > On 8/30/24 17:27, Arnaldo Carvalho de Melo wrote:
> > > > On Wed, Aug 28, 2024 at 05:39:48PM -0300, Arnaldo Carvalho de Melo wrote:
> > > >> On Wed, Aug 28, 2024 at 04:10:55PM +0200, Veronika Molnarova wrote:
> > > > So, is there some other knob to get further output from that FAIL case?
> > > > Like the command that is failing? I'll try to take a look at the
> > > > sources, but are you seeing this problem with what is in
> > > > perf-tools-next/perf-tools-next?
> 
> > > Couldn't reproduce the issue on multiple systems. There is no further way
> > > of getting more logs from the test case. The output of the failure is from
> > > the regex checking when a line wasn't matched to any possible regex.
> > > Looking at the test case "adding blacklisted function warn_thunk_thunk",
> > > the failure is caused by command 'perf probe warn_thunk_thunk', which is
> > > a blacklisted function taken from "/sys/kernel/debug/kprobes/blacklist".
> 
> root@x1:~# grep thunk_thunk /sys/kernel/debug/kprobes/blacklist
> 0xffffffff97004af0-0xffffffff97004b20	warn_thunk_thunk
> root@x1:~#
> 
> <SNIP>
> 
> > /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err:A function DIE doesn't have decl_line. Maybe broken DWARF?
> > root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > A function DIE doesn't have decl_line. Maybe broken DWARF?
> > Probe point 'warn_thunk_thunk' not found.
> >   Error: Failed to add events.
> > root@x1:~#
> > root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted_list.log 
> > root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.log 
> > root@x1:~#
> > 
> > So is it just a matter of adding this output to the expected outputs?
> > In test_adding_blacklisted.sh?
> 
> Did the patch below, now it passes, Ack?
> 
> root@x1:~# export PERFTEST_KEEP_LOGS=y
> root@x1:~# perf test 88
>  88: perftool-testsuite_probe                                        : Ok
> root@x1:~#
> 
> Or am I missing the point? :-)

The logs continue to point out that problem:

root@x1:~# cat /tmp/perftool-testsuite_probe.Fu4/perf_probe/logs/adding_blacklisted.err 
A function DIE doesn't have decl_line. Maybe broken DWARF?
A function DIE doesn't have decl_line. Maybe broken DWARF?
Probe point 'warn_thunk_thunk' not found.
  Error: Failed to add events.
root@x1:~#
 
> - Arnaldo
> 
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> index b5dc10b2a73810b3..14290d08a4a96eaf 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> @@ -42,7 +42,8 @@ REGEX_ERROR_MESSAGE="Error: Failed to add events."
>  REGEX_INVALID_ARGUMENT="Failed to write event: Invalid argument"
>  REGEX_SYMBOL_FAIL="Failed to find symbol at $RE_ADDRESS"
>  REGEX_OUT_SECTION="$BLACKFUNC is out of \.\w+, skip it"
> -../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
> +REGEX_MISSING_DECL_LINE="A function DIE doesn't have decl_line. Maybe broken DWARF?"
> +../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" "$REGEX_MISSING_DECL_LINE" < $LOGS_DIR/adding_blacklisted.err
>  CHECK_EXIT_CODE=$?
>  
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
