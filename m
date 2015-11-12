From: Tony Jones <tonyj@suse.de>
Subject: restricting counted/sampled events
Date: Thu, 12 Nov 2015 10:18:02 -0800
Message-ID: <5644D7DA.7050200@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57682 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579AbbKLSZs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 13:25:48 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id AFDF1AD2E
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 18:25:24 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I don't believe there is current support to do this,  but maybe I'm overlooking something?

I'd like to be able to restrict the pmu (or filter results) to report counting/sampling between two arbitrary code points,  such as a tracepoint or kprobe.

I believe it will require core perf changes and was curious on peoples thoughts?

Tony
