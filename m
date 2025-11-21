Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA42C0296;
	Fri, 21 Nov 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715670; cv=none; b=A1KdYNHgCeZK8Lk2jOAwDsBbBteq1MqxwBJynEd75Bz9txnxrGxmfatWo40BFqbf46UfTK4lZNoIi2ZAggLOlYQJrli1HD3v5Y1bNRbpMhW9pyExrdv8baw5DWFCovaQPp8bv7P7NT6OboU474WRggiowlmtn+u7/qQFSto5u2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715670; c=relaxed/simple;
	bh=eInAUYEonqecolnVtmUNXId6rbl1ZXAHthWxpLNajEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXx7i0ZMvSbAfU7086iPXSZArk99xBdniFfFWWAvoiZwtH+bKi/r2ejXQXOwPhrze+9SLNCANj3VWIG36rhGir5vPDbCenFwH0iVLwAiGpjjtXeI6fOhigOQnQMIpXLXCfeXDwL624C7K3Ia+LeUWUZ93sSCwXe75JCRCxhNVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAijLsFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAijLsFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829DAC4CEF1;
	Fri, 21 Nov 2025 09:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763715670;
	bh=eInAUYEonqecolnVtmUNXId6rbl1ZXAHthWxpLNajEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAijLsFX/S5Sf6sqheAQEACvIwIlXP58JZgMNSayulYJhQ/vkzcFMbYimLZajqFl8
	 WDudN5Vht9JQNhoGhkJFZOYhDi6GOK81pnW+IbjFPGpFFvzp/aTmtykFLRtZnQRY5G
	 cqhAXEdxrZYjx+nm+mtHr9aHyX/xjtTur91tejJBBKl7LkX7O1GHLnUA8KNs1i2Dd6
	 HZmETHnaJlYLGxI5SBm/WWJUXucKqbCHGke95a6qpHln5XIk1QXet84kIm7+ZfzP4O
	 w4ZHHh7nOdCeY/PqH+1xY9kfjHuskzqbIsbatfTzEI/bX02JflZlD4/pgMTidGofS5
	 fGblDXCRydK4w==
Date: Fri, 21 Nov 2025 10:01:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: cp0613@linux.alibaba.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, guoren@kernel.org, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add prefix for
 XuanTie
Message-ID: <20251121-able-terrestrial-spaniel-90c3cf@kuoka>
References: <20251121063439.2545-1-cp0613@linux.alibaba.com>
 <20251121063439.2545-2-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121063439.2545-2-cp0613@linux.alibaba.com>

On Fri, Nov 21, 2025 at 02:34:36PM +0800, cp0613@linux.alibaba.com wrote:
> From: Chen Pei <cp0613@linux.alibaba.com>
> 
> Add new vendor strings to dt bindings for RISC-V vendor XuanTie.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index f1d1882009ba..5d28b2da94cd 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1829,6 +1829,8 @@ patternProperties:
>      description: Xilinx
>    "^xnano,.*":
>      description: Xnano
> +  "^xuantie,.*":
> +    description: C-SKY Microsystems Co., Ltd. (XuanTie)

We do not create new prefixes for existing entries. You have already
csky, alibaba and thead and probably many more. Choose some appropriate.

Your commit msg should also explain anything unusual here, like above.

Best regards,
Krzysztof

