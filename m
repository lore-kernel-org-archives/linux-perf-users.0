Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D59C38A2D
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 11:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJXLep (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiJXLeS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 07:34:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CB76BCCA;
        Mon, 24 Oct 2022 04:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3BA461252;
        Mon, 24 Oct 2022 11:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D19C433C1;
        Mon, 24 Oct 2022 11:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611201;
        bh=WTjtHgZEvE9XMQ3vDUR75QkwkZ5R9ZQ+58cICOfz8Pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pgl4bOjT93GPdM4YAxqDQjJZQ4lzSt116jHBDrH64S5v3BRGfwnD167XFZyGU2xJc
         hFxkJlh5upgjjR26/uxXdpBL+d9vaTwpjnebdWGFl6/wL6znG2mWZn2g20MBSFUeRH
         Nbs1la1YtTxh4lDLqanghOkbr2vWSnOkHize4dFFBaypXutSIoqptQ/bmOz9qYMzeZ
         jvdxnherrYsIS5ijm+Y4pf71Yhpl6N+O2/w6+rRLVw557HTj/TnzjMCTOxUAdF/Lkc
         zvkKQHBtJRaEDsfe4ITyvv20uoTGGq1ajSizMOA9XC0YmanFurewTwGxYsNd5cZ7Vn
         GUNgYGAMmljYw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FFB3404BE; Mon, 24 Oct 2022 08:33:18 -0300 (-03)
Date:   Mon, 24 Oct 2022 08:33:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/8] perf test: Use a test program in perf record tests
Message-ID: <Y1Z3/t4RtnB8r03t@kernel.org>
References: <20221020172643.3458767-1-namhyung@kernel.org>
 <20221020172643.3458767-4-namhyung@kernel.org>
 <CAP-5=fWKCdyFzR8ZZSK_2v6vT_RKngxxnXGieUVb8PBATJ64eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWKCdyFzR8ZZSK_2v6vT_RKngxxnXGieUVb8PBATJ64eQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 20, 2022 at 04:52:14PM -0700, Ian Rogers escreveu:
> On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:

> > If the system has cc it could build a test program with two threads
> > and then use it for more detailed testing.  Also it accepts an option
> > to run a thread forever to ensure multi-thread runs.
> >
> > If cc is not found, it falls back to use the default value 'true'.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> I wonder if these utilities should just be built into perf to avoid
> the cc dependency. Perhaps we can have a hidden option built into perf
> test.

Agreed, not depending on a compiler makes 'perf test' usable in more
systems, particularly production ones where we may want to check if perf
is passing all tests applicable to that system.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/shell/record.sh | 64 ++++++++++++++++++++++++++++++--
> >  1 file changed, 60 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > index 464071462809..952981481239 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -6,10 +6,17 @@ set -e
> >
> >  err=0
> >  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > +testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
> > +testsym="test_loop"
> >
> >  cleanup() {
> >    rm -f "${perfdata}"
> >    rm -f "${perfdata}".old
> > +
> > +  if [ "${testprog}" != "true" ]; then
> > +    rm -f "${testprog}"
> > +  fi
> > +
> >    trap - EXIT TERM INT
> >  }
> >
> > @@ -19,9 +26,56 @@ trap_cleanup() {
> >  }
> >  trap trap_cleanup EXIT TERM INT
> >
> > +build_test_program() {
> > +  if ! [ -x "$(command -v cc)" ]; then
> > +    # No CC found. Fall back to 'true'
> > +    testprog=true
> > +    testsym=true
> > +    return
> > +  fi
> > +
> > +  echo "Build a test program"
> > +  cat <<EOF | cc -o ${testprog} -xc - -pthread
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <pthread.h>
> > +
> > +void test_loop(void) {
> > +  volatile int count = 1000000;
> > +
> > +  while (count--)
> > +    continue;
> > +}
> > +
> > +void *thfunc(void *arg) {
> > +  int forever = *(int *)arg;
> > +
> > +  do {
> > +    test_loop();
> > +  } while (forever);
> > +
> > +  return NULL;
> > +}
> > +
> > +int main(int argc, char *argv[]) {
> > +  pthread_t th;
> > +  int forever = 0;
> > +
> > +  if (argc > 1)
> > +    forever = atoi(argv[1]);
> > +
> > +  pthread_create(&th, NULL, thfunc, &forever);
> > +  test_loop();
> > +  pthread_join(th, NULL);
> > +
> > +  return 0;
> > +}
> > +EOF
> > +}
> > +
> >  test_per_thread() {
> >    echo "Basic --per-thread mode test"
> > -  if ! perf record -o /dev/null --quiet true 2> /dev/null
> > +  if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
> >    then
> >      echo "Per-thread record [Skipped event not supported]"
> >      if [ $err -ne 1 ]
> > @@ -30,13 +84,13 @@ test_per_thread() {
> >      fi
> >      return
> >    fi
> > -  if ! perf record --per-thread -o "${perfdata}" true 2> /dev/null
> > +  if ! perf record --per-thread -o "${perfdata}" ${testprog} 2> /dev/null
> >    then
> >      echo "Per-thread record [Failed record]"
> >      err=1
> >      return
> >    fi
> > -  if ! perf report -i "${perfdata}" -q | grep -q true
> > +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> >    then
> >      echo "Per-thread record [Failed missing output]"
> >      err=1
> > @@ -62,7 +116,7 @@ test_register_capture() {
> >      return
> >    fi
> >    if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
> > -    -c 1000 --per-thread true 2> /dev/null \
> > +    -c 1000 --per-thread ${testprog} 2> /dev/null \
> >      | perf script -F ip,sym,iregs -i - 2> /dev/null \
> >      | grep -q "DI:"
> >    then
> > @@ -73,6 +127,8 @@ test_register_capture() {
> >    echo "Register capture test [Success]"
> >  }
> >
> > +build_test_program
> > +
> >  test_per_thread
> >  test_register_capture
> >
> > --
> > 2.38.0.135.g90850a2211-goog
> >

-- 

- Arnaldo
