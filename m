Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE21213E9C;
	Fri,  3 Oct 2025 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518984; cv=none; b=Y3h3pVtBfKVlSU3miTuwLQlUrjSHQ8WYxcVFsC9WOXEn9XHQkDJ4EkKHf1aWFC72EvjNiBKj2zfuzKTBfVo3tFbLeVjE2wppPWfG/O9HStRkaNr1HDJ11WAcZfIb5v0TcBGN0qnhEt1W/SimIzjz8FqmtpCymD9Vcsj7HomqXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518984; c=relaxed/simple;
	bh=bNAzf4Vw8yNtHRTIUbEuaOyIu3wdBv22A9tw+7SpQ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZRcU56GQQqpm0sUFrc8iHUWYs5Q41NLFeWkwTg1qohjdUT0HNwIZ9LuDgSWR8S0Bk6vXDnuMOXa5VpxwNUWmGcMarFOtODnc3M+LnPm8n5sh4YMoXwy5fB2nQBuumjmRduqO+vZckLaFH+ASw95XdMpmJgv+PTWLw0mgp4BpCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KieZbrC7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KieZbrC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B529C4CEF5;
	Fri,  3 Oct 2025 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759518983;
	bh=bNAzf4Vw8yNtHRTIUbEuaOyIu3wdBv22A9tw+7SpQ9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KieZbrC7q4DQFDxWuAjqTtQL9X5cubJD1TFLTaDJH91glwpRhLKYfWqmjbUIQaCtG
	 bpa1ucVgb3E8JMm3fI+ZzAgYsgIZ/w/IH8G8xDJl/HmBwKtrXxjQ45aQA4OV/rIE3+
	 CnH5j5O4LiYkdMXoUOCeTJ8Um+V18qfPwMl+oEsk6txR1UYHz4Xtpx83fQTS0jkh9M
	 CdxkVNZdaUFNo5flWdLVljXbBH2Zh9REC0BGALb9V+RmoxzC4ov9saREefefGbmWCT
	 slIUV7zH3WhuLH5W4fw2B8ZdwIulWWDueJapqkl1T8ztaaW+lhPgKndUujUDaJaZ7Z
	 ZLZQwIcZ4sDLw==
Date: Fri, 3 Oct 2025 16:16:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] tools build: Remove feature-libslang-include-subdir
Message-ID: <aOAhBJfL98rEk-6v@x1>
References: <20251003022733.2417810-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003022733.2417810-1-irogers@google.com>

On Thu, Oct 02, 2025 at 07:27:33PM -0700, Ian Rogers wrote:
> Added in commit cbefd24f0aee ("tools build: Add test to check if
> slang.h is in /usr/include/slang/") this feature was to fix build
> support on now unsupported versions of RHEL 5 and 6. As 6 years has
> passed let's remove the workaround.

Thanks, applied to perf-tools-next,

- Arnaldo
