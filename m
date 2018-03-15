From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] perf trace: __print_array should print hex format
 instead of dec
Date: Thu, 15 Mar 2018 13:20:25 -0400
Message-ID: <20180315132025.5825df8c@vmware.local.home>
References: <1520937557-24895-1-git-send-email-changbin.du@intel.com>
        <20180313142732.GA29837@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313142732.GA29837@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, yan.y.zhao@intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, 13 Mar 2018 11:27:32 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Mar 13, 2018 at 06:39:17PM +0800, changbin.du@intel.com escreveu:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > The token '__print_array' is to print the array in hex format, but not
> > decimal numbers. The implementation of __print_array in kernel side is:
> > __print_array()->trace_print_array_seq()
> > 
> > This patch align the perf's behavior with kernel so we have a consistent
> > event format.  
> 
> Look ok, i.e. makes the userspace formatting do what the equivalent
> kernel code does, Rostedt, Ack?
> 

Thanks for sending this to me. I'll see how it affects trace-cmd, and
let you know.

-- Steve
