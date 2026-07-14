Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F64D98E6;
	Tue, 14 Jul 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047919; cv=none; b=a7zbAe0ROQMwsz/ks6ycHIevT/H8QdOI6G6OjhwyWRhkJ9ohvJ6LlsFQJzRKT7EQQ0X/pUnNT8QFnpncOcs5Q496ibr6xP/axAnIqm1zyGoOeUtPQjVjBnqnlNeH0muHA/ACr4J/RwGbFRu3O0KQm5tmV277QNIMRy2Q6TOFHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047919; c=relaxed/simple;
	bh=P8axtzlc26y5kWyEb7PWfrNrtHlna+IHi2EA6Xja4RU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JwEDcwErNwbBBzhVXOYfDzDm7J8G5pHc5jS4WX5tvvYA9ES5tQMDtG6sbnIYH2P3R3db8StafnCbePoKWB9VouhSWRspEImbUke1BzBodFuSBR6nP5AuhFA/nXjhYRE/j+9RJ9iKj66v9TUGG+7m2H/1UejGvaTwxh8/Jx0sqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fve7O5Vd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fve7O5Vd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784047914;
	bh=P8axtzlc26y5kWyEb7PWfrNrtHlna+IHi2EA6Xja4RU=;
	h=From:Subject:Date:To:Cc:From;
	b=fve7O5Vdo0KIs1MfkqxpEQn3B8brETbVkR2GMWxcSRtjnyMrrllrNZSFcVUyAKGfJ
	 +0MemZuGN2XsszgcG33WTOnzCWVhGwc0tsW7lp4iTH9ZjJH6ylUCl6axlnl64eOBgG
	 QHUVxyn/CcyexZdNguLoj0JIfv89MVc7IhxCP7b0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] driver core: Constify the signature of
 device_show/store_*()
Date: Tue, 14 Jul 2026 18:51:47 +0200
Message-Id: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMAwA0F+RnA1oGR3brwwRbRPNDnU0mTjEf
 183j+/ydlDKQgr3aodMq6gsqaCtKwjzkCZCicXgGueba+tQP8qKYUlqOJhljLT2tFl/YmTvbxw
 5XgjK8crEsv3/R3da3+OTgv1SOI4v7Q3lOoEAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784047913; l=1711;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=P8axtzlc26y5kWyEb7PWfrNrtHlna+IHi2EA6Xja4RU=;
 b=ygssrvOv1vOPr3lElItnO1Z5cofbIvqxZSp7zutH11/4nI7eNOB7qK2ICFH8O4iBEF8Ffq26R
 SSBn+MlIBpABIIOgUqelEMPj402hGe/Kyp7J89f+xIgEOUpE3i2ZbqC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Prepare for the constification of 'struct dev_ext_attribute' by changing
the signature of the standard callback functions.

Intended for the driver-core tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      x86/mce: Use __DEVICE_ATTR() macro to initialize dev_ext_attribute
      drivers: perf: Use __DEVICE_ATTR() macro to initialize dev_ext_attribute
      driver core: Constify the signature of device_show/store_*()

 arch/powerpc/perf/hv-24x7.c                 |  2 +-
 arch/x86/kernel/cpu/mce/core.c              |  6 +++---
 drivers/base/core.c                         | 30 ++++++++++++++---------------
 drivers/perf/arm-cci.c                      |  2 +-
 drivers/perf/arm-ccn.c                      |  2 +-
 drivers/perf/arm_cspmu/arm_cspmu.h          |  2 +-
 drivers/perf/arm_dsu_pmu.c                  |  2 +-
 drivers/perf/cxl_pmu.c                      | 10 +++++-----
 drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |  6 +++---
 drivers/perf/hisilicon/hns3_pmu.c           |  6 +++---
 drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 12 ++++++------
 drivers/perf/qcom_l3_pmu.c                  |  8 ++++----
 drivers/perf/xgene_pmu.c                    |  2 +-
 include/linux/device.h                      | 14 +++++++-------
 17 files changed, 55 insertions(+), 55 deletions(-)
---
base-commit: 1160c2208fab4eaf4a32d738f83474c32c3a6944
change-id: 20260712-sysfs-const-attr-dev_ext_attr-dbf669fdfd4e

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

