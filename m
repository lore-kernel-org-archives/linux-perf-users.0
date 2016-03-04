From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v11 17/24] perf config: Collect configs to handle config
 variables
Date: Fri, 4 Mar 2016 22:58:48 +0900
Message-ID: <20160304135848.GA15486@danjae.kornet>
References: <1447768424-17327-1-git-send-email-treeze.taeung@gmail.com>
 <1447768424-17327-17-git-send-email-treeze.taeung@gmail.com>
 <20151118051525.GP7062@sejong>
 <56D98378.4080208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34045 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbcCDOAK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Mar 2016 09:00:10 -0500
Content-Disposition: inline
In-Reply-To: <56D98378.4080208@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taeung Song <treeze.taeung@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, perf group <linux-perf-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

Hi Taeung,

On Fri, Mar 04, 2016 at 09:45:44PM +0900, Taeung Song wrote:
> Hi, Namhyung and all
> 
> (I'm modifying this patch to be tidy)
> I have a mere question about name of a variable for
> current config list that contains section list which has key-value
> pairs from ~/.perfconfig or $(sysconfdir)/perfconfig config file.
> 
> (This variable is designed to be used by several functions
> that handle config information(key-value pairs).)
> 
> I used 'sections' for this variable (type is 'struct list_head'),
> but IMHO, I think that renaming it is better e.g.
> 
> 1) 'cfglist'
> 2) 'configlist'
> 3) 'config_list'
> 4) 'cfgset'
> 5) 'configset'
> 6) 'config_set'
> ... :-\
> 
> It is trivial question,
> but I wanna know a opinion of other people. :-)

I'd go with 3 or 6.  Or simply 'configs' or 'perf_configs' is fine for
me.

Thanks,
Namhyung
