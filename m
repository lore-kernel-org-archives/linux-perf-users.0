From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v4 12/12] perf test: improve pmu event metric testing
Date: Sun, 3 May 2020 10:31:37 -0700
Message-ID: <CAP-5=fVaLWVyxweesWYCj1=FFubM3t6OsF1Jd46d=FtsQUQVmQ@mail.gmail.com>
References: <20200501173333.227162-1-irogers@google.com> <20200501173333.227162-13-irogers@google.com>
 <20200503145553.GA1865281@krava> <CAP-5=fXrwcz+MMF0Dqd_UnoXoTo1iO7T3-ENX0fzytPmJWmtoA@mail.gmail.com>
 <20200503170608.GA1915271@krava>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000000a441305a4c1ca85"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200503170608.GA1915271@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kajoljain <kjain@linux.ibm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane
List-Id: linux-perf-users.vger.kernel.org

--0000000000000a441305a4c1ca85
Content-Type: text/plain; charset="UTF-8"

On Sun, May 3, 2020 at 10:06 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sun, May 03, 2020 at 08:26:22AM -0700, Ian Rogers wrote:
> > On Sun, May 3, 2020 at 7:56 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, May 01, 2020 at 10:33:33AM -0700, Ian Rogers wrote:
> > > > Add a basic floating point number test to expr.
> > > > Break pmu-events test into 2 and add a test to verify that all pmu metric
> > > > expressions simply parse. Try to parse all metric ids/events, failing if
> > > > metrics for the current architecture fail to parse.
> > > >
> > > > Tested on skylakex with the patch set in place. May fail on other
> > > > architectures if metrics are invalid.
> > >
> > > yep, failing for me (-vvv output below).. could you plz
> > > detect that and skip the test ?
> >
> > Thanks, filtering the verbose output we have just 1 parse event failure:
> >
> > Parse event failed: id 'arb/event=0x80,umask=0x2,thresh=1/' metric
> > 'DRAM_Parallel_Reads' expr 'arb@event\=0x80\,umask\=0x2@ /
> > arb@event\=0x80\,umask\=0x2\,thresh\=1@'
> > Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help 'valid
> > terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'
> >
> > This looks like a bug in skl-metrics.json:
> >
> >    {
> >         "BriefDescription": "Average number of parallel data read
> > requests to external memory. Accounts for demand loads and L1/L2
> > prefetches",
> >         "MetricExpr": "arb@event\\=0x80\\,umask\\=0x2@ /
> > arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@",
> >         "MetricGroup": "Memory_BW",
> >         "MetricName": "DRAM_Parallel_Reads"
> >     },
> >
> > which can be fixed by removing "\\,thresh\\=1" but looking at the
> > expression this will just make the expression yield a value of 1. As
> > this is an Intel json file could they comment? Jiri, could you be
> > missing a patch on the kernel side? We could lower this failure to
> > just a diagnostic message to land this set of patches, let me know
> > what you'd like me to do.
>
> I applied this on current Arnaldo's perf/core.. not sure there's
> more pending changes out there
>
> I'd like not to delay this patchset too long.. could we push the
> first 10 patches and solve the rest in separate change?

Thanks, I've attached a patch that can be squashed into 12 to make the
error non-fatal. Patch 11 is trying to make the diagnostics around
adding a PMU event clearer and aside warning messages, and removal of,
has no functional effect. I don't mind the first 10 being merged and
these coming later. I don't mind just patch 11 coming later as it'd be
nice to have the test so metrics can get fixed.

Thanks,
Ian

> thanks,
> jirka
>

