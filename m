Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5865351C1F
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019200; cv=none; b=k7KdWsJQFdb4rmEp3rS6QiKqoTnB1+JlPqeHhd6GdC6O2HyS+lMS60FUesaHp8wwakfrnZI0vDtc5oudXap3CyImJDy3U6NWiofkdZacZRnaIRGl9+ecO5/RdiYHj+/IBzdf7eAf91oABomYy0WecWoaMpiYAUUvhvVf5IndHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019200; c=relaxed/simple;
	bh=lBXAGlrsbjTU+g8uNsoAuc1n3HKX288sGIs5thhGvIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qbyh2KkwtPZb7/Kxsv00M/TZ6Jo91MNg+Z974+RXUDzKmiiffFJNAUjC/rx+QnAmjjCnT7nHCqF/OBLAvt8HLFir9hlLCQjBDvm/aCOEr5gXB2IvrJF6hbqMpWcSxu08DvK3/ET2iO4flcT5lw31n0eeMzjoxAfanwfoEqgwCT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWogJMS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWogJMS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698291F000E9;
	Tue, 14 Jul 2026 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784019198;
	bh=lBXAGlrsbjTU+g8uNsoAuc1n3HKX288sGIs5thhGvIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eWogJMS6MRxczieFTrTqIvz2Qh4WzNzCxciLvY2/cJ+q99xQZXiTGHIlotnTqFI1b
	 MsucErsbY5VO0SvVyHu6rgOl8h2mHPIhq6AIZXJf5zSl/oQxpGnyGrww1/B+eLQS2d
	 Y9VstDV714/Dz3KRD5eosps0Jlf+eLx1hao1Yv8nGX/fjCu0zk+Uhafm8cv4iKv9BX
	 rVNMH3iJN2FM0cQ4LitBp7XulVwIVzoyDzoW6rHpxhjM83ofBRaraNlUHM/8HmfTRb
	 to7kr4YlgMBDprn4NhwgB+b4PGRLFJYHnFS1ePMd4JWFKnfZ0LHB1pW5oQRFLioCqz
	 awreIntKdrZ/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714083625.1083606-2-zong.li@sifive.com>
References: <20260714083625.1083606-1-zong.li@sifive.com>
 <20260714083625.1083606-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 08:53:17 +0000
Message-Id: <20260714085318.698291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Missing `.remove` callback in the auxiliary driver and incorrect `=
devm` usage tie resources to the wrong lifecycles, causing Use-After-Free o=
n device unbind.
- [High] The PMU IRQ handler fails to properly clear the interrupt source i=
n multiple edge cases, leading to a permanent PMU lockup or an infinite int=
errupt storm.
- [High] The stateful counter read optimization in `riscv_iommu_pmu_get_cou=
nter` overwrites its state, causing subsequent hardware wraparounds to be c=
ompletely missed.
- [High] The interrupt handler blindly restarts all allocated counters, inc=
orrectly unpausing events that were explicitly stopped by the perf core.
- [High] Stack buffer overflow on 32-bit systems due to writing a 64-bit va=
lue into a 32-bit bitmap array.
- [Medium] Group validation logic in `riscv_iommu_pmu_event_init` fails to =
enforce hardware constraints and allows invalid cross-PMU combinations.
- [Medium] Wrapping expected `irq_set_affinity` failures in `WARN_ON` cause=
s unnecessary kernel stack traces.
- [Medium] Incorrect determination of `num_counters` using `hweight32` make=
s the highest counter inaccessible if lower counters are omitted.
--

--- Patch [1]: [PATCH v4 1/2] drivers/perf: riscv-iommu: add risc-v iommu p=
mu driver ---
Note: The format of this report has been altered to provide a free-form sum=
mary
due to system recitation restrictions. No original patch code is quoted.

commit f8f3c1f0f8ae563726a542519ac8eef772529601
Author: Zong Li <zong.li@sifive.com>
Subject: drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This commit adds a new auxiliary device driver to support the risc-v iommu =
pmu.
It implements the performance monitoring counters, including hardware detec=
tion,
filtering support, and event configuration.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

