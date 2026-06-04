Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A573B27FB;
	Thu,  4 Jun 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590680; cv=none; b=pZ5xv8VqQjX0yf1qr75SvyJ/7KwrAYqQOjX2CRpZgFEojiTTR3cpN7KuSamu1dtYo3F2PoNIpHBeyH26siSyzVSfp+CoFRhcabUIHiycV/Hv5XbLinsbjnpmieLcqwJldBOdtqDqHhujg4C2B138fviz2kQd0f1FOj8oKoVqLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590680; c=relaxed/simple;
	bh=ONwr8KDF6l/77u3rYbkYgcsXWYLOHfRd8I2VFYL3WWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3TEblcpzxcWgdoeIxKAVKSBmwHHDcZa9V5Rq7EKm3fKTrEK1JS7r4+Jrdzu5qwumRh4V6cwFtmblAnllaK3B/07tCNBYcAX+64Bedcy5A4/S2nQ01tn8oEKUwiWmvrdzSNDjzhVL4pJ13Zl/sOL2fosIqOIZo63QuPc1wWHIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmDO0Hsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmDO0Hsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BBB1F00893;
	Thu,  4 Jun 2026 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780590679;
	bh=qHniX+sBNMoqIIs6hZ3e1wBnzEN8wlaKC4LziP+aFCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YmDO0Hsux4pBg8h/YpqRC2upDhERYdQ/9yrRDlIsiYey5qqMP+wmyzmv5XfGEAL4p
	 oWZsYWUnzg4fij7lKtVT6xRhteoOY1EkKw1oUoFQe9Iy9rLfG/ItbDIOEuC7N/knTt
	 XfuAlDMsa9NetipnhkxogtQuMrbd+XjSWCqofUWXKR7beQ7lcwwMcXJPs14oyKPCzB
	 GHGxSslOrn8xnOyIgySHkL+REFRAROGChbpE0BzyuvnDC/7LFIP1rsET+ZyJfHapkD
	 GgBTcEciJPuTyVyr8FPcl0jhf6R213Bg10E3/OWueTrx/BIwOQf0tZVyOl9OcRtPU6
	 eiDYr3XKEEhDw==
Date: Thu, 4 Jun 2026 09:31:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, james.clark@linaro.org,
	tycho@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] perf/lock: enable end-timestamp accounting for
 cgroup aggregation
Message-ID: <aiGoUxZvM46QiAUA@google.com>
References: <20260530195940.78700-1-suchitkarunakaran@gmail.com>
 <aiF_gZBqoajF1xXe@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiF_gZBqoajF1xXe@x1>

On Thu, Jun 04, 2026 at 10:37:05AM -0300, Arnaldo Carvalho de Melo wrote:
> On Sun, May 31, 2026 at 01:29:40AM +0530, Suchit Karunakaran wrote:
> > update_lock_stat() handles lock contentions that start but never reach a
> > contention_end event (e.g., locks still held when profiling stops), but
> > previously treated LOCK_AGGR_CGROUP as a no-op due to missing cgroup
> > context in userspace.
> > 
> > Fix this by adding a cgroup_id field to struct tstamp_data, recording it
> > at contention_begin using get_current_cgroup_id() when aggr_mode is
> > LOCK_AGGR_CGROUP. Capturing it at contention_begin is semantically
> > correct, the contention cost is incurred by the task that had to wait,
> > not by whatever task happens to be running at contention_end. It is also
> > preferable from a performance standpoint, as contention_end runs just
> > before the task enters the critical section.
> > 
> > Update contention_end to use pelem->cgroup_id instead of calling
> > get_current_cgroup_id() dynamically, ensuring both complete and
> > incomplete contention events attribute the wait time to the cgroup at
> > wait-start time consistently.
> 
> Namhyung, can you provide an Acked-by or Reviewed-by?

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

