From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf tools: What is the default value of report.queue-size ?
Date: Tue, 26 May 2015 10:24:29 +0200
Message-ID: <20150526082429.GA6555@krava.brq.redhat.com>
References: <20150526074028.GB13654@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbbEZIYb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 May 2015 04:24:31 -0400
Content-Disposition: inline
In-Reply-To: <20150526074028.GB13654@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taeung Song <treeze.taeung@gmail.com>
Cc: namhyung@kernel.org, acme@kernel.org, linux-perf-users@vger.kernel.org

On Tue, May 26, 2015 at 04:40:28PM +0900, Taeung Song wrote:
> Hi, linux-perf list
> 
> I have a question about the default value of report.queue-size.
> 
> I found 'struct report' and 'queue_size' which is a member variable of it in builtin-report.c file.
> But when report.queue_size isn't customized by perf-config 'report.queue-size',
> I don't know the default value of 'report.queue_size'.
> 
> What is the default value of 'report.queue-size' ?

0 - meaning no limit

it's used to initialize 'struct ordered_events::max_alloc_size' which
by default set to max u64

jirka
