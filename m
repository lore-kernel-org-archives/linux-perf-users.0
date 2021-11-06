Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C1DC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 00:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B2D61139
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 00:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhKFAuV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 20:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhKFAuU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 20:50:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BB0C061570;
        Fri,  5 Nov 2021 17:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=dYeKck/iXvULKvcfsrGrG7rdH6xeTDD5bHWpXPPzQV4=; b=NQ8SeqqGoxXShKBofpd+svv9d7
        dLDGbHxmiQSNCbA4OYwXPUg7Aqj1vqmdECPQkwH9FWDRLYHbPLv6BYpjXfSJCazbzH6xPFKpyZhSU
        64hrX5YFaU7CAzjqBkNZoeV9f+iQMDyuPZ6Liy2KQlArIR4Fsd17Hm9EG+YBHjwoiLdXVEJUe11i6
        shCOoNWDUpNDB0ZXx680UkmsHSaG32aZS7OI7ZnbEd83GJBBbGZSy1NDJRFUKkuSLJZmYpl03+5a9
        gHTzIV7C9m7cTH8NpshyUIbn6p6AfqcOTASh0j/9Xs0iXvXfdPyNhsXmh5MIFgMo0zvGu9pmkD7z7
        i/dDMXVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj9qI-006xhR-86; Sat, 06 Nov 2021 00:46:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97E6330031A;
        Sat,  6 Nov 2021 01:45:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E2DC2C8F4FD4; Sat,  6 Nov 2021 01:45:57 +0100 (CET)
Date:   Sat, 6 Nov 2021 01:45:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     kan.liang@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: Using perf_event_open() to sample multiple events of a process
Message-ID: <YYXQRYbRO193U4re@hirez.programming.kicks-ass.net>
References: <92645262-D319-4068-9C44-2409EF44888E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92645262-D319-4068-9C44-2409EF44888E@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 04, 2021 at 10:57:50PM -0700, Nadav Amit wrote:
> Hello Ken, Peter,
> 
> I would appreciate some help regarding the use of perf_event_open()
> to have multiple samples getting into the same mmap’d memory when they
> are both attached to the same process.
> 
> I am doing so (using both PERF_FLAG_FD_NO_GROUP and PERF_FLAG_FD_OUTPUT),
> but it results in -EINVAL. Debugging the code shows that
> perf_event_set_output() fails due to the following check:
> 
>         /*
>          * If its not a per-cpu rb, it must be the same task.
>          */
>         if (output_event->cpu == -1 && output_event->ctx != event->ctx)
>                 goto out;
> 
> However, it appears that at this point, event->ctx is not initialized
> (it is null) so the test fails and the whole perf_event_open() syscall
> fails.
> 
> Am I missing something? If not, I am unsure, unfortunately, what the
> proper way to fix it is…
> 
> I include a small test that fails on my system. The second
> perf_event_open fails due to the check in perf_event_set_output():
> 

Works when you use the SET_OUTPUT ioctl()...

I think something went sideways in the syscall path and things went out
of order :/ I'll try and have a look.


---
#define _GNU_SOURCE 1

#include <asm/unistd.h>
#include <linux/perf_event.h>
#include <linux/hw_breakpoint.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

long perf_event_open(struct perf_event_attr* event_attr, pid_t pid, int cpu,
		int group_fd, unsigned long flags)
{
	return syscall(__NR_perf_event_open, event_attr, pid, cpu, group_fd, flags);
}

int main(void)
{
	pid_t pid = getpid();
	int group_fd, fd, err;
	void *p;
	struct perf_event_attr pe = {
		.type = 4,
		.size = sizeof(struct perf_event_attr),
		.config = 0x11d0,
		.sample_type = 0x8,
		.sample_period = 1000,
		.precise_ip = 2,
	};

	group_fd = perf_event_open(&pe, pid, -1, -1, PERF_FLAG_FD_CLOEXEC |
			PERF_FLAG_FD_NO_GROUP |
			PERF_FLAG_FD_OUTPUT);

	if (group_fd < 0) {
		perror("first perf_event_open");
		exit(-1);
	}

	p = mmap(NULL, 3 * 4096, PROT_READ|PROT_WRITE, MAP_SHARED, group_fd, 0);

	if (p == MAP_FAILED) {
		perror("MAP_FAILED");
		exit(-1);
	}

	pe.config = 0x12d0;

	fd = perf_event_open(&pe, pid, -1, -1, PERF_FLAG_FD_CLOEXEC |
			PERF_FLAG_FD_NO_GROUP |
			PERF_FLAG_FD_OUTPUT);

	if (fd < 0) {
		perror("second perf_event_open");
		exit(-1);
	}

	err = ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, group_fd);
	if (err < 0) {
		perror("ioctl");
		exit(-1);
	}

	printf("success\n");
}

