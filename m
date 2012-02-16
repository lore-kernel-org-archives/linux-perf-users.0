From: Kant <fnord.hammer@gmail.com>
Subject: RWX stack in perf
Date: Thu, 16 Feb 2012 17:30:42 +0100
Message-ID: <CAEmqk_zpVjv3HxT2xUbbUx8QwfESMQhCrsWHWOvQ91R0um3fhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37208 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab2BPQao (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 16 Feb 2012 11:30:44 -0500
Received: by bkcjm19 with SMTP id jm19so2129561bkc.19
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Feb 2012 08:30:43 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Building perf 3.2.6 ends up with RWX stack, preventing me from using perf top.

Using -Wa,--noexecstack seems to fix the problem.

mmap(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = -1 EPERM (Operation not
permitted)
