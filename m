Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295681;
	b=E9TEe86DZ5Man7xtn43JBfonznuu20yIeXodeW+U5B8eaoSEcSpbWRkonKK4Y8r2w9aC
	 Kk8eLqEqBzIQ1fbmHvt4dYoe1BggBqhmK0xzcBpfrXBBWOxKC2QGgDr6A+VjvOK0PuZZ/
	 lGxqlLKJ+Faq2iiYQ+klvhMhpCrArOTizdfEU3wweNXAB8ThpJgzmmPtAKr8sT70XBkSl
	 ut89J19y+AbTr13JrjvAK9UyWHPtOeOEzb86re5VZ1Vg7hYhINlTeoKsIdpksZDDAUDbP
	 JYqhiV3uauVZrfZhlKGHKIIgSyxIW5K8SyBXHZezZp/EYVXSQqyzMOCCIB5Sbf5rBpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295681;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JJWiOAmxy65xzOnIzkKiZHs547R//LqHsI7/Rc5J/Mc=;
	b=FHE1CeWR7wR5mdmCAAW8+Qn9uzqnBVz/PBzZSKo12XgS33DNvlfEpLVdAcAu/Afh7cWT
	 sW20sej8e//fZwdnmu0LtEI9KIFwyboguTXSsjeeYKl1xKo8JGIHwGoHe+5eN7JqjgkCG
	 aI689vA8EV03iQklOEuvQWXrgGfbo0Tw5oVtmv2n8Y5Dt0WClYQMh8MOszyHyQKYjzez2
	 xE/wW9y5HnlPqLTOW37lhVM7ekHcIy7zAYmCaSCm0pS/UB64vc2bqklg1tNLATP2xsfm8
	 uDBpoKC7x3SgrsqrcRRKhMEeROP6FsS02wsOGHCGOFkA7RqK6zDlAJnPGoP9giqRCXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OpX1LeaD;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11813606A31C;
	Thu, 29 Oct 2026 17:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11813606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OpX1LeaD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C3421682;
	Thu, 29 Oct 2026 10:41:17 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B39BF3F59E;
	Thu, 29 Oct 2026 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793295680; bh=GrLXrVxy0qLGUj63FcOKiSL+aGileL5U0QJtN0lpGjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpX1LeaDGd5qmg1b/GecPwfvsij4QQBlMterRUW7DW2dgl6Rc3ZH4ZPupZSb9LimB
	 3izdwbPMZjn16r9O0DOrXshgNp7fhFXT091I41e35b4ioOmF0SjQl5Q7dRIuhpehd8
	 ewYB2RmQbvzBn6Z9P+0r0bTgS/dGGz7C0mYN9e/Y=
Date: Thu, 29 Oct 2026 17:41:17 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Subject: Re: [PATCH v2 09/14] perf cs-etm: Classify exception calls using the
 exception packet
Message-ID: <20261029174117.GC9176@e132581.arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-9-6ab8c07a5455@arm.com>
 <7bed4275-0b97-46d7-b250-5039aa95eccf@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bed4275-0b97-46d7-b250-5039aa95eccf@linaro.org>

On Tue, Sep 29, 2026 at 03:08:42PM +0100, James Clark wrote:

[...]

> > @@ -174,6 +174,7 @@ struct cs_etm_packet {
> >   	enum cs_etm_sample_type sample_type;
> >   	enum cs_etm_isa isa;
> >   	u64 start_addr;
> > +	/* For exceptions: preferred return address, or CS_ETM_INVAL_ADDR. */
> >   	u64 end_addr;
> 
> Minor nit, but you could use a union. I don't know how clear re-using
> "end_addr" id for exception packets is when reading the code.
> 
>        union {
>            u64 end_addr; // Range packets
>            u64 pref_ret_addr; // Exception packets

Will do.
