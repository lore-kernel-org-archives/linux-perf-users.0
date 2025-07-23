Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D495221DB4;
	Wed, 23 Jul 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263856; cv=none; b=P+CqD8aBYk9uCqpnCzM1gMhfLQnw+YEv0XqeVoVVT80uymSo0mEWXAe7yyuHILSz3XgZBgk6kEHQgbtB7sbXkRPbNA0TYsBvADQxXS37rirWWCvhYVZcry6qhb2B7/fPpi3iSx7Dg9RRT7haoB+Fqowi4w35e7zF9EdHHkHcOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263856; c=relaxed/simple;
	bh=TIjAj4HOySs1kKeNnto2wtp++uO3ua03omoFhMX5/0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6vR2TLMtMHas9KH7DtQbAWAS5UdeiuZmn7Ye3YP7vKCHVAgnhrGGC2gTYvzq99ueJidqFsw69SCKJ7qvdvCAtGGRkvGr51jDttylRorexyMCOm2YR1K/OGgVkXPLxVXeAjj7Rn7jpTJlPwD/AFB6mQim9PVYU2H/s0U12wtGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4ABC4CEE7;
	Wed, 23 Jul 2025 09:44:11 +0000 (UTC)
Date: Wed, 23 Jul 2025 10:44:09 +0100
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
Subject: Re: [PATCH v4 2/8] arm64: probes: Break ret out from bl/blr
Message-ID: <aICu6a1kggJ42xZe@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-3-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719043740.4548-3-jeremy.linton@arm.com>

On Fri, Jul 18, 2025 at 11:37:34PM -0500, Jeremy Linton wrote:
> Prepare for GCS by breaking RET out into its own function, where
> it makes more sense to encapsulate the new behavior independent
> from the branch instructions.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
