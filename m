From: Arun Sharma <asharma@fb.com>
Subject: Re: [RFC] Sort inclusive
Date: Tue, 6 Mar 2012 11:41:38 -0800
Message-ID: <4F566872.9010408@fb.com>
References: <20120305221253.GA30250@dev3310.snc6.facebook.com> <20120306065753.GB5100@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56827 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965176Ab2CFTmR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 6 Mar 2012 14:42:17 -0500
In-Reply-To: <20120306065753.GB5100@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Tom Zanussi <tzanussi@gmail.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On 3/5/12 10:57 PM, Ingo Molnar wrote:

> Btw., assuming that you are profiling user-space applications
> via call-chains, how do you deal with the lack of dwarf decoding
> done by perf, in particular on 64-bit x86 systems where most
> distros don't compile call-chains into libraries and
> application? In what practical situations does that limitation
> hinder you and what do you do about it - rebuild your apps with
> frame pointers included?

Yes - we're rebuilding everything with frame pointers so we could get 
callchains. While this works for C/C++, I'm not convinced that we have a 
good solution for JITs where there may be multiple stacks (eg: one each 
for interpreted and JIT code), and the kernel may not be able to unwind 
without dwarf decoding. For now, we're going with the /tmp/perf-$pid.txt 
based solution for JITs.

I'll post a new patch with the code refactored into smaller functions.

  -Arun
