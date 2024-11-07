Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42874186E58;
	Thu,  7 Nov 2024 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007573; cv=none; b=XNyJAIYwO7WXFXczt0GK6LmfvSEps5qusN8qTduA3/RSJDYVCyaXTDa3ThQqe20G/8TiX9izPlbp6kK2GRRmr6SQTcVQzEdYPeENjk++FizVNLvDTfE/NuIKeMDsgKjk98ivHKdE9yr5EBm639c1bszAEv3tHf4yArb6C3vBx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007573; c=relaxed/simple;
	bh=gSxeEEMc1rhOTQ3WpSnA7rf/AYqSPCfbi4/aBCwnjwA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VmVYt5U03dP5Vhr/F5LuLmfCucsvCw9lLTbciXtSZLojc1KOg6WGzO4WoNCF99FKFB2D5ILmHDK6LDEQ2XntSfBQkBWAQp41cZGZSeyDvbOgufNpO6uGSg5dXpQx/Kba9RokGnN/W+Gktw7lqs7ZjfNvuw2Eaww8S9ovWHBl7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LStZwvFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LStZwvFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5C5C4CECC;
	Thu,  7 Nov 2024 19:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731007573;
	bh=gSxeEEMc1rhOTQ3WpSnA7rf/AYqSPCfbi4/aBCwnjwA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LStZwvFKdNsRAqoJCvxknjrjx0F99WSH2zJUiJAAGNEL1pUcPkmUEuZf3pLr8RCiy
	 pDnmI5cum1jv5R/5s11P4gcS4mrepZCUXOxeU8/bWo0gJcTyoNeUN8Dsugb0/gjoRo
	 QdIy9lWdoxeO5SHFJuXnwz3xGtJoeFpk+0N43SzsIbrfoqjhwvwiuxF+3NzRiXqB9g
	 mr80Pg7rawf8RSNyHFxaELmAwyH1XzZIQYRWBGBduGiq9WD6sAMC1b7YOg61hnHXGG
	 MLR3SjE3OVpmksPCyAnTvkD2yH5jMdjJ0kLPrAJ68kFBtwXA4KgW5qUFFA2DL/gMWf
	 J415i6O/dMT8g==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 linux@treblig.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241106144826.91728-1-linux@treblig.org>
References: <ZyscLqAzo9Z7Zg02@google.com>
 <20241106144826.91728-1-linux@treblig.org>
Subject: Re: [PATCH v2] perf: event: Remove deadcode
Message-Id: <173100757274.1638101.1803957222550847312.b4-ty@kernel.org>
Date: Thu, 07 Nov 2024 11:26:12 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 06 Nov 2024 14:48:26 +0000, linux@treblig.org wrote:

> event_format__print() last use was removed by 2017's
> commit 894f3f1732cb ("perf script: Use event_format__fprintf()")
> 
> evlist__find_tracepoint_by_id() last use was removed by 2012's
> commit e60fc847cefa ("perf evlist: Remove some unused methods")
> 
> evlist__set_tp_filter_pid() last use was removed by 2017's
> commit dd1a50377c92 ("perf trace: Introduce filter_loop_pids()")
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

