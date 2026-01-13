Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A02FD689;
	Tue, 13 Jan 2026 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333745; cv=none; b=rvrvCogOsCEs4Oou6mUrdTJQNufaBFZV+dPggvUNt8P2V0VYgzvYp92/KGNbjTttEGTjZ8d1DL5o9hQ8+BxwPRSL6QukkXbgo1yzExJgv/GCk2F94+uEHdxPE4E6MWi8EsLSZDR1FZ3cV7i7Y0csMkDyrVgQmc7qgQsTvOpbGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333745; c=relaxed/simple;
	bh=0dksfeQmNe8pG8qiWCReZ/yCg3DDFgqZ+wI7dW+Zi3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBD9DihrslBYaWAEWAHKuTNNAEzLPjQbANPkUiKDXDIbhxNzIh5/9YDd17iznkiNvwsCToe1zdgQU0kU98VEnbzucOpHpn0J3XkAEfzJOJIqMHu0aRClrp2mOyJrhB+F42ew62sOLeRr7AAEtQ2zQZq6jgJ0xBfDls7PChYEVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byer8ceO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byer8ceO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99605C116C6;
	Tue, 13 Jan 2026 19:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768333745;
	bh=0dksfeQmNe8pG8qiWCReZ/yCg3DDFgqZ+wI7dW+Zi3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byer8ceOyf9hYuQ5+2g0wFrRn5mrg/OPmBfpbdTWRX5hg/XJ3mnbubOAbF0Ta2O6B
	 ahOEH0AS/uOH3C7axANQe/5LNDOsLypCePWaj4MiCLtVtFzx1LXVEMblTS/rTX9itA
	 G4/47hETpv4hnU9xXWF8rqs3FDcKmTiQo9SI0tLLYOyc9pM8wssMx0hr9gjQ7hIMEf
	 QyvtId+00y+lphtG7Me5pJERrrdMRMhEYWcSe1fDrxKCxyOr61GLQKcLhPnNEDbeYO
	 m/uGDPsJmbDL9ls+9FJ3kQEf22wpXK+Wwq1rtiduW7KadAD39mtthN5Pa6aj50SLAm
	 Pr8i69VQRxfJQ==
Date: Tue, 13 Jan 2026 16:49:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Sri Jayaramappa <sjayaram@akamai.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joshua Hunt <johunt@akamai.com>
Subject: Re: [PATCH] libsubcmd: Fix null intersection case in exclude_cmds()
Message-ID: <aWahrUD2yzJSMyR-@x1>
References: <20251202213632.2873731-1-sjayaram@akamai.com>
 <CAP-5=fUs8jD_qLJGjLBiVheu6JzynmmYSmfr_9PgKmxK4qEwVg@mail.gmail.com>
 <CAP-5=fU8PA0u=YKroNK8ykF3f8oUrttgNzJ13LELCmNL0JO+=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU8PA0u=YKroNK8ykF3f8oUrttgNzJ13LELCmNL0JO+=Q@mail.gmail.com>

