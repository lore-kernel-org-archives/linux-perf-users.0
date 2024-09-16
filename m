Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D113BAC6;
	Mon, 16 Sep 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469369; cv=none; b=DLH/V+WW4eC5WFMaq6ifCl6axoRWduIpFBcRy162WirsHpHxIurK/A/AKPzT062RxIaZ4CfVDH03KhcEWMCySqeVARAYJkgNAupvunT2eNb3FpkLvaA42KilJ/pcVz3uwovr5CsXolgXZrhv4O0sWrB6sFLZQZ9WWjiD9IkeDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469369; c=relaxed/simple;
	bh=ZozYKvgROHO1raDuSrpocyvUKKR2cO7VKK9UmLVOQbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3LScUz5qSbq2hBzIpPwPOGHG0IsBGBnsk67pV2jmc55j/wNqr6Egd8TJxi9kWF50nnqF40nFwLdo5d35onsKAFAJ9lfUwZCNnI7+V7zDt3EntfdfWUtBFddnGndHR6ZxeGcl85Sm24HaqEMgLXKS/Ft9/fmGkioDb6CoqwI3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=qwlj8m7A; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="qwlj8m7A"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 3ABC0635B044;
	Mon, 16 Sep 2024 08:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1726469356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OpAToRcOAtsVlBADYEykP6qZIrdZeHVVPdnhqMdtvI8=;
	b=qwlj8m7AhDaysAWVz6vHUN0dYW3Vh/bcH1bGjyfNtTr6pvdA2KzFYyJtybwL/k7eTZI7FH
	ynWqJZDCUg/CvfANNQsqfAoRts8W+/KtCxbGsS2g9BmyGiunsEQNEG8CILLgowhtGljCns
	Qpg6MXh+eclupke5DsCLOl2VjRs3VTk=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rui.zhang@intel.com, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: eranian@google.com, gautham.shenoy@amd.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v5 0/9] Add per-core RAPL energy counter support for AMD CPUs
Date: Mon, 16 Sep 2024 08:49:01 +0200
Message-ID: <4593672.LvFx2qVVIh@natalenko.name>
In-Reply-To: <ef56c1b3-5ff9-48de-bfbf-88c99b44695a@amd.com>
References:
 <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
 <12511146.O9o76ZdvQC@natalenko.name>
 <ef56c1b3-5ff9-48de-bfbf-88c99b44695a@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2338222.ElGaqSPkdT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2338222.ElGaqSPkdT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Mon, 16 Sep 2024 08:49:01 +0200
Message-ID: <4593672.LvFx2qVVIh@natalenko.name>
In-Reply-To: <ef56c1b3-5ff9-48de-bfbf-88c99b44695a@amd.com>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 16. z=C3=A1=C5=99=C3=AD 2024 6:18:13, SEL=C4=8C Dhanan=
jay Ugwekar wrote:
> Hello Oleksandr,
>=20
> On 9/14/2024 2:48 AM, Oleksandr Natalenko wrote:
> > Hello.
> >=20
> > On p=C3=A1tek 13. z=C3=A1=C5=99=C3=AD 2024 17:21:40, SEL=C4=8C Dhananja=
y Ugwekar wrote:
> >> Currently the energy-cores event in the power PMU aggregates energy
> >> consumption data at a package level. On the other hand the core energy
> >> RAPL counter in AMD CPUs has a core scope (which means the energy=20
> >> consumption is recorded separately for each core). Earlier efforts to =
add
> >> the core event in the power PMU had failed [1], due to the difference =
in=20
> >> the scope of these two events. Hence, there is a need for a new core s=
cope
> >> PMU.
> >>
> >> This patchset adds a new "power_per_core" PMU alongside the existing
> >> "power" PMU, which will be responsible for collecting the new
> >> "energy-per-core" event.
> >>
> >> Tested the package level and core level PMU counters with workloads
> >> pinned to different CPUs.
> >>
> >> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa=20
> >> machine:
> >>
> >> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1
> >>
> >>  Performance counter stats for 'system wide':
> >>
> >> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
> >> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
> >>
> >> v4 Link: https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.U=
gwekar@amd.com/
> >>
> >> v5 changes:
> >> * Rebase on top of Kan Liang's "PMU scope" patchset [2]
> >> * rapl_cntr_mask moved to rapl_pmus struct in patch 8
> >> * Patch 1 from v4 is merged separately, so removed from this series
> >> * Add an extra argument "scope" in patch 5 to the init functions
> >> * Add an new patch 2, which removes the cpu_to_rapl_pmu() function
> >>
> >> Base: tip/perf/core(currently has just 1-5 patches from [2]) + patch 6=
 from [2] +=20
