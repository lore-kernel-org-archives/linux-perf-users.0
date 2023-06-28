Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EDFEB64DC
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jun 2023 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjF1I64 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:58:56 -0400
Received: from wp530.webpack.hosteurope.de ([80.237.130.52]:50596 "EHLO
        wp530.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235777AbjF1ImN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Jun 2023 04:42:13 -0400
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qEQkM-0005rp-0R; Wed, 28 Jun 2023 10:41:54 +0200
Message-ID: <2359d385-342b-b025-d90d-cf271a859403@leemhuis.info>
Date:   Wed, 28 Jun 2023 10:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] perf probe: fix regression introduced by switch to
 die_get_decl_file
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     regressions@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230628082337.1857302-1-georgmueller@gmx.net>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230628082337.1857302-1-georgmueller@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687941733;8b8edd79;
X-HE-SMSGID: 1qEQkM-0005rp-0R
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28.06.23 10:23, Georg Müller wrote:
> When switching from dwarf_decl_file() to die_get_decl_file(), a regression
> was introduced when having a binary where the DWARF info is split to
> multiple CUs. It is not possible to add probes to certain functions.
> 
> These patches introduce a testcase which shows the current regression
> and a fix for the issue
> 
> Signed-off-by: Georg Müller <georgmueller@gmx.net>
> Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net/

FWIW, you in both commits might want to add a

 Cc: stable@vger.kernel.org

to ensure the fix is backported to appropriate releases (e.g. 6.4 and
6.3, if the latter doesn't go EOL earlier).

Ciao, Thorsten

P.S.: Some (I guess: most) maintainers prefer if patch series are
startet as new threads
