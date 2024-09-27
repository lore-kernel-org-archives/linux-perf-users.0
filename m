Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D815C137;
	Fri, 27 Sep 2024 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727417440; cv=none; b=BSnuerjHWjTA3m2K/N3voakL3nKf7bszenZujzcPp1jH+nQN/9RwIGQUzwhdekbmnBRIxD/M/kbdTkymar6EPlRSqfbgujbGW1HKG8vi3S7YaQD8VYV5QbToceSKzMXcX2AbITNisIxyfBUrvput0FeJok/Qfbr+eFrboGz/uKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727417440; c=relaxed/simple;
	bh=+guQvv6fqUt2CbCRSlQmWkFW2t7JixAFrUd924WeMRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh1Wepvq9hk/FFj1A0YfBARCk0XoLyNOQsgxpXt2k1Qh4myhDsFE8TjvJf3vUlsYuW0dxFcD1lZgnaN08itk8l4pXGEfCLxTlJm9xERalwaJvOaZBoqpOIhnWwIG4SEFO2Yn2/InR/PEiyw6Y6con5jqKX/mI6tvrePxyKKfc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/Mu7Rv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/Mu7Rv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CA6C4CECD;
	Fri, 27 Sep 2024 06:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727417440;
	bh=+guQvv6fqUt2CbCRSlQmWkFW2t7JixAFrUd924WeMRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/Mu7Rv9d08wQTX6O/59GdAynImI/WzVIMjJjs6moFD8M2Eel7mfgw+hqAmhHeYRz
	 BbcZkfVF+sNfb1gYr983qzWRSsprwP+ugpThof+O0TPZCyG55gz27d8KP7iIc2kpBq
	 lyaYdEen7h4s+AK1GBh3184xMAoTSPLl9dJubyShtkFz43P1wgSBISAq5EnhLaqzy4
	 kpNIsd7JU4D9WAbiUznxblm/j4SrAtM9A05NFEX3yX7K9Kk/+el4dshgTffPSwc87g
	 xWgN59JG+w3I/mvgJdwZ00/im8MAeaopTnLCg/M73cQ5bUj00QjU3DD0BEtGUOA7FE
	 CXXV0Y5RC7GoQ==
Date: Thu, 26 Sep 2024 23:10:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] perf arm-spe: Introduce metadata version 2
Message-ID: <ZvZMXpLnyzhFMrLb@google.com>
References: <20240914215458.751802-1-leo.yan@arm.com>
 <61d9e213-d2ca-48c9-b176-03e7d01524c9@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61d9e213-d2ca-48c9-b176-03e7d01524c9@arm.com>

Hi Leo,

On Thu, Sep 26, 2024 at 05:20:49PM +0100, Leo Yan wrote:
> On 9/14/24 22:54, Leo Yan wrote:
> > This patch series enhances Arm SPE metadata in the Perf file to a
> > version 2 format and maintains backward compatibility for metadata v1.
> > 
> > The version 2 metadata contains a global structure with fields for
> > metadata header version number, header size, CPU numbers. It also
> > expands to store per-CPU metadata, which includes the CPU logical
> > number in the kernel, MIDR, and capacity values associated with Arm SPE.
> > 
> > This patch set has been tested the perf to decode the Arm SPE metadata
> > v1 and v2.
> > 
> > Changes from v1:
> > - Dropped LDS bit exposing from Arm SPE driver (Will Deacon).
> > - To simplify the change, this series did not include multiple AUX event
> >    support.
> 
> Hi Arnaldo, Namhyung,
> 
> Gentle ping. There is a bit backlog for Arm SPE patches, so I would
> like to bring up this series and the series [1] for the Arm SPE data
> source refactoring (which is dependent on the current series).
> 
> Please kindly review and pick it up if it is fine for you.

While it seems like general changes, I'd like to see some ARM folks
reviewing this series.

Thanks,
Namhyung

> 
> [1] https://lore.kernel.org/linux-perf-users/20240914220901.756177-1-leo.yan@arm.com/
> 
> 
> > Leo Yan (5):
> >    perf arm-spe: Define metadata header version 2
> >    perf arm-spe: Calculate meta data size
> >    perf arm-spe: Save per CPU information in metadata
> >    perf arm-spe: Support metadata version 2
> >    perf arm-spe: Dump metadata with version 2
> > 
> >   tools/perf/arch/arm64/util/arm-spe.c | 106 ++++++++++++++++++-
> >   tools/perf/util/arm-spe.c            | 151 +++++++++++++++++++++++++--
> >   tools/perf/util/arm-spe.h            |  38 ++++++-
> >   3 files changed, 281 insertions(+), 14 deletions(-)
> > 
