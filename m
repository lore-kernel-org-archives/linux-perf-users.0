From: Christian Convey <christian.convey@gmail.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Mon, 9 Jan 2017 12:59:38 -0500
Message-ID: <CAPfS4ZxuWKhR2KXvkTQf9om5DcAsC_D2sQE5KC-eJNv6GDREyQ@mail.gmail.com>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <3722511.TPbTubHR2j@milian-kdab2> <CAPfS4ZyBOz_E5k3DKf8qqMbrKacCpijBM4-aUsgeL5LJTnxNyw@mail.gmail.com>
 <20170108084403.39baa3d793af5fed3ed4aeac@kernel.org> <CAPfS4ZzKPTPrBJY+yhMBte_wyVgTnt-kuDUGF39BxV0NZs+TDQ@mail.gmail.com>
 <20170109170354.GD13299@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32879 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422830AbdAIR7k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2017 12:59:40 -0500
Received: by mail-qk0-f194.google.com with SMTP id 11so7447231qkl.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2017 09:59:39 -0800 (PST)
In-Reply-To: <20170109170354.GD13299@naverao1-tp.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

On Mon, Jan 9, 2017 at 12:03 PM, Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
...
> On 2017/01/09 10:19AM, Christian Convey wrote:
> Try compiling your program with -O2, or use a newer perf:
> https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?id=e47392bf9c0613a058cd20ee89d8ce9d957d4b24

Thanks for the suggestion.  I switched from -O0 to -O2, and
unfortunately I could no longer add the probe events at all:

cconvey@spaceman ~/dw/scratch/cconvey/src/fib $ sudo -E
${PERF_EXEC_PATH}/perf probe --exec=./fib -f --add='* $params'
Failed to write event: Invalid argument
Please upgrade your kernel to at least 3.14 to have access to feature @__fmt
 Error: Failed to add events.

cconvey@spaceman ~/dw/scratch/cconvey/src/fib $ sudo -E
${PERF_EXEC_PATH}/perf --version
perf version 4.8.11

cconvey@spaceman ~/dw/scratch/cconvey/src/fib $ uname -a
Linux spaceman 4.8.0-32-generic #34-Ubuntu SMP Tue Dec 13 14:30:43 UTC
2016 x86_64 x86_64 x86_64 GNU/Linux


- Christian
