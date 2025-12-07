Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1E3B8D59;
	Sun,  7 Dec 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765134539; cv=none; b=fjZfSMszpk4jHP+IHNNTdanAZETr6KUBAef9QU2ZvI/NXnd+hQAbuwdV6fFfdNQi3qEcffFc6FBtnekshzOSjYmxngvFUAUNvEgnCuF7Xs/JehQdmh2H+Q3ZijQpQuudLpCMWpzLFGIBQouV2zbGHMhMvlLb2/dnK1tIvs/6W5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765134539; c=relaxed/simple;
	bh=ZvIed2GvEBeA/46k/5FtsmHUJFSjM4LwQ4CPXye6ZXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6xGKLwkrEq21I1sz1MrAaVR+yesg9Txn726R8cvW2PAXTc0p0fF8+hWJ19oCqf1I+N23NsvsSvamZNAGyKp4p+T3bvlQiESDGC1/Mi9RyU8Nj9KxBiBecXqjvRbAjB5edxDeggIHvsSLmgOyRYusZl7y94alTMquO4wC2CbBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B50753409EC;
	Sun, 07 Dec 2025 19:08:55 +0000 (UTC)
Date: Sun, 7 Dec 2025 20:08:51 +0100
From: Guilherme Amadio <amadio@gentoo.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@kernel.org, peterz@infradead.org
Subject: Re: perf --help triggers an assertion
Message-ID: <aTXQw9dtP5df7LmP@gentoo.org>
References: <20250701201027.1171561-3-namhyung@kernel.org>
 <20250909094953.106706-1-amadio@gentoo.org>
 <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com>
 <aMF0iWh4yTK5KwcJ@gentoo.org>
 <CAP-5=fV8p7u9zfYAWJ8zt=Dq53u-b3pNzD9ve2HabJ9_qjymhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV8p7u9zfYAWJ8zt=Dq53u-b3pNzD9ve2HabJ9_qjymhw@mail.gmail.com>

Hi Ian,

On Wed, Sep 10, 2025 at 08:04:42AM -0700, Ian Rogers wrote:
> On Wed, Sep 10, 2025 at 5:52 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> >
> > On Tue, Sep 09, 2025 at 11:31:51AM -0700, Ian Rogers wrote:
> > > On Tue, Sep 9, 2025 at 2:49 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> > > >
> > > > Hi Namhyung,
> > > >
> > > > I was updating perf's package in Gentoo Linux and noticed some problems
> > > > which were not there before. I tested with the version below and the problem
> > > > still seems to be there. perf --help triggers an assertion (see below).
> > > > Looking in the list, it seems related to the patch below:
> > > >
> > > > https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3-namhyung@kernel.org/
> > > >
> > > > Cheers,
> > > > -Guilherme
> > > >
> > > > The problem:
> > > >
> > > > gentoo perf $ ./perf --help
> > > > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
> > > > Aborted                    (core dumped) ./perf --help
> > > >
> > > > Some extra information:
> > > >
> > > > gentoo perf $ ./perf version
> > > > perf version 6.17.rc5.gf777d1112ee5
> > > > gentoo perf $ ./perf test subcmd
> > > >  69: libsubcmd help tests                                            :
> > > >  69.1: Load subcmd names                                             : Ok
> > > >  69.2: Uniquify subcmd names                                         : Ok
> > > >  69.3: Exclude duplicate subcmd names                                : Ok
> > > > gentoo perf $ ./perf bad-command
> > > > perf: 'bad-command' is not a perf-command. See 'perf --help'.
> > > > gentoo perf $ ./perf --help
> > > > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
> > > > Aborted                    (core dumped) ./perf --help
> > > > gentoo perf $ gdb run --args ./perf --help
> > > > GNU gdb (Gentoo 16.3 vanilla) 16.3
> > > > Copyright (C) 2024 Free Software Foundation, Inc.
> > > > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> > > > This is free software: you are free to change and redistribute it.
> > > > There is NO WARRANTY, to the extent permitted by law.
> > > > Type "show copying" and "show warranty" for details.
> > > > This GDB was configured as "x86_64-pc-linux-gnu".
> > > > Type "show configuration" for configuration details.
> > > > For bug reporting instructions, please see:
> > > > <https://bugs.gentoo.org/>.
> > > > Find the GDB manual and other documentation resources online at:
> > > >     <http://www.gnu.org/software/gdb/documentation/>.
> > > >
> > > > For help, type "help".
> > > > Type "apropos word" to search for commands related to "word"...
> > > > Reading symbols from ./perf...
> > > > (gdb) run
> > > > Starting program: /home/amadio/src/linux/tools/perf/perf --help
> > > > [Thread debugging using libthread_db enabled]
> > > > Using host libthread_db library "/usr/lib64/libthread_db.so.1".
> > > > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
> > > >
> > > > Program received signal SIGABRT, Aborted.
> > > > __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > > > 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) : 0;
> > > > (gdb) bt
> > > > #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > > > #1  0x00007ffff74c1656 in __pthread_kill_internal (threadid=<optimized out>, signo=signo@entry=6) at pthread_kill.c:89
> > > > #2  0x00007ffff74c166d in __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at pthread_kill.c:100
> > > > #3  0x00007ffff747509c in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> > > > #4  0x00007ffff747637e in __GI_abort () at abort.c:77
> > > > #5  0x00007ffff746e023 in __assert_fail_base (fmt=<optimized out>, assertion=assertion@entry=0x555555974d03 "cmds->names[ci] == NULL",
> > > >     file=file@entry=0x555555974cfc "help.c", line=line@entry=104, function=function@entry=0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cmds")
> > > >     at assert.c:118
> > > > #6  0x00007ffff746e075 in __assert_fail (assertion=0x555555974d03 "cmds->names[ci] == NULL", file=0x555555974cfc "help.c", line=104,
> > > >     function=0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cmds") at assert.c:127
> > > > #7  0x0000555555693813 in exclude_cmds (cmds=0x55555614e5e0 <other_cmds>, excludes=0x55555614e5c0 <main_cmds>) at help.c:104
> > > > #8  0x0000555555693eb3 in load_command_list (prefix=0x555555954071 "perf-", main_cmds=0x55555614e5c0 <main_cmds>,
> > > >     other_cmds=0x55555614e5e0 <other_cmds>) at help.c:252
> > > > #9  0x00005555555e9987 in cmd_help (argc=1, argv=0x7fffffffd1a0) at builtin-help.c:458
> > > > #10 0x0000555555685d45 in run_builtin (p=0x555556130de0 <commands+192>, argc=1, argv=0x7fffffffd1a0) at perf.c:349
> > > > #11 0x0000555555685fe1 in handle_internal_command (argc=1, argv=0x7fffffffd1a0) at perf.c:401
> > > > #12 0x0000555555686142 in run_argv (argcp=0x7fffffffcfac, argv=0x7fffffffcfa0) at perf.c:445
> > > > #13 0x0000555555686493 in main (argc=1, argv=0x7fffffffd1a0) at perf.c:553
> > > > (gdb) quit
> > >
> > > Thanks Guilherme,
> > >
> > > I tried to reproduce the same version with various options: DEBUG=1
> > > -UNDEBUG in EXTRA_CFLAGS, -fsanitize=address. Being in various
> > > directories with "perf-" prefixed files. I'm afraid I wasn't able to
> > > reproduce. The assert is trying to avoid a memory leak, so
> > > non-critical, and I couldn't in a quick inspection eye-ball an issue.
> > > Without getting a reproduction I don't think I can make progress with
> > > the issue.

