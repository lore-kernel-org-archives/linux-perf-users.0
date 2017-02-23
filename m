From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [Question] about symbol__get_source_line() in util/annotate.c
Date: Thu, 23 Feb 2017 14:14:13 +0900
Message-ID: <20170223051413.GA30710@sejong>
References: <13ff5742-c651-0211-c0e0-0961c2d1ab64@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:40589 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdBWFOQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Feb 2017 00:14:16 -0500
Content-Disposition: inline
In-Reply-To: <13ff5742-c651-0211-c0e0-0961c2d1ab64@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taeung Song <treeze.taeung@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>, kernel-team@lge.com

Hi Taeung,

On Thu, Feb 23, 2017 at 12:31:08PM +0900, Taeung Song wrote:
> Hi Namhyung,
> 
> I have two question about the code util/annotate.c:1653~1676
> 
> https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git/tree/tools/perf/util/annotate.c?h=perf/core#n1653
> 
> 1653         for (i = 0; i < len; i++) {
> 1654                 u64 offset;
> 1655                 double percent_max = 0.0;
> 1656
> 1657                 src_line->nr_pcnt = nr_pcnt;
> 1658
> 1659                 for (k = 0; k < nr_pcnt; k++) {
> 1660                         h = annotation__histogram(notes, evidx + k);
> 1661                         src_line->samples[k].percent = 100.0 * h->addr[i] / h->sum;
> 1662
> 1663                         if (src_line->samples[k].percent > percent_max)
> 1664                                 percent_max = src_line->samples[k].percent;
> 1665                 }
> 1666
> 1667                 if (percent_max <= 0.5)
> 1668                         goto next;
> 1669
> 1670                 offset = start + i;
> 1671                 src_line->path = get_srcline(map->dso, offset, NULL, false);
> 1672                 insert_source_line(&tmp_root, src_line);
> 1673
> 1674         next:
> 1675                 src_line = (void *)src_line + sizeof_src_line;
> 1676         }
> 
> 
> 1) Why use 'offset = start + i;' ?
> For example,
> There are addresses matched with test.c:26 as below,
> 
>     400816:       push   %rbp
>     400817:       mov    %rsp,%rbp
>     40081a:       mov    %edi,-0x24(%rbp)
>     40081d:       mov    %rsi,-0x30(%rbp)
> 
> If using 'offset = start + i;' in the above for loop,
> needless addresses can be checked.

Right, that's not nice.

> 
> 
>     i=0, 400816
>     i=1, 400817
>     i=2, 400818 (nonvalidated)
>     i=3, 400819 (nonvalidated)
>     i=4, 40081a
>     i=5, 40081b (nonvalidated)
>     i=6, 40081c (nonvalidated)
>     i=7, 40081d
> 
> So I think it is better to use dissemble_line array such as
> (in order to check only validated addresses.)
> 
>     list_for_each_entry(dl, &notes->src->source, node)
> 
> What about this ?

I agree with you.  Maybe we can get rid of the source_line struct
entirely.

> 
> 2) Why use the if statement as below ?
> 
>     if (percent_max <= 0.5)
>             goto next;
> 
> I think it is more correct to use 0.0 instead of 0.5
> 
> What do you think about that ?

Well, I think that the summary line doesn't want to show too many
(small) lines.  Using 0.0 instead seems meaningless though.

Thanks,
Namhyung
