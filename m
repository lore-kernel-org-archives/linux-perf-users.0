From: Andi Kleen <ak@linux.intel.com>
Subject: Re: perf memory metrics on ec2 instance
Date: Wed, 03 Jan 2018 15:36:18 -0800
Message-ID: <87608i5xcd.fsf@linux.intel.com>
References: <CA+q6zcXGsPT3bXhUS2gNf0_JPm+jLHBaSH+T_5CNPkZ3A9GK7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46429 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeACXg5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Jan 2018 18:36:57 -0500
In-Reply-To: <CA+q6zcXGsPT3bXhUS2gNf0_JPm+jLHBaSH+T_5CNPkZ3A9GK7g@mail.gmail.com>
        (Dmitry Dolgov's message of "Wed, 3 Jan 2018 15:50:28 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Dmitry Dolgov <9erthalion6@gmail.com> writes:
>
> It's quite confusing for me, because the same works fine on my local machine,
> but this error I've got is not about something being not supported. Can you tell
> me what I'm doing wrong?

perf mem requires PEBS.  PEBS is currently not supported in VMs. You
should let Amazon know that you need it though, so it could be possibly
implemented.

-Andi
