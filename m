From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: About using PEBS from the user space
Date: Sun, 3 May 2015 18:19:21 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1505031816450.4940@vincent-weaver-1.umelst.maine.edu>
References: <55469B90.1090903@bsc.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34653 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbECWOP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 3 May 2015 18:14:15 -0400
Received: by qgfi89 with SMTP id i89so58568615qgf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2015 15:14:14 -0700 (PDT)
In-Reply-To: <55469B90.1090903@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, 4 May 2015, Harald Servat wrote:

> Dear list,
> 
>   I'd like to use the perf library to access PEBS so as to collect referenced
> memory addresses from the user space. I think I've successfully setup the perf
> structures (struct perf_event_attr) to configure the performance counters, but
> I don't see what should I do to access to the captured memory addresses. I've
> seen that within arch/x86/kernel/cpu/perf_event_intel_ds.c there are the
> routines alloc_pebs_buffer, alloc_ds_buffer which seems to allocate and setup
> the necessary buffers using kmalloc_node calls. Question is, how can replicate
> this from the user space? And how we should connect these buffers to the PEBS
> infrastructure using perf calls?

You can try looking at the example code in my perf_event_tests code.
	https://github.com/deater/perf_event_tests

The stuff you are looking for is probably covered in the
	test/record_sample/samples_data_src
	test/record_sample/sample_weight
and especially the
	test/record_sample/sample_regs_intr
tests, although that last one requires a fairly recent kernel to work.

Vince
