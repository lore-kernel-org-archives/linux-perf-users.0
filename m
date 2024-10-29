Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B620FA86
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245828; cv=none; b=b7vDvOy+IzljisI8QpDE5stx3CzL4nV6ftGqZ0x8ySUjpAebEYZAnwgH7UH6XteF9AnxhSho3Luhkpar/8Fzu5cV5XOyvuPNFmlu9iZhpbeK0THFXn0iLdWNIJBZ5T21+DPiNSMVbfOdXpqkqUCHr0e/9busektDuvTW6zFsc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245828; c=relaxed/simple;
	bh=Km9QmhwRo6fGnvgC/ifviJ2aCCdQhRE1CmRblF85asg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZN5bWEKioRg4DOprLEK0vlMWIOt5XkHAmNCrhZLR9dPIORexelp9uafhiZWXwdygwNRbXd5b1Z0IIHzljmQ4wznwTkRs7kwlfIVJvZFu+iYAM0xSOK9v72P6/PTGGmduhImzJaHwdALiJWVPOORJVbwhYSSa6OGIJrzPH88hoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC+2IZMk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC+2IZMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA31C4CEEA;
	Tue, 29 Oct 2024 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245828;
	bh=Km9QmhwRo6fGnvgC/ifviJ2aCCdQhRE1CmRblF85asg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JC+2IZMkf2PtwUS1yY44nzOEiCDiHphebj+axO+aS3IxTCiSsjv5N1JXcrYWBZCwD
	 YTTnTA7tIUCg6gLt8hQmYAEVOscvdGKRnihq+CKB0gDPj1qLRP62iFWX7iTyojb7lL
	 82MaeQ6ZgqkB2nAAq7Z9d0pJDX47tryK6b/zcL5kigT+5vN5xUP6lbv0KgBd7D55op
	 Evt5P+IRXUnD9sOvwoRskBz8XhTaQC2h0vKzBOHai1j6nMHUsiVZA5WB267J23zke2
	 ts1ojLLXgwItXxGszMXxyunwAP1y8iNkqPskLhPwfLg8J+pDnfFT6V3nalAolDHow8
	 i2LNXXA0k/Q8A==
Date: Tue, 29 Oct 2024 16:50:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Can perf drop libunwind support
Message-ID: <ZyF0wjYbEvXWUU9s@google.com>
References: <CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com>

Hi Ian,

On Wed, Oct 23, 2024 at 02:57:05PM -0700, Ian Rogers wrote:
> Hi,
> 
> perf wants to build with BPF support these days. libbpf has a
> dependency on libelf, part of elfutils. libdw is also part of elfutils
> and amongst other things provides unwinding support. My understanding
> is libdw unwinding is used by perf in preference to libunwind when
> present. My suspicion is that libunwind is being feature tested,
> linked against but then seldom or never used. Given this could perf
> drop libunwind support in order to simplify the code base?
> 
> Possible savings:
>  - remove libunwind's 8 feature tests
>  - removal of 10 arch or not libunwind C files in perf
>  - removal of libunwind #ifdef-ed code throughout common files.

I'm ok with removing libunwind to reduce the maintenance burden.
In general, we'd better not have multiple libraries for the same
purpose.  Recently we added libllvm support, then it might replace
libelf, libdw and libcapstone someday. :)

Thanks,
Namhyung

