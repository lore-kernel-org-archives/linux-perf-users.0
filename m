Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D017CA1B;
	Mon,  3 Mar 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035621; cv=none; b=cYX/w7RS67mJCnA23+gATf6fXMZWcyqrrNtHKNeGawoSTsZkXndXGgMoOXn4MTSQzGyvop3EMl+AOJqkPwGik0nvf59e0SyFeKss6Yme8i25xaWsZaSyxV1zLM7NJVmtQwozSHWZRlmGXF93PdJ4hOXCO7ay8CPtWiml4JhCJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035621; c=relaxed/simple;
	bh=bo8HrOIlN5Xf5krNsctVKKdvPdiqrXCjvrUMmNpPcNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRAV7K9CgzW29WMRFxATLlLT4xMCbG6G3Bwc0W2pfNfeWS0HFoKTabe88NctGKwx9cGuqYObHfSP7FaAEcObUoMdQMKE1wtsXvYESkR+qEU5D3hZwV//EEBY7XJmTUyK6+kmMGOcS7jLzwoppPAo+Ap9bvJFRpZc0GhEpBlWdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hncZz6O5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hncZz6O5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D50AC4CED6;
	Mon,  3 Mar 2025 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741035621;
	bh=bo8HrOIlN5Xf5krNsctVKKdvPdiqrXCjvrUMmNpPcNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hncZz6O5SzQ0KX7gjO3GOe9xzDMoa4yW4yZqipxllhuZVZIn4j8nJJO3nV3ZNPvUO
	 6g0BIa85DBrSVK/a7iEZzKSqkt/fKwSFOIWT6hlFT6mTNNSmWN4ue3kJrHpVrM2nw3
	 cJAiprxl6RVL0xdGqPbKE2yQbqkqNkDhGIwy8wXccJAROe7j4TQWhxaPsneYrHpxgt
	 7MfKR7bUWDF16JaeGY4vEDa5Mmcxr/Cy3wibEImKe/5CBQ47IYS42DNkRbZ0L78FNA
	 f5U2rDOQkXOUfYChIQR3bfp7K7jAv1jMhOuyQGRXN3juZtQSpp8B2n5XbVCRVbP6IX
	 BhdmygBOLobUA==
Date: Mon, 3 Mar 2025 13:00:19 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/12] perf script: Refactor branch flags for Arm SPE
Message-ID: <Z8YYY2Q_ZPIaZ74g@google.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250303093853.GG2157064@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303093853.GG2157064@e132581.arm.com>

On Mon, Mar 03, 2025 at 09:38:53AM +0000, Leo Yan wrote:
> Hi Arnaldo, Namhyung,
> 
> On Mon, Feb 17, 2025 at 07:58:56PM +0000, Leo Yan wrote:
> > This patch series refactors branch flags for support Arm SPE.  The patch
> > set is divided into two parts, the first part is for refactoring common
> > code and the second part is for enabling Arm SPE.
> 
> James has given review tags (including the new added patch 06).  Could
> you kindly pick up this series?
> 
> Sorry for pushing a bit, as we have dependency on it.

No problem, I'll add it to the tmp branch and run some tests.

Thanks,
Namhyung

