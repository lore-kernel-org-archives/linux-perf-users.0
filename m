From: Yilong Li <yilongl@cs.stanford.edu>
Subject: Re: Need help in tracking down OS jitters using Intel PT
Date: Thu, 23 Mar 2017 12:56:41 -0700
Message-ID: <CAPJB79Rx1NK0DOgt2undUFenq-J6LTZ-kUrj4wKjfqu5OMJMMw@mail.gmail.com>
References: <CAPJB79SqGQY-jb455rJXsyzF7cEkrLE653rwG+rPy6F4+-VQEA@mail.gmail.com>
 <6ccea408-bf0e-e730-5375-e6cba55f6540@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp2.cs.stanford.edu ([171.64.64.26]:47166 "EHLO
        smtp2.cs.Stanford.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdCWT4n (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Mar 2017 15:56:43 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35904)
        by smtp2.cs.Stanford.EDU with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.88)
        (envelope-from <yilongl@cs.stanford.edu>)
        id 1cr8qf-0003BS-LR
        for linux-perf-users@vger.kernel.org; Thu, 23 Mar 2017 12:56:42 -0700
Received: by mail-pg0-f48.google.com with SMTP id g2so128218242pge.3
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2017 12:56:41 -0700 (PDT)
In-Reply-To: <6ccea408-bf0e-e730-5375-e6cba55f6540@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Thanks for the information! I didn't know that. I will give it a try.

Yilong

On Thu, Mar 23, 2017 at 8:30 AM, David Ahern <dsahern@gmail.com> wrote:
> On 3/23/17 3:28 AM, Yilong Li wrote:
>> What am I missing? Where does the 15us go? The program and the scripts
>> I used in the experiment can be found here:
>> https://github.com/yilongli/OSJitterTest.
>
> have you tried the hw latency detector? kernel/trace/trace_hwlat.c and
> config HWLAT_TRACER
