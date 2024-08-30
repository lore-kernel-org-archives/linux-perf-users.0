Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D41E507
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031661; cv=none; b=YiajHujdvvhVqanJBfyqClVAOM0rKGTIYha4gBCVeDjurK122O38SweKSUBNOZim9nlWvPlQNVe58q5hY7g2AnYu40TM0YF6+U5pA3/aLNMgPSNaXMacCJM8YBEnIoj9p3j36GuJGDft7RdOftjyeWihgu0mUK20pTzloArUBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031661; c=relaxed/simple;
	bh=HYvvSEpwXd4Q0POTzyLRRQrjEULwdGWpLo4kQfbsHYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOkdFyM1gCMWVcRmTlCz7fwR/9Et6B5YAxeWEqXUvqKl0GNpNUigvoqlj+bS6d7g18ha3ZwguHG/n/W/Ay9CsDr2ByWJHa96XAsLOxhQKzjopBZxbqwNwkTHj2GPTU3Oaextlux6D5wpoHlIoecnmG1vp4mZqvaiRxsawIptCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7HNrCt1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7HNrCt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15081C4CEC2;
	Fri, 30 Aug 2024 15:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725031660;
	bh=HYvvSEpwXd4Q0POTzyLRRQrjEULwdGWpLo4kQfbsHYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7HNrCt1q04Ixi9Hyj3PXcajty/UmJNeQovHiMbqp2YYm//Ey+28PvT96HVW8L19T
	 Elmyq0mjsv6ht9/goaBiIng64Sg60fs7Zs82i4u8oFBppO0zXdybbTRkuN85S0bcio
	 co9sr2oqSf5c0WUEETj/hgBCuzt62lp5YKs4KCmAE0EO7mq8Sl32Qbsl/7lWKAFW3L
	 PxkdXC63M5wbSApFbuzQFgHakMtc/TcaVoMNhqXJabKYnF4lY6DGB+uS/goj4THaFP
	 0jl68nRUmP2EFifqAV3HQ93PcV/3R6JYa47DmPXAkAgPxqbWCryE+1pfmgreOYpmQe
	 2g/ynaqRucZSg==
Date: Fri, 30 Aug 2024 12:27:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
	mpetlan@redhat.com, irogers@google.com, atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
Message-ID: <ZtHk6Tj7KioLRd10@x1>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
 <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com>
 <Zs-LEEutfp0hkjh5@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs-LEEutfp0hkjh5@x1>

On Wed, Aug 28, 2024 at 05:39:48PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 28, 2024 at 04:10:55PM +0200, Veronika Molnarova wrote:
> > Ping
> 
So, is there some other knob to get further output from that FAIL case?
Like the command that is failing? I'll try to take a look at the
sources, but are you seeing this problem with what is in
perf-tools-next/perf-tools-next?

- Arnaldo

root@x1:~# perf test -vvvvv 88
capget syscall failed (No such file or directory - 2) fall back on root check
 88: perftool-testsuite_probe:
--- start ---
test child forked, pid 2780578
Line did not match any pattern: "A function DIE doesn't have decl_line. Maybe broken DWARF?"
Line did not match any pattern: "A function DIE doesn't have decl_line. Maybe broken DWARF?"
-- [ FAIL ] -- perf_probe :: test_adding_blacklisted :: adding blacklisted function warn_thunk_thunk (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing blacklisted probe (should NOT be listed)
## [ FAIL ] ## perf_probe :: test_adding_blacklisted SUMMARY :: 1 failures found
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: 
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: -a
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: --add
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf list
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l
-- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed probe (should NOT be listed)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: adding probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: first probe adding
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (without force)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (with force)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
-- [ PASS ] -- perf_probe :: test_adding_kernel :: wildcard adding support
-- [ PASS ] -- perf_probe :: test_adding_kernel :: non-existing variable
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: add
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: record
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function argument probing :: script
## [ PASS ] ## perf_probe :: test_adding_kernel SUMMARY
-- [ SKIP ] -- perf_probe :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_probe :: test_basic :: usage message
-- [ PASS ] -- perf_probe :: test_basic :: quiet switch
## [ PASS ] ## perf_probe :: test_basic SUMMARY
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -a
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -d
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -L
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -V
-- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -d xxx
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -L foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -V foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -L foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -V foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -l -F
## [ PASS ] ## perf_probe :: test_invalid_options SUMMARY
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:10
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:0-10
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:2+10
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c:1
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1+1
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1-10
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:foo
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1-foo
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1+foo
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func;lazy\*pattern
## [ PASS ] ## perf_probe :: test_line_semantics SUMMARY
---- end(-1) ----
 88: perftool-testsuite_probe                                        : FAILED!
root@x1:~# 