> >>       diff [3] + patch 7 from [2] + revert [4] + apply [5]=20
> >>
> >> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d=
@linux.intel.com/
> >> [2]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@li=
nux.intel.com/
> >> [3]: https://lore.kernel.org/all/8c09633c-5bf2-48a2-91a6-a0af9b9f2e8c@=
linux.intel.com/
> >> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commi=
t/?h=3Dperf/core&id=3D8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514
> >> [5]: https://lore.kernel.org/all/20240910085504.204814-1-Dhananjay.Ugw=
ekar@amd.com/
> >>
> >> Dhananjay Ugwekar (8):
> >>   perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
> >>   perf/x86/rapl: Rename rapl_pmu variables
> >>   perf/x86/rapl: Make rapl_model struct global
> >>   perf/x86/rapl: Add arguments to the cleanup and init functions
> >>   perf/x86/rapl: Modify the generic variable names to *_pkg*
> >>   perf/x86/rapl: Remove the global variable rapl_msrs
> >>   perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
> >>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
> >>
> >> K Prateek Nayak (1):
> >>   x86/topology: Introduce topology_logical_core_id()
> >>
> >>  Documentation/arch/x86/topology.rst   |   4 +
> >>  arch/x86/events/rapl.c                | 406 ++++++++++++++++----------
> >>  arch/x86/include/asm/processor.h      |   1 +
> >>  arch/x86/include/asm/topology.h       |   1 +
> >>  arch/x86/kernel/cpu/debugfs.c         |   1 +
> >>  arch/x86/kernel/cpu/topology_common.c |   1 +
> >>  6 files changed, 266 insertions(+), 148 deletions(-)
> >=20
> > With v6.11-rc7 + all the mentioned preparatory patches and this series:
> >=20
> > $ taskset -c 9 dd if=3D/dev/zero of=3D/dev/null &
> >=20
> > $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ sleep=
 5
> >=20
> >  Performance counter stats for 'system wide':
> >=20
> > S0-D0-C0              1               3,79 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C1              1               5,65 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C2              1               1,26 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C3              1               3,18 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C4              1               2,06 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C5              1               3,51 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C6              1               0,77 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C7              1               0,55 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C8              1               1,65 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C9              1              47,85 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C10             1               2,49 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C11             1              11,85 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C12             1               1,75 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C13             1               0,74 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C14             1               2,58 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C15             1               4,67 Joules power_per_core/energy=
=2Dper-core/
> >=20
> >        5,003391425 seconds time elapsed
> >=20
> > on the following CPU:
> >=20
> > AMD Ryzen 9 5950X 16-Core Processor
> >=20
> > If this behaves as expected, please add:
> >=20
> > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>=20
> Energy reported by core 9 is considerably higher than other cores, which =
is as expected.
>=20
> However, can you please post the core_id for CPU 9 just to be sure,

$ cat /sys/devices/system/cpu/cpu9/topology/core_id
9

> also I see that other=20
> cores are also showing considerable energy consumption(e.g. core 11), are=
 there some other=20
> tasks running in the background?

Yes, this is a fully-featured desktop environment. Another run:

S0-D0-C0              1               7,68 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C1              1               2,05 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C2              1               0,96 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C3              1               5,16 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C4              1               1,11 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C5              1               2,42 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C6              1               1,11 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C7              1               0,51 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C8              1               1,61 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C9              1              47,07 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C10             1               1,59 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C11             1               3,02 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C12             1               1,43 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C13             1               0,84 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C14             1               0,73 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C15             1               0,78 Joules power_per_core/energy-per=
=2Dcore/

Thank you.

>=20
> Thanks for testing!
>=20
> Regards,
> Dhananjay
>=20
> >=20
> > Thank you.
> >=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart2338222.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmbn1N0ACgkQil/iNcg8
M0vA5BAAuvrxL1Ww66CzQY0hbanL9x4JozASuGpoPijKGZ6drC4Vb6kuWQTklRUI
WbHMa5r7okU4Lky+4wN5EK0AnzQx9OkhRgJmx5OPhuk/S2v+MqYh+cVwmIbwe8O/
hBtvBCV6FKu783ueRj8TxIKQFb3CHsDFfLBE73fRqFwk5MU8CNQN/20K8uKgl/YF
ELGPxp5Y7+ro5zLLESQ54mk/1gyU1pC0YaR1wW5RzQRYwwXTOjOrAl7UvQP1JN/U
hIXBEP/ns8YlrkDI+0wLcCCzEQ9onGzTkKc4gc1/mRlNqE886wEQ098JFLZtgm65
mCuCHE8U+bm3dDAXPuZ1SFNQN5isQUpLZAGYTY122+p3eX5X4yx42I+sYKdIg1Lu
/GVkkgI1v5YLhfIMrOaORvucrXP/1dovSTC5R8bTgloAisnD5PuMZ7c7U4OIUt0n
/hd4whKbBSOR1tby/HhN3RHhHG/xX82WDtL8d74yxGnhyCHmGJAzgF9lRQLpS/Az
9rP5fe54uWxQh8XbRkWV3XP9uOmz1jyfRdvimGeuq+bfyabo2YaE/Mb6nUpdXVhx
Eo/byCDo0nWGyqW/46bjLGrlIVKbS+EdI5iO/ktr6ToYkbFSE1d8YFwGSPbpG4F9
FWB2Guwhsr9YMjxhTnGyqLggjGcowAuhFwYbb6w8qSOdAUCOGyw=
=N53Z
-----END PGP SIGNATURE-----

--nextPart2338222.ElGaqSPkdT--



