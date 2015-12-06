From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/2] perf test: Adding an entry for the perftool-testsuite
Date: Sun, 6 Dec 2015 16:53:17 +0100
Message-ID: <20151206155317.GB11852@krava.brq.redhat.com>
References: <1449249064.24573.184.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44599 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbbLFPxT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 6 Dec 2015 10:53:19 -0500
Content-Disposition: inline
In-Reply-To: <1449249064.24573.184.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Fri, Dec 04, 2015 at 06:11:04PM +0100, Michael Petlan wrote:
> In order to be able to run the bash/subcommand-based testsuite directly
> from perf test a new perf-test entry has been created for it.
> 
> The driver (suite.c) runs all the tests  that it finds in the testsuite
> directory: tools/perf/testsuite/   (rather ./testsuite as it expects it
> it being run from the perf's directory).
> 
> In case the testsuite is not found, the testcase is skipped. If this is
> not the desired behaviour, some packaging will be needed.
> 
> Usage:
> 	./perf test suite
> 
> or
> 	./perf test suite -v
> 
> (for the verbose output)
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

I can't get this applied on latest acme's perf/core

[jolsa@krava perf]$ git am /tmp/w/
Applying: perf test: Adding an entry for the perftool-testsuite
error: patch failed: tools/perf/tests/Build:34
error: tools/perf/tests/Build: patch does not apply
error: patch failed: tools/perf/tests/builtin-test.c:170
error: tools/perf/tests/builtin-test.c: patch does not apply
error: patch failed: tools/perf/tests/tests.h:68
error: tools/perf/tests/tests.h: patch does not apply
Patch failed at 0001 perf test: Adding an entry for the perftool-testsuite
The copy of the patch that failed is found in:
   /home/jolsa/kernel/linux-perf/.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


jirka
