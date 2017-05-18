From: Nan Xiao <xiaonan830818@gmail.com>
Subject: Why the stack frame in perf.data isn't displayed in FlameGraph?
Date: Thu, 18 May 2017 12:09:55 +0800
Message-ID: <CA+MhoaM8o2yap8mMVvJsbB2iwXtn05uh+0am5aACbFV50Oud_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34279 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbdEREJ4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2017 00:09:56 -0400
Received: by mail-pf0-f174.google.com with SMTP id 9so17296214pfj.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2017 21:09:56 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I am a newbie of using perf tools and FlameGraph. I write a simple
test program which is rafacimentoed from this
NTL(http://www.shoup.net/ntl/doc/tour-ex3.html) program:

#include <NTL/ZZX.h>

using namespace std;
using namespace NTL;

void inner(int i, ZZX& t, Vec<ZZX>& phi)
{
        for (long j = 1; j <= i-1; j++)
         if (i % j == 0)
            t *= phi(j);
}

void outer(int i, Vec<ZZX>& phi)
{
        ZZX t;
        t = 1;
        inner(i, t, phi);
        phi(i) = (ZZX(INIT_MONO, i) - 1)/t;
        cout << phi(i) << "\n";
}

int main()
{
   Vec<ZZX> phi(INIT_SIZE, 100);

   for (long i = 1; i <= phi.length(); i++) {
      outer(i, phi);
   }
}

And compile it using following command:

    g++ -pthread test.cpp -lntl -lgmp

I use "perf record -g ./a.out" to profile the program, but "perf
report" can only show "main" and "outer", no "inner" function
(https://github.com/NanXiao/images/blob/master/perf/perf.data):

......
+    7.10%     0.00%  a.out    a.out                [.] outer
+    7.10%     0.00%  a.out    a.out                [.] main
......

From the perf.svg(https://github.com/NanXiao/images/blob/master/perf/perf.svg),
there is neither "outer" nor "inner" stack frames.

Since there is "outer" in perf.data, why it can't display in
FlameGraph? Another doubt is why perf.data doesn't contain "inner"
stack frame?

Thanks in advance!

Best Regards
Nan Xiao
