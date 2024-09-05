Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3518DF81
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563069; cv=none; b=AlhyRlP+yBli0lfpK58tI+2milsu4xMHPJI8qVK+1O3a3dNlN6RgsKtkdw0OXVz1JW30kImZ2N99onStsSDcAqDWkvkbTrccEdaqrP5vLPTBq1rRtPOa91wL8x5i6QuhwSjx4ump8sBhH9LLC5OlLukTOo8OhVrRNEPyf5rF7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563069; c=relaxed/simple;
	bh=zyUl7mRiH4TStBOepTUlw75QbE5V3RMGNMkmcEsuzCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm7xFmHcFA9scJVztvEPwRkhviAMFJOsuPr2MwUZKQTEM2+CzaH0tze5WiLTyGLdqGki5SpNqresFZFWUMvpPMIts00WEOKweb34Fu0IhSyEdvUBjiKn5OqytiatvRy4ev0G0Uw15SpaXsM95yjXz6INQgi2WV7xkqLXKDNafzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiEQ8sXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiEQ8sXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B382BC4CEC3;
	Thu,  5 Sep 2024 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563069;
	bh=zyUl7mRiH4TStBOepTUlw75QbE5V3RMGNMkmcEsuzCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiEQ8sXJpuiqcmhqQOkGkimlzuK6SbWc1UfD+gebcpTsaaWp3JOWvI+xDbN5btw/d
	 FgvXWpJGLgJF0QvbPKixaXTRIezCijmJequcz7ziylnLbVisoVUYv12UyE8cQRSO6W
	 kb/nGZPGMXG/OXvhNDs69iGzSxIq6tL3dUkOqcJovaF0JFKPT8HesWhg8M+/gPIfTj
	 6t3iVcCYGQZ9ONMXMkUOeRBOC7JNI53OwUP9qil4hTcu7b3zz4EC8oin5n5zNe9yIp
	 ido1EyaVGynhWOtM6hhj2NdmX24PX9LZoJR5GLdU8tJOZbpqQMjCpt5dtbsfW0lj/4
	 oeNzMTOgj7u4g==
Date: Thu, 5 Sep 2024 16:04:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Veronika Molnarova <vmolnaro@redhat.com>,
	linux-perf-users@vger.kernel.org, acme@redhat.com,
	namhyung@kernel.org, mpetlan@redhat.com, irogers@google.com,
	atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
Message-ID: <ZtoAuoFNF8neYA-4@x1>
References: <20240702110849.31904-1-vmolnaro@redhat.com>
 <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com>
 <Zs-LEEutfp0hkjh5@x1>
 <ZtHk6Tj7KioLRd10@x1>
 <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>
 <ZtXMRffIGVmjptcf@x1>
 <ZtXOrJdxvrI7Kk6n@x1>
 <b87e2c58-8696-48bc-92ca-93964917bf9a@redhat.com>
 <ZtYIElLzMIzEVH9t@x1>
 <20240906001104.9314082caaf0268f09cc45b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240906001104.9314082caaf0268f09cc45b2@kernel.org>

On Fri, Sep 06, 2024 at 12:11:04AM +0900, Masami Hiramatsu wrote:
> On Mon, 2 Sep 2024 15:46:42 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Mon, Sep 02, 2024 at 05:10:48PM +0200, Veronika Molnarova wrote:
> > > On 9/2/24 16:41, Arnaldo Carvalho de Melo wrote:
> > > > On Mon, Sep 02, 2024 at 11:31:36AM -0300, Arnaldo Carvalho de Melo wrote:
> > > >> On Mon, Sep 02, 2024 at 04:05:04PM +0200, Veronika Molnarova wrote:
> > > >>> On 8/30/24 17:27, Arnaldo Carvalho de Melo wrote:
> > > >>>> On Wed, Aug 28, 2024 at 05:39:48PM -0300, Arnaldo Carvalho de Melo wrote:
> > > >>>>> On Wed, Aug 28, 2024 at 04:10:55PM +0200, Veronika Molnarova wrote:
> > > >>>> So, is there some other knob to get further output from that FAIL case?
> > > >>>> Like the command that is failing? I'll try to take a look at the
> > > >>>> sources, but are you seeing this problem with what is in
> > > >>>> perf-tools-next/perf-tools-next?

> > > >>> Couldn't reproduce the issue on multiple systems. There is no further way
> > > >>> of getting more logs from the test case. The output of the failure is from
> > > >>> the regex checking when a line wasn't matched to any possible regex.
> > > >>> Looking at the test case "adding blacklisted function warn_thunk_thunk",
> > > >>> the failure is caused by command 'perf probe warn_thunk_thunk', which is
> > > >>> a blacklisted function taken from "/sys/kernel/debug/kprobes/blacklist".
> > > > 
> > > > root@x1:~# grep thunk_thunk /sys/kernel/debug/kprobes/blacklist
> > > > 0xffffffff97004af0-0xffffffff97004b20	warn_thunk_thunk
> > > > root@x1:~#
> 
> right, thunk functions should not be probed.
> 
> > > > <SNIP>
> > > > 
> > > >> /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err:A function DIE doesn't have decl_line. Maybe broken DWARF?
> > > >> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err
> > > >> A function DIE doesn't have decl_line. Maybe broken DWARF?
> > > >> A function DIE doesn't have decl_line. Maybe broken DWARF?
> > > >> Probe point 'warn_thunk_thunk' not found.
 