[Severity: High]
Does the iommu_pmu_driver auxiliary driver leak resources or cause a
use-after-free on unbind?

The driver definition is missing a remove callback to unregister the pmu and
remove the cpu hotplug instance. Furthermore, riscv_iommu_pmu_request_irq()
binds the interrupt using devm_request_irq() against the parent iommu device
rather than the auxiliary device. If a user unbinds the pmu driver via sysf=
s,
the struct will be freed, but the interrupt and hotplug callbacks will rema=
in
active with dangling pointers.

[Severity: High]
Will the pmu interrupt handler cause an interrupt storm or permanent lockup=
 on
edge cases?

In riscv_iommu_pmu_irq_handler(), if the overflow register reads as zero, t=
he
function returns early without clearing the interrupt pending bit in the st=
atus
register and without restarting the counters. Similarly, if an event is mis=
sing
from the array, the loop uses continue and skips clearing the hardware over=
flow
bit. Both cases leave the interrupt pending indefinitely.

[Severity: Medium]
Does the event initialization logic properly validate groups?

In riscv_iommu_pmu_event_init(), when iterating over siblings in a group, t=
he
code explicitly skips checking if the sibling's pmu matches the event's pmu
when the sibling is a cycle event. Additionally, the loop counts the siblin=
gs
but seems to miss accounting for the new event itself when checking against
total_event_counters, which could allow exceeding hardware limits or creati=
ng
invalid cross-pmu groups.

[Severity: Medium]
Is it intentional to trigger a kernel warning for expected affinity failure=
s?

In both riscv_iommu_pmu_probe() and riscv_iommu_pmu_offline_cpu(), the calls
to irq_set_affinity() are wrapped in a warning macro. On systems without
multiprocessor support or with interrupt controllers that do not support
affinity routing, this function safely returns an error. Wrapping this in a
warning causes unnecessary stack traces for valid hardware configurations.

[Severity: High]
Can the counter read optimization miss hardware wraparounds?

In riscv_iommu_pmu_get_counter(), when a wraparound is detected, the code s=
ets
the previous low value to a sentinel of all ones to force the slow path on =
the
next read. However, this sentinel value is immediately overwritten
unconditionally by the actual low value read, which is zero. If another wrap
occurs before the next read, the check for whether the new low value is less
than or equal to the previous low value will fail, and the wraparound will =
be
missed.

[Severity: Medium]
Does using hweight32() to determine the number of counters cause issues with
sparse counter implementations?

In riscv_iommu_pmu_probe(), the number of counters is derived by counting t=
he
set bits in the inhibit register using hweight32(). If the hardware omits
some lower counters but implements higher ones, hweight32() returns a count
that is strictly less than the highest implemented index. This means the bi=
tmap
operations will use a bound that cuts off the highest available counters,
leaving them inaccessible. Should this use fls() on the bitmask instead?

[Severity: High]
Does the interrupt handler accidentally unpause stopped events?

In riscv_iommu_pmu_start_all(), the code clears the inhibit bits for every
counter that is marked in used_counters. However, used_counters only tracks
whether a counter has been allocated to an event, not whether that event is
currently active or explicitly stopped by the perf core. If an event was
stopped for throttling or a context switch, an interrupt from another event
will cause the stopped event to unconditionally resume counting.

[Severity: High]
Can the overflow bitmap trigger a stack buffer overflow on 32-bit architect=
ures?

In riscv_iommu_pmu_irq_handler(), ovf_bitmap is declared with a size of 32
bits. On 32-bit systems, this allocates exactly 4 bytes on the stack. The
function then calls bitmap_from_u64() to copy the overflow register into it,
which unconditionally writes 64 bits (8 bytes), overwriting 4 bytes of adja=
cent
stack memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714083625.1083=
606-1-zong.li@sifive.com?part=3D1
