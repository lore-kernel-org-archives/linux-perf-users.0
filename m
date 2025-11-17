Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E12309BE;
	Mon, 17 Nov 2025 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364063; cv=none; b=BZh0jTurnQcsKToVut7wStyoo3rlTuRM1KlfqWUu9hYgIttyshGM+XXoQ/NQ/CjJ8CZM427xPlRsb+2e2oayl93GiLoSQDEy1C1Dfa0uiL1t1EMIJLG+ar9RwLnr4oj96NU+41EKff6G4LCxiYCBljRfhj99qWZp+OZwLgfiKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364063; c=relaxed/simple;
	bh=tx1EQAISjX9lGOb14ffit3i4ZUagycgBEd3Frvd4LA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9heJHoJF30J2hgdgRqBVN3yVzdCWEOoGkdq8glj4Yvhsc7U0XjRrtUO+K1sMVQ471FyfnpX5thZ+oxLqCK8NsW0BCrI6LVNfyiWP78j9dQIwJDe2E92eTBrP8WAj24+0XUbrNzkKMmIfkTh7G3/rsA71hiyp5N3fiW9zW/y8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/6t8s7z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/6t8s7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D81C4CEF5;
	Mon, 17 Nov 2025 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763364062;
	bh=tx1EQAISjX9lGOb14ffit3i4ZUagycgBEd3Frvd4LA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/6t8s7ziwKgH/pXRNhCOmPQK1hCu7lViGR+DFoD9xGgsaltHb47bQlfXXSNY4rbh
	 Hct0jnvPwIDvk0E/k4mfphGHMuXr/Y3a09eL6ImGIsFjs2zkjiTQblLKB/ihG4UveG
	 LFeghF1Y63MLEasIkrWa4SSuYCkNZ24Go0zLbllbfWHqYHleP0D0Mu5F0emANXGJVm
	 BQk444MEv/bNN+4MbDGvxs1L2xzkkEbduHHAyV6Pt7NghN3Pt4/PHZIEAkiBAgmmrL
	 nyQmd34ehjZJfbfChKb2DUaYtBrPdqlKJLcKLQsmWflAs+Wr2AEkBeT5MYaRnH9dbN
	 pJtk9woIA8vsA==
Date: Sun, 16 Nov 2025 23:20:59 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/25] perf arm_spe: Extend operations
Message-ID: <aRrM2y4O_3aaa2Ee@google.com>
References: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
 <CAP-5=fXiiWRDPzONNNZQZc4QOBQoz=kRnJq77on5r4w9aDx-XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXiiWRDPzONNNZQZc4QOBQoz=kRnJq77on5r4w9aDx-XA@mail.gmail.com>

Hello,

On Thu, Nov 13, 2025 at 09:01:47AM -0800, Ian Rogers wrote:
> On Wed, Nov 12, 2025 at 10:24 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > This series enhances tooling to support new operations:
> >
> >   - Support for MTE tag since Arm SPE v1.3;
> >   - Support for Advanced SIMD extension and SVE operations;
> >   - Support memcpy, memset and GCS operations;
> >   - Support extended operations for atomic, Acquire/Release and
> >     Exclusive instructions.
> >   - Enhance the data source for associated info, like floating-point,
> >     conditional, data processing, etc.
> >
> > This series is divided into three parts:
> >
> >   Patches 01 ~ 06: Support raw dump for new operations;
> >   Patches 07 ~ 17: Export the operation info into records, so that the
> >                    information can be later consumed by samples.
> >   Patches 18 ~ 25: Set the operation info into sample's data source and
> >                    SIMD flag, and updated the document.
> >
> > This patch series is tested on FVP for native parsing and x86_64 for
> > cross parsing.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Can I get some comments from ARM folks?  I think I can merge part 1 and
2 before changing the kernel interface.

Thanks,
Namhyung

