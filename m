Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B7430BB3;
	Sat, 28 Feb 2026 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772315940; cv=none; b=YGhY6SmZP+90Jvd5gEJM7nozqKtMiZubCSl9DcMEihp1oXg8BnxEKubv1Q+cXNbelFen4Qc77e24OskmzM5yr6oHD7zXKhxGiSDl8PUk0MmmftYx7CBGraB62sRUtLPZHeqT95Sw8EN2nqSXaY6Pf2wpeLyuq6zjr7m5U7js1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772315940; c=relaxed/simple;
	bh=Ld+pngW8u/Nqx5EZqVABXM1oYnBqteIpU/N21OGAmNo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dLsdPeNmj3uh3pHdCTR3jxXy8e0Yvjuh13MQe1uhDBfnj/C4jeq8OGvVOXlHCAXDkWTO8A7M69c9EdIYOdgvXafpfRxdjro3KAFN6PpNkPsSG3WQBI+88vI93bnDpATC+5xN+pi4k/Jr8S9nYDFtD6bD5GXWVRvJi3Itlv7gvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E9CC116D0;
	Sat, 28 Feb 2026 21:58:54 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 4/8] dt-bindings: iommu: Add spacemit/t100 features
From: Conor Dooley <conor.dooley@microchip.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Yixun Lan <dlan@kernel.org>, 
 Jingyu Li <joey.li@spacemit.com>, Zong Li <zong.li@sifive.com>, 
 Yaxing Guo <guoyaxing@bosc.ac.cn>, Zhijian Chen <zhijian@spacemit.com>, 
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <D8CE6E5B1001D797+a6f36da0272ac18fff2a992976b1defc3bb01af6.1772289741.git.lv.zheng@linux.spacemit.com>
References: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
 <D8CE6E5B1001D797+a6f36da0272ac18fff2a992976b1defc3bb01af6.1772289741.git.lv.zheng@linux.spacemit.com>
Date: Sat, 28 Feb 2026 21:58:42 +0000
Message-Id: <177231592262.848068.18080490567217057666@spud>
X-Mailer: b4 0.15-dev-38bf1

On Sat, 28 Feb 2026 22:44:49 +0800, Lv Zheng <lv.zheng@linux.spacemit.com> wrote:
> Adds device tree bindings for SpacemiT T100 specific features by
> introducing spacemit,t100 compatible. T100 contains distributed IOATCs,
> each of which exposes pmiv interrupt.
> 
> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> Signed-off-by: Jingyu Li <joey.li@spacemit.com>

Patch content here is fine, but the signoff chain on this patch is not
right. What did Jingyu do? You're author and submitter so either Jingyu
did nothing and should be removed, or is a co-developer which requires
attribution via the co-developed-by tag. If the latter, their signoff
should be before yours (the submitter is always last).

pw-bot: changes-requested

Cheers,
Conor.

-- 
Conor Dooley <conor.dooley@microchip.com>
