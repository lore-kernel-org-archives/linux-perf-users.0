Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D023D2AA;
	Fri, 25 Apr 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579387; cv=none; b=T0LIleuCv/kn+YZt8JTH35g8xjKDg5uGQgg2L6NkSIR01EwPQrNbiJ0TAsHxvb569IcdnPWi4xCwoHrAcbyX2S6mLJnqfcWAJxhHq2xxwXLUL0YDkx4VNh3Of2/nscULin/Rm0w2/tH/FJKp0It8uynnAcSCkY0yxCg8N49Yxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579387; c=relaxed/simple;
	bh=6+9MkaQu+mPud85wB7s0sGxBcW7FKtrCtMEYMFsYG+w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9M0mzvY9J8s4RH9FT/dVd3NHnbGnXRZ2oBeZBz0g39Re3dLFfX3VLsMN8ISWa9jhljsoVBUmKuHQwcHpSS4Avu4PfFDAVsg96R2+HkLc4EgQpblBQZKtucNcNgLrpszhBNxNne1Oll62bnI12F1ul1Ot2FmI6k1l93YuBO9Uhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZkVPR0BJlz6M4tN;
	Fri, 25 Apr 2025 19:05:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 50F141400D7;
	Fri, 25 Apr 2025 19:09:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Apr
 2025 13:09:42 +0200
Date: Fri, 25 Apr 2025 12:09:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Junhao He <hejunhao3@huawei.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <james.clark@linaro.org>, <leo.yan@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@linaro.org>,
	<yangyicong@hisilicon.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add hisilicon pmu json events under
 its entry
Message-ID: <20250425120941.00004f12@huawei.com>
In-Reply-To: <20250418070812.3771441-4-hejunhao3@huawei.com>
References: <20250418070812.3771441-1-hejunhao3@huawei.com>
	<20250418070812.3771441-4-hejunhao3@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Apr 2025 15:08:12 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> The all hisilicon pmu json events were missing to be listed there.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

