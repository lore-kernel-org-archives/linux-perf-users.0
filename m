From: Francis Moreau <francis.moro@gmail.com>
Subject: perf-probe: issue with latest fedora kernel
Date: Thu, 09 Dec 2010 16:00:08 +0100
Message-ID: <m2pqtb9ekn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63492 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444Ab0LIPAO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 9 Dec 2010 10:00:14 -0500
Received: by wwa36 with SMTP id 36so2554724wwa.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Dec 2010 07:00:13 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I'm trying to use perf-probe(1) with the latest F14 kernel
(2.6.35.9-64.fc14.x86_64).

I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
contains the running vmlinux image AFAICT.

I added it to the buildid cache:

$ perf buildid-cache -v -a /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux
Adding 4d89e23415d8ab491cfc8ef8aa67764b91cc6787 /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux: OK

But when running perf-probe(1) like the following:

  $ perf probe schedule cpu
  Failed to find path of kernel moduleFailed to open debuginfo file.
  Error: Failed to add events. (-2)

it fails.

One strange thing is that when perf read the running kernel build id, it
get: 882b1b53eb1d65320e8fa710273aa8493896c4.

Could anybody tell me what I'm doing wrong ?

Thanks
-- 
Francis
