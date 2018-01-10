From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] tracing: make sure the parsed string always
 terminates with '\0'
Date: Tue, 9 Jan 2018 23:10:22 -0500
Message-ID: <20180109231022.5e9ca245@vmware.local.home>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
        <1515491748-25926-3-git-send-email-changbin.du@intel.com>
        <20180109180258.3936e10a@vmware.local.home>
        <20180110030206.wciy7y4mvtqoqjz3@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180110030206.wciy7y4mvtqoqjz3@intel.com>
Sender: stable-owner@vger.kernel.org
To: "Du, Changbin" <changbin.du@intel.com>
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, 10 Jan 2018 11:02:06 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> On Tue, Jan 09, 2018 at 06:02:58PM -0500, Steven Rostedt wrote:
> > On Tue,  9 Jan 2018 17:55:47 +0800
> > changbin.du@intel.com wrote:
> >   
> > > From: Changbin Du <changbin.du@intel.com>
> > > 
> > > The parser parse every string into parser.buffer. And some of the callers
> > > assume that parser.buffer contains a C string. So it is dangerous that the
> > > parser returns a unterminated string. The userspace can leverage this to
> > > attack the kernel.  
> > 
> > Is this only a bug if we apply your first patch?
> >  
> I don't think so. Seems it is there already.
>  

OK. I'll have to take a deeper look into this so that I completely
understand the problem and your solution. I'm currently traveling and
may not get to do that this week. Please ping me next week if you don't
hear back from me on this issue.

Thanks!

-- Steve
