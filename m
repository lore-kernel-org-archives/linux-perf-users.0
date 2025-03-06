Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83D2144BF;
	Thu,  6 Mar 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281250; cv=none; b=W+0VkMu9PUPn8JAcoEymQ5CUge3TlGYKWtEBWRCbIUujZIMerkRdvAFN/BkTZyTwCfBPTEVY0duLKu7+QPSOYnySmaZkBrvxewgehtaUW//twHr/eHFIYnxP2XOCgcg8bu9vX6NxMCGIeKOyDDYEYRmIBfj1KNOfIdXwVyUqu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281250; c=relaxed/simple;
	bh=NPUYXr/d1bwO11II4JoeaNIFdDgaiz/ixDVzQSUkWNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s0Q1wTAxQ01wAHC2mq3GnglD682Nl2g/g3ui+ewzVtCD4O7r9epfv0G8ZQjeknRChXw42eUI5P/vfbbSPfW47K2nCdDwuHyJfsrdZ3XkjuhXSqMV9DY5OaN90i4zsBDfe19yAb7OLIiIWMRyzK6M2rOMUDGJm1hD0ivbo9XzwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5N9qq0I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5N9qq0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75625C4CEE9;
	Thu,  6 Mar 2025 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281249;
	bh=NPUYXr/d1bwO11II4JoeaNIFdDgaiz/ixDVzQSUkWNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h5N9qq0IYuGnq89Q5ANcSL8n+k9EyqZuutGEef8v00xS1mNAAxFxZcEvk5/PVk9Nr
	 yLZ19fGw64/4wBg5uZLG91KTuLFcYAgwSl8a/UdoGWc+/RbmGf/2qcibeG5O3Tg/YJ
	 T2/o1B7aejcSG/pDFsbkyi6Ep60Ozna4RNi2zeeqZ4EvKVNzFQlObrJN31tGukCVCe
	 2HzDTH9LEQBPAYH4biBztnEyipG1apNwBlue/awtPwCrnQiY0eLpEyggGRrkBH2EZF
	 g6WncyRWnz5e7AMgDqLICvLKeznX4CDU+oLOvEfULuHLBIhDRtQLSTv0y/IpgW+xVl
	 ScUnZ6KhhT0oQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Kan Liang <kan.liang@intel.com>
In-Reply-To: <20250305163935.1605312-1-thomas.falcon@intel.com>
References: <20250305163935.1605312-1-thomas.falcon@intel.com>
Subject: Re: [PATCH v6] perf script: Fix output type for dynamically
 allocated core PMU's
Message-Id: <174128124944.3835280.16855059248236595784.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 09:14:09 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 05 Mar 2025 10:39:35 -0600, Thomas Falcon wrote:
> This patch was originally posted here:
> 
> https://lore.kernel.org/all/20241213215421.661139-1-thomas.falcon@intel.com/
> 
> I have rebased on top of Arnaldo's patch here:
> 
> https://lore.kernel.org/all/Z2XCi3PgstSrV0SE@x1/
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


