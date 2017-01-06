From: Christian Convey <christian.convey@gmail.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Fri, 6 Jan 2017 14:07:19 -0500
Message-ID: <CAPfS4Zx6ZzWWUsSEbstsd2En6bqo=z94NTWe6xh_tJ9eZd17+A@mail.gmail.com>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <87zij4nhvk.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36322 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936366AbdAFTHU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2017 14:07:20 -0500
Received: by mail-qt0-f178.google.com with SMTP id k15so316766284qtg.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jan 2017 11:07:20 -0800 (PST)
In-Reply-To: <87zij4nhvk.fsf@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

> Use the right tool for the job.
>
> On Intel, use a Broadwell or Skylake or Goldmont and use processor trace.
>
> perf record -e intel_pt//u foo
> perf script --itrace=cr

Hi Andi,

Thanks for the idea.  It sounds promising.

Unfortunately for my current situation, the CPU's on which I need to
run this are too old to have intel_pt.

- Christian
