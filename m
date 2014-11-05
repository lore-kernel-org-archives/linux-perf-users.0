From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC] ARM64: Accessing perf counters from userspace
Date: Wed, 5 Nov 2014 17:39:11 +0000
Message-ID: <20141105173911.GB30358@leverpostej>
References: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
 <20141103154006.GJ29621@leverpostej>
 <CAJ2qOjRj_-uwpWe_Q+wNwSBsrkkmWL6x+u5Ba3_W5erzp9C+wg@mail.gmail.com>
 <CAPiYAf4ZbEP20AEaEyaDJ9ov-w-F-UNDu9OmurL_3YQx+9p5bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36295 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755732AbaKERmP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Nov 2014 12:42:15 -0500
Content-Disposition: inline
In-Reply-To: <CAPiYAf4ZbEP20AEaEyaDJ9ov-w-F-UNDu9OmurL_3YQx+9p5bA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ola Liljedahl <ola.liljedahl@linaro.org>
Cc: Yogesh Tillu <yogesh.tillu@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "magnus.karlsson@avagotech.com" <magnus.karlsson@avagotech.com>, "tillu.yogesh@gmail.com" <tillu.yogesh@gmail.com>, "Prasun.Kapoor@caviumnetworks.com" <Prasun.Kapoor@caviumnetworks.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "Andrew.Pinski@caviumnetworks.com" <Andrew.Pinski@caviumnetworks.com>, "mike.holmes@linaro.org" <mike.holmes@linaro.org>, "linaro-networking@linaro.org" <linaro-networking@linaro.org>, "jean.pihet@linaro.org" <jean.pihet@linaro.org>, "arnd@linaro.org" <arnd@linaro.org>

Hi Ola,

On Wed, Nov 05, 2014 at 04:21:52PM +0000, Ola Liljedahl wrote:
>    Re the use case.
>    We would like to profile e.g. number of cycles or caches misses or
>    mispredicted branches for the rather short code path from when a p=
acket is
>    dequeued for processing until this processing stage is complete an=
d the
>    packet is enqueued. This could be as few as 500 or 1000 instructio=
ns. No
>    system calls are allowed in this code path (indeed it is unlikely =
that the
>    networking dataplane application will doing be any system calls at=
 all
>    after initialization). We also don't want to (or can't) average ov=
erhead
>    over many iterations just in order to amortize the perf syscall ov=
erhead.
>    Re the implementation.
>    I think enabling user space PMU counter access should be done
>    automatically by the kernel when an application requires exclusive=
 access
>    to a PMU counter. This would be a standard feature in the kernel, =
probably
>    requiring a new flag to perf_even_open() or maybe a new ioctl (res=
erve PMU
>    counter and return which actual counter was reserved).

There's already a framework used on x86 that we should re-use. No-one
has yet attempted to reuse it, nor does anyone seem to have done the du=
e
diligence to discover it already exists.

There are many problems with giving userspace control over the counters=
,
and at best we might be able to safely provide userspace with read-only
access. Counter reservation won't fit the existing framework, and the
existing userspace counter access framework doesn't take this approach.

If we can safely expose read-only access in the same manner as x86, and
userspace takes into account the various caveats (e.g. that events can
be rotated across counters), I am not opposed to that. There are a
number of issues that need to be investigated and addressed to make tha=
t
possible beyond flipping a bit in a control register.

There's also the problem of big.LITTLE. I don't see how it's possible t=
o
expose access to the counters in any heterogeneous system in a way that
isn't guaranteed to be broken. I suspect that we can't provide raw
counter access on such systems.

Thanks,
Mark.

>    On 4 November 2014 19:32, Yogesh Tillu <[1]yogesh.tillu@linaro.org=
> wrote:
>=20
>      Hi,
>      =C2=A0 =C2=A0Please find my reply inline.
>      On 3 November 2014 21:10, Mark Rutland <[2]mark.rutland@arm.com>=
 wrote:
>      >
>      > Hi,
>      >
>      > On Mon, Nov 03, 2014 at 03:04:00PM +0000, Yogesh Tillu wrote:
>      > > We have tried to implement some changes to allow perf counte=
rs to be
>      accessed
>      > > from user space. Benchmarking so far has show that these are=
 100s of
