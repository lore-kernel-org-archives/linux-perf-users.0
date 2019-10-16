From: James Clark <James.Clark@arm.com>
Subject: Re: [RFC PATCH 2/3] perf tools: Add support for "report" for some spe
 events
Date: Wed, 16 Oct 2019 10:12:43 +0000
Message-ID: <58bed363-41ee-e425-a36e-e3c69d1a4e90@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
 <0ac06995-273c-034d-52a3-921ea0337be2@arm.com>
 <016c1ce8-7220-75a2-43fa-0efe150f897c@huawei.com>
 <805660ca-1cf3-4c7f-3aa2-61fed59afa8b@arm.com>
 <637836d6-c884-1a55-7730-eeb45b590d39@huawei.com>
 <b7e5ca2d-8c6c-8ab8-637e-a9aaebaf62a5@arm.com>
 <2b1fc8c7-c0b9-f4b9-a24f-444bc22129af@huawei.com>
 <335fedb8-128c-7d34-c5e8-15cd660fe12e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <335fedb8-128c-7d34-c5e8-15cd660fe12e@huawei.com>
Content-Language: en-US
Content-ID: <6D50A32F91C7D94A9752A1E7B029CD57@eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tan Xiaojun <tanxiaojun@huawei.com>, Jeremy Linton <Jeremy.Linton@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>, "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>, "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>, "songliubraving@fb.com" <songliubraving@fb.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Kim Phillips <Kim.Phillips@amd.com>
Cc: "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>, "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>, "liwei391@huawei.com" <liwei391@huawei.com>, "huawei.libin@huawei.com" <huawei.libin@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Al Grant <Al.Grant@arm.com>, nd <nd@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Xiaojun,

>>
>> What do you mean when the user specifies "event:pp", if the SPE is avail=
able, configure and record the spe data directly via the perf event open sy=
scall?
>> (perf.data itself is the same as using -e arm_spe_0//xxx?)
>=20
> I mean, for the perf record, if the user does not add ":pp" to these even=
ts, the original process is taken, and if ":pp" is added, the spe process i=
s taken.
>=20

Yes we think this is the best way to do it considering that SPE has been im=
plemented as a separate PMU and it will be very difficult to do it in the K=
ernel when the precise_ip attribute is set.

I think doing everything in userspace is easiest. This will at least mean t=
hat users of Perf don't have to be aware of the details of SPE to get preci=
se sample data.

So if the user specifies "event:p" when SPE is available, the SPE PMU is au=
tomatically configured data is recorded. If the user also specifies -e arm_=
spe_0//xxx and wants to do some manual configuration, then that could overr=
ide the automatic configuration.


James
