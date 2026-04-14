Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0C23372C;
	Tue, 14 Apr 2026 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148633; cv=none; b=VyaQDzz2qKINpvnaHATQtmDuaW+v8j9//iPXkUipWVAxL40DB/36o7q2SXZzhuG8RX6wDqRNzytKx52B8KpvWVAJ1z+xU+TT9PjzLPYJhulHK6p3JXUt6REpb09Q9N55pCiy/WwRe3fXqZjEwyvi2xPNRlNY5sQ84mKBMgRZeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148633; c=relaxed/simple;
	bh=rAMrbuV7+mtv+mVSBX787Q2+LKMdBce5YJGLCl+57Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCznNOoKb2sIjEXhlCebmYNd6yuI6vnpkOrAJKShSwIZModS6kppBfsb7hyjFoXpY7N1taQS+nhoKAcP6wf59PJXsOdh1Z2eE6PmEeLB5WaDj1AuArauCSDNSXBgdCgEcaj+fUdVIJ9K5hg/AYDbqMlLAd5BQAwQU8HDcm6NQQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8wMl9dO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8wMl9dO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1453C19425;
	Tue, 14 Apr 2026 06:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776148633;
	bh=rAMrbuV7+mtv+mVSBX787Q2+LKMdBce5YJGLCl+57Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8wMl9dOM5gbScWY+51w+Tin6WBAt5MJBIifiJkYYsD8wm7DUdFi3Kk3dkbO+MXZp
	 2CPI6HDIYtnnUtR0xdsJNuIiehMobhCeIEqQc6CK7m/m/L9PUyBKgncxVWPIxyyV33
	 S/+aGIwkub35q7KhzndWzz4fIsQkE5/HHqgiwa6HKeU63DdTyk26ZuyTrDm8IWPXeR
	 qbrLT4pZBTcXkKcajCDcKoW9Hr9B6ojbzY2YdAHwV5Mkrfwwq+MgxFEmyKI/idqdQw
	 Pwmo4hzguoKSZojNSRmqO8TK2b9lTolHil4n5z+bI/wsr2WvsyB1JUc6o/MxLqpFGd
	 20Z4NCPxuBa4A==
Date: Tue, 14 Apr 2026 08:37:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: sashiko@lists.linux.dev
Cc: Geetha sowjanya <gakula@marvell.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: perf: marvell: Add CN20K DDR PMU
 binding
Message-ID: <20260414-tireless-skinny-cow-0e8cf6@quoll>
References: <20260413165621.10921-2-gakula@marvell.com>
 <20260413171206.F380AC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413171206.F380AC2BCAF@smtp.kernel.org>

On Mon, Apr 13, 2026 at 05:12:06PM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Low] DT binding example unit address and generic node name mismatch.
> - [Low] Unnecessary duplication of binding files instead of updating the existing schema.
> --
> 
> commit e2d439a05897c67e7bc90170f7cf6e218505769a
> Author: Geetha sowjanya <gakula@marvell.com>
> 
> dt-bindings: perf: marvell: Add CN20K DDR PMU binding
> 
> This commit adds a new device tree binding for the DDR Performance Monitoring
> Unit found in Marvell CN20K SoCs. The hardware provides counters to monitor
> DDR traffic and is accessed via a dedicated MMIO region.
> 
> > diff --git a/Documentation/devicetree/bindings/perf/marvell,cn20k-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/marvell,cn20k-ddr-pmu.yaml
> > new file mode 100644
> > index 0000000000000..cc6aa760de49e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/perf/marvell,cn20k-ddr-pmu.yaml
> 
> The commit message notes that the CN20K DDR PMU is functionally equivalent
> to the CN10K DDR PMU. Does it make sense to consolidate this by adding the new
> compatible string to the existing marvell-cn10k-ddr.yaml schema instead of
> introducing a new duplicate file?
> 

That's valid comment, I did not notice there is a file which is almost
identical. Why isn't this part of that file?

> Splitting schemas is typically recommended only when conditionals become
> too unwieldy.
> 
> [ ... ]
> 
> > +examples:
> > +  - |
> > +    bus {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        ddr-pmu@c200000000 {
> > +            compatible = "marvell,cn20k-ddr-pmu";
> > +            reg = <0xc200 0x00000000 0x0 0x100000>;
> > +        };
> > +    };
> 
> Is there a unit address mismatch here? The 64-bit base address formed by the
> reg property is 0xc20000000000, but the node name uses @c200000000, missing two
> trailing zeros. This can trigger a unit_address_vs_reg regression during
> dt_binding_check.
> 

Also valid.

Best regards,
Krzysztof

