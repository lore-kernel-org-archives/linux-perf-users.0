Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853333;
	b=ySL31mFHeTktWKL6lkbiij9GjVpu3gJzVRNQD5zykddKu2inMrMLg1f2Gxy3yS0Z1iiW
	 pXWSb83fCPDFrUeaYOS2Wq0a7vss5OfTUOcdE1D/XXN8oh3Ct2+mYYYWT4QWJJ9yoiG0F
	 k/NE3nlkQ3XurOLSNDoLrLqmyvdez70UBDEuSLnQDV8mFcgfkxUJN1AQC74Nkl7bwCAlM
	 GN70pCne0ANrNnw2HjEZiH3m5yWyIJ+tI6cKG2GM6Zpg7Bj+8RpaWcm3PoOyJ5vj8DnQf
	 bvzYldkrTDFdO1IoR/NpW8A/o1QAj6uS0L3Z0rpRM/2lDUcjUesTpwNKbYzdwjztA+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853333;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Bx9BFmE1wLXw81GEy8xTvfh2DHQC7Qib0epoWWtsHZg=;
	b=OZXKOj/b4fdbbGuB7xhnu/Jvl00vNhUtoGKUryEG8Q+r1R4YG3ecf38uUVa+gSIqBk7u
	 6qJss6NDt18gcbqne7p/53bdnoiL8Qwb7AhoxKFSfFVTk0PJ8THjZutcLqfiwhrlhy1X+
	 FEQHMl7bKczaYUCXVGQ/rVpUWV76MjvLrHN/QjZ/UD4KbzHzDYyrupftS5tEi/6iBESSE
	 yHh7dR8WBPFbGWfwyqP+7iw2n7VaMJJs5nAfAzc3W4lc2cwTIXff5NngIQFlYfV7WxG9L
	 IJKOYLjhpBZKE3gq+s6s7A8RNIkWS3fHll3NhNRYRzsd8uJzfhq3KNobgboHpqoWm7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UlTR1XYG;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64050606A31C;
	Mon, 16 Nov 2026 18:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64050606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UlTR1XYG
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A07C41684;
	Mon, 16 Nov 2026 10:22:08 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 925C03F632;
	Mon, 16 Nov 2026 10:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794853331; bh=goJwv/swJu68Y9hAS2XUupq7PiPrjIfLYlStZrGMjm0=;
	h=From:Subject:Date:To:Cc:From;
	b=UlTR1XYGFmGx57WHb+xFLIaoTlc9SWjhRZzd27Td4eV42hOpsw40LqOrDG/7iSgtX
	 TIy5sLSf7nHcRqzEqquUlPfxvS3l7C/ndYlKT1Bksy+6Ls6eVuiaC7x0rgmD9F2mZQ
	 5O//L1uzfYhNyp1/14QAlVJM4YW73pn/rIJ954G4=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/8] ACPI: arm64: Support PMU on Heterogeneous Systems
Date: Mon, 16 Nov 2026 18:21:27 +0000
Message-Id: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdJ+2oC/4WNwQqDMBBEf0X23JSsEKk99T+KhDRZdQ/RsLHSI
 v57U+m9xzfMvNkgkzBluFYbCK2ceZ4K4KkCP7ppIMWhMNS6bhB1q5xPbJ1Em+LTCg2cF3FLWdk
 xJtV40xrf63AJBMWRhHp+Hf57V3gs9Vnex92K3/RnRvxjXlFp9WiDN7rHQGRupXr2c4Ru3/cP5
 yuevMgAAAA=
X-Change-ID: 20261109-acpi_arm_pmu_registration_hmp-6c595cf0d8de
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, Will Deacon <will@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, Jeremy Linton <jeremy.linton@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, Rob Herring <robh@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, Al Grant <al.grant@arm.com>, 
 "Johnny.Fan" <johnny.fan@cixtech.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794853327; l=3514;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=goJwv/swJu68Y9hAS2XUupq7PiPrjIfLYlStZrGMjm0=;
 b=56hWmS+3xC7LmrbBWUKHF9DrbRdWd6N36Fs78LtUwPpuAQFmSQns9f24Hao9oUvCm380XIMCE
 jwOjkO90ZeDBQMKP870C1FH435FZioX3FoPWaALnB24SOlEKVFsakAy
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series follows Johnny Fan's SPE/TRBE work [1], which requires
ACPI-specific IRQ affinity handling in the drivers. It provides a common
way to describe PPI affinity for devices created from the MADT.

