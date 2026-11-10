Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347860;
	b=OispdzYPWRPnN2E9VNK1fUZU+6vxNbopOXZhnNLgSHLxqwMtnEkAapc7PUCEABDVhhhQ
	 ezFrGdKeQilGzoEHm78uyQEFYzZSYyBdRBleIZsUbWpREPfVpKx6TFREXg6pLrFvEi2NH
	 umDhoXChvK+UqHVvhHzPxie67B65P9jxPCrCpG+sCmUrWzDBI5YWMOMgo948fjSJ4YdKg
	 66TCTsqlPm6P7UB27MgwryXZVdu6msS8mrKEVxHFGS6CVcuL6e9XRsKX+cSo1J+Sjga3/
	 ftO/sw4KTQ0ET6owMei1korwD1UgfeCDvQR5NCx47og6OtRuoQfWuVxSAUM4BRxkiDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347860;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=U3dRy5Wk3wu3LM0ZFl67CqnCypaazAgWa6UYzSpWGgI=;
	b=mXSGVSvs/KPHWqHZBO5zAMGCo2QpZ+IVNVnaSKMAUyBclpPzIzEDk8A2YM/i1drzN6wm
	 KJ8CkgDHesT5qh4LCwjqu46NtV4gHHU5r+moRjv/NtJJM3GI3mT7SO7LjnZAev+kU7JiU
	 axiCzLtuIoCcm21LdnrcGJUQ9AdMcQ9oFHQK5J1IDGu/MUdWl5nUJyk0egoq0F/ssfecm
	 fG6TFe0A83bNuqabfCn9m0amblw0hqWeD282GM8YISoyBpsSasWNjIfqH1G+EyxoiTOZl
	 C9wc9sol2jhurH6bXTCoGfEpG/u8z2rAVMciCv4vULXJ7WIw7KgGdSurw/c2QoLSegQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7CCKrWF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C6606A321;
	Tue, 10 Nov 2026 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7CCKrWF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF441F0089F;
	Tue, 10 Nov 2026 21:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347859;
	bh=U3dRy5Wk3wu3LM0ZFl67CqnCypaazAgWa6UYzSpWGgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F7CCKrWFkbSIH0AcLuXP0eMkA12V7yhabdvfZk0a3U/F98xYhCnLDCEoR6z21Wq93
	 Pz2yhZm637kCuf950KIgrFEt+apGAJ9eoV47TR1Vb22ZqojMvjtrK6/ma5qWqvOr4o
	 qof06RAuuWNdBLTxmRdUcQ3OCTqI3s6Nl2IiEX3A5+wyofSU8IwA4MqaUhghph+qq5
	 riud09IGbFJqMIrdKnQ3cA5xQXXo9483d4JsUZXxO/FnxL0cw4zGb05uhnI4McYgRR
	 IzpsRwegUJghoEQkRHpjyODNK23ueKuoCfSZ/NeHMcmQfs5ud4BMId4uHUqNO3vCgE
	 qhEQCFygNhxPw==
Date: Tue, 10 Nov 2026 13:57:37 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jakub Brnak <jbrnak@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] perf tools: LLVM dwarf and flaky test fixes
Message-ID: <avOTUWTBoXDooTY2@google.com>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
 <CAP-5=fWpnzp4O-kKqToP0Q7WVp1dcPaUH1MgPNiL__MNJKZ7hQ@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWpnzp4O-kKqToP0Q7WVp1dcPaUH1MgPNiL__MNJKZ7hQ@mail.gmail.com>

On Mon, Nov 09, 2026 at 10:20:06AM -0800, Ian Rogers wrote:
> On Mon, Nov 9, 2026 at 5:48 AM James Clark <james.clark@linaro.org> wrote:
> >
> > Running the tests on an LLVM build results in some dwarf issues that
> > need fixing. And there is an easy fix for some flakiness caused when
> > tests are run in parallel.
> >
> > Assisted by Claude Opus 5.5
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> For the series:
> Tested-by: Ian Rogers <irogers@google.com>

Thanks, as Arnaldo took the patch 3 and 4 to perf-tools, I'll process
the rest in perf-tools-next.

Thanks,
Namhyung

