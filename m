From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf report: null ptr dereference in utils/env.c
Date: Wed, 19 Oct 2016 00:04:08 +0200
Message-ID: <20161018220408.GA3286@krava>
References: <D6EDEBF1F91015459DB866AC4EE162CC02499B19@IRSMSX103.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934010AbcJRWEM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2016 18:04:12 -0400
Content-Disposition: inline
In-Reply-To: <D6EDEBF1F91015459DB866AC4EE162CC02499B19@IRSMSX103.ger.corp.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>

On Tue, Oct 18, 2016 at 04:13:45PM +0000, Odzioba, Lukasz wrote:
> Hi,
> Am I the only one getting segfaults in perf report (4.8-rc8/4.9rc-1)?
> It happens simply when I try to exit it.
> 
> Program received signal SIGSEGV, Segmentation fault.
> perf_env__exit (env=env@entry=0x1fc4d00) at util/env.c:25
> (...)
> (gdb) list
> (...)
> 
> 24              for (i = 0; i < env->nr_numa_nodes; i++)
> 25                      cpu_map__put(env->numa_nodes[i].map);
> 26              zfree(&env->numa_nodes);
>  
>  (gdb) print env->nr_numa_nodes
> $1 = 2
>  (gdb) print env->numa_nodes
> $2 = (struct numa_node *) 0x0    
> 
> This line was introduced in the following patch:
> https://patchwork.kernel.org/patch/9213995/

could you please try with Arnaldo's current perf/urgent branch
that has following patch:
  f957a5308dbb perf header: Set nr_numa_nodes only when we parsed all the data

is that ppc machine? how did you generate the perf.data?

thanks,
jirka
