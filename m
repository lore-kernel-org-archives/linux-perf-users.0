Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3F126C05;
	Tue, 24 Jun 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787589; cv=none; b=d/NBHuFxu6KKap9NFGftGMO98vD+jXpdfJ7GuPVkL5ttkmcUU9gQioIUH6HwDO3n5THR/s+Eav5ox0ZVDZyCKh2/9dCidrCu/hNQBS0ZLGftyFFIKhuNGzKlkmzfi75lmW6KsypEg2GXjsPeyerTmy4ty5UKFImxbEk9YqlVfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787589; c=relaxed/simple;
	bh=W2xVuCe7bK8DRCKXqVells+OeVWBSXLrTS0EhysxPoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ePzE9er079PJ1qZqeq3Mlcba2apza1m9MJYblV4Dnh2QEfJ00v/RZXYvVo+eI1vrwxaA1kk5sttJ6boj6T0SgBw75Soaxkgpey/a9e51cleP/hAoqGHUmM+jmElqP7qQ1OHv36utlGGzayPc4PvAwlr/0tTqxWUW5Xc/IemEB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYOG3rAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYOG3rAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48540C4CEE3;
	Tue, 24 Jun 2025 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750787588;
	bh=W2xVuCe7bK8DRCKXqVells+OeVWBSXLrTS0EhysxPoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YYOG3rAVjeS4X6H9EENCq7v3V5/80ewLyVTBG+aTxPZgIcoPnO+vCZdoxDopVhrkD
	 CjHzGAsa5cPZdi9fLMqk4ErqBs+m2n8kvKPo3L8JPDHhrYp0c82KgUKbr0E61iTMy8
	 N5w5KvQTJtAMhw2O8SF/lYLs4BqINzAO4DfhfeDA1yQSwAiv6MD8nBUUB1ujXxz6Pr
	 SpPKFiHk+5rEIusx0fzqQr/sataXiDaPH85HB0eeNm0uEVglClINtFMdlp/1fRAQwK
	 MGXsxtuOqQdjylL2LFZMjqcOkXcNSulRe2ZxKwTyTK8/y1JXFe1ifpFe2W2wui148Y
	 dvra+vNNdu12g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Chun-Tse Shao <ctshao@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Jakub Brnak <jbrnak@redhat.com>, Junhao He <hejunhao3@huawei.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, 
 Stephane Eranian <eranian@google.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>
In-Reply-To: <20250620212435.93846-1-acme@kernel.org>
References: <20250620212435.93846-1-acme@kernel.org>
Subject: Re: [PATCH 0/3] perf tools build process cleanups and extra hints
Message-Id: <175078758824.337518.12947692938396399829.b4-ty@kernel.org>
Date: Tue, 24 Jun 2025 10:53:08 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 20 Jun 2025 18:24:32 -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
> 	Some simple cleanups and extra hints for the build process,
> 
> - Arnaldo
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


