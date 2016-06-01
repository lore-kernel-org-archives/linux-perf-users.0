From: M Kelly <mark.kelly@lexisnexis.com>
Subject: =?utf-8?b?X3NwaW5fbG9jaw==?= origin ?
Date: Wed, 1 Jun 2016 17:14:43 +0000 (UTC)
Message-ID: <loom.20160601T191324-906@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42179 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbcFARUK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Jun 2016 13:20:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1b89oM-0004R4-9j
	for linux-perf-users@vger.kernel.org; Wed, 01 Jun 2016 19:20:06 +0200
Received: from 209.243.55.99 ([209.243.55.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2016 19:20:06 +0200
Received: from mark.kelly by 209.243.55.99 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2016 19:20:06 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Perf report for our application shows:

 34.27%  [kernel]                    [k] _spin_lock
  8.19%  libjlib.so                  [.] CLZWExpander::expand(void*)
  4.62%  libjhtree.so                [.] CMRUCacheOf<CKeyIdAndPos, 
CJHTreeNode>
  1.97%  [kernel]                    [k] futex_wait_setup
  1.51%  [kernel]                    [k] native_write_msr_safe
  1.34%  [kernel]                    [k] futex_wake

Any suggestion for how to trace where/who is responsible for the spin_lock ?

thank you in advance,
mark 
