From: Jack Henschel <jackdev@mailbox.org>
Subject: Filter option should follow a tracer option
Date: Fri, 18 Aug 2017 11:43:51 +0200 (CEST)
Message-ID: <2141818167.39420.1503049431846@office.mailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:50964 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750808AbdHRJnz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Aug 2017 05:43:55 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 0154C41A07
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Aug 2017 11:43:53 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id sfarDG6Qy54k for <linux-perf-users@vger.kernel.org>;
        Fri, 18 Aug 2017 11:43:52 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi everyone,

I'm experimenting with Intel PT and perf, but I am currently stuck at getting filters to work with `perf record`.

I have the following command:
> perf record -e intel_pt// --filter 'filter main @ /bin/sleep' /bin/sleep 1
But it throws this error message:
> --filter option should follow a -e tracepoint or HW tracer option

Maybe this is a trivial mistake, but I don't understand the error, because as far as I'm concerned the --filter options *is* following a -e HW tracer option.

I'm using perf version 4.9.30 with kernel 4.9.30-2+deb9u3 on Debian 9 Stretch.

Best Regards,
Jack Henschel
