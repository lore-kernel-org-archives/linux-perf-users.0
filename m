Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BB24DCF9;
	Fri, 16 Oct 2026 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118783; cv=none; b=DauFHCFsVeGwLPbYIuqwGCoGehusFcdbZ2fHfkhGJmMfm0UrERHpfmF1zmlt3aamsu5+eVZm4GXVA51IbyNsy+B+kQSOC0eED0PEiKqjWFrLY3MzI/08kRCKfLPoug0mILvA2Is0NF3EjKV7zdB7/9azybWXo0zsPczXhQikd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118783; c=relaxed/simple;
	bh=MZY+7SazQs9GXNv9EElMy4rFDKkGdkmElPmNkGrAcxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVxI9ojSf/HktM3Eb/38DIZ5b9lO551q8J7qFAkUZUBg6fwka0QLrQy7Cwwj1b8auHyxs1QfwQVtt5D2NXPCmVIf1QEosISYtqeApmoKnrhNR3SfIcqIHyxHPoBrC8sV2uHYcaRcgTuY7XFGakW2m6gLFIxUH5OwrsG4CV7jdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSTBRA4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSTBRA4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0B71F000C4;
	Fri, 16 Oct 2026 02:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118782;
	bh=NY+s7zT7aa1GPal19vg7xWY4xP210y5n0JCG656QxoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eSTBRA4pGxs3xUltikXcnzgiv1wqu+h/H1/eWdNf7El3f8O2o8rb/jzNF87jc0qLd
	 KH7Y751ivX8muae9RrP6EpDgttgjSPck1TngBm19aURwjVBvZOM9QjpoRmMu0llzNs
	 yYlAgoYsHT9iguAMP8hEGevI7MKjuuJisjWsoRITn6xDuyYM03FNOn6W4c159zGnZx
	 5VAo0mH174lU7QLqLOhhaGRigs7jQWKbRbqEzf/Y31DN86IncraARtGnHPTLYX12YZ
	 zarwoRBE3Cqr9tIQEZbTlOwjzDL/p2GQRGVPAUHWL9lbf1+wip81edFY/idNm0Fjcb
	 HrIA9BHilG4NQ==
Date: Thu, 15 Oct 2026 22:46:21 -0400
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/6] tools: build kernel selftests in tools_build
Message-ID: <atGP_fJItPeF4WAk@laps>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-5-sashal@kernel.org>
 <08e8e221-4e46-41a1-baa5-bade8ee20730@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <08e8e221-4e46-41a1-baa5-bade8ee20730@linuxfoundation.org>

On Tue, Oct 13, 2026 at 01:29:22PM -0600, Shuah Khan wrote:
>On 10/11/26 17:36, Sasha Levin wrote:
>>Add a "Kernel selftests" sub-menu with one entry per selftests directory
>>that builds with only a C library and does not write into the source
>>tree. Each is built as "make kselftest-all" builds it, with KHDR_INCLUDES
>>pointing at the UAPI headers installed in the object tree, but by its own
>>make, so the selected ones build in parallel. Selftests whose Makefile
>>does not use KHDR_INCLUDES still build against the C library's copy of
>>the UAPI headers.
>>
>>The selftests do not track header dependencies, so a selftest is built
>>again from scratch when its own directory, a header or makefile any
>>selftest may share, or a kernel source it includes directly (the vDSO
>>test includes the architecture's vDSO code) is newer than its last
>>build.
>
>Is there a way you can fold in kselftest_deps.sh run into this
>so users know why some tests didn't build. Also we want to make
>sure kselftest build doesn't fail if a test fails to build to
>keep the current kselftest build behavior.

Sure. In the next version a selftest that fails to build prints a warning and
the build carries on, as with kselftest-all. FORCE_TARGETS=1 makes it fatal, as
it does for kselftest-all, for CI that wants that.

-- 
Thanks,
Sasha
