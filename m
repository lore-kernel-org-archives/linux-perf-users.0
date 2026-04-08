Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BD377ECD;
	Wed,  8 Apr 2026 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632151; cv=none; b=Ht33o8E4HqMw/bO/Zh/JCSQfSkns4Upws0UaDqduT9SM5JsLjU0TNWwu30aC+paTgE87Nsnxszv79z9Eywv9B6UICJjAdoalW9deeIBX6FsLqY+yX6yAksTlhXDBaDTAxPakAg1fzM+pMvu5vWZRftBM/3R/jxbClY+BOb+Lsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632151; c=relaxed/simple;
	bh=gSnWs/hdG4id/G+ZDtXX2wOhcyV0p/AOipuWvp3E5LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBz1WVem8UtfPawQ4PCve6RolVdt+RCLhMUyEMLbmT5SLFOqKiV7BfgUU3AspEi1n57dB1xEBBRQT+bOYt9f/W8xYVIxFsR9AASfcjpMt+JfHiXBjdTubfLHKPOpFdDkN/rUmHByFfbq9JECNQKvpBkY+gv2qqqwmOwGE9stKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKrKQ12b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKrKQ12b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8CEC19424;
	Wed,  8 Apr 2026 07:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775632151;
	bh=gSnWs/hdG4id/G+ZDtXX2wOhcyV0p/AOipuWvp3E5LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKrKQ12b6l9zt5BbE/9WX0kjncIHuQhtK9hQt5pnOPM0LyPPInHL1nUBvYOyUy11M
	 fU2ZibPC10Gn+2GTogAr3ufBtagZ0Lve8XB1pq0BMGmRKGqdObErCdYaiYRVlUJPXH
	 Cse2PyBWkcgECXksU86iivqJsZ84YDyFjQ0f+BcUSL/RY9PVQjhRvopW8IrKZMK3lT
	 YZ5upvOhZJJFwkU5VNPJnAAmMYUvfQfmCCuBWuNXITJaSWO8vuXBcc5nwc5/Ka5jPT
	 805V3iOlvQerhhDOfKrivGNfkSiv94HuLkEpEWwxKcdS+lmOz6s7HPztcnmILS9cBq
	 vrxPeHV2JuUgA==
Date: Wed, 8 Apr 2026 09:09:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, 
	will@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: perf: marvell: Add CN20K DDR PMU
 binding
Message-ID: <20260408-fancy-slick-locust-ff68fe@quoll>
References: <20260407153511.4250-1-gakula@marvell.com>
 <20260407153511.4250-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407153511.4250-2-gakula@marvell.com>

On Tue, Apr 07, 2026 at 09:05:10PM +0530, Geetha sowjanya wrote:
> Marvell CN20K SoCs integrate a DDR Performance Monitoring Unit (PMU)
> associated with the DDR controller. The block provides hardware counters
> to monitor DDR traffic and performance events and is accessed via a
> dedicated MMIO region.
> 
> The CN20K DDR PMU is functionally equivalent to the CN10K DDR PMU, with
> minor register offset differences. This binding documents the CN20K
> variant and introduces a specific compatible string to allow software
> to distinguish between the two implementations.

Drop last sentence, I already asked for that.

> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  .../bindings/perf/marvell-cn20k-ddr-pmu.yaml  | 39 +++++++++++++++++++

Still wrong filename.

Best regards,
Krzysztof

