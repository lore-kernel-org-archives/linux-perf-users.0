From: SUJA JAMES <sujamoljames@yahoo.com>
Subject: Performance Events/Hw Cache Miss counting
Date: Mon, 17 Oct 2011 11:32:09 -0700 (PDT)
Message-ID: <1318876329.69798.YahooMailNeo@web110406.mail.gq1.yahoo.com>
Reply-To: SUJA JAMES <sujamoljames@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Message body
Hi All,

I am trying to query the performance management counters on my box,
which is based on Kernel 2.6.38 and running Intel processor.=C2=A0 I am
trying to do the same from my kernel module itself as I need to
profile my kernel modules. I use the
perf_event_create_kernel_counter() api with the following attr/config

The below=C2=A0 attrs/configuration is working and I am getting the cou=
nter
values/overflow_handler is getting called.
static struct perf_event_attr counter_attrs[] =3D {
{
=C2=A0 =C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0=C2=A0 .type=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D PERF_=
TYPE_HARDWARE,
=C2=A0=C2=A0=C2=A0 .config=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D PER=
=46_COUNT_HW_CACHE_MISSES,
=C2=A0=C2=A0=C2=A0 .size=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D sizeo=
f(struct perf_event_attr),
=C2=A0=C2=A0=C2=A0 .pinned=C2=A0=C2=A0=C2=A0 =3D 1,
=C2=A0=C2=A0=C2=A0 .disabled=C2=A0=C2=A0=C2=A0 =3D 0,
=C2=A0=C2=A0=C2=A0 },
};

But, when I use the following attrs/config, the
perf_event_create_kernel_counter() API is failing.=C2=A0 Ie,
(IS_ERR(returned_pevent) is TRUE and the event is not triggered on the
CPU.=C2=A0 I even tried =E2=80=9CPERF_TYPE_HARDWARE=E2=80=9D type also =
with the below
config. Also I used different values for "sample_period" [100 to 1000]

static struct perf_event_attr counter_attrs[] =3D {
{
=C2=A0=C2=A0=C2=A0 .type=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =3D=
=C2=A0 PERF_TYPE_HW_CACHE,
=2Econfig=C2=A0=C2=A0=C2=A0 =C2=A0 =3D=C2=A0=C2=A0=C2=A0 PERF_COUNT_HW_=
CACHE_L1D =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
 <<=C2=A0 0=C2=A0 |
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 (PERF_C=
OUNT_HW_CACHE_OP_READ =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 <<=C2=
=A0 8) |
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (PERF_COUNT_HW=
_CACHE_RESULT_MISS =C2=A0=C2=A0=C2=A0 =C2=A0 << 16),
=C2=A0=C2=A0=C2=A0 .size=C2=A0=C2=A0=C2=A0 =C2=A0 =3D sizeof(struct per=
f_event_attr),
=C2=A0=C2=A0=C2=A0 .pinned=C2=A0 =3D 1,
=C2=A0=C2=A0=C2=A0 .disabled =3D 0,
=C2=A0=C2=A0=C2=A0 },
};

Does anybody know why?. What =E2=80=9Cconfig=E2=80=9D value=C2=A0 I sho=
uld use to query the
L1D/ L1I cache misses. I think the =E2=80=9CPERF_COUNT_HW_CACHE_MISSES=E2=
=80=9D counts
only 2nd and 3rd level caches.

Thanks,
Suja
