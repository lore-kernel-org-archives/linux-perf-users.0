Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA80237180;
	Tue,  9 Dec 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765296375; cv=none; b=iquKWcWKk+zhjqwiIPEzL9fbDHTF56iUBQTqmM9jc3h5CulMyzioEE8M/PQ03L/1pOzJN8sAgIHRK5SpOr0EVSDxruCeiz5k8fhjr2LV9cS3wcNN5pUPE1y+uBFSb10yjxARCOF6JQBhN61NnbJB8u0v0xxJgm+qFe1kwyf/BoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765296375; c=relaxed/simple;
	bh=P2STSWWWjeftoBcHAjwCFwgdgm8jmQl2pXzfOMmKFlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9k+Q6swWnVuJHgNOldk4krFROg5L3LGpQpWuWSV0lJDYv41cY0szNpdzzEG923omtD838WjJzY1xNnl4ICIgd2eSn473GLZTPJfOfz1EZSpeef5cvB1nhTZNUFt/PqrjNAr+0Xjd725E9AONnLxhp92JZ4Wpuifqc2JGv7fups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0B3175D;
	Tue,  9 Dec 2025 08:06:05 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 642CC3F73B;
	Tue,  9 Dec 2025 08:06:12 -0800 (PST)
Date: Tue, 9 Dec 2025 16:06:10 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Mike Leach <mike.leach@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 06/19] coresight: trbe: Refactor syndrome decoding
Message-ID: <20251209160610.GY724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-6-7da32b076b28@arm.com>
 <65c84357-0bda-454f-88c3-623b3ff9d29d@arm.com>
 <1c1092e6-aa5d-4bb1-84e5-81151a02cc6f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c1092e6-aa5d-4bb1-84e5-81151a02cc6f@linaro.org>

On Tue, Dec 09, 2025 at 01:17:50PM +0000, James Clark wrote:

[...]

> > > +    pr_err_ratelimited("%s on CPU %d [TRBSR=0x%016llx,
> > > TRBPTR=0x%016llx, TRBLIMITR=0x%016llx]\n",
> > > +               err_str, smp_processor_id(), trbsr,
> > > +               read_sysreg_s(SYS_TRBPTR_EL1),
> > > +               read_sysreg_s(SYS_TRBLIMITR_EL1));
> 
> Don't you need to use %p to not leak pointers?

I will use "%pK" instead for debugging purpose when set
kptr_restrict=0.

> > > +    return TRBE_FAULT_ACT_FATAL;
> > >   }
> > >   static unsigned long trbe_get_trace_size(struct perf_output_handle
> > > *handle,
> > > diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/
> > > hwtracing/coresight/coresight-trbe.h
> > > index 45202c48accec7c86ba56130e2737bc2d1830fae..d7f7cd763c0c7139cf322b7336ee563073e3bea0
> > > 100644
> > > --- a/drivers/hwtracing/coresight/coresight-trbe.h
> > > +++ b/drivers/hwtracing/coresight/coresight-trbe.h
> > > @@ -35,9 +35,11 @@ static inline bool is_trbe_enabled(void)
> > >       return trblimitr & TRBLIMITR_EL1_E;
> > >   }
> > > -#define TRBE_EC_OTHERS        0
> > > -#define TRBE_EC_STAGE1_ABORT    36
> > > -#define TRBE_EC_STAGE2_ABORT    37
> > > +#define TRBE_EC_OTHERS            0x0
> > > +#define TRBE_EC_GP_CHECK_FAULT        0X1e
> > > +#define TRBE_EC_BUF_MGMT_IMPL        0x1f
> > > +#define TRBE_EC_STAGE1_ABORT        0x24
> > > +#define TRBE_EC_STAGE2_ABORT        0x25
> 
> I know some were already defined here, but this should probably be an enum
> in sysreg.

Good point.  Will do.

Thanks,
Leo
