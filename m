Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874E2627F9;
	Tue, 20 May 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756601; cv=none; b=UYKPDetKhdd2ziqfXuaObKrJgw8syF39ksS+seTJ70sBmF9rpJaEHU+VkZ85Bf2EMUSyjCNrS/BDEWpnRVByJoQ3as57DUPpBhr9OX4qxyyeyKZSI9UILQjxw8JHOxjJCqIZtEcKQkdfVfKmjc3bcmqUtWOHSMGidFrcTBFW3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756601; c=relaxed/simple;
	bh=38+Oaln/YQrWvyjxstfyQuJ7we5KEYC6rNh0i/3nfOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYknWbANW6w7+DXFpB11lfCbDT5jOO06O29Jrx6ONcWU54c9zZa+yV0DJP5mirM+WvJxL26z8JvGRJW2/ahIRXnZQqjSTAsnzEaJqY5+lRFzVjoffRoS96gHyNPfFIm1Ra1jFqjOR1un819oSnLUC4oUA4fnEy07mmCh26DYGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaPdkLmH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaPdkLmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B3AC4CEE9;
	Tue, 20 May 2025 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756599;
	bh=38+Oaln/YQrWvyjxstfyQuJ7we5KEYC6rNh0i/3nfOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CaPdkLmHFu3cfOELOO5R5MIY57KOZBZyrLilsaO/+EW4gbl6oGEKfBmINihS9rhd5
	 HAsA9e73KYpxdwFJwZte5kmXNZ3M4D/uckLOAOyYftfQoXCQsVwoswzKmqznCZC4nu
	 1kfQzFIoI2DqJL9RzoRlILF8w2QSlHsILpqhsjRjyv99YqBHzIU7m3+vDsbw4If6x5
	 sSbgIZmzG50iW4xKjETKhcnwksEfCuV0TE0d9uNAGTj42e6ZJuwz995rPgGsOT1JzF
	 10w+qgu+LHYZOTRJy5dVSLR0ShU8tSCLNsx2uQZMl2hk6pXKgCct0pgFGrOVeusVsF
	 nthau0vr5RQjA==
Date: Tue, 20 May 2025 12:56:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	I Hsin Cheng <richard120310@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peng Jiang <jiang.peng9@zte.com.cn>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH FYI 0/7] Updating some kernel headers with the kernel
 sources
Message-ID: <aCymNKCDygqWrd20@x1>
References: <20250519214126.1652491-1-acme@kernel.org>
 <aCv7e4Jr0s6ViN1I@yury>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCv7e4Jr0s6ViN1I@yury>

On Mon, May 19, 2025 at 11:48:11PM -0400, Yury Norov wrote:
> On Mon, May 19, 2025 at 06:41:19PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Just FYI,

> > 	Updating some kernel headers with the kernel sources.

> For patches 5, 6 and 7:
> Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

Thanks, added to the patches.
 
> Would you like me to take those in bitmap-for-next?

Since this affects just the tooling, and removes a warning when building
them, I think its better for those to be carried in the perf-tools-next
tree, ok?

Cheers,

- Arnaldo
