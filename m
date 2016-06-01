From: M Kelly <mark.kelly@lexisnexis.com>
Subject: Re: =?utf-8?b?c3Bpbl9sb2Nr?= cause ?
Date: Wed, 1 Jun 2016 18:49:01 +0000 (UTC)
Message-ID: <loom.20160601T204307-459@post.gmane.org>
References: <574F15E4.5070008@lexisnexis.com> <4716588.WReR5L1Wkn@milian-kdab2> <loom.20160601T194103-83@post.gmane.org> <20160601181153.GU2563@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47628 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbcFAStM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Jun 2016 14:49:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1b8BCV-0004gV-5v
	for linux-perf-users@vger.kernel.org; Wed, 01 Jun 2016 20:49:07 +0200
Received: from 209.243.55.99 ([209.243.55.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2016 20:49:07 +0200
Received: from mark.kelly by 209.243.55.99 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2016 20:49:07 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Arnaldo Carvalho de Melo <acme <at> kernel.org> writes:

> No need for DWARF if you want to know what leads to the spinlock just up
> to the syscall layer or if your userland components have frame pointers.

Hi,

ok, I rebuilt our app using -fno-omit-frame-pointer 
and did the perf record -g and when looking at the 
report output I now see:

    40.90%  thorslave_mytho  [kernel.kallsyms]                   [k] _spin_lock                                                                       
            |
            --- _spin_lock
               |          
               |--49.11%-- futex_wake
               |          do_futex
               |          sys_futex
               |          system_call_fastpath
               |          __lll_unlock_wake
               |          |          
               |          |--99.81%-- CKeyCursor::gtEqual(char const*, char*, bool)
               |          |          _ZN16CKeyLevelManager7_lookupEbj.constprop.100
               |
               |--44.31%-- futex_wait_setup
               |          futex_wait
               |          do_futex
               |          sys_futex
               |          system_call_fastpath
               |          __lll_lock_wait
               |          |          
               |          |--99.83%-- CKeyCursor::gtEqual(char const*, char*, bool)
               |          |          _ZN16CKeyLevelManager7_lookupEbj.constprop.100
               |
               |--5.46%-- task_rq_lock
               |          try_to_wake_up
               |          |          
               |          |--99.98%-- wake_up_state
               |          |          wake_futex
               |          |          futex_wake
               |          |          do_futex
               |          |          sys_futex
               |          |          system_call_fastpath
               |          |          __lll_unlock_wake
               |          |          |          
               |          |          |--99.75%-- CKeyCursor::gtEqual(char const*, char*, bool)
               |          |          |          _ZN16CKeyLevelManager7_lookupEbj.constprop.100
               |          
               |--0.73%-- try_to_wake_up
               |          |          
               |          |--99.83%-- wake_up_state
               |          |          wake_futex
               |          |          futex_wake
               |          |          do_futex
               |          |          sys_futex
               |          |          system_call_fastpath
               |          |          __lll_unlock_wake
               |          |          |          
               |          |          |--99.88%-- CKeyCursor::gtEqual(char const*, char*, bool)
               |          |          |          _ZN16CKeyLevelManager7_lookupEbj.constprop.100

So that is helpful.  
I do not understand the system_call_fastpath->futex->_spin_lock part yet, 
but that is a separate issue!

thanks so much,
mark
