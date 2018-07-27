From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: BPF relocation 'perf test' entries failing was: Re: [GIT PULL
 00/27] perf/core improvements and fixes
Date: Fri, 27 Jul 2018 08:27:27 +0200
Message-ID: <8b7e30c5-338c-7e9b-536f-9418792936d7@linux.ibm.com>
References: <20180726131534.GD17940@kernel.org>
 <2fbfac01-e103-8daf-6187-b94d1725dbd0@linux.ibm.com>
 <20180726185805.GA20438@kernel.org> <20180726191435.GB20438@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726191435.GB20438@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Sandipan Das <sandipan@linux.ibm.com>
Cc: Alexei Starovoitov <ast@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Ingo Molnar <mingo@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Clark Williams <williams@redhat.com>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 07/26/2018 09:14 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 26, 2018 at 03:58:05PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Jul 26, 2018 at 11:04:08PM +0530, Sandipan Das escreveu:
>>> I came across the same problem. Does the following patch fix it?
> 
>>> https://lkml.org/lkml/2018/7/26/669
>  
>> Oh my, that one was subtle... Checking...
> 
> Right, when it said it was running:
> 
>   40.3: BPF prologue generation
> 
> In fact it was running:
> 
>   40.4: BPF relocation checker
> 
> That error message in the 'perf test -v' output:
> 
>   libbpf: Program 'func=sys_write' contains non-map related relo data pointing to section 65522
> 
> Was the _expected_ one for "40.4: BPF relocation checker", then it
> failed when it couldn't run the off by one "last" subtest, duh.
> 
> Thomas, this was a problem introduced by a patch from you, just for
> reference, this one:
> 
>     Fixes: 9ef0112442bd ("perf test: Fix subtest number when showing results")
> 
> I should have caught this by running 'perf test' before/after applying
> that patch, I'll now make sure this is done before sending pull reqs
> upstream.
> 
> In fact I did after, and thought, hey, some BPF related regression, I
> must've updated clang/llvm and something new appeared on the radar, so I
> went that direction and went nowhere, well, now I have an uptodate
> llvm/clang combo to play with BTF, pahole, etc 8-)
> 
> Thanks!
> 
> - Arnaldo



Sandipan,
thanks for fixing what I have messed up.

Arnaldo,
sorry for the hickup, I should have caught this too. In fact I ran
perf test before and after, but redirected the output and just 
looked at the grep'ed lines on the screen....
I should be looked more carefully...

Apologies for the mess and thanks again for fixing this.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
