From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v2 1/4] Add a new element for the struct perf_tool, and
 add the --per-event-dump option for perf script
Date: Mon, 25 Sep 2017 20:44:26 -0600
Message-ID: <d48e0922-2d17-b975-a116-5d51bddc026a@gmail.com>
References: <1506251547-35909-1-git-send-email-yuzhoujian@didichuxing.com>
 <1506251547-35909-2-git-send-email-yuzhoujian@didichuxing.com>
 <20170925125614.GA15076@krava>
 <CAHCio2hkYkgqiMEaz=miTDGNvDwR89xVPvJWBw_3kkB42gUTNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:52055 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966127AbdIZCo3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Sep 2017 22:44:29 -0400
In-Reply-To: <CAHCio2hkYkgqiMEaz=miTDGNvDwR89xVPvJWBw_3kkB42gUTNQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>, Jiri Olsa <jolsa@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Wind Yu <yuzhoujian@didichuxing.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On 9/25/17 8:41 PM, 禹舟键 wrote:
> The changelogs are in the cover-letter.
> changes in v2:
>         - remove the set of script.tool.per_event_dump variable.
>         - add the __maybe_unused attribute for the fp argument in the
> second patch.
>         - remove the fp_selection_helper function for setting the fp
> argument.
>         - split the original second patch(Makes all those related
> functions receive the FILE pointer) to two patches.
>         - modify the file name of per-event-dump to <ORIGINAL PERF DATA
> FILE NAME>-script-dump-<EVENT NAME>.txt

Each patch should have a single focus and a changelog describing what is
changed and why. Impacts to the user experience should have example output.
