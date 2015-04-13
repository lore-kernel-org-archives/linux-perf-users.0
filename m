From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Sampling on sched:sched_switch
Date: Mon, 13 Apr 2015 18:34:38 +0530
Message-ID: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vn0-f41.google.com ([209.85.216.41]:40114 "EHLO
	mail-vn0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbbDMNEj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Apr 2015 09:04:39 -0400
Received: by vnbg62 with SMTP id g62so19397550vnb.7
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2015 06:04:39 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi

I am enabling sampling on tracepoint: sched:sched_switch, during which
i get no data points for a particular process but when i run:

perf stat -e "context_switch" <some exec>

then it shows that exec was context switched.

How it could be possible.?

Thanks
Regards
