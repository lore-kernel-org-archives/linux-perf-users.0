From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Re: Bizarre results from perf event API
Date: Sat, 21 Feb 2015 21:44:02 +0000
Message-ID: <CAAk6P0X5N3pvEjaEy-v6mHy7+fg3pdLyeRYR2VGm2wuqPYeOZw@mail.gmail.com>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
	<54E7D3B3.7020108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:40377 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbBUVoD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 21 Feb 2015 16:44:03 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so10652797igk.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Feb 2015 13:44:02 -0800 (PST)
In-Reply-To: <54E7D3B3.7020108@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi,

> Trying using a program with established results. e.g., This is from
> PeterZ years ago. On intel 'perf stat -e instructions a.out' should show
> ~1 billion (a wee bit more, but clearly in the 1b range).

That program itself gave the expected results, but it's a good
suggestion.  When I tried changing that program to also fork a bunch
of child processes, I started getting similarly weird results to what
I had seen before.

Looking more closely at the behavior of perf, I think the essential
difference is that perf uses the *child* PID as argument to
perf_event_open.  When I tried changing my program to do the same, it
seems to have fixed the problem.  That is to say, where I used
something like

   fd = perf_event_open(..., getpid(), ...);
   child = fork();
   if (child == 0) {
       execvp(...);
   }

I needed to instead use

   pipe(pipefd);
   child = fork();
   if (child == 0) {
       read(pipefd[0], &x, 1);
       execvp(...);
   }
   fd = perf_event_open(..., child, ...);
   write(pipefd[1], &x, 1);

This seems like a bug, especially since it only seems to come up when
there are grandchild processes involved.  (And I can't help thinking
the first version is a lot more elegant!)  Does the kernel somehow get
confused because enable_on_exec is set and the original process hasn't
actually exec'ed anything?

The problem doesn't occur *every* time there are grandchildren - I
didn't see any problems when running some basic experiments with shell
scripts.  But here's a simple C program that does exhibit the problem:

int main()
{
  int i, j;
  for (i = 0; i < 50; i++) {
    if (!fork()) {
      for (i = 0; i < 100000000; i++) {
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
        asm("nop");
      }
      exit(0);
    }
  }
  for (i = 0; i < 50; i++)
    wait(&j);
  return 0;
}

At any rate, thanks for your advice!

Benjamin
