Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119121422F;
	Thu, 20 Feb 2025 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075973; cv=none; b=ZLFNi3MyNHaM9Y0tqAUzG6MJJebi3gmpau0+JXdYVU1ADJcst0UA/2ZK5dvrjEW5EsZrsVzFHe77heAEljryCaAI+PvOWoI1Xqp/YA9GBKyZKmYd+s/EbU/TifMDpQHi/DfMGJ0OBw3oWRwGASCyKjX5JuDgS7Xy5rQ0VOn6cGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075973; c=relaxed/simple;
	bh=rUQMs66UtMND3Tcn4rZz3B4Zw/4rIqImK2WI2ZjytM8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HAfP5W8zoxWNYDIdY/RjCiDDcaaNkzNzf+Px0k5SK94WFCTGLOjQmz3bw9xSXfWBOMCeXHGApxj7PWC+wXZR0Dgh6ozJRluACmKDwxOhmR6cqvVPCplAHzuqYdXq8pgVovVvQuwbtG01eCj31SiXPAeNylX+tPTmDY37D/sUoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQMP2LdS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQMP2LdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC4AC4CEE4;
	Thu, 20 Feb 2025 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075973;
	bh=rUQMs66UtMND3Tcn4rZz3B4Zw/4rIqImK2WI2ZjytM8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dQMP2LdSfCm/jtzgsouRHxGvTSM7TR1BBE50uVrJ5oDNBo09L70ekAdkSD2eWUcW9
	 /GrUA8VQpjzErYAtumhUD04mZTY3l5hxXMra2NOHVZVh+tl+vRs9FEQRdzgS+wj5jD
	 L3eftL3GDXD13FW+kP54bCCQv0FbYuKgvT03ewGwGGzD0aX+bj7jXapWQnhQmmj9CX
	 p455swwQHpJMNP+LEHBvlxx72DbtBe6LXh5jh7teOQpHO7CwvOyzgeQK5SeL22pvns
	 LxFO5TtTzBf01FxseyxSSgxKq4oFfdxHjEuhsi01oklmBd4/aj0mD2iaV8soCjvxNo
	 WrrnRewY0qXOg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <2025021955-implant-excavator-179d@gregkh>
References: <2025021955-implant-excavator-179d@gregkh>
Subject: Re: [PATCH] perf: fix up some comments and code to properly use
 the event_source bus
Message-Id: <174007597292.1790567.8180370887868623106.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 10:26:12 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 19 Feb 2025 14:40:56 +0100, Greg Kroah-Hartman wrote:
> In sysfs, the perf events are all located in
> /sys/bus/event_source/devices/ but some places ended up hard-coding the
> location to be at the root of /sys/devices/ which could be very risky as
> you do not exactly know what type of device you are accessing in sysfs
> at that location.
> 
> So fix this all up by properly pointing everything at the bus device
> list instead of the root of the sysfs devices/ tree.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


