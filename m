From: "Chinnathambi, Muthusamy" <muthusamy.chinnathambi@hp.com>
Subject: perf probe failed to find symbols -
Date: Tue, 16 Dec 2014 03:18:24 +0000
Message-ID: <050363D101EB63409B222217F4B02E781EC22E9F@G6W2492.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:33663 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbaLPDVU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 15 Dec 2014 22:21:20 -0500
Received: from g6t1526.atlanta.hp.com (g6t1526.atlanta.hp.com [15.193.200.69])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 225666463C
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2014 03:21:20 +0000 (UTC)
Received: from G6W4001.americas.hpqcorp.net (g6w4001.atlanta.hp.com [16.205.80.210])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g6t1526.atlanta.hp.com (Postfix) with ESMTPS id 1E59DC8
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2014 03:21:12 +0000 (UTC)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: "Chinnathambi, Muthusamy" <muthusamy.chinnathambi@hp.com>

Hi,

I wanted try perf probe, but I am getting the following failure.

[root@force perf_tests]# ./perf probe --add sys_read
Failed to find symbol sys_read in kernel
  Error: Failed to add events.
[root@force perf_tests]#

I had built and installed the kernel with kprobes enabled. Looks like the kernel is stripped, how should I build the kernel for perf to be able to find symbols.

Regards,
Muthusamy C
