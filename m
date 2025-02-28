Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A831DE88B;
	Fri, 28 Feb 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781501; cv=none; b=s+cJgGVMby0tTks2TsTD/MAvePRftYHWrrhgo7msssOxQ/yefTbrmt9AWlVMr+e4Ckf+Dl9c19z9OdHc9GedGDqgUq2WWLH/yjSepR/21GlTM982RJdeaZQQ6cWWp1I8z+2d4vIIjMjwJEITe5qCpyRhNAGQ6BCiA7h73k9SSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781501; c=relaxed/simple;
	bh=nl0RxLxluqEXdwZrRYcWUvlPQj16buT8wUVR1+IW6iM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CHpos5PiEnc1gY4kQObM/VRDCVJPMatcz6jF8yn47ak4OTEE9HZwT7VZofC9JuYyQCr1nlU1/O4LYXYAkegfuQfMUuJYay8K+TiWhU65/3oLlbXuUJg0vuMAFmuNE4j6Rzdln1bZpmJesjyxeWDlNhMNOIM/yxzqY+ew0BWI03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLYoa5ZD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLYoa5ZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6CEC4CEE2;
	Fri, 28 Feb 2025 22:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740781501;
	bh=nl0RxLxluqEXdwZrRYcWUvlPQj16buT8wUVR1+IW6iM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=kLYoa5ZD1tgEpJrzTr028axEhdyIgCeEEujQNZ+krj6mzvUouRhGZQ8em5TF2zHM7
	 ShRDbMBadSb5IAkSXm2Lg+UFy8bZ6fqVLGJNfPTNYRonz2a/G0tf6XGq8oSpc/gyLr
	 SBKjq2MaTK5I3RVuBQMXk5ZyKRnaS95Ubv6CJ+/SY48mLvWem58bPzLjyg5FYJbMVx
	 aAlGcVaLYA+kJ5/aWYyuHKo4CXMQ0ZWNvDUrhfb9PeF6Qaee2pug9/lIDHB+hbBmzM
	 30SeD0ZIw2Pw2yOnV+0t+aj7O+JEmTNFe9pfjQ2wr7bdiNnZuijUgzSESdT57CrWrF
	 Id+Krrv4JXJ+w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
In-Reply-To: <20250227085544.2154136-1-leo.yan@arm.com>
References: <20250227085544.2154136-1-leo.yan@arm.com>
Subject: Re: [PATCH v2] perf arm-spe: Report error if set frequency
Message-Id: <174078150058.322575.7287434251293207744.b4-ty@kernel.org>
Date: Fri, 28 Feb 2025 14:25:00 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 27 Feb 2025 08:55:44 +0000, Leo Yan wrote:
> When users set the parameter '-F' to specify frequency for Arm SPE, the
> tool reports error:
> 
>   perf record -F 1000 -e arm_spe_0// -- sleep 1
>   Error:
>   Invalid event (arm_spe_0//) in per-thread mode, enable system wide with '-a'.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


