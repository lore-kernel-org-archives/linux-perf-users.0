From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 17/17] perf annotate: Handle variables in 'sub', 'or' and
 many other instructions
Date: Tue, 17 Apr 2018 09:51:04 -0300
Message-ID: <20180417125104.GB3553@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
 <20180413140111.25313-18-acme@kernel.org>
 <20180413162043.GD6694@tassilo.jf.intel.com>
 <20180413172035.GB26496@kernel.org>
 <20180413173940.GE6694@tassilo.jf.intel.com>
 <20180417025628.GB31947@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180417025628.GB31947@sejong>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Apr 17, 2018 at 11:56:28AM +0900, Namhyung Kim escreveu:
> Hi,
> 
> On Fri, Apr 13, 2018 at 10:39:40AM -0700, Andi Kleen wrote:
> > > What do I miss? Or where is it that I'm misinterpreting the calculations
> > > that objdump did in its output?
> > 
> > The calculations are right, but these are still two different address modes.
> > You cannot just turn one silently into the other.
> > 
> > I think it would be ok to use the syntax in the assembler
> > 
> > symbol(%rip)  with no # ...
> 
> One thing I find useful is to show string constant if the address is
> in the rodata (and printable of course).  Maybe something like below..
> 
>   lea    0x1234(%rip),%rdi    # "hello world\n"
>   callq  printf
> 
> 
> Just an idea.

Send some more :-)

/me adds to the todo.annotate folder...

- Arnaldo
