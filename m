From: David Ahern <dsahern@gmail.com>
Subject: Re: Bizarre results from perf event API
Date: Mon, 23 Feb 2015 18:21:35 -0700
Message-ID: <54EBD21F.3030101@gmail.com>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>	<54E7D3B3.7020108@gmail.com> <CAAk6P0X5N3pvEjaEy-v6mHy7+fg3pdLyeRYR2VGm2wuqPYeOZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:47071 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbBXBVg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 Feb 2015 20:21:36 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so23219460iga.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Feb 2015 17:21:36 -0800 (PST)
In-Reply-To: <CAAk6P0X5N3pvEjaEy-v6mHy7+fg3pdLyeRYR2VGm2wuqPYeOZw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin Moody <benjamin.moody@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 2/21/15 2:44 PM, Benjamin Moody wrote:
> Hi,
>
>> Trying using a program with established results. e.g., This is from
>> PeterZ years ago. On intel 'perf stat -e instructions a.out' should show
>> ~1 billion (a wee bit more, but clearly in the 1b range).
>
> That program itself gave the expected results, but it's a good
> suggestion.  When I tried changing that program to also fork a bunch
> of child processes, I started getting similarly weird results to what
> I had seen before.

This is with the 1billion instructions sent earlier:

$ ./myperfstat ./1bi
Total instructions: 1000087491

$ perf stat -e instructions:u ./1bi

  Performance counter stats for './1bi':

      1,000,087,608      instructions:u

        0.285943713 seconds time elapsed

Using the second version of this program:

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

main ()
{
         int i;

         fork();
         fork();

         for (i = 0; i < 100000000; i++) {
                 asm("nop");
                 asm("nop");
                 asm("nop");
                 asm("nop");
                 asm("nop");
                 asm("nop");
                 asm("nop");
         }
         wait(NULL);
         wait(NULL);
         wait(NULL);
         wait(NULL);
}

This one spawn child processes so you have
     perf -> child -> gchild -> ggchild
                |---> gchild

So it has the grandparent characteristics you are getting at.

$ ./myperfstat ./1bi4
Total instructions: 4000094342

$ perf stat -e instructions:u ./1bi4

  Performance counter stats for './1bi4':

      4,000,094,649      instructions:u

        0.259537842 seconds time elapsed

Still seems to match up.

This is on:
$ uname -r
3.18.7-200.fc21.x86_64

>
> Looking more closely at the behavior of perf, I think the essential
> difference is that perf uses the *child* PID as argument to
> perf_event_open.  When I tried changing my program to do the same, it
> seems to have fixed the problem.  That is to say, where I used
> something like

And I did not modify the mystat.c program to do this:

>
>     fd = perf_event_open(..., getpid(), ...);
>     child = fork();
>     if (child == 0) {
>         execvp(...);
>     }
>
> I needed to instead use
>
>     pipe(pipefd);
>     child = fork();
>     if (child == 0) {
>         read(pipefd[0], &x, 1);
>         execvp(...);
>     }
>     fd = perf_event_open(..., child, ...);
>     write(pipefd[1], &x, 1);
