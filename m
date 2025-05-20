Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B925178D;
	Tue, 20 May 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756670; cv=none; b=XmoOGSw64MDlOawJ470t9+6hPFb5fpuUsbMuwLiVr1W7+gjVpnsv5gWGyF8wP6DXWxaxMcmrCZUS3DiXObzScumn4Ekh8/sB9oyE3m0wVHM5EHKh+pSKMP5M/t58x76UV33Of/pOHFGYnS3dOCJIhSf1qSPPymkE8oFsXA+AADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756670; c=relaxed/simple;
	bh=8HEoeqGmsnu4TOM4II34Oz1U01ZgP2fZxAbjPwuTw3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA+6XPWUvCshf2aqc/cimjCyhQcjIsIKd+vGBEw8vYgW3+l2x0hSa8g6fS+HJicBKZ+CNzzPVO6YVsouC2CWuaUoX223wp+ajJCN8WhOv4s/FotgeNGpdZqKqRajYFg9KDnLNDqv5Ax9CjbPvawXc7U/yFDLQaUurPWYoW56evg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz94cX4F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz94cX4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DDFC4CEE9;
	Tue, 20 May 2025 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756670;
	bh=8HEoeqGmsnu4TOM4II34Oz1U01ZgP2fZxAbjPwuTw3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz94cX4FWRw7YeibPYo8FWl/+9G085t01D/c/RGXguBMKBZGJJYjl/Bqd+miBYAXu
	 4JR9f6kLduhADY/GiBqoB8XzqVwqUH3g0AC/ubCkiUnCsiACcexhyUGwrr4o2iT9Sk
	 mP70Meo2r1zIa7jzw/fT7cNqsHPSJjcYRZS7JB2aAD084sSXWfy984whnS3T494A1G
	 QFhVtF9i3maRz09dD4aOUxk4yabl/8Rl/eXy719piL2iYIjM0MsmLaU4qblfQt6LJs
	 ul0zRBQnPqzLU6h/wkwAddy6FjAYVD8eWkW+PvSVV9ZM4dd2VuxywfACGYgSbK0lU7
	 ecgHdd5Ul57wA==
Date: Tue, 20 May 2025 12:57:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/7] tools include UAPI: Sync linux/vhost.h with the
 kernel sources
Message-ID: <aCyme7GaVBdGSTK2@x1>
References: <20250519214126.1652491-1-acme@kernel.org>
 <20250519214126.1652491-2-acme@kernel.org>
 <cek234mjuzbh3w4jvwhpx2oundb23tmxjaa2q35ul7bu7todum@hqkjcbnf3fzf>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cek234mjuzbh3w4jvwhpx2oundb23tmxjaa2q35ul7bu7todum@hqkjcbnf3fzf>

On Tue, May 20, 2025 at 09:20:04AM +0200, Stefano Garzarella wrote:
> On Mon, May 19, 2025 at 06:41:20PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com

> > To get the changes in:
 
> >  a940e0a685575424 ("vhost: fix VHOST_*_OWNER documentation")
 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks, added to the patch,

- Arnaldo
