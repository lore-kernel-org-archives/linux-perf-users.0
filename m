Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375DDC636D4
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Feb 2023 18:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBFSK0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBFSKX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Feb 2023 13:10:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6CF7D8F
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Feb 2023 10:10:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D35AB815C6
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Feb 2023 18:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CD7C433EF;
        Mon,  6 Feb 2023 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675707019;
        bh=nmqAI9J4GjOYj1FBxzBhACWHOupskqoCkl1A+nVv+K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xb/zrEXIOOCRaxMhtHrfdxLk/LKpVJrTpu+zEmyGIURNcFi9xwqYbWMqT0wJqgLeE
         kUtoNclM/D95AJVUkLV4Kwe3yKIeT6oruFtdDxKYEBQpVYLqOq9ZbaKzo4GS8Bj1Q2
         jTPwjDSE4qhHRnJH/TOpLNHScYrEb0kyMwsA3GIsHuxI1/AueTnJIXW98QPhySECnE
         6fG3bfk562mxjARvAab4Avxgf9swB+aVoH+VPErOYMpimdsyZBTmT2e4bApERDA+bJ
         yWXFeXmVQhe8FrCGf/ooqv1EWwk6QZR2Mp6AOBiIWjPg9nV8VrxO3wWjErZxcwM2qw
         1QQExjcdQ/HXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7388D405BE; Mon,  6 Feb 2023 15:10:16 -0300 (-03)
Date:   Mon, 6 Feb 2023 15:10:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, disgoel@linux.ibm.com
Subject: Re: [PATCH 2/2] perf test bpf: Skip test if kernel-debuginfo is not
 present
Message-ID: <Y+FCiNAhves7RglY@kernel.org>
References: <20230105121742.92249-1-atrajeev@linux.vnet.ibm.com>
 <20230105121742.92249-2-atrajeev@linux.vnet.ibm.com>
 <Y7bIk77mdE4j8Jyi@kernel.org>
 <8B8A7CCE-E007-4C0C-AF1F-17B679F9A86D@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8B8A7CCE-E007-4C0C-AF1F-17B679F9A86D@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Feb 06, 2023 at 07:28:49PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 05-Jan-2023, at 6:24 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Thu, Jan 05, 2023 at 05:47:42PM +0530, Athira Rajeev escreveu:
> >> Perf BPF filter test fails in environment where "kernel-debuginfo"
> >> is not installed.
> > 
> > I'll apply this to perf/core, for the next merge window, as its more an
> > improvement than a fix, i.e. we know why it fails, we're just improving
> > the user reporting to make that clear at first sight.
> > 
> > - Arnaldo
> > 
> 
> Hi Arnaldo,
> 
> Just wanted to check when we can have these two patches in perf/core.
> I didn't find these in https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/?h=tmp.perf/core
> Not sure if I missed.

Thanks for the reminder, applied those now.

- Arnaldo
 
> Thanks
> Athira
> 
> >> Test failure logs:
> >> <<>>
> >> 42: BPF filter                            :
> >> 42.1: Basic BPF filtering                 : Ok
> >> 42.2: BPF pinning                         : Ok
> >> 42.3: BPF prologue generation             : FAILED!
> >> <<>>
> >> 
> >> Enabling verbose option provided debug logs, which says debuginfo
> >> needs to be installed. Snippet of verbose logs:
> >> 
> >> <<>>
> >> 42.3: BPF prologue generation                                       :
> >> --- start ---
> >> test child forked, pid 28218
> >> <<>>
> >> Rebuild with CONFIG_DEBUG_INFO=y, or install an appropriate debuginfo
> >> package.
> >> bpf_probe: failed to convert perf probe events
> >> Failed to add events selected by BPF
> >> test child finished with -1
> >> ---- end ----
> >> BPF filter subtest 3: FAILED!
> >> <<>>
> >> 
> >> Here subtest, "BPF prologue generation" failed and
> >> logs shows debuginfo is needed. After installing
> >> kernel-debuginfo package, testcase passes.
> >> 
> >> Subtest "BPF prologue generation" failed because, the "do_test"
> >> function returns "TEST_FAIL" without checking the error type
> >> returned by "parse_events_load_bpf_obj" function.
> >> Function parse_events_load_bpf_obj can also return error of type
> >> "-ENODATA" incase kernel-debuginfo package is not installed. Fix this
> >> by adding check for -ENODATA error.
> >> 
> >> Test result after the patch changes:
> >> 
> >> Test failure logs:
> >> <<>>
> >> 42: BPF filter                 :
> >> 42.1: Basic BPF filtering      : Ok
> >> 42.2: BPF pinning              : Ok
> >> 42.3: BPF prologue generation  : Skip (clang/debuginfo isn't
> >> installed or environment missing BPF support)
> >> 
> >> Fixes: ba1fae431e74 ("perf test: Add 'perf test BPF'")
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> ---
> >> Note: This is dependent on patch 1:
> >> tools/perf: Update the exit error codes in function
> >> try_to_find_probe_trace_event
> >> 
> >> tools/perf/tests/bpf.c | 6 +++++-
> >> 1 file changed, 5 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> >> index 17c023823713..6a4235a9cf57 100644
> >> --- a/tools/perf/tests/bpf.c
> >> +++ b/tools/perf/tests/bpf.c
> >> @@ -126,6 +126,10 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
> >> 
> >> 	err = parse_events_load_bpf_obj(&parse_state, &parse_state.list, obj, NULL);
> >> 	parse_events_error__exit(&parse_error);
> >> +	if (err == -ENODATA) {
> >> +		pr_debug("Failed to add events selected by BPF, debuginfo package not installed\n");
> >> +		return TEST_SKIP;
> >> +	}
> >> 	if (err || list_empty(&parse_state.list)) {
> >> 		pr_debug("Failed to add events selected by BPF\n");
> >> 		return TEST_FAIL;
> >> @@ -368,7 +372,7 @@ static struct test_case bpf_tests[] = {
> >> 			"clang isn't installed or environment missing BPF support"),
> >> #ifdef HAVE_BPF_PROLOGUE
> >> 	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test,
> >> -			"clang isn't installed or environment missing BPF support"),
> >> +			"clang/debuginfo isn't installed or environment missing BPF support"),
> >> #else
> >> 	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
> >> #endif
> >> -- 
> >> 2.31.1
> > 
> > -- 
> > 
> > - Arnaldo
> 

-- 

- Arnaldo
