From: Mahmood Naderan <mahmood.nt@gmail.com>
Subject: Using perf on AMD 15h
Date: Sat, 6 Jun 2015 10:37:17 +0430
Message-ID: <CADa2P2V7hrecCM2C_H5ZB5V4xVq1UqcR4wKvt9HL9sAjQ8CEwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Guys,
My first question is, does the version of kernel affects the perf
functionality? I mean fixing bugs and ...
Currently, the kernel version is 2.6.39 and here is the problem:

According tot he BKDG of AMD 15h, it is possbile to disable the
hardware prefetcher by setting some bits of MSRC001_1022

MSRC001_1022 Data Cache Configuration (DC_CFG)
Bits       -->     Description
63:16   -->  Reserved.
15  -->    DisPfHwForSw. Read-write. Reset: 0. 1=Disable hardware
prefetches for software prefetches.
14   -->   Reserved.
13   -->   DisHwPf. Read-write. Reset: 0. 1=Disable the DC hardware
prefetcher. BIOS: See 2.3.3 [Using L2 Cache as General Storage During
Boot].
12:10   -->  Reserved.
9:5   -->  Reserved.
4   -->  DisSpecTlbRld. Read-write. Reset: 0. 1=Disable speculative
TLB reloads. BIOS: See 2.3.3 [UsingL2 Cache as General Storage During
Boot].
3:0   -->  Reserved.



So in order to disable all prefetch configs, I have to write 0xA008 to
that MSR. I did that for all cores using

[root@tiger exe]# wrmsr -a 0xc0011022 0xA008
[root@tiger exe]# rdmsr -a -x -0 0xc0011022
000000000000a008
...


However, when I run perf along with the command, the prefetch ststs
are non-zero!


[root@tiger exe]# perf stat -e
L1-dcache-loads:uk,L1-dcache-prefetches:uk,L1-dcache-prefetch-misses:uk
./bzip2_base.amd64-m64-gcc44-nn
spec_init
Tested 64MB buffer: OK!
 Performance counter stats for './bzip2_base.amd64-m64-gcc44-nn':
    55,341,597,193 L1-dcache-loads:uk
     1,047,662,614 L1-dcache-prefetches:uk
                 0 L1-dcache-prefetch-misses:uk
      35.921618464 seconds time elapsed




I expect to see 0 in front of  L1-dcache-prefetches. Don't you?
I have stuck at this problem. I appreciate any feedback and comment.


Regards,
Mahmood
