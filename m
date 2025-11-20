Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC11A316E;
	Thu, 20 Nov 2025 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665349; cv=none; b=fZC/PFyS++Rpd839WjgH7vxkFDNIUnlALBHbQl54cA/LBWvUVEPjSZBcZseRtxW9YiqXd9W+e3ylNdWTVUOqyGStiPksESxPbHdw77pOImG3ZqG2T76DMrd0B1JjLjOcn2OAQ4eG6SubMZMAGHiKPHvKZN3+Trxov7NmlJ5wD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665349; c=relaxed/simple;
	bh=0/B9oM+YMFeS91VJoL5RXguL564VuWCa2Pk2VCXkjxY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HJNtL7f6fAdGrunb9LXYplCXhC/06NJNSA+qxqAjjqOD8bPkLi2Th04SRyovUK1rOrlwCPa8TAk5BVGemIAgGgK+GI+tCPeXpO/IN1rpyvNFQ79UzjRuy4gs7kIcgPF8n0nI6FT1ZFdrXxU5KlOhFyge1b9WKNPS5jN72gl3dwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je1OtrBP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je1OtrBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEB9C4CEF1;
	Thu, 20 Nov 2025 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665349;
	bh=0/B9oM+YMFeS91VJoL5RXguL564VuWCa2Pk2VCXkjxY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Je1OtrBPJ9j2spPYgzVDvkl9bE6j2M3E/fvtnYOc8X+GSRTn2xbJMwehwx6kKxaDN
	 45LPT5KuwEEp1vkfp4mBzBpyXW+cNoQLbssSn7wecV0eB0pZ197Ervrl1JMt9+3kYb
	 hZ1tOGAGsXoMHs+7PQK/BXwD60OBKW9BMPoWPaObEp4xnfGDU3k50P5ZJJpPn4t4I8
	 yz59shLN5iLpQBv6lJ9wcGkqhzS4f5fQ/l/KojotfbUg1ts6B8seOfnuEXMAogSwcK
	 QmironDd88UBC75vjDWKpFkfCJtK5Y5shPe//J+7bDD8rLDew+/QuBGBID8oBaawXx
	 Wrvy6px8Bb+Gw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, German Gomez <german.gomez@arm.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251119050555.2017758-1-irogers@google.com>
References: <20251119050555.2017758-1-irogers@google.com>
Subject: Re: [PATCH v1 1/2] perf maps: Avoid RC_CHK use after free
Message-Id: <176366534773.3323482.11545683532910788298.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 11:02:27 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 18 Nov 2025 21:05:54 -0800, Ian Rogers wrote:
> The case of __maps__fixup_overlap_and_insert where the "new" maps
> covers existing mappings can create a use-after-free with reference
> count checking enabled. The issue is that "pos" holds a map pointer
> from maps_by_address that is put from maps_by_address but then used to
> look for a map in maps_by_name (the compared map is now a
> use-after-free). The issue stems from using maps__remove which redoes
> some of the searches already done by __maps__fixup_overlap_and_insert,
> so optimize the code (by avoiding repeated searches) and avoid the
> use-after-free by inlining the appropriate removal code.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


