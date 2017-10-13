From: Leandro Silva <silvaleandrodp@gmail.com>
Subject: Getting error with event modifiers
Date: Fri, 13 Oct 2017 10:42:36 -0300
Message-ID: <CAJ5k3oqprQSt7pS_fE2WU8-z3zsXV8N-6dCuCa++QZ7c1cGg-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:43093 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756659AbdJMNm5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Oct 2017 09:42:57 -0400
Received: by mail-io0-f173.google.com with SMTP id 134so4807326ioo.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2017 06:42:57 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm trying to read the power of the system in kernel space using the
event power/energy-cores/ with the perf tool using the :k modifier
like below:

perf stat -a -e power/energy-cores/:k -I 1000 sleep 10


user@dkphome:/sys/bus/event_source/devices/cpu$ sudo perf stat -a -e
power/energy-cores/:k -I 1000 sleep 30
event syntax error: '..nergy-cores/:k'
                                   \___ parser error
Run 'perf list' for a list of valid events

  Usage: perf stat [<options>] [<command>]

     -e, --event <event>   event selector. use 'perf list' to list
available events

I though that this event didn't support the :k modifier but i made
other tests and now i think that this may be a bug or i'm trying with
the wrong syntax. To test it i tried other event like below:

The cache-misses event can be called in two ways cache-misses OR
cpu/cache-misses/ so i tried both with the modifier

user@dkphome:/sys/bus/event_source/devices/cpu$ sudo perf stat -a -e
cache-misses:k -I 1000 sleep 5
#           time             counts unit events
     1.000429017            287.589      cache-misses:k
     2.000828552            195.999      cache-misses:k
     3.001086195            216.885      cache-misses:k
     4.001438671            240.842      cache-misses:k
     5.000702347            314.469      cache-misses:k
user@dkphome:/sys/bus/event_source/devices/cpu$ sudo perf stat -a -e
cpu/cache-misses/:k -I 1000 sleep 5
event syntax error: '..ache-misses/:k'
                                   \___ parser error
Run 'perf list' for a list of valid events

  Usage: perf stat [<options>] [<command>]

     -e, --event <event>   event selector. use 'perf list' to list
available events
user@dkphome:/sys/bus/event_source/devices/cpu$ sudo perf stat -a -e
cpu/cache-misses/ -I 1000 sleep 5
#           time             counts unit events
     1.000379149          1.949.866      cpu/cache-misses/
     2.000628057          1.023.040      cpu/cache-misses/
     3.000906500          1.284.476      cpu/cache-misses/
     4.001197960            853.127      cpu/cache-misses/
     5.000762257            722.242      cpu/cache-misses/

Someone have a clue on how could i use the :k modifier with the
power/energy-cores/ event?
---

Thanks for the help
Leandro Divino Pimenta da Silva
