Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDFF2F7475;
	Thu,  6 Nov 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460745; cv=none; b=lteaFtX9pdXlPb/jpszNXD8ErOw6Tz0LXZDOdAEqQW5zhfyGPtKlKeWwEP++rmsayYWl9UKgpH1LkwZrDpShm5/2w3rpUkk8prua35Hi93bUON5yneXCPp7fs7mLvREY69TGuoqrrABzYohhMudfxPEx7DlJ7xnm2hwDRjo7EyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460745; c=relaxed/simple;
	bh=SRAMAkyKyrD5o7pBxELMq9QSxVAxrDV5ZGYyJJUGbzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqbcxKUPs4Y7jZwDpi1vN5VvuOvtprM6Tq2/h0mTleWSpHy1J7BBPdn/T0AQEtgum49MWZ3yB7R9kLR4AhHWV81kHTvN3EJMncOUQCPsPjlod0IPLfGUJYGllq0rCC40eyQTilTsZ/e5MoV/8FZ1QLsbl9PhR5MrYVy6RiItB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTI/2/Jc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTI/2/Jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BA9C4AF09;
	Thu,  6 Nov 2025 20:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762460745;
	bh=SRAMAkyKyrD5o7pBxELMq9QSxVAxrDV5ZGYyJJUGbzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTI/2/JcJmU96Xy/sXPupIKhToZV7iBp76fw6EvsQV+iF3THlj0TDZ1YNHEdJQm/A
	 7KsXVzAL4s7c6KVXQ/R1NxFf2F71twQWCB0RNrCtcsCOudH7vnBZWUHZCxNl2zBxpc
	 K94/D77UYEoOvv4YeuZQT0V7C6xT0yFXBOrUpP7l5KO4ZS7Mjo8MEO9SSQssa41OpY
	 Nnntd9EKRrMZYVdRWA+sf9OiRyzh6BN2DKawkm/Pm0To2w5+ebfCgs4H4n+57c3Vhb
	 DmYqXFLy0EnmaBK6CkcE/3pxAiPeU4KLFHglaw3oQdDreSq1NcQychtYuDcWdX5xUv
	 eHdhjfhM7xiNA==
Date: Thu, 6 Nov 2025 17:25:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
	Trevor Gross <tmgross@umich.edu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf symbols: Handle '1' symbols in /proc/kallsyms
Message-ID: <aQ0ERJiTpiA_rL5D@x1>
References: <aQjua6zkEHYNVN3X@x1>
 <aQltxZIVd6w5VNtI@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQltxZIVd6w5VNtI@google.com>

On Mon, Nov 03, 2025 at 07:06:45PM -0800, Namhyung Kim wrote:
> On Mon, Nov 03, 2025 at 03:03:23PM -0300, Arnaldo Carvalho de Melo wrote:
> > Just FYI, I'm carrying this on the perf tools tree.

> > I started seeing this in recent Fedora 42 kernels:

> >   root@x1:~# uname -a
> >   Linux x1 6.17.4-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Oct 19 18:47:49 UTC 2025 x86_64 GNU/Linux
> >   root@x1:~#

> >   root@x1:~# perf test 1
> >     1: vmlinux symtab matches kallsyms     : FAILED!
> >   root@x1:~#

> > Related to:

> >   root@x1:~# grep ' 1 ' /proc/kallsyms
> >   ffffffffb098bc00 1 __pfx__RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
> >   ffffffffb098bc10 1 _RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
> >   root@x1:~#

> > That is found in:
 
> >   root@x1:~# pahole --running_kernel_vmlinux
> >   /usr/lib/debug/lib/modules/6.17.4-200.fc42.x86_64/vmlinux
> >   root@x1:~#
 
> >   root@x1:~# readelf -sW /usr/lib/debug/lib/modules/6.17.4-200.fc42.x86_64/vmlinux | grep __pfx__RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
> >   150649: ffffffff81f8bc00    16 FUNC    LOCAL  DEFAULT    1 __pfx__RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
> >   root@x1:~#
> > 
> > But was being filtered out when reading /proc/kallsyms, as the '1'
> > symbol type was not being handled, do it, there are just two of them at
> > this point.
> 
> Do you know what the type '1' means?  It seems they are from Rust.

They are related to anonymous Rust closures in the QR encoder for the
DRM panic, this part:

drivers/gpu/drm/drm_panic_qr.rs

    fn from_segments(segments: &[&Segment<'_>]) -> Option<Version> {
        (1..=40)
            .map(Version)
            .find(|&v| v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum())
    }

That 

Using rustfilt we get:

core::iter::adapters::map::map_try_fold::<usize, drm_panic_qr::Version, (), core::ops::control_flow::ControlFlow<drm_panic_qr::Version>, drm_panic_qr::Version, core::iter::traits::iterator::Iterator::find::check<drm_panic_qr::Version, <drm_panic_qr::Version>::from_segments::{closure#0}>::{closure#0}>::{closure#0}
#

Both are for the same symbol, the __pfx__ is to do some stack probing.
LLVM may introduce this for other reasons.

So far, '1' symbols are Rust symbols, in the Linux kernel, for unnamed
closures and its prefix code checking for stack space, Miguel, do you
have something to add?

- Arnaldo
