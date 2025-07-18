Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DDC2BEC3A;
	Fri, 18 Jul 2025 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837288; cv=none; b=U8ZTk0K1BNLGm/JuDt8Ln4u6m9J9CkXZAfwkyrkL0fNK81hvYQlyNVMB5NbZhsXCPJiSnNPFjNxlYA7boA8ldGTrMP6zSotWVGljlYcy+t0iHK/zidVHjAajfP7tNnbLCJYUPDi2XgL5rvsj40hjhv+ZTSMs3DUsBxzEJIStVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837288; c=relaxed/simple;
	bh=MqxG4JlYWZ7OWc9cbn4MfZN570ClGIVj2IbvzbaUbCw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVm7lKQbY6LKCgXnavzCVxK37+0Ng5zKpFXm6S0rkaux/v37sySenNuFWZHZhafi5GceDTDeOpmKfPdR8Dhau9+lSUtCi1H+7gz1ZEhJZLfenUx8uqIF5RQAJfiuFn4Gb3ufq4997QLRvhKx4Hzxkft9GdlRqGBa4x4ob2iAMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk6Y70MQwz6L53F;
	Fri, 18 Jul 2025 19:11:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 27B20140371;
	Fri, 18 Jul 2025 19:14:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Jul
 2025 13:14:44 +0200
Date: Fri, 18 Jul 2025 12:14:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: Re: [PATCH v3 4/6] coresight: cti: Use of_cpu_phandle_to_id for
 grabbing CPU id
Message-ID: <20250718121443.000011ff@huawei.com>
In-Reply-To: <20250718094848.587-5-alireza.sanaee@huawei.com>
References: <20250718094848.587-1-alireza.sanaee@huawei.com>
	<20250718094848.587-5-alireza.sanaee@huawei.com>
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

On Fri, 18 Jul 2025 10:48:46 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Use the newly created API (of_cpu_phandle_to_id) to grab CPU ID.
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
