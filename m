From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [Patch 1/4] perf report: Add function for verbose dump of raw
 data
Date: Mon, 14 Jan 2019 13:13:30 +0100
Message-ID: <9938997a-c00b-8331-cbd9-e0c778d83b92@linux.ibm.com>
References: <20190111115259.99438-1-tmricht@linux.ibm.com>
 <20190111140059.GV22483@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111140059.GV22483@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 01/11/2019 03:00 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 11, 2019 at 12:52:56PM +0100, Thomas Richter escreveu:
>> Add support to call an architecture dependend function to interpret
>> raw data verbatim when dumping the perf.data file with
>> option -D.
> 
> Please add "per-arch" to the summary, so that just by looking at my
> inbox main page I can see what this is about.
> 

Will do.

> Also how this will deal with processing a perf.data file generated on a
> S/390 machine in another arch? I.e.
> 
> on s/390:
> 
> perf record -a sleep 10
> 
> on a x86_64:
> 
> scp that file
> perf report -i perf.data.from.s390
> 
> ?
> 

This is then the raw data in byte format, as in 
   [root@f29 perf]# ./perf report -D \
                 -i ~/perf-s390-ctrset/perf.data.s390.ctrset
....
0x750 [0x6e8]: event: 9
.
. ... raw event: size 1768 bytes
.  0000:  09 00 00 00 01 00 e8 06 1d 00 00 00 00 00 00 00  ................
.  0010:  00 00 00 00 00 00 00 00 34 82 00 00 34 82 00 00  ........4...4...
.  0020:  04 a3 d3 1e c4 01 00 00 00 00 00 00 00 00 00 00  ................
.  0030:  a0 0f 00 00 00 00 00 00 00 00 06 ac fe ef 00 00  ................
.  0040:  00 06 00 00 00 00 00 00 01 6c c8 ad 00 00 00 00  .........l......
.  0050:  00 d2 cf a5 00 00 00 00 00 00 39 93 00 00 00 00  ..........9.....
.  0060:  00 04 0c df 00 00 00 00 00 00 2c 97 00 00 00 00  ..........,.....
.  0070:  00 08 82 01 fe ef 00 01 00 02 00 00 00 00 00 00  ................
.  06b0:  00 00 14 58 d5 80 20 9a 29 34 a5 53 d5 80 20 9a  ...X.. .)4.S.. .
.  06c0:  28 15 83 53 00 00 00 00 00 00 00 00 00 00 00 00  (..S............
.  06d0:  00 00 00 00 d5 80 19 5e 46 96 8a 74 39 06 00 00  .......^F..t9...
.  06e0:  00 00 00 00 00 00 00 00                          ........        

0 1941842404100 0x750 [0x6e8]: PERF_RECORD_SAMPLE(IP, 0x1): 33332/33332: 0 peri>
 ... thread: facultaet:33332
 ...... dso: <not found>



> report code should lookup a function for the architecture the perf.data
> was recorded on, using the perf.data file header, etc.
> 
>         const char *arch_name = perf_env__arch(session->header->env);
> 
> Then lookup a table to find the right function, ok? See arch__find() for
> an example used in the annotation code.
> 
> - Arnaldo
>  

I can make this platform independent and call a function to display
the event raw data collected on a s/390 and any other platform.
I will start with s390 and x86.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
