Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2050D2DF6F4
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332232; cv=none; b=QI3QgAdG+3HhySvaIO6RhwSxqDSVexbZIXq/bTnHFWbTOz39fEQdy1J2Ub1yKdxPJMmIgHglFCdlQ+YSzoSpxdcJUR+pAICAUX6VlvkqBstGQfhc8tNwf9jrYAthQzPp9ZeN/o/iQcfgY9fk14roSNh0QMfCulOv0wHLSOsSpbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332232; c=relaxed/simple;
	bh=fDeOs13L/MBQnskCcsSM/GlRV8A/x86Rpha792DuFoU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bWD5vZo9mf8JCyHaLIYWRX/zlv9tQhuHCGbg4PZ2AEXGV2dEABz6TMM9aemQTbAzBzvwvts8zj0mvcvpUNhXk2W+SeFPAP+bZiyrAR8cxLLgpXiJKdDO6UQnEL1AeNhtGVsVQ+W5lX7rApxNfl4qWYCAWGmBN480xaBeRHYTwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPfmkAtN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPfmkAtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DE2C4CEFB;
	Fri, 24 Oct 2025 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761332232;
	bh=fDeOs13L/MBQnskCcsSM/GlRV8A/x86Rpha792DuFoU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=mPfmkAtNytxn0TmbXYfsEQ4RfA6GyfXfNX8kc7TlVF2/Sm80gLZMmeBufd4/eU2Jr
	 idnysyD23rd9aBTq9n51eWOILqOSvHjXV5lOFcHUrtujz/LtqZyoLf5trlMTVrunVC
	 WZNVphvSPDG6CzUokgesoJrPNJqWf59HpFZGpgDBulRfuVj0h5D2bLwmMMCoJFJKXA
	 WVL5wCaxgjjiO2qw5tLkaF+Oi5tCu2yHT+/X2HDXPV7xZVV8booOmydG5mSrVKxwON
	 geXtsfCVhh0zwCkTwTFZv2uGeBh/1qbrkSykDK2RhKmfMN99BmpuAZ7wHJ0UFK1jOY
	 zpDeD+vqBMHfA==
From: Namhyung Kim <namhyung@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
In-Reply-To: <20251022142849.1537706-1-leo.yan@arm.com>
References: <20251022142849.1537706-1-leo.yan@arm.com>
Subject: Re: [PATCH] perf cs-etm: Mute enumeration value warning
Message-Id: <176133223155.3710582.11738125288265656189.b4-ty@kernel.org>
Date: Fri, 24 Oct 2025 11:57:11 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 22 Oct 2025 15:28:49 +0100, Leo Yan wrote:
> When the OpenCSD library introduces a new enumeration value (for example,
> in the v1.7.1 release), the perf build fails with an error:
> 
>   util/cs-etm-decoder/cs-etm-decoder.c:600:10: error: enumeration value 'OCSD_GEN_TRC_ELEM_ITMTRACE' not explicitly handled in switch [-Werror, -Wswitch-enum]
>     600 |         switch (elem->elem_type) {
> 	|                 ^~~~~~~~~~~~~~~
>   1 error generated.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


