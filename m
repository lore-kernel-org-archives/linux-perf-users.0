From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf report: distinguish between inliners in the same
 function
Date: Wed, 17 May 2017 15:13:16 +0900
Message-ID: <20170517061316.GE32691@danjae.aot.lge.com>
References: <20170503213536.13905-1-milian.wolff@kdab.com>
 <25337947.y8Q11MWckQ@milian-kdab2>
 <20170516005332.GA4885@sejong>
 <2100411.JFybRMHOWM@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33856 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbdEQGNb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2017 02:13:31 -0400
Content-Disposition: inline
In-Reply-To: <2100411.JFybRMHOWM@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Tue, May 16, 2017 at 03:18:13PM +0200, Milian Wolff wrote:
> On Dienstag, 16. Mai 2017 02:53:32 CEST Namhyung Kim wrote:
> > On Mon, May 15, 2017 at 12:01:54PM +0200, Milian Wolff wrote:
> > > On Monday, May 15, 2017 3:21:58 AM CEST Namhyung Kim wrote:
> > > > Hi Milian,
> > > > 
> > > > On Sun, May 14, 2017 at 08:10:50PM +0200, Milian Wolff wrote:
> > > > > On Freitag, 12. Mai 2017 15:01:29 CEST Namhyung Kim wrote:
> > > > I think you'd be better adding (fake) dso and sym to keep the inline
> > > > information.  The fake dso can be paired with the original dso and
> > > > maintain a tree of (inlined) symbols.  You may need a fake map to
> > > > point the fake dso then.  It seems a bit compilcated but that way the
> > > > code will be more consistent and easier to handle (e.g. for caching
> > > > and/or deletion) IMHO.
> > > 
> > > Can you expand on this please? How would that solve the problem of finding
> > > a function name or srcline for a given inline frame?
> > > 
> > > I.e.: the function name is, currently, part of the sym. So the fake
> > > dso/map
> > > would contain an internal, fake, string table which fake symbols could
> > > leverage for the function name?
> > > 
> > > Sounds like doable, but also sounds like *a lot* of work. And I don't see
> > > how that would solve the srcline situation: That one is queried on-demand
> > > based on the IP of a frame. I would say that inline frames should keep
> > > the IP of the first non-inlined frame. But that would make it impossible
> > > to find the srcline for the N'th inlined frame... Am I missing something?
> > 
> > I agree that srcline info can be kept in callchain cursor nodes, but I
> > still think function name should be in (fake) symbols.  Sharing a
> > symbol for all inlined frames would not work for the children mode
> > IMHO.
> 
> I'm running into a bit of trouble here. I hoped to be able to store the 
> inlined symbol in the DSO to reuse it for other inlined entries that use the 
> same function. I also hope that this will then take care of the deletion of 
> the fake symbols, once the dso is freed.

I don't want to store inlined functions to an original DSO as it would
confuse symbol lookups in the DSO.  As you said those inlined
functions will have same address so multiple symbols exist for an
address.

I thought they can be kept in a fake DSO which should be linked to the
original DSO, but it doesn't need to be a DSO.  Instead a DSO can have
a tree that maintains lists of (inlined) symbols and srclines sorted
by address.


