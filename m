Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50D430CF6
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612997; cv=none; b=Dis86Qs05cPhlSoi4eHYBJ6d2Fu1hYpcpMxhsL1ZrashaRF4a4cVcKeO5yY2FNbn6YAWzcukqKYyvKUouBpnp4CfKECADD/Nwu5Aufpibxk6wHGRej6Pma6fm+4uhNJ8wTob4sfMzvEl36ui0SJp9I22ysbB5/qCGtoxBAUX7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612997; c=relaxed/simple;
	bh=N0FPojFXU0pApsxKjA1PK/ID5/1WXuMBs5arWXUUvQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAySjzN2G16S4rmj8td3FZwhtpWqCDaKs+8WYQkyjMu1JMEHraFxVyrsBpQEqARo/66KWuP6k/K9u1EpfWgi+tvGLU4uUd78Mk04jwTt6X6MxRzZ3VodF8szr2tJYh3IkmqcRCtYc/nEJPwdXy1o7B6gBr/MpK7wpdfiv+oyako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lwUl9usL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lwUl9usL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D05126A4;
	Thu,  9 Jul 2026 09:03:09 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 135E93F66F;
	Thu,  9 Jul 2026 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783612993; bh=N0FPojFXU0pApsxKjA1PK/ID5/1WXuMBs5arWXUUvQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwUl9usLcQddI2IzwBL69XkoXm9FRCR/3m0y3ujMpzKtgWru2cs8UDMVIssWrVPQU
	 JG2qjsqxCDsS/8xxdiEsS9gILRBqQkZ1ONfPMNskK9VX59capxh4Gyj7I8rry0cGuv
	 h8ai4NIhmyLq0K/FlfnlZMTxncnREZbvxw+fSdgU=
Date: Thu, 9 Jul 2026 17:03:10 +0100
From: Leo Yan <leo.yan@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 4/5] perf/arm-cmn: Add new filters
Message-ID: <20260709160310.GG1024232@e132581.arm.com>
References: <cover.1782830759.git.robin.murphy@arm.com>
 <5304caf0300992329742d22b746167b2f3e4174c.1782830759.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5304caf0300992329742d22b746167b2f3e4174c.1782830759.git.robin.murphy@arm.com>

On Tue, Jun 30, 2026 at 04:19:19PM +0100, Robin Murphy wrote:

[...]

> @@ -284,6 +286,9 @@ enum cmn_filter_select {
>  	SEL_CBUSY_SNTHROTTLE_SEL,
>  	SEL_HBT_LBT_SEL,
>  	SEL_SN_HOME_SEL,
> +	SEL_SNP_VC_SEL,
> +	SEL_ENHANCED_HBT_LBT_SEL,
> +	SEL_EVICT_STATE_SEL,
>  	SEL_MAX
>  };

Though SEL_SNP_VC_SEL/SEL_ENHANCED_HBT_LBT_SEL are not really used in
this patch, I understand this is preparing for new filters.

The secondary filter between SEL_EVICT_STATE_SEL and SEL_HBT_LBT_SEL
also looks good to me:

Reviewed-by: Leo Yan <leo.yan@arm.com>
