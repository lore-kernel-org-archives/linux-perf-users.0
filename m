Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A847C15ECCC;
	Wed,  3 Jun 2026 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506756; cv=none; b=YDxmCML9S1lWfOrEeZdt8mb8ZIfwHJIsC6AqVOajqgfXgmv8pt/WDaizM0Fv4Exrqv2KePR+gN733zQ7xQJ3dLOCmE0fui8pgIPk6MYrqWn8FP7bU1HbSTV++jaPpuT+1E1FeYYdyXceuW6E3uM1qXvqcU7gFyp2/FFvRh8dvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506756; c=relaxed/simple;
	bh=/vWRA/BU+uqdw/xlSamShXJibi4CtKGGpZV0RcYVwk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvbomM9BA6KRZCaskUvh0dX7BfUORVKoGPT4nxj2HTzxPQWked5TNHK4HfZpqlAErLFRDI7zQlOGvbIIODseYyv5EBFHJ1xbTY0860s1bMiFcFyAKamVsqHixlj7bUJnF1jxSFU9rgmulbs5U8tWMtHNOHRfQoJ/r8/bueJooIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Gfs3A0Iz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Gfs3A0Iz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 270F1307A;
	Wed,  3 Jun 2026 10:12:30 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D8A33F632;
	Wed,  3 Jun 2026 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780506755; bh=/vWRA/BU+uqdw/xlSamShXJibi4CtKGGpZV0RcYVwk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gfs3A0IzYiygMT7yUvzbOBtQcIkFgLg6Uzrx70Pl5qVNZy4bHQDh/VSyoNK7WyNB1
	 nAcB+i2ogiITJifqlQXEJ+33KyM+sU3EFOTUHW85kAnrA5o4ovW8dVRnXWxV1WOyiG
	 2qBPvOa2rTMaCQgAQwkwDopihl5PkanxOgcoSJe8=
Date: Wed, 3 Jun 2026 18:12:31 +0100
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
Subject: Re: [PATCH v2 12/18] perf test cs-etm: Reduce snapshot size
Message-ID: <20260603171231.GC101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-12-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-12-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:54PM +0100, James Clark wrote:
> The default buffer size for root is 4MB which is very slow to decode. We
> only need a few KB to verify that the dd process is hit so reduce the
> size to 128KB.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
