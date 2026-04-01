Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F333F593
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087295; cv=none; b=cRm7vZuRSlLDl/uS7QMb2d42ihFX5HIj4vV5b/1FYWZF0psDvBvRsLozFL2nM6GASeEQovBNq7JpKExns+JNz1XBwCYL362/hYsSLQHnIFySKvn80959VFiLQ4KrmJ7EiVOCBNXbi7Inu4rxLyzymVKdH3Ey9fbCYXtKam6IN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087295; c=relaxed/simple;
	bh=NGZttMNJ9EWXO/Q81Wa5rkHXP+XklwmmmSU7SV71jlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7Q5BVzHDKFP0oQ/DEHjvC93yoEjVETmZCr//DbCKYOUq9PcXV8iRpCFFqdwe3dQW7bMad8BLRLEZ1iOiIeZGQvVkZD1wm3fL54d7ywQ1/QBrXb8Cr53Zk6QXHKUt5wCeUNrScfcoUDgkHErNcqqphQ4DL+r8ItmCbQhccNeZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6mfWRRo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6mfWRRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39E2C116C6;
	Wed,  1 Apr 2026 23:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775087295;
	bh=NGZttMNJ9EWXO/Q81Wa5rkHXP+XklwmmmSU7SV71jlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6mfWRRo+anvEdrq+IIbqrL6UiwyXlPhr70lg2ciUAhs0P+tjbMRbVvay0NF4jRna
	 zGlIFHaNhu+drsEi5vynwiCHjwad0DebcTunXFG+hzgSigh6GQ8/Hl6oyn8tHP7JsF
	 4f9urXtA3wiSxQrm1RCr3YOXZ/1vz7361cq49AN1ymCJoEzPgJuw3Y8oupQWPIa7hd
	 vwrn1Uid5A9vf3rBpe7nA9zZo8bMAGPUJaCVplrVpPd8Gel2j7NvbQaueXbGs6yZt7
	 4t3Fhq8FaH4kGY1vKwIE+C4CEgnkxMCc3pCXfIjQ/7IsesA+qFJfiogJSNhiagpHmV
	 wJnkW6xGMBqjA==
Date: Wed, 1 Apr 2026 16:48:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Venkat <venkat88@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>, acme@kernel.org,
	jolsa@kernel.org, adrian.hunter@intel.com, vmolnaro@redhat.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
	Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
Message-ID: <ac2uvTXI1iknXwyV@google.com>
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
 <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>

On Wed, Apr 01, 2026 at 01:40:47PM -0700, Ian Rogers wrote:
> This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?

Are you ok with the change itself then?

I'm not sure what's the expectation when the test runs with a regular
user.  I assume the intention of this change is running as root..

Thanks,
Namhyung

