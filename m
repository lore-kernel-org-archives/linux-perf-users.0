From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: What does this mean by duplicating performance events in "perf reporting"
Date: Tue, 18 Jun 2013 17:31:26 -0400
Message-ID: <CAEuYUeo=dpmsismX_zbFimP977z9fyo2xy8Jxn0_HKxPzFWYMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:40293 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307Ab3FRVb2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Jun 2013 17:31:28 -0400
Received: by mail-ea0-f180.google.com with SMTP id k10so2879039eaj.11
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jun 2013 14:31:27 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>

Hi all, does someone could help me with this issue?

I use perf to record such performance counter:
     sudo perf record --stat -fo perf_dacapo.data -e context-switches
-e major-faults java -jar dacapo-9.12-bach.jar xalan

But when I use perf report :
     sudo perf report -i perf_dacapo_tomcat.data --stdio -n --threads|less

I get the result like this:

# ========
# captured on: Tue Jun 18 15:22:30 2013
# hostname : shashaa-OptiPlex-960
# os release : 3.2.0-48-generic
# perf version : 3.2.46
# arch : x86_64
# nrcpus online : 4
# nrcpus avail : 4
# cpudesc : Intel(R) Core(TM)2 Quad CPU Q9400 @ 2.66GHz
# cpuid : GenuineIntel,6,23,10
# total memory : 8046912 kB
# cmdline : /usr/bin/perf_3.2.0-48 record --stat -fo
perf_dacapo_tomcat.data -e context-switches -e major-faults java -jar
Dropbox/perf/dacapo-9.12-bach.jar xalan -t 3
# event : name = context-switches, type = 1, config = 0x3, config1 =
0x0, config2 = 0x0, excl_usr = 0, excl_kern = 0, id = { 3768, 3769,
3770, 3771 }
# event : name = major-faults, type = 1, config = 0x6, config1 = 0x0,
config2 = 0x0, excl_usr = 0, excl_kern = 0, id = { 3772, 3773, 3774,
3775 }
# HEADER_CPU_TOPOLOGY info available, use -I to display
# HEADER_NUMA_TOPOLOGY info available, use -I to display
# ========
#
# Events: 1K context-switches
#
# Overhead  Command      Shared Object      Symbol
# ........  .......  .................  ..........
#
   100.00%     java  [kernel.kallsyms]  [k] __schedule


# Events: 0  major-faults
#
# Overhead  Command  Shared Object  Symbol
# ........  .......  .............  ......
#


#
# (For a higher level overview, try: perf report --sort comm,dso)
#
#  PID   TID  major-faults  major-faults  context-switches
context-switches  context-switches  context-switches  major-faults
major-faults
  7092  7108           218           218                   431
                  445                        206
   212                     61                   30
  7092  7107           175           310                   58
                   70                          95
       501                     283                366
  7092  7106            66            26                     343
                    154                        244
      394                     283                194
  7092  7105            16             0                       4
                        8                            16
              36                      16                   22
  7092  7100             3              4                       26
                        27                          7
              52                       2                    15
  7092  7098             5              1                       3
                         32                          68
              129                     22                  25
  7092  7102           107            204                  441
                 617                        101
    426                      9                    7
  7092  7099             0              3                       4
                        18                           0
               13                        2                    3
  7092  7104             0              0                       0
                        0                             3
                  0                         0                    0
  7092  7095             0              0                      5
                        25                           12
               12                       26                   7
  7092  7097             2             10                     34
                     14                            22
             9                         0                    0
  7092  7096             1              7                      26
                       16                           25
             13                       0                    2
  7092  7103           216            11                   1
                     236                        368
       339                     302                281
  7092  7093            24             38                   40
                    16                            0
            0                         0                    0
  7092  7094             4              7                     4
                         11                          22
               17                      22                     3
  7092  7101             0              0                     0
                          0                             0
                   6                        0                       0


My Question is why each thread has more than 2 events counted in the
table?? For each thread, there are 4 major-faults and 4
context-switches, but they have different number for each thread??

Thanks very much for your advice.
Best wishes.
Yours,
Wang Peipei
