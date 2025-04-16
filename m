Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73422D4DF;
	Wed, 16 Apr 2025 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789356; cv=none; b=tuuUbOm59Ezc8baxIWcH63siwK/uUvcty5t4u7t7dVbkvNTNmQwI3zVu0SaJYUVqEIPPnx7EU3sE05rm9tbRy5Ucg+golB4rCt8oGV1vOvWF/m1rPwjwqF9YnBaOeTV7oENLvjU1hRn2mtVu1sKHcjZfmTOLRRWTj9I4bKkzgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789356; c=relaxed/simple;
	bh=Jz6qHTg8Q8zRmoy99ODS+PiAJiETvWfoBcUY75LwSgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmvqL+sGEHT9ozbarQ0nU42pGIH1UU7cPt3L1gmdzCaj3NENiQak4zVMNqB3bGBrPSmEU8M1XQRFY/l++aFD7KCzwDk9uZWkaeAmn1hxrHB8TIKhqFj+4h8dsWrtd48dmIlLwzBeq3Ul7EEr/T9Hsl7llfP6UqbSqW1ge0jwK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dgkw2Eer; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dgkw2Eer"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KYd5npbJzyzOtmH5HG/Rke9Rgxyj9IA+KROKFQ48knQ=; b=dgkw2EerY+ijHY0llMySBA1oxv
	xSPZge946AAbseUxLprw1dmHPIe+Ay0niuuilqJ9xf49w160AavLss33BZyxu6U04clsa0Jzbxnw5
	hLaS8Sc8ObsVLlseuWOJkFq1tOFOzNGEe2RdsyOksxaKexJEf+xvSqS9M1L6eIife4lKDBIYHA+rT
	nTnZ7YW1EOOh79sltbW7nF7QsF00Qwvy25XgD1rJUq5hESeFhT48NdjJvkuk1IlGCph3jHJlE21XU
	6mBPMTuCF8G65GKfwJRIVaRAykcU7gXDrGwCDpyB+/WDjSHaVpkeCWZP13NdSeKGlsLXybawFzFcH
	V16L9j3A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4xPe-0000000A3y0-1TNG;
	Wed, 16 Apr 2025 07:42:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B917B3003C4; Wed, 16 Apr 2025 09:42:25 +0200 (CEST)
Date: Wed, 16 Apr 2025 09:42:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 00/22] Arch-PEBS and PMU supports for Clearwater
 Forest and Panther Lake
Message-ID: <20250416074225.GG4031@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <71ba0725-04f5-4142-8536-b5c17d2d5e00@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ba0725-04f5-4142-8536-b5c17d2d5e00@linux.intel.com>

On Tue, Apr 15, 2025 at 11:21:30AM -0400, Liang, Kan wrote:
> Hi Peter,
> 
> On 2025-04-15 7:44 a.m., Dapeng Mi wrote:
> > Dapeng Mi (21):
> >   perf/x86/intel: Add PMU support for Clearwater Forest
> > 
> > Kan Liang (1):
> >   perf/x86/intel: Add Panther Lake support
> 
> Could you please take a look and pick up the above two patches if they
> look good to you?

Yes, I've picked up that earlier 2 patch series and will pick up the
first 6 patches from this series.

Thanks!
