From: James Clark <James.Clark@arm.com>
Subject: Re: [RFC PATCH 2/3] perf tools: Add support for "report" for some spe
 events
Date: Wed, 9 Oct 2019 09:48:55 +0000
Message-ID: <b7e5ca2d-8c6c-8ab8-637e-a9aaebaf62a5@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
 <0ac06995-273c-034d-52a3-921ea0337be2@arm.com>
 <016c1ce8-7220-75a2-43fa-0efe150f897c@huawei.com>
 <805660ca-1cf3-4c7f-3aa2-61fed59afa8b@arm.com>
 <637836d6-c884-1a55-7730-eeb45b590d39@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <637836d6-c884-1a55-7730-eeb45b590d39@huawei.com>
Content-Language: en-US
Content-ID: <9E4071F694BA7A45891EB1DFAFE7DC78@eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tan Xiaojun <tanxiaojun@huawei.com>, Jeremy Linton <Jeremy.Linton@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>, "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>, "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>, "songliubraving@fb.com" <songliubraving@fb.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Kim Phillips <Kim.Phillips@amd.com>
Cc: "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>, "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>, "liwei391@huawei.com" <liwei391@huawei.com>, "huawei.libin@huawei.com" <huawei.libin@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Al Grant <Al.Grant@arm.com>, nd <nd@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Xiaojun,

> By the way, you mentioned before that you want the spe event to be in the=
 form of "event:pp" like pebs. Is that the whole framework should be made s=
imilar to pebs? Or is it just a modification to the command format?=20

We're currently still investigating if it makes sense to modify the Perf ev=
ent open syscall to use SPE when the "precise_ip" attribute is set. And the=
n synthesize samples using the SPE data when available. This would keep the=
 syscall interface more consistent between architectures.

And if tools other than Perf want more precise data, they don't have to be =
aware of SPE or any of the implementation defined details of it. For exampl=
e the 'data source' encoding can be different from one micro architecture t=
o the next. The kernel is probably the best place to handle this.

At the moment, every tool that wants to use the Perf syscall to get precise=
 data on ARM would have to be aware of SPE and implement their own decoding=
.

> For the former, this may be a bit difficult. For the latter, there is cur=
rently no modification to the record part, so "-c -F, etc." is only for ins=
tructions rather than events, so it may be misunderstood by users.
>=20
> So I haven't figured out how to do. What do you think of this?

I think the patch at the moment is a good start to make SPE more accessible=
. And the changes I mentioned above wouldn't change the fact that the raw S=
PE data would still be available via the SPE PMU. So I think continuing wit=
h the patch as-is for now is the best idea.


James
