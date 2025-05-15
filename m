Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729BF25B682;
	Thu, 15 May 2025 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333251; cv=none; b=oT5oOfP4Lr27tTns5JDGJqT+InBCJ3CeCWM0mPbLapWhKkBanRqcjw9O5NH4AtA7l06btknSlK7rlANNcLoUbpr4VltvcVo5SGjn5Ry0vReC4htZVMfnA5yZ92PY1nMJveaFxjc9SJrssMQarKYVC4raQDn8qwANm6bbs5Eknyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333251; c=relaxed/simple;
	bh=yPg9w9KpNVnjTuBql0SsmnBzRG1XYqkefsFYkp5NT3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL2Xf7TEej0x2dHt3IoByqYL4JePubMrk0D4SdSnykyc2eqToMBNPrR5uSvXRvzh4u0lDaLPfMUv9I+oRBxB4RHN0diztJKybPJLfShiPduHV60g8DnHsRBJN6cyqGbaHpTuc5dAJ8S+woJdV1eIShIafrhvK6gOIMaFiOv9tM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSnFHmvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSnFHmvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66064C4CEE7;
	Thu, 15 May 2025 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747333250;
	bh=yPg9w9KpNVnjTuBql0SsmnBzRG1XYqkefsFYkp5NT3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSnFHmvfx1n+13Ya9b2MX1sWa/C1oxlUXI3dDXUfMwFmkZCsL+H3bOYiYyA827jJ9
	 C2XWzLicDoGutvzIlcT07bHzAQ2nUY+fTWUyiVdRR2JR8cNDXlRFRqqLMZOgqmuSVx
	 wpkiOJSEfSjGb3T2oZunkCen3FldaUwcspfsq0LLdc2mQOfojVrSdGlWt7C2vyUj2j
	 sKyYnkW7NYum2Dn1ufE1BNjy9EWVh8wilyaLIaAYPBRdE+Tb/ef7zdUx2+U1oDT3EI
	 yhJBk7IDdo9NGXKjwo+mxNmp6Nj7hoLw0Vi6l0dXvd72Eid21RjPQThHADy6gtDJRx
	 eqwKiA5/cFoCQ==
Date: Thu, 15 May 2025 11:20:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	gautam@linux.ibm.com
Subject: Re: [PATCH v16 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <aCYwgPcEBBoI2dSn@google.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
 <aBjfrUqFe444h_CF@x1>
 <CAP-5=fXMwyGm5KUecSS4pUhgBB_py=R_c0LqEYfnjyRrf4bcMQ@mail.gmail.com>
 <CA+JHD93FaugH5ny6+bBkciwoWzLN5RKCbtBq77V2bi8Rs15-UQ@mail.gmail.com>
 <CAP-5=fX8+nyvisxybD6gWBhJd=GpuMiBkSA+CqnLuUc7Mx2KHw@mail.gmail.com>
 <CA+JHD935y5ky0EWrG4okShjizP9JDp1hOoUiCNT3c6WUj0k1VA@mail.gmail.com>
 <CAH0uvohK3ER-KODvgc3aApLOebR4v=SeprenvRxxbJqwUQW6jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohK3ER-KODvgc3aApLOebR4v=SeprenvRxxbJqwUQW6jw@mail.gmail.com>

On Wed, May 14, 2025 at 01:15:42PM -0700, Howard Chu wrote:
> Hello,
> 
> Thank you, Ian and Arnaldo, for testing this. I apologize for not
> responding sooner — I don't think that'll happen again (these are my
> patches, after all).
> 
> Wow, it's applied. Guess I'll treat myself to some Kung Pao chicken tonight.

Congrats!  Hope you enjoyed your chicken. :)

Thanks,
Namhyung

