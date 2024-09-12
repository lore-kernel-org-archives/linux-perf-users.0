Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B4210FB
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146440; cv=none; b=X+hZ6BdDWgwjsgRjUcmKoS3wyB+UAXl9Vi9ZCjb0VCVHr5WnAhRekW42KD8tJmWyx5cMtjFjwfJTb2zeGKwk9Ox2B+fhyV/JY8O8b+SBKSx99VBHi5kFlWQLoo1zEpu/ssw4B2dLp6BtzUiT3Ahletil4WuCMndIzUaxG/KwWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146440; c=relaxed/simple;
	bh=TH7JhLqDTJ/gWGEQzLP1S1z9F0XUFzL4bXYBJZGk4No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCuJihnbxTrVu15WYGn6WMqPYA6Ve8MS8r6ONmupTEcwC0WgDSAHGk+szbHvjvPG0zqrnQkW9vi3nuyNhv7a0/nbHY569ugOyPdQc78nW31P/uafgmNdKeu5ehquytYw1FjgNkRW92ln3RnMlQe1MbHqaVtvtX0tNAB0nsZqPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6ydzHGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6ydzHGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4DDC4CEC3;
	Thu, 12 Sep 2024 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146440;
	bh=TH7JhLqDTJ/gWGEQzLP1S1z9F0XUFzL4bXYBJZGk4No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6ydzHGrfz1A1qEm0HqQNXcKqzNluEX5nerN2UrtjiAXAtzRVCllYczDmfz8DSc1d
	 wt3meaIReoVaebIofd7OMGPCETa3ztE/DdsAn/YVg3gMpS/IsJO3NKaYg+EGEWIX+M
	 VH46QlpooZIrBfgkmYJlBx6McfEhPb4KWC593xWWzTAXCqwX/sLkyVFjvNlmE9617C
	 jdfmBmoE5ck6DNi9z4dtU2NJqZEQgcBVTgA+Ho/dO6bSbo7Ih7+lWpehtW2GlXwt4o
	 yyt9CNQexABBM1WXANYG9I5b1lRSAuCMskR41pJ6OnqhsZPV0VQhDTFgiT7N+uPbeF
	 tHnQiIxFerSCQ==
Date: Thu, 12 Sep 2024 10:07:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, acme@redhat.com,
	namhyung@kernel.org, mpetlan@redhat.com, irogers@google.com,
	atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
Message-ID: <ZuLnhbC4eAmKzVO5@x1>
References: <Zs-LEEutfp0hkjh5@x1>
 <ZtHk6Tj7KioLRd10@x1>
 <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>
 <ZtXMRffIGVmjptcf@x1>
 <ZtXOrJdxvrI7Kk6n@x1>
 <b87e2c58-8696-48bc-92ca-93964917bf9a@redhat.com>
 <ZtYIElLzMIzEVH9t@x1>
 <20240906001104.9314082caaf0268f09cc45b2@kernel.org>
 <ZtoAuoFNF8neYA-4@x1>
 <ZtoDUPuP-fEbC6sg@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtoDUPuP-fEbC6sg@x1>

On Thu, Sep 05, 2024 at 04:15:28PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 05, 2024 at 04:04:29PM -0300, Arnaldo Carvalho de Melo wrote:
> > So, I proposed that if we get that error message (A function DIE doesn't
> > have decl_line. Maybe broken DWARF?) we should skip it, but Veronika did
> > the right thing and asked if that wasn't really papering over some
> > problem and pointed to a patch that addressed a problem that lead to
> > that exact same message being produced, but that didn't help with our
> > current case, with another blacklisted function, warn_thunk_thunk.

> > You mentioned that this is an asm function, so no DWARF, let alone
> > correct DWARF, so the message is kinda ok, but we can't use that message
> > as it could paper over real problems like the one fixed by the patch
> > that Veronika pointed out.

> > How to figure out if a function has valid DWARF? Maybe for the moment we
> > should have _another_ blacklist, one for functions in the blacklist that
> > have no valid DWARF? A blacklist's blacklist?
 
> We have the needed info to provide a more informative warning:

So, perhaps we should, in the test, when we get that "broken dwarf"
output, look at the debuginfo file for the kernel to see if the function
is one in a DW_UT_compile (CU) that has 

     <da27a>   DW_AT_language    : 32769 (MIPS assembler)

And then just have a -vv output stating that that function is being
skipped because it is DWARF from assembler?

Veronika, would you be willing to try to do that?

Thanks,

- Arnaldo
 