I had a look at this with gdb again while I was updating perf to 6.18 in Gentoo.

BTW, I've followed your advice and turned off BUILD_NONDISTRO:
https://gitweb.gentoo.org/repo/gentoo.git/commit/?id=b92c5b8bd89c70c40a84f86013c4ecf321f3132f

It looks like the logic to exclude commands sometimes doesn't work as
expected, and you reach a line where there is an assertion for
cmds->names[ci] == NULL, but it's not actually NULL. The difference with
other setups is probably the installation of perf-read-vdso32 into a
default path in our packaging. In gdb I saw that when running perf --help,
I arrive at exclude_cmds() with the following:

Breakpoint 1, exclude_cmds (cmds=cmds@entry=0x55555605bd90 <other_cmds>, excludes=excludes@entry=0x55555605bdb0 <main_cmds>) at help.c:74
74      {
(gdb) p *cmds
$1 = {alloc = 24, cnt = 1, names = 0x5555568fe180}
(gdb) p *excludes
$2 = {alloc = 24, cnt = 1, names = 0x5555568fe0c0}
(gdb) p *cmds->names[0]
$3 = {len = 11, name = 0x5555568db788 "read-vdso32"}
(gdb) p *excludes->names[0]
$4 = {len = 7, name = 0x555556890198 "archive"}

I have /usr/bin/perf and /usr/bin/perf-read-vdso32, as well as this:

$ ls /usr/libexec/perf-core/
dlfilters  libperf-gtk.so  perf-archive  perf-iostat  scripts  tests

If I remove /usr/bin/perf-read-vdso32, then perf --help works again:

gentoo ~ $ sudo rm /usr/bin/perf-read-vdso32
gentoo ~ $ perf version
perf version 6.18
gentoo ~ $ perf --help | head -3

 usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

gentoo ~ $ touch ~/bin/perf-read-vdso32
gentoo ~ $ chmod +x ~/bin/perf-read-vdso32
gentoo ~ $ perf --help
perf: help.c:107: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
Aborted                    (core dumped) perf --help

So, I think that if you don't have perf-read-vdso32 installed by default,
you will likely be able to reproduce the problem like shown above. So,
the assumption that cmds->names[0] == NULL is not correct, since we have
the "read-vdso32" command at position 0, and the excludes list only
contained "archive". The patch below is my attempt to fix the issue:

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index ddaeb4eb3e24..0c4ba87422e5 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -102,10 +102,10 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
                        cmds->names[cj++] = cmds->names[ci];
                        cmds->names[ci++] = NULL;
                }
+               for (ci = cj; ci < cmds->cnt; ci++)
+                       assert(cmds->names[ci] == NULL);
+               cmds->cnt = cj;
        }
-       for (ci = cj; ci < cmds->cnt; ci++)
-               assert(cmds->names[ci] == NULL);
-       cmds->cnt = cj;
 }

So, if there are no actual command exclusions, at the end of the while loop
we get out with ei > excludes->cnt, and ci == cj, like the example above,
in which ci == cj == 0, and ei == 1. So the assumption that
cmds->names[0] == NULL is wrong, since there's a valid "read-vdso32"
command at position 0, and setting cmds->cnt = cj; is also wrong, since
cnt should be 1 and is set to 0. The patch moves the asserts and the
update of cmds->cnt inside the if(ci != cj), which indicates something
was actually excluded. If cmds was not modified, then the initial value
of cmds->cnt was already correct. Please let me know if you'd like me
to submit this properly as a patch, but since it's so simple, please
feel free to just take this and apply yourself.

Best regards,
-Guilherme
