From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 0/3] tracing: Fix the parser when processing strings
 w/ or w/o terminated '\0'
Date: Wed, 17 Jan 2018 14:45:24 +0900
Message-ID: <20180117054524.GB7530@danjae.aot.lge.com>
References: <1516093350-12045-1-git-send-email-changbin.du@intel.com>
 <20180116124226.73d2c7e2@gandalf.local.home>
 <20180117045433.sg2kbbx3x2nqnsoo@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36254 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeAQFs0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Jan 2018 00:48:26 -0500
Content-Disposition: inline
In-Reply-To: <20180117045433.sg2kbbx3x2nqnsoo@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com

Hello,

On Wed, Jan 17, 2018 at 12:54:34PM +0800, Du, Changbin wrote:
> On Tue, Jan 16, 2018 at 12:42:26PM -0500, Steven Rostedt wrote:
> > On Tue, 16 Jan 2018 17:02:27 +0800
> > changbin.du@intel.com wrote:
> > 
> > > From: Changbin Du <changbin.du@intel.com>
> > > 
> > > I found there are some problems in the tracing parser when I investiage the root
> > > cause of issues mentioned in below patch.
> > > https://patchwork.kernel.org/patch/10132953/
> > 
> > I pulled in your patches and tweaked the change logs of the other two
> > patches as well. You can see my temporary git tree here, but it may
> > rebase.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> > 
> >  ftrace/core
> > 
> > -- Steve
> Got it. Thank you!
> 
> Hi Olsa, so the perf patch 'perf ftrace: Fix the buffer size in__write_tracing_file'
> is still needed. I will resend you at appropriate time.

But it will work on the future kernels only, right?  For tools to be
compatible with old kernels, you'd better writing a whitespace after
the function name IMHO.

Thanks,
Namhyung
