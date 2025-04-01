Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAC1F1517;
	Tue,  1 Apr 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522028; cv=none; b=YJmGdv1Cj+zcXe2z71bJvCWNWxXU+fr+TftoM4Jcd/E5+lfWdDlN+PCP7KaQcVfd1hIlOsdpGjucRdjYQ95vbldcxr62mL4GDaXsap4k5yrxxAgr5+OMTmllojgAZ+L1lMLFqY/33KqSXXuOaElPem6cxv0WBQu9V/av2PlD7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522028; c=relaxed/simple;
	bh=DX6CwGWIOUp8UiX4yk4PGZ/Qz79zFJQanQXwoDWbPuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkhFWOCnvPhWhDPuiBYqYgWk661JBec042NZqO4eyfIrDght20+vj5zYT40LSpTPqJlDv9sjzRuCZUMimrFhYrzJVzXDxbbDB8pvGccK6GZoT9l1+Rzn0dUGIPZe3yK8mUPlD9e2sCkgezL0ZMNBJuHuaUMWCn0SbgvGCjVSFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ak97sMXK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ak97sMXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743522027; x=1775058027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DX6CwGWIOUp8UiX4yk4PGZ/Qz79zFJQanQXwoDWbPuA=;
  b=ak97sMXKFmx4SXBn2EMVtLUwjDfOlzwarxHJAU0NmwJh/m+nI4hHrlFv
   c2NN+Ze6d9aACU5f5NCwRVNePN4Ad5M2BxTWzZi97jMDsUnJVT20Xju3v
   Zjb91PC6gAKjimp+dDYpW8L/bHBG5ZFu6f29g3Bp61KzJfoZMuJrVfsAW
   Q+owJoUfSiMZu6UzETvBQsmR5QbAvpyRxyVc91RF100uEe0fIlKNuC3fv
   F0jSvgM6gDxKhvgZsTYO3fGJDB5rje4xt339wpUDC4eOsMCPkxz6ibml5
   EtH6gDmpWn/tiWIRRHEfnyZt1WUXRA7cdwtw3HGW7pjXwktxZC/QfacyR
   g==;
X-CSE-ConnectionGUID: 8lwC1vkHT0yStL+G4f5C5g==
X-CSE-MsgGUID: iu2w1q7fQZ+GYZEh2VbY8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="62252311"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="62252311"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:40:27 -0700
X-CSE-ConnectionGUID: SmHi2ruaTsaUnzAAaIbRSg==
X-CSE-MsgGUID: 0zVsI6h1S5Ob58iVRHbqVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="163644183"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:40:26 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1A93C20B5736;
	Tue,  1 Apr 2025 08:40:24 -0700 (PDT)
Message-ID: <f93c3fef-8e30-408d-9f2f-e833cfb7b1a6@linux.intel.com>
Date: Tue, 1 Apr 2025 11:40:22 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Rename bts_buffer variables and use
 struct_size()
To: Peter Zijlstra <peterz@infradead.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20250331122938.1837255-2-thorsten.blum@linux.dev>
 <20250401142006.GF5880@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250401142006.GF5880@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Dapeng

On 2025-04-01 10:20 a.m., Peter Zijlstra wrote:
> On Mon, Mar 31, 2025 at 02:29:38PM +0200, Thorsten Blum wrote:
>> Rename struct bts_buffer objects from 'buf' to 'bb' to improve the
>> readability when accessing the structure's 'buf' member. For example,
>> 'buf->buf[]' becomes 'bb->buf[]'.
>>
>> Use struct_size() to calculate the number of bytes to allocate for a new
>> bts_buffer. Compared to offsetof(), struct_size() provides additional
>> compile-time checks (e.g., __must_be_array()).
>>
>> Indent line 327 using tabs to silence a checkpatch warning.
>>
>> No functional changes intended.
> 
> This is two things, as such should be two patches. Also, meh. This is
> going to create extra work for the arch-pebs guys I suppose.
> 

I think the patch only changes the internal variables, while the
arch-pebs only touch the external interfaces. It should be less effort
to re-base.

Thanks,
Kan
