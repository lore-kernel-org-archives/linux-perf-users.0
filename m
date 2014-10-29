From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Collect Per thread event count using perf
Date: Wed, 29 Oct 2014 14:54:08 +0900
Message-ID: <87ioj3775r.fsf@sejong.aot.lge.com>
References: <loom.20141029T024721-194@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo04.lge.com ([156.147.1.127]:63768 "EHLO
	lgeamrelo04.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaJ2FyK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 01:54:10 -0400
In-Reply-To: <loom.20141029T024721-194@post.gmane.org> (Hemendra Rawat's
	message of "Wed, 29 Oct 2014 02:03:36 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hemendra Rawat <hkr1990@vt.edu>
Cc: linux-perf-users@vger.kernel.org

Hi Hemendra,

On Wed, 29 Oct 2014 02:03:36 +0000 (UTC), Hemendra Rawat wrote:
> Hi,
>
> I'm new to perf. I want to use perf to collect cpu-cycles spent in 
> each function for a multi-threaded program (Nasa Parallel Bench
> marks OpenMP version).  
>
> I'm using following commands to record and analyze the data. 
>
>             # perf record -s --call-graph=dwarf ./my-program 10
>             # perf report -T --call-graph=graph     
>
> But the TUI interface that opens up doesn't give information on a 
> per thread basis. It's all aggregate event count for each function. 
> I'm not sure whether i'm recording the data in the wrong way or 
> I'm missing something in the interpretation of perf output.  Can 
> someone help me with this ? Any help will be highly appreciated.

It seems only --stdio support the -T option (and recorded events have
'S' modifier?).  What about using "perf report -s pid"?

And I have a question to others: I always get confused with "perf record
-s".  It turns on the inherit_stat attribute, and what it does looks
like sharing event value/stat with other tasks - but I maybe mis-
understood something.  Could anyone please explain it to me in more
detail?  Also it'd be better if the related man page also can be updated.

Thanks,
Namhyung
