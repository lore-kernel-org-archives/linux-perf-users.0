Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77328D845;
	Wed, 23 Jul 2025 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265419; cv=none; b=uRawbeXXAbM3IuUNah/KMU+YHs6OyTNRRp+4XZLyQh1wgTaNP5qsCJRMc1SHr1VMTq7oBPmwNjLwlPSFca/G8XbGgBm47rGeRiCVrtyGp4A2q59czjV+YaVh37Ddt4MReoY2hM8591/Ys13zVytJqtV8MaE2O/AGvcpeayHqtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265419; c=relaxed/simple;
	bh=itd+dOxiHn+aQt0YOOCiTJdMBotB8bzKJWfiOWggScY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE61ew5sVESZzED3VDczcS+Ksk0jSL3GWGd5gH1NwdtWUxPE3lBiuChYqzPGmwE19BZ0Igf0VpBOJ8RcHXbwmX46rxdzpKjUQWOibefZL1TkCsC/QC/OyYwAt/tjfVxjbZ8vm04RDFpSn1erl9T62K5bUsZZ+WJ48NqpvhF0Du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1946C4CEE7;
	Wed, 23 Jul 2025 10:10:12 +0000 (UTC)
Date: Wed, 23 Jul 2025 11:10:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] arm64: Kconfig: Remove GCS restrictions on UPROBES
Message-ID: <aIC1AvCRQ7Ok9pxZ@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-8-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719043740.4548-8-jeremy.linton@arm.com>

On Fri, Jul 18, 2025 at 11:37:39PM -0500, Jeremy Linton wrote:
> Now that the uprobe paths have been made GCS compatible
> drop the Kconfig restriction.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
