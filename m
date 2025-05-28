Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD801D6195
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457671; cv=none; b=d8yHj+99PhyLqcrUlbQRQM8m7L6gxNpvYtInIbM/dvQJCI7GwV87M9OFBRXGN669rBLWDqPC2buCoBNZDEkXqXEssgiozHPtOtTsMDEY/2FTX2CtjIWbX0b8X1v9T/HwOc+uSrkX8LWIq4dbZRZKV/B8LapfgE/DfG9ZMGz1UFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457671; c=relaxed/simple;
	bh=anInPSvL/83FHSBSN+bKogNvYIU2+g5qwkPfCRkKlrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Immh5jE1DCk8tqo3NSS7sOWt7OveTkXTmSJuOGlJIEjDC0nu0ss/HGfDQg7rSVLnfWnVrRGXdPXF+B0HqgQd0XhhQo5I70BXC58MyQbxDw5/46hcSGETKZoTImKcAOAhlXgn/aBXPB0CMV+gDOAZYF+jwTdDls4sPmE+dWYHKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heE0mFq0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heE0mFq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B78FC4CEE3;
	Wed, 28 May 2025 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748457671;
	bh=anInPSvL/83FHSBSN+bKogNvYIU2+g5qwkPfCRkKlrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heE0mFq015GgFv7vFUJYPY4VrZ1v1CXcUmYPkadP2vVNN1sQqZRD2UHyLkpEXbt6U
	 jK6+jqKie8+90EsWCmnZpplR/4jLYXHPW/sQk+SneMUo/qgZRBdrm93ve5WiZwUpTc
	 omfti4V3dTbfq72HILqH69mLT3tX6Qk0k5nofv08SWtNL60br64h3HF1i3YP2VYcBX
	 i0xYOasT0Tk5MFKF4vSOYXOt4x7RJ/BSfrYQ3JJD/rHSBkrsqzo0uZ/fcoUbQd9eDI
	 QodwbMVbblOEOClpeediQ5fCyKJkWw/OzzvlCaEPCi/K4ALePAjQYbcPa0HPGyPzxf
	 p5k5bn+6z8VpA==
Date: Wed, 28 May 2025 15:41:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Anubhav Shelat <ashelat@redhat.com>, mpetlan@redhat.com,
	namhyung@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf trace: always print return value for syscalls with
 set errpid
Message-ID: <aDdYxLLtNa4qT3ZF@x1>
References: <20250403160411.159238-2-ashelat@redhat.com>
 <CAH0uvoh8h2NAw3wbBwXAKyAHWS=QehM=pkBD8GOc+f7CcmedyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoh8h2NAw3wbBwXAKyAHWS=QehM=pkBD8GOc+f7CcmedyA@mail.gmail.com>

On Thu, Apr 03, 2025 at 08:26:52PM -0700, Howard Chu wrote:
> [Resend due to rejection by mailing list]
> 
> Hello Anubhav,
> 
> Thanks for doing this :)
> 
> On Thu, Apr 3, 2025 at 9:06 AM Anubhav Shelat <ashelat@redhat.com> wrote:
> >
> > Currently some syscalls that have errpid set to true do not print a
> > return value in perf trace. The syscalls that were consistently
> > observed were set_robust_list and rseq. This is because perf cannot find
> > their child process. This change ensures that the return value is always
> > printed.
> >
> > Before:
> >      0.256 ( 0.001 ms): set_robust_list(head: 0x7f09c77dba20, len: 24)                        =
> >      0.259 ( 0.001 ms): rseq(rseq: 0x7f09c77dc0e0, rseq_len: 32, sig: 1392848979)             =
> > After:
> >      0.270 ( 0.002 ms): set_robust_list(head: 0x7f0bb14a6a20, len: 24)                        = 0
> >      0.273 ( 0.002 ms): rseq(rseq: 0x7f0bb14a70e0, rseq_len: 32, sig: 1392848979)             = 0
> >
> > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks, applied after rewording it a bit to mention that this not
related to rseq/set_robust_list as those shouldn't be using errpid, but
that the problem predates that and added this, where the problem
started:

Fixes: 11c8e39f5133aed9 ("perf trace: Infrastructure to show COMM strings for syscalls returning PIDs")

- Arnaldo
