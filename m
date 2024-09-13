Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5F14EC73;
	Fri, 13 Sep 2024 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262799; cv=none; b=nLkcokld399+cfcqVM8r/Y6x5fDpfp1Yc7H7P4MZ5g438VtEWciCWwXTLwNi831CHO/9LGo2J5sbyrOyIPrn/RK/1gC6Mt3lhbOMK4UQmTPxR9KBOtfnTFfx4/fLVR1LbNvyEsb7dMtsAfNGlHELdliJbxAFPx09EZRBNDBqCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262799; c=relaxed/simple;
	bh=uq1fFp1dyul0YEnDpEY3zyiKQ89fFRtHbay+aPbNGxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0lT1cynlHJkPyvkGKUMJmjPz5nZihIARDQ9WMq1uf7PJ53rekDhONsbAw1RJX2eXhJdhSIPXOLIgtvmywT/1op0DdFFP8SqGOuwVVCpTH5l2LDhNm1HaP5jrXvRoDm+br2pJvXAC0PQkRZDKyqYoF8C2PlyZTblz25M4P3sr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=CwqmJYKt; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="CwqmJYKt"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 45C3D635B044;
	Fri, 13 Sep 2024 23:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1726262353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QEpUsGTEKp/21YhjVnQYIlBG3qJE8+pJXR8PiPJjyt4=;
	b=CwqmJYKtnHjf2wXCEPxur25DC1zt6umUahU766d0Ghj1BhDRZV+mMHYSbwzSbyAKAaC+8t
	I5BuemIIZF1cUcCpeu9cDe5spx4MYuejsLleFGZ7BSin+XXPeeN1cYvI7j7VYsCjv/cIo0
	AVF9G0EQ6yj5C+Z3PUYCfhtR9JkIUog=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rui.zhang@intel.com, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: eranian@google.com, gautham.shenoy@amd.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject:
 Re: [PATCH v5 0/9] Add per-core RAPL energy counter support for AMD CPUs
Date: Fri, 13 Sep 2024 23:18:58 +0200
Message-ID: <12511146.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5814330.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5814330.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Fri, 13 Sep 2024 23:18:58 +0200
Message-ID: <12511146.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
MIME-Version: 1.0

Hello.

On p=C3=A1tek 13. z=C3=A1=C5=99=C3=AD 2024 17:21:40, SEL=C4=8C Dhananjay Ug=
wekar wrote:
> Currently the energy-cores event in the power PMU aggregates energy
> consumption data at a package level. On the other hand the core energy
> RAPL counter in AMD CPUs has a core scope (which means the energy=20
> consumption is recorded separately for each core). Earlier efforts to add
> the core event in the power PMU had failed [1], due to the difference in=
=20
> the scope of these two events. Hence, there is a need for a new core scope
> PMU.
>=20
> This patchset adds a new "power_per_core" PMU alongside the existing
> "power" PMU, which will be responsible for collecting the new
> "energy-per-core" event.
>=20
> Tested the package level and core level PMU counters with workloads
> pinned to different CPUs.
>=20
> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa=20
> machine:
>=20
> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1
>=20
>  Performance counter stats for 'system wide':
>=20
> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>=20
> v4 Link: https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.Ugwe=
kar@amd.com/
>=20
> v5 changes:
> * Rebase on top of Kan Liang's "PMU scope" patchset [2]
> * rapl_cntr_mask moved to rapl_pmus struct in patch 8
> * Patch 1 from v4 is merged separately, so removed from this series
> * Add an extra argument "scope" in patch 5 to the init functions
> * Add an new patch 2, which removes the cpu_to_rapl_pmu() function
>=20
> Base: tip/perf/core(currently has just 1-5 patches from [2]) + patch 6 fr=
om [2] +=20
>       diff [3] + patch 7 from [2] + revert [4] + apply [5]=20
>=20
> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@li=
nux.intel.com/
> [2]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux=
=2Eintel.com/
> [3]: https://lore.kernel.org/all/8c09633c-5bf2-48a2-91a6-a0af9b9f2e8c@lin=
ux.intel.com/
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?=
h=3Dperf/core&id=3D8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514
> [5]: https://lore.kernel.org/all/20240910085504.204814-1-Dhananjay.Ugweka=
r@amd.com/
>=20
> Dhananjay Ugwekar (8):
>   perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
>   perf/x86/rapl: Rename rapl_pmu variables
>   perf/x86/rapl: Make rapl_model struct global
>   perf/x86/rapl: Add arguments to the cleanup and init functions
>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>   perf/x86/rapl: Remove the global variable rapl_msrs
>   perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>=20
> K Prateek Nayak (1):
>   x86/topology: Introduce topology_logical_core_id()
>=20
>  Documentation/arch/x86/topology.rst   |   4 +
>  arch/x86/events/rapl.c                | 406 ++++++++++++++++----------
>  arch/x86/include/asm/processor.h      |   1 +
>  arch/x86/include/asm/topology.h       |   1 +
>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>  arch/x86/kernel/cpu/topology_common.c |   1 +
>  6 files changed, 266 insertions(+), 148 deletions(-)

