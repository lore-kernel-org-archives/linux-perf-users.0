Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3E1A7264;
	Mon,  1 Sep 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756845; cv=none; b=kkga0S6rbbK3XMsWFmugA7QljBndF2TIazMsjJurJ0V60VsVfXUbxx0CqKWxe1Wr0Goqgodo9BEG/Hmn6UqJ/SoeAF2PKCfJZPLbXOMUn74Id7gmLcCgWCsavERZvDUjV8o3eTavRlP0yjqGcAZcwj0SGpzXDSFWa6Pg98jl3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756845; c=relaxed/simple;
	bh=CFkBOeYNe06+1/UF6vKOmObFAnoKtYOc56dz9hmioNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnpV5U9Vdy8RVIzaOuALTm7Zzi5LkJfBP5716ufc6FsKneI0P7G1kfuu6IztKokGxArHh/o5/qlFvhWI8dymB9Bz3qCkPv0FD+4Wr7YrV9X9OVhMkTfpj2nEEP+bCB2offFRvjgULmhX2y/HGwH16p21x1hbF2hr0AaWSKGKlDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF5QL4Ih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF5QL4Ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0D9C4CEF5;
	Mon,  1 Sep 2025 20:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756845;
	bh=CFkBOeYNe06+1/UF6vKOmObFAnoKtYOc56dz9hmioNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dF5QL4IhHX5peWtKPcWO33+Y/3jYSVPCYwQVLn4vWsTG5pUjvAx8X3+EkpQyK4cwd
	 RXXaTi9MTftGORj9chATZHBlTnlf3oEMH5w4nzSzNKMSrD17q6MQXtgrvf+s40vRuK
	 qSCqWOPpc8hKBThcZ0VyZgHvRX94245kcVzuTrfDfQguT+UbeygsqlfuJGkWadMHPT
	 Bvqqts9V1e85LulqF6aV3Ou4aDCgnj67lMhQmqLTRu+SIr721QbXgyWEB4QkdqQxyN
	 fIVb1WDAmeg4q+IXL8sl3o+HGZi6vGR9hPufJ5LJ3i47jTDVZcHSLMg9ua6AZqH2uY
	 FRQmP7aqHPijA==
Date: Mon, 1 Sep 2025 15:00:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Add Cortex-A320/A520AE/A720AE cores
 and PMU
Message-ID: <175675683724.229121.8672693936627716247.robh@kernel.org>
References: <20250821190722.417639-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821190722.417639-1-robh@kernel.org>


On Thu, 21 Aug 2025 14:07:21 -0500, Rob Herring (Arm) wrote:
> Add the recently introduced Cortex-A320/A520AE/A720AE core and PMU
> compatible strings.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 3 +++
>  Documentation/devicetree/bindings/arm/pmu.yaml  | 3 +++
>  2 files changed, 6 insertions(+)
> 

Applied, thanks!

