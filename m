Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E028B41A;
	Fri, 18 Jul 2025 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837049; cv=none; b=OvY4U/0A1dthjYEWl/1Hi6FelB/Zorp2+zzq9f0xJ6zLMJjtyKEk0R5DR+ZpDlj0CdxJRdcqiQJq9F8OHTrfcwfcJjbAl4fWZoh7m5G0fsXGxnxTkDF0720eEnL3YlS2bPP/Xb+a1623A8frajbrBi9mmQBTfBJ9c0oTNWV/QoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837049; c=relaxed/simple;
	bh=MgYAaFAV9DdwWvVxuxzzk0BamlJdsRr1b/bLPNq9hfI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQhEcOOunIvyVwKINlmWg1ku1Ycbc2FrOSE8TN5BbhHKKmKRpz1F6BKQsxEItDCce43j8M89XJ2cZvgkkFjtZLmcrR7Otfor6x+ZlsVTU19/QqLLJUNzEZke5gj2TdnBYnmTzwZUMwc/iBiLG62S/7WwETIow2ImPDljEOs20IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk6W943lmz6M4jb;
	Fri, 18 Jul 2025 19:09:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DC339140371;
	Fri, 18 Jul 2025 19:10:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Jul
 2025 13:10:43 +0200
Date: Fri, 18 Jul 2025 12:10:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: Re: [PATCH v3 1/6] of: add infra for finding CPU id from phandle
Message-ID: <20250718121042.00007fe5@huawei.com>
In-Reply-To: <20250718094848.587-2-alireza.sanaee@huawei.com>
References: <20250718094848.587-1-alireza.sanaee@huawei.com>
	<20250718094848.587-2-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Jul 2025 10:48:43 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Get CPU ID from phandle. Some drivers such as coresight, cti-coresight,
> or arm-dsu use this API for finding CPU node in DT. In particular,
> drivers do this by getting the CPU device_node through a phandle and
> then find the CPU ID using of_cpu_node_to_id(). This commit encapsulates
> CPU node finding and improves readability.
> 
> The API interface takes three parameters, 1) node, 2) pointer to
> pointer of CPU node, 3) CPU node index. API sets the pointer to the CPU
> node and allows the driver to work with the CPU node, for logging
> purposes for instance.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