--0000000000000a441305a4c1ca85
Content-Type: text/x-patch; charset="US-ASCII"; name="jiri.patch"
Content-Disposition: attachment; filename="jiri.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k9rbtbov0>
X-Attachment-Id: f_k9rbtbov0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvcG11LWV2ZW50cy5jIGIvdG9vbHMvcGVyZi90
ZXN0cy9wbXUtZXZlbnRzLmMKaW5kZXggNWFiMTgwOWI3NDFiLi5jMThiOWNlOGNhY2UgMTAwNjQ0
Ci0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMvcG11LWV2ZW50cy5jCisrKyBiL3Rvb2xzL3BlcmYvdGVz
dHMvcG11LWV2ZW50cy5jCkBAIC00MDQsMTIgKzQwNCwxMyBAQCBzdGF0aWMgaW50IGNoZWNrX3Bh
cnNlX2lkKGNvbnN0IGNoYXIgKmlkLCBib29sIHNhbWVfY3B1LCBzdHJ1Y3QgcG11X2V2ZW50ICpw
ZSkKIAltZW1zZXQoJmVycm9yLCAwLCBzaXplb2YoZXJyb3IpKTsKIAlyZXQgPSBwYXJzZV9ldmVu
dHMoZXZsaXN0LCBpZCwgJmVycm9yKTsKIAlpZiAocmV0ICYmIHNhbWVfY3B1KSB7Ci0JCXByX2Rl
YnVnKCJQYXJzZSBldmVudCBmYWlsZWQ6IGlkICclcycgbWV0cmljICclcycgZXhwciAnJXMnXG4i
LAotCQkJaWQsIHBlLT5tZXRyaWNfbmFtZSwgcGUtPm1ldHJpY19leHByKTsKLQkJcHJfZGVidWco
IkVycm9yIHN0cmluZyAnJXMnIGhlbHAgJyVzJ1xuIiwKKwkJZnByaW50ZihzdGRlcnIsCisJCQki
XG5XQVJOSU5HOiBQYXJzZSBldmVudCBmYWlsZWQgbWV0cmljICclcycgaWQgJyVzJyBleHByICcl
cydcbiIsCisJCQlwZS0+bWV0cmljX25hbWUsIGlkLCBwZS0+bWV0cmljX2V4cHIpOworCQlmcHJp
bnRmKHN0ZGVyciwgIkVycm9yIHN0cmluZyAnJXMnIGhlbHAgJyVzJ1xuIiwKIAkJCWVycm9yLnN0
ciwgZXJyb3IuaGVscCk7CiAJfSBlbHNlIGlmIChyZXQpIHsKLQkJcHJfZGVidWcoIlBhcnNlIGV2
ZW50IGZhaWxlZCwgYnV0IGZvciBhbiBldmVudCB0aGF0IG1heSBub3QgYmUgc3VwcG9ydGVkIGJ5
IHRoaXMgQ1BVLlxuaWQgJyVzJyBtZXRyaWMgJyVzJyBleHByICclcydcbiIsCisJCXByX2RlYnVn
MygiUGFyc2UgZXZlbnQgZmFpbGVkLCBidXQgZm9yIGFuIGV2ZW50IHRoYXQgbWF5IG5vdCBiZSBz
dXBwb3J0ZWQgYnkgdGhpcyBDUFUuXG5pZCAnJXMnIG1ldHJpYyAnJXMnIGV4cHIgJyVzJ1xuIiwK
IAkJCWlkLCBwZS0+bWV0cmljX25hbWUsIHBlLT5tZXRyaWNfZXhwcik7CiAJfQogCWV2bGlzdF9f
ZGVsZXRlKGV2bGlzdCk7CkBAIC00MTcsNyArNDE4LDggQEAgc3RhdGljIGludCBjaGVja19wYXJz
ZV9pZChjb25zdCBjaGFyICppZCwgYm9vbCBzYW1lX2NwdSwgc3RydWN0IHBtdV9ldmVudCAqcGUp
CiAJZnJlZShlcnJvci5oZWxwKTsKIAlmcmVlKGVycm9yLmZpcnN0X3N0cik7CiAJZnJlZShlcnJv
ci5maXJzdF9oZWxwKTsKLQlyZXR1cm4gc2FtZV9jcHUgPyByZXQgOiAwOworCS8qIFRPRE86IHRv
byBtYW55IG1ldHJpY3MgYXJlIGJyb2tlbiB0byBmYWlsIG9uIHRoaXMgdGVzdCBjdXJyZW50bHku
ICovCisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgdGVzdF9wYXJzaW5nKHZvaWQpCg==
--0000000000000a441305a4c1ca85--