>  <1><da258>: Abbrev Number: 0
>   Compilation Unit @ offset 0xda259:
>    Length:        0x3f (32-bit)
>    Version:       5
>    Unit Type:     DW_UT_compile (1)
>    Abbrev Offset: 0x74c8
>    Pointer Size:  8
>  <0><da265>: Abbrev Number: 1 (DW_TAG_compile_unit)
>     <da266>   DW_AT_stmt_list   : 0x12cbd
>     <da26a>   DW_AT_ranges      : 0x2d6e
>     <da26e>   DW_AT_name        : (indirect string, offset: 0x1ec2f): /home/acme/git/linux/arch/x86/entry/entry.S
>     <da272>   DW_AT_comp_dir    : (indirect string, offset: 0x1be93): /home/acme/git/build/v6.11-rc5+
>     <da276>   DW_AT_producer    : (indirect string, offset: 0x1beb3): GNU AS 2.41
>     <da27a>   DW_AT_language    : 32769 (MIPS assembler)
>  <1><da27c>: Abbrev Number: 2 (DW_TAG_subprogram)
>     <da27d>   DW_AT_name        : (indirect string, offset: 0x1ec5b): entry_ibpb
>     <da281>   DW_AT_external    : 1
>     <da281>   DW_AT_type        : <0xda29a>
>     <da282>   DW_AT_low_pc      : 0xffffffff82062790
>     <da28a>   DW_AT_high_pc     : 23
>  <1><da28b>: Abbrev Number: 2 (DW_TAG_subprogram)
>     <da28c>   DW_AT_name        : (indirect string, offset: 0x1ec66): warn_thunk_thunk
>     <da290>   DW_AT_external    : 1
>     <da290>   DW_AT_type        : <0xda29a>
>     <da291>   DW_AT_low_pc      : 0xffffffff81008060
>     <da299>   DW_AT_high_pc     : 45
>  <1><da29a>: Abbrev Number: 3 (DW_TAG_unspecified_type)
> 
> root@number:~# readelf -wi `pahole --running_kernel_vmlinux` | grep warn_thunk_thunk
>     <da28c>   DW_AT_name        : (indirect string, offset: 0x1ec66): warn_thunk_thunk
> root@number:~# pahole --running_kernel_vmlinux
> /lib/modules/6.11.0-rc5+/build/vmlinux
> root@number:~# perf buildid-list -k
> 4dd7f9c4507b82a5bf90671d524e5bb308104ffa
> root@number:~# file /lib/modules/6.11.0-rc5+/build/vmlinux
> /lib/modules/6.11.0-rc5+/build/vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=4dd7f9c4507b82a5bf90671d524e5bb308104ffa, with debug_info, not stripped
> root@number:~# perf buildid-list -i /lib/modules/6.11.0-rc5+/build/vmlinux
> 4dd7f9c4507b82a5bf90671d524e5bb308104ffa
> root@number:~#
> 
> - Arnaldo
> 
> > 
> > - Arnaldo
> >  
> > > > > >>   Error: Failed to add events.
> > > > > >> root@x1:~#
> > > > > >> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted_list.log 
> > > > > >> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.log 
> > > > > >> root@x1:~#
> > > > > >>
> > > > > >> So is it just a matter of adding this output to the expected outputs?
> > > > > >> In test_adding_blacklisted.sh?
> > > > > > 
> > > > > > Did the patch below, now it passes, Ack?
> > > > > > 
> > > > > > root@x1:~# export PERFTEST_KEEP_LOGS=y
> > > > > > root@x1:~# perf test 88
> > > > > >  88: perftool-testsuite_probe                                        : Ok
> > > > > > root@x1:~#
> > > > > > 
> > > > > > Or am I missing the point? :-)
> > 
> > > > > Yeah, that would fix the test case, the question is whether we should
> > 
> > > > I was lazy, but yeah, that thought crossed my mind, good thing you did
> > > > the due diligence and found that patch! Looking at it now.
> > 
> > > > > accept it as a possible output. Found some old patch that should have
> > > > > fixed the mentioned issue: 
> > > > > https://lore.kernel.org/all/20230628082337.1857302-3-georgmueller@gmx.net/
> > 
> > > > I updated Masami's e-mail to a more recent one, Masami-san, wdyt? Can I
> > > > have your opinion on the patch pointed out by Veronika?
> >  
> > > Thanks for update my email. Yeah, it looks good to me.
> >  
> > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Unfortunately that cset is already there:
> > 
> > commit c66e1c68c13b872505f25ab641c44b77313ee7fe
> > Author: Georg Müller <georgmueller@gmx.net>
> > Date:   Wed Jun 28 10:45:51 2023 +0200
> > 
> >     perf probe: Read DWARF files from the correct CU
> >     
> >     After switching from dwarf_decl_file() to die_get_decl_file(), it is not
> >     possible to add probes for certain functions:
> >     
> >       $ perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
> >       A function DIE doesn't have decl_line. Maybe broken DWARF?
> >       A function DIE doesn't have decl_line. Maybe broken DWARF?
> >       Probe point 'match_unit_removed' not found.
> >          Error: Failed to add events.
> 
>  
> > 
> > ⬢[acme@toolbox perf-tools-next]$ git tag --contains c66e1c68c13b872505f25ab641c44b77313ee7fe | grep ^v6.1
> > v6.10
> > v6.10-rc1
> > v6.10-rc2
> > v6.10-rc3
> > v6.10-rc4
> > v6.10-rc5
> > v6.10-rc6
> > v6.10-rc7
> > v6.11-rc1
> > v6.11-rc2
> > v6.11-rc3
> > v6.11-rc4
> > v6.11-rc5
> > v6.11-rc6
> > ⬢[acme@toolbox perf-tools-next]$
> > 
> > But..
> > 
> > root@number:~# perf test -vvvvv testsuite_probe |& head
> > capget syscall failed (No such file or directory - 2) fall back on root check
> >  88: perftool-testsuite_probe:
> > --- start ---
> > test child forked, pid 511749
> > Line did not match any pattern: "A function DIE doesn't have decl_line. Maybe broken DWARF?"
> > Line did not match any pattern: "A function DIE doesn't have decl_line. Maybe broken DWARF?"
> > -- [ FAIL ] -- perf_probe :: test_adding_blacklisted :: adding blacklisted function warn_thunk_thunk (output regexp parsing)
> > -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing blacklisted probe (should NOT be listed)
> > ## [ FAIL ] ## perf_probe :: test_adding_blacklisted SUMMARY :: 1 failures found
> > -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: 
> > root@number:~# perf -v
> > perf version 6.11.rc6.g69e90b02e611
> > root@number:~#
