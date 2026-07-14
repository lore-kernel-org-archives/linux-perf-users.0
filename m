Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412914D90CF;
	Tue, 14 Jul 2026 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047921; cv=none; b=BLzWlBYPwEneRhWJhFGnW/y5Eh91kg18iUAYqXTZ0jCPe6fG0Y7EnUTeBh4oTYjoIuHLMc9itZQpnc0bJrhCz2zmiOqh198e8wE1VGOYWpdlvo63O2zCiEjL1otRGYPZQ2r3LdhfJWlp6WbDt40uPJGRxK15XhEhTMmYtTZZUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047921; c=relaxed/simple;
	bh=y+nMsMtnPzeoRMm6XOGdcqLiE1JJKdTJFdXgVfqhtcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EwUUPNJqa6zmAHjAT/2xSETCTcp4QDJWiYWpeDBctPsDRMei9pBWTrxOIOtN4nYDRCSPiStsktiu2G83qbqfJ50LOgStWzRqUvp9JPiIrsZYPjkzpnBN4/SgIJ6s8C68/m6bNQnPgQJWpVdbtEeh4AlXvVIUZLKUDWkv1kLwYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AfRCxkVh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AfRCxkVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784047914;
	bh=y+nMsMtnPzeoRMm6XOGdcqLiE1JJKdTJFdXgVfqhtcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AfRCxkVhMPXaeJ4X2pakjBoLYVMtENgqh6kslhbd+3AQg3WfIGgBcX2hDtINAVg+v
	 Hw6tnma1FmLBkiT/Ldj7crCME1oCD5BjCY6CJbbzBhJYmNVDVsdn5FyukoGu1QvVSV
	 BKkbdrDrb2bAHn8Ii1Z7+wIuZQYUY5Pu5/df8wFo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 14 Jul 2026 18:51:50 +0200
Subject: [PATCH 3/3] driver core: Constify the signature of
 device_show/store_*()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-sysfs-const-attr-dev_ext_attr-v1-3-6b2c0435d621@weissschuh.net>
References: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
In-Reply-To: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784047913; l=5833;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=y+nMsMtnPzeoRMm6XOGdcqLiE1JJKdTJFdXgVfqhtcg=;
 b=CE/PLEPjEk9Clk2ILAqAI/VCFiwwgxAk66fuzdwrBCBYf62zj4nI5gb6xVcT3JfCfpR44koSU
 BdRAPrwT0zcBc20cdAFo7P5079v7q7Z6w6civBd2ZOcqPBwj5qITrGA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Prepare for the constification of 'struct dev_ext_attribute' by changing
the signature of the standard callback functions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/perf/hv-24x7.c |  2 +-
 drivers/base/core.c         | 30 +++++++++++++++---------------
 include/linux/device.h      | 14 +++++++-------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index abb4cfb11fcc..c0abac00e026 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -462,7 +462,7 @@ static struct attribute *device_str_attr_create_(char *name, char *str)
 	attr->var = str;
 	attr->attr.attr.name = name;
 	attr->attr.attr.mode = 0444;
-	attr->attr.show = device_show_string;
+	attr->attr.show_const = device_show_string;
 
 	return &attr->attr.attr;
 }
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d026682944f..649b8a126920 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2513,13 +2513,13 @@ static const struct sysfs_ops dev_sysfs_ops = {
 	.store	= dev_attr_store,
 };
 
-#define to_ext_attr(x) container_of(x, struct dev_ext_attribute, attr)
+#define to_ext_attr(x) container_of_const(x, struct dev_ext_attribute, attr)
 
 ssize_t device_store_ulong(struct device *dev,
-			   struct device_attribute *attr,
+			   const struct device_attribute *attr,
 			   const char *buf, size_t size)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 	int ret;
 	unsigned long new;
 
@@ -2533,19 +2533,19 @@ ssize_t device_store_ulong(struct device *dev,
 EXPORT_SYMBOL_GPL(device_store_ulong);
 
 ssize_t device_show_ulong(struct device *dev,
-			  struct device_attribute *attr,
+			  const struct device_attribute *attr,
 			  char *buf)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 	return sysfs_emit(buf, "%lx\n", *(unsigned long *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_ulong);
 
 ssize_t device_store_int(struct device *dev,
-			 struct device_attribute *attr,
+			 const struct device_attribute *attr,
 			 const char *buf, size_t size)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 	int ret;
 	long new;
 
@@ -2562,19 +2562,19 @@ ssize_t device_store_int(struct device *dev,
 EXPORT_SYMBOL_GPL(device_store_int);
 
 ssize_t device_show_int(struct device *dev,
-			struct device_attribute *attr,
+			const struct device_attribute *attr,
 			char *buf)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 
 	return sysfs_emit(buf, "%d\n", *(int *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_int);
 
-ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
+ssize_t device_store_bool(struct device *dev, const struct device_attribute *attr,
 			  const char *buf, size_t size)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 
 	if (kstrtobool(buf, ea->var) < 0)
 		return -EINVAL;
@@ -2583,19 +2583,19 @@ ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
 }
 EXPORT_SYMBOL_GPL(device_store_bool);
 
-ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_bool(struct device *dev, const struct device_attribute *attr,
 			 char *buf)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 
 	return sysfs_emit(buf, "%d\n", *(bool *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
 ssize_t device_show_string(struct device *dev,
-			   struct device_attribute *attr, char *buf)
+			   const struct device_attribute *attr, char *buf)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 
 	return sysfs_emit(buf, "%s\n", (char *)ea->var);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 7b2baffdd2f5..61e2b98b38a4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -127,19 +127,19 @@ struct dev_ext_attribute {
 	void *var;
 };
 
-ssize_t device_show_ulong(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_ulong(struct device *dev, const struct device_attribute *attr,
 			  char *buf);
-ssize_t device_store_ulong(struct device *dev, struct device_attribute *attr,
+ssize_t device_store_ulong(struct device *dev, const struct device_attribute *attr,
 			   const char *buf, size_t count);
-ssize_t device_show_int(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_int(struct device *dev, const struct device_attribute *attr,
 			char *buf);
-ssize_t device_store_int(struct device *dev, struct device_attribute *attr,
+ssize_t device_store_int(struct device *dev, const struct device_attribute *attr,
 			 const char *buf, size_t count);
-ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_bool(struct device *dev, const struct device_attribute *attr,
 			char *buf);
-ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
+ssize_t device_store_bool(struct device *dev, const struct device_attribute *attr,
 			 const char *buf, size_t count);
-ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_string(struct device *dev, const struct device_attribute *attr,
 			   char *buf);
 
 typedef ssize_t __device_show_handler_const(struct device *dev, const struct device_attribute *attr,

-- 
2.55.0

