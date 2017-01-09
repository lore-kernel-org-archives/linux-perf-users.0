From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Mon, 09 Jan 2017 12:20:48 -0500
Message-ID: <y0mshosi1zj.fsf@fche.csb>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932489AbdAIRUz (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2017 12:20:55 -0500
In-Reply-To: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
        (Christian Convey's message of "Thu, 5 Jan 2017 22:49:13 -0500")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christian Convey <christian.convey@gmail.com>
Cc: linux-perf-users@vger.kernel.org


christian.convey wrote:

> [...]
> Systemtap has an example script, "para-callgraph.stp", that reports
> the *sequence* of userspace function calls and returns made by an
> application.
>
> I'd like to perform that kind of analysis using perf tools rather than
> Systemtap, because I recently learned that Canonical considers
> Systemtap to be unsupported.  (E.g., it's pretty broken on Ubuntu
> 14.04.)
> [...]

For what it's worth, upstream systemtap versions work generally fine on
Ubuntus old & new.  Consider building your own, if Canonical's community
is not keeping it fresh on their own distro.

That said, consider also dyninst (C++ binary instrumentation API), or
perhaps even as a kernel-independent pure-userspace systemtap backend:
  % stap --runtime=dyninst

- FChE
