Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A42D595F
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695438; cv=none; b=uJYyqa1qG4Z/ZI48ul7MyDqSq2pty+Z9WpR3/BD7fQxT6dVfLjztcZ6kaE6dLT8kLG1EeUMyG+cjvg8W9Nj32ErzBlVcU96QbGaflRRTCVjqUVIdBABHgxJvB4NwHH1CmsShF2T+XUqvVsALgTNqKpCXCArKwluUm1D4PWdEqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695438; c=relaxed/simple;
	bh=a7NC+nFJ+Tuc2PzrYJ4DR6DBBp1CMW7ltoY50S0P/kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr9iEWP4j96uDrF6I8jsgA+1wi5m/2bpVk+G35JANQOCCPJ86x2EmiY6AqHR/BT/X+g5qTgpfIXITJY25RTbDMLrTuVr7u4a/1hMn+yIkBZPdV0BrCBayg+fUn+emqUuEaTV+RillcNjWW6BGMXHz+EpzlmlYdwZcpkmxSmPKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E9CE1595;
	Fri, 17 Oct 2025 03:03:48 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA5FB3F59E;
	Fri, 17 Oct 2025 03:03:55 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:03:54 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 05/25] perf arm_spe: Decode ASE and FP fields in other
 operation
Message-ID: <20251017100354.GA281971@e132581.arm.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-5-1150b3c83857@arm.com>
 <897c28a8-599f-44b3-8939-8279d2639f2c@linaro.org>
 <a252e477-2f5c-41ef-8cf9-bcee5e0e7574@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a252e477-2f5c-41ef-8cf9-bcee5e0e7574@linaro.org>

On Thu, Oct 09, 2025 at 10:06:34AM +0100, James Clark wrote:

[...]

> > > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > @@ -351,8 +351,12 @@ static int arm_spe_pkt_desc_op_type(const
> > > struct arm_spe_pkt *packet,
> > >                   arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
> > >               if (payload & SPE_OP_PKT_SVE_PRED)
> > >                   arm_spe_pkt_out_string(&err, &buf, &buf_len, " PRED");
> > > -        } else {
> > > +        } else if (SPE_OP_PKT_OTHER_SUBCLASS_OTHER(payload)) {
> > >               arm_spe_pkt_out_string(&err, &buf, &buf_len, "OTHER");
> > > +            if (payload & SPE_OP_PKT_OTHER_ASE)
> > > +                arm_spe_pkt_out_string(&err, &buf, &buf_len, " ASE");
> > > +            if (payload & SPE_OP_PKT_OTHER_FP)
> > > +                arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
> > >               arm_spe_pkt_out_string(&err, &buf, &buf_len, " %s",
> > >                              payload & SPE_OP_PKT_COND ?
> > >                              "COND-SELECT" : "INSN-OTHER");
> > 
> > A warning for unknown packet type would be useful here now that there is
> > no final else catch-all.
> > 
> 
> Although I see it's consistent with other cases now. Maybe it could be a
> later fix to add unknown packet type warnings for all cases.

Yeah, a new version of the patch set will address the comments in this
series, except that I'd prefer to defer adding a warning for unknown
types.

Thanks a lot for review!

Leo
