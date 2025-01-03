Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446D17BB32;
	Fri,  3 Jan 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906073; cv=none; b=TX02mapLq6VHGhSQqSyIDoyllQPl+A+ThxrZqmXgjkCxSH0xCQrfo729BSjPoEiM7yfeHttUmbJUr5RdZOMDVO6nnPGL4Dhj8KvT0ne2BGjRwC0wXfO7gYtfOEFEfIXobvzdq8Jf9fJeJkq2U8mG2q7CdD33Xx0qJuBkgF/Mdj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906073; c=relaxed/simple;
	bh=KA65K9oldX72y8XHUViwdsk03n7uOn+TyfsVZ96bb1s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kli5gctcLGRlidMFd2ckuB/n53YzrR8SanvPhgKXKHy4LG8KfYPbtptl47XJcDeGUiLvBAIRUtHCV/DrdiNWFQiTaBXZflg/Bes045yyQPzs9zMBJIWmxwfuKYu0UIAd41TjZCPhvQwqQzwXXpfN1VPzPEN3qk2SZxvDwDvCW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPj3y60NSz6K5wl;
	Fri,  3 Jan 2025 20:06:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FD80140C98;
	Fri,  3 Jan 2025 20:07:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 Jan
 2025 13:07:45 +0100
Date: Fri, 3 Jan 2025 12:07:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Neeraj Kumar <s.neeraj@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <tongtiangen@huawei.com>, Yicong Yang
	<yangyicong@huawei.com>, Niyas Sait <niyas.sait@huawei.com>,
	<ajayjoshi@micron.com>, Vandana Salve <vsalve@micron.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Gregory Price <gourry@gourry.net>, Huang
 Ying <ying.huang@intel.com>, Vishak G <vishak.g@samsung.com>, Krishna Kanth
 Reddy <krish.reddy@samsung.com>, "Alok Rathore" <alok.rathore@samsung.com>,
	<gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/4] cxl: Register devices for CXL Hotness
 Monitoring Units (CHMU)
Message-ID: <20250103120744.00006abc@huawei.com>
In-Reply-To: <1983025922.01735899782509.JavaMail.epsvc@epcpadp2new>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
	<20241121101845.1815660-2-Jonathan.Cameron@huawei.com>
	<CGME20250103052421epcas5p4a1a917ba5d367dfccec91d4522666ca0@epcas5p4.samsung.com>
	<1983025922.01735899782509.JavaMail.epsvc@epcpadp2new>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

> >diff --git a/drivers/cxl/hmu.h b/drivers/cxl/hmu.h
> >new file mode 100644
> >index 000000000000..c4798ed9764b
> >--- /dev/null
> >+++ b/drivers/cxl/hmu.h
> >@@ -0,0 +1,23 @@
> >+/* SPDX-License-Identifier: GPL-2.0-only */
> >+/*
> >+ * Copyright(c) 2024 Huawei
> >+ * CXL Specification rev 3.2 Setion 8.2.8 (CHMU Register Interface)
> >+ */
> >+#ifndef CXL_HMU_H
> >+#define CXL_HMU_H
> >+#include <linux/device.h>  
> 
> No compilation errors even by removing this header.
> I think this inclusion is not required.
> Also found similar include at drivers/cxl/pmu.h

Kernel generally follows include what you use principles to avoid
future issues due to reorganization of headers etc.

Here struct device definition is needed below so this header should be
included.  If there are other cases that do not do this, they should
be fixed (there are ongoing efforts to clean this up btw by adding the
missing includes).

> 
> >+
> >+#define CXL_HMU_REGMAP_SIZE 0xe00 /* Table 8-32 CXL 3.0 specification */  
> 
> Above Macro CXL_HMU_REGMAP_SIZE is not used, So we should remove it.
> Its comment is also not appropriate

Not sure on the comment being in appropriate but sure this define can 
go away (and the comment with it).

Thanks for taking a look.

Jonathan


