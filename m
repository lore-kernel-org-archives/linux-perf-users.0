Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AE15ADA6;
	Fri, 22 Nov 2024 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313869; cv=none; b=ZUmjK/yj54g+/7yrvspM80uYxf3vLuHhDIJJdZ1f6+ly8IA8kCv43w5iE+OvAkaS7QIVLVysfhMcJtDqUuKaHYXhGmCe6hYlSf0vp6XkNOGxtSmmRfKigsAk00kv4Sw2j9D4vSQZpWYYpAjCrTxym00k+JQIZEHjIJKQsh52REE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313869; c=relaxed/simple;
	bh=YoTyYNBTwd5oFShK70a7bXiii0fT5kU01Am5pDUenj0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GhU3T4o0yOvEakvQUHWiV3Y7PU5dE4t3m08Tju/9pP3Fdg2jC163gg372pJW8NbFZWsVZNweduD8ainPVjlvML68SKk5iwmkuEJqIUImb6wZBBCMW2VkjbQUCLBwvsvQjEDcfY7FsFLeM71rK1PbzvBNcJT4E8eI7AL5w5f8inw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWGYwhWR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWGYwhWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3140C4CECE;
	Fri, 22 Nov 2024 22:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732313869;
	bh=YoTyYNBTwd5oFShK70a7bXiii0fT5kU01Am5pDUenj0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fWGYwhWR2JNy0dzVswENeCidVsQ59sZ7owljYhxnXojpWWuUBuqJ+IKlfiRKGwape
	 j0cO1O02d3N/HLOCraxZDq/h40kS+ahu+oFzuGlNA6vNovbxoRDMmIjyj8y0paJvHS
	 J2GReEznqZ5lJAuZ7zKffUV3qi9akt6tPMrJGNj8g50Trpq7FX4DMs1SSoMSHqsu0a
	 OmH1+YMXzNBtqjZdsruduTBAr1PEB3lfJVBpI/imd66mN9aUyQcDPBqV/f5IANwf75
	 LdTCR9VkeDHMqbXJqzggO+ZL7BgHSbIZMGSXEOoFEmJNiBF0cCR4EkG3zIMuLla2Py
	 mnhZsuozvfKjw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241118052638.754981-1-irogers@google.com>
References: <20241118052638.754981-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test: Correct hwmon test PMU detection
Message-Id: <173231386873.85365.16380200855751649106.b4-ty@kernel.org>
Date: Fri, 22 Nov 2024 14:17:48 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 17 Nov 2024 21:26:38 -0800, Ian Rogers wrote:

> Use name to avoid potential other hwmon PMUs.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

