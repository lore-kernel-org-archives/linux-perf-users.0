From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: perf: comparing "CPU performance / CPU impact" of two binaries?
Date: Tue, 20 Dec 2016 00:32:15 +0900
Message-ID: <3889b08f1e5a9f08081329a33d3fa5c2@admin.virtall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.virtall.com ([178.63.195.102]:48105 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755438AbcLSPhs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Dec 2016 10:37:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailext.virtall.com (Postfix) with ESMTP id AE03F72B555
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2016 16:32:16 +0100 (CET)
Received: from mailext.virtall.com ([127.0.0.1])
        by localhost (web1.virtall.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CYzyrSY9OuVD for <linux-perf-users@vger.kernel.org>;
        Mon, 19 Dec 2016 16:32:15 +0100 (CET)
Received: from admin.virtall.com (localhost [127.0.0.1])
        by mailext.virtall.com (Postfix) with ESMTP
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2016 16:32:15 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Let's say I have two binaries which convert complex data from one format 
to another.

I will run them on a busy server at low priority and I don't really care 
if one is faster than the other - I want to know which of them will have 
lower "CPU impact" to perform the same task.


binary_1:

    26879408.172126      task-clock:u (msec)       #    0.709 CPUs 
utilized
                  0      context-switches:u        #    0.000 K/sec
                  0      cpu-migrations:u          #    0.000 K/sec
         1142192473      page-faults:u             #    0.042 M/sec
     81241884199345      cycles:u                  #    3.022 GHz         
              (83.59%)
     65593453047217      stalled-cycles-frontend:u #   80.74% frontend 
cycles idle     (83.59%)
     34800591044061      stalled-cycles-backend:u  #   42.84% backend 
cycles idle      (67.09%)
     98783244945290      instructions:u            #    1.22  insn per 
cycle
                                                   #    0.66  stalled 
cycles per insn  (83.64%)
     18250463170335      branches:u                #  678.976 M/sec       
              (83.60%)
       169450790563      branch-misses:u           #    0.93% of all 
branches          (83.59%)

    37911.679793230 seconds time elapsed


binary_2:

    33134123.016486      task-clock:u (msec)       #    1.071 CPUs 
utilized
                  0      context-switches:u        #    0.000 K/sec
                  0      cpu-migrations:u          #    0.000 K/sec
         1947142971      page-faults:u             #    0.059 M/sec
    105227191042973      cycles:u                  #    3.176 GHz         
              (83.69%)
     80721331715962      stalled-cycles-frontend:u #   76.71% frontend 
cycles idle     (83.69%)
     46245245856602      stalled-cycles-backend:u  #   43.95% backend 
cycles idle      (67.25%)
    140459525725760      instructions:u            #    1.33  insn per 
cycle
                                                   #    0.57  stalled 
cycles per insn  (83.93%)
      9187630340020      branches:u                #  277.286 M/sec       
              (83.70%)
       112107883833      branch-misses:u           #    1.22% of all 
branches          (83.69%)

    30949.033426941 seconds time elapsed


As you can see, binary_1 was executing for 37911 seconds, and binary_2 
for 30949 seconds.

On the other hand, binary_2 used more cycles and instructions.


Because I will be running it on a busy server, I think that binary_1 
will have lower impact on the CPU (and, other tasks). Is my reasoning 
correct?


Tomasz Chmielewski
https://lxadm.com
