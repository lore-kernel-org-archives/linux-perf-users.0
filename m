From: Christian Convey <christian.convey@gmail.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Mon, 9 Jan 2017 21:32:09 -0500
Message-ID: <CAPfS4ZxT4tCo_=evtN8wHiJSUDFK0yR7W_KEvzXyBoNciHk-HQ@mail.gmail.com>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <3722511.TPbTubHR2j@milian-kdab2> <CAPfS4ZyBOz_E5k3DKf8qqMbrKacCpijBM4-aUsgeL5LJTnxNyw@mail.gmail.com>
 <20170108084403.39baa3d793af5fed3ed4aeac@kernel.org> <CAPfS4ZzKPTPrBJY+yhMBte_wyVgTnt-kuDUGF39BxV0NZs+TDQ@mail.gmail.com>
 <20170109170354.GD13299@naverao1-tp.localdomain> <CAPfS4ZxuWKhR2KXvkTQf9om5DcAsC_D2sQE5KC-eJNv6GDREyQ@mail.gmail.com>
 <20170110092507.939229d10bc7cd08b12d31dc@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32841 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161988AbdAJCcL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2017 21:32:11 -0500
Received: by mail-qt0-f194.google.com with SMTP id n13so6692431qtc.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2017 18:32:11 -0800 (PST)
In-Reply-To: <20170110092507.939229d10bc7cd08b12d31dc@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Milian Wolff <milian.wolff@kdab.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Masami,

On Mon, Jan 9, 2017 at 7:25 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> It seems that the above fix is included v4.9 series, not v4.8.
>
> Could you try to download the latest kernel and build the perf?
> You don't need to build kernel, only tools/perf/perf is what you need.
> So, what you need is
> $ cd <somewhere-your-download-kernel>/tools/perf/
> $ make

I tried 4.9, and it worked!  Thanks very much!

- Christian
