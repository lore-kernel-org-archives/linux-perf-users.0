Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70B372058;
	Mon,  7 Sep 2026 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759923; cv=none; b=JziXG8pyz1qu99eJTCXUSB7/carrkDGw98mIToRfCi6MHAhNxgC2SIG5BzIRbgrWkVYawFPG8AuPy8718Q32bxcJrRvnfjWwmy1cuo8NajkQC91EL1TdC7dcH5aLUiKvvTm4MBG5RlKO/8LsprIDThHUNnxXsL6+hm6cLHMiB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759923; c=relaxed/simple;
	bh=74OyWk+S1XapnZa91tZh7QGJ8Z65Zq0I4MGM9fNJNk4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pnYsu32y/UGohjb1L0aJl4bFlHxdoxkZq9hwn6Vi2Tq8BAdR9aIT599d8SuF3NJJRm2nP7QOWhNoHOVitt6X0vW7EmMMjWEMbzQMm+ba2u/5K+2+CRptOJrZEkWkDLd6FMXq58XunGNRz5Ad6VvGibA8NoPU2pV8wMB8udJYYVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=A6HY3cV7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="A6HY3cV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1788759912;
	bh=74OyWk+S1XapnZa91tZh7QGJ8Z65Zq0I4MGM9fNJNk4=;
	h=From:Subject:Date:To:Cc:From;
	b=A6HY3cV701dgp4nehXyHi0uuEnDYEsK/ruMG+iGzYoQjZUV/M7TXnif6yPqj1WCHf
	 u6SwqmxYz6xiFp1/Wb0+Xphev6GzjL+dE1p6VSs5jEWoFF42oV7/2jf4QHzK47dG/q
	 rSXkrDVQq0zPLslfyMEAaaLBw5epZDE/IPsbgxso=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] driver core: Constify the signature of
 device_show/store_*()
Date: Mon, 07 Sep 2026 07:45:00 +0200
Message-Id: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw7CIBBFf6Vh7RjAitGV/2GapoVBcEENQ7FN0
 3+3j7h2eZKbc+7ECKNHYrdiYhGzJ9+FBeShYNo14YngzcJMcqn4RUigkSyB7gIlaFKKYDDXOKR
 6h9YqdbXGmhLZ4nhHtH7Y/I9qZ+rbF+q0SteF85S6OG4Hslh3v1b5p5UFcFCt1Lw8nY2S4v5BT
 0Ta9e4YMLFqnucvwCtUS+EAAAA=
X-Change-ID: 20260712-sysfs-const-attr-dev_ext_attr-dbf669fdfd4e
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, 
 Yushan Wang <wangyushan12@huawei.com>, Jijie Shao <shaojijie@huawei.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788759912; l=2248;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=74OyWk+S1XapnZa91tZh7QGJ8Z65Zq0I4MGM9fNJNk4=;
 b=XvYmhK8g23TtkqqxN7yFFdmL3QKRYan/Vq1gOpl1Rbpx5vGwB2eFDVQ3yILkyDbE08ZBxinF5
 wad1OfZF2tjA5gvkgXhlADqWAri64DSYcu+XOo2XcNPH3zmUHKsUZII
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Prepare for the constification of 'struct dev_ext_attribute' instances
by changing the signature of the standard callback functions.
The first two patches prepare some drivers to handle both the const and
non-const callback variants.

Intended for the driver-core tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase on v7.3-rc1.
- Cover a few more drivers in drivers/perf/.
- Link to v1: https://patch.msgid.link/20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net

---
Thomas Weißschuh (3):
      x86/mce: Use __DEVICE_ATTR() macro to initialize dev_ext_attribute
      drivers: perf: Use __DEVICE_ATTR() macro to initialize dev_ext_attribute
      driver core: Constify the signature of device_show/store_*()

 arch/powerpc/perf/hv-24x7.c                 |  2 +-
 arch/x86/kernel/cpu/mce/core.c              |  6 +++---
 drivers/base/core.c                         | 30 ++++++++++++++---------------
 drivers/perf/alibaba_uncore_drw_pmu.c       |  2 +-
 drivers/perf/arm-cci.c                      |  2 +-
 drivers/perf/arm-ccn.c                      |  2 +-
 drivers/perf/arm_cspmu/arm_cspmu.h          |  2 +-
 drivers/perf/arm_dsu_pmu.c                  |  2 +-
 drivers/perf/arm_spe_pmu.c                  |  6 +++---
 drivers/perf/cxl_pmu.c                      | 10 +++++-----
 drivers/perf/fsl_imx8_ddr_perf.c            |  2 +-
 drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |  6 +++---
 drivers/perf/hisilicon/hns3_pmu.c           |  6 +++---
 drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 12 ++++++------
 drivers/perf/qcom_l3_pmu.c                  |  8 ++++----
 drivers/perf/starfive_starlink_pmu.c        |  2 +-
 drivers/perf/xgene_pmu.c                    |  2 +-
 include/linux/device.h                      | 14 +++++++-------
 21 files changed, 61 insertions(+), 61 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260712-sysfs-const-attr-dev_ext_attr-dbf669fdfd4e

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

