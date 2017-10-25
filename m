From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: perf buildid-cache -p <path> question
Date: Thu, 26 Oct 2017 02:04:08 +0900
Message-ID: <20171026020408.053d2985bdd1e4fef824fbcb@kernel.org>
References: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
        <20171016141222.GC5311@kernel.org>
        <20171021011259.5d6368a7fd1f54004b6ae1da@kernel.org>
        <20171020162056.GH30002@kernel.org>
        <140bd721-4929-22ee-ce77-b7fe575a470c@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbdJYREL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 13:04:11 -0400
In-Reply-To: <140bd721-4929-22ee-ce77-b7fe575a470c@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On Tue, 24 Oct 2017 09:56:02 +0200
Thomas-Mich Richter <tmricht@linux.vnet.ibm.com> wrote:

> On 10/20/2017 06:20 PM, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Oct 21, 2017 at 01:12:59AM +0900, Masami Hiramatsu escreveu:
> >> On Mon, 16 Oct 2017 11:12:22 -0300
> >> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>
> >>
> >> For example, you have a /usr/bin/tar (this is old tar) and its buildid-cache
> >> in cache directory by perf buildid-cache -a /usr/bin/tar.
> >> And at some point, you will update the /usr/bin/tar (this is new tar).
> >> This new tar binary is not same as old one, so if you also do
> >> perf buildid-cache -a /usr/bin/tar, it creates another version of buildid
> >> cache in cache directory.
> >>
> >> At this moment,
> >> $ perf buildid-cache -r /usr/bin/tar
> >> will remove only new tar's buildid cache, but old one remains.
> >>
> >> On the other hand,
> >> $ perf buildid-cache -p /usr/bin/tar
> >> will remove all the caches related to /usr/bin/tar from buildid cache.
> >>
> >> And since the -p is supposed to be used for cleanup, it doesn't return
> >> error even if there is no buildid cache remaining.
> >>
> >>
> >> Should it work for a directory instead of a file too?
> >> I need to investigate it too.
> > 
> > Isn't that implemented by I patch by Thomas?
> > 
> > - Arnaldo
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> Ok, I have understood the behavior of commands
> perf buildid-cache -a
> and
> perf buildid-cache -r.
> 
> Same with command perf buildid-cache -p /usr/bin/tar.
> It works correctly if you specify a file name and not a directory as I did
> in my previous append.
> 
> I was mislead by the man page which says
> "file list" for option -a
> "file(s) to remove" for option -r
> "path(s) to remove (remove old caches too)' for option -p
> 
> I just find it confusing to explicitly mention files for
> option -a and -r whereas option -p mentions path.
> 
> We can drop my patch but I would like to clarify the man page
> to explicitly mention "file(s)" or "file list" instead of path for option -p.
> 
> What do you think?

Indeed. Originally the "file" means existing file but "path" means the path in the
cache, which can be already removed. However, that can mislead users.
So I agree that is unified to "file list".

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
