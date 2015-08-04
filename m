From: Milian Wolff <mail@milianw.de>
Subject: perf: remount of tracefs required
Date: Tue, 04 Aug 2015 16:44:53 +0200
Message-ID: <5297956.5blcApkzlY@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:45187 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965281AbbHDOo4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 10:44:56 -0400
Received: from milian-kdab2.localnet (unknown [185.28.184.2])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id 03E9B6280369
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2015 16:44:53 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hey all,

on ArchLinux with Linux 4.1.3, perf 4.1.0, I get:

$ perf trace
Error:  No permissions to read 
/sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'
$ sudo mount -o remount,mode=755 /sys/kernel/debug
$ perf trace
Error:  No permissions to read 
/sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'

This is b/c Arch uses tracefs, and running

$ sudo mount -o remount,mode=755 /sys/kernel/debug/tracefs

fixes the issue for me. Could someone please amend the error message? Do I 
also need to remount debugfs, or is tracefs sufficient for using more advanced 
perf tools?

Thanks

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
