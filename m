Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018C2DF151;
	Fri, 21 Nov 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715712; cv=none; b=OaHLECtMot61hA3GwHr0ZFTnlyEVhp3dBgNghp1umdNGkdvu18L7EjeC/l8Lfvxw8yjo+bKfvEv08aqLP4AHusm3RbB36p8ni0lVZxHRw1FzQn+RHQe5D/Al0nIcYXn2DpeUI2pJz4iwsixoJU1UGon1sHlU8eechM1OdRQJbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715712; c=relaxed/simple;
	bh=BAlIVa/oy39TVToOmx2+pumF4QJ8TMQ+gMvOrQ50rm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntWpblg9RskVypHJXm4IHFIqCdsIomCsRj0rz6vALLzBbMh0kMQcH9xoI+L0LDf/GZauR0MEI3OpVtwNXXd2ajwefJRcWirgcF8qAzBL6feqqBxNYKeKpcGlssmzQUePzfg1KM+QV/yPCib90W0IHIPSJEAwTGHimZmm735ECrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odt6l800; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odt6l800"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006B8C4CEF1;
	Fri, 21 Nov 2025 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763715711;
	bh=BAlIVa/oy39TVToOmx2+pumF4QJ8TMQ+gMvOrQ50rm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Odt6l8004Gy13rV97eKLhGuEg7Ybbputx02ogH9vFfbE1mf/Qy7KGUm/LQMg66d3X
	 f0z6ioDVLTY7y7eyJ9jAJQ5n7wsSjICHTrUIAqpaKHumxBJvBxcWvm+wxEuJ71pnAF
	 vjoLJ7txHg+pZrF6scoE6DKxsn3+8giAyfmw/SJhR73ni9RN7KqLrddyTDH6RXvxJD
	 b/hV5jCm8vy35nsx+v7J40tJHfkoKQOi2QzkPEt6NuRuCvE0QiSZ1/C/PHfi7pVjtv
	 39xjlJ4vGTs20tPWCrismoAkydWHT4DGih+MizVAXmZAZJb/t8jvn32P4/4aysXvPI
	 whBrBZLBZY0ww==
Date: Fri, 21 Nov 2025 10:01:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: cp0613@linux.alibaba.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, guoren@kernel.org, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: riscv: Add XuanTie C930 CPU
 compatible
Message-ID: <20251121-hasty-scarlet-axolotl-c93efb@kuoka>
References: <20251121063439.2545-1-cp0613@linux.alibaba.com>
 <20251121063439.2545-3-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121063439.2545-3-cp0613@linux.alibaba.com>

On Fri, Nov 21, 2025 at 02:34:37PM +0800, cp0613@linux.alibaba.com wrote:
> From: Chen Pei <cp0613@linux.alibaba.com>
> 
> Update Documentation for supporting XuanTie C930.

You just copied here commit subject and diff. Write something useful
instead.

> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index 153d0dac57fb..581a95eba932 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -65,6 +65,7 @@ properties:
>                - thead,c908
>                - thead,c910
>                - thead,c920
> +              - xuantie,c930

So that is thead...

>            - const: riscv
>        - items:
>            - enum:
> -- 
> 2.50.1
> 
