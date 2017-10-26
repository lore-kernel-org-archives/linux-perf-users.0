From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: perf buildid-cache -p <path> question
Date: Thu, 26 Oct 2017 23:41:30 +0900
Message-ID: <20171026234130.b314a642b72c5fa5f396ec9e@kernel.org>
References: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
        <20171022001703.c56a77784dbc49b258d36bf7@kernel.org>
        <7d8827b9-2517-dfdb-b5fb-64088c81c0c7@linux.vnet.ibm.com>
        <20171026015723.6d9202ce81b2fb222993f63b@kernel.org>
        <2b863f9e-e3f3-fa7f-7014-679d7fac63ea@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932255AbdJZOld (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Oct 2017 10:41:33 -0400
In-Reply-To: <2b863f9e-e3f3-fa7f-7014-679d7fac63ea@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On Thu, 26 Oct 2017 09:07:21 +0200
Thomas-Mich Richter <tmricht@linux.vnet.ibm.com> wrote:

> On 10/25/2017 06:57 PM, Masami Hiramatsu wrote:
> 
> ...
> 
> >>
> >> When you look at the patch I submitted, in function build_id_cache__purge_path()
> >> you specify a fully qualified path name, for example /usr/bin/tar. This is a file
> >> and it calls function build_id_cache__remove_file() to remove its entries in the cache.
> > 
> > OK, now I see what the question is based on...
> > I'll see your patch.
> > 
> > Thank you,
> > 
> 
> I think we drop the patch and change the man page instead.
> Any objections?

No, it's just reply ordering issue. :) (I saw this first, and the other next)

Thank you,

> 
> -- 
> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> --
> Vorsitzende des Aufsichtsrats: Martina Koederitz 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