> Yeah, thunk functions are defined by asm code. No DWARF is available.

Sure, but then, how would that be detected by the test?

To recap, the
./tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh test
does:

# skip if not supported
BLACKFUNC=`head -n 1 /sys/kernel/debug/kprobes/blacklist 2> /dev/null | cut -f2`
if [ -z "$BLACKFUNC" ]; then
        print_overall_skipped
        exit 0
fi

# remove all previously added probes
clear_all_probes


### adding blacklisted function

# functions from blacklist should be skipped by perf probe
! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $LOGS_DIR/adding_blacklisted.err
PERF_EXIT_CODE=$?

REGEX_SCOPE_FAIL="Failed to find scope of probe point"
REGEX_SKIP_MESSAGE=" is blacklisted function, skip it\."
REGEX_NOT_FOUND_MESSAGE="Probe point \'$BLACKFUNC\' not found."
REGEX_ERROR_MESSAGE="Error: Failed to add events."
REGEX_INVALID_ARGUMENT="Failed to write event: Invalid argument"
REGEX_SYMBOL_FAIL="Failed to find symbol at $RE_ADDRESS"
REGEX_OUT_SECTION="$BLACKFUNC is out of \.\w+, skip it"
../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
CHECK_EXIT_CODE=$?


So it _tries_ to probe blacklisted functions and check what is that the
tooling does when asked to probe things it shouldn't probe.

So, I proposed that if we get that error message (A function DIE doesn't
have decl_line. Maybe broken DWARF?) we should skip it, but Veronika did
the right thing and asked if that wasn't really papering over some
problem and pointed to a patch that addressed a problem that lead to
that exact same message being produced, but that didn't help with our
current case, with another blacklisted function, warn_thunk_thunk.

You mentioned that this is an asm function, so no DWARF, let alone
correct DWARF, so the message is kinda ok, but we can't use that message
as it could paper over real problems like the one fixed by the patch
that Veronika pointed out.

How to figure out if a function has valid DWARF? Maybe for the moment we
should have _another_ blacklist, one for functions in the blacklist that
have no valid DWARF? A blacklist's blacklist?

Turtles all the way down? :-)

- Arnaldo
 
> > > >>   Error: Failed to add events.
> > > >> root@x1:~#
> > > >> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted_list.log 
> > > >> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.log 
> > > >> root@x1:~#
> > > >>
> > > >> So is it just a matter of adding this output to the expected outputs?
> > > >> In test_adding_blacklisted.sh?
> > > > 
> > > > Did the patch below, now it passes, Ack?
> > > > 
> > > > root@x1:~# export PERFTEST_KEEP_LOGS=y
> > > > root@x1:~# perf test 88
> > > >  88: perftool-testsuite_probe                                        : Ok
> > > > root@x1:~#
> > > > 
> > > > Or am I missing the point? :-)

> > > Yeah, that would fix the test case, the question is whether we should

> > I was lazy, but yeah, that thought crossed my mind, good thing you did
> > the due diligence and found that patch! Looking at it now.

> > > accept it as a possible output. Found some old patch that should have
> > > fixed the mentioned issue: 
> > > https://lore.kernel.org/all/20230628082337.1857302-3-georgmueller@gmx.net/

> > I updated Masami's e-mail to a more recent one, Masami-san, wdyt? Can I
> > have your opinion on the patch pointed out by Veronika?
 
> Thanks for update my email. Yeah, it looks good to me.
 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Unfortunately that cset is already there:

commit c66e1c68c13b872505f25ab641c44b77313ee7fe
Author: Georg Müller <georgmueller@gmx.net>
Date:   Wed Jun 28 10:45:51 2023 +0200

    perf probe: Read DWARF files from the correct CU
    
    After switching from dwarf_decl_file() to die_get_decl_file(), it is not
    possible to add probes for certain functions:
    
      $ perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
      A function DIE doesn't have decl_line. Maybe broken DWARF?
      A function DIE doesn't have decl_line. Maybe broken DWARF?
      Probe point 'match_unit_removed' not found.
         Error: Failed to add events.


⬢[acme@toolbox perf-tools-next]$ git tag --contains c66e1c68c13b872505f25ab641c44b77313ee7fe | grep ^v6.1
v6.10
v6.10-rc1
v6.10-rc2
v6.10-rc3
v6.10-rc4
v6.10-rc5
v6.10-rc6
v6.10-rc7
v6.11-rc1
v6.11-rc2
v6.11-rc3
v6.11-rc4
v6.11-rc5
v6.11-rc6
⬢[acme@toolbox perf-tools-next]$

But..

root@number:~# perf test -vvvvv testsuite_probe |& head
capget syscall failed (No such file or directory - 2) fall back on root check
 88: perftool-testsuite_probe:
--- start ---
test child forked, pid 511749
Line did not match any pattern: "A function DIE doesn't have decl_line. Maybe broken DWARF?"
Line did not match any pattern: "A function DIE doesn't have decl_line. Maybe broken DWARF?"
-- [ FAIL ] -- perf_probe :: test_adding_blacklisted :: adding blacklisted function warn_thunk_thunk (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing blacklisted probe (should NOT be listed)
## [ FAIL ] ## perf_probe :: test_adding_blacklisted SUMMARY :: 1 failures found
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: 
root@number:~# perf -v
perf version 6.11.rc6.g69e90b02e611
root@number:~#
