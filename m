Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B46F2F2;
	Thu, 30 Oct 2025 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795977; cv=none; b=MavTZ+4E7NYVYp6DIZN3hOe1aNGpY4HFSf/WtgDaKvuNYh7TihgeHqjy+TNS0tbU1t9Oz19ie2dVg8wDIsQ05BgMevVwODpvsefmthDg6HnvcCUUq+qqpngfta2FkWE/EKExfkqUD/7ZHhx/xyqfi4SLUkL1awp99foCGhHl93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795977; c=relaxed/simple;
	bh=zRImOtARLNLcx7HCBYvTAml6pzycx1cwqrtnyIyxVfE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VxQ62sjobpH7BdzGcutJMUwoZM1NFmP/iyVGjbhj8+0RahJjMZK8rv4nvStkADBbavkYuGwH8dBxWsYgPsf5fN94FykObPSrNy+cMSEPRukmLNaQtY5c+0gG+9Z2t8sLSNEWv0N79yY7oCwzraTVAiUsk3kNNuDclsU6dPGBJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnlWHS67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnlWHS67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BE4C4CEFF;
	Thu, 30 Oct 2025 03:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761795976;
	bh=zRImOtARLNLcx7HCBYvTAml6pzycx1cwqrtnyIyxVfE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=TnlWHS67HPnzZjjwm/FBFdacBDNPmDVK5XCCx0tv6EEtOHuv2IdFTl4JAIIbTmLo4
	 eikie8PtubJCsaDD3C1gDVQ9v4befwDAxjVgqqw5MoEa7eYzdCDJthlufSyL/GK1Gq
	 s6p0HMGsk3N9KgmYWzF6kwJlFszcAV29ngrTPiF1kyJoStN4wr1+MXZHyTTSaVbJqI
	 8bJC9JVftkxFNs8Is7Qfbd+BeBpNar08sDDYOiM2bGkEjIaQheKI8SCB1nlVsnex0t
	 QriAJOjtaRBRE+A/Ow/yTi2fWFRTE19RJlNx4FjgMurlLVXybHXT9SplFsDGNl0CAa
	 iA7VjQ2Cyj+yQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251028153821.4003666-1-irogers@google.com>
References: <20251028153821.4003666-1-irogers@google.com>
Subject: Re: [PATCH v2] perf test workload: Add thread count argument to
 thloop
Message-Id: <176179597624.3104145.672105800878866289.b4-ty@kernel.org>
Date: Wed, 29 Oct 2025 20:46:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 28 Oct 2025 08:38:20 -0700, Ian Rogers wrote:
> Allow the number of threads for the thloop workload to be increased
> beyond the normal 2. Add error checking to the parsed time and thread
> count values.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


