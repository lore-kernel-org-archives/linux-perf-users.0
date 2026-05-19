Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05358395D9F
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204235; cv=none; b=IGZDAlApek0r7J63PIixu/9c2ZO66Q+uEeEGq5x4WorKzVUKs3HmPRgTwAn2eXFzAAbYwVu0sa0BePJkgxXflgNqDxKj6vmXQnAYUjppShWyGLMjUq5Am0iz9AzMsuze/QDEgVY2yPplFt+1QFz+oMIqZSy2oeqU7IWkxPhDBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204235; c=relaxed/simple;
	bh=FN7uMzRTjAP+YHvjen/EgVPRJspom02oX8oIz1mp6rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfctPOac8HIWXQ7bc2/jM0hGapfSlC+EQ4WBkcGnYoKdJLIOPz6mZPFAeJ3CITwKrQ2in0/q722v3tva/1XVzYBrgs+OzB5LhVxTx16R5ae/z1XSqqQBJRCxVb72iMXr82nFd8QgPf+aVXx0jwHRFUAwP2Ea52GYghWFfP8DgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBQ6ae21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBQ6ae21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91630C2BCB3;
	Tue, 19 May 2026 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204234;
	bh=FN7uMzRTjAP+YHvjen/EgVPRJspom02oX8oIz1mp6rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBQ6ae21wBh/ta+/qjIhzUdfRxLHihreiKccr9jss5wZaufPFfOtfcsYBgVRiPNci
	 8oQdSag4QrWha0IYMcmloxwa3GYGwwdLKFYoiulY38DMpXUf2rUlOfkjM8jNkThk87
	 5y3PbeukISJGHyv9Z94w2ppkfaqUrj8DrPwboVuPsgn83PUQ6VDA0VJG3wwN7myNFf
	 qOLGIdHhQkCUhw4Fz+ElHZUy/D1tQZ21plHURJ8jdDHc53KRn/Rl/aa9Jhsb4mS/RL
	 Sp4f6+zKjbAoEifnYZSimxEn5w0t98iUAp6iqXtW2k1vi33STQ9iIldAh2E1EgkDM8
	 sDpnF1jZ8cT8g==
From: Will Deacon <will@kernel.org>
To: Yushan Wang <wangyushan12@huawei.com>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linuxarm@huawei.com
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PMU driver maintainer to Yushan Wang
Date: Tue, 19 May 2026 16:22:59 +0100
Message-ID: <177918542479.723638.6401145981850080149.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416095110.25612-1-Jonathan.Cameron@huawei.com>
References: <20260416095110.25612-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 16 Apr 2026 10:51:10 +0100, Jonathan Cameron wrote:
> Replace myself with Yushan Wang who is very familiar with the HiSilicon PMU
> drivers.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] MAINTAINERS: Update HiSilicon PMU driver maintainer to Yushan Wang
      https://git.kernel.org/will/c/dbd7d67b1318

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