>      times
>      > > faster than using syscall(perf_event_open). This would be us=
eful for
>      many use
>      > > cases like networking(critical to fast path code), benchmark
>      executionpath with
>      > > low budget of cpu cycles etc.
>      > >
>      > > Benchmark figures on ArmV8, "reading perf cycle counter" wit=
h below
>      approaches
>      > > 1) Reading perf cycle counter through perf_event_open syscal=
l
>      > > Result[cpu cycles]: 2000 (For Armv7[Arndale] 5407)
>      > > 2) Direct access of perf counters from userspace through asm
>      > > Result[cpu cycles]: 2 (For Armv7[Arndale] 16)
>      > > 3) Reading perf cycle counter through vDSO path
>      > > Result[cpu cycles]: ~20
>      > >
>      > >
>      > > Could you please let me know your comments/review. Below are=
 the
>      details about
>      > > setup and patchset.
>      >
>      > For there to be any meaningful review of this, it needs to be =
based on
>      a
>      > kernel tree, and implemented within the existing perf framewor=
k; it
>      > cannot be a module on the side. This is impossible to review, =
because
>      it
>      > looks nothing like what a real solution will have to.
>      Agree, I will resend patchset based on kernel tree.
>      I will rework on Module implementation and try to reimplement it=
 with
>      CONFIG_ based design to co-exist with kernel perf framework
>      (as in armv8pmu_reset it Disable access to counters from userspa=
ce).
>      >
>      > Please base this on a kernel tree, and integrate with the exis=
ting
>      > frameworks.
>      >
>      > It would also be helpful if you could describe a use case for =
which
>      the
>      > current mechanisms are too expensive. It will certainly be che=
aper to
>      > read the registers directly, but there is additional work user=
space
>      will
>      > need to do in addition to simply reading the registers. That c=
an
>      impact
>      > the use-case.
>      With Current mechanism, it takes lot of cpu cycles where "only r=
ead of
>      perf counter" operations are interested. For example, To Benchma=
rk
>      networking fastpath code like control plane where we have very l=
imited
>      budget for reading value of counters.
>      >
>      > It's unclear to me why you cannot amortize the cost of the rea=
ds over
>      a
>      > number of iterations. A specific (non-trivial) example would h=
elp.
>      Agree, I will try to modify tests with number of iterations.
>=20
>      Thanks,
>      Yogesh
>      > Thanks,
>      > Mark.
>      >
>      > >
>      > > ** Setup details **
>      > > Architecture: ArmV8
>      > > Board=C2=A0 =C2=A0 =C2=A0 =C2=A0: Juno Board
>      > > Linux kernel: 3.16.0+
>      > > Kernel Repo :
>      git://[3]git.linaro.org/kernel/linux-linaro-tracking.git
>      > > (Branch:linux-linaro)
>      > > Rootfs=C2=A0 =C2=A0 =C2=A0 : Linaro Ubuntu rootfs
>      > > Toolchain=C2=A0 =C2=A0: gcc version 4.9.1 20140529 (prerelea=
se)
>      > > (crosstool-NG linaro-1.13.1-4.9-2014.06-02 - Linaro GCC 4.9-=
2014.06)
>      > >
>      > > 1) Reading perf cycle counter through perf_event_open syscal=
l
>      > > *Application to read counter using perf_event_open syscall.
>      > > [PATCH] Application reads perf cycle counter using perf_even=
t_open
>      > > syscall, and prints Benchmark results.
>      > >
>      > > Signed-off-by: Yogesh Tillu <[4]yogesh.tillu@linaro.org>
>      > > ---
>      > >=C2=A0 app_readcounter.c |=C2=A0 =C2=A083
>      +++++++++++++++++++++++++++++++++++++++++++++++++++++
>      > >=C2=A0 1 file changed, 83 insertions(+)
>      > >=C2=A0 create mode 100644 app_readcounter.c
>      > >
>      > >
>      > > 2) Direct access of perf counters from userspace using asm
>      > > This setup contains kernel module + header file with impleme=
nted asm
>      to access
>      > > perf counters + Application uses api provided in header file=
 to
