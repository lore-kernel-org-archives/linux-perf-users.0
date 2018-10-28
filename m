From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 11/11] perf tools: Stop fallbacking to kallsyms for vdso
 symbols lookup
Date: Sun, 28 Oct 2018 22:10:08 +0100
Message-ID: <20181028211008.GA3145@krava>
References: <20181017225501.32150-1-acme@kernel.org>
 <20181017225501.32150-12-acme@kernel.org>
 <4c682937-3cee-6974-0970-68610e13ad37@intel.com>
 <87a7n070tj.fsf@intel.com>
 <20181027110541.GA25072@krava>
 <87bm7fgnhz.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87bm7fgnhz.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On Sat, Oct 27, 2018 at 01:09:44PM -0700, Vinicius Costa Gomes wrote:
> Hi Jirka,
> 
> Jiri Olsa <jolsa@redhat.com> writes:
> 
> > On Fri, Oct 26, 2018 at 04:19:52PM -0700, Vinicius Costa Gomes wrote:
> >> Hi,
> >> 
> >> Adrian Hunter <adrian.hunter@intel.com> writes:
> >> 
> >> > On 18/10/18 1:55 AM, Arnaldo Carvalho de Melo wrote:
> >> >> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> >> 
> >> >> David reports that:
> >> >> 
> >> >> <quote>
> >> >> Perf has this hack where it uses the kernel symbol map as a backup when
> >> >> a symbol can't be found in the user's symbol table(s).
> >> >
> >> > I don't think this is a complete fix because it exposes new problems.
> >> 
> >> This commit broke function name resolution for 'perf record -g' for me.
> >> 
> >> What I mean is, with this commit applied:
> >> 
> >> $ ./tools/perf/perf record -g -- sleep 1
> >> 
> >> $ ./tools/perf/perf report
> >> 
> >> 'perf report' doesn't seem to be able to show the function names of the
> >> trace.
> >> 
> >> If I revert this commit, function names are resolved fine.
> >
> > that commit just showed up some places where we have the
> > ip resolve wrong.. would attached patch fix it for you?
> 
> Thank you for your patch.
> 
> I can some difference in the output, but I wouldn't say that it's fixed.
> 
> Here are some samples, if it's useful somehow:
> 
> https://gist.github.com/vcgomes/985626705e0968b973e426964f86a4b0
> 
> The "ping" tests were done running
> 
> $ sudo ./tools/perf/perf record -g -- ping -f -c 1000 127.0.0.1
> 
> And the "sleep" tests were done running
> 
> $ sudo ./tools/perf/perf record -g -- /bin/sleep 1

ugh, I tried with 'sudo ./perf record -g' and it looks
like it matter to callchains if there's a workload

Adrian said he's preparing complex patch for this
let's wait for his changes

thanks,
jirka
