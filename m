From: "Maucci, Cyrille" <cyrille.maucci@hp.com>
Subject: RE: Profiling a program's runtime
Date: Fri, 4 Feb 2011 18:33:36 +0000
Message-ID: <0E02F16954AF394BB163AEE50FDF548568FE033612@GVW1121EXC.americas.hpqcorp.net>
References: <ukft18-pba.ln1@burns.bruehl.pontohonk.de>
 <20110204171604.GB1808@nowhere> <6cqt18-1lh.ln1@burns.bruehl.pontohonk.de>
 <20110204174750.GD1808@nowhere> <4D4C4105.3050002@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:13562 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1BDSdk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 13:33:40 -0500
In-Reply-To: <4D4C4105.3050002@cisco.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>, Frederic Weisbecker <fweisbec@gmail.com>, Christoph Bartoschek <bartoschek@gmx.de>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

I'd think that what he's looking for is a bit what caliper cstack would provide.


So something like showing 'running' (consuming CPU) and 'blocked' (I/O, passive wait, etc...)...


Function Summary 
-------------------------------------------------------------------------------------------------------
% Total  Cumulat                          Sample         Sample                                    
   IP      % of              IP            Hits           Hits                                     
Samples    Total          Samples        Running        Blocked  Function                          File
-------------------------------------------------------------------------------------------------------
  42.11    42.11             1456           1456              0  libc.so.1::__lseek_sys            
  38.09    80.19             1317            592            725  libc.so.1::_read_sys              
   9.43    89.62              326            326              0  libc.so.1::memset                 
   1.59    91.21               55             55              0  libc.so.1::_write_sys             
Etc...

On the flat summary side


And something presented like this in the call graph part


Call Graph
--------------------------------------------------------------------
       --% Total Hits In / Under--    % Func Hits    
       Run +     Run       Block        Under Parent     Parents
Index  Block     Hits      Hits       In Func        Name     Index
       Hits      Only      Only         In Children      Children
--------------------------------------------------------------------
[1]    100.0      78.0      22.0        0.00         *ROOT* [1]
                                           79.47         dld.so::main_opd_entry [5]
                                           20.04         *unknown_0x600000000e0a7608* [52]
                                            0.20         DDENV::main [4]
                                            0.09         DDENV::Bffo_BILLproc [25]
                                            0.06         DDENV::bffe_Root [46]
                                            0.03         *unknown_0x6000000008f9c6e8* [364]
                                            0.03         DDENV::bfen_EXECproc [2]
                                            0.03         DDENV::F1_RootObject [63]
                                            0.03         *unknown_0x134* [451]
                                            0.03         *unknown_0xc0000000000087a0* [456]
--------------------------------------------------------------------
                                           99.97         DDENV::main [4]
                                            0.03         *ROOT* [1]
[2]     99.8      77.8      22.0        0.00         DDENV::bfen_EXECproc [2]
                                          100.00         DDENV::bfen_INPUTproc [3]

Etc...




Sorry, I'm new to this list and have never used perf before but am planning to do so verysoon.
Did anyone answer his initial question "I would like to get a callgraph for the whole time a program runs. Is this possible with perf?"?


Thanks
++Cyrille


-----Original Message-----
From: linux-perf-users-owner@vger.kernel.org [mailto:linux-perf-users-owner@vger.kernel.org] On Behalf Of David Ahern
Sent: Friday, February 04, 2011 7:10 PM
To: Frederic Weisbecker; Christoph Bartoschek
Cc: linux-perf-users@vger.kernel.org; Arnaldo Carvalho de Melo
Subject: Re: Profiling a program's runtime



On 02/04/11 10:47, Frederic Weisbecker wrote:

>> I want that not only the CPU time is counted that my task uses, but 
>> also the time my task waits.
> 
> The time your task waits, other tasks executes :-/  (including idle in 
> the scheme)
>  
>> For example, if my task waits for network packets in a read() then 
>> the time should be added to the read() function. Other profilers I 
>> know would not count the time when the process is blocked.

You can determine time blocked on read (and other system calls) by acquiring all context switches:

    perf record -e cs -c 1 -a

From there you'll want to generate a time history output. To use unmodified perf code use the -D option to dump raw samples (perf report -D). You can find the process of interest and the kernel timestamp between schedule out events -- and the sched out event before your process. Together you can piece together the time you blocked on read.

Alternatively, there are add-on patches which dump the timehistory in a pretty print format:

http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00049.html
http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00047.html
http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00048.html


That output can be manipulated much easier to determine time on the processor and time between schedule-in events.

Not the complete picture of what I think you are looking for -- but a way to get the time blocked on syscall stats via perf.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