>      access counter.
>      > >
>      > > * Kernel Module: To enable access of counters from userspace
>      > > Yogesh Tillu (1):
>      > >=C2=A0 =C2=A0Kernel module to Enable userspace access to PMU =
counters for
>      > >=C2=A0 =C2=A0 =C2=A0ArmV8
>      > >
>      > >=C2=A0 ARMv8_Module/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A0 8 ++++
>      > >=C2=A0 ARMv8_Module/README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 1 +
>      > >=C2=A0 ARMv8_Module/enable_arm_pmu.c |=C2=A0 =C2=A096
>      +++++++++++++++++++++++++++++++++++++++++
>      > >=C2=A0 3 files changed, 105 insertions(+)
>      > >=C2=A0 create mode 100644 ARMv8_Module/Makefile
>      > >=C2=A0 create mode 100644 ARMv8_Module/README
>      > >=C2=A0 create mode 100644 ARMv8_Module/enable_arm_pmu.c
>      > >
>      > > * Application:
>      > > [PATCH] Added test for Direct access of perf counter from us=
erspace
>      > >=C2=A0 using asm.
>      > >
>      > > Signed-off-by: Yogesh Tillu <[5]yogesh.tillu@linaro.org>
>      > > ---
>      > >=C2=A0 README.directaccess |=C2=A0 =C2=A0 8 ++++
>      > >=C2=A0 direct_access.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A065 ++=
++++++++++++++++++++++++++
>      > >=C2=A0 direct_access.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 117
>      +++++++++++++++++++++++++++++++++++++++++++++++++++
>      > >=C2=A0 3 files changed, 190 insertions(+)
>      > >=C2=A0 create mode 100644 README.directaccess
>      > >=C2=A0 create mode 100644 direct_access.c
>      > >=C2=A0 create mode 100644 direct_access.h
>      > >
>      > > 3) Reading perf cycle counter through vDSO path
>      > > * Kernel Module: To enable access of counters from userspace=
 ( Same
>      as setup (2) )
>      > > * Kernel vDSO implementation: vDSO implementation for readin=
g of
>      perf cycle counter
>      > > [PATCH] provide open/read function through vDSO for PMU coun=
ters
>      > > Yogesh Tillu (1):
>      > >=C2=A0 =C2=A0To read PMU cycle counter through vDSO Path
>      > >
>      > >=C2=A0 arch/arm64/kernel/vdso/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 6 +++---
>      > >=C2=A0 arch/arm64/kernel/vdso/vdso.lds.S=C2=A0 =C2=A0|=C2=A0 =
=C2=A0 5 +++++
>      > >=C2=A0 arch/arm64/kernel/vdso/vdso_perfc.c |=C2=A0 =C2=A020 +=
+++++++++++++++++++
>      > >=C2=A0 3 files changed, 28 insertions(+), 3 deletions(-)
>      > >=C2=A0 create mode 100644 arch/arm64/kernel/vdso/vdso_perfc.c
>      > >
>      > > * application=C2=A0 : To read perf counter through api(imple=
mented
>      through vDSO)
>      > > [PATCH] Test Application: access PMU counter through vDSO
>      > > Yogesh Tillu (1):
>      > >=C2=A0 =C2=A0Test application to read PMU counter through vds=
o
>      > >
>      > >=C2=A0 vdso_userspace_perf.c |=C2=A0 =C2=A058
>      +++++++++++++++++++++++++++++++++++++++++++++++++
>      > >=C2=A0 1 file changed, 58 insertions(+)
>      > >=C2=A0 create mode 100644 vdso_userspace_perf.c
>      > >
>      > > NOTE: This codebase mainly for POC of "Access perf counters =
from
>      userspace",
>      > > not much concentration towards api standard forms.
>      > >
>      > > --
>      > > 1.7.9.5
>      > >
>      > >
>      > > _______________________________________________
>      > > linux-arm-kernel mailing list
>      > > [6]linux-arm-kernel@lists.infradead.org
>      > > [7]http://lists.infradead.org/mailman/listinfo/linux-arm-ker=
nel
>      > >
>=20
> References
>=20
>    Visible links
>    1. mailto:yogesh.tillu@linaro.org
>    2. mailto:mark.rutland@arm.com
>    3. http://git.linaro.org/kernel/linux-linaro-tracking.git
>    4. mailto:yogesh.tillu@linaro.org
>    5. mailto:yogesh.tillu@linaro.org
>    6. mailto:linux-arm-kernel@lists.infradead.org
>    7. http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
