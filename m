From: Milian Wolff <milian.wolff@kdab.com>
Subject: perf probe: register type casting to string
Date: Wed, 06 Sep 2017 12:29:40 +0200
Message-ID: <1715726.r9yPp6ySFi@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:54556 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbdIFK3o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Sep 2017 06:29:44 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hey all,

it seems like it's impossible to use the :string type cast feature of perf 
probe when using a register as the source. I.e.:

~~~~~
┌milian@agathebauer:/tmp
└$ cat test.c
void blub(const char* l)
{
}

int main(int argc, char** argv)
{
  blub(argv[0]);
  return 0;
}
┌milian@agathebauer:/tmp
└$ gcc -O0 -g test.c
┌milian@agathebauer:/tmp
└$ perf probe -x ./a.out 'blub label=%di:string'
Failed to write event: Invalid argument
  Error: Failed to add events.
~~~~~~

Is there anything I'm missing? When I use `l` instead of `%di` it works. But 
if I'm trying to add a tracepoint to a library that got stripped and is 
missing debug symbols, what can I do?

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
