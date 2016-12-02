From: HOUSSEN Franck <fghoussen@gmail.com>
Subject: Re: perf-probe : error "Rebuild with -g, or install an appropriate
 debuginfo package"
Date: Fri, 2 Dec 2016 11:40:15 +0100
Message-ID: <CABvthirubZd+MfSy8PUEXkt1GCveY1HxS7X-OWMpncVzjsU1kg@mail.gmail.com>
References: <CABvthiqmUuGqcDU6LQRJhsPiic4-qePRx8wJtMoj+D+ihjAVdg@mail.gmail.com>
 <20161201142624.2041eb5a2ed866f817dd7566@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35611 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933961AbcLBKkR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Dec 2016 05:40:17 -0500
Received: by mail-wm0-f54.google.com with SMTP id a197so12705186wmd.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Dec 2016 02:40:16 -0800 (PST)
In-Reply-To: <20161201142624.2041eb5a2ed866f817dd7566@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org

Installing dwarf was the solution. Now, compiling with either -g or
-ggdb, I can probe the function.

Thanks !

Franck

2016-12-01 6:26 GMT+01:00 Masami Hiramatsu <mhiramat@kernel.org>:
> On Wed, 30 Nov 2016 14:49:09 +0100
> HOUSSEN Franck <fghoussen@gmail.com> wrote:
>
>> I compiled myApp.cpp (that contains a function named myFunction) with:
>> ~>mpic++ -O2 -ggdb -fno-omit-frame-pointer -o myApp myApp.cpp
>>
>> When I try to probe a function from the myApp binary, I get:
>> ~> sudo perf probe --exe ./myApp --add "myFunction:2"
>> The /home/path/to/myApp file has no debug information.
>> Rebuild with -g, or install an appropriate debuginfo package.
>>   Error: Failed to add events.
>
> Could you run `eu-readelf -S myApp` ?
> Could you also try to build your app with '-g' instead of '-ggdb'?
> I guess mpic++ might generate some extened debuginfo or just ignored
> the option.
>
>>
>> ... -g has been set a t compile time and libelf (and libelf-dev) seems
>> to be installed:
>
> No, libelf is not related to this issue.
>
> [...]
>> PS : When I do that
>> ~>sudo perf probe --exe ./myApp --add "myFunction"
>> Added new event:
>>   probe_myApp:myFunction (on myFunction in /home/path/to/myApp)
>>
>> It works !?... I need to place the tracepoint at the second line below
>> the entry of myFunction =3D> replacing "myFunction" with "myFunction:2"
>> does not work ! Why ?...
>
> Without line number, perf probe tries to find symbols from symtab in
> the binary. DWARF (a.k.a. debuginfo) has much more information, like
> line-to-addr, local variable assignment etc.
>
> Thanks,
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>



--=20
Bonne journ=C3=A9e,

Franck HOUSSEN
