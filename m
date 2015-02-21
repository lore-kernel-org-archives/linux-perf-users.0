From: David Ahern <dsahern@gmail.com>
Subject: Re: Bizarre results from perf event API
Date: Fri, 20 Feb 2015 17:39:15 -0700
Message-ID: <54E7D3B3.7020108@gmail.com>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43579 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074AbbBUAjR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Feb 2015 19:39:17 -0500
Received: by mail-ig0-f182.google.com with SMTP id h15so7160670igd.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 16:39:16 -0800 (PST)
In-Reply-To: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin Moody <benjamin.moody@gmail.com>, linux-perf-users@vger.kernel.org

On 2/20/15 4:26 PM, Benjamin Moody wrote:
> I'm trying to write a program that uses the Linux perf event API to
> track the CPU usage of an arbitrary task.  I'm following the
> documentation at <http://linux.die.net/man/2/perf_event_open>.
>
> My program (highly simplified version shown below) seems to work most
> of the time, and as far as I can tell, it should be measuring exactly
> the same thing as what 'perf stat -e instructions:uD' measures.
> However, when I try measuring the performance of a certain large
> proprietary application, I get *completely* different results from my
> program and from perf stat.  (The results from perf are somewhat
> believable; mine are not.)
>

Trying using a program with established results. e.g., This is from 
PeterZ years ago. On intel 'perf stat -e instructions a.out' should show 
~1 billion (a wee bit more, but clearly in the 1b range).

int main (void)
{
         int i;

         for (i = 0; i < 100000000; i++) {
                 asm("nop");
                 asm("nop");
                 asm("nop");
                 asm("nop");
                 asm("nop");
                 asm("nop");
                 asm("nop");
         }

         return 0;
}
