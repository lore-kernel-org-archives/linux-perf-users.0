From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 0/2] perf sched map: re-annotate shortname if thread
 comm changed
Date: Tue, 6 Mar 2018 08:53:02 +0100
Message-ID: <20180306075302.GA19895@krava>
References: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: changbin.du@intel.com
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 06, 2018 at 11:37:35AM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> v2:
>   o add a patch to move thread::shortname to thread_runtime
>   o add function perf_sched__process_comm() to process PERF_RECORD_COMM event.
> 
> Changbin Du (2):
>   perf sched: move thread::shortname to thread_runtime
>   perf sched map: re-annotate shortname if thread comm changed

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/perf/builtin-sched.c | 132 ++++++++++++++++++++++++++++++---------------
>  tools/perf/util/thread.h   |   1 -
>  2 files changed, 90 insertions(+), 43 deletions(-)
> 
> -- 
> 2.7.4
> 
