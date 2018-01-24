From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/1] perf stat: Add support to print counts for fixed
 times
Date: Wed, 24 Jan 2018 08:39:18 +0100
Message-ID: <20180124073918.GB8473@krava>
References: <1516192645-27187-1-git-send-email-ufo19890607@gmail.com>
 <1516192645-27187-2-git-send-email-ufo19890607@gmail.com>
 <20180123142449.GA21721@krava>
 <CAHCio2g-V-ojoi0igHSHNjj3ouzyhU+sO5WJSDHdZXGpUsZ7Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCio2g-V-ojoi0igHSHNjj3ouzyhU+sO5WJSDHdZXGpUsZ7Ew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Wind Yu <yuzhoujian@didichuxing.com>, Adrian Hunter <adrian.hunter@intel.com>, Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jan 24, 2018 at 10:03:08AM +0800, 禹舟键 wrote:
> Hi Jirka
> How can you control the output for perf stat, if the "--interval-print" is
> not 1000, eg. 2000, 3000, 5000.
> 
> root@node10:/home$ ./perf stat -e cycles -a -I 2000 sleep 3
> #           time             counts unit events
>      2.001361101        695,569,361      cycles
>      3.003249250         57,904,006      cycles
> root@node10:/home$ ./perf stat -e cycles -a -I 2000 --times-print 3
> #           time             counts unit events
>      2.002784924        128,438,406
> cycles
>      4.004290885         93,128,097
> cycles
>      6.005726281        111,303,359      cycles


[jolsa@krava perf]$ sudo ./perf stat -e cycles -a -I 2000 --times-print 3
#           time             counts unit events
     2.000161257      1,197,889,478      cycles                                                      
     4.000424645      2,905,635,530      cycles                                                      
     6.000589943      1,658,546,001      cycles                                                      
[jolsa@krava perf]$ sudo ./perf stat -e cycles -a -I 2000 sleep 6
#           time             counts unit events
     2.000248489      1,224,257,116      cycles                                                      
     4.000489261      3,171,435,328      cycles                                                      
     6.000766440      4,092,029,501      cycles                                                      
     6.916537222        563,745,072      cycles                                                      

jirka
