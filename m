From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/4] perf script: Add script per-event-dump support
Date: Mon, 18 Sep 2017 09:26:02 +0200
Message-ID: <20170918072602.GB11683@krava>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbdIRH0H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Sep 2017 03:26:07 -0400
Content-Disposition: inline
In-Reply-To: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 18, 2017 at 01:55:18PM +0800, yuzhoujian wrote:
> Introduce a new option to print trace output to files named by the
> monitored events and update perf-script documentation accordingly.
> 
> Shown below is output of perf script command with the newly introduced
> option.
> 
>         $perf record -e cycles -e context-switches -ag -- sleep 10
>         $perf script --per-event-dump
>         $ls /
>         cycles.stacks context-switches.stacks

hum, how adding -e option to be consistent with record, like:

	$ perf record -e cycles -e context-switches ...

	$ perf script -e cycles
	--- dumps only cycles to perf.data

	$ perf report -e cycles 
	--- displays only cycles

thanks,
jirka
