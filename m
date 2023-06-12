Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7514C7EE2E
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 19:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbjFLTCE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbjFLTCD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 15:02:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446F191;
        Mon, 12 Jun 2023 12:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05F5361E69;
        Mon, 12 Jun 2023 19:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBD3C4339B;
        Mon, 12 Jun 2023 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686596521;
        bh=IhObLeclTmvSH1UpIW27KQ0g0HG4GLrPKfddXj9eH9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8Xpb8A7laktpyIDDzwdsLltNKMnBZf1+QmyIiv0dz2gh+RE/gQ/6ktdZgU4e10qn
         Rq3yjTdnvx4S8b7vxv/CYoPEHG2RtE2/TBhD20hefrhCJCcV8XSOFoXUpmcKtk4hz1
         ByKXd7xwz//kcgmtvfTrbhUeCz8j2+YJ16TA2h/cExahq9CTR1QYtTjoMDaHkDUoOW
         4OhxsrHtkEET/IWBpl8y1qT1M6zSmgRkiRMqA1pm1Ml173Dx18s4vfT8CEKDOybcZu
         7SY73riBV7oDEC0ZgCNxB5Tv1XJ0BsZQAjqGTJXnwI3NL1IuSuqeVn14lzhtVlMFZb
         5Bhiq/Yy6+y1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 252C940692; Mon, 12 Jun 2023 16:01:59 -0300 (-03)
Date:   Mon, 12 Jun 2023 16:01:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4]  Avoid some large stack allocations
Message-ID: <ZIdrp9OzTjQU32xZ@kernel.org>
References: <20230527034324.2597593-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230527034324.2597593-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, May 26, 2023 at 08:43:18PM -0700, Ian Rogers escreveu:
> Following on cleaning up .data and .bss in:
> https://lore.kernel.org/lkml/20230526183401.2326121-1-irogers@google.com/
> Look for some probably too large stack allocations with -Wstack-usage=20000
> and pahole.

Thanks, applied.

- Arnaldo

 
> Don't attempt to cleanup variable length arrays like in:
> ```
> util/header.c: In function ‘write_cache’:
> util/header.c:1269:12: warning: stack usage might be unbounded [-Wstack-usage=]
>  1269 | static int write_cache(struct feat_fd *ff,
>       |            ^~~~~~~~~~~
> ```
> 
> Also leave two allocations relating to session/event processing:
> ```
> util/auxtrace.c: In function ‘auxtrace_queues__add_indexed_event’:
> util/auxtrace.c:424:12: warning: stack usage is 65616 bytes [-Wstack-usage=]
>   424 | static int auxtrace_queues__add_indexed_event(struct auxtrace_queues *queues,
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/session.c: In function ‘perf_session__peek_events’:
> util/session.c:1822:5: warning: stack usage is 65648 bytes [-Wstack-usage=]
>  1822 | int perf_session__peek_events(struct perf_session *session, u64 offset,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~
> ```
> 
> The biggest win is for perf inject where 128kb becomes lazily
> allocated when aux or guest data is encountered.
> 
> Ian Rogers (4):
>   perf sched: Avoid large stack allocations
>   perf script: Remove some large stack allocations
>   perf inject: Lazily allocate event_copy
>   perf inject: Lazily allocate guest_event event_buf
> 
>  tools/perf/builtin-inject.c | 31 +++++++++++++++++++++++++------
>  tools/perf/builtin-sched.c  | 26 ++++++++++++++++++++++----
>  tools/perf/builtin-script.c | 17 +++++++++++++----
>  3 files changed, 60 insertions(+), 14 deletions(-)
> 
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 

-- 

- Arnaldo
