From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: perf probe dwarf on shared libraries
Date: Fri, 12 Sep 2014 11:57:01 +0900
Message-ID: <541260FD.5040401@hitachi.com>
References: <CANq2XvGNtBO2zVoGTZJkfUofRbZ94-NJ5hZrSz5BT3En4dEHJA@mail.gmail.com> <20140911145119.GG10158@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailxx.hitachi.co.jp ([133.145.228.50]:34724 "EHLO
	mailxx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbaILDXi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 11 Sep 2014 23:23:38 -0400
In-Reply-To: <20140911145119.GG10158@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: david lerner <dlernerdroid@gmail.com>, linux-perf-users@vger.kernel.org

(2014/09/11 23:51), Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 04, 2014 at 03:11:31PM -0500, david lerner escreveu:
>> Has perf probe for userspace shared libraries been modified to use dwarf info?
>> The first commit to provide this useful functionality...
>>    fb7345bbf7fad9  perf probe: Support basic dwarf-based operations on
>> uprobe events,
>> shows examples only with the executable perf, but not with a shared library.
>  
>> With version 3.14 I'm able to set probes in application executable,
>> for example for the test application 'libunwind-test.out' I see the
>> usual args to main():
>>    root@qemu0:~# perf probe -x ./libunwind-test.out --vars main
>>    Available variables at main
>>         @<main+0>
>>                 char**  a
>>                 int     c
>> But I can't access the variables in a library that has embedded (not
>> split out) dwarf debug info...
>>    root@qemu0:~# perf probe -x /usr/lib64/libunwind.so --vars unw_backtrace
>>    Failed to find symbol at 0x33c38039cd
>>    Failed to find variables at unw_backtrace (-2)
>>    Error: Failed to show vars. (-2)
>> I've used gdb to confirm that perf found the correct function address
>> for unw_backtrace(), and that gdb knows the symbolic names of the
>> arguments.
>  
>> Is using dwarf debuginfo with shared libraries for perf uprobes on the
>> to-do list?
>> Or is this capability incomplete in version 3.14 and I need to pick up
>> other patches?
> 
> Have to check this, but perhaps Masami has this working already?

Hmm, I thought it should work. But no, it doesn't.
I've checked it and have found it doesn't work as below.

----
 $ ./perf probe -x /usr/lib64/libunwind.so -vvv -V access_reg
 probe-definition(0): access_reg
 symbol:access_reg file:(null) line:0 offset:0 return:0 lazy:(null)
 0 arguments
 Open Debuginfo file: /usr/lib/debug/usr/lib64/libunwind.so.8.0.1.debug
 Searching variables at access_reg
 Failed to find symbol at 0x2f40
 Failed to find the address of access_reg
   Error: Failed to show vars. Reason: No such file or directory (Code: -2)
----

I guess it might fail to verify the symbol address. Because
it is a shared library, dwarf information will be a bit
different. Anyway I'll try to fix that.

Thank you for reporting! :)


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
