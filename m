Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B162C326F;
	Thu,  4 Jun 2026 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581862; cv=none; b=RzIdSZoJdygDpdCtU/KZ4lMX+eVHxstoSu7CCrjrsOoLMn6NSRWMTRx1zdpqhFpywlTIBBvDXdfQbm1UcOWIDkhGVHCwCSV7MK/uTF3sg5fhZUjNokIk8BkEWOK2BW337m/06YSFdYi3fVob8YTOpczq9yhZ83UDeBsgk1NTYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581862; c=relaxed/simple;
	bh=Ya0jraPB8ds0nEFJNfS0ztM/ekhqeDn6l4Nyjbx/TbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEUVQc6y4PSMjvcgljLsgem7r0RRhl4ekypfe8+kCUJzAwPGYOn92CKHUzZ7pDafujzW/bXHhTo8J201+SNhjmS/qichAa2fWOLscNXVQewAmAlxVtj3kpvt83SZQNfyK3x/ZfsBU6Imx0j3r7Duft0EhiiPAqRT87R+ULcMu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs975JQt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs975JQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD761F00893;
	Thu,  4 Jun 2026 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581860;
	bh=bahoDJKT25PEPvJgELnf332X4a26LznAyLyadH+yBy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fs975JQt7ptR6qFLc1fNLZRz5N5Z89k1lx+WXUNfSB7tz25FDJDqrn5pk+vr/3qy5
	 r3gdkHrOh1+Upm6FI/zjwEuWB4bWBRZYEXFowhYyJ6ef9jw61xzcjEhX4y/sT5SOnZ
	 fRmvVdQVq8x7Tb9AVRNNwL3CJyT1qL6TLvTJ/0T9fODcWjDggj6CL5jgItz2jfeSQe
	 3CdZixiueOD93vgnjRkkzFfKV3WCv0RrCEMrCEnNd3jsI+Or2bOFEdQUJXWwdPJBgE
	 kyERAqKKbp1dD2PSGEP8IPaX4kIfERdS51Bmej6+PQ65NJ8J+eBXBrtyHb4bx2qKqS
	 BT0yE1PR8wPnQ==
Date: Thu, 4 Jun 2026 11:04:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	thomas.falcon@intel.com, tmricht@linux.ibm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [RESEND PATCH v2] perf tools: Ensure event leader stays at head
 of evlist after sorting
Message-ID: <aiGF4ZT3lleisLQb@x1>
References: <20260505211924.1961056-2-ctshao@google.com>
 <agArPG7T5rACOOcv@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agArPG7T5rACOOcv@google.com>

On Sat, May 09, 2026 at 11:52:44PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Tue, May 05, 2026 at 02:19:00PM -0700, Chun-Tse Shao wrote:
> > From: Ian Rogers <irogers@google.com>
> > 
> > For evlist of a certain event/metric, the HEAD should be the event
> > leader. In some scenarios where uncore_xxx_0 does not exist, the event
> > leader is not the first element after sorting. For example, on my test
> > machine uncore_iio_0 does not exist, the event leader is uncore_iio_2.
> > 
> > However, in `evlist__cmp`, it was reordered based on the PMU name, which
> > makes uncore_iio_1 the HEAD of evlist, breaking the following merge
> > logic in `evsel__merge_aliases`.
> > 
> > The patch adds a loop at the end of
> > `parse_events__sort_events_and_fix_groups` to make sure the first
> > wildcard match is the earliest entry in the list, updating pointers
> > accordingly without breaking reordering detection.
> > 
> > Tested on device lacks uncore_iio_0, and `perf test` looks good.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