Register one platform device for each group of CPUs with the same MIDR.
Associate a software node with each device to expose its CPU mask through
platform_get_irq_affinity(). SPE and TRBE drivers can then obtain affinity
without ACPI-specific handling or a processor-container companion.

Grouping by MIDR allows CPU PMU events to follow tasks across compatible
CPUs, including CPUs in different processor containers. SPE and TRBE
require a shared GSI within each group. CPU PMUs can also use per-CPU SPIs
and reuse the platform probe path used for DT. Move the common ACPI device
registration to drivers/acpi/arm64/.

This series has been tested on Orion O6, with four little Cortex-A520
cores (CPUs 2-5) and eight big Cortex-A720 cores (CPUs 0-1 and 6-11).
It exposes the following PMU devices:

  # ls /sys/bus/event_source/devices/
  arm_spe_0  armv8_pmuv3_0  armv8_pmuv3_1  breakpoint  cs_etm  kprobe  software  tracepoint  uprobe
  # cat /sys/bus/event_source/devices/armv8_pmuv3_0/cpus
  0-1,6-11
  # cat /sys/bus/event_source/devices/armv8_pmuv3_1/cpus
  2-5
  # cat /sys/bus/event_source/devices/arm_spe_0/cpumask
  0-1,6-11
  # ls /sys/bus/event_source/devices/cs_etm/sinks/
  trbe0  trbe1  trbe10  trbe11  trbe2  trbe3  trbe4  trbe5  trbe6  trbe7  trbe8  trbe9

The CPU PMU masks match the MIDR groups: eight A720 CPUs and four A520
CPUs. SPE uses the A720 mask, and TRBE exposes one sink per CPU.

[1] https://lore.kernel.org/linux-arm-kernel/20261102084153.3975282-1-johnny.fan@cixtech.com/

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Johnny.Fan (1):
      perf/arm_pmu: Register ACPI SPE and TRBE devices with software nodes

Leo Yan (7):
      device property: Add firmware node IRQ affinity callbacks
      device property: Add software-node IRQ affinity masks
      perf/arm_pmu: Prepare ACPI registration for per-CPU interrupts
      perf/arm_pmu: Register ACPI CPU PMUs as platform devices
      perf/arm_pmu: Support ACPI devices in the platform probe
      perf/arm_pmu: Use ACPI CPU affinity in IRQ handling
      ACPI: arm64: Move PMU device registration to drivers/acpi/arm64/

 MAINTAINERS                     |   1 +
 arch/arm64/include/asm/acpi.h   |   3 +
 drivers/acpi/arm64/Kconfig      |   4 +
 drivers/acpi/arm64/Makefile     |   1 +
 drivers/acpi/arm64/pmu.c        | 393 +++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c         |   8 +
 drivers/base/platform.c         |   7 +-
 drivers/base/property.c         |  15 ++
 drivers/base/swnode.c           |  53 +++++
 drivers/of/property.c           |   7 +
 drivers/perf/Kconfig            |   4 -
 drivers/perf/Makefile           |   1 -
 drivers/perf/arm_pmu.c          |   3 +-
 drivers/perf/arm_pmu_acpi.c     | 438 ----------------------------------------
 drivers/perf/arm_pmu_platform.c |  62 +++++-
 drivers/perf/arm_pmuv3.c        |   5 +-
 include/linux/cpuhotplug.h      |   1 -
 include/linux/fwnode.h          |   5 +
 include/linux/perf/arm_pmu.h    |  12 +-
 include/linux/property.h        |   6 +
 20 files changed, 552 insertions(+), 477 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261109-acpi_arm_pmu_registration_hmp-6c595cf0d8de

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

