Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F092641EE
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911763; cv=none; b=BjseCH1oW4NgjnbyIW6Oynro4Uqtl4QfbfMF7umZJN4dVYwzbGSOIGsBH6xT5KbpEdLVR0lAks3xEhqGJW/XJWPfy4g/UNes/KLnewbVqxMdoxqPL9rPV7/CZuh596vVEq+LMN3UWdNMZdpg31cBMJWGFEruBuXkYrUJOaWr8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911763; c=relaxed/simple;
	bh=PEgYszr3C0/80DXj9fpELQ8jt6gYhIAhYk0e4gbcO4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TZEHk8ghLuTJ4MJ0hV5j+7ATJdWzb9ppZ9P1a6WNIRLnl4IqnoDpqBIZJnIWfapRGi5ByXZTHZXIkokheW8IMj/wgigRhCL2Vu3+AARP8X1l4cg6aF0ZWWS6Ju7zcuEjdyGK9gWLT/ywcEHqnu5Z0pSUBR4fkAnBGcIfcXiwLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CceXB88o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CceXB88o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20AF1F000E9;
	Wed, 27 May 2026 19:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911762;
	bh=NummqP1mBbU7sy9QVHom4VF6oTxQ0g8IRMRDwJOeHVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CceXB88oQi1mxz+e5PUmYQjzKLY8nuDNnnJm4XJci//oXZJbSsbv52sFYJfmuGx+J
	 p5kHAPCvZ5W0L9rlo1s5DAmFNTg3pqRuazA/zv0VVcARPGr+ZwfN9l/ob0TwHMPed/
	 ATSziLJZaG4Xz2wPUtwmsXDPP3V7VILudVozQ+QSUwShdJTzT+uloKqlhTciUfLKwJ
	 47mEpTWMUnqR8BKHWyAJTbr2aSb9m5cgmOrHnswkFtzXigUxqnfGi5ju02T6kXU1we
	 SVa9u5hAaOVlikeSa5RjmitbwzQ/S/FgNmfOKh9x5iceNtAMZI6pTZyWG1ZKlq+Z67
	 zITfmzbnhsfWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 6/7] perf/x86/intel/uncore: Fix uncore_die_to_cpu()
 for offline dies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260527151154.130505-6-zide.chen@intel.com>
References: <20260527151154.130505-6-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 19:56:01 +0000
Message-Id: <20260527195601.F20AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but in `pmu_alloc_to=
pology()`, if the memory allocation for `topology[die]` fails, the error cl=
eanup loop dereferences the newly-NULL pointer, causing a kernel crash.
- [High] This problem wasn't introduced by this patch, but there is an unpr=
otected list traversal of PCI buses in `uncore_die_to_segment()` leading to=
 a potential Use-After-Free if a PCI bus is hot-removed.
--

commit ff1f5cc12e40244014f762aa4e444d2ef1d867a3
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Fix uncore_die_to_cpu() for offline dies

If the die is offline when uncore_die_to_cpu() is called, it silently
returns 0, which is misleading. This patch modifies the function to return
-1 in this case, indicating that all CPUs on the die are offline. It also
opportunistically replaces -EPERM with -ENODEV.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 22256ded2d67d..4b3a1fa5b41b7 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -91,7 +91,7 @@ int uncore_device_to_die(struct pci_dev *dev)
>   */
>  int uncore_die_to_cpu(int die)
>  {
> -	int res =3D 0, cpu;
> +	int res =3D -1, cpu;
> =20
>  	for_each_online_cpu(cpu) {
>  		if (topology_logical_die_id(cpu) =3D=3D die) {

[ ... ]

> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index 772b78237424c..334dc384b5b93 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3772,12 +3772,17 @@ static void pmu_free_topology(struct intel_uncore=
_type *type)
>  static int skx_pmu_get_topology(struct intel_uncore_type *type,
>  				 int (*topology_cb)(struct intel_uncore_type*, int, int, u64))
>  {
> -	int die, ret =3D -EPERM;
> +	int die, ret =3D -ENODEV;
>  	u64 cpu_bus_msr;
> +	int cpu;
> =20
>  	cpus_read_lock();
>  	for (die =3D 0; die < uncore_max_dies(); die++) {
> -		ret =3D skx_msr_cpu_bus_read(uncore_die_to_cpu(die), &cpu_bus_msr);
> +		cpu =3D uncore_die_to_cpu(die);
> +		if (cpu =3D=3D -1)
> +			continue;
> +
> +		ret =3D skx_msr_cpu_bus_read(cpu, &cpu_bus_msr);
>  		if (ret)
>  			break;

[Severity: High]
This isn't a bug introduced by this patch, but later in this function, we
call uncore_die_to_segment() which iterates over PCI root buses using
pci_find_next_bus():

arch/x86/events/intel/uncore.c:uncore_die_to_segment() {
	struct pci_bus *bus =3D NULL;

	/* Find first pci bus which attributes to specified die. */
	while ((bus =3D pci_find_next_bus(bus)) &&
	       (die !=3D uncore_pcibus_to_dieid(bus)))
		;

	return bus ? pci_domain_nr(bus) : -EINVAL;
}

The pci_find_next_bus() function acquires and releases pci_bus_sem internal=
ly,
returning a raw bus pointer without holding a lock or taking a reference co=
unt.

If an unrelated hot-pluggable PCI root bus is hot-removed concurrently, cou=
ld
the bus pointer be freed before the next iteration?

Passing this freed pointer back to pci_find_next_bus() could cause a
use-after-free when accessing from->node.next.=20

While cpus_read_lock() is held in skx_pmu_get_topology(), does it prevent
concurrent hotplug of unrelated PCI root buses?

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference in pmu_alloc_topology() in this same file.

If kzalloc_objs() for topology[die] fails, the code jumps to the clear labe=
l:

arch/x86/events/intel/uncore_snbep.c:pmu_alloc_topology() {
	...
	for (die =3D 0; die < uncore_max_dies(); die++) {
		topology[die] =3D kzalloc_objs(**topology, type->num_boxes);
		if (!topology[die])
			goto clear;
	...
clear:
	for (; die >=3D 0; die--) {
		for (idx =3D 0; idx < type->num_boxes; idx++)
			kfree(topology[die][idx].untyped);
		kfree(topology[die]);
	...
}

At the clear label, the loop variable die still points to the index that
failed allocation, so topology[die] is NULL.

Does the cleanup loop's attempt to execute kfree(topology[die][idx].untyped)
evaluate to (topology[die] + idx)->untyped and crash the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527151154.1305=
05-1-zide.chen@intel.com?part=3D6
