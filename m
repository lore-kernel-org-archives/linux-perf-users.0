From: Arnaldo Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
Date: Tue, 24 Mar 2020 18:24:09 -0300
Message-ID: <D53AD1F8-4B2B-4B30-BC72-59CCA7F0D268@gmail.com>
References: <20200224043749.69466-1-namhyung@kernel.org> <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com> <20200324163444.GA162390@mtj.duckdns.org> <20200324201522.GP2452@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200324201522.GP2452@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org



On March 24, 2020 5:15:22 PM GMT-03:00, Peter Zijlstra <peterz@infradead=
=2Eorg> wrote:
>On Tue, Mar 24, 2020 at 12:34:44PM -0400, Tejun Heo wrote:
>> On Mon, Mar 23, 2020 at 08:58:04AM +0900, Namhyung Kim wrote:
>> > Hello Peter, Tejun and folks=2E
>> >=20
>> > Do you have any other comments on the kernel side?
>> > If not, can I get your Ack?
>>=20
>> Everything looks good from cgroup side=2E I think I acked all cgroup
>parts already
>> but if not please feel free to add
>>=20
>>  Acked-by: Tejun Heo <tj@kernel=2Eorg>
>
>Yeah, looks good to me too=2E Since it's mostly userspace patches, will
>you route it Arnaldo?
>
>Acked-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>

Thanks for the acks, I'll process it tomorrow, so tests passing it'll go I=
ngo's way for 5=2E7 tomorrow=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
