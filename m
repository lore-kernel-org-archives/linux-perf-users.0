From: Hemendra Rawat <hkr1990@vt.edu>
Subject: Perf call-graph on arm aarch64 Linux
Date: Thu, 6 Nov 2014 06:43:32 +0000 (UTC)
Message-ID: <loom.20141106T071245-829@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53966 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbaKFGnv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Nov 2014 01:43:51 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1XmGnM-0005RP-PQ
	for linux-perf-users@vger.kernel.org; Thu, 06 Nov 2014 07:43:49 +0100
Received: from nc65214b0.cns.vt.edu ([198.82.20.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2014 07:43:48 +0100
Received: from hkr1990 by nc65214b0.cns.vt.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2014 07:43:48 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm trying to profile NAS benchmarks on a 64bit ARM machine running 
linux. I want to find number of cycles elapsed in each function of my 
multi-threaded application. For this, I'm trying to  generate call-graphs 
for my program for each thread using perf. I'm using perf as follows : 

perf record -g -s ./is.A 2                 (2 = Number of threads)
perf report -s pid --call-graph=graph

The problem I'm facing is that  when i call perf report, It prints 
"Failed to open /tmp/perf-565.map" and the generated call-graph 
has no symbol information 

Samples: 29K of event 'cycles'
# Event count (approx.): 17905152121
#
# Overhead                              Symbol
# ........  ..................................
#
    99.72%  [.] 0x0000000000005080            
            |          
            |--40.99%-- 0x402760
            |          |          
            |          |--87.05%-- 0x403fa4
            |          |          0x407e6c
            |          |          0x430c6c
            |          |          |          
            |          |          |--99.85%-- 0x0
            |          |           --0.15%-- [...]
            |          |          
            |           --12.95%-- 0x402df8
            |                     |          
            |                     |--90.98%-- 0x403050
            |                     |          0x40b7b8
            |                     |          0x40244c
            |                     |          0x7fd7c9dbc8
            |                     |          
            |                      --9.02%-- 0x403014
            |                                0x40b7b8
            |                                0x40244c
            |                                

Also, the generated call-graphs are not per thread. On an x86 machine, 
I get proper call-graphs with symbol information and "perf report -s pid" 
sorts the results thread wise. My version of perf on x86 is "3.16" on ARM 
it is "3.12"  

Linux dhcp-10-66-9-75 3.12.0-mustang_sw_1.13.28-beta  aarch64 GNU/Linux
[root@dhcp-10-66-9-75 tmp]# perf --version
perf version 3.12.0

Can someone please help me with how to proceed. It is something to do 
with the version of perf I have on my ARM machine ? I read somewhere 
on Internet that I need to have DWARF support for which I  need to compile 
perf using libunwind. Is it possible to compile and install a new version of 
perf (3.16) on my existing linux version (3.12.0). Any help would 
be highly appreciated.

Thanks
Hemendra
