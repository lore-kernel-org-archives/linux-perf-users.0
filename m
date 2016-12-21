From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: Inlined functions in perf report
Date: Thu, 22 Dec 2016 06:56:28 +0800
Message-ID: <499d963f-9049-0b6c-00c3-0f155433ae26@linux.intel.com>
References: <20161220115954.GA35897@sesse.net>
 <df263fe1-e1af-881b-311e-5329bb51db0e@linux.intel.com>
 <20161221095823.GA19249@sesse.net> <8193556.VWj3dM7HSI@milian-kdab2>
 <20161221102035.GA31703@sesse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161221102035.GA31703@sesse.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>, Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Could you see the inline if you use the addr2line command? For example, 
addr2line -e <app> -i <addr>

For example, in my case,

root@skl:/home/jinyao/skl-ws/perf-dev/lck-2867/test# addr2line -e 
./test2 -i 40052d
/usr/include/x86_64-linux-gnu/bits/stdio2.h:104
/home/jinyao/skl-ws/perf-dev/lck-2867/test/test2.c:27
/home/jinyao/skl-ws/perf-dev/lck-2867/test/test2.c:35
/home/jinyao/skl-ws/perf-dev/lck-2867/test/test2.c:45
/home/jinyao/skl-ws/perf-dev/lck-2867/test/test2.c:61

00000000004004f0 <main>:

      ......

      40052d:       e8 6e ff ff ff          callq  4004a0 <puts@plt>

Thanks

Jin Yao


On 12/21/2016 6:20 PM, Steinar H. Gunderson wrote:
> On Wed, Dec 21, 2016 at 11:09:42AM +0100, Milian Wolff wrote:
>> Just to check - did you really compile your code with frame pointers? By
>> default, that is not the case, and the above will try to do frame pointer
>> unwinding which will then fail. Put differently - do you any stack frames at
>> all? Can you try `perf record --call-graph dwarf` instead? Of course, make
>> sure you compile your code with `-g -O2` or similar.
> I don't specifically use -fno-omit-frame-pointer, no. But the normal stack
> unwinding works just fine with mainline perf nevertheless; is this expected?
>
> /* Steinar */
