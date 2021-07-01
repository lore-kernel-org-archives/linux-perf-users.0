Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA76C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 10:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D886961476
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 10:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhGAKjz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229744AbhGAKjz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 06:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625135844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gcU0dPNge0Ig1Ib2qoVjGnOfz1woSkeZ7eLAApuj39c=;
        b=L2ldVFU0AqkXBhB+S6AnHxFXOCD9vo0MtuptndBm1BZheF7BxSU4DcNy34C6djPxNI1V50
        WGCTd4vHM5tjY/6IZBAl3Ad6VUAFOGUXAGGVgxOevmtLEfDK1Ur9S6UMqnONI7ONFq9TN6
        ow6IGo5+syvDLv3TYG1k5RUwVBuClQY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-nWRd7tTMOHexl75_CSJnmA-1; Thu, 01 Jul 2021 06:37:23 -0400
X-MC-Unique: nWRd7tTMOHexl75_CSJnmA-1
Received: by mail-ed1-f72.google.com with SMTP id o8-20020aa7dd480000b02903954c05c938so2857508edw.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jul 2021 03:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gcU0dPNge0Ig1Ib2qoVjGnOfz1woSkeZ7eLAApuj39c=;
        b=d0lMGSMk9Jntx4pQpA5bIgByWxahm32WM17lFNdj/+VSLxhu+tvrtSqfRvVZMjGtCg
         8eWzfnkZ8eTmloliiumARpWs6IhzrBqIGtR0JIR00/TPrxIGWfbC/MNWmztcYVCv+ZB2
         Fmch7UNuHOHBsrnK1se8/MFxcH8YIXJ8hIUdacKMpU6Qu5fT6MSHoC9qjlQq6MbCsOMg
         33yP9UkyfRB9zv5jhU7NkapWqwfHAJowp1CZ6s5F09ekH5JlW57hG97ES3SuemDldIXK
         xz2bDDm6YEVeNo9WJTQ6XHVHezzIO8u0O7FtpI5UOyMDgstQIogt+pb6tnexaRwU/m+K
         gZFQ==
X-Gm-Message-State: AOAM533kVOsAklkQ6WUsqQR+Dw8EUeCp07z1Q55r68tFEteExeBlL6MA
        4iCpDW+qKo5r8P8hsOGPSGWmAs6rAXJvEJWw5E3o0QCXTvMcGUhA5ZjirmMOMM69a0SVWLMgUAE
        wn8gWeP3Kme+zg5FJC1OUsVi8teftzQ==
X-Received: by 2002:a05:6402:1d25:: with SMTP id dh5mr54361683edb.355.1625135842136;
        Thu, 01 Jul 2021 03:37:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy69g3/cFW/LrPusGiaburIOgunrFOK5xqfS6z+/a/dHH3D5ZmVHiexTopF3u2YELnRcnRGsw==
X-Received: by 2002:a05:6402:1d25:: with SMTP id dh5mr54361666edb.355.1625135841941;
        Thu, 01 Jul 2021 03:37:21 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id eg26sm13855054edb.81.2021.07.01.03.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:37:21 -0700 (PDT)
Date:   Thu, 1 Jul 2021 12:37:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: Perf loses events without reporting
Message-ID: <YN2a3pSvealjK6uR@krava>
References: <87lf6rclcm.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf6rclcm.fsf@stepbren-lnx.us.oracle.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 30, 2021 at 10:29:13AM -0700, Stephen Brennan wrote:
> Hi all,
> 
> I've been trying to understand the behavior of the x86_64 performance
> monitoring interrupt, specifically when IRQ is disabled. Since it's an
> NMI, it should still trigger and record events. However, I've noticed
> that when interrupts are disabled for a long time, events seem to be
> silently dropped, and I'm wondering if this is expected behavior.
> 
> To test this, I created a simple kernel module "irqoff" which creates a
> file /proc/irqoff_sleep_millis. On write, the module uses
> "spin_lock_irq()" to disable interrupts, and then issues an mdelay()
> call for whatever number of milliseconds was written. This allows us to
> busy wait with IRQ disabled. (Source for the module at the end of this
> email).
> 
> When I use perf to record a write to this file, we see the following:
> 
> $ sudo perf record -e cycles -c 100000 -- sh -c 'echo 2000 > /proc/irqoff_sleep_millis'

seems strange.. I'll check

could you see that also when monitoring the cpu? like:

  $ sudo perf record -e cycles -c 100000 -C 1 -- taskset -c 1 sh -c ..

jirka

> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.030 MB perf.data (58 samples) ]
> 
> $ sudo perf script
> # ... filtered down:
>               sh 62863 52318.991716:     100000 cycles:  ffffffff8a8237a9 delay_tsc+0x39 ([kernel.kallsyms])
>               sh 62863 52318.991740:     100000 cycles:  ffffffff8a823797 delay_tsc+0x27 ([kernel.kallsyms])
>               sh 62863 52318.991765:     100000 cycles:  ffffffff8a823797 delay_tsc+0x27 ([kernel.kallsyms])
> #                      ^ v   ~2 second gap!
>               sh 62863 52320.963900:     100000 cycles:  ffffffff8ae47417 _raw_spin_lock_irqsave+0x27 ([kernel.kallsyms])
>               sh 62863 52320.963923:     100000 cycles:  ffffffff8ae47417 _raw_spin_lock_irqsave+0x27 ([kernel.kallsyms])
>               sh 62863 52320.963948:     100000 cycles:  ffffffff8ab1db9a handle_tx_event+0x2da ([kernel.kallsyms])
> 
> The perf stat shows the following counters over a similar run:
> 
> $ sudo perf stat -- sh -c 'echo 2000 > /proc/irqoff_sleep_millis'
> 
>  Performance counter stats for 'sh -c echo 2000 > /proc/irqoff_sleep_millis':
> 
>           1,975.55 msec task-clock                #    0.999 CPUs utilized
>                  1      context-switches          #    0.001 K/sec
>                  0      cpu-migrations            #    0.000 K/sec
>                 61      page-faults               #    0.031 K/sec
>      7,952,267,470      cycles                    #    4.025 GHz
>        541,904,608      instructions              #    0.07  insn per cycle
>         83,406,021      branches                  #   42.219 M/sec
>             10,365      branch-misses             #    0.01% of all branches
> 
>        1.977234595 seconds time elapsed
> 
>        0.000000000 seconds user
>        1.977162000 seconds sys
> 
> According to this, we should see roughly 79k samples (7.9 billion cycles
> / 100k sample period), but perf only gets 58. What it "looks like" to
> me, is that the CPU ring buffer might run out of space after several
> events, and the perf process doesn't get scheduled soon enough to read
> the data? But in my experience, perf usually reports that it missed some
> events. So I wonder if anybody is familiar with the factors at play for
> when IRQ is disabled during a PMI? I'd appreciate any pointers to guide
> my exploration.
> 
> My test case here ran on Ubuntu distro kernel 5.11.0-22-generic, and I
> have also tested on a 5.4 based kernel. I'm happy to reproduce this on a
> mainline kernel too.
> 
> Thanks,
> Stephen
> 
> Makefile:
> <<<
> obj-m += irqoff.o
> 
> all:
> 	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
> 
> clean:
> 	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
> >>>
> 
> irqoff.c:
> <<<
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/init.h>
> #include <linux/proc_fs.h>
> #include <linux/spinlock.h>
> #include <linux/delay.h>
> #include <linux/version.h>
> #include <linux/uaccess.h>
> 
> MODULE_LICENSE("GPL");
> MODULE_DESCRIPTION("Test module that allows to disable IRQ for configurable time");
> MODULE_AUTHOR("Stephen Brennan <stephen.s.brennan@oracle.com>");
> 
> 
> // Store the proc dir entry we can use to check status
> struct proc_dir_entry *pde = NULL;
> 
> DEFINE_SPINLOCK(irqoff_lock);
> 
> 
> static noinline void irqsoff_inirq_delay(unsigned long millis)
> {
> 	mdelay(millis);
> }
> 
> 
> static ssize_t irqsoff_write(struct file *f, const char __user *data, size_t amt, loff_t *off)
> {
> 	char buf[32];
> 	int rv;
> 	unsigned long usecs = 0;
> 
> 	if (amt > sizeof(buf) - 1)
> 		return -EFBIG;
> 
> 	if ((rv = copy_from_user(buf, data, amt)) != 0)
> 		return -EFAULT;
> 
> 	buf[amt] = '\0';
> 
> 	if (sscanf(buf, "%lu", &usecs) != 1)
> 		return -EINVAL;
> 
> 	/* We read number of milliseconds, but will convert to microseconds.
> 	   Threshold it at 5 minutes for safety. */
> 	if (usecs > 5 * 60 * 1000)
> 		return -EINVAL;
> 
> 	pr_info("[irqoff] lock for %lu millis\n", usecs);
> 	spin_lock_irq(&irqoff_lock);
> 	irqsoff_inirq_delay(usecs);
> 	spin_unlock_irq(&irqoff_lock);
> 
> 	return amt;
> }
> 
> static ssize_t irqsoff_read(struct file *f, char __user *data, size_t amt, loff_t *off)
> {
> 	return 0;
> }
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(5,6,0)
> static const struct file_operations irqsoff_fops = {
> 	.owner                  = THIS_MODULE,
> 	.read                   = irqsoff_read,
> 	.write                  = irqsoff_write,
> };
> #else
> static const struct proc_ops irqsoff_fops = {
> 	.proc_read		= irqsoff_read,
> 	.proc_write		= irqsoff_write,
> };
> #endif
> 
> static int irqoff_init(void)
> {
> 	pde = proc_create("irqoff_sleep_millis", 0644, NULL, &irqsoff_fops);
> 	if (!pde)
> 		return -ENOENT;
> 
> 	pr_info("[irqoff] successfully initialized\n");
> 	return 0;
> }
> 
> static void irqoff_exit(void)
> {
> 	proc_remove(pde);
> 	pde = NULL;
> }
> 
> module_init(irqoff_init);
> module_exit(irqoff_exit);
> >>>
> 

