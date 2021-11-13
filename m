Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB6EC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356E161029
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 13:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhKMNc1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Nov 2021 08:32:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhKMNc0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Nov 2021 08:32:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D40460F70;
        Sat, 13 Nov 2021 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636810174;
        bh=kVuaHpj7gjt39OEKcsqnJuPd2nH8iPI9QdS+gAsJj2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLJmRobWcYrv7x1qeIUymM71S43zMm7k3U0dGSeQsFrENkQlPF6AZtXlbmngRU5K0
         FEGAgVO6jFrC8q8ZeiPC/pBpguQOiTMrG9oJPLgLPgDlwnZdXqeI1/zN2+1AmWd90Y
         iF0MRn6Ai+AqbZ0/eFiuJpSF4J2bGsny3cCmtD7fU0eUhFKzur9d/bm5+6TWk1mPZC
         Xp9gutYXnKFPMSDH6jXAdWh4MprtKkl4fKhMMGaGyDwZnLc9Lh9nwh6cvdMxAsdU/s
         ZlUS+0H4VFHeZP/JhFqo6qPPouS3LsKx1Oml2kIL8lhC0favcjvTJQfu+FA6aG554D
         WhW5U1M0NdQoA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 90259410A1; Sat, 13 Nov 2021 10:29:31 -0300 (-03)
Date:   Sat, 13 Nov 2021 10:29:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>, eranian@google.com
Subject: Re: [PATCH v3 03/22] perf test: Make each test/suite its own struct.
Message-ID: <YY+9uyPCJ3A0x616@kernel.org>
References: <20211104064208.3156807-1-irogers@google.com>
 <20211104064208.3156807-4-irogers@google.com>
 <YY+4WNB6GGWrkzvT@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY+4WNB6GGWrkzvT@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Nov 13, 2021 at 10:06:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 03, 2021 at 11:41:49PM -0700, Ian Rogers escreveu:
> > By switching to an array of pointers to tests (later to be suites)
> > the definition of the tests can be moved to the file containing the
> > tests.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/arm/include/arch-tests.h     |   2 +-
> >  tools/perf/arch/arm/tests/arch-tests.c       |  18 +-
> >  tools/perf/arch/arm64/include/arch-tests.h   |   2 +-
> >  tools/perf/arch/arm64/tests/arch-tests.c     |  11 +-
> >  tools/perf/arch/powerpc/include/arch-tests.h |   2 +-
> >  tools/perf/arch/powerpc/tests/arch-tests.c   |  11 +-
> >  tools/perf/arch/x86/include/arch-tests.h     |   2 +-
> >  tools/perf/arch/x86/tests/arch-tests.c       |  47 ++--
> >  tools/perf/tests/builtin-test.c              | 273 ++++++++++++-------
> >  tools/perf/tests/dwarf-unwind.c              |   7 +-
> >  tools/perf/tests/tests.h                     |   8 +-
> >  11 files changed, 215 insertions(+), 168 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
> > index c62538052404..37039e80f18b 100644
> > --- a/tools/perf/arch/arm/include/arch-tests.h
> > +++ b/tools/perf/arch/arm/include/arch-tests.h
> > @@ -2,6 +2,6 @@
> >  #ifndef ARCH_TESTS_H
> >  #define ARCH_TESTS_H
> >  
> > -extern struct test arch_tests[];
> > +extern struct test *arch_tests[];
> >  
> >  #endif
> > diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
> > index 6848101a855f..5287729026ab 100644
> > --- a/tools/perf/arch/arm/tests/arch-tests.c
> > +++ b/tools/perf/arch/arm/tests/arch-tests.c
> > @@ -3,18 +3,12 @@
> >  #include "tests/tests.h"
> >  #include "arch-tests.h"
> >  
> > -struct test arch_tests[] = {
> > +DEFINE_SUITE("Vectors page", vectors_page);
> > +
> > +struct test *arch_tests[] = {
> >  #ifdef HAVE_DWARF_UNWIND_SUPPORT
> > -	{
> > -		.desc = "DWARF unwind",
> > -		.func = test__dwarf_unwind,
> > -	},
> > +	&dwarf_unwind,
> >  #endif
> > -	{
> > -		.desc = "Vectors page",
> > -		.func = test__vectors_page,
> > -	},
> > -	{
> > -		.func = NULL,
> > -	},
> > +	&vectors_pages,
> 
> Its "vector_page", not plural, I'm fixing it up from this point onwards.

Also had to add this, now fixing up the fallout in the following patches
to see if this builds on arm 32-bit.

- Arnaldo

diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
index ee1ee83ee6a17f38..8276740f7ff86db4 100644
--- a/tools/perf/arch/arm/tests/arch-tests.c
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -3,8 +3,6 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-DEFINE_SUITE("Vectors page", vectors_page);
-
 struct test *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	&dwarf_unwind,
diff --git a/tools/perf/arch/arm/tests/vectors-page.c b/tools/perf/arch/arm/tests/vectors-page.c
index 7ffdd79971c89220..dac7b32afb655608 100644
--- a/tools/perf/arch/arm/tests/vectors-page.c
+++ b/tools/perf/arch/arm/tests/vectors-page.c
@@ -9,8 +9,7 @@
 
 #define VECTORS__MAP_NAME "[vectors]"
 
-int test__vectors_page(struct test *test __maybe_unused,
-		       int subtest __maybe_unused)
+static int test__vectors_page(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	void *start, *end;
 
@@ -22,3 +21,5 @@ int test__vectors_page(struct test *test __maybe_unused,
 
 	return TEST_OK;
 }
+
+DEFINE_SUITE("Vectors page", vectors_page);
