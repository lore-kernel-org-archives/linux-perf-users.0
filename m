From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 03/14] perf report: create real callchain entries for
 inlined frames
Date: Fri, 8 Sep 2017 00:16:34 +0900
Message-ID: <CAM9d7ch7Lc7yfMRTrHKZnBop05cYNDA_kb+Hx6bznC-t6EOAUA@mail.gmail.com>
References: <20170806212446.24925-1-milian.wolff@kdab.com> <1935427.QE1zWV8lNS@agathebauer>
 <20170907145853.GA5764@danjae.aot.lge.com> <3394979.u4vPUxEDmB@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3394979.u4vPUxEDmB@milian-kdab2>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

On Fri, Sep 8, 2017 at 12:05 AM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Thursday, September 7, 2017 4:58:53 PM CEST Namhyung Kim wrote:
>> Hi Milian,
>
> Hey Namhyung!
>
>> > > > > @@ -511,10 +563,63 @@ void inline_node__delete(struct inline_node
>> > > > > *node)
>> > > > >
>> > > > >       list_for_each_entry_safe(ilist, tmp, &node->val, list) {
>> > > > >
>> > > > >               list_del_init(&ilist->list);
>> > > > >
>> > > > > -             zfree(&ilist->filename);
>> > > > > -             zfree(&ilist->funcname);
>> > > > > +             zfree(&ilist->srcline);
>> > > > > +             // only the inlined symbols are owned by the list
>> > > > > +             if (ilist->symbol && ilist->symbol->inlined)
>> > > > > +                     symbol__delete(ilist->symbol);
>> > > >
>> > > > Existing symbols are released at this moment.
>> > >
>> > > Thanks for the review, I'll try to look into these issues once I have
>> > > more
>> > > time again.
>> >
>> > OK, so I just dug into this part of the patch again. I don't think it's
>> > actually a problem after all:
>> >
>> > When an inline node reuses the real symbol, that symbol won't have its
>> > `inlined` member set to true. Thus these symbols will never get deleted by
>> > inline_node__delete.
>>
>> But ilist->symbol is a dangling pointer so accessing ->inlined would
>> be a problem, no?
>
> Sorry, but I can't follow. Why would it be a dangling pointer? Note, again,
> that I've tested this with both valgrind and ASAN and neither reports any
> issues about this code.

IIUC, ilist->symbol can point an existing symbol.  And all existing
symbols are freed before calling inline_node__delete().  I don't know
why valgrind or asan didn't catch anything.. maybe I'm missing
something.

-- 
Thanks,
Namhyung