With v6.11-rc7 + all the mentioned preparatory patches and this series:

$ taskset -c 9 dd if=3D/dev/zero of=3D/dev/null &

$ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 5

 Performance counter stats for 'system wide':

S0-D0-C0              1               3,79 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C1              1               5,65 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C2              1               1,26 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C3              1               3,18 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C4              1               2,06 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C5              1               3,51 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C6              1               0,77 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C7              1               0,55 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C8              1               1,65 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C9              1              47,85 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C10             1               2,49 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C11             1              11,85 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C12             1               1,75 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C13             1               0,74 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C14             1               2,58 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C15             1               4,67 Joules power_per_core/energy-per=
=2Dcore/

       5,003391425 seconds time elapsed

on the following CPU:

AMD Ryzen 9 5950X 16-Core Processor

If this behaves as expected, please add:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5814330.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmbkrEIACgkQil/iNcg8
M0tZMhAAlvJWp4AIPX79UnmqnETyOtW7FHZFOjNE9YOHX9KchlLb7V3iNP2S/TAv
oIjQoTpRciVosdnuWeiBSw0k41kp8QlSI+Pd2OK94RNDH8eS+mUaUzBvjS6fRFXP
NenzZHMg554tJiLcptKqfcBvsVf7Jf0KNsQWlaaL/lG4G9d5Yr3UROd1owPlTmC8
zoQB0ZKNYJf7P2AHmjXAaKme1jGYLenO7SgxXBcmPVqEKVBxtZnBmwciJrtQdJsY
k8gV3d0pSO1mvgJglWA1WpAZOV9mMktV9FAzene8gc547RQYUkNFahQJYFIgHMTN
7X4V9D6syY9Xw7QTNCY3hgOM2gtzV2pSkYjNXAf1Tn29v/7ukzEze2NX/XgOlB3G
HipdhYFu4DCKOMPhBvY14xxe5kRbonYd5pEleHGv+FeV0tLZkoOikVAgZbKUEa0p
X+UOvvcU1W0+Sp7aI/ngi+CNHMaPk0gAqlLxjKaqb3ao99IuzcjQIzk/OF8h4LYi
OqWdq0Y6AOj+6vFc6KQF32roSPlH4WVrUqxbUX7nfOwgL36xAiHuo/V/rcSc2YVo
+3U6sYDto0Q2Tx2q6DSDiHxKfgfjUqFYH7N0EibtDgUi0s/urJnKFif3fHOEkyUH
6Nr12Ehip8FB25rNrMwZwShQISZcVZRX7lm1J3yq+Rka7c1Vd6Y=
=8uuH
-----END PGP SIGNATURE-----

--nextPart5814330.DvuYhMxLoT--



