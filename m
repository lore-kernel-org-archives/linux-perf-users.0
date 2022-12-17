Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0064C4332F
	for <linux-perf-users@archiver.kernel.org>; Sat, 17 Dec 2022 16:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiLQQNh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 17 Dec 2022 11:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiLQQNh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Dec 2022 11:13:37 -0500
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Dec 2022 08:13:35 PST
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3105FCC
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Dec 2022 08:13:35 -0800 (PST)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 0D3ADA070E;
        Sat, 17 Dec 2022 16:05:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 5BAA920015;
        Sat, 17 Dec 2022 16:05:32 +0000 (UTC)
Date:   Sat, 17 Dec 2022 11:05:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kautuk Consul <kconsul@ventanamicro.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikita Shubin <n.shubin@yadro.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools changes for v6.2: 1st batch
User-Agent: K-9 Mail for Android
In-Reply-To: <Y53XHw3rlsaaUgOs@kernel.org>
References: <20221216143609.186415-1-acme@kernel.org> <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com> <Y53XHw3rlsaaUgOs@kernel.org>
Message-ID: <89FBC20F-E29E-4639-A505-554D7BB8809C@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5BAA920015
X-Stat-Signature: w9rru6zj8hr6ijwpsktk1zoctqxiq17u
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++HiwiChKEpfeEbXkXleVw7k5adtwrqvY=
X-HE-Tag: 1671293132-499959
X-HE-Meta: U2FsdGVkX181UWrq+rfyblOitY5OluchEqi5nK/81w3LghVlspe7u+f6W3hpfeENYYRfgW8GmV0/6dIxqCYhLw==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On December 17, 2022 9:50:07 AM EST, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

>
>And below you have it, now back to the pool, the kids are waiting :-)
>

Sure, rub it in to those of us in North America dealing with a snow storm!

-- Steve

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
