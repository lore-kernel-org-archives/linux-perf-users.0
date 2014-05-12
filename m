From: xiakaixu <xiakaixu@huawei.com>
Subject: Re: Does perf support different length of user-space hw_breakpoint?
Date: Mon, 12 May 2014 17:00:30 +0800
Message-ID: <53708DAE.6080903@huawei.com>
References: <53707DD6.2000108@huawei.com> <20140512080503.GL30445@twins.programming.kicks-ass.net> <CAGjdHukwC3cu3YOSSteXsC4_52m-YTdAAYCfXV+q5A2pnW+CKQ@mail.gmail.com> <20140512084823.GO30445@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:19899 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaELJAy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 12 May 2014 05:00:54 -0400
In-Reply-To: <20140512084823.GO30445@twins.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kaixu xia <xiakaixu1987@gmail.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, paulus@samba.org, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Borislav Petkov <bp@alien8.de>, Namhyung Kim <namhyung@kernel.org>, Huxinwei <huxinwei@huawei.com>, peifeiyue@huawei.com, fweisbec@gmail.com

=E4=BA=8E 2014/5/12 16:48, Peter Zijlstra =E5=86=99=E9=81=93:
> On Mon, May 12, 2014 at 04:20:44PM +0800, kaixu xia wrote:
>> 2014-05-12 16:05 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
>>
>>> On Mon, May 12, 2014 at 03:52:54PM +0800, xiakaixu wrote:
>>>> Hi guys,
>>>>
>>>> Does perf support different length of user-space hw_breakpoint,
>>>> such as  HW_BREAKPOINT_LEN_1/HW_BREAKPOINT_LEN_2/HW_BREAKPOINT_LEN=
_4/
>>>> HW_BREAKPOINT_LEN_8?
>>>>
>>>> Seems perf only support HW_BREAKPOINT_LEN_4/sizeof(long)
>>>> by default from the source code and simple test.
>>>>
>>>> May I have your opinions if I want to trace different bytes of
>>>> hw_breakpoint addr?
>>>
>>> Frederic?
>>>
>>
>> Sorry, can not fully understand it. Can you give more details on tha=
t?
>=20
> I asked Frederic to answer your question :-)
>=20
Thanks:-)
