From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH 2/3] tracing: make sure the parsed string always
 terminates with '\0'
Date: Wed, 10 Jan 2018 11:02:06 +0800
Message-ID: <20180110030206.wciy7y4mvtqoqjz3@intel.com>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
 <1515491748-25926-3-git-send-email-changbin.du@intel.com>
 <20180109180258.3936e10a@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:51275 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755500AbeAJDKW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Jan 2018 22:10:22 -0500
Content-Disposition: inline
In-Reply-To: <20180109180258.3936e10a@vmware.local.home>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, stable@vger.kernel.org

On Tue, Jan 09, 2018 at 06:02:58PM -0500, Steven Rostedt wrote:
> On Tue,  9 Jan 2018 17:55:47 +0800
> changbin.du@intel.com wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > The parser parse every string into parser.buffer. And some of the callers
> > assume that parser.buffer contains a C string. So it is dangerous that the
> > parser returns a unterminated string. The userspace can leverage this to
> > attack the kernel.
> 
> Is this only a bug if we apply your first patch?
>
I don't think so. Seems it is there already.
 
> -- Steve
> 

-- 
Thanks,
Changbin Du
