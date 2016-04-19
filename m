From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Ideas to measure kernel function execution time using perf
Date: Wed, 20 Apr 2016 08:37:57 +0900
Message-ID: <20160420083757.cba5cdd3038c7d82391b3b4c@kernel.org>
References: <57158D19.7070307@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47230 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbcDSXiD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Apr 2016 19:38:03 -0400
In-Reply-To: <57158D19.7070307@cn.fujitsu.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, 19 Apr 2016 09:42:49 +0800
Qu Wenruo <quwenruo@cn.fujitsu.com> wrote:

> Hi,
> 
> Is there any method to measure kernel function execution time for 
> specific functions using perf?
> 
> Current ftrace events can only record the timestamp when hitting the 
> trace point (along with some other info).
> 
> I'm OK adding new ftrace events into kernel, but even after adding such 
> ftrace events, is it possible to use perf to calculate the function 
> execution time?

Would you mean "perf probe"? :)

Actually, kprobes on the function entry point (on x86) automatically
use ftrace and also you can get function parameters, e.g.

# perf probe -a 'YOUR_TARGET_FUNCTION $params'

And with using ftrace, you can get function duration and parameters,
for example,

# perf probe -a 'vfs_read $params'
Added new event:
  probe:vfs_read       (on vfs_read with $params)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_read -aR sleep 1

# cd /sys/kernel/debug/tracing/
# echo vfs_read > set_ftrace_filter
# echo 1 > events/probe/vfs_read/enable
# echo function_graph > current_tracer
# echo 0 > trace
# less trace
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 2)               |  /* vfs_read: (vfs_read+0x0/0x130) file=0xffff88036a959200 buf=0x7ffe460abb70 count=0x10 pos=0xffff880052d1bf20 */
 3)               |  /* vfs_read: (vfs_read+0x0/0x130) file=0xffff88024524b900 buf=0x7ffcdee7ec57 count=0x1 pos=0xffff88023942ff20 */
 2)   0.538 us    |  vfs_read();
 3)               |  vfs_read() {
 2)               |  /* vfs_read: (vfs_read+0x0/0x130) file=0xffff8803c24ba400 buf=0xd8efdc count=0x1ff0 pos=0xffff880052d1bf20 */
 2)   0.979 us    |  vfs_read();
...

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
