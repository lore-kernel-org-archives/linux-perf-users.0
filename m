Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C943165;
	Thu, 22 Aug 2024 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360062; cv=none; b=OqoRx1L3gG+eHSJR4dUjxbbrBnxM00dj8VHLTFAyPgKQUcW8oYY4dpEWM64pRdeJbPHuGEcHfUQaDMqEM+Uj0Pk+vlhFAcw3f0Tr869o6oWRjw75dUD/JsZlNaRKnAjMLdpOV4ecXCH5uG9hFhMja6a0tDcwZY3m88+wdzngbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360062; c=relaxed/simple;
	bh=5eEPnWkjMFjlu5Zp4sOVXZC1l5F+kgiwj0gq4739oHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN8D96HDWkOTr5tS6oiO5PhcOvHSw1TQIKh4DD499wtl3qAL26/KkaDz50nKfUWeWoe5rtJrp+xF3AMRVeRYCPrSNDOGV9nq/K8E6DZYNozvJMS/MF0AsL1Mml7LFxHJ6G8AibZ+IaVCsZxluRL9013oCblPqDbuHD5dZK3EDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9aKie4K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9aKie4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5E0C32782;
	Thu, 22 Aug 2024 20:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724360062;
	bh=5eEPnWkjMFjlu5Zp4sOVXZC1l5F+kgiwj0gq4739oHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9aKie4K7t6wVb4rAlnmrx7kgCPS+ULgjwjgfljYhHU/0UHPhLhMwKo60xOvM4gHS
	 QM3X9M+INUIUgoAWo8lmMi/Ngmn8nK+uyqLkcdIrr9RWZtg2dldj8JqH4Z4aBQI/83
	 oYgLQpWDxQ050zh9BZVwSj3w553nlH7HGzvKbZCGrQ3xFNJPFxkPrMDG5RJxJ2tpNF
	 StY5jO3dHnCwVnNkPdDY2Aibi4NQtTgdOZjtUC6mDniDSXQlhoJ2PSXuketIYiDplN
	 eJHbtQiB/njCre5udhsL/cY2lpgGML3c/qvt43m1HyfaKAz1n9R5XRaUiivTtwv2X5
	 Kx8E0yvFpt65g==
Date: Thu, 22 Aug 2024 17:54:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCHSET 0/4] perf annotate-data: Update data-type profiling
 quality (v2)
Message-ID: <Zselec3mxmkd723n@x1>
References: <20240821232628.353177-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821232628.353177-1-namhyung@kernel.org>

On Wed, Aug 21, 2024 at 04:26:24PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is continuation of data type profiling series to improve its quality.
> I've also found some more bugs and room for improvements.
> 
> Acutally it depends on the a couple of fixes I sent out yesterday.
> But as they will be merged to perf-tools-next, I omitted them here.

Thanks, applied to perf-tools-next,

- Arnaldo
