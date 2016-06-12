From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Perf report --percentage
Date: Sun, 12 Jun 2016 22:55:26 +0900
Message-ID: <20160612135526.GA16671@danjae.aot.lge.com>
References: <6076A35470B38B408600AA0E3B4A31E767471A9E@ORSMSX114.amr.corp.intel.com>
 <6076A35470B38B408600AA0E3B4A31E767471E8A@ORSMSX114.amr.corp.intel.com>
 <20160611083148.GA13968@danjae.aot.lge.com>
 <1739457.PENJkRDNvS@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34000 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbcFLN4E (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 12 Jun 2016 09:56:04 -0400
Received: by mail-pf0-f180.google.com with SMTP id 62so37604173pfd.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Jun 2016 06:56:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1739457.PENJkRDNvS@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: shiny.sebastian@intel.com, linux-perf-users@vger.kernel.org

Hi Milian,

On Sat, Jun 11, 2016 at 01:53:34PM +0200, Milian Wolff wrote:
> On Samstag, 11. Juni 2016 17:31:48 CEST Namhyung Kim wrote:
> > Hello,
> > 
> > On Wed, Jun 08, 2016 at 04:21:43PM +0000, Sebastian, Shiny wrote:
> > > Thanks Milian. I added -g graph,0 and it did add lot more percentages -
> > > it's still not adding up though.
> > > 
> > > #perf report -C 1 --no-children -g graph,0
> > 
> > I think it's because you used -C option to restrict samples only from
> > cpu 1.  One way to check this is adding 'cpu' to sort keys and compare
> > sample count and callchain count.
> > 
> > What is the result of this command?
> > 
> >   # perf report -C 1 --no-children -g graph,0,count -n -s +cpu
> 
> If that is the case, how would you explain my findings? Note how I did not 
> pass `-C 1`, and still missed up to 90% of backtraces:
> 
> $ perf report --no-children -g fractal,0
> 
> -    9.47%  kwrite           ld-2.23.so                     [.] do_lookup_x
>    + 23.31% do_lookup_x
> -    7.06%  kwrite           ld-2.23.so                     [.] strcmp
>    + 9.06% strcmp
> +    5.71%  kwrite           ld-2.23.so                     [.] check_match

Hmm.. I have no idea.  Could you please show me the count of
callchains with following command?

  $ perf report --no-children -g graph,0,count -n


Also it'd be great if you double check the output of 'perf script' to
ensure all the samples have callchains..

Thanks,
Namhyung
