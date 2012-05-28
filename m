From: Yipeng Huang <yipeng@gmail.com>
Subject: Questions about cycle events
Date: Mon, 28 May 2012 14:54:44 +0800
Message-ID: <CAB_n8zJ5DjXF=qbVYNWr8yHUhB2dNB3gHru=nJv490tcdtdfFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60997 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab2E1Gyq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 28 May 2012 02:54:46 -0400
Received: by lbbgm6 with SMTP id gm6so1703436lbb.19
        for <linux-perf-users@vger.kernel.org>; Sun, 27 May 2012 23:54:44 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear All,

Have a couple questions about how the cycle events in Perf are defined.

1. Is the perf stat -e cycles event a good equivalent for PAPI_TOT_CYC
(PAPI's total cycles event)?

2. Is there an overlap in counting between the cycles event and the
resource stall event r01a2 or are they distinct?

3. How can I find out how other particular events are defined? Is
there a reference available?

Thanks,

Yipeng
