Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8C35C68E;
	Fri,  9 Oct 2026 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512667; cv=none; b=Gh8WWkayxtyamnHxcXqTdxWsJcyjV93rdGNsjnmnJebrEiLYs6YE0FiPiiH8ctd+z6Bg2xMgsaRR1S2+S03BfSF57SAFmyrUNX/xrJERVDmeZ/OdQCOLmqGPaChnSjq3MfEecNhzggfdNDVHnFjETYN/O3O9W9g0PDDJ6OPRkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512667; c=relaxed/simple;
	bh=jYnTLWQ3LoGxPB2ilYylVuoXr4yMy0414CZwFBR7AHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW/oQ+bgUcXqezmEXg4mGUtCVX/Mx2+if9axZNod61EgCxAU5A+V0CzUhQlhLKdZZqCCXknlu3dCq6UfIQV5nTzEefQuuzyhRcJ+8Uc4MHCN+IQF0kOUEkE1BXzqfYZSw2MdFNVg5vbf54WsOMmBLtH7/YMqkysl9m/nW5m5Noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v3ajY/sc; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v3ajY/sc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791512662; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=/CQiZoAkKnBrmHzjwfjOfcRl2oGn50xKlECwPsQSc+g=;
	b=v3ajY/scW/kosmpygs6n2A41z/TrmXbCfa+Y3OVUlQJPIkx9OcW2jggbadCfTcMf9m7N1gTBFKmZpDyPaiKBFLteHXujJJYeygvG8NAMAu0tir71NIAqvrz91B6IcVT/GoMpAj+TFSW7vyUmym7/iAXDbb027KksVPvD2PjhcX0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XCRtTJG_1791512656;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XCRtTJG_1791512656 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Oct 2026 10:24:20 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: adrian.hunter@intel.com
Cc: acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	guoren@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	leo.yan@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	mark.rutland@arm.com,
	mike.leach@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	palmer@dabbelt.com,
	peterz@infradead.org,
	pjw@kernel.org,
	will@kernel.org
Subject: Re: [PATCH v2 2/2] perf tsc: Declare TSC support from the build system
Date: Fri,  9 Oct 2026 10:24:22 +0800
Message-ID: <20261009022424.2604-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <66136aa8-adbe-4fdf-9b7c-d44ea0e5cf1e@intel.com>
References: <20260929034133.2153-1-cp0613@linux.alibaba.com> <20260929034133.2153-3-cp0613@linux.alibaba.com> <66136aa8-adbe-4fdf-9b7c-d44ea0e5cf1e@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit

Hi Adrian,

On Tue, 6 Oct 2026, Adrian Hunter wrote:
> Perhaps with #include <tools/config.h> the following is tidier:
>
> 	if (!IS_BUILTIN(HAVE_RDTSC)) {
> 		pr_debug("Test not supported on this architecture\n");
> 		return TEST_SKIP;
> 	}

Thanks for the review.  I'll change it as suggested and post v3.

Best regards,
Pei
