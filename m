Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6048288C2F;
	Tue, 23 Dec 2025 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766469176; cv=none; b=osRl1f6bEQ2KwbrTsyiQ/F3yr6JitWR2XMNu2kbYbitZ5+S2sBbt4X4kjg5L3VNqIPFC40kjulXliNZ75KXR9wzytJmdmB0Chz0Tj4EmB+lX+uJkCGqSj+uYy4/0B6+Cs2oC++nBvIqNucN1YmgLMQLfJKRI+q0TSLXfkBwnoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766469176; c=relaxed/simple;
	bh=RkXyG34uY5YWKn7k6JtW1TB/xYsa8JjgNjok6WEVqLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEg7n4IKpmE5nXbyn0nO3tMH+v7PI/83y9lViUbjRgTRCCUcEqip0qZ22OAJq6Tr9XbIwNZEtprRfU5/2EZACaRqJJk7yAkAf+DyS/sKEBokbP6nZHyLW7/Dc1A7IDifgCOKAhcs/CJkWZ6dti2rN2bsib2925LZXYPfi0aF5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djrGqHFB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djrGqHFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766469175; x=1798005175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RkXyG34uY5YWKn7k6JtW1TB/xYsa8JjgNjok6WEVqLw=;
  b=djrGqHFBWduXAFhb6j9ib34iS6bW7e7nvOtzMIForBdQCRBzwnsNyaek
   dFkgKQ3G6ddImzbKx+6Ie8CJKUlG66J000Cqpj4J5IvCCNsOxxpj+vgfc
   +JWFbOXQua9xG/kafcl7wCRoZ5fa4H2Sf8IsKNzX7V6Z6GY8LdA6UFGu8
   MLd9wTrXGKOL0ELOAunQ6LU7hCASaTF6vsT6WbjNMCPuoLo1icrYXLSb7
   P4PyEIzQP+AS6sDAF7HV0+M5RGj9gwoJvooRljpZ7Oi8kV6wLufW/ln0l
   5kbt694enaV7N1DKxTUqXpGlonqRwxnJ4395rA7JUBSiqxMWLwfHlV+l3
   g==;
X-CSE-ConnectionGUID: zs1UnkxTRnWd6QBYkNV0JA==
X-CSE-MsgGUID: LxZPmoSHRGOWEUOUkzEBLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="78634311"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="78634311"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 21:52:54 -0800
X-CSE-ConnectionGUID: C1B9e9e9TKywv6yDtkvO4A==
X-CSE-MsgGUID: RwSXUI5cSEuepgfjbRYteQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="200611519"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 21:52:50 -0800
Message-ID: <7f151e4e-7fcf-4007-9c7d-a90af1c05f84@linux.intel.com>
Date: Tue, 23 Dec 2025 13:52:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] perf/x86/intel/uncore: Update DMR uncore constraints
 preliminarily
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
 <20251212210007.13986-7-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251212210007.13986-7-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/13/2025 5:00 AM, Zide Chen wrote:
> Update event constraints base on the latest DMR uncore event list.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 81 ++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index e5b95fa75313..8068b9404ecb 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6760,10 +6760,72 @@ static const struct attribute_group dmr_cxlcm_uncore_format_group = {
>  	.attrs = dmr_cxlcm_uncore_formats_attr,
>  };
>  
> +static struct event_constraint dmr_uncore_cxlcm_constraints[] = {
> +	UNCORE_EVENT_CONSTRAINT(0x1, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x2, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x3, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x4, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x5, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x6, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x7, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x8, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x9, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0xa, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0xb, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0xc, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0xd, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0xe, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0xf, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x10, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x11, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x12, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x14, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x1d, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x1e, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x1f, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x20, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x21, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x22, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x23, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x24, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT(0x41, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x42, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x43, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x44, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x45, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x46, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x47, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x48, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x49, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x4a, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x4b, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x4c, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x4e, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x50, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x51, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x52, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x53, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x54, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x55, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x56, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x57, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x58, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x59, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x5a, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x5b, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x5c, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x5d, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x5e, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x60, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT(0x61, 0xf0),

Could we define a "UNCORE_EVENT_CONSTRAINT_RANGE()" macro just like what
core PMU does (refer INTEL_EVENT_CONSTRAINT_RANGE macro)? Then we don't
need to add so many lines.

Maybe like this,

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 698bcd7fe5a0..bc4367a6628e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -437,7 +437,7 @@ uncore_get_event_constraint(struct intel_uncore_box
*box, struct perf_event *eve

        if (type->constraints) {
                for_each_event_constraint(c, type->constraints) {
-                       if ((event->hw.config & c->cmask) == c->code)
+                       if (constraint_match(c, event->hw.config))
                                return c;
                }
        }
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 338713cd7a7d..f6fcee2a505e 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -32,7 +32,8 @@
 #define UNCORE_EXTRA_PCI_DEV           0xff
 #define UNCORE_EXTRA_PCI_DEV_MAX       4

-#define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
+#define UNCORE_EVENT_CONSTRAINT(c, n)          EVENT_CONSTRAINT(c, n, 0xff)
+#define UNCORE_EVENT_CONSTRAINT_RANGE(c, e, n) EVENT_CONSTRAINT_RANGE(c,
e, n, 0xff)

 #define UNCORE_IGNORE_END              -1


> +	EVENT_CONSTRAINT_END
> +};
> +
>  static struct intel_uncore_type dmr_uncore_cxlcm = {
>  	.name			= "cxlcm",
>  	.event_mask		= GENERIC_PMON_RAW_EVENT_MASK,
>  	.event_mask_ext		= DMR_CXLCM_EVENT_MASK_EXT,
> +	.constraints		= dmr_uncore_cxlcm_constraints,
>  	.format_group		= &dmr_cxlcm_uncore_format_group,
>  	.attr_update		= uncore_alias_groups,
>  };
> @@ -6775,9 +6837,21 @@ static struct intel_uncore_type dmr_uncore_hamvf = {
>  	.attr_update		= uncore_alias_groups,
>  };
>  
> +static struct event_constraint dmr_uncore_cbo_constraints[] = {
> +	UNCORE_EVENT_CONSTRAINT(0x11, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x19, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x1a, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x1f, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x21, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x36, 0x1),
> +	EVENT_CONSTRAINT_END
> +};
> +
>  static struct intel_uncore_type dmr_uncore_cbo = {
>  	.name			= "cbo",
>  	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.constraints            = dmr_uncore_cbo_constraints,
>  	.format_group		= &dmr_sca_uncore_format_group,
>  	.attr_update		= uncore_alias_groups,
>  };
> @@ -6811,9 +6885,16 @@ static struct intel_uncore_type dmr_uncore_dda = {
>  	.attr_update		= uncore_alias_groups,
>  };
>  
> +static struct event_constraint dmr_uncore_sbo_constraints[] = {
> +	UNCORE_EVENT_CONSTRAINT(0x1f, 0x01),
> +	UNCORE_EVENT_CONSTRAINT(0x25, 0x01),
> +	EVENT_CONSTRAINT_END
> +};
> +
>  static struct intel_uncore_type dmr_uncore_sbo = {
>  	.name			= "sbo",
>  	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.constraints		= dmr_uncore_sbo_constraints,
>  	.format_group		= &dmr_sca_uncore_format_group,
>  	.attr_update		= uncore_alias_groups,
>  };
