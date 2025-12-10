Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67658285C91;
	Wed, 10 Dec 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383603; cv=none; b=lFuku+Fr5rAXE1e7hmKUY6aaueqhpfFRZ8Mnf3gzBViDig1yiSrsOjJpUE4m/TswIIVcGrHey/Shr58mCh9mhEx9w1sIqBO7qSslQTNWFijhN84gMifLufMETlKT4Vk/7TLigoVFBeQqo2DwN0UR4EPgCQ/D0VEhV81ihBwnK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383603; c=relaxed/simple;
	bh=DzfZSgJNDNINpaNmrIAA6mTIETQ93XXaRym0jJspIoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t64AGsvbUbt/WRRSkwaJu37v8psvPcaZ9nUNMJZlkolbOaWMJCJcKPavDJjF2i6rgxRy8tzZxekFHl3CRFGvL4APKNV8oL9wXPk0Hlix+bXd46xxRt1S9aFtdYmo8KmD8fs4rZlDWdoouFK6LwUOPrioSadGwzXfr6MH95Te8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50DE2153B;
	Wed, 10 Dec 2025 08:19:53 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28C553F73B;
	Wed, 10 Dec 2025 08:20:00 -0800 (PST)
Date: Wed, 10 Dec 2025 16:19:58 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 08/19] coresight: trbe: Use PERF_AUX_FLAG_PARTIAL instead
 of PERF_AUX_FLAG_COLLISION
Message-ID: <20251210161958.GA724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-8-7da32b076b28@arm.com>
 <5f6bcd93-b565-4b10-9a2d-6851141e5dbe@arm.com>
 <f1ac7190-bdd9-4725-8955-d82d6f1912fb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ac7190-bdd9-4725-8955-d82d6f1912fb@linaro.org>

On Tue, Dec 09, 2025 at 01:40:35PM +0000, James Clark wrote:

[...]

> > >   	if (!is_trbe_running(trbsr))
> > > -		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> > > +		perf_aux_output_flag(handle, PERF_AUX_FLAG_PARTIAL);
> > 
> > This is interesting. So there is a no possibility for the records to be
> > overridden in the perf ring buffer and incomplete record is all that can
> > happen when TRBE is stopped, without stopping the ETE first ? Could both
> > of these scenarios might be possible as well ?
> > 
> 
> There's no chance of overwriting because that would be the TRUNCATED case
> and the event would get disabled. PARTIAL seems to be when there was an
> error that's recoverable in the driver only, but as in my other comment I
> don't think the extra complexity is necessary and always using TRUNCATED
> would be enough.

If I extend a bit, I would say that the TRUNCATED flag is used to prevent
buffer overwrites, while the other flags indicate why a record is
incomplete.

Thanks,
Leo
