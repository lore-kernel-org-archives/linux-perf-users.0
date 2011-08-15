From: Han Pingtian <phan@redhat.com>
Subject: How to use perf kvm?
Date: Mon, 15 Aug 2011 09:28:50 +0800
Message-ID: <20110815012850.GG4805@hpt.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab1HOB2T (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 14 Aug 2011 21:28:19 -0400
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: yanmin_zhang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org

Hello,

Could you please tell me how to use subcommand kvm of perf? I have tried:

[root@dell-pem710-02 ~]# pgrep qemu-kvm
6912
[root@dell-pem710-02 ~]# sshfs -o allow_other,direct_io  10.16.71.8:/
guestmount/6912
root@10.16.71.8's password:
[root@dell-pem710-02 ~]# perf kvm   --guest --guestmount ~/guestmount top

But there is no kvm guest's info. Only host's info displayed.

Thanks in advance.
-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY
