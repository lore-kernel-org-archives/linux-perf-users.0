From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf documentation: Add desription forHEADER_TRACING_DATA
Date: Thu, 12 Mar 2020 12:48:31 +0100
Message-ID: <747c8b92-a342-3e0c-4232-19df02250496@linux.ibm.com>
References: <20200303070846.18335-1-tmricht@linux.ibm.com>
 <20200311135815.GD19277@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200311135815.GD19277@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 3/11/20 2:58 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 03, 2020 at 08:08:46AM +0100, Thomas Richter escreveu:
>> Add description and layout in the perf.data file for
>> the header part describing trace data used in commands
>> perf record -e XXX
>> where XXX is a probe or tracepoint.
> 
> Did you write this from scratch?  I was going thru it and couldn't find
> what that "Note member 'ftrace_count' can be zero." refers to, couldn't
> find this ftrace_counter, is this outdated?
> 
> [root@five ~]# find /sys/kernel/debug/tracing/events/ -type f | xargs grep ftrace_count
> [root@five ~]# find /sys/kernel/debug/tracing/events/ -name ftrace_count
> [root@five ~]# uname -a
> Linux five 5.5.5-200.fc31.x86_64 #1 SMP Wed Feb 19 23:28:07 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@five ~]#
> 
> The part about using a probe and then go on dissecting it is really
> nice, I'll try reproducing it soon,
> 
> Thanks,
> 

Arnaldo,
        
yes, I wrote this from scratch. I decided to invest some time into the
documentation after I have spent nearly 3 week in debugging why commands

  perf record -e probe:vfs_getname

followed by

  perf report 
  
did not print the file name on s390. Remember we talked about failing
test case 65: Check open filename arg using perf trace + vfs_getname.
(Steven Rostedt and Masami Hiramatsu helped me on this).

On ftrace_count: This is not a file available in /sys/kernel/debug/tracing.
It is a value saved in function

tracing_data_get
  record_ftrace_files
     copy_event_system --> Check for some format file in directories
                           /sys/kernel/debug/tracing/events/ftrace/*/
Depending on what probe was defined, there is no hit and zero is written
to the output.

Hope this helps.
-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
