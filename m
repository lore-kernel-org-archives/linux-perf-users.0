Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E936EAA7;
	Thu,  5 Feb 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282712; cv=none; b=u6lIWeq9JthgEJwxkj2r3Ps3mrw14gW6jwOrWIqZkdE5hBzYxLvmklFp1SJD5frXMdpwRQRxVwLJGVqlmjfA3iAkjNrr1eWGK6ct1y8vjbGX6OtvCxe+UN3NVX3GvBO1Bjaq61xfXLmQWF8F7dHfSBNdBHiS/e0dj7OjLHD8Lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282712; c=relaxed/simple;
	bh=zuHjMyPXHPdxxW46nAc61syCpAqkEeuD5lusiZdCPgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6m/ZH1U7ZfpASH0d+uEr7C4ySp5MNH0Mgu9dvaFTbT61bHNNcF1Eb9d3HA/pzNOthCiGJSieyirl9i7orVeHBLEUmSXJKdyuA+/R+nYt38FxxYOse/Ff3zAj7+4nI9rR1HFywZ7biToyWiaBG7oeTW15l2EUcAdW48rsypLr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=fvOuQhyo; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="fvOuQhyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770282659;
	bh=VHjIDDa6NWq53y9Nca1m6Txf2KFKP1m6ZhkSL3s92vo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fvOuQhyorYAKCHfnSoeuEtrYPPeLCa8tbZ6Sk2nix2q2lUqsOCowNhvjNzCdidMsK
	 TGANMi+GIwAOWoAqq17rkPeE5FxuPPnuvQ8glDlI+rwvmCmXOxkGyxKnFQQhdr1ukd
	 D9CGUS3O/6z2IAv2vGoG2yDClCHbGqfXpHt7qvw0=
X-QQ-mid: esmtpgz15t1770282658t67abc38d
X-QQ-Originating-IP: PWcwMXHfPU6D+9OfCYZaXoiyeDhdI4y7+BNQfv/6mvI=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Feb 2026 17:10:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13911501969854134547
EX-QQ-RecipientCnt: 19
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v4 4/7] iommu/riscv: Add vendor event support for RISC-V IOMMU HPM
Date: Thu,  5 Feb 2026 17:10:53 +0800
Message-ID: <17ADCFC5ACF772A6+7c69dba6df8eb79aa3eb11781518a47143033b1e.1770281596.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770281596.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770281596.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MRiFTjyIbtS1KK1EQQOKZQfCeu9NZge1g/BCYbotSDLhgdo4pbGOKqlw
	4L2fccsQoP0MLso0YSgpDlMyTIu3zlqUgDKnKsEIc/chuH3y9FjmhirvLu5Hrl4+tzJac/2
	KfZq39Z70cMhCAZzfcylIM54dcU6erghiD14tp/4Lvc1PBnUFyhIfv3IzffvDFVKDlrbff4
	LzeBF6lWKM8QdLmI5eamgO9q8245S8X0x/EFhcbX15V2QEDRB+FRpQLd1PYMVxFGze+0knw
	JBrlT2Ual26TqDzKc0KsIJpuSGi50qHb0GxJP/0ISjhMq5xdgs1DsYQ6+P4Xz7W+JgxZrUv
	0m+E17yCpKspnNBVYYa6R6Ca4hoHr54FLtlhVcMGC+gN2iLbaFTWB7AWO6Og0piLRZBewDV
	NrZtYHxjn5qFp4P8BWEHD9BMqteUxdpkBK/rO0ftpSru6owz4C37KGFG7nsm9KMT6kY6RKT
	svia79Y8RkoikQ5w+/jiWuZOC4LtN2RkXsIugDW1YxklGu/7Y9gcinm8gjhGlfg6JYcc2Bh
	fmzE95ka0fYAh4caWCBasMEkqXyWkqJmZyoyva8ZwZ1a7qq3t/hSVDl8fmIz2q1E+fzd1dr
	vNx+UicK7/uHP1/93pbNwcZ/2e1c3auXMJv1/DvyDJ5+JvqHgCGGLBp38pZubqV9k2S8pfb
	m9tH15/eXh6rnW+OBg73GtHwLxIIiFj6QDrZ0FU+TPd7YbTsM/AhKMHeNO25g1KwMqnSNVt
	V93WTJrWHkTX9MrU7WbxGGXWxgNqUe+ZgUac8V88NPDrAG5B6c1dKwROZalDghplxLkgd1+
	8EedcA0cx81EVzOvG3Ndi3rIfdv3KQHihRQpY+R3qZVCJCr2dpgsc+dI1pRwBzSkkuR5In3
	bRTKUEFa4PEw7ijrT5G/IwTg1QnodhbkO5xdnfDqBB2xWdtMD8KISP/1reQNSsttPBJCWFL
	J/yJ98fzWnf5hcAokW4/f5CC/WZT4Bt/odhPqB5LaUm7B3yWojIjmW9J7XU/ig1aFga2OfE
	dnmYHsTrGN9B/9lQ92V3nUVdh/HskizwtYWLn+WyXrPJ60Ukyb1U4XNAzNG7xzkbdcpTHW7
	w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Adds mechanism to allow vendor events to be registered via userspace
