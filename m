From: Andi Kleen <andi@firstfloor.org>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Sat, 7 Jan 2017 11:08:36 -0800
Message-ID: <20170107190835.GA26852@two.firstfloor.org>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <87zij4nhvk.fsf@firstfloor.org>
 <CAPfS4Zx6ZzWWUsSEbstsd2En6bqo=z94NTWe6xh_tJ9eZd17+A@mail.gmail.com>
 <CAM9d7cjdNdeUKge_LbSwWyCdnrvzP2VxKGLy3tAw3q03D5Jf3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:55363 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdAGTIj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 7 Jan 2017 14:08:39 -0500
Content-Disposition: inline
In-Reply-To: <CAM9d7cjdNdeUKge_LbSwWyCdnrvzP2VxKGLy3tAw3q03D5Jf3w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@gmail.com>
Cc: Christian Convey <christian.convey@gmail.com>, Andi Kleen <andi@firstfloor.org>, linux-perf-users <linux-perf-users@vger.kernel.org>

> You can use uftrace for function tracing.  It doesn't have a hardware dependency
> but you need to rebuild your program with instrumentation enabled (like -pg
> or -finstrument-functions in gcc).
> 
> https://github.com/namhyung/uftrace

I have a similar tool here. 

http://github.com/andikleen/ftracer

But it's really far inferior to hardware tracing. Use the right tool for the
job.

-Andi
