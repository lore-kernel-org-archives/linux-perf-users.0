Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E92110E;
	Wed,  1 Oct 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325897; cv=none; b=CXLBPD78qUdKUAhg2wH6Ybpk58HmsSzYU0LC9q5MkHR7XvZ16UWzmZF8PSK0h7o7nveX75zGOogJ9Zqgd/lQR407T32yEKOb0U8+uqqPvfwlHmkr2x2BJKKfBqIHdc2HoxuJUC03sL1TkL1MFhx7fDkEF0E/zqUD/JZXo0ddVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325897; c=relaxed/simple;
	bh=XxwenTZYHKcchxhkGdvccTjyuxdR+m+3PbPB7SIZTHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg4MqCluIsJ35X8ccXXTrgac7EkLVZePRdS7VjS1+fP6ft2Zp2vmjcgEV+2m4Ql/yOIY2uQVJVWgaJtqS/AfDD+nxWfRi8Npe0hriuUyO0v2pGQZLqGFOO4uKSgbjAB85bSn6e2sZS9wQWa+FgLsQ56otBSuuzf7s28nOT74RG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP9V0mCL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP9V0mCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F27C4CEF4;
	Wed,  1 Oct 2025 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759325896;
	bh=XxwenTZYHKcchxhkGdvccTjyuxdR+m+3PbPB7SIZTHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uP9V0mCLlRgPiDEHjT+xveEwmxeA2TSvx6WIcAepPNm+T95yesdvDX5bppIKz3BTy
	 dtCT6DzJSxpPNGPxLmrfmq9YWtFvkIr9BFFwMAyXkJtUMbdN5862eXUeMZsi86CDM9
	 o/59J0gLPJ/FrvoJps3Obb6TgbFWm1ArEnfco1BeATPsYlJpexSqnSHnnPrHP5E9xe
	 OLRGW6FixiStzmyNt8D0JvMXG5Yvf4PoNtrMMpXgu/N93pLc7qWO1BiCtXDU8qXVK5
	 ujz8JFb9IZxLEMt+2hkQt0WBsHrdJ7+orFC42hzEoz9jQguPX3z7vWWdaewhVvk5Xx
	 D1b8eDZLv+MSQ==
Date: Wed, 1 Oct 2025 10:38:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf sched: Avoid union type punning undefined
 behavior
Message-ID: <aN0uxfZAT8pp8svS@x1>
References: <20250914183353.1962899-1-irogers@google.com>
 <CAP-5=fV59uES4ZkNHDUypeO0XSnjkUTDWLydvaymEsegyeSb-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV59uES4ZkNHDUypeO0XSnjkUTDWLydvaymEsegyeSb-w@mail.gmail.com>

On Tue, Sep 30, 2025 at 01:05:33PM -0700, Ian Rogers wrote:
> On Sun, Sep 14, 2025 at 11:33 AM Ian Rogers <irogers@google.com> wrote:
> >
> > A union is used to set the priv value in thread (a void*) to a boolean
> > value through type punning. Undefined behavior sanitizer fails on this.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Thanks, applied to perf-tools-next,

- Arnaldo
