Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E486344;
	Fri, 15 Aug 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266927; cv=none; b=EAb33Qv696EMYGJoiJ0iCy2r4MfDueQUieYTHDaN5xGPv0a07VNeAdz1PulSWQ7q3X5++QI+uZFTpdk4O5VR+D6Lg+guwsTsHIfjsc41wo2qPHWieSfbhOJgyrq9UzvAKbWeeQcLCCcTRWMN5naVw5qHxPOkzTjVb2MmzjZ4L5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266927; c=relaxed/simple;
	bh=NrDxS+nEV24yOQvxvSGpYB/9OTb59CnDqOJpdYh1gVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2gJV7UYCdx1gyfjijHQjKPNgAyRx5fdvRhDT7Hidy3mt9fQb+wNx09lCU2b/7sNrIzmVnxvCQijRT41g6ef/RDGL/epGRSkODXtIpAj8PMStr2+9y8Y9CZVPQch1zFrJm8uYLCMc54tMK+R6Wfc0AMU+FmfSLA2OlLC22va9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEB6C4CEEB;
	Fri, 15 Aug 2025 14:08:42 +0000 (UTC)
Date: Fri, 15 Aug 2025 15:08:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] arm64: probes: Add GCS support to bl/blr/ret
Message-ID: <aJ8_aH7ncFfznl8S@arm.com>
References: <20250811141010.741989-1-jeremy.linton@arm.com>
 <20250811141010.741989-5-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811141010.741989-5-jeremy.linton@arm.com>

On Mon, Aug 11, 2025 at 09:10:07AM -0500, Jeremy Linton wrote:
> The arm64 probe simulation doesn't currently have logic in place
> to deal with GCS and this results in core dumps if probes are inserted
> at control flow locations. Fix-up bl, blr and ret to manipulate the
> shadow stack as needed.
> 
> While we manipulate and validate the shadow stack correctly, the
> hardware provides additional security by only allowing GCS operations
> against pages which are marked to support GCS. For writing there is
> gcssttr() which enforces this, but there isn't an equivalent for
> reading. This means that uprobe users should be aware that probing on
> control flow instructions which require reading the shadow stack (ex:
> ret) offers lower security guarantees than what is achieved without
> the uprobe active.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
