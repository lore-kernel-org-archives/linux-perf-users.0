Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5C3D88F6;
	Tue,  6 Oct 2026 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282124; cv=none; b=QPocp6e6ao/uplK6nPrfMtD4X+QhPlgwJQH+EkcAYFN161UL9jpjpw9kZTHql6Rm1jVPtUqWM3ubc5jX5jJ/PS2RepAq3JLibbPNsVItPsAoHuNN5bGM8v0z44C0Bn2DsQDnOl5S60yBVXuKkkpGcfcpbH8Vffv1B0G7gWzlLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282124; c=relaxed/simple;
	bh=H/0IBsqQnXm4Zcf8F5gvrhFBxYY23PJO+BseCi64kEc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Pnij1i1KsZXi71reJWkzoIlCPIDxlgmGTCqc413QnAp2ynEEZea79XCK7UMKdjjwbBJyKtkEFKoAr3Mzxxy9RNdsWWPHThCvRstcW9daLTQpZ7lX2bs6h4Tol4rEzVhzy/fRycHqbv0Asdwc+Xs2n2IPbrsNrJF6J46ZIulaytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1U5RfrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1U5RfrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC6B1F000FF;
	Tue,  6 Oct 2026 10:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791282122;
	bh=tvi6puQA0J0hA9rYePYBkk/sQ0USpeIPJk0WcZ47PBs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=J1U5RfrKVeP+O4jqaKDHgViRN05qb9EM9Ow1h1Wq3zq++FQwMjOceD42csp5T2HCP
	 i4SQN58VQayxBkq/PLuKIXLU+KdLNU9LT0f6v3i5OyTx3dwvfYPKAgq1fvXfLrF0bM
	 /QcMGDDxqEEv/AaEnXTMVA5Z2b19XuC+aLAR6Bnw9DJxQT36qn3BCzvnXP3mkPMC49
	 Rqi68kedr200C4HRCqsVLWgsyVU0VK6suF3v8YaykyMc4wf5GKLPSdbWX8zBA7gKqX
	 HoBRJ3r01WmcEZLIAyF5w1Uzxv8mxRmPnxv1ODiOYAx/mqEnviAm2uzXFHPcXoI7yz
	 qkeItwitvc/sA==
Date: Tue, 6 Oct 2026 04:21:53 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>, 
    Conor Dooley <conor@kernel.org>, Anup Patel <anup@brainfault.org>, 
    =?ISO-8859-15?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, 
    Yunhui Cui <cuiyunhui@bytedance.com>, Atish Patra <atish.patra@linux.dev>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
    Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
    Yuanzhu <yuanzhu@bytedance.com>, Yicong Yang <yang.yicong@picoheart.com>, 
    Susheng Yang <yang.susheng@zte.com.cn>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 0/9] riscv: add SBI Supervisor Software Events
 support
In-Reply-To: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
Message-ID: <29e631f0-c135-bea4-0a3b-81dd715cef54@kernel.org>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Zhanpeng Zhang,

On Fri, 11 Sep 2026, Zhanpeng Zhang wrote:

> RISC-V does not architecturally define a supervisor-mode non-maskable
> interrupt (NMI). An interrupt that arrives while Linux has cleared SIE stays
> pending and is not observed until interrupts are enabled again. That is
> correct for ordinary interrupt handling, but some kernel work needs an
> NMI-like notification that can run even inside an interrupt-disabled region:
> sampling a PMU overflow at the instruction that caused it, or taking a
> high-priority RAS report promptly, cannot wait for the next unmask boundary.
> 
> The SBI Supervisor Software Events (SSE) extension [1] fills this gap. It lets
> Linux register handlers for events that the SBI implementation can deliver
> ahead of ordinary traps and interrupts, giving RISC-V the NMI-like supervisor
> notification mechanism it otherwise lacks.

Thanks for taking this series forward.  Could you please rebase this 
series against the current riscv/for-next branch and repost?  I tried 
pulling the series in, but it needs quite a few updates since we've 
queued up quite a few patches that touch SBI.

thanks,


- Paul
