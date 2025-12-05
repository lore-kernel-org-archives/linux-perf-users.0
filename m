Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10966305E21;
	Fri,  5 Dec 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764937228; cv=none; b=CuhklFlshKP42fDHLhXdkk2kDhhf0+QOUJnlvPXRobqmGhhat0Sa47gOgN1OAJo1Ce0DgIquf2cdfqr2Bo3KzQ7qqP4Cb00ZUY8xLcCRa01co8YLOzoJ2tF855RYq3YJuugKicMrFF4nMdmqLbs1QY9q/EXT0H+fvEWTD0edvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764937228; c=relaxed/simple;
	bh=DPIhu8XnTCVMPFNHevide2mG3+yqmFRajE0zcEXy09I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFjdYK+Z2ufiha+ux0e/tbg8Cpr2S44J0lBOQ7qDAUG+MdD/s6EGyd9dGZ1UGgwsD+ASvUsG18Rg6nk1HXcEJw+z0Un89h8AO+wVcn23QuNTn7prKZYp73NXb2Duz9LAggPJnp6C8k8IWV24EGXJIWtkmhqHEz5EHlW0RC+Xzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XsSUiGm+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsSUiGm+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ehDwBewhH1/6tfSSiV/1JrOnKVPG0Ugl8MAlZIQBjLQ=; b=XsSUiGm+cGAvF1DbkF0FyWgp4C
	4qh01l5qqztl+H07e85CXhOsMRn8h9HmMTQIjRXaNgTfSqhZD2d+EkOuEStthghA0bpMOcP+riCYl
	P7AmYXGndblQUlEuxd3/caSA0JziyaN2kSilFYKVntLQwIgjZg2vbOtvg7Um+vOBKdSWCPBBnQN/b
	j65Di4PwvPuzXddYdl/gkh7y1Ltok2K/VEtI7zP3CWvolYM2KfTnJ0ITts4GyDVzrTwnSxXdUvYSa
	KQloJ8qj/Rn3tPEjzFXlJZORox3yRnCR4PrR9MXkfewcQmgk6GaE67/8QWuK9KxDwSWJmOHwNOAr7
	oB4cefvg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRTvj-00000005z1N-1LjJ;
	Fri, 05 Dec 2025 11:24:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 21FE03003C4; Fri, 05 Dec 2025 13:20:14 +0100 (CET)
Date: Fri, 5 Dec 2025 13:20:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v5 13/19] perf/x86: Enable SSP sampling using
 sample_regs_* fields
Message-ID: <20251205122014.GX2528459@noisy.programming.kicks-ass.net>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-14-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203065500.2597594-14-dapeng1.mi@linux.intel.com>

On Wed, Dec 03, 2025 at 02:54:54PM +0800, Dapeng Mi wrote:
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index ca242db3720f..c925af4160ad 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -729,6 +729,10 @@ struct x86_perf_regs {
>  		u64	*egpr_regs;
>  		struct apx_state *egpr;
>  	};
> +	union {
> +		u64	*cet_regs;
> +		struct cet_user_state *cet;
> +	};
>  };

Are we envisioning more than just SSP?

