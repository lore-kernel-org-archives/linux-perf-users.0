From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH 2/3] tracing: make sure the parsed string always
 terminates with '\0'
Date: Mon, 15 Jan 2018 18:49:50 +0800
Message-ID: <20180115104950.u33gj7h4of7mlekx@intel.com>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
 <1515491748-25926-3-git-send-email-changbin.du@intel.com>
 <20180109180258.3936e10a@vmware.local.home>
 <20180110030206.wciy7y4mvtqoqjz3@intel.com>
 <20180109231022.5e9ca245@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:30270 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753648AbeAOK6I (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Jan 2018 05:58:08 -0500
Content-Disposition: inline
In-Reply-To: <20180109231022.5e9ca245@vmware.local.home>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Du, Changbin" <changbin.du@intel.com>, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, stable@vger.kernel.org

On Tue, Jan 09, 2018 at 11:10:22PM -0500, Steven Rostedt wrote:
> On Wed, 10 Jan 2018 11:02:06 +0800
> "Du, Changbin" <changbin.du@intel.com> wrote:
> 
> > On Tue, Jan 09, 2018 at 06:02:58PM -0500, Steven Rostedt wrote:
> > > On Tue,  9 Jan 2018 17:55:47 +0800
> > > changbin.du@intel.com wrote:
> > >   
> > > > From: Changbin Du <changbin.du@intel.com>
> > > > 
> > > > The parser parse every string into parser.buffer. And some of the callers
> > > > assume that parser.buffer contains a C string. So it is dangerous that the
> > > > parser returns a unterminated string. The userspace can leverage this to
> > > > attack the kernel.  
> > > 
> > > Is this only a bug if we apply your first patch?
> > >  
> > I don't think so. Seems it is there already.
> >  
> 
> OK. I'll have to take a deeper look into this so that I completely
> understand the problem and your solution. I'm currently traveling and
> may not get to do that this week. Please ping me next week if you don't
> hear back from me on this issue.
> 
> Thanks!
> 
> -- Steve

I checked every trace_get_user() clients again and found it is not an issue in
current kernel. The client has checked trace_parser_cont() before using parsed
string or append '\0'.

I still want to make the parser returns a '\0' terminated string. Then we don't
require the clients append it. I think this would be better since we are dealing
with strings.

-- 
Thanks,
Changbin Du
