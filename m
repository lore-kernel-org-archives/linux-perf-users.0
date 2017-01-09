From: Christian Convey <christian.convey@gmail.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Mon, 9 Jan 2017 13:08:46 -0500
Message-ID: <CAPfS4ZxoKn+3QycvGY8M=tj8P=c8DnBumXHw13f42WNuH1MggQ@mail.gmail.com>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <y0mshosi1zj.fsf@fche.csb>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35710 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970351AbdAISIs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2017 13:08:48 -0500
Received: by mail-qt0-f175.google.com with SMTP id x49so77296229qtc.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2017 10:08:47 -0800 (PST)
In-Reply-To: <y0mshosi1zj.fsf@fche.csb>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On Mon, Jan 9, 2017 at 12:20 PM, Frank Ch. Eigler <fche@redhat.com> wrote:
...
> For what it's worth, upstream systemtap versions work generally fine on
> Ubuntus old & new.  Consider building your own, if Canonical's community
> is not keeping it fresh on their own distro.

Thanks for the tip.

When I was using Ubuntu 14.04, Ubuntu's systemtap package was at
version 2.3, and it didn't even pass unit tests.

On 14.04 I tried to build my own systemtap 3.0.  IIRC, I ran into
enough problems with library versions, that my messiness threshold was
exceeded.  I think where I stopped as a problem involving the version
of libc-json, where Ubuntu 14.04's packaged version was too old.

>
> That said, consider also dyninst (C++ binary instrumentation API), or
> perhaps even as a kernel-independent pure-userspace systemtap backend:
>   % stap --runtime=dyninst

Cool, thanks for the tip.  I wasn't aware of stap's `--runtime` option.

Cheers,
Christian
