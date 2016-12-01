From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: perf-probe : error
 "Rebuild with -g, or install an appropriate debuginfo package"
Date: Thu, 1 Dec 2016 14:26:24 +0900
Message-ID: <20161201142624.2041eb5a2ed866f817dd7566@kernel.org>
References: <CABvthiqmUuGqcDU6LQRJhsPiic4-qePRx8wJtMoj+D+ihjAVdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754354AbcLAF0a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Dec 2016 00:26:30 -0500
In-Reply-To: <CABvthiqmUuGqcDU6LQRJhsPiic4-qePRx8wJtMoj+D+ihjAVdg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: HOUSSEN Franck <fghoussen@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Wed, 30 Nov 2016 14:49:09 +0100
HOUSSEN Franck <fghoussen@gmail.com> wrote:

> I compiled myApp.cpp (that contains a function named myFunction) with:
> ~>mpic++ -O2 -ggdb -fno-omit-frame-pointer -o myApp myApp.cpp
> 
> When I try to probe a function from the myApp binary, I get:
> ~> sudo perf probe --exe ./myApp --add "myFunction:2"
> The /home/path/to/myApp file has no debug information.
> Rebuild with -g, or install an appropriate debuginfo package.
>   Error: Failed to add events.

Could you run `eu-readelf -S myApp` ?
Could you also try to build your app with '-g' instead of '-ggdb'?
I guess mpic++ might generate some extened debuginfo or just ignored
the option.

> 
> ... -g has been set a t compile time and libelf (and libelf-dev) seems
> to be installed:

No, libelf is not related to this issue.

[...]
> PS : When I do that
> ~>sudo perf probe --exe ./myApp --add "myFunction"
> Added new event:
>   probe_myApp:myFunction (on myFunction in /home/path/to/myApp)
> 
> It works !?... I need to place the tracepoint at the second line below
> the entry of myFunction => replacing "myFunction" with "myFunction:2"
> does not work ! Why ?...

Without line number, perf probe tries to find symbols from symtab in
the binary. DWARF (a.k.a. debuginfo) has much more information, like
line-to-addr, local variable assignment etc.

Thanks,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
