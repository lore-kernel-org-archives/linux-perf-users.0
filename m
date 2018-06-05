From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf tools: Fix object code reading for PTI entry
 trampolines
Date: Tue, 5 Jun 2018 17:08:35 +0300
Message-ID: <00606a96-4e6b-6c98-c560-db722f4cd865@intel.com>
References: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
 <20180605134142.GE4899@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605134142.GE4899@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 05/06/18 16:41, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 05, 2018 at 10:30:00AM +0300, Adrian Hunter escreveu:
>> Fix object code reading and the "Object code reading" test for PTI entry
>> trampolines.
>>
>> perf tools uses map__rip_2objdump() to calculate objdump virtual addresses.
>> map__rip_2objdump() needs to be amended to deal with PTI entry trampolines.
>> Also the "Object code reading" test will not create maps for the PTI entry
>> trampolines unless the machine environment exists to show that the arch is
>> x86_64.
> 
> So, I split it into two patches, right at the "Also" part in your
> description:
> 
> [acme@seventh perf]$ git log --oneline -2
> 36800a71b000 (HEAD -> perf/core) perf map: Consider PTI entry trampolines in rip_2objdump()
> 2f6777b74f6d perf test code-reading: Fix perf_env setup for PTI entry trampolines
> [acme@seventh perf]$
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core
> 
> And this test fails way less often, but still does, for instance:
> 
> # while true ; do perf test -v object 2>out.txt ; grep -i fail out.txt && break ; done
> dso__data_read_offset failed
> Object code reading: FAILED!
> #
> [root@seventh ~]# tail out.txt 
> File is: /proc/kcore
> On file address is: 0x7fff892300df
> kcore map tested already - skipping
> Reading object code for memory address: 0x4a020f
> File is: /home/acme/bin/perf (deleted)
> On file address is: 0xa020f
> dso__data_read_offset failed
> test child finished with -1
> ---- end ----
> Object code reading: FAILED!
> [root@seventh ~]#
> 
> I start that loop and then try running 'make -C tools/perf O=/tmp/build/perf install-bin',
> to generate some load.

So is it related to the "deleted" in "File is: /home/acme/bin/perf (deleted)"?

> 
> But now at least on a quiet system it works.
> 
> - Arnaldo
> 
