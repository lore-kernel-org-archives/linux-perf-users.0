From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH v3 0/3] tracing: Fix the parser when processing strings
 w/ or w/o terminated '\0'
Date: Wed, 17 Jan 2018 12:54:34 +0800
Message-ID: <20180117045433.sg2kbbx3x2nqnsoo@intel.com>
References: <1516093350-12045-1-git-send-email-changbin.du@intel.com>
 <20180116124226.73d2c7e2@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31680 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeAQFCz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Jan 2018 00:02:55 -0500
Content-Disposition: inline
In-Reply-To: <20180116124226.73d2c7e2@gandalf.local.home>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Tue, Jan 16, 2018 at 12:42:26PM -0500, Steven Rostedt wrote:
> On Tue, 16 Jan 2018 17:02:27 +0800
> changbin.du@intel.com wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > I found there are some problems in the tracing parser when I investiage the root
> > cause of issues mentioned in below patch.
> > https://patchwork.kernel.org/patch/10132953/
> 
> I pulled in your patches and tweaked the change logs of the other two
> patches as well. You can see my temporary git tree here, but it may
> rebase.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> 
>  ftrace/core
> 
> -- Steve
Got it. Thank you!

Hi Olsa, so the perf patch 'perf ftrace: Fix the buffer size in__write_tracing_file'
is still needed. I will resend you at appropriate time.

-- 
Thanks,
Changbin Du
