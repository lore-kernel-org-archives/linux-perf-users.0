From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf report: include partial stacks unwound with libdw
Date: Fri, 2 Jun 2017 11:59:22 -0300
Message-ID: <20170602145922.GA7901@redhat.com>
References: <20170601210021.20046-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751128AbdFBO71 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jun 2017 10:59:27 -0400
Content-Disposition: inline
In-Reply-To: <20170601210021.20046-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, acme@kernel.org

Em Thu, Jun 01, 2017 at 11:00:21PM +0200, Milian Wolff escreveu:
> With this patch applied, the libdw unwinder will produce the same
> output as the libunwind unwinder.

> +++ b/tools/perf/util/unwind-libdw.c
> @@ -224,7 +224,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  
>  	err = dwfl_getthread_frames(ui->dwfl, thread->tid, frame_callback, ui);
>  
> -	if (err && !ui->max_stack)
> +	if (err && ui->max_stack != max_stack)
>  		err = 0;

Simple enough, thanks a lot, applied!

- Arnaldo
