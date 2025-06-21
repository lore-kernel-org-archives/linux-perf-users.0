Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8D26A1C4;
	Sat, 21 Jun 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528883; cv=none; b=ccznRkMNXXZyc7UF/7wji0XBauiEnHooTdzQEX3mZsluovMiXoEZbDRBQEdgCrlTVBlQ9r0YP2+5qyvBFIjORDux4RSsoBuhkl7P+haHvxp+21cyN3wDS/ehX7fZeT81ey+EjXRR0FtOKaTsCO0Q7+kHru22hmfATN2/7KUVDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528883; c=relaxed/simple;
	bh=6zQZ72m49x1BcZdTxFSIRG80BSi2SlJFEib2qVHPMgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LZjAf5L3rkWmJMnnoPb2ffO0AzIl002aAmbcthdyZev8ZjcHpFkgmAh1x6FTAdO/zIdYEC2azL4NgM1xO8FTJpqv++Zv0QT59t5miYNgPGgcCRM9rIUSUpo8VtNVoBsr0XaDG7Lm4FbxSVvt1jxMsQeX6yb3FwFhCCKKwxwd+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gikyGOKa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gikyGOKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E866C4CEEF;
	Sat, 21 Jun 2025 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528883;
	bh=6zQZ72m49x1BcZdTxFSIRG80BSi2SlJFEib2qVHPMgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gikyGOKaNN3UWupxtcGbbZfOpKRECL2eeOR5oHsfStRzZPfecUebV3urg8z+XkNZX
	 jZFp58ACbiTQgABw3bGKQkH4c7INXx26gWAmaroQYNbRxA/eDcLCJ2egg8Wa11aMxT
	 zarUGtMXJ5cp6WcAg1k0GenOBqruflt4RgbjdiefnMQz7o3+bikLf+xeoQY7Qeqso3
	 5FPbKJGjr5yKkI4xqw9GKQd79ZvTto8c3bkg31XTVQAG0kizHQ8ucSDGC/TuTP1KBt
	 p25WprZ7qnphA7mvM+yIAgIsf3RRtXpdkCp4PLFF9+LsnIOwNBkdeQkdB0uo+87rRY
	 3zJ5Kv6O72Rrg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250606225431.2109754-1-namhyung@kernel.org>
References: <20250606225431.2109754-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf parse-events: Set default GH modifier properly
Message-Id: <175052888301.2250071.13103878674887305698.b4-ty@kernel.org>
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

On Fri, 06 Jun 2025 15:54:31 -0700, Namhyung Kim wrote:
> Commit 7b100989b4f6bce7 ("perf evlist: Remove __evlist__add_default")
> changed to use "cycles:P" as a default event.  But the problem is it
> cannot set other default modifiers correctly.
> 
> perf kvm needs to set attr.exclude_host by default but it didn't work
> because of the logic in the parse_events__modifier_list().  Also the
> exclude_GH_default was applied only if ":u" modifier was specified -
> which is strange.  Move it out after handling the ":GH" and check
> perf_host and perf_guest properly.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


