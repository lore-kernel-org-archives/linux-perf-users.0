From: Andi Kleen <andi@firstfloor.org>
Subject: Re: measure uncore events
Date: Thu, 03 Oct 2013 22:02:58 -0700
Message-ID: <87d2nltypp.fsf@tassilo.jf.intel.com>
References: <CAJh9x3o3au3ouwn4TTPt+CGyh3bo_u0Qo5LiKshe3HmSY7er4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21780 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab3JDFC7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Oct 2013 01:02:59 -0400
In-Reply-To: <CAJh9x3o3au3ouwn4TTPt+CGyh3bo_u0Qo5LiKshe3HmSY7er4w@mail.gmail.com>
	(Yuanfang Chen's message of "Tue, 1 Oct 2013 13:34:49 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yuanfang Chen <cyfmxc@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Yuanfang Chen <cyfmxc@gmail.com> writes:

> I'm trying to measure uncore events. After reading [1], I tried "perf
> stat -a -e "uncore_imc_0/event=0xff,umask=0x00/" /bin/ls", it says
> "invalid or unsupported event".
>
> The machine is Intel Ivy Bridge i5-3320M with ArchLinux 3.11.2-1-ARCH.
> 'perf --version'  is 'perf version 3.11.0'
> In '/sys/bus/event_source/devices/uncore_cbox_0/events', there is only
> one event 'clockticks'.

Uncore monitoring is only supported for IvyBridge Xeon E5+ / Core i7
49xx systems, not for your CPU.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
