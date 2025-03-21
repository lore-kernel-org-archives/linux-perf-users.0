Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2522FF37;
	Fri, 21 Mar 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581809; cv=none; b=GwYIuEAPLVoltXPFfZh/JuoKryWfgnekQqyZ+prLTQ8NBc26HjDOr4DXjVUrwe9jTqBXSI45HBWs8xWmqGWzDwVJ2wuJzUm5xKl3XD8RfTWkuUKgM+ERBJoxZPha1VxqrpHzC+A2Gpqf6ne+JwGw0i1VeYmV0QVroFMhbJOQWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581809; c=relaxed/simple;
	bh=yr0HsmTDZnI304hBonkyEV4widgyTxAQ69tprlnifKM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MspDbczJzamVzigX6uCfertNRVczgLLAPNh0uoS4Q3p1yQ6D0w1ZDjWB9a1+/toKURFVY6xZo91t5R4RNefPhCHRNJ8plb9nIwUIxPNkFHRpUavWGgxnbpGc3IWkySCaLGENlGgkFAC+Xeeo8vSfynd8vM1xBT3UNR3nqPxvxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni9zuw0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni9zuw0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EE5C4CEF2;
	Fri, 21 Mar 2025 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742581809;
	bh=yr0HsmTDZnI304hBonkyEV4widgyTxAQ69tprlnifKM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ni9zuw0GoBvQ/nQmMiZoTDkaeyPusps56xz52dal3hCVmy6cOnaj7uA2oHk8nMuEg
	 MF+egbCGjmN6YQKNDfI0zIIIf8A9WNsEpAqCOJxgwLwJ2OOeLQYIYpz6js/b5QAQsN
	 75fPXXC86LJoFNgLjs3LK7BOH9gotB9ggCh54BIKsqVCTdjjiTE1aauT60bjNPt8SZ
	 tTGCgtPKHGyRgqTIkU3a2VuZT695pdmaJ6XJnfVP4Nk3uN6YFjbzvXUIjdjHjbiUOY
	 UJguw0i2deMRQ+NF5dFEbfgfu7+Awuor0BryFYx5+RKsiQu/VA7stk6fbToPXqntjD
	 7GQcf1CSG+Lcg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
References: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
Subject: Re: [PATCH 0/2] perf vendor events arm64: AmpereOne/AmpereOneX:
 Add a new errata and fix metrics calculations
Message-Id: <174258180865.163787.7449214813728278320.b4-ty@kernel.org>
Date: Fri, 21 Mar 2025 11:30:08 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 13 Mar 2025 20:15:57 +0000, Ilkka Koskinen wrote:
> Add an errata reference to a impacted event and fix metrics calculation
> caused by a scaling issue.
> 
> Ilkka Koskinen (2):
>   perf vendor events arm64: AmpereOne/AmpereOneX: Mark LD_RETIRED
>     impacted by errata
>   perf vendor events arm64 AmpereOneX: Fix frontend_bound calculation
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


