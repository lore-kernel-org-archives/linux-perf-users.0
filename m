Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A902AF10;
	Tue, 13 May 2025 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164919; cv=none; b=e9VJyM+jAY/Mhn9DQrfumaABWEsVZ/DYnXyxlTtvw2fA2GgScyd5MtiHT/mIKsAbn1Hjty2vlfQ3EzW+V4PGvK4Go6dR4B89Jb7wNlnHGxioPc3wnNFKfs/yfHiTd5Laz+kIjZ2Ph53ZeskhCkm/1FL4diudj/T8UZx0nOPzfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164919; c=relaxed/simple;
	bh=NKW7fWAMGx7vuDsNqjWG++yNI1YSSBcCdp2F3u9Eoac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owrfMXhO2lI6lfjhPWbgu1uJRQOO/hi8uqxWkwbQByn753/EzpQI6PmCvlz3dwERK+N0Ne0kJaqIkElvaXeETK03cPorj4BoDB19mDQ1t1UZn+MDos/yNr4FeEfVmw8bSw69aBxSywig607QRA5iFehR2gK+oh5dRdPRq66JpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHamqIXR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHamqIXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0F9C4CEEB;
	Tue, 13 May 2025 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747164918;
	bh=NKW7fWAMGx7vuDsNqjWG++yNI1YSSBcCdp2F3u9Eoac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHamqIXRvn5zOEHqKLiHjErflvpdj1JYDOAJaGK492eYJZHRqRLtCf9qOGdINcmHn
	 HickgvddKLqBo6Y1oYFVI0FevwPcq0CPmlQuPY4Yw7ZLG+npgTOkMy5Q00qOG0hGym
	 KPNgdZcvoTF40UX+d85nAf0Wgcx9w9e/7VAHIbZCdS0Ik8IzZtBzyzMFx8WDLwKbwH
	 Kob6qDqGMhn9tJlg/eYGOaVs4PEKZ29NioKEHzq5LQLY/LraZepBwNU2NUFoxMT1vt
	 y/UzCNPGbc49/AU33iuNA+BSG3cKIY46Vd9507gRXXZX2vPClLGe8egTjz+0u1rhtq
	 B3BW2/RxzqDwQ==
Date: Tue, 13 May 2025 16:35:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	John Garry <john.g.garry@oracle.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Metric related performance improvements
Message-ID: <aCOe85iNjzgIW1B-@x1>
References: <20250410044532.52017-1-irogers@google.com>
 <Z_dp7E2wtSek-KHo@z2>
 <aCOewZobRD1dPrl4@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCOewZobRD1dPrl4@x1>

On Tue, May 13, 2025 at 04:34:28PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 09, 2025 at 11:49:16PM -0700, Namhyung Kim wrote:
> > Great, I also see the speedup on my machine from 32s to 3s.

> > Tested-by: Namhyung Kim <namhyung@kernel.org>
 
> I'm collecting this for v2 as well, ok? Holler if you disagree.

BTW, in my workstation:

Before:

  root@number:~# time perf test "Parsing of PMU event table metrics"
   10.3: Parsing of PMU event table metrics                            : Ok
   10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

  real  0m9.286s
  user  0m9.354s
  sys   0m0.062s
  root@number:~#

After:

  root@number:~# time perf test "Parsing of PMU event table metrics"
   10.3: Parsing of PMU event table metrics                            : Ok
   10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

  real  0m0.689s
  user  0m0.766s
  sys   0m0.042s
  root@number:~# time perf test 10
   10: PMU JSON event tests                                            :
   10.1: PMU event table sanity                                        : Ok
   10.2: PMU event map aliases                                         : Ok
   10.3: Parsing of PMU event table metrics                            : Ok
   10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
   10.5: Parsing of metric thresholds with fake PMUs                   : Ok

  real  0m0.696s
  user  0m0.807s
  sys   0m0.064s
  root@number:~#
