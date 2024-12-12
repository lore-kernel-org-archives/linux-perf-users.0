Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282B186607;
	Thu, 12 Dec 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030044; cv=none; b=OQohlBYf/TSjNS90hMQJX2G0xJsyRQEMfnFK2Vd6C6SaxWSX+jLg/HgBU6dOOH7xq3/4MnYRFV/xpkUfi1Xj4CncYRXzkimBlrFVbkwc4+y/d/Mj5AKhCfcKR+RlIdZlwiDc/NhLV5owQVZKW7N3D/kGoncY+4T4+qgkFLkcA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030044; c=relaxed/simple;
	bh=oiZaV7j9gU2sJqIGqh0RC+7QYVeLo3vZ7KcMUOkYhrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWdFohcXuYmvISVBVmwYqe0ufW6n68R5SRbM4e7vNE38hA7MGkKX3KnvGma7E9jN+a03lie6C6eJm7cRBGgb+H4YyevGJC/VzUxy+5P30ukl2qpxBmdee5MPB/zlOZ9IPmT630sdYgENo0U2mSy6i6yIn20JlduSTm7fybihjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geUnC+k6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geUnC+k6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EA5C4CECE;
	Thu, 12 Dec 2024 19:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734030043;
	bh=oiZaV7j9gU2sJqIGqh0RC+7QYVeLo3vZ7KcMUOkYhrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geUnC+k6xo6LAubga1czvSTQpJAiWqt5iQWZEXlMJkO+Wl2O/x89cwzATolcMgVI7
	 wy7Px/TKXinUETYQqXNuwXnycxSm3R7mKEKfqxe8auA87lsrRbfYo5kgnK5Ywc+s+6
	 6nQZLL4h+vOuhwK/7goN4L1RGiu0T7jz1Y+hVSqlPSURnLj0OoeKsPrAl41ri1IpYq
	 V8uSlYHGPdWC0qJaSLrLn3gkGloen+ui8u3pOr656o48ul+MftHQpaAdl36ziQW8gc
	 8Uuop8Ly1vhzwCPKNaHQ9TPKgLUvOzVLC8K4OhcrG2jcrvbAJPKJQekQx3yIaDdLB1
	 k6pZmXuIB0O2w==
Date: Thu, 12 Dec 2024 16:00:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, nick.forrington@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/3] perf lock: Add percpu-rwsem for type filter
Message-ID: <Z1sy2NgchmkOOVt_@x1>
References: <20241210200847.1023139-1-ctshao@google.com>
 <20241210200847.1023139-2-ctshao@google.com>
 <Z1nk1gxH9siszkwG@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1nk1gxH9siszkwG@google.com>

On Wed, Dec 11, 2024 at 11:15:34AM -0800, Namhyung Kim wrote:
> On Tue, Dec 10, 2024 at 12:08:21PM -0800, Chun-Tse Shao wrote:
> > percpu-rwsem was missing in man page. And for backward compatibility,
> > replace `pcpu-sem` with `percpu-rwsem` before parsing lock name.
> > Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
> > percpu-rwsem`

> > Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address")
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>

> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Here the reviewer can also add info about where this should go, i.e.
this is a fix, has a Fixes tag, but then there is extra work for
maintainers to do: Is this a regression introduced in this merge window?
Should this go to urgent or next? If the submitter adds this, it helps,
if the reviewer agrees, even better, otherwise emit an opinion where it
should go.

In this specific case:

⬢ [acme@toolbox perf-tools-next]$ git tag --contains 4f701063bfa2 | grep ^v[56] | grep -v -- -rc
v6.10
v6.11
v6.12
v6.4
v6.5
v6.6
v6.7
v6.8
v6.9
⬢ [acme@toolbox perf-tools-next]$

Looks something its there for quite a while, so probably can go to
perf-tools-next?

- Arnaldo