On Mon, Dec 08, 2025 at 09:26:49AM -0800, Ian Rogers wrote:
> On Sun, Dec 7, 2025 at 2:16 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Dec 2, 2025 at 1:40 PM Sri Jayaramappa <sjayaram@akamai.com> wrote:
> > >
> > > When there is no exclusion occurring from the cmds list - for example -
> > > cmds contains ["read-vdso32"] and excludes contains ["archive"] - the
> > > main loop completes with ci == cj == 0. In the original code the loop
> > > processing the remaining elements in the list was conditional:
> > >
> > >     if (ci != cj) { ...}
> > >
> > > So we end up in the assertion loop since ci < cmds->cnt and we
> > > incorrectly try to assert the list elements to be NULL and fail with
> > > the following error
> > >
> > >    help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
> > >
> > > Fix this by moving the if (ci != cj) check inside of a broader loop.
> > > If ci != cj, left shift the list elements, as before, and then
> > > unconditionally advance the ci and cj indicies which also covers the
> > > ci == cj case.
> > >
> > > Fixes: 1fdf938168c4d26f ("perf tools: Fix use-after-free in help_unknown_cmd()")
> > >
> > > Signed-off-by: Sri Jayaramappa <sjayaram@akamai.com>
> >
> > Thanks Sri! Guilherme reported a related issue and I think your fix covers it:
> > https://lore.kernel.org/lkml/aTXQw9dtP5df7LmP@gentoo.org/
> >
> > I came up with the following test based on your commit message, could
> > you validate it covers the case for your fix:
> > ```
> > diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-help.c
> > index 2280b4c0e5e7..9da96a16fd20 100644
> > --- a/tools/perf/tests/subcmd-help.c
> > +++ b/tools/perf/tests/subcmd-help.c
> > @@ -95,10 +95,36 @@ static int test__exclude_cmdnames(struct
> > test_suite *test __maybe_unused,
> >        return TEST_OK;
> > }
> >
> > +static int test__exclude_cmdnames_no_overlap(struct test_suite *test
> > __maybe_unused,
> > +                                            int subtest __maybe_unused)
> > +{
> > +       struct cmdnames cmds1 = {};
> > +       struct cmdnames cmds2 = {};
> > +
> > +       add_cmdname(&cmds1, "read-vdso32", 11);
> > +       add_cmdname(&cmds2, "archive", 7);
> > +
> > +       TEST_ASSERT_VAL("invalid original size", cmds1.cnt == 1);
> > +       TEST_ASSERT_VAL("invalid original size", cmds2.cnt == 1);
> > +
> > +       exclude_cmds(&cmds1, &cmds2);
> > +
> > +       TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt == 1);
> > +       TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt == 1);
> > +
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1,
> > "read-vdso32") == 1);
> > +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "archive") == 0);
> > +
> > +       clean_cmdnames(&cmds1);
> > +       clean_cmdnames(&cmds2);
> > +       return TEST_OK;
> > +}
> > +
> > static struct test_case tests__subcmd_help[] = {
> >        TEST_CASE("Load subcmd names", load_cmdnames),
> >        TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
> >        TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
> > +       TEST_CASE("Exclude disjoint subcmd names", exclude_cmdnames_no_overlap),
> >        {       .name = NULL, }
> > };
> > ```
> > If you build perf you can run the test like:
> > ```
> > $ perf test -v help
> >  68: libsubcmd help tests                                            :
> >  68.1: Load subcmd names                                             : Ok
> >  68.2: Uniquify subcmd names                                         : Ok
> >  68.3: Exclude duplicate subcmd names                                : Ok
> >  68.4: Exclude disjoint subcmd names                                 : Ok
> > ```
> > Perhaps you can think of other values for the test so we don't run
> > into more issues.
> 
> Running the test above I get the following before:
> ```
>  68.4: Exclude disjoint subcmd names:
> --- start ---
> test child forked, pid 1443868
> perf: help.c:107: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
> 
> ---- unexpected signal (6) ----
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
> Failed to read build ID for //anon
>     #0 0x55ed35f172de in child_test_sig_handler builtin-test.c:312
>     #1 0x7fea1d049df0 in __restore_rt libc_sigaction.c:0
>     #2 0x7fea1d09e95c in __pthread_kill_implementation pthread_kill.c:44
>     #3 0x7fea1d049cc2 in raise raise.c:27
>     #4 0x7fea1d0324ac in abort abort.c:81
>     #5 0x7fea1d032420 in __assert_perror_fail assert-perr.c:31
>     #6 0x55ed35ea1524 in exclude_cmds help.c:106
>     #7 0x55ed35f62e82 in test__exclude_cmdnames_no_overlap subcmd-help.c:112
>     #8 0x55ed35f17470 in run_test_child builtin-test.c:340
>     #9 0x55ed35ea5834 in start_command run-command.c:128
>     #10 0x55ed35f17ee3 in start_test builtin-test.c:546
>     #11 0x55ed35f1838d in __cmd_test builtin-test.c:648
>     #12 0x55ed35f18f2d in cmd_test builtin-test.c:850
>     #13 0x55ed35e94494 in run_builtin perf.c:349
>     #14 0x55ed35e9472c in handle_internal_command perf.c:401
>     #15 0x55ed35e94885 in run_argv perf.c:448
>     #16 0x55ed35e94bce in main perf.c:555
>     #17 0x7fea1d033ca8 in __libc_start_call_main libc_start_call_main.h:74
>     #18 0x7fea1d033d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>     #19 0x55ed35de4f41 in _start perf[52f41]
>  68.4: Exclude disjoint subcmd names                                 : FAILED!
> ```
> After the test passes and is address/leak sanitizer clean.
> 
> Tested-by: Ian Rogers <irogers@google.com>
> 
> I posted the test as a patch here:
> https://lore.kernel.org/lkml/20251208172339.1445817-1-irogers@google.com/

So, finally this one is also applied, together with Guilherme's
Tested-by/Reviewed-by tags, etc.

- Arnaldo