> 
> To do this, I thought I could use dso__find_symbol_by_name and, if nothing was 
> found, I create the new fake symbol by symbol__new and insert it via 
> dso__insert_symbol. Apparently, I also need to update the sorted lookup table, 
> so I call dso__sort_by_name, but that then leads to crashes:
> 
> ==22675== Invalid write of size 8
> ==22675==    at 0x4D89FC: rb_link_node (rbtree.h:82)
> ==22675==    by 0x4D89FC: symbols__insert_by_name (symbol.c:387)
> ==22675==    by 0x4D89FC: symbols__sort_by_name (symbol.c:398)
> ==22675==    by 0x4D89FC: dso__sort_by_name (symbol.c:512)
> ==22675==    by 0x4EB704: unwind_entry (machine.c:2061)
> ==22675==    by 0x55BCF7: entry (unwind-libunwind-local.c:600)
> ==22675==    by 0x55BCF7: get_entries (unwind-libunwind-local.c:723)
> ==22675==    by 0x55BE01: _unwind__get_entries (unwind-libunwind-local.c:745)
> ==22675==    by 0x4E8B20: sample__resolve_callchain (callchain.c:1016)
> ==22675==    by 0x5196F9: hist_entry_iter__add (hist.c:1039)
> ==22675==    by 0x448044: process_sample_event (builtin-report.c:204)
> ==22675==    by 0x4F61DD: perf_evlist__deliver_sample (session.c:1211)
> ==22675==    by 0x4F61DD: machines__deliver_event (session.c:1248)
> ==22675==    by 0x4F66D3: perf_session__deliver_event (session.c:1310)
> ==22675==    by 0x4F66D3: ordered_events__deliver_event (session.c:119)
> ==22675==    by 0x4F9CD2: __ordered_events__flush (ordered-events.c:210)
> ==22675==    by 0x4F9CD2: ordered_events__flush.part.3 (ordered-events.c:277)
> ==22675==    by 0x4F6DEC: perf_session__process_user_event (session.c:1349)
> ==22675==    by 0x4F6DEC: perf_session__process_event (session.c:1475)
> ==22675==    by 0x4F8C5C: __perf_session__process_events (session.c:1867)
> ==22675==    by 0x4F8C5C: perf_session__process_events (session.c:1921)
> ==22675==  Address 0xd1fae38 is 24 bytes before a block of size 54 alloc'd
> ==22675==    at 0x4C2CF35: calloc (in /usr/lib/valgrind/vgpreload_memcheck-
> amd64-linux.so)
> ==22675==    by 0x4D80F0: symbol__new (symbol.c:240)
> ==22675==    by 0x54750E: dso__load_sym (symbol-elf.c:1121)
> ==22675==    by 0x4D9D3E: dso__load (symbol.c:1535)
> ==22675==    by 0x4F262B: map__load (map.c:292)
> ==22675==    by 0x4F262B: map__find_symbol (map.c:335)
> ==22675==    by 0x4B3B55: thread__find_addr_location (event.c:1458)
> ==22675==    by 0x55BC70: entry (unwind-libunwind-local.c:588)
> ==22675==    by 0x55BC70: get_entries (unwind-libunwind-local.c:723)
> ==22675==    by 0x55BE01: _unwind__get_entries (unwind-libunwind-local.c:745)
> ==22675==    by 0x4E8B20: sample__resolve_callchain (callchain.c:1016)
> ==22675==    by 0x5196F9: hist_entry_iter__add (hist.c:1039)
> ==22675==    by 0x448044: process_sample_event (builtin-report.c:204)
> ==22675==    by 0x4F61DD: perf_evlist__deliver_sample (session.c:1211)
> ==22675==    by 0x4F61DD: machines__deliver_event (session.c:1248)
> ==22675== 
> 
> Here's the patch that I tried to play around with this concept:
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index a98f55a91cb2..4d1b6e58da00 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2037,6 +2037,38 @@ static int unwind_entry(struct unwind_entry *entry, 
> void *arg)
>  
>         if (symbol_conf.hide_unresolved && entry->sym == NULL)
>                 return 0;
> +
> +       if (symbol_conf.inline_name && entry->map) {
> +               u64 addr = map__rip_2objdump(entry->map, entry->ip);
> +               struct inline_node *inline_node;
> +               inline_node = dso__parse_addr_inlines(entry->map->dso, addr);
> +               if (inline_node) {
> +                       struct inline_list *ilist;
> +                       list_for_each_entry(ilist, &inline_node->val, list) {
> +                               struct symbol *sym;
> +                               sym = dso__find_symbol_by_name(entry->map-
> >dso,
> +                                                              MAP__FUNCTION,
> +                                                              ilist-
> >funcname);
> +                               if (!sym) {
> +                                       fprintf(stderr, "create new entry\n");
> +                                       sym = symbol__new(entry->sym->start,
> +                                                         entry->sym->end,
> +                                                         entry->sym->binding,
> +                                                         ilist->funcname);
> +                                       dso__insert_symbol(entry->map->dso,
> +                                                          MAP__FUNCTION,
> +                                                          sym);
> +                                       dso__sort_by_name(entry->map->dso,
> +                                                         MAP__FUNCTION);
> +                                       fprintf(stderr, "%p | %p | %s | %s\n", 
> sym,
> +                                               
> dso__find_symbol_by_name(entry->map->dso, MAP__FUNCTION, ilist->funcname),
> +                                               sym->name, ilist->funcname);
> +                               }
> +                               fprintf(stderr, "want to add inline: %s %p\n", 
> ilist->funcname, sym);
> +                       }
> +                       inline_node__delete(inline_node);
> +               }
> +       }
>         return callchain_cursor_append(cursor, entry->ip,
>                                        entry->map, entry->sym,
>                                        false, NULL, 0, 0);
> ~~~~~~~~~~~~~~~
> 
> Any idea what I'm doing wrong here? Can I not insert into the sorted list? 
> I.e. is it not safe to sort multiple times? Is this the wrong approach in 
> general?
> 
> Also, any suggestion as to what I'd use for symbol start/end for the inlined 
> fake symbols?

Please see above.

Thanks,
Namhyung
