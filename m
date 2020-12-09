Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A585C19425
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Dec 2020 17:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C34023B6B
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Dec 2020 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgLIRty (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgLIRtm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Dec 2020 12:49:42 -0500
Date:   Wed, 9 Dec 2020 14:49:10 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607536141;
        bh=g9dGx1sfBfj6LVoySFl/0KfqVoAZqY8Q4b/cyCZSIx4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppuqGLDhnRrGAnmbGGI2AG/lvtJGkbjufRuYKHBGvjxIaG2hd3our5/6dGRLekd1G
         skzEZUQefTTNnjS9k6tXOXIJMpLPUaAXXU1eVIStjkAiSbpzNOGzhEXAc6zWkSTMGf
         d1o5+/O1Yqpe7voMSP1rMssYqg/4tNwjD9bD7ttsZNPjHFt4VAkVMWL0c1J4ndDRr8
         nFA/pt9xsGWU9uqSUcllIwWOxWDzDsXtDVaI4QNhw0XbkHZUUnPqmbw3wE5/ZMmNG4
         KT88uGASSuAFDQvx3GsU5aYB1WiNbhEuXO/wZwRP1LppwX5CvAjCEqDwRqG0BGRQp+
         QoeAhV/wJbMDg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, irogers@google.com,
        rbernon@codeweavers.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH] perf test: Skip test 68 for Powerpc
Message-ID: <20201209174910.GC185686@kernel.org>
References: <20201104082954.57338-1-tmricht@linux.ibm.com>
 <20201119135022.36340-1-kjain@linux.ibm.com>
 <4a2908ca-6b75-c688-ec3b-7f37783f08cc@linux.ibm.com>
 <20201207163524.GF125383@kernel.org>
 <763d4593-d581-0971-338c-b811925be45b@linux.ibm.com>
 <29a77348-2ab7-1235-3fcf-c505dab1f1a1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a77348-2ab7-1235-3fcf-c505dab1f1a1@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Dec 08, 2020 at 10:32:33PM +0530, Ravi Bangoria escreveu:
> On 12/8/20 8:13 PM, Thomas Richter wrote:
> > On 12/7/20 5:35 PM, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Nov 24, 2020 at 03:04:53PM +0530, Ravi Bangoria escreveu:
> > > > On 11/19/20 7:20 PM, Kajol Jain wrote:
> > > > > Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
> > > > > adds a WINDOWS EXE file named tests/pe-file.exe, which is
> > > > > examined by the test case 'PE file support'. As powerpc doesn't support
> > > > > it, we are skipping this test.

> > > > > Result in power9 platform before this patach:
> > > > > [command]# ./perf test -F 68
> > > > > 68: PE file support                               : Failed!

> > > > > Result in power9 platform after this patch:
> > > > > [command]# ./perf test -F 68
> > > > > 68: PE file support                               : Skip

> > > > > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

> > > > Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

> > > But why is it failing? I.e. what is that

> > >   perf test -v -F 68

> > > outputs?

> > > Using 'perf report' on a perf.data file containing samples in such
> > > binaries, collected on x86 should work on whatever workstation a
> > > developer uses.

> > > Say, on a MacBook aarch64 one can look at a perf.data file collected on
> > > a x86_64 system where Wine running a PE binary was present.

> > What is the distro you are using?
> > I observed the same issue on s390 but this was fixed for fedora33 somehow.
> > The error just went away after a dnf update....

> > [root@m35lp76 perf]# cat /etc/fedora-release
> > Fedora release 33 (Thirty Three)
> > [root@m35lp76 perf]# ./perf test -F 68
> > 68: PE file support                                                 : Ok
> > [root@m35lp76 perf]#

> > However on my fedora32 machine it still fails:
> > [root@t35lp46 perf]# cat /etc/fedora-release
> > Fedora release 32 (Thirty Two)
> > [root@t35lp46 perf]# ./perf test -F 68
> > 68: PE file support                                                 : FAILED!
> > [root@t35lp46 perf]#
> > 
> > Note that I am running the same kernel on both machines: linux 5.10.0rc7 downloaded
> > this morning.
> > 
> 
> Ok that's interesting. I don't see that on powerpc.
> 
> Fedora 32 with 5.10.0-rc2+ kernel:
> 
>   $ ./perf test -vv -F 68
>   68: PE file support                                                 :
>   --- start ---
>   filename__read_build_id: cannot read ./tests/pe-file.exe bfd file.
>   FAILED tests/pe-file-parsing.c:40 Failed to read build_id
>   ---- end ----
>   PE file support: FAILED!
> 
> Fedora 33 with 5.10.0-rc3 kernel:
> 
>   $ ./perf test -vv -F 68
>   68: PE file support                                                 :
>   --- start ---
>   filename__read_build_id: cannot read ./tests/pe-file.exe bfd file.
>   FAILED tests/pe-file-parsing.c:40 Failed to read build_id
>   ---- end ----
>   PE file support: FAILED!
> 
> Ubuntu 18.04.5 with 4.15.0-126-generic kernel:
> 
>   $ ./perf test -vv -F 68
>   68: PE file support                                                 :
>   --- start ---
>   filename__read_build_id: cannot read ./tests/pe-file.exe bfd file.
>   FAILED tests/pe-file-parsing.c:41 Failed to read build_id
>   ---- end ----
>   PE file support: FAILED!
> 
> 
> I assumed bfd is not capable to parse PE files on powerpc. Though,
> I didn't check it in more detail. I'll look into it tomorrow.

Humm, so this is something related to installation? I.e. that
pe-file.exe isn't being found...

It first assumes that the developers are in the tools/perf/ directory,
can you please add the patch below and see if it helps?

Without it and without having actually installed perf (for instance with
'make -C tools/perf install' I get:

[acme@five perf]$ perf test -F 68
68: PE file support                                                 : FAILED!
[acme@five perf]$

[acme@five perf]$ perf test -F -v 68
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
68: PE file support                                                 :
--- start ---
FAILED tests/pe-file-parsing.c:40 Failed to read build_id
---- end ----
PE file support: FAILED!
[acme@five perf]$

If I go to tools/perf:

[acme@five perf]$ perf test 68
68: PE file support                                                 : Ok
[acme@five perf]$

With the patch below it works both at the top level dir and at
tools/perf/ on a system without a perf installation containing these
PE files.

We have this in tools/perf/Makefile.perf:

install-tests: all install-gtk
        $(call QUIET_INSTALL, tests) \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
                $(INSTALL) tests/attr.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
                $(INSTALL) tests/pe-file.exe* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \    <---------------------------------------------
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
                $(INSTALL) tests/attr/* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
                $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
                $(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'

install-bin: install-tools install-tests install-traceevent-plugins

- Arnaldo

diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 58b90c42eb38c1b9..a380d31b645b58dd 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -78,6 +78,9 @@ int test__pe_file_parsing(struct test *test __maybe_unused,
 	if (!lstat("./tests", &st))
 		return run_dir("./tests");
 
+	if (!lstat("./tools/perf/tests", &st))
+		return run_dir("./tools/perf/tests");
+
 	/* Then installed path. */
 	snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());
 
