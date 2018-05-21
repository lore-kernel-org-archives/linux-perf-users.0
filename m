From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a sample
Date: Mon, 21 May 2018 07:14:49 -0700
Message-ID: <71E4F816-7E0F-4984-B53C-06F8566EAB40@amacapital.net>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com> <20180509145436.GV12217@hirez.programming.kicks-ass.net> <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com> <20180510101406.GA12217@hirez.programming.kicks-ass.net> <0594eaea-0cab-ea04-c258-5f4770ffeee6@linux.intel.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0594eaea-0cab-ea04-c258-5f4770ffeee6@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


> On May 21, 2018, at 5:44 AM, Alexey Budankov <alexey.budankov@linux.intel.=
com> wrote:
>=20
> Hi Peter,
>=20
>> On 10.05.2018 13:14, Peter Zijlstra wrote:
>> On Thu, May 10, 2018 at 12:42:38PM +0300, Alexey Budankov wrote:
>>>> The Changelog needs to state that user_regs->bp is in fact valid and
>>>=20
>>> That actually was tested on binaries compiled without and with BP expose=
d=20
>>> and in the latter case proved the value of that change.
>>=20
>> Mostly works is not the same as 'always initialized', if there are entry
>> paths that do not store that register, then using the value might leak
>> values from the kernel stack, which would be bad.
>>=20
>> But like said, I think much of the kernel entry code was sanitized with
>> the PTI effort and I suspect things are in fact fine now, but lets wait
>> for Andy to confirm.
>=20
> It looks like, these days, all registers are saved on system calls, just=20=

> like you anticipated.
>=20
> So BP register value might be stored into the Perf trace on a sample.=20
>=20
> Andy?

Hmm, I thought I replied. Yes, they are indeed all saved, but I=E2=80=99m no=
t very excited about committing to doing so forever. But storing BP should b=
e fine.
