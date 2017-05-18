From: Nan Xiao <xiaonan830818@gmail.com>
Subject: Re: Why the stack frame in perf.data isn't displayed in FlameGraph?
Date: Thu, 18 May 2017 21:24:04 +0800
Message-ID: <CA+MhoaOJkUe-EyP67F+YtNb04TjfteTSS=KHiN98ry4zK5WXWA@mail.gmail.com>
References: <CA+MhoaM8o2yap8mMVvJsbB2iwXtn05uh+0am5aACbFV50Oud_g@mail.gmail.com>
 <9775568.X03CyG2sn6@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36643 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbdERNYQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2017 09:24:16 -0400
Received: by mail-pg0-f44.google.com with SMTP id x64so22794179pgd.3
        for <linux-perf-users@vger.kernel.org>; Thu, 18 May 2017 06:24:10 -0700 (PDT)
In-Reply-To: <9775568.X03CyG2sn6@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Hi Milian,

Firstly, thanks very much for your kind and detailed help!

(1) I recompile the program use "g++ -g -O2 ...", and use "perf record
--call-graph dwarf" to sample. The FlameGraph can display full stack
frames and "inner" function appears in both FlameGraph and "perf
record".

(2) > Also, to see inline frames, try to build perf from git (acme's
perf/core) and use `perf report --inline`.

I find my perf version doesn't support "--inline" option, and I can't
figure out what is the meaning of "build perf from git (acme's
perf/core)". Could you elaborate it? I just install perf tools using
"sudo pacman -S perf".

Thanks very much in advance!
Best Regards
Nan Xiao


On Thu, May 18, 2017 at 3:32 PM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Donnerstag, 18. Mai 2017 06:09:55 CEST Nan Xiao wrote:
>> Hi all,
>>
>> I am a newbie of using perf tools and FlameGraph. I write a simple
>> test program which is rafacimentoed from this
>> NTL(http://www.shoup.net/ntl/doc/tour-ex3.html) program:
>>
>> #include <NTL/ZZX.h>
>>
>> using namespace std;
>> using namespace NTL;
>>
>> void inner(int i, ZZX& t, Vec<ZZX>& phi)
>> {
>>         for (long j = 1; j <= i-1; j++)
>>          if (i % j == 0)
>>             t *= phi(j);
>> }
>>
>> void outer(int i, Vec<ZZX>& phi)
>> {
>>         ZZX t;
>>         t = 1;
>>         inner(i, t, phi);
>>         phi(i) = (ZZX(INIT_MONO, i) - 1)/t;
>>         cout << phi(i) << "\n";
>> }
>>
>> int main()
>> {
>>    Vec<ZZX> phi(INIT_SIZE, 100);
>>
>>    for (long i = 1; i <= phi.length(); i++) {
>>       outer(i, phi);
>>    }
>> }
>>
>> And compile it using following command:
>>
>>     g++ -pthread test.cpp -lntl -lgmp
>
> Frame pointers are missing, you probably want to use either
>
> a) `g++ -fno-omit-frame-pointers` which may work if NTL is header-only
> b) `g++ -g` to rely on dwarf debug information and then use `perf record --
> call-graph dwarf`
>
> In general, I suggest to always compile with `-O2 -g` when you want to
> profile, otherwise you are missing a lot of compiler optimizations, and/or
> cripple tools like perf that want to use debug information.
>
>> I use "perf record -g ./a.out" to profile the program, but "perf
>> report" can only show "main" and "outer", no "inner" function
>> (https://github.com/NanXiao/images/blob/master/perf/perf.data):
>>
>> ......
>> +    7.10%     0.00%  a.out    a.out                [.] outer
>> +    7.10%     0.00%  a.out    a.out                [.] main
>> ......
>
> I bet that's because the "inner" function got inlined and frame pointers are
> disabled (see above). Recompile with the command above, and then use `perf
> record --call-graph dwarf`.
>
> Also, to see inline frames, try to build perf from git (acme's perf/core) and
> use `perf report --inline`.
>
>> From the
>> perf.svg(https://github.com/NanXiao/images/blob/master/perf/perf.svg),
>> there is neither "outer" nor "inner" stack frames.
>>
>> Since there is "outer" in perf.data, why it can't display in
>> FlameGraph? Another doubt is why perf.data doesn't contain "inner"
>> stack frame?
>
> If the above fixes it for report, try to apply "[PATCH] perf script: Add --
> inline option" by Namhyung Kim. Then you can generate the flamegraph via
>
> perf script --inline | stackcollapse-perf.pl | flamegraph.pl > out.svg
>
> Which should also show the inline frames.
>
> Cheers, hope that helps
>
> --
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
