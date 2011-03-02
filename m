From: Han Pingtian <phan@redhat.com>
Subject: perf archive warning
Date: Wed, 2 Mar 2011 12:23:54 +0800
Message-ID: <20110302042354.GB5186@hpt.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757565Ab1CBETq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2011 23:19:46 -0500
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hi,

perf archive has some waring messages, is this a bug?

root@intel-s3e36-01 perf]# ./perf-archive
tar: .build-id/b2/370e39ea2898c6e11c188e2f3879e4e3d6d1ef: Cannot stat: No such file or directory
tar: .build-id/b2/370e39ea2898c6e11c188e2f3879e4e3d6d1ef: Cannot stat: No such file or directory
tar: Exiting with failure status due to previous errors
Now please run:

$ tar xvf perf.data.tar.bz2 -C ~/.debug

wherever you need to run 'perf report' on.
[root@intel-s3e36-01 perf]# ./perf --version
perf version 2.6.38.rc6.166.g493f33
[root@intel-s3e36-01 perf]# ./perf buildid-list
b2370e39ea2898c6e11c188e2f3879e4e3d6d1ef [kernel.kallsyms]
dd95cb496ebc4ed922eeb5640965f1243fcfcd9a /lib/modules/2.6.32-118.el6.x86_64/kernel/fs/ext4/ext4.ko
9e1aca88b83308cec7574d74975fa6f7d654c96e /lib64/libc-2.12.so
d880be15bf992b5fbcc629e6bbf1c747a928ddd5 /lib64/libglib-2.0.so.0.2200.5
d1b2ca4e1ec8f81ba820e5f1375d960107ac7e50 /usr/lib64/libstdc++.so.6.0.13
[root@intel-s3e36-01 perf]#

-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY
