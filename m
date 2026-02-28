Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E83E33B6C7;
	Sat, 28 Feb 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289995; cv=none; b=L+ChogIDHBGYTaWWSt93MA6CXc1rHpFnIakeCb3+Z2JgSVvzaeGfWdEqNZLb8udm4eg8Zj5jKVFLgTWMcN4mf9aQaxJKYTyuRF/jQeFUdxxqg2EyKSQNlSm4Bna0hmFLuBIr8/Xz/U5rpPWG1QU5DeB/vfR+OaHUxWGr+h0zOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289995; c=relaxed/simple;
	bh=I02qRJ6CpvImE+6y6tAC/KFMdUum9tMYeupGFSqc0RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjDrI8jz0l7ztF31eJhx7Ol7cBjQEUf0EqoQZAM1u2CkX7IsN6ITs5Hd4DoolUNfWAlWhb3BZiOGayIKoWRir4VsTFRPgNXu4wzwaegdRlVqraPbHgNx99xW+rWHeF4Ufkxz7aXUFW43gnQb/ZTjE9Difwxsl0BETYZsUkHMYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=gdSc5HI7; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="gdSc5HI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772289929;
	bh=GbOAkjn6laTptkSnh6XYJm2aHQrZmXs7grRbKjhgjdw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gdSc5HI7LDK3UoM+wIMhm4LwJknpbJQQHeQrUC2KeFhjfEtum6UiQJiblyk85mXra
	 4eQuUAc2MWGlAHdHWvS2zB0B4oa5542klzcZRXtnJhVpkLaM+fmAllP0q6Ltysix+2
	 Y/yxEPI1ZGLpDBhAwna3G65Uyq6UP3tsvoh9F/oM=
X-QQ-mid: zesmtpgz5t1772289928t9a451ff3
X-QQ-Originating-IP: 1rBRZBiZfVmJkN3GwwUCdLX2pFtsVXUihEV0i1hxCjE=
Received: from SurfaceBook2-B.localdomain ( [183.193.112.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 22:45:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 99386155817105120
EX-QQ-RecipientCnt: 33
From: Lv Zheng <lv.zheng@linux.spacemit.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zong Li <zong.li@sifive.com>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/8] iommu/riscv: Add vendor event support for RISC-V IOMMU HPM
Date: Sat, 28 Feb 2026 22:45:22 +0800
Message-ID: <B63F9FC1F921CE76+4772dfad6fadfae95bafccf306187cda595498ce.1772289741.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
References: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Odky5wNUcHo/fvP/5aC0Yt1uajpBQXvRIyb4OVM0bTjQlMHypFWgC+Qs
	LKhAnpk4iOwlSfvEjCVmLnsE0ZcrRznCoH5TNKm5QEuX487mBC3x3g4N390qIfzJqw3Hvla
	q2A/0KV+ODyhiYXqAo+Z3zKVTKptLi6fETWNKk63mzE89fvv6DWWUA9+KaakNO7en52EktL
	RwwM+BXdI5Tui1HSoOE9gtsc9J7uldnhspQrYbNXaY2DzQYtO5Ob97+VBv+L1o4WIKCtpmW
	4ek8faKVBgkUFXvbdtq9UheshL/uE1l5WRVQ7ILY3o+7V3rWFyJTJyyQvxNgMDT/eM6BZ9F
	7TLs0kCl6qHaYi68lQFj3Pbcg1QKtT1FVEB35pQ8c0r0G5vVpXATk1Dt7afYW6zu6M01h11
	Hka7E55EYBSciXOnHIVGd8X9NmxQHSBwfS8cx0lQTGUA2mKDAnsqYQuAC+d59Bp5FpDabt5
	vijYWx+vnqRk4tzfz2X1V9BKko54//2mJ5iWvgjY0vhsmK6xk3iqI9hitTcoOcDZJwR1OXq
	2EvGapJo+H9BOQFwI86W9cLQuZK4iNrqt+0Q1ANb0rcDt0To4hccs2uoJh1cg6U8YpyAb9m
	K18yfknjSZhZVRFCdLedHM2GHMhWN0KeI/t4FulXVht1/SyFYM+d2iUh40szQSPK0w7bJFf
	XrrarKSopkxZhw0fNH71JyzguxRwf2F9UzBjiob+uq5SXriDWkXS9qZbvdKyTA+xO0C2C1w
	NIAnR81fO+nF2CXjfkPxZWS8g7HSArl8O9YDYx6S6ZIqnMqnmSVYx10Ukk4SPpjMIPBE3Gb
	JYLtBsL7lEwC+kttMRpFzLmzqR+gyGCAtEyd+e9IcAEooQnVqTiaPhloXUvQENq6lNawtOD
	9OL5uT+DeY+ValHFVnq5s4fIsnpHbi3l17ZQGDVjPvgFPZR6cqTqn3HSogc7FEK3Mh5V8L8
	R4Ft/CsAmgXBVByuEVzSWGRh24BiUyK3oNfpwGTUM/F6iFZHghaKGCkRJmU63Mzs90ZQRJG
	tv4Rdk1XbLGWDbCZbMks7DBzv5EqdlUXDPB7ogQw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Add a mechanism to allow vendor events to be registered via userspace
jevents. The PMU exposes an "identifier" sysfs attribute derived from the
device tree compatible string (e.g. "spacemit,t100" or "riscv,iommu"),
which perf's jevents uses to match JSON event definitions to the PMU.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu.c    | 29 +++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h    |  2 ++
 drivers/perf/riscv_iommu_hpm.c | 22 +++++++++++++++++++++-
 include/linux/riscv_iommu.h    |  2 ++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e10011493228..b8a0542ad5d4 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1664,6 +1664,7 @@ static int riscv_iommu_subdev_add(struct riscv_iommu_device *iommu,
 	subdev->base = params->base;
 	subdev->iommu = iommu;
 	subdev->info = params->info;
+	subdev->identifier = params->identifier;
 
 	auxdev = &subdev->auxdev;
 	auxdev->name = params->name;
@@ -1701,6 +1702,32 @@ static int riscv_iommu_subdev_add(struct riscv_iommu_device *iommu,
 	return ret;
 }
 
+/* Compatible strings that serve as PMU identifier for userspace jevents */
+static const char *const riscv_iommu_hpm_identifiers[] = {
+	"spacemit,t100",
+	"riscv,iommu",
+};
+
+static const char *riscv_iommu_get_hpm_identifier(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	int i, ret;
+
+	if (!np)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(riscv_iommu_hpm_identifiers); i++) {
+		ret = of_property_match_string(np, "compatible",
+					       riscv_iommu_hpm_identifiers[i]);
+		if (ret >= 0)
+			return devm_kstrdup(dev,
+					    riscv_iommu_hpm_identifiers[i],
+					    GFP_KERNEL);
+	}
+
+	return NULL;
+}
+
 static void riscv_iommu_enumerate_hpm(struct riscv_iommu_device *iommu)
 {
 	struct riscv_iommu_hpm_info *hpm_info;
@@ -1728,6 +1755,7 @@ static void riscv_iommu_enumerate_hpm(struct riscv_iommu_device *iommu)
 		.name = "riscv_iommu_hpm",
 		.info = hpm_info,
 		.base = iommu->reg + RISCV_IOMMU_REG_IOCOUNTOVF,
+		.identifier = riscv_iommu_get_hpm_identifier(iommu->dev),
 	};
 
 	if (of_device_is_compatible(iommu->dev->of_node, "spacemit,t100")) {
@@ -1822,6 +1850,7 @@ static void riscv_iommu_enumerate_ioatc(struct riscv_iommu_device *iommu)
 			.name = "spacemit_ioatc_hpm",
 			.info = ioatc_info,
 			.base = base + RISCV_IOMMU_REG_IOCOUNTOVF,
+			.identifier = riscv_iommu_get_hpm_identifier(iommu->dev),
 		};
 
 		ret = riscv_iommu_subdev_add(iommu, &params);
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index f1bb682dd478..7f34c1bbfe25 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -74,11 +74,13 @@ struct riscv_iommu_device {
  * @name: auxiliary device name
  * @info: device-specific info, freed in release
  * @base: PMU register base
+ * @identifier: perf PMU identifier for JSON Compat matching
  */
 struct riscv_iommu_subdev_params {
 	const char *name;
 	void *info;
 	void __iomem *base;
+	const char *identifier;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
diff --git a/drivers/perf/riscv_iommu_hpm.c b/drivers/perf/riscv_iommu_hpm.c
index b166b3cb6d4f..fdc18affbe02 100644
--- a/drivers/perf/riscv_iommu_hpm.c
+++ b/drivers/perf/riscv_iommu_hpm.c
@@ -88,6 +88,7 @@ struct riscv_iommu_hpm {
 	unsigned int irq;
 	unsigned int on_cpu;
 	bool global_filter;
+	const char *identifier;
 	struct hlist_node node;
 	/*
 	 * Layout of events:
@@ -664,8 +665,24 @@ static ssize_t riscv_iommu_hpm_global_filter_show(struct device *dev,
 static struct device_attribute riscv_iommu_hpm_global_filter_attr =
 	__ATTR(global_filter, 0444, riscv_iommu_hpm_global_filter_show, NULL);
 
+static ssize_t riscv_iommu_hpm_identifier_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct riscv_iommu_hpm *hpm = dev_get_drvdata(dev);
+
+	if (!hpm->identifier)
+		return 0;
+
+	return sysfs_emit(buf, "%s\n", hpm->identifier);
+}
+
+static struct device_attribute riscv_iommu_hpm_identifier_attr =
+	__ATTR(identifier, 0444, riscv_iommu_hpm_identifier_show, NULL);
+
 static struct attribute *riscv_iommu_hpm_vendor_attrs[] = {
 	&riscv_iommu_hpm_global_filter_attr.attr,
+	&riscv_iommu_hpm_identifier_attr.attr,
 	NULL
 };
 
@@ -891,6 +908,7 @@ static int riscv_iommu_hpm_probe(struct auxiliary_device *auxdev,
 
 	hpm->subdev = subdev;
 	hpm->base = subdev->base;
+	hpm->identifier = subdev->identifier;
 	hpm->on_cpu = raw_smp_processor_id();
 	hpm->irq = info->irq;
 	hpm->global_filter = info->global_filter;
@@ -914,7 +932,9 @@ static int riscv_iommu_hpm_probe(struct auxiliary_device *auxdev,
 	attr_grps = is_ioatc ? riscv_iommu_hpm_ioatc_attr_grps :
 			       riscv_iommu_hpm_attr_grps;
 
-	hpm_name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
+	/* jevents name: auxdev->name + "_" + auxdev->id */
+	hpm_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%u", auxdev->name,
+				  auxdev->id);
 	if (!hpm_name)
 		return -ENOMEM;
 
diff --git a/include/linux/riscv_iommu.h b/include/linux/riscv_iommu.h
index 71a961731c22..d21d89251ed5 100644
--- a/include/linux/riscv_iommu.h
+++ b/include/linux/riscv_iommu.h
@@ -24,6 +24,7 @@ struct riscv_iommu_device;
  * @base: PMU register base
  * @iommu: parent IOMMU (opaque)
  * @info: subdevice-specific info, freed in release
+ * @identifier: Vendor identifier for userspace jevent
  */
 struct riscv_iommu_subdev {
 	struct list_head link;
@@ -31,6 +32,7 @@ struct riscv_iommu_subdev {
 	void __iomem *base;
 	struct riscv_iommu_device *iommu;
 	void *info;
+	const char *identifier;
 };
 
 /**
-- 
2.43.0

