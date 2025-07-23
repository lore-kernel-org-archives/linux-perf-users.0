Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19A286D56;
	Wed, 23 Jul 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263878; cv=none; b=lDNzU0Tl0+KdVMoT+mHvmAwhrGkE2dECLyo0Ql7SLgsSpWi7NPo77TQ7TYftioLB04vRvcGOCqiohaC/ihzn7NLDFtuW4GnAxovy60PVOZMQh+BSWgrXKDaGQYUCf824lzqO4oKe0mW41Gf5uccyuzNjXfUpDR03k2fuRmXYZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263878; c=relaxed/simple;
	bh=kBI+th1AOgFUDp3WWLFv7kJDQDxideS6it+GkfPd60w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY9kObosLocuumqXhlzkB2q8oyC4rEklgHUjbUsIjSwKtSmZnYO1LM6u7QR4ec54M+gs93HxObkPnnaQffBkYIbyYixgBjyokgLq4mS/u74jKl9IrePZk9a2EEjyuDCKacZFl9L0NLPIIw1zvkZfDfIjHqj0U6JQB5OCnPCqxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AADC4CEE7;
	Wed, 23 Jul 2025 09:44:33 +0000 (UTC)
Date: Wed, 23 Jul 2025 10:44:31 +0100
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
Subject: Re: [PATCH v4 3/8] arm64: uaccess: Move existing GCS accessors
 definitions to gcs.h
Message-ID: <aICu__TsqPRXJU7m@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-4-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719043740.4548-4-jeremy.linton@arm.com>

On Fri, Jul 18, 2025 at 11:37:35PM -0500, Jeremy Linton wrote:
> We are going to add some additional GCS access helpers to gcs.h in
> order to avoid some forward reference problems with uaccess.
> 
> In preparation for that, lets move the existing gcssttr() and
> put_user_gcs() routines into gcs.h where it makes sense to keep all
> the accessors together. Further, the code which uses them already
> includes gcs.h and there is an existing CONFIG_ARM64_GCS check we can
> reuse.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
