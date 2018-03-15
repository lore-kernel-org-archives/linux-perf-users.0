From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf trace: __print_array should print hex format
 instead of dec
Date: Thu, 15 Mar 2018 14:49:50 -0300
Message-ID: <20180315174950.GF3690@kernel.org>
References: <1520937557-24895-1-git-send-email-changbin.du@intel.com>
 <20180313142732.GA29837@kernel.org>
 <20180315132025.5825df8c@vmware.local.home>
 <20180315133156.3389b762@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180315133156.3389b762@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, yan.y.zhao@intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Mar 15, 2018 at 01:31:56PM -0400, Steven Rostedt escreveu:
> On Thu, 15 Mar 2018 13:20:25 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 13 Mar 2018 11:27:32 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > Em Tue, Mar 13, 2018 at 06:39:17PM +0800, changbin.du@intel.com escreveu:  
> > > > From: Changbin Du <changbin.du@intel.com>
> > > > 
> > > > The token '__print_array' is to print the array in hex format, but not
> > > > decimal numbers. The implementation of __print_array in kernel side is:
> > > > __print_array()->trace_print_array_seq()
> > > > 
> > > > This patch align the perf's behavior with kernel so we have a consistent
> > > > event format.    
> > > 
> > > Look ok, i.e. makes the userspace formatting do what the equivalent
> > > kernel code does, Rostedt, Ack?
> > >   
> > 
> > Thanks for sending this to me. I'll see how it affects trace-cmd, and
> > let you know.
> >
> 
> Looks good!
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

thanks, applying
