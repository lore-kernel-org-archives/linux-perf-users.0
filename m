Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020219;
	b=Bp92KNNDRuh3QyRX5SYJ2Z2wwxH25bW8VxOKz+3JB6+uQL/CaBYDvfXQj0egBesvztl5
	 /73gcBeJ931ytK1iJ2Yg8F7qH28nBrEFbIWJZ1svim7s5eOQNnqm+Czp/OdTBsHw2Cwta
	 PKxbNJWTN7DGt3D092peLBQuvLMXZmXWf+kJlfihfx/QMxBf9d7waHOWRxGFGhUyyQ4jK
	 vvOAfEyrCyeyhsby1axhuJ+y4WB7kv1I3aXspjhQrwKb4U+kCBi5w858wVm8ATUP15x0O
	 DjPo+BgK4tHZ+uh3YeiaE1YFN/HLSZy4guZKeUGBXWjtr78OkxoZCAPY6P+6tffWK2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020219;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XniNYFBtJTE+9qOOq15tFLI6AKi9yaCDJXq5LBSrfl8=;
	b=OoinuI9Ful65KhEG2RzpLE7iH0zJzkvgCbM/lMdACd6AdBY7tIE+M0JGboB1KOdkXWEp
	 eJ1uQmVUzMeEKakzHWVdDWnie8CKM71Ry7W1KHPryYrnGo1KYEJLcnyDIVD+WNlcf5u83
	 9XO/bKncgJx68nlduIk18gt+o5CTPsrJTkUl3cxowYyjcOmpKyjiroVQs87ndgauz1LZr
	 spF6x9bALEa7aQeesS8cFvNa3Y1jH5FaQw/NaBGa8r3SsOx+aGiQNj4e7+vo81ed55zaV
	 k9ljrdYQvUsSyoCWTFl2AUY/eD1heiLvFYv1vwrycU1o7beXzTrSp+niPZUgBvJkMNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeK4RMao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B8606A31C;
	Wed, 18 Nov 2026 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeK4RMao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20631F000C6;
	Wed, 18 Nov 2026 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020219;
	bh=XniNYFBtJTE+9qOOq15tFLI6AKi9yaCDJXq5LBSrfl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UeK4RMao2Z57KpmezA5xm5c1hd5E42HSrZxakKzNep/ORf8Z8fSnGTcCC+SN6um+i
	 uFa3b6WLgX/65NuTQIOb/igzjz3qzfBS6XVvCQeFBBeKiprFAxQEr8tQ/HwoYgEbfD
	 IduMxH3N54ovxRkudp4oRnGiH1Ez4KsyHlwtoNE8TKcsy8vsz30ID9aWqIwKrnARqa
	 9e5FmDXwba5GAZX0TzVxX+MPUyEke2Y6CbvArb9gY3gK+3X3JryJx7P4IMCXQIXMEx
	 fe5JyLvJUMtXJElCo/CUKnMiXzVLyJGBLuLNmF3k5pFatpN+xQXNNml9XWzhkCgthG
	 tqir/4Q1G0kKg==
Date: Wed, 18 Nov 2026 13:43:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 07/13] perf tests: Exercise data type resolution from
 a register
Message-ID: <av3VuNr38Zxh0KV_@phoenix2>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-8-acme@kernel.org>
 <av1QxJZA36xcbcEL@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av1QxJZA36xcbcEL@google.com>

On Tue, Nov 17, 2026 at 11:16:20PM -0800, Namhyung Kim wrote:
> On Tue, Nov 17, 2026 at 05:04:25PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > At -O2 a struct pointer lives in a register (with DWARF describing it with
> > a register location on register-argument ABIs), while the unoptimized
> > workloads the data type tests profile keep their variables on the stack.
> > 
> > Add a regptr workload with a noinline function that takes the pointer from
> > a volatile global, so the compiler cannot constant-propagate the object
> > address, and check that its three member accesses are resolved from that
> > register.
> 
> Thanks for adding the workloads for data type profiling.  I was unsure
> if it's ok to add since it'd requires many test cases to cover various
> aspect of binary patterns or compiler/language differences.  But having
> a seperate repo for the test programs would be cumbersome too.

I think these are all super small samples that can get into the perf
binary, at some point if possible we can have it in dlsym'able .so
files. For now this way of including what is needed to fine tune/test
important new features such as data-type profiling is worth having it
linked in the main binary.

- Arnaldo
