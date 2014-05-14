From: xiakaixu <xiakaixu@huawei.com>
Subject: Re: Does perf support different length of user-space hw_breakpoint?
Date: Wed, 14 May 2014 10:55:09 +0800
Message-ID: <5372DB0D.5070206@huawei.com>
References: <53707DD6.2000108@huawei.com> <20140513120046.GB1138@krava.brq.redhat.com> <20140513150613.GC13828@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140513150613.GC13828@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, paulus@samba.org, Ingo Molnar <mingo@kernel.org>, a.p.zijlstra@chello.nl, Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>, Namhyung Kim <namhyung@kernel.org>, Huxinwei <huxinwei@huawei.com>, peifeiyue@huawei.com
List-Id: linux-perf-users.vger.kernel.org

=E4=BA=8E 2014/5/13 23:06, Frederic Weisbecker =E5=86=99=E9=81=93:
> On Tue, May 13, 2014 at 02:00:46PM +0200, Jiri Olsa wrote:
>> On Mon, May 12, 2014 at 03:52:54PM +0800, xiakaixu wrote:
>>> Hi guys,
>>>
>>> Does perf support different length of user-space hw_breakpoint,
>>> such as  HW_BREAKPOINT_LEN_1/HW_BREAKPOINT_LEN_2/HW_BREAKPOINT_LEN_=
4/
>>> HW_BREAKPOINT_LEN_8?
>>>
>>> Seems perf only support HW_BREAKPOINT_LEN_4/sizeof(long)
>>> by default from the source code and simple test.
>>
>> right..
>>
>>         /*
>>          * We should find a nice way to override the access length
>>          * Provide some defaults for now
>>          */
>>         if (attr.bp_type =3D=3D HW_BREAKPOINT_X)
>>                 attr.bp_len =3D sizeof(long);
>>         else
>>                 attr.bp_len =3D HW_BREAKPOINT_LEN_4;
>>
>>>
>>> May I have your opinions if I want to trace different bytes of
>>> hw_breakpoint addr?
>>
>> I guess that depends on what you want to do ;-)
>=20
> Ah, I have a patchset from Jacob Shin and Suravee Suthikulpanit that =
does
> that. Also it has been hanging around for too long by my fault. I'm p=
osting
> it now.

Thanks for your reply!
Hopefully I can get it ASAP.
> .
>=20
