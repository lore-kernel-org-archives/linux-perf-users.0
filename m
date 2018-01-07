From: Dmitry Dolgov <9erthalion6@gmail.com>
Subject: Re: perf memory metrics on ec2 instance
Date: Sun, 7 Jan 2018 16:37:11 +0100
Message-ID: <CA+q6zcWn=J6s-9=AyVYgQW+J56edeEn3EuBX78oP2QwmQKTgog@mail.gmail.com>
References: <CA+q6zcXGsPT3bXhUS2gNf0_JPm+jLHBaSH+T_5CNPkZ3A9GK7g@mail.gmail.com>
 <87608i5xcd.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35049 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeAGPhw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Jan 2018 10:37:52 -0500
Received: by mail-io0-f177.google.com with SMTP id 14so10480490iou.2
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jan 2018 07:37:52 -0800 (PST)
In-Reply-To: <87608i5xcd.fsf@linux.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org

> On 4 January 2018 at 00:36, Andi Kleen <ak@linux.intel.com> wrote:
>
> perf mem requires PEBS.  PEBS is currently not supported in VMs. You
> should let Amazon know that you need it though, so it could be possibly
> implemented.

Thanks for the explanation. Is there any alternative way to get memory
counters? If I need to know only how many times an event appeared, can I do
more or less the same with perf stat -e 'counter_name' without PEBS support?
