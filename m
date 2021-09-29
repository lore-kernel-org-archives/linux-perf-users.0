Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22152C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C7A61502
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 21:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbhI2VMT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346833AbhI2VMS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Sep 2021 17:12:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9AA1615A2;
        Wed, 29 Sep 2021 21:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632949837;
        bh=VkVtr9ff3pqbOeduk4fdcTSzfp8pXb56OBTnBgAb4WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eWB9cS59SsFDc0zmb7fXgonZKcb7B83lHRffii/ir603DzT/SAiS9kg1gOmrGeV2T
         mC6vOLD0ZvEPkzMiBTSG9pxLSQgT9H2XxOKIZWOEjTGxUOzlds/j5P8ZF2BIorfbjs
         /Qw6psYLTMhiFBU4gCONMzvZQ/+2/++iPtOqfvGIrRYgHvrGCCN2AnQrKJ5EBT8Rp7
         C9s7Ds+un6PDRDkDLPyjiM0j2RxP8NYX04GSbLBJ4Q24cny8muRGiegdoAAQaFDmFO
         vAk8ofTUISNTgxTyKEvfmxtot+aP+eQKxYHWH8Tje6HCqInbsrPTi31oYUbqxe6Kas
         zrX956LLdMNyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0ECD5410A1; Wed, 29 Sep 2021 18:10:34 -0300 (-03)
Date:   Wed, 29 Sep 2021 18:10:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tests vmlinux-kallsyms: ignore hidden symbols
Message-ID: <YVTWSXjThbbZbE0L@kernel.org>
References: <20210922152706.23655-1-mpetlan@redhat.com>
 <CAP-5=fUN_fYmgm69ruBvp6E+nkLKsTvZwHqGzaRd471MhMRykA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUN_fYmgm69ruBvp6E+nkLKsTvZwHqGzaRd471MhMRykA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 22, 2021 at 09:36:11AM -0700, Ian Rogers escreveu:
> On Wed, Sep 22, 2021 at 8:27 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > Certain kernel symbols are purposely hidden from kallsyms. The function
> > is_ignored_symbol() from scripts/kallsyms.c decides if a symbol should
> > be hidden or not.
> >
> > The perf test "vmlinux symtab matches kallsyms" fails in case perf finds
> > some of the hidden symbols in its machine image and can't match them to
> > kallsyms.
> >
> > Let's add a filter to check if a symbol not found isn't one of these
> > before failing the test.
> >
> > The function is_ignored_symbol() has been copied from scripts/kallsyms.c
> > and needs to be updated along with the original.
> >
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> It is a shame this can't be a library to ensure the function is kept in sync.

We can adapt :-)

⬢[acme@toolbox perf]$ sed -n -e '/static bool is_ignored_symbol.*/,/^}.*/ p' scripts/kallsyms.c > original
⬢[acme@toolbox perf]$ sed -n -e '/static bool is_ignored_symbol.*/,/^}.*/ p' tools/perf/tests/vmlinux-kallsyms.c > copy
⬢[acme@toolbox perf]$ diff -u original copy
⬢[acme@toolbox perf]$

⬢[acme@toolbox perf]$ sed -n -e '/static bool is_ignored_symbol.*/,/^}.*/ p' scripts/kallsyms.c 
static bool is_ignored_symbol(const char *name, char type)
{
	/* Symbol names that exactly match to the following are ignored.*/
	static const char * const ignored_symbols[] = {
		/*
		 * Symbols which vary between passes. Passes 1 and 2 must have
		 * identical symbol lists. The kallsyms_* symbols below are
		 * only added after pass 1, they would be included in pass 2
		 * when --all-symbols is specified so exclude them to get a
		 * stable symbol list.
		 */
		"kallsyms_addresses",
		"kallsyms_offsets",
		"kallsyms_relative_base",
		"kallsyms_num_syms",
		"kallsyms_names",
		"kallsyms_markers",
		"kallsyms_token_table",
		"kallsyms_token_index",
		/* Exclude linker generated symbols which vary between passes */
		"_SDA_BASE_",		/* ppc */
		"_SDA2_BASE_",		/* ppc */
		NULL
	};

	/* Symbol names that begin with the following are ignored.*/
	static const char * const ignored_prefixes[] = {
		"$",			/* local symbols for ARM, MIPS, etc. */
		".LASANPC",		/* s390 kasan local symbols */
		"__crc_",		/* modversions */
		"__efistub_",		/* arm64 EFI stub namespace */
		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
		"__AArch64ADRPThunk_",	/* arm64 lld */
		"__ARMV5PILongThunk_",	/* arm lld */
		"__ARMV7PILongThunk_",
		"__ThumbV7PILongThunk_",
		"__LA25Thunk_",		/* mips lld */
		"__microLA25Thunk_",
		NULL
	};

	/* Symbol names that end with the following are ignored.*/
	static const char * const ignored_suffixes[] = {
		"_from_arm",		/* arm */
		"_from_thumb",		/* arm */
		"_veneer",		/* arm */
		NULL
	};

	/* Symbol names that contain the following are ignored.*/
	static const char * const ignored_matches[] = {
		".long_branch.",	/* ppc stub */
		".plt_branch.",		/* ppc stub */
		NULL
	};

	const char * const *p;

	for (p = ignored_symbols; *p; p++)
		if (!strcmp(name, *p))
			return true;

	for (p = ignored_prefixes; *p; p++)
		if (!strncmp(name, *p, strlen(*p)))
			return true;

	for (p = ignored_suffixes; *p; p++) {
		int l = strlen(name) - strlen(*p);

		if (l >= 0 && !strcmp(name + l, *p))
			return true;
	}

	for (p = ignored_matches; *p; p++) {
		if (strstr(name, *p))
			return true;
	}

	if (type == 'U' || type == 'u')
		return true;
	/* exclude debugging symbols */
	if (type == 'N' || type == 'n')
		return true;

	if (toupper(type) == 'A') {
		/* Keep these useful absolute symbols */
		if (strcmp(name, "__kernel_syscall_via_break") &&
		    strcmp(name, "__kernel_syscall_via_epc") &&
		    strcmp(name, "__kernel_sigtramp") &&
		    strcmp(name, "__gp"))
			return true;
	}

	return false;
}
⬢[acme@toolbox perf]$

This should be added to tools/perf/check-headers.sh as a new
function_check() function that receives three parameters:

	function_check scripts/kallsyms.c tools/perf/tests/vmlinux-kallsyms.c is_ignored_symbol

The regexps can also be tightened up a bit.

Michael, can you cook up a patch for this?

Thanks,

- Arnaldo
