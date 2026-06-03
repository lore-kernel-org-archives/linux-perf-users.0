Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01CD37D104;
	Wed,  3 Jun 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508964; cv=none; b=fSBQQ4t06KoZX2kDO4cSUYkrtpUSEGAzXIjZBfmFZFSgzm1T5svmIqtVwClsieEXItfjW58+4rXHgjBeydLFPJ3zJ7e5xrLrgmIIzD3F4qIC88JOzZYRqbeYROhdrdtN4gfqZKO5X1Xy2x3acFUtGte2skzIOlK+wawxizZJglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508964; c=relaxed/simple;
	bh=rW0Bn8SPJq/CTsrzRlIkxVsX1j3pD9AY/d09Fa3R+G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn++8eCrjH7ltp8xAmoNSkhLtxyGEAh07H/ZNp2Oq3SRaYmRhGUBl6nE84ngkye+KY+MiTafCOJUH4wiubvMMb4edKxdb5x/wa51pFIjncQHP9D6pn1IEIUocOOi7rou+10yeKVQahka2pfSnOd4dHkpNwnL2hoV5hb49KLlUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EvhBmUc7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EvhBmUc7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31AFE32E4;
	Wed,  3 Jun 2026 10:49:17 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC1683F632;
	Wed,  3 Jun 2026 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780508962; bh=rW0Bn8SPJq/CTsrzRlIkxVsX1j3pD9AY/d09Fa3R+G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvhBmUc7QNFxVWg/USdhn+yGl1Kd2ZpVRf624VY+VZP5lPdsg/ltpdmJDdiIkBTFw
	 +VmeVVr3jdTEwoJKNszzmxCGPEV5PheRucK7CMdIHwlPwoKfFtpWdW7wVBU1PNoVsI
	 K+jMpG66ImkVEl3helzzLCofGGiqGrgLNyfQH7tY=
Date: Wed, 3 Jun 2026 18:49:19 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 16/18] perf test cs-etm: Add all branch instructions
 to test
Message-ID: <20260603174919.GH101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-16-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-16-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:58PM +0100, James Clark wrote:
> If we reduce the number of samples searched to speed up the test, then
> there will be less chance of hitting one of these branches. Extend the
> regex to cover all branches so the test will always pass.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
