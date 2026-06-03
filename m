Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A123812DA;
	Wed,  3 Jun 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498619; cv=none; b=Loz2GMM3bSRLrxdrcMmj8TpnyI6GLHz3NpgRanKnizCSPDrECS+mmVu2q72miNkpGrSfYkhdUx+goel0gMuj4IdGSMGPW8A4Njoqsnh4zle7iWHS6TaI+iuwzGPO8sp7ZevHA//6EV87d0btrpVfoVbRXkuR1I+Snk2nWPEpNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498619; c=relaxed/simple;
	bh=mTreqZLmeIh1IGTzSvo6hYoyP7N06HK5Bl5wUdwkoGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxWbR0vawjO5GuHsyXgdUdiTlGTFmT4wdi95A0xlQIiNMCzjIGOXEFOd17YBhhIIvV94DZkZd9ZXuVu01syM3jsSSnO70HbmiItXLijOfni/U+jgcZ6lExm3bYE1XgUzQxvw0CLV1ctVG38BMZAtmlhPAsdmjuKQ+6gDuTTJzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TIu5wIj/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TIu5wIj/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E43632F4;
	Wed,  3 Jun 2026 07:56:52 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99DC3F632;
	Wed,  3 Jun 2026 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780498617; bh=mTreqZLmeIh1IGTzSvo6hYoyP7N06HK5Bl5wUdwkoGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIu5wIj/dPtYD/ElLIxHnHt+p+65aZR1pmL5QPno0UrNq41aF75MHCoSNbX+H2Peu
	 xVaySCSFrf9QWWFhMJQk84iliaKU9sJglKwkmxpO1kSZSsbIAext+UVCSF1C+4Q4y6
	 V73xQ0fTBViiR+ZurcmdvDZ4iMv7wZdziSUWijUA=
Date: Wed, 3 Jun 2026 15:56:54 +0100
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
Subject: Re: [PATCH v2 10/18] perf test cs-etm: Test decoding for concurrent
 threads test
Message-ID: <20260603145654.GZ101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-10-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-10-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:52PM +0100, James Clark wrote:
> The thread_loop test only looks for context IDs in the raw trace.
> There's a lot more that can go wrong when decoding these, so replace it
> with a test that looks at the final output for matching thread names and
> symbols.
> 
> In the future we might use timestamps and context switch events to track
> threads, so looking at context IDs in the raw trace wouldn't always
> work.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>
