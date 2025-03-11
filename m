Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299725B68E;
	Tue, 11 Mar 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709507; cv=none; b=QClJFQBNzi7zCYAOwOUe2j9zLfPTFuCG2gk8kKI26NdEy3GkVVQKrsVZvPKL/nckgQcpxxyd5ctbNI1xdY3YYtfObFd4da50qI8H4yTmwfEnc3BHpV42uBsq7IcJ1jcwdRBb0oiy4EzFeJdlcKT8U47gNNFFCujzHDU9PaFZ3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709507; c=relaxed/simple;
	bh=Lc0kuMJgIZ02p/W8Xz6bM9+2AvjfrGNgLv2joggmucE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ga1VZWKxlBQNnbqslSKOYfZXnJK2Oos25CRFQcP0As5egf/J37iGeDWdM18B+oxbQ2ffLX52WtWQToZL58ck2zVRtbhgEaulUYAfiXq0oOM6hN2fzEIetB0Vvi5tYtMGcRKcRGhcIJMPZZ5ve8+P0AGtCI2uA3RB+hLwd9FSscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqbVxZMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqbVxZMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6226C4CEED;
	Tue, 11 Mar 2025 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709507;
	bh=Lc0kuMJgIZ02p/W8Xz6bM9+2AvjfrGNgLv2joggmucE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=DqbVxZMJzkIdZUEaqpXdP9/KEzeXH/XVqi2U0sHUzuHgjGOL1zDl8XPjulWWyDvO/
	 HdZEdLxrdO6KytXMAO35WeCum4+EFvTCp9P6HEqUsI+23NX7mucNznpZvfaahehcdZ
	 meIKZH9+UMWXz2ZRIGcfwajcrUK5UrugTK+0dAinqAt4mzYwXFdlghigla+copvRSI
	 cbY54KA9FAeAfJ8LjpqvsnPeehJk2FK9Fub8EHW0VnozW9Z7BfGJ2C/EakTdc5AQwS
	 RXG2Md1B+omeT3J7vhbxgALQe1QI7UB3s4gWJlaKSuQTLdzz3YS3FM3DMlVPQtebab
	 EsZkiGi2YQkPg==
From: Namhyung Kim <namhyung@kernel.org>
To: Kan Liang <kan.liang@linux.intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Leo Yan <leo.yan@arm.com>, Thomas Falcon <thomas.falcon@intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250308012853.1384762-1-irogers@google.com>
References: <20250308012853.1384762-1-irogers@google.com>
Subject: Re: [PATCH v2] perf mem: Don't leak mem event names
Message-Id: <174170950664.2288726.14708796433249812313.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 09:11:46 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 07 Mar 2025 17:28:53 -0800, Ian Rogers wrote:
> When preparing the mem events for the argv copies are intentionally
> made. These copies are leaked and cause runs of perf using address
> sanitizer to fail. Rather than leak the memory allocate a chunk of
> memory for the mem event names upfront and build the strings in this -
> the storage is sized larger than the previous buffer size. The caller
> is then responsible for clearing up this memory. As part of this
> change, remove the mem_loads_name and mem_stores_name global buffers
> then change the perf_pmu__mem_events_name to write to an out argument
> buffer.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


