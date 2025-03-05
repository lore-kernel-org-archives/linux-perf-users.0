Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363E205E00;
	Wed,  5 Mar 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168389; cv=none; b=OzHQFrre+un9VAe5sy+pe2CZ9w/KBu3if/nts17nAHd7FB28/FTmeqJj0wZz7vbUONWxSYLuGwC8Qwl6r9cuKTfxmSos+l8+RGzOJUXTyt9I/xc/1JdI4yv/LCTpnI0K+/O5HK7Q2lj+fX7wjxy21c34mMzi0R3zo/jYkPtZiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168389; c=relaxed/simple;
	bh=s2oJi5OGtytvWKh8J+5v3jAYAjZvG6ci4Mk+QuIm++E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nszwZTca1n771Us56dCepub+3VvHF5P6sxno5cka1m1DGQVNe+SnrHiM/CfOGdKFTWBortMXlzY3pDK29jU0a5ds8DN1dllN5n88QUlhqeDQPViXrZ2y8hQ5Q8KwrMsITHgBmZz04O5mgdTWW+uV88LcabhTixLdYGEzsdBmgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91E66FEC;
	Wed,  5 Mar 2025 01:53:20 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98553F673;
	Wed,  5 Mar 2025 01:53:06 -0800 (PST)
Date: Wed, 5 Mar 2025 09:53:04 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
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
Message-ID: <20250305095304.GF13418@e132581.arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250303093853.GG2157064@e132581.arm.com>
 <Z8YYY2Q_ZPIaZ74g@google.com>
 <20250304113350.GK2157064@e132581.arm.com>
 <Z8dJ00nIeVqMMncD@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8dJ00nIeVqMMncD@google.com>

On Tue, Mar 04, 2025 at 10:43:31AM -0800, Namhyung Kim wrote:

[...]

> > Please consider picking the latest change (either the whole v4 series or
> > just the updated patch 01 would be fine).
> 
> Sure, I'll add v4 to the tmp branch soon.

Thanks, Namhyung!  Also thanks Adrian's review for v4!

Leo