jevents. By default, vendor event identifier matches "riscv,iommu", and
the events are registered as "riscv_iommu_hpm" events.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu-hpm.c | 63 +++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h     |  1 +
 2 files changed, 64 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-hpm.c b/drivers/iommu/riscv/iommu-hpm.c
index fe51f60c0c75..4615c4b161a0 100644
--- a/drivers/iommu/riscv/iommu-hpm.c
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -443,6 +443,30 @@ static const struct attribute_group riscv_iommu_hpm_cpumask_group = {
 	.attrs = riscv_iommu_hpm_cpumask_attrs,
 };
 
+static ssize_t riscv_iommu_hpm_identifier_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct riscv_iommu_hpm *iommu_hpm = to_iommu_hpm(dev_get_drvdata(dev));
+
+	if (!iommu_hpm->identifier)
+		return 0;
+
+	return sysfs_emit(buf, "%s\n", iommu_hpm->identifier);
+}
+
+static struct device_attribute riscv_iommu_hpm_identifier_attr =
+	__ATTR(identifier, 0444, riscv_iommu_hpm_identifier_show, NULL);
+
+static struct attribute *riscv_iommu_hpm_identifier_attrs[] = {
+	&riscv_iommu_hpm_identifier_attr.attr,
+	NULL
+};
+
+static const struct attribute_group riscv_iommu_hpm_identifier_group = {
+	.attrs = riscv_iommu_hpm_identifier_attrs,
+};
+
 #define IOMMU_HPM_EVENT_ATTR(name, config)		\
 	PMU_EVENT_ATTR_ID(name, riscv_iommu_hpm_event_show, config)
 
@@ -518,6 +542,7 @@ static const struct attribute_group *riscv_iommu_hpm_attr_grps[] = {
 	&riscv_iommu_hpm_cpumask_group,
 	&riscv_iommu_hpm_events_group,
 	&riscv_iommu_hpm_format_group,
+	&riscv_iommu_hpm_identifier_group,
 	NULL
 };
 
@@ -620,6 +645,36 @@ static void riscv_iommu_hpm_reset(struct riscv_iommu_hpm *iommu_hpm)
 	riscv_iommu_hpm_interrupt_clear(iommu_hpm);
 }
 
+static bool riscv_iommu_hpm_is_identifier_compat(const char *compat)
+{
+	return !strcmp(compat, "riscv,iommu");
+}
+
+static const char *riscv_iommu_hpm_get_identifier(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	const char *compat;
+	int count, i;
+
+	if (!np)
+		return NULL;
+
+	count = of_property_count_strings(np, "compatible");
+	if (count <= 0)
+		return NULL;
+
+	for (i = 0; i < count; i++) {
+		if (of_property_read_string_index(np, "compatible",
+						  i, &compat))
+			continue;
+
+		if (riscv_iommu_hpm_is_identifier_compat(compat))
+			return devm_kstrdup(dev, compat, GFP_KERNEL);
+	}
+
+	return NULL;
+}
+
 static void riscv_iommu_hpm_set_standard_events(struct riscv_iommu_hpm *iommu_hpm)
 {
 	/* Cycles counter is always supported */
@@ -646,6 +701,7 @@ static void riscv_iommu_hpm_remove(void *data)
 static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 					 struct riscv_iommu_hpm *iommu_hpm,
 					 u32 offset, int irq,
+					 const char *identifier,
 					 const struct attribute_group **attr_groups,
 					 const char *prefix)
 {
@@ -659,6 +715,7 @@ static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 	unique_id = atomic_fetch_inc(&riscv_iommu_hpm_ids);
 	memset(iommu_hpm, 0, sizeof(*iommu_hpm));
 	iommu_hpm->iommu = iommu;
+	iommu_hpm->identifier = identifier;
 
 	if (offset + RISCV_IOMMU_REG_SIZE <= iommu->reg_size)
 		base = iommu->reg + offset;
@@ -788,6 +845,7 @@ static void riscv_iommu_hpm_exit(void)
 int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
 {
 	struct device *dev = iommu->dev;
+	const char *identifier;
 	int irq, rc;
 
 	if (!FIELD_GET(RISCV_IOMMU_CAPABILITIES_HPM, iommu->caps)) {
@@ -806,7 +864,12 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
 	if (rc < 0)
 		return rc;
 
+	identifier = riscv_iommu_hpm_get_identifier(dev);
+	if (identifier)
+		dev_info(dev, "HPM: Vendor identifier: %s\n", identifier);
+
 	rc = riscv_iommu_hpm_register_unit(iommu, &iommu->hpm, 0, irq,
+					   identifier,
 					   riscv_iommu_hpm_attr_grps,
 					   "riscv_iommu_hpm");
 	if (rc < 0)
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 0ad9f5cad4de..d3c11abef5cf 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -41,6 +41,7 @@ struct riscv_iommu_hpm {
 	int irq;
 	int on_cpu;
 	struct hlist_node node;
+	const char *identifier;
 	/*
 	 * Layout of events:
 	 * 0       -> HPMCYCLES
-- 
2.43.0

