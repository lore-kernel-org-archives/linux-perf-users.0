Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C15C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 21:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBA761209
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 21:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhINVWs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 17:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234866AbhINVWm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 17:22:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DC5461209;
        Tue, 14 Sep 2021 21:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631654484;
        bh=/XicsGZc2g3wu3bXlK+QfX1UuqeEudR+OFBINtUeNJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5Y2YLMAwHiDaghA7XreWpoiYZrUuguvSr9sGxWEcT8iPAQSGGzTVCrtI1hU1mWUm
         bvhuBvTYe/uI+fH0c7j7AzB6QTjaAKLjc3Iw40Ppg+g0hz12CxtbSROGoVUjxvWeTt
         vYkzBmg2NSNhdBfIyyI24Z9U35EbmDZ97EP+WyTogVI/syXZdOjespJQckRmS8aai8
         Mu+ee3pozLu8aff2n+V22O7yzaFq0k+Yxemj93MUi3nBF51I2SYALMVlav12aiWd+Z
         5We6PrJQ+66yfdPD5s0saTlRy6SPs3QuGP7xDNfU03t81Azhyy/OnuBdIC8DH/6ifq
         yMX6brrMzgJ9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE71F4038F; Tue, 14 Sep 2021 18:21:20 -0300 (-03)
Date:   Tue, 14 Sep 2021 18:21:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     acme@redhat.com, linux-perf-users@vger.kernel.org,
        jolsa@redhat.com, jlelli@redhat.com, milian.wolff@kdab.com
Subject: Re: [PATCH] perf machine: Initialize srcline string member in
 add_location struct
Message-ID: <YUESUBs5STNG2sIT@kernel.org>
References: <20210719145332.29747-1-mpetlan@redhat.com>
 <YToIuTUuudHKZmN2@kernel.org>
 <alpine.LRH.2.20.2109131651090.27231@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2109131651090.27231@Diego>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Sep 13, 2021 at 05:13:12PM +0200, Michael Petlan escreveu:
> On Thu, 9 Sep 2021, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jul 19, 2021 at 04:53:32PM +0200, Michael Petlan escreveu:
> > > It's later supposed to be either a correct address or NULL. Without the
> > > initialization, it may contain an undefined value which results in the
> > > following segmentation fault:
> > > 
> > >   # perf top --sort comm -g --ignore-callees=do_idle
> > 
> > Later where? The backtrace below is unresolved, I couldn't reproduce it
> > here, that al variable is local to add_callchain_ip(), and is then
> > passed to several places where I couldn't find al->srcline being used,
> > can you state where it is used and causes the segfault?
> > 
> 
> Here is a better backtrace of a segfault:
 
> #0  0x00007ffff56b7685 in __strlen_avx2 () from /lib64/libc.so.6
> #1  0x00007ffff55e3802 in strdup () from /lib64/libc.so.6
> #2  0x00005555558cb139 in hist_entry__init (callchain_size=<optimized out>, sample_self=true, template=0x7fffde7fb110, he=0x7fffd801c250) at util/hist.c:489
> #3  hist_entry__new (template=template@entry=0x7fffde7fb110, sample_self=sample_self@entry=true) at util/hist.c:564
> #4  0x00005555558cb4ba in hists__findnew_entry (hists=hists@entry=0x5555561d9e38, entry=entry@entry=0x7fffde7fb110, al=al@entry=0x7fffde7fb420, 
>     sample_self=sample_self@entry=true) at util/hist.c:657
> #5  0x00005555558cba1b in __hists__add_entry (hists=hists@entry=0x5555561d9e38, al=0x7fffde7fb420, sym_parent=<optimized out>, bi=bi@entry=0x0, mi=mi@entry=0x0, 
>     sample=sample@entry=0x7fffde7fb4b0, sample_self=true, ops=0x0, block_info=0x0) at util/hist.c:288
> #6  0x00005555558cbb70 in hists__add_entry (sample_self=true, sample=0x7fffde7fb4b0, mi=0x0, bi=0x0, sym_parent=<optimized out>, al=<optimized out>, hists=0x5555561d9e38)
>     at util/hist.c:1056
> #7  iter_add_single_cumulative_entry (iter=0x7fffde7fb460, al=<optimized out>) at util/hist.c:1056
> #8  0x00005555558cc8a4 in hist_entry_iter__add (iter=iter@entry=0x7fffde7fb460, al=al@entry=0x7fffde7fb420, max_stack_depth=<optimized out>, arg=arg@entry=0x7fffffff7db0)
>     at util/hist.c:1231
> #9  0x00005555557cdc9a in perf_event__process_sample (machine=<optimized out>, sample=0x7fffde7fb4b0, evsel=<optimized out>, event=<optimized out>, tool=0x7fffffff7db0)
>     at builtin-top.c:842
> #10 deliver_event (qe=<optimized out>, qevent=<optimized out>) at builtin-top.c:1202
> #11 0x00005555558a9318 in do_flush (show_progress=false, oe=0x7fffffff80e0) at util/ordered-events.c:244
> #12 __ordered_events__flush (oe=oe@entry=0x7fffffff80e0, how=how@entry=OE_FLUSH__TOP, timestamp=timestamp@entry=0) at util/ordered-events.c:323
> #13 0x00005555558a9789 in __ordered_events__flush (timestamp=<optimized out>, how=<optimized out>, oe=<optimized out>) at util/ordered-events.c:339
> #14 ordered_events__flush (how=OE_FLUSH__TOP, oe=0x7fffffff80e0) at util/ordered-events.c:341
> #15 ordered_events__flush (oe=oe@entry=0x7fffffff80e0, how=how@entry=OE_FLUSH__TOP) at util/ordered-events.c:339
> #16 0x00005555557cd631 in process_thread (arg=0x7fffffff7db0) at builtin-top.c:1114
> #17 0x00007ffff7bb817a in start_thread () from /lib64/libpthread.so.0
> #18 0x00007ffff5656dc3 in clone () from /lib64/libc.so.6
> 
> If you look at the frame #2, the code is:
> 
> 488      if (he->srcline) {
> 489          he->srcline = strdup(he->srcline);
> 490          if (he->srcline == NULL)
> 491              goto err_rawdata;
> 492      }
> 
> If he->srcline is not NULL (it is not NULL if it is uninitialized rubbish),
> it gets strdupped and strdupping a rubbish random string causes the problem.
> 
> Also, if you look at the commit 1fb7d06a509e, it adds the srcline property
> into the struct, but not initializing it everywhere needed.

