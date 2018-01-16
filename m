From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 0/3] tracing: Fix the parser when processing strings
 w/ or w/o terminated '\0'
Date: Tue, 16 Jan 2018 12:42:26 -0500
Message-ID: <20180116124226.73d2c7e2@gandalf.local.home>
References: <1516093350-12045-1-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516093350-12045-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: changbin.du@intel.com
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, 16 Jan 2018 17:02:27 +0800
changbin.du@intel.com wrote:

> From: Changbin Du <changbin.du@intel.com>
> 
> I found there are some problems in the tracing parser when I investiage the root
> cause of issues mentioned in below patch.
> https://patchwork.kernel.org/patch/10132953/

I pulled in your patches and tweaked the change logs of the other two
patches as well. You can see my temporary git tree here, but it may
rebase.

git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

 ftrace/core

-- Steve
