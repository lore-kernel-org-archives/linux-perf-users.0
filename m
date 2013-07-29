From: Etem <etem_deniz@hotmail.com>
Subject: perf record + perf report
Date: Mon, 29 Jul 2013 08:52:20 +0000 (UTC)
Message-ID: <loom.20130729T104749-103@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37076 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab3G2IzH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 29 Jul 2013 04:55:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1V3jEN-0005M0-A6
	for linux-perf-users@vger.kernel.org; Mon, 29 Jul 2013 10:55:05 +0200
Received: from 193.140.74.2 ([193.140.74.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2013 10:55:03 +0200
Received: from etem_deniz by 193.140.74.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2013 10:55:03 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I am running Ubuntu 11.10 64bit on x86_64 machine with 4 core and 
hyperthreading enabled. I am using the following commands in order to get 
per-thread performance characteristics of a multi-threaded application. 
"perf record -s -e cycles,instructions,cache-references,cache-
misses,branches,branch-misses /PATH/TO/APPLICATION". "perf report -T --
stdio".

I get invalid results randomly. In the result, I get invalid (negative) 
process id or very big counter values. I am giving an example output:

# (For a higher level overview, try: perf report --sort comm,dso)
#
#  PID   TID   cycles           cycles  instructions  instructions         
instructions          instructions          instructions  instructions  
instructions  instructions  cache-references  cache-references      
cache-references     cache-references      cache-references  
cache-references  cache-references     cache-references  cache-misses  
cache-misses          cache-misses          cache-misses      cache-misses  
cache-misses  cache-misses      cache-misses  branches  branches              
branches              branches              branches  branches  
branches              branches  branch-misses  branch-misses         
branch-misses      branch-misses         branch-misses  branch-misses  
branch-misses  branch-misses    cycles    cycles                
cycles                cycles            cycles    cycles
  4487  4493        0                0             0             0  
  7494102348578251111   3488601301391995001                 41541         
  37571             0             0                 0                 0   
  7092150592960751218  7810209763779608678                  1611              
  2111                 0  7381246349212319846             0             0   
  7018136542324422001     28838465189274226                36            
  28             0                 0         0         0   
  8026367814273625705   7453295080785733747   7380943991784800358      
  7228         0                     0              0              0     
  28825271049347427  28825292623798627     28825270915195235            
  434              0              0         0         0   
  8462108034846451316                 85567             94053     98435
...

You can see invalid values such as 8026367814273625705. How can I fix this 
problem and get correct per-thread performance counters?

Thanks.