Now I see, when using --ignore-callees=do_idle we end up here in
add_callchain_ip():

2181         if (al.sym != NULL) {
2182                 if (perf_hpp_list.parent && !*parent &&
2183                     symbol__match_regex(al.sym, &parent_regex))
2184                         *parent = al.sym;
2185                 else if (have_ignore_callees && root_al &&
2186                   symbol__match_regex(al.sym, &ignore_callees_regex)) {
2187                         /* Treat this symbol as the root,
2188                            forgetting its callees. */
2189                         *root_al = al;
2190                         callchain_cursor_reset(cursor);
2191                 }
2192         }

And the al that doesn't have the ->srcline field initialized will be
copied to the root_al, so then, back to:

1211 int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
1212                          int max_stack_depth, void *arg)
1213 {
1214         int err, err2;
1215         struct map *alm = NULL;
1216
1217         if (al)
1218                 alm = map__get(al->map);
1219
1220         err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
1221                                         iter->evsel, al, max_stack_depth);
1222         if (err) {
1223                 map__put(alm);
1224                 return err;
1225         }
1226
1227         err = iter->ops->prepare_entry(iter, al);
1228         if (err)
1229                 goto out;
1230
1231         err = iter->ops->add_single_entry(iter, al);
1232         if (err)
1233                 goto out;
1234

That al at line 1221 is what hist_entry_iter__add() (called from
sample__resolve_callchain()) saw as 'root_al', and then:

	iter->ops->add_single_entry(iter, al);

will go on with al->srcline with a bogus value, I'll add the above
sequence to the cset and apply, thanks!

- Arnaldo

 
> Michael
> 
> > - Arnaldo
> >  
> > > terminates with
> > > 
> > >   perf: Segmentation fault
> > >   -------- backtrace --------
> > >   perf(+0x417b26)[0x557794f1fb26]
> > >   /lib64/libc.so.6(+0x37400)[0x7f62a0194400]
> > >   /lib64/libc.so.6(+0x15d685)[0x7f62a02ba685]
> > >   /lib64/libc.so.6(__strdup+0x12)[0x7f62a01e6802]
> > >   perf(+0x3769d9)[0x557794e7e9d9]
> > >   perf(+0x376d3a)[0x557794e7ed3a]
> > >   perf(+0x377284)[0x557794e7f284]
> > >   perf(+0x3773e0)[0x557794e7f3e0]
> > >   perf(hist_entry_iter__add+0xc4)[0x557794e80114]
> > >   perf(+0x2799aa)[0x557794d819aa]
> > >   perf(+0x354ec8)[0x557794e5cec8]
> > >   perf(+0x279341)[0x557794d81341]
> > >   /lib64/libpthread.so.0(+0x814a)[0x7f62a27b514a]
> > >   /lib64/libc.so.6(clone+0x43)[0x7f62a0259dc3]
> > > 
> > > Fixes: 1fb7d06a509e ("perf report: Use srcline from callchain for hist entries")
> > > 
> > > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > > Reported-by: Juri Lelli <jlelli@redhat.com>
> > > CC: Milian Wolff <milian.wolff@kdab.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/machine.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index da19be7da284..44e40bad0e33 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -2149,6 +2149,7 @@ static int add_callchain_ip(struct thread *thread,
> > >  
> > >  	al.filtered = 0;
> > >  	al.sym = NULL;
> > > +	al.srcline = NULL;
> > >  	if (!cpumode) {
> > >  		thread__find_cpumode_addr_location(thread, ip, &al);
> > >  	} else {
> > > -- 
> > > 2.18.4
> > > 
> > 
> > -- 
> > 
> > - Arnaldo
> > 
> > 

-- 

- Arnaldo
