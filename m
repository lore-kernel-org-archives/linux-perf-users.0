From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pfn_t: force '~' to be parsed as an unary operator
Date: Wed, 24 Oct 2018 15:43:16 -0700
Message-ID: <20181024154316.810676f4b8eb9be637a34e28@linux-foundation.org>
References: <20181021145939.8760-1-sebhtml@videotron.qc.ca>
        <CAPcyv4iJ_bfzOtV_GAQg_tdLLuebE_1Gp420LMG0xbR2ZQdV7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4iJ_bfzOtV_GAQg_tdLLuebE_1Gp420LMG0xbR2ZQdV7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: sebhtml@videotron.qc.ca, Steven Rostedt <rostedt@goodmis.org>, acme@redhat.com, tz.stoyanov@gmail.com, Namhyung Kim <namhyung@kernel.org>, zwisler@kernel.org, arangradient@gmail.com, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, 22 Oct 2018 10:13:48 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> [ added Andrew ]
> 
> Patch here: https://lore.kernel.org/patchwork/patch/1002234/
> 
> On Sun, Oct 21, 2018 at 8:00 AM Sebastien Boisvert
> <sebhtml@videotron.qc.ca> wrote:
> >
> > Tracing the event "fs_dax:dax_pmd_insert_mapping" with perf produces this
> > warning:
> >       [fs_dax:dax_pmd_insert_mapping] unknown op '~'
> >
> > It is printed in process_op (tools/lib/traceevent/event-parse.c) because '~'
> > is parsed as a binary operator.
> >
> > perf reads the format of fs_dax:dax_pmd_insert_mapping ("print fmt") from
> > /sys/kernel/debug/tracing/events/fs_dax/dax_pmd_insert_mapping/format .
> >
> > The format contains:
> >
> > ~(((u64) ~(~(((1UL) << 12)-1)))
> >          ^
> >          \ interpreted as a binary operator by process_op().
> >
> > This part is generated in the declaration of the event class
> > dax_pmd_insert_mapping_class in include/trace/events/fs_dax.h :
> >
> >                 __print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
> >                         PFN_FLAGS_TRACE),
> >
> > This patch adds a pair of parentheses in the declaration of PFN_FLAGS_MASK to
> > make sure that '~' is parsed as a unary operator by perf.
> >
> > The part of the format that was problematic is now:
> >
> > ~(((u64) (~(~(((1UL) << 12)-1))))
> >
> > Now, all the '~' are parsed as unary operators.
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> 
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> 

I grabbed it, and added cc:stable.

But aren't we fixing this in the wrong place?  That's a valid
expression and if this isn't addressed in perf then we may hit a
similar issue elsewhere...
