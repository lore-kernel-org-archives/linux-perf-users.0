Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F66280CC1;
	Tue,  1 Jul 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751392516; cv=none; b=WyWRzgMdQ6Xt3FL1T4bVnlpBold8KE0o/cc/ZSSRDXiG0bnxdB3q7useIcvpB5Q5OjTFEsGdWzLT/gZXckeTVIJQHwCap3TQmwEoAeBz7Nr9ijxMFHzxl9XtmrvuynovXsU0ybHMmw1EUDIQoDoDve1sLdXrrlGBr+zjl+eJlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751392516; c=relaxed/simple;
	bh=DnPVouCLiwfGHggG02cDxfN2bxIrdB/EVyqkVKPRB+M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pR8JQJql14KGGN2I/Ct60XNBffG6h0Z6xKw7N98KhpDEJf78AIJxCxn0U4RMltv5ZiTRjqVjCrcMtvDjWSMECT4S9gTfD2aV4WjO8rXqMZsnO57d8c+qNLK2+dbItyv4m286VMGJgavJa3fiAfBlOGpM5hh+d1N38HpUK3a0n1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVJ5FbyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVJ5FbyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346F7C4CEF1;
	Tue,  1 Jul 2025 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751392515;
	bh=DnPVouCLiwfGHggG02cDxfN2bxIrdB/EVyqkVKPRB+M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=YVJ5FbyKZE000KuscpadMEKa962HfDQLUlNdhng1qEiVo3jmwUTJCuxXT3olryiuI
	 wltKayxh9YCtGa6CsD1dytqXGYlmfPTZpCEGr5ZrUtdMIAOYExNZxCLFWKhqFblBr2
	 tQrkunFkj6IHx74ULaf0w++kaa9vtkFK6/ZAZ19bcukKTYQ7D1QFpD65ADk8qz/pxb
	 lk1T6IHhCAJ1cX+oJ3AOCIWHuutU6Ku6lrXcfJjJmCzBlNHJO5dL0q1KqNP+fGFdDS
	 p9MxsgH5qdJiG9ddpGzknIWmSgqKsTtjxGXfCKjQwldjonH8P/efgoFV/jAY9laJWU
	 kZ3VnyTZ9n/Yw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250628015832.1271229-1-irogers@google.com>
References: <20250628015832.1271229-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test annotate: Use --percent-limit rather than
 head to reduce output
Message-Id: <175139251517.738306.4966360457421812263.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 10:55:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 27 Jun 2025 18:58:32 -0700, Ian Rogers wrote:
> The annotate test was sped up by Thomas Richter
> <tmricht@linux.ibm.com> in commit
> 658a8805cb60 ("perf test: Speed up test case 70 annotate basic tests")
> by reducing the annotate output using head. This causes flakes on
> hybrid machines where the first event dumped may not have the samples
> for the test within it. Rather than reduce the output using `head`
> switch to `--percent-limit 10` which will stop annotate dumping
> functions that have an overhead of less than 10%, the noploop program
> should be using more.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


