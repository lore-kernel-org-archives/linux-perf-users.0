Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4309C15B964;
	Wed, 29 May 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717010672; cv=none; b=Stwm1Lw4zSwSym59p6HONqiUTqJp82XGdvTiR6wFKx82KkBP7iY3Mb/cVKegQxhC4KOpDoSYszAs0M0rlrbujWMgTMdQFOhh0U8CYJy9IpGBnOZH4xzAeeaFMFWDPUf4ljxHbrgQ12foPXk8vjCP80mXjuD4eNU57Ml5UYauotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717010672; c=relaxed/simple;
	bh=p9mYxHDza/Axc1uEohlL5OW7dsuH9rNK/HVfZ/iRm2g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCk7Sez/zEqyEHfCWuVS363vSifm6zBuqodTcAZJxBfYVU801tdpGAa0wITEleFa4WpJ0RXdhiVJR+8gLSjPTl7uaiw93mpCXVd6XQ2p4Iiab5Y/zZgAmHs7yXxVOk9HdZdJjyMClVi0RuQWpQ5q3voGqAeYx41tQh7j+JsKoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIdV/Zxk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIdV/Zxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C70AC32781;
	Wed, 29 May 2024 19:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717010671;
	bh=p9mYxHDza/Axc1uEohlL5OW7dsuH9rNK/HVfZ/iRm2g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HIdV/Zxkq05bdrXRiiTlsn85PafVC8A/EA+EIKuf9aoxzFux4yLCCJP+3k0jb7CVp
	 r1vomG4XlCxPKEUB4mffwFO4T+9w+GunRda8OQSDtf/A+9FLKf2GetjLoOkp6/NmFh
	 Ttj9OPqtFFLW+jt+g+XdqFZmIY7ZDvpqY51EQFZ08EAxaFaLiSKP9hlBck+82w49t7
	 Gjj3FAWOjJE5zkbYo8K7v2ua+ZyR4iA/5FupKPzPyQ9bFMe8IpSTkl3NGDR6GovEQP
	 yZIRz2cej4vNq8Q1OvJHOfa9zipef5N14+LrR4VAfKfYbqfHmUSJD6tt6EbNYVycRe
	 UYVPZW65Igjew==
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@arm.com>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Stephane Eranian <eranian@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Tuan Phan <tuanphan@os.amperecomputing.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Bhaskara Budiredla <bbudiredla@marvell.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
Date: Wed, 29 May 2024 12:24:21 -0700
Message-ID: <171701062467.353211.4212637863767093531.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240515060114.3268149-1-irogers@google.com>
References: <20240515060114.3268149-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 May 2024 23:01:12 -0700, Ian Rogers wrote:
> The mrvl_ddr_pmu is uncore and has a hexadecimal address
> suffix. Current PMU sorting/merging code assumes uncore PMU names
> start with uncore_ and have a decimal suffix. Add support for
> hexadecimal suffixes and add tests.
> 
> v6. Add necessary fix in pmu.c to perf_pmu__match_ignoring_suffix that
>     also needs to ignore hex suffixes.
> v5. In pmus.h remove needless addition of #include list.h but add
>     stddef.h for size_t.
> v4. Workaround GCC build error by using unsigned types. Don't consider
>     short hex suffixes as suffixes (e.g. cpum_cf) and test this
>     behavior.
> v3. Rebase and move tests from pmus.c to the existing pmu.c.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>
