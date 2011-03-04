From: Han Pingtian <phan@redhat.com>
Subject: how to use 'perf kvm'?
Date: Fri, 4 Mar 2011 16:28:34 +0800
Message-ID: <20110304082834.GB2881@hpt.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755871Ab1CDIYT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Mar 2011 03:24:19 -0500
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

Hello,

Can someone tell me how to use the subcommand 'kvm' of the perf tool?
I'm trying to use it this way:

perf kvm --guest --guestkallsyms kallsyms top

where kallsyms is copied from the kvm guest. But nothing useful is
displayed, only some headers:


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PerfTop:       0 irqs/sec  kernel:-nan% us:-nan% guest kernel:-nan% guest us:-nan% exact: -nan% [1000Hz cycles],  (all, 2 CPUs)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

             samples  pcnt  DSO
             _______ _____

exiting.

Thanks in advance.

-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY
