Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520D36F40E;
	Thu, 19 Mar 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941076; cv=none; b=PuWLk2tWSmPOuPoFfzL6776t/iaTi0j0zVeaJ9BUoV4H2mtsWnhUazfgUwkZV8sca76lYN0Qfgo00eYfvIx3ZmGay1LAPNUecrPVxWUJYRpl6NlmP2nH/Th0X9xEaBvy1D2ckt8CFTbc5c69Gaf8n9qSDkPdrJQfI0r10GGseeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941076; c=relaxed/simple;
	bh=JvTLHSOBhUF/6vqMPnvIVIvuJSrupAXFYpy7t/Os+hA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UBVJhHi84lTRPmMvX9xzH9vKMCCpOQdDAOXGGjlAu9o6366vAmFnYpO4XOizbkWVKr+9vgEXkp3BCRA82QOi2AqJWBj7ErLeXpiYvxQPWzCRPuy2in7sXgYiSn0o7DuMIK7lpTb8laVrqu2/6R+UU/zw6m52oOv870LvBcn+ccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmk5gZFU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmk5gZFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0829C19424;
	Thu, 19 Mar 2026 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941076;
	bh=JvTLHSOBhUF/6vqMPnvIVIvuJSrupAXFYpy7t/Os+hA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jmk5gZFUCxSCovnK7nD+Jsq2UsCVCC0wI771FK/M/zf6A2N2FEa2gUV5/sSOih+cY
	 tZHkeSkauFuzbgJox7Ev51Bu7wuTdYxZLlHlOgVr1Mr4psOa4o4qzZY0AAKiXBCvUU
	 nTNz0QuQJPA6VB1jj9smFPMv3H4yq6FdWPpq3kdssCjq26kdZbnquOrRrkS4tJieTC
	 ehkw9/VGF6trhzDrbAPLcAizLjzesT5A1/0aTk5GECHjkpO3kQqqO2sKENujThZbGb
	 g40tWfLQkvZkTgyQGsKoH8OABVKsRDLFNQBct7WwLjvCYP5xMTz2JEJSuW/7S7QLy4
	 4FLeSO84DdC5g==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-kernel@vger.kernel.org, acme@kernel.org, 
 Mike Leach <mike.leach@arm.com>
Cc: suzuki.poulose@arm.com, leo.yan@arm.com, james.clark@linaro.org, 
 peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, 
 irogers@google.com
In-Reply-To: <20260318103640.464982-1-mike.leach@arm.com>
References: <20260318103640.464982-1-mike.leach@arm.com>
Subject: Re: [PATCH v2 1/2] perf: tools: cs-etm: Fix print issue for
 Coresight debug in ETE/TRBE trace
Message-Id: <177394107584.14914.545377108953674625.b4-ty@b4>
Date: Thu, 19 Mar 2026 10:24:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-02735

On Wed, 18 Mar 2026 10:36:39 +0000, Mike Leach wrote:

> Building perf with CORESIGHT=1 and the optional CSTRACE_RAW=1 enables
> additional debug printing of raw trace data when using command:-
> perf report --dump.
> 
> This raw trace prints the CoreSight formatted trace frames, which may be
> used to investigate suspected issues with trace quality / corruption /
> decode.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

