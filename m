From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Devel] [PATCH 0/7] Profiling sleep times (v3)
Date: Tue, 6 Dec 2011 09:30:44 +0100
Message-ID: <20111206083044.GB30062@elte.hu>
References: <1322471015-107825-1-git-send-email-avagin@openvz.org>
 <4EDDC0FB.6080005@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4EDDC0FB.6080005@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Vagin <avagin@openvz.org>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-perf-users@vger.kernel.org, Paul Mackerras <paulus@samba.org>, devel@openvz.org, David Ahern <dsahern@gmail.com>, Arun Sharma <asharma@fb.com>
List-Id: linux-perf-users.vger.kernel.org


* Andrey Vagin <avagin@openvz.org> wrote:

> Hello Arnaldo,
> 
> I found, that you commit patches for perf. Could you review this part?

To help out this effort i have applied your new 
kernel/sched/fair.c event to patch the scheduler
tree (tip:sched/core).

Note, i have renamed it from sched_stat_block to 
sched_stat_blocked - which is really the term we
use for such task states.

Thanks,

	Ingo
