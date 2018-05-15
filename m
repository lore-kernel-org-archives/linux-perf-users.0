From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a sample
Date: Tue, 15 May 2018 09:30:05 -0700
Message-ID: <F6BF3B97-F955-4644-A033-4D20CA7F1922@amacapital.net>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com> <20180509145436.GV12217@hirez.programming.kicks-ass.net> <eb83a97a-2e62-9c18-b738-a92b2f4dee23@linux.intel.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eb83a97a-2e62-9c18-b738-a92b2f4dee23@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


> On May 15, 2018, at 1:08 AM, Alexey Budankov <alexey.budankov@linux.intel.=
com> wrote:
>=20
>=20
> Hi Andy,
>=20
>> On 09.05.2018 17:54, Peter Zijlstra wrote:
>>> On Tue, May 08, 2018 at 06:21:36PM +0300, Alexey Budankov wrote:
>>>=20
>>> Store user space frame-pointer value (BP register) into Perf trace=20
>>> on a sample for a process so the value becomes available when=20
>>> unwinding call stacks for functions gaining event samples.
>>>=20
>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> ---
>>> arch/x86/kernel/perf_regs.c | 8 +++++++-
>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>>> index e47b2dbbdef3..8d68658eff7f 100644
>>> --- a/arch/x86/kernel/perf_regs.c
>>> +++ b/arch/x86/kernel/perf_regs.c
>>> @@ -156,7 +156,13 @@ void perf_get_regs_user(struct perf_regs *regs_user=
,
>>=20
>>=20
>>>     * Most system calls don't save these registers, don't report them.
>>=20
>> ^^^ that worries me and is the reason for the '-1's below. However I
>> think with all the PTI rework this might no longer be true.
>>=20
>> The Changelog needs to state that user_regs->bp is in fact valid and
>> ideally point to the commits that makes it so. Also this patch should
>> update that comment.
>>=20
>> Cc Andy who keeps better track of all that than me.
>=20
> Are there any thoughts so far? Feedback on the matter above is highly appr=
eciated.

Sorry, I missed this. Can you forward the original patch?  I don=E2=80=99t h=
ave it.
These days, system calls should save all registers, but I=E2=80=99m not enti=
rely sure I want to promise that they=E2=80=99ll continue to do so forever.
