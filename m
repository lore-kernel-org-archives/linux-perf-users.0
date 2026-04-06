Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261AB355F46;
	Mon,  6 Apr 2026 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497943; cv=none; b=IgRtP0Kyk5sJ5l/4SjmYTPkpogN0n+mYMjV5n7IdDnSSodwj2yRDj3sRg19UbaBsns3AnLfyIENe327J45nAOfmX/Y+/mMUP+3Dm1mv7z6UGbQovay7qJFNOd+wOVdIuI0PygbSo3s1jPDyuVL5KyR7Ln9fId3k5dx3NrUW3THk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497943; c=relaxed/simple;
	bh=L+fHFYIxwhhlhI1YHQoUhP8mu0wAvXjcXppHn+VVLGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0ny6rKZo+FdqcsLBQzLK4/vMJm1ld1gbwkVzo0MpPhPOz59IeK6dNsSzYLDbc+DfjOjOmtv4nwp5IhfXcbSSIuXygfq+bYghVs13piEd1yabwUsiULX+7QRnTTdZsd9rhmHAIOOF1+rW0fo6ukSTcOT0x2EBpZi4SWVmB1foQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+b084kU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+b084kU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1CAC4CEF7;
	Mon,  6 Apr 2026 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775497942;
	bh=L+fHFYIxwhhlhI1YHQoUhP8mu0wAvXjcXppHn+VVLGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+b084kUGRB5foGiP1JoBAGzWvTaALApxAIHBCwvqcaVKNFyijR9PL3qXVIFd/MfL
	 /mgeu54xF2gb2nFXz8q/wLk8uRhr4n0igR4SLCSUrcwdMtOJcc/Vgs8grFF5smmebf
	 VtAYGNoChscJpAJ8L3sPyjepe2cADymkVp2tR7FpCOJlNDah5YPdAOxaGBuieGlBTA
	 NZQWl5XGwWFiRJcZysn02+UurvthX1AuTk3FyTVzWdlYmnCGUnV9hTDoaq8WdVwi82
	 lzVE/tUgH06WpMFJWXdc1wK6cV94YRpHpbsLeJDWiCk5Ve7mNp2Q9wpCddslNqA3n4
	 3SCd6VJtCV65w==
Date: Mon, 6 Apr 2026 10:52:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, sun.jian.kdev@gmail.com
Subject: Re: [PATCH v2] perf cgroup: Update metric leader in
 evlist__expand_cgroup
Message-ID: <adPy1Og7FgOXKQID@google.com>
References: <CAP-5=fVbwwP6QBO+GrFoSVFxX1GM9rTJFqUwMVdsona_Gt6rug@mail.gmail.com>
 <20260404060552.1585709-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260404060552.1585709-1-irogers@google.com>

On Fri, Apr 03, 2026 at 11:05:52PM -0700, Ian Rogers wrote:
> When the evlist is expanded the metric leader wasn't being updated. As
> the original evsel is deleted this creates a use-after-free in
> stat-shadow's prepare_metric. This was detected running the "perf stat
> --bpf-counters --for-each-cgroup test" with sanitizers.
> 
> The change itself puts the copied evsel into the priv field (known
> unused because of evsel__clone use) and then in a second pass over the
> list updates the copied values using the priv pointer.
> 
> Fixes: d1c5a0e86a4e ("perf stat: Add --for-each-cgroup option")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Sun Jian <sun.jian.kdev@gmail.com>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

