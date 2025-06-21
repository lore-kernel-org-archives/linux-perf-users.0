Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78026FA6A
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Jun 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528884; cv=none; b=NvhJLOZ+KQliF2YDIVK0wbufs/GhiPusvUQhJrjJfFByI+6mygSyHH3Sn+haKA0Hfdnv5oZd+Q9eZ9jfxwTty+YlfxVwVxtjSWH3AMin+JX3IGDKY7HY1B6HexktGYWHe7IoFidQirmJTi0G6/AVL46g9f0tl6rMY7BWmsaj5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528884; c=relaxed/simple;
	bh=sR9JR+tUUFclApmMgvW/CApl9gGChfm8csup30EGPV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qv7gymHdmz/esxTnv2DJaOu38OOjgXeh5SME6V9l+HnOfMOiO9e/6hf5c536R23d3rxB6nZrvWGCwrw+olHEn4XY70F/tCjyjKwDZy2EBMqM/T3rx5/7TzqAAEtuxTAK7390nu7xMy922q/8j1lisUSpvgvPC3FiHH98fFcsbzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sARhiZ3w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sARhiZ3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D9AC4CEEF;
	Sat, 21 Jun 2025 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528884;
	bh=sR9JR+tUUFclApmMgvW/CApl9gGChfm8csup30EGPV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sARhiZ3wNAuo56LUq1CNe/OeLGcveWaigxmSrLr9ew7u/lBGvxCsBgbfBEJwMuv5m
	 bLQtIsUwjyovYx/5y4bJxxwQoABzlsb8MBYUzQ0kX3YFj+WJNGL08G+eWGAht5xRmy
	 ZdrQT/MXeYMB/fuy24M1cptudoFfxmHDYTJ/00OQj5t8C2CwBtn+zcO++QvKxcd675
	 ak5dZNlAnQq8KUa1UuUXebHmZqCl9urTGAUH0BT+FS48m7bG5esVEhy3DwXg1mBrSi
	 OumLAsOh6EPpKBiUYWiEpWfhqc8N++Do4kMnuxWos6yvJZQOKKiWyV0hx2gOvd83yU
	 /rYQtJulY5PAw==
From: Namhyung Kim <namhyung@kernel.org>
To: mpetlan@redhat.com, acme@kernel.org, irogers@google.com, 
 linux-perf-users@vger.kernel.org, Anubhav Shelat <ashelat@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 dapeng1.mi@linux.intel.com, james.clark@linaro.org
In-Reply-To: <20250618142921.4053400-2-ashelat@redhat.com>
References: <20250618142921.4053400-2-ashelat@redhat.com>
Subject: Re: [PATCH] perf header: remove unecessary core id test
Message-Id: <175052888391.2250071.15507491189551553762.b4-ty@kernel.org>
Date: Sat, 21 Jun 2025 11:01:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 18 Jun 2025 10:29:22 -0400, Anubhav Shelat wrote:
> It is possible for systems to have a greater socket id number than the
> number of cpus present on a machine, so this test is obselete and should
> be removed.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


