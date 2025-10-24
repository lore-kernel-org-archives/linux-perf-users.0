Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAC13C695;
	Fri, 24 Oct 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316726; cv=none; b=lfIKf62WYUiIuUcFfQDkW2Va/DabSF7zJB3tcbTz0tV0up8fUqXbtByvSjOk5ZLDTo3Vjf4wKzM/CO+pNwjIvSZVIbZcj1HkPYlFEZIfh7uapdQGZO54fov2mHaW+SptRzKSrs/B66bFkatXpKrX9kkKDj/EmQOk51PtZCcjpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316726; c=relaxed/simple;
	bh=AIFwelp+/xBHxhoz7J6sOfXkstJh4Ezb6r2BbgZb3NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaRGxGNIYgaBkUn7Du9uPCaZvuUUp+Y92Mc7DIDPNpbla5pf674RE6ePDlZTuvb9mcsUcwzZmz2NCgGtPhX9bZ1KjQgTg6CR0gm+L9f8Fns9ht02KqdDWLnA8EIO866vvFh3ACTFpKz3ain1FIXDydjYBI6zy9vbXNrOvS9038U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11AF91516;
	Fri, 24 Oct 2025 07:38:36 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A16A3F66E;
	Fri, 24 Oct 2025 07:38:43 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:38:41 +0100
From: Leo Yan <leo.yan@arm.com>
To: tanze <tanze@kylinos.cn>
Cc: adrian.hunter@intel.com, namhyung@kernel.org, mingo@redhat.com,
	graham.woodward@arm.com, irogers@google.com, james.clark@linaro.org,
	john.g.garry@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mike.leach@linaro.org
Subject: Re: [PATCH v3] perf auxtrace: Add auxtrace_synth_id_range_start()
 helper
Message-ID: <20251024143841.GU281971@e132581.arm.com>
References: <20251024085625.175688-1-tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024085625.175688-1-tanze@kylinos.cn>

On Fri, Oct 24, 2025 at 04:56:25PM +0800, tanze wrote:
> To avoid hardcoding the offset value for synthetic event IDs 
> in multiple auxtrace modules (arm-spe, cs-etm, intel-pt, etc.), 
> and to improve code reusability, this patch unifies 
> the handling of the ID offset via a dedicated helper function.
> 
> Signed-off-by: tanze <tanze@kylinos.cn>

I built perf successfully with this patch:

Tested-by: Leo Yan <leo.yan@arm.com>
