Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F2298CA5;
	Mon, 20 Apr 2026 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684923; cv=none; b=sX5h+td4OvkQdkUfcx5o2eZALOUOaPLbgosiA2RotEnZMqzkmZrFHQ9BiY8hP25Mqx6HGwoFyHMr1sBZ3j60+jON2KeAGOCFSU3v5RNbffjaGG0hDE+FiahJz/j3kbLr7u4Er9w29MqFoYYnARf3FPhKDOBxNbBiGELa/5CyBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684923; c=relaxed/simple;
	bh=9tGGymsFYuXXd0c9Ws53eSK9oULmEMhNB+4cg6xA0wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq9QX+8C+ZyZ3or0i1SSVWddb5wH2pWZR230BUXnIswPJX6m76cIgLEF8a5U64h6rJBlz7+ja8yAV0wZyoCqq/2PCgCMrAIoQuFLOHTmfPd0lrOKEDW6UQQidUEH7/rRi1fNQmQqP3DmpBKeH7ptU1aY0YoRwZQLPraTiUpNUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ONWbn9IZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ONWbn9IZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mh9rAB4Yj/2VP7Lm9kkbFqE5vJwwhST9aKDmk2h4fGM=; b=ONWbn9IZ9sIRiUMEWWP1fxo35C
	ED0HDysXWL561RSuuOG8Zm+ZJTaBIst8/Z+iTWZtq6sYLNPxmmg6yutC5G/K8MmFWzY/1eMCHmYZF
	AISwOuoIjTNb/nVEAIKtYvXf8TozZOXk0dyWAVNcMrPVwvCmLtrkDg1MiImn8kTBmjFLJkx5EceLK
	1LM3ch1sSJaaoamPHG/2xGSTN8apuvImlZHRNTyppi+5vxO12I6rVUAAONxm5Ss7xzTanCyYYL5Ny
	q19k5T+0O1f5LQFXqoG+aSyDjlsLD31lmpZVILzlDXD/n07bnAhMCLGFkaTX1E4Y3WawiOBuy/a32
	sELsVSUg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEmuH-00000007pSE-2UyD;
	Mon, 20 Apr 2026 11:35:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B7078301BDE; Mon, 20 Apr 2026 13:35:12 +0200 (CEST)
Date: Mon, 20 Apr 2026 13:35:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
Message-ID: <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
References: <20260420091634.128787-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420091634.128787-1-jgross@suse.com>

On Mon, Apr 20, 2026 at 11:16:28AM +0200, Juergen Gross wrote:

> - Use functions instead of macros for accessing MSRs, which will drop
>   modifying variables passed as a parameter.
> 
> - Eliminate multiple accessors doing exactly the same thing (e.g.
>   rdmsrl() and rdmsrq()).

So far so sane.

> - Instead of having function names based on the underlying instruction
>   mnemonics, have functions of a common name space (msr_*()).

Not sure on this one. The whole msr_{read,write}_{safe,noser}() thing is
a royal pain. Also 'noser' reads to me as the noun that goes with 'to
nose' [he that noses (around), like baker: he that bakes].

I would much rather we just stick to the mnemonics here. All of this
really is about wrapping single instructions, no need to make it an
unreadable mess.
