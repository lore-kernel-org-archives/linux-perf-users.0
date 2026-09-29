Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A250552947;
	Tue, 29 Sep 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707478; cv=none; b=iOPV2Oqn36iXxAju1YnPuhPLQHxr96G31t/8xBK6eg9PLpucU7FA/GNHL3C4cyKVqc1R4+pBT3YZnpqEG5emfLwsQAa3SoG7hX29fwhAE4YIDsIkqc6291tajGmnV1Ztq1aSZlAWfhZ+IaMgBCSUhB5v1DlrRXPr8501Fu+HiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707478; c=relaxed/simple;
	bh=wvhzMdghD7hMV970INZvbY4Zqk7w0t5tT1UUTB9Ef6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud4TpGDUNaamqDwVt2/E/50z1vPMcU5GAAFmfMN+nRkIq49Uq5T+A4D6DxqtaH5tuXUMqkDwqxbWhvAptZTQLj/BG0d6AMaT6isjGW0I4H+zrh6UOBKeqOQY91AInbZemfGn3qj6RXDRnzT0hzsCc+boyJPN9zNghkFmtuzbYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITwoPm9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITwoPm9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590261F000FF;
	Tue, 29 Sep 2026 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707475;
	bh=wvhzMdghD7hMV970INZvbY4Zqk7w0t5tT1UUTB9Ef6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ITwoPm9V+NnrOV9QC85g4mWg1aWrsJz5hNrgLNbuRmLir2MMHX/Nhkq8DkUljXa9c
	 yWezeSoWfCAuent7oJr+iFtQD34twjwlqtBDFIZnzhNdaaY28ybdO93q5RGjkDXHeM
	 V1xCeAMjalCs1b5lsiMl0iB8yPrTs+YveJq8jvzJ9wyysT2eI5cliMQdSNVHM6Gr6Y
	 +hRm1iViDsf5tWwiyFsSUjcSD0NaX7Jpm8CkvA68BQHsaQWYm5qRz1egToyoPoUig7
	 fKjTNwpDHncXo+KnmHNRXyTQxt9GJu1mbU/16pPtIvCSNP/p1Amnk/Iz6r9etu5qgf
	 8vquP2kjBn9ow==
Date: Tue, 29 Sep 2026 20:44:31 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v3 0/9] perf python: Follow-up fixes and shell test
 deflaking
Message-ID: <arwHD_zJ60j_vOBX@x2>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929065839.407062-1-irogers@google.com>

On Mon, Sep 28, 2026 at 11:58:30PM -0700, Ian Rogers wrote:
> This series contains follow-up fixes for the standalone Python scripts
> and their shell tests, particularly when running 'perf test' as root
> under heavy parallel load:

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
