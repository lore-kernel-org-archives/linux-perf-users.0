From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: event group without multiplexing
Date: Thu, 12 Nov 2015 12:51:53 -0500 (EST)
Message-ID: <alpine.DEB.2.20.1511121248050.7597@vincent-weaver-1.umelst.maine.edu>
References: <CAJh9x3q+g4Q4WfZ8XZ9ZOw0BcgYd_hdoUufu2YpRGtZt2tfu5Q@mail.gmail.com> <CAJh9x3qCnvz4yWTBxyMp_RZt66L7OXHxbgTcfWaqFBfdZiGkLQ@mail.gmail.com> <CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
 <1447350001.15375.95.camel@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36566 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbbKLRuG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 12:50:06 -0500
Received: by iofh3 with SMTP id h3so72754041iof.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 09:50:04 -0800 (PST)
In-Reply-To: <1447350001.15375.95.camel@Rudolf-RHEL-7>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Yuanfang Chen <cyfmxc@gmail.com>, linux-perf-users@vger.kernel.org

On Thu, 12 Nov 2015, Michael Petlan wrote:

> But I can't find any reference about the r1000248 event
> in the Intel Manual. Vince, am I missing something?
> 
> Anyway, shouldn't it behave the same on IVB and HSW?

I am going off the code in
	arch/x86/kernel/cpu/perf_event_intel.c
(current git tree)

SNB and HSW have as a constraint
	INTEL_EVENT_CONSTRAINT(0x48, 0x4), /* L1D_PEND_MISS.* */

IVB has as a constraint
	INTEL_UEVENT_CONSTRAINT(0x0148, 0x4), /* L1D_PEND_MISS.PENDING */
	
Notice the difference.  Not sure if this is a bug in the kernel or what, 
but that's what's there and I think it's what's causing the issue.

Vince
