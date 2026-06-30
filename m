Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076FE386554
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807795; cv=none; b=XFgIF+LSSqUYGKZ56p76ngSe173UGOx6ypTbjyRI1GznnuXR8gRuSdn3duhCs30cn70bA8g5z6C1H0ZXvBTFzpBYqSpomj9gLH3dGVpVMB+KjBOMCDh10MFVq5ypeCXiGD7d3Y6W2qvaOk69CL8z3X9PhYyXfg7KfiocNRok77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807795; c=relaxed/simple;
	bh=O032AETtd2QRdz8mAj4/zj+sMhndZd08wJhinDFxnVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItUW+1zT+vGL3/ZryJIPKAORIlaF0E31yYxfaY/re5u/d8I9CKSYUaCeovBnoHadipzWE/5TphtFiRA3ChWb4Ey7NcEIY6Q+hT8Zo2u+ThRwumKJtzm331j6V4MwjKe3Df4naumpKz+0ZUujqWNh82p/gAgn0p06geFY4L38vuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a16LguaA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a16LguaA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0BCF22D9;
	Tue, 30 Jun 2026 01:23:08 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E46943F905;
	Tue, 30 Jun 2026 01:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782807793; bh=O032AETtd2QRdz8mAj4/zj+sMhndZd08wJhinDFxnVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a16LguaA70TV8S9pystkxlAS5iZpyVaTSV4nZx2qtSr4E3LT2Jn416WOEQsNVZrNC
	 eH1ocv+EpYiZGaxmGvoqM6TlXX6h+zbqJ20PbMMLdB988oU4JBbTNQxQZ/9huY7knP
	 2J9KLCb273d6n1N2JIyWtU5op0aqo/fxKz8U5DZo=
Date: Tue, 30 Jun 2026 09:23:10 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH v10 0/9] perf cs-etm: Support thread stack and callchain
Message-ID: <20260630082310.GE1812158@e132581.arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
 <akMPoLNBbAEyNU64@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akMPoLNBbAEyNU64@google.com>

Hi Namhyung,

On Mon, Jun 29, 2026 at 05:36:48PM -0700, Namhyung Kim wrote:

[...]

> Will you send a new version or want to merge this?  It seems there are
> some remaining comments from Sashiko.

I prefer to merge this series.

Sashiko reported several critical issues in the common code, they are on
my to-do list.

Thanks,
Leo
