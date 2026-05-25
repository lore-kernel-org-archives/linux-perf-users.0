Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46E3EFFDE;
	Mon, 25 May 2026 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723491; cv=none; b=GRg5+ci4WeEU9OpPwokTUydcrw1Bq99XM+2hUYQ1/Yev7XVvDpOzJ3QiA/ltyDn9AKcAuxnthU6tdoA38viAgmSbTxFCrYq0/KEUM3lyQZUFyogDReNmr0phKSP7aBJ1Ux3kAvRZnWzyEmBwcmMTj760tQ56SLfw6XUfVtWTkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723491; c=relaxed/simple;
	bh=LojSqt2SwnBlIdwbxJz5YupGrvG/H4NnV0wrxzoiqz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOdVtuTmTX3cGa01w4XQcfSLfHnErpkd4LabioWCKw7XcEhNegz8oAGIXikEgfvFokElo6zdLap5npX/E1tOQn7Qt+V7VsyGagWY8g8prL63qu9iJ06Y09Ora14fWYSME3TQ/rCBPdhi/QqiX/bOrfuKn2AiygLeq9IsfyO/bo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAbYQx5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAbYQx5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83441F00A3A;
	Mon, 25 May 2026 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723490;
	bh=+wN/e1fWfH7603KyKAt8gJph6yMzt5h6zzrrx3f+luY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oAbYQx5S9OpRmMYvxccHcnBX01h2SLjunsX1lNW4YosccaxL5hn/f2gRpsewbW1h+
	 MNpwnhFiqKnkZS8Kl7LRwfvM8qIx+KacUKLq5IWYPD+o3yXueuAz1RPjFVi6xxSmXn
	 zIXCuVKC6p6MXhrIePY8PHrrkQlbQCBWnk+KJD3YUqH+bhf2+Lj4Z9K355UIHDLPkq
	 jaTXzqaQCGV+TQdzcFqJK0KhvHMeE+OQfygM0YO4xaV3XD1EhYhrbEBvhFUKyQOyzT
	 FW49Z7Afz0PihBPyN7RnoDKUjLO8bzdnamcni/qzAn5t+aZsnkvHJvHzaLL6RgzNF5
	 NjRG9gVDeNHAw==
Date: Mon, 25 May 2026 12:38:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 22/29] perf header: Validate bitmap size before
 allocating in do_read_bitmap()
Message-ID: <ahRs3o_5n4M7iZtr@x1>
References: <20260525010550.1100375-23-acme@kernel.org>
 <20260525022959.6321E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525022959.6321E1F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 02:29:58AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:

> - [Low] The comment describing the per-node data layout does not accurately reflect the actual fields parsed by the code.

> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
 
> [ ... ]
 
> > @@ -3497,7 +3520,8 @@ static int process_mem_topology(struct feat_fd *ff,
> >  		return -1;
> >  	}

> > -	if (ff->size < 3 * sizeof(u64) + nr * 2 * sizeof(u64)) {
> > +	/* Per node: version(u64) + bitmap_size(u64) + bitmap data (>= 1 u64) */
 
> [Severity: Low]
> This isn't a bug, but does this comment accurately reflect the actual fields
> parsed by the code?
 
> It appears the first per-node field is actually the node ID, not the version,
> and this comment omits one of the two size fields written per node. It also
> assumes the bitmap data is always >= 1 u64 (when it could be 0). While the
> calculation nr * 3 * sizeof(u64) correctly accounts for the 3 metadata u64
> fields (node ID, size, and the second size from do_read_bitmap()), the text
> describing the layout seems slightly incorrect.

Addressed with:

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 351369ac4dc2c0a2..5b1fa1653d2a48cc 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3532,7 +3532,7 @@ static int process_mem_topology(struct feat_fd *ff,
                return -1;
        }

-       /* Per node: version(u64) + bitmap_size(u64) + bitmap data (>= 1 u64) */
+       /* Per node: node_id(u64) + mem_size(u64) + bitmap_nr_bits(u64) */
        if (ff->size < 3 * sizeof(u64) + nr * 3 * sizeof(u64)) {
                pr_err("Invalid HEADER_MEM_TOPOLOGY: section too small (%zu) for %llu nodes\n",
                       ff->size, (unsigned long long)nr);
acme@x1:~/git/perf-tools-next$
