From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Tue, 10 Jan 2017 09:25:07 +0900
Message-ID: <20170110092507.939229d10bc7cd08b12d31dc@kernel.org>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
        <3722511.TPbTubHR2j@milian-kdab2>
        <CAPfS4ZyBOz_E5k3DKf8qqMbrKacCpijBM4-aUsgeL5LJTnxNyw@mail.gmail.com>
        <20170108084403.39baa3d793af5fed3ed4aeac@kernel.org>
        <CAPfS4ZzKPTPrBJY+yhMBte_wyVgTnt-kuDUGF39BxV0NZs+TDQ@mail.gmail.com>
        <20170109170354.GD13299@naverao1-tp.localdomain>
        <CAPfS4ZxuWKhR2KXvkTQf9om5DcAsC_D2sQE5KC-eJNv6GDREyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752287AbdAJAZV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2017 19:25:21 -0500
In-Reply-To: <CAPfS4ZxuWKhR2KXvkTQf9om5DcAsC_D2sQE5KC-eJNv6GDREyQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christian Convey <christian.convey@gmail.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

On Mon, 9 Jan 2017 12:59:38 -0500
Christian Convey <christian.convey@gmail.com> wrote:

> On Mon, Jan 9, 2017 at 12:03 PM, Naveen N. Rao
> <naveen.n.rao@linux.vnet.ibm.com> wrote:
> ...
> > On 2017/01/09 10:19AM, Christian Convey wrote:
> > Try compiling your program with -O2, or use a newer perf:
> > https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?id=e47392bf9c0613a058cd20ee89d8ce9d957d4b24
> 
> Thanks for the suggestion.  I switched from -O0 to -O2, and
> unfortunately I could no longer add the probe events at all:
> 
> cconvey@spaceman ~/dw/scratch/cconvey/src/fib $ sudo -E
> ${PERF_EXEC_PATH}/perf probe --exec=./fib -f --add='* $params'
> Failed to write event: Invalid argument
> Please upgrade your kernel to at least 3.14 to have access to feature @__fmt
>  Error: Failed to add events.
> 
> cconvey@spaceman ~/dw/scratch/cconvey/src/fib $ sudo -E
> ${PERF_EXEC_PATH}/perf --version
> perf version 4.8.11
> 
> cconvey@spaceman ~/dw/scratch/cconvey/src/fib $ uname -a
> Linux spaceman 4.8.0-32-generic #34-Ubuntu SMP Tue Dec 13 14:30:43 UTC
> 2016 x86_64 x86_64 x86_64 GNU/Linux
 
It seems that the above fix is included v4.9 series, not v4.8.

Could you try to download the latest kernel and build the perf?
You don't need to build kernel, only tools/perf/perf is what you need.
So, what you need is
$ cd <somewhere-your-download-kernel>/tools/perf/
$ make

Not that you have to install libdw-dev for perf-probe before that.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
