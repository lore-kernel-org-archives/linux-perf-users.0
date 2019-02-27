From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Support sample context in perf report
Date: Wed, 27 Feb 2019 08:01:35 -0800
Message-ID: <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
References: <20190226030412.23485-1-andi@firstfloor.org>
 <20190227111801.GA18893@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190227111801.GA18893@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

> > Also available in
> > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2
> 
> your post is missing this patch, it's only in the branch:
>   perf tools: Add utility function to fetch executable

Because Arnaldo already merged it. But the branch is still based
on tip/perf/core, which doesn't have it yet.

-Andi
