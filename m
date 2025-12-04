Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BFD286D63;
	Thu,  4 Dec 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874760; cv=none; b=Ak20x6LShcgQS4lNfYAoIb4ObkBHo2qEwp0FAqta3rG3RD/C1aRsaVoyw8X6xfAcrF/8CXj1XSCnBRcbXpXeVcDYQdZtEYg/n2cD+4I3kmUi4Z8uPgiu04TuIi0QZK1ZcmHJmsyEq1VOAH0rXDzv3WjifY+MAeFCh4HJuS/LOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874760; c=relaxed/simple;
	bh=W6v7/A6dBcSpaZ5N3ccZis3CxGBhdHTbLC2vUArtf58=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=VVI5YORMG7OIQq5hg+ZTxHJEnBthq1WyaJS1+RCFW9gmnPk40b3LicsGGlHHGqxfBS1q5uPkiTCG5KB0AqkOFr9nYL0IEiEKNJHcsJFxp82Jl9fxzaQVtC+OhlOzD5gAEi6/u0WzysehmR6NjfWHeIq+8a9fPu2OFB84GkOLB1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUVTJ2Uk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUVTJ2Uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764874758; x=1796410758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=W6v7/A6dBcSpaZ5N3ccZis3CxGBhdHTbLC2vUArtf58=;
  b=WUVTJ2UkTgAcGB7cMIa29RsUSnAE77h180ui7qlH7K+z/QZz4af81CkQ
   UR1ED+NUV77iImXa2b/edVqoMqVNSQrVQwOReCNigOO7LKgvc0vVosAr2
   L1Ln3sEeYXOdFTzCRPlw6ehyRLhHtU52NvXp3bPzseFUQvMRD69ZeEhWC
   XahN/nJc8WGCXtnZAWA2qDTTp9/mfa2mMwsN0EspLUDSGCNVtc7ljqcm/
   OyLovYrSXzkTwN/NzG3EEZ574yh1mHRW7pLswzTOikYfAl2fHsrRGEK0t
   RfM462C165MjQz0fX1BF9pFr/bpMFmWTeLiBQ6h3jG4Z3ekRFynAX29G1
   Q==;
X-CSE-ConnectionGUID: nwCrZwhaSju6Cte9OT+1cw==
X-CSE-MsgGUID: 50mhvzedShmkckdtDvsbEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66788159"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="66788159"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 10:59:18 -0800
X-CSE-ConnectionGUID: 5BX6+0HtRfGSSuwchY/cwg==
X-CSE-MsgGUID: 2Gy5TwZcTl6qxGnlwS2ypw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="194952291"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.108.81]) ([10.125.108.81])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 10:59:16 -0800
Content-Type: multipart/mixed; boundary="------------vc7s0RPLK54dAdS70enIaN0e"
Message-ID: <f4521211-b8e2-41a6-9ae1-cfedcb8dd7b2@intel.com>
Date: Thu, 4 Dec 2025 10:59:15 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 06/19] perf/x86: Add support for XMM registers in
 non-PEBS and REGS_USER
To: Peter Zijlstra <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-7-dapeng1.mi@linux.intel.com>
 <20251204151735.GO2528459@noisy.programming.kicks-ass.net>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20251204151735.GO2528459@noisy.programming.kicks-ass.net>

This is a multi-part message in MIME format.
--------------vc7s0RPLK54dAdS70enIaN0e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/25 07:17, Peter Zijlstra wrote:
>> - Additionally, checking the TIF_NEED_FPU_LOAD flag alone is insufficient.
>>   Some corner cases, such as an NMI occurring just after the flag switches
>>   but still in kernel mode, cannot be handled.
> Urgh.. Dave, Thomas, is there any reason we could not set
> TIF_NEED_FPU_LOAD *after* doing the XSAVE (clearing is already done
> after restore).
> 
> That way, when an NMI sees TIF_NEED_FPU_LOAD it knows the task copy is
> consistent.

Something like the attached patch?

I think that would be just fine. save_fpregs_to_fpstate() doesn't
actually change the need for TIF_NEED_FPU_LOAD, so I don't think the
ordering matters.

--------------vc7s0RPLK54dAdS70enIaN0e
Content-Type: text/x-patch; charset=UTF-8; name="tif-after-xsave.patch"
Content-Disposition: attachment; filename="tif-after-xsave.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS9zY2hlZC5oIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vZnB1L3NjaGVkLmgKaW5kZXggODkwMDRmNGNhMjA4Li4yZDU3YTdi
ZjU0MDYgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS9zY2hlZC5oCisr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS9zY2hlZC5oCkBAIC0zNiw4ICszNiw4IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBzd2l0Y2hfZnB1KHN0cnVjdCB0YXNrX3N0cnVjdCAqb2xk
LCBpbnQgY3B1KQogCSAgICAhKG9sZC0+ZmxhZ3MgJiAoUEZfS1RIUkVBRCB8IFBGX1VTRVJf
V09SS0VSKSkpIHsKIAkJc3RydWN0IGZwdSAqb2xkX2ZwdSA9IHg4Nl90YXNrX2ZwdShvbGQp
OwogCi0JCXNldF90c2tfdGhyZWFkX2ZsYWcob2xkLCBUSUZfTkVFRF9GUFVfTE9BRCk7CiAJ
CXNhdmVfZnByZWdzX3RvX2Zwc3RhdGUob2xkX2ZwdSk7CisJCXNldF90c2tfdGhyZWFkX2Zs
YWcob2xkLCBUSUZfTkVFRF9GUFVfTE9BRCk7CiAJCS8qCiAJCSAqIFRoZSBzYXZlIG9wZXJh
dGlvbiBwcmVzZXJ2ZWQgcmVnaXN0ZXIgc3RhdGUsIHNvIHRoZQogCQkgKiBmcHVfZnByZWdz
X293bmVyX2N0eCBpcyBzdGlsbCBAb2xkX2ZwdS4gU3RvcmUgdGhlCg==

--------------vc7s0RPLK54dAdS70enIaN0e--
