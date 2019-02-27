From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Support sample context in perf report
Date: Wed, 27 Feb 2019 17:16:59 +0100
Message-ID: <20190227161658.GA2890@krava>
References: <20190226030412.23485-1-andi@firstfloor.org>
 <20190227111801.GA18893@krava>
 <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

On Wed, Feb 27, 2019 at 08:01:35AM -0800, Andi Kleen wrote:
> > > Also available in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2
> > 
> > your post is missing this patch, it's only in the branch:
> >   perf tools: Add utility function to fetch executable
> 
> Because Arnaldo already merged it. But the branch is still based

can't see it on his perf/core branch,
please paste me commit id

jirka

> on tip/perf/core, which doesn't have it yet.
> 
> -Andi
