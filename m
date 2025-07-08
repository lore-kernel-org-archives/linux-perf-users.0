Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B541DDC18;
	Tue,  8 Jul 2025 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994925; cv=none; b=r7KDfste670p6yVXlaUhy2Z6wckEqzInlxX4OoQamVekYAuQnPBW2q3lmJwG6XE2J+CdB2DuM2tKdKOcYOWEQr3vWccy7K87IJJ0PCp0ZYuxNJPPo5DFax83rPQ7tz0S6UH1Ba28+lPResFsNTv0DCvgi65/4slOMCRXU+ES5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994925; c=relaxed/simple;
	bh=0H0aF7cRHHB/Br97rsZdQr6cJ2PDUaga3Bt+QUveVQk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WOLl8n5GNqFNOcZvWGmclibsnEVY79C1DxT1EnH3Bvt4Y6ma94Ik/WarIXTheZG1c+C3RWmRZL79C6KVVZQ+yqDXrWFWtQW0nNCjg2U7XlaRKV1nAXUSvyK2AdMZ3OBWrY5Hp7iK7PZy9ncun4fmmh1m4DgFkry8PVp3GoISCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZstwGqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZstwGqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB58AC4CEED;
	Tue,  8 Jul 2025 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751994925;
	bh=0H0aF7cRHHB/Br97rsZdQr6cJ2PDUaga3Bt+QUveVQk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=cZstwGqeVD86NuqZ6sVHNLn2zaeM/oBrLcmGRw8G4apR9Ejvt92hbm3hvL3Byotgg
	 OKzJp4x6Av7FFF/bHdrChQwIhlNPLheBpCJzme+ZRpgH3qfONBf1JAxdckVCLHr3Rp
	 A0Frr9LAWvxK9yZqdwW5mKm6XcIYpPnNfj4LEz7XUqSc3IcM2AldsaHR6BmcVP57k/
	 amaLPlYkauoipOGTlfkfyteyh3VJ71eenPL7vUkCqe3Z4M5MynOYhrvpeaM5esV0/j
	 BKQP+sNNB6NYmXPxl9OiHgYCZidmbBzthsydKGZ2YvNxQu3rb+hVgJqKzbiRXLtWNW
	 aq02rU2MgnjWA==
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
References: <20250630163101.1920170-1-irogers@google.com>
Subject: Re: [PATCH v2 00/15] perf vendor events: Update Intel events
Message-Id: <175199492491.1307843.10305341895448801662.b4-ty@kernel.org>
Date: Tue, 08 Jul 2025 10:15:24 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 30 Jun 2025 09:30:45 -0700, Ian Rogers wrote:
> Update:
>  - ADL/ADLN v1.29 -> 1.31
>  - ARL 1.08 -> 1.09
>  - CLX 1.23 -> 1.25
>  - EMR 1.11 -> 1.14
>  - GRR 1.07 -> 1.09
>  - GNR 1.08 -> 1.10
>  - ICX 1.27 -> 1.28
>  - LNL 1.11 -> 1.14
>  - MTL 1.13 -> 1.14
>  - PTL new v1.00
>  - SPR 1.25 -> 1.28
>  - SRF 1.09 -> 1.11
>  - SKX 1.36 -> 1.37
>  - TGL 1.17 -> 1.18
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


