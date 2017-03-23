From: David Ahern <dsahern@gmail.com>
Subject: Re: perf software events broken in containers
Date: Thu, 23 Mar 2017 08:21:27 -0600
Message-ID: <f95c7553-51f1-cee9-b8cc-643c32b0f72c@gmail.com>
References: <CAE40pddXy_vJ5Xd4eunsuYbnaqCDV2bJNqfsdLcMY3kvR-hqOg@mail.gmail.com>
 <8c4186d0-bfbf-6f1a-c953-9859bf057856@redhat.com>
 <CAE40pdd06QXckEMYfU63c=Zvrrn22A-sm-Sh37CymR5rpJZ57Q@mail.gmail.com>
 <4bf76843-d25e-4cda-30ce-0984f8778704@redhat.com>
 <CAE40pdcbbU=e6YXTivOW1=w2urucbQknUZc9VzebPgHeiLrKqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34690 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbdCWOVa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Mar 2017 10:21:30 -0400
Received: by mail-pf0-f172.google.com with SMTP id p189so83284208pfp.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2017 07:21:29 -0700 (PDT)
In-Reply-To: <CAE40pdcbbU=e6YXTivOW1=w2urucbQknUZc9VzebPgHeiLrKqw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>, William Cohen <wcohen@redhat.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 3/22/17 3:35 PM, Brendan Gregg wrote:
> We also found that docker explicitly blocks perf_event_open() by default[1]:
> 
> "perf_event_open    Tracing/profiling syscall, which could leak a lot
> of information on the host."

as it should. The event collection does not discriminate by namespaces.
