From: Andi Kleen <andi@firstfloor.org>
Subject: Re: toplev would hang forever when analyzing a program with PID
Date: Mon, 27 Mar 2017 13:35:38 -0700
Message-ID: <874lyewj8l.fsf@firstfloor.org>
References: <CADGfq7zQv_3B-vYkTi8p1SQ=xcjyp3cVBAGaL=P7-gUBobbDzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1363 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdC0Ufk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2017 16:35:40 -0400
In-Reply-To: <CADGfq7zQv_3B-vYkTi8p1SQ=xcjyp3cVBAGaL=P7-gUBobbDzg@mail.gmail.com>
        (Yijie Shen's message of "Sun, 26 Mar 2017 22:07:44 +0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yijie Shen <henry.yijieshen@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Yijie Shen <henry.yijieshen@gmail.com> writes:
>
>
> this would hang forever even if the process with such pid end, this
> happens whatever the pid is pointing at is, a Java process or a Linux
> tool such as top.
>
>
> Am I doing something wrong? What does the right command look like to
> analyze a program using PID?

You're using SMT, so toplev has to enable global monitoring (-a),
but that does not interact well with --pid in perf.

That's more a perf bug .

It would work in single thread mode or without SMT, or using intervals.

toplev should probably print a warning in this case.

-Andi

>
