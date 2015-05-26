From: Taewoong Song <treeze.taeung@gmail.com>
Subject: Re: perf tools: What is the default value of report.queue-size ?
Date: Wed, 27 May 2015 00:19:28 +0900
Message-ID: <B04A0871-3A4F-4E5E-929F-BD0AB4ADE601@gmail.com>
References: <20150526074028.GB13654@gmail.com> <20150526082429.GA6555@krava.brq.redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33486 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbbEZPTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 May 2015 11:19:37 -0400
Received: by padbw4 with SMTP id bw4so95101472pad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2015 08:19:33 -0700 (PDT)
In-Reply-To: <20150526082429.GA6555@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: namhyung@kernel.org, acme@kernel.org, linux-perf-users@vger.kernel.org

Thank you for your answer.

Thanks,
Taeung


> On May 26, 2015, at 5:24 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> 
> On Tue, May 26, 2015 at 04:40:28PM +0900, Taeung Song wrote:
>> Hi, linux-perf list
>> 
>> I have a question about the default value of report.queue-size.
>> 
>> I found 'struct report' and 'queue_size' which is a member variable of it in builtin-report.c file.
>> But when report.queue_size isn't customized by perf-config 'report.queue-size',
>> I don't know the default value of 'report.queue_size'.
>> 
>> What is the default value of 'report.queue-size' ?
> 
> 0 - meaning no limit
> 
> it's used to initialize 'struct ordered_events::max_alloc_size' which
> by default set to max u64
> 
> jirka
