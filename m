Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D16167DA0;
	Wed, 29 May 2024 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717010723; cv=none; b=eJdiOJp+ArG82rF/rI4AMKEs3tRnSLfQQvpevpuPrDlHFz9c0tAVuaJiCqh+uDtjKqDfZVXQv+FXdKcJ3vSxUaDEgyySmmOk6zxJPsq3yaffCu5/a+CWgXIKjEx4mtJddhdGr0hMfnhGHND/ZMHtKpvT3xDcm11ifBVKp2/diZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717010723; c=relaxed/simple;
	bh=8hnX5+K+L9gtEsPSecwouqZPNByI/V3C1YUs3P5OMKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFYEvakINagDhNJB/Knaoeh79/r1vP7IvIyO1IPAZsitFxeJ42vlyxT4YTINFGkNUIFCt5szDPGBCA8i3WPzRu+RJK4UjIhz5oy5QDWmsp779h/kNMjkATOpTY9NH3AU3HnTMa8CgQtE9/DFVMJHtKN7zAOvEz7MGbn99n245Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG04acR1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG04acR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD97C113CC;
	Wed, 29 May 2024 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717010723;
	bh=8hnX5+K+L9gtEsPSecwouqZPNByI/V3C1YUs3P5OMKk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eG04acR1Ip+bUHa1/4moCvsgaOxyC2uhwuFA2mGOEyfT0adu7qpV0yTtV0BfDx0qh
	 Z9UsSJkNFV/26hHt7KV98pnhsd6CQevFL4lHKPorqDJLfSl2v86hmboZ775x5FE854
	 RhkPIqstx6NxJUN0rKorvvR8SCtIlnxgrIFRgzSax4cQRXaRCyL3oNTjVHylXJ3tbU
	 z9rBdliAtVwzwIF8A2vBoWIl6nqEjK6TcXPy6wyopxvZ2fychJ/JzbQ+MEcVMngfUr
	 8fGK9+d50bjSJ+o8XOSfJsKQx/MjFgYqDDesjatIj0cjM/XwWexOw62f+gzRdEAWil
	 v0HZiIto3j48w==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v1] perf arm-spe: Unaligned pointer work around
Date: Wed, 29 May 2024 12:25:20 -0700
Message-ID: <171701062467.353211.6004518321763325404.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240514052402.3031871-1-irogers@google.com>
References: <20240514052402.3031871-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 13 May 2024 22:24:02 -0700, Ian Rogers wrote:
> Use get_unaligned_leXX instead of leXX_to_cpu to handle unaligned
> pointers. Such pointers occur with libFuzzer testing.
> 
> A similar change for intel-pt was done in:
> https://lore.kernel.org/r/20231005190451.175568-6-adrian.hunter@intel.com
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>
