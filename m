Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE9212B05;
	Tue, 18 Mar 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320938; cv=none; b=Wl81WIsPPv8mN9M39E64svfCusi68joFSCn40N61qpr1e57JoMgn2QkFpEG44cUiknnmSvdiTwHALYixocoCJwxfPvR6RyzAECYIDQ9tCyVyYIg1aPYmxUgp4l3YmiAwKfzXeDc8QeFf3EeqGSR6N8b6JwnVPiwjNAmY3CVBlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320938; c=relaxed/simple;
	bh=ry484X/mdkHepbQNXMiAzJAv8rz4BS9UyrvubBi+qM4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IIf7tH2EIu5GDiOw5C0JUYBse0MWuI0NzwaSKiLR/8ztr8Lblr8miFUoKh3XqP3fa5x3hso+D5FHC3juyG+vhpItqAStY8d7aIQQr9d9X/wvyPY+y9nM5Mx1l2F2MnWetsAg2GhNlYAy3mdvywJn9iRSKuG74gtkyFdNnvsMBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLMkn4V0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLMkn4V0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B25C4CEF1;
	Tue, 18 Mar 2025 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320938;
	bh=ry484X/mdkHepbQNXMiAzJAv8rz4BS9UyrvubBi+qM4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iLMkn4V0bP0CpUDKBHknkoF0uUXgjxXKawBqJtbx+dMJeZquVQGI3TKGmeHkzO1Qo
	 tZ2BGobI0pHRiftfcarhHjL89T4x8RiG1ThWdXnAfXB07HD0M0/JpVW/ppWp78aIYx
	 zJ+rtKf3JnnRO4Ta1EHA1O4F4WqBibvjYSe5jrKdKiYXNgpD93f2v9KHjgLoVVGWnP
	 SRzUHwZSz4E7h80ainwksy+88gBcBm2SmsSAcfrenE4Wbnk9Hy3dVTf0ymfkfBjBX7
	 IX5muHhraRqmO1HZ/AkEWTgM6devzIVhTu7veYUWDpPAhFr7vncnySGxzXy+W0j1EH
	 2ttWeHV2a5AcQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250311211635.541090-1-irogers@google.com>
References: <20250311211635.541090-1-irogers@google.com>
Subject: Re: [PATCH v1] perf tests annotate: Add pipe output to output
 testing
Message-Id: <174232093806.2542685.5490063295095338711.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 11:02:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 11 Mar 2025 14:16:35 -0700, Ian Rogers wrote:
> Parameterize the basic testing to generate directly a perf.data file
> or to generate/use one from pipe input or output.  To simplify the
> refactor move some of the head/grep logic around. Use "-q" with grep
> to make the test output cleaner.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


