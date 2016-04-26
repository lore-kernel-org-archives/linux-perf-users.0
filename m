From: Anurup M <anurupvasu@gmail.com>
Subject: Help needed. Default value for a event parameter (param=?)
Date: Tue, 26 Apr 2016 19:00:40 +0530
Message-ID: <571F6D80.5010602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33318 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbcDZNao (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Apr 2016 09:30:44 -0400
Received: by mail-pf0-f169.google.com with SMTP id 206so6942961pfu.0
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Apr 2016 06:30:44 -0700 (PDT)
Received: from [192.168.40.11] ([14.141.5.98])
        by smtp.gmail.com with ESMTPSA id 127sm37198010pfe.72.2016.04.26.06.30.42
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2016 06:30:42 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I have a question about perf event parameter. I am trying to add an event parameter
which should take a default value if not input by the user.

I have the event added in sys/bus/event_source/devices/<pmu>/events/  and there
is a configurable event parameter "unit=?"
ex: event=0x301,units=?

The perf list list it as below
# perf list
<pmu>/<event_alias>,units=?/ [Kernel PMU event]

Now I have a requirement that If user does not pass any value for the parameter "unit"
I should take a default value in my PMU implementation. Is this supported?

If not please guide me on where the change is needed.
Any suggestions are appreciated.

Thanks,
Anurup
