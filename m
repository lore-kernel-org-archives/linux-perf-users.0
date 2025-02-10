Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BE25E463;
	Mon, 10 Feb 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216066; cv=none; b=Ghlyhf38Fw0XFEGN3CyelUAFukfPEo8meayhPfbnAgOTCwB+nfviPI9kqTzZL+7FXVp/rkH4JNCO7IBuba3HHuEglCCkqzfp21k8fi9k5ZdbKMuveFdDBewKxe/ZJAv9HR+LGAeLe+bcZp+DXW5ZdchfOlg92CfR+KOyaeXG29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216066; c=relaxed/simple;
	bh=E3Ox3+LSPCyck3Fm5/8Q6aMkRcAj9VBKEg4cAOnPsOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LLY5I0cry8KgUTXxZCDFUzz8Apdm1lBbiouQSzsBAb9xDhW+W949raRZE0NVmW6sn3/JYA33rNn0fiwCArOoM1eFKLd/nXliJfW4WIuXMBzEwy8mfH0lsSVWl90ObfEeLdvhYH4s9+H3XRERtUHk+SHOwaOoyS2WVli7jf75i5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLgs4VWW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLgs4VWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739216065; x=1770752065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E3Ox3+LSPCyck3Fm5/8Q6aMkRcAj9VBKEg4cAOnPsOA=;
  b=SLgs4VWWhgWV1FPqHLKO8Yvsg1BIy2Fsz/cHa1hTmihvYyafq7zuvswG
   3bQCyOrRSHbXf2wtJoUzE0NiMw6Wc/lmLJq0zwmaYliZVpTR2Gd2wIZno
   xJV6ry5BcH6FsaHE0uhMFMWxuKWMo8ViH26cFwP1AXPTmujc9MdfmrDTI
   o3YGgvVhRKMj7h/GcB9uqTlgkGakybQBLwj92+ZAszmt/ch/XTtpuTcCc
   n77oXEGxGAQuN8wHmwt6poIGYuRx610ynecLLmeqc4Bf4xRhKIUpQvgVU
   ReJPKAqWOc+T3ew71eyvapF1KPL4JoufwqiNoAlcEbVc+gGGlbRNS3Klg
   Q==;
X-CSE-ConnectionGUID: OJSk48O/Shar+i9AELv9Ow==
X-CSE-MsgGUID: HrrXFZAYQlaNdfIvKvhIvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50444660"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="50444660"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 11:34:23 -0800
X-CSE-ConnectionGUID: LuYOOZnCSXG2B3V10yWyNA==
X-CSE-MsgGUID: lBW2ek2DSUuLxeyAIYsl9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="112506393"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 10 Feb 2025 11:34:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1B2242F2; Mon, 10 Feb 2025 21:34:17 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v1 1/1] x86/events/amd/iommu: Increase IOMMU_NAME_SIZE
Date: Mon, 10 Feb 2025 21:34:12 +0200
Message-ID: <20250210193412.483233-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The init_one_iommu() takes an unsigned int argument that can't be checked for
the boundaries at compile time and GCC complains about that when build with
`make W=1`:

arch/x86/events/amd/iommu.c:441:53: note: directive argument in the range [0, 4294967294]
arch/x86/events/amd/iommu.c:441:9: note: ‘snprintf’ output between 12 and 21 bytes into a destination of size 16

Increase the size to cover all possible cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/events/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index b15f7b950d2e..f8228d8243f7 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -30,7 +30,7 @@
 #define GET_DOMID_MASK(x)  (((x)->conf1 >> 16) & 0xFFFFULL)
 #define GET_PASID_MASK(x)  (((x)->conf1 >> 32) & 0xFFFFFULL)
 
-#define IOMMU_NAME_SIZE 16
+#define IOMMU_NAME_SIZE 24
 
 struct perf_amd_iommu {
 	struct list_head list;
-- 
2.45.1.3035.g276e886db78b

