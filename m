From: OSDepend <osdepend@gmail.com>
Subject: Howto make perf probe work
Date: Mon, 1 Apr 2013 01:30:15 +0800
Message-ID: <201304010130139026692@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:65087 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab3CaRaS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 31 Mar 2013 13:30:18 -0400
Received: by mail-pd0-f177.google.com with SMTP id y14so892200pdi.36
        for <linux-perf-users@vger.kernel.org>; Sun, 31 Mar 2013 10:30:17 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi all,
	Is there any way to use perf probe to add new tracepoint like pagefault enter/exit?
	
	When I type perf probe fault:10
	I always get the error as follow:

		Debuginfo-analysis is not supported.
		Error: Failed to add events. (-38)
	
	What exactly i miss to get the perf probe work correctly?

Best,
Chen

2013-04-01



zhengchen
