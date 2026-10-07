Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929884B1CEB;
	Wed,  7 Oct 2026 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386954; cv=none; b=Vjekp966Quyoko+AX/n8kq+C3HjsFuAlfK3bHKq4JCMpV96PgS8IEVgG3vO6lCDhUEMQuiZPbtvUIOYiaqCWhIKRnAiRgvgNWUh7TbdxmMSan716/PFFHeI8J9vXaimb92G1imNWP4dvAGxxYXhSMrBLmMux3I5mbMlGIGsL/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386954; c=relaxed/simple;
	bh=17JWSCb1bGSp01DKeEIMZvohDg/s3Nfn8z1pUMci9rw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HngyH6t0vu9G9Y84zQD0+BvyEavd5xoCJL/RkFZYHq6ztDFlfp6ixPvZ33F0zEJ93yeX2gexChmZuo1CScrp3cd2XcigiM0ZstKaP3KYwSKaQQYO9ELfvsYfsFKXwASmOVCkveyJYfEj6fUV+vtbWiYiSeF+EiuTwvvCvtsjr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTxUV4JO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTxUV4JO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA991F000FF;
	Wed,  7 Oct 2026 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791386950;
	bh=LqN60BuPJ3IrOHfbBCAENpTxaEXAkkkwVCSec+5Hnw0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=MTxUV4JO/OyZ8FpkpRpFW7BCTaGXKSVyT5L8zuhfruHSmwE6wVUOj3rC7bf4hG8wg
	 eneBfutJBjkWkn23+L3F0bzueMh23Usv2pN4hzBKCE+wTmeoZzu7nqoV6UkScr5PpO
	 A0rxq8Opa2Fe96e34C8NQtaIX+ssrKqnG5iirmoyfzbU+yu0S9qNbMLwvrNVY0K4q3
	 oNELiSeEDkFCCqWZzDqgdYZ6MYxE0+vJI6Z7h/aTGMFdNMRGAlYJ3+WwUrKAM55Hx3
	 pmn6swzsxt31nTyj0RpXJBt3HD/LEBtUutIYZ8/Z0Npyev6ol8jsNAAgxeeXLEy/mU
	 oPXRBdIOycnwA==
Date: Wed, 7 Oct 2026 09:28:59 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
    namhyung@kernel.org, mark.rutland@arm.com, 
    alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
    adrian.hunter@intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
    john.g.garry@oracle.com, will@kernel.org, mike.leach@arm.com, 
    pjw@kernel.org, palmer@dabbelt.com, guoren@kernel.org, 
    linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v2 1/2] perf riscv: Implement rdtsc()
In-Reply-To: <20260929034133.2153-2-cp0613@linux.alibaba.com>
Message-ID: <7a32beb7-27e9-1805-d23a-590ad7fa05b3@kernel.org>
References: <20260929034133.2153-1-cp0613@linux.alibaba.com> <20260929034133.2153-2-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 29 Sep 2026, Chen Pei wrote:

> Perf has no riscv implementation of rdtsc(), so it links against the weak
> stub in util/tsc.c and every caller reads a constant 0 that cannot be
> told apart from a counter standing still.
> 
> Implement rdtsc() over the time CSR with rdtime.  The time CSR is a TSC
> equivalent on riscv: readable from user mode, constant frequency, and the
> same counter riscv's arch_perf_update_userpage() builds the user page
> conversion fields from, so the counter and perf time share a timebase.
> 
> Define it for RV64 only.  Reading the counter whole on RV32 takes time and
> timeh in a loop, and no RV32 user in tools/perf needs it that much, so
> RV32 keeps the weak stub.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul
