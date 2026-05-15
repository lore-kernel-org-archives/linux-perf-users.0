Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF841C2FF;
	Fri, 15 May 2026 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803278; cv=none; b=Vgt47htOMpJAaIE6MGQk2pYmQGzebs8GWC2Zd8YevZywaxyQYj1Sr0l70FxCkveEBiAqoLel3DUvRkhR8w5dz5mp3wBnXA5j0VW3+g2x0XdrKF5VPfBdn0OF+ZS6IVdwREFFjYigO+2chuLaAC3eiIp87GKYGZaYlBE2t0rWRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803278; c=relaxed/simple;
	bh=qcyh1k6oDWxzqMUIRNWfJA2lNDX2xIYpO4RsFgvB/Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsmQ+cZi6dc6QsbLHhWGh1iH2eQ8OTsW8TBH+2BMUg96ft2hmuhbyObfO+D0aro11INRDPXIn2sbJYtQgoH70axQtpPeUOkVr1NTo7CDh4/fVnjstVsUUydzWZjvDnrzVoJ2gknJRIYdkudf3KBmzc+T3/6a5k6F4JBkzOLj7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORTs2e47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORTs2e47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D03C2BCB3;
	Fri, 15 May 2026 00:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778803278;
	bh=qcyh1k6oDWxzqMUIRNWfJA2lNDX2xIYpO4RsFgvB/Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORTs2e47LDfXtxpftrsgmc0BBJfhsGWPf3S7imib3v4dWSmqlGKYQTWNchK/6tqqv
	 28zSEFcawoJf5V5dMaouJ/OjkKLtq1W+p1dESsernOwMwK7viKW4dlettM9fHGZJ/g
	 GUI/V3HUvr+ResYK5Wo+/EnZVSefKesf7+hwdq5+G5er6JKBevdLzivjuiELJUBEww
	 BBRyyBE1t8374ptrmuPzDNmNofdZC8dRo2ivwgc/FhQ4blzhzcWxfDchMnGEL3jS2K
	 vMhmTj6OBA4dBHPhOVFmkR66JiCZSaodo3uE/UB6rBNz3FPqlkz2ZY0XPM4GiMfpiH
	 Rwch+YpztSmpw==
Date: Thu, 14 May 2026 21:01:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, namhyung@kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Li Guan <guanli.oerv@isrc.iscas.ac.cn>, 9erthalion6@gmail.com,
	alex@ghiti.fr, alexander.shishkin@linux.intel.com,
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu,
	atrajeev@linux.ibm.com, howardchu95@gmail.com,
	john.g.garry@oracle.com, jolsa@kernel.org, leo.yan@linux.dev,
	libunwind-devel@nongnu.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org, mingo@redhat.com,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com,
	will@kernel.org
Subject: Re: [PATCH v5 0/7] perf libunwind multiple remote support
Message-ID: <agZiS2-fY49MjsY6@x1>
References: <20260413024805.1316480-1-irogers@google.com>
 <20260513233151.572332-1-irogers@google.com>
 <CAP-5=fW6S1XzZvq=kWj6ma=O1UCDrVV3ZNbzK0fMS_ho6e1qVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW6S1XzZvq=kWj6ma=O1UCDrVV3ZNbzK0fMS_ho6e1qVg@mail.gmail.com>

On Thu, May 14, 2026 at 09:51:09AM -0700, Ian Rogers wrote:
> On Wed, May 13, 2026 at 4:32 PM Ian Rogers <irogers@google.com> wrote:
> > Fix the libunwind build for when libdw and libunwind are feature
> > detected, currently failing with a duplicate symbol.
> >
> > Refactor the libunwind support so that whenever a remote target is
> > available, perf functions using the ELF machine can use that remote
> > target regardless of what the host/local machine is. Migrate existing
> > libunwind supported architectures like powerpc, arm64 and loongarch so
> > that they can work in a cross-architecture way. Add support for
> > RISC-V. Make the code more regular in function names, etc. and avoid
> > including a C-file. This increases the lines of code. It is similar in
> > style to the unwind-libdw implementation. It is hoped that the more
> > uniform nature of the code will help with refactoring the perf
> > registers for SIMD/APX support.
> >
> > Aside from local host testing these patches are under tested, in part
> > as I'm failing to see how to build libunwind with support for multiple
> > remote targets. Please could I get help in testing.
> 
> So the patches failed to apply in Sashiko:
> https://sashiko.dev/#/patchset/20260513233151.572332-1-irogers%40google.com
> The baseline logs show perf-tools-next was at commit 8c8f20936143
> ("perf build: Remove NO_GTK2 build test") which is 6 patches
> out-of-date compared to the current tip these patches are against. I
> ran Sashiko locally, so I don't expect a huge amount from the reviews.
> Currently Sashiko is catching up with a backlog because its tokens
> have a lower priority and there was high load earlier in the week.
> Anyway, I could repost the patches for Sashiko review but given the
> backlog I think that would just create noise at the moment. Hopefully
> I can get human review so we can move forward with merging these
> improvements.

Trying to apply it now, will also run sashiko locally.

- Arnaldo
