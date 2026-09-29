Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC37525A6D;
	Tue, 29 Sep 2026 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708324; cv=none; b=N8KYT1o0HPjNuT4jTifbibYjW7KAar4ROQRSpgON7myakFVe+EW1bpz7adRF6LvJRAXAjkTQCD6tVBfoksnc5WDbUTub7GgVyAJT6//RYQvuMoBnbVCu0VF3RR5KaIgpuPVHPocBEo4dJIp0LySf6G6JEtmNmiFEHQLnQW8KHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708324; c=relaxed/simple;
	bh=wdQi7nivD2fWu+yw0UvnQedeGPjpbG2I8DBLwRumovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EESNDmr87DQbR9u1CGE0eta2L48ciTW1XiJ5p/Kv4QTqdOHgovcfHHvDY47xOHzO7uglAZRztZVs9UnFcKARaG3bGpg3itN1EYJ5jVMy0KX6O53mB2Xyo8VYEeONL8lLiVvZEqk/YYq+t2Wx5hRm7ev9q2AQGGsM+KFi03k4SVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6DDBKOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6DDBKOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E851F000FF;
	Tue, 29 Sep 2026 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790708323;
	bh=7d8BscZeLtWMOuw9daJjKxQBtdGQG3DAvv9rrWTO38c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L6DDBKObWUukKY+isZXvM8Hrqf7c1KK9jCgr6dNpQmTfmx/ywqDeuG5Bb2N1jDZz8
	 fFWt2DCUOVf2+NIU3SnMK25CCktdsXiQ2xd1GdCCcCEcnCM7TDAwSjU6M/2TJQ0XOz
	 b1dTrsTTxR8vTbwnebopMBo0HHmWliI4lwWT7vJ5kEG+YmKrNt+QgB2TluOvuE1/tk
	 l603PfgkZ2hKd/+XHCgsCLat3pYvhrfk7dQroGdg+SiSSb3yWdvlimSi62bq/J/zpR
	 Wn9xAZviwCM2R/bY4i0Xf4vNp1Mcq+UI7OG8zKlJH76eUdOF8oxpBdaNfsaLBZJjfa
	 9uepQUaTXFsGQ==
Date: Tue, 29 Sep 2026 20:58:40 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 0/8] perf tools: Cleanup dso debug info access
Message-ID: <arwKYBViJ2TvhXAW@x2>
References: <20260929011139.53242-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929011139.53242-1-namhyung@kernel.org>

On Mon, Sep 28, 2026 at 06:11:31PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is a preparation for DSO file access cleanup work.  IIUC DSO
> access has three types - symbol table, binary data and debug info.
> Those information can be placed separately like stripped binaries and
> split debug files.  I've added dbginfo_type to DSO to track location
> of debug info like others.
> 
> I'm sending this out before it grows too much.  This patchset focuses
> on debuginfo open path.  Once it looks good to others, I'll update
> other places accessing DWARF info to use this info and cleanup other
> file type accesses too.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
