Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E1268FE0;
	Wed, 26 Feb 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550763; cv=none; b=POpZHKNnFGtl4S9sqOIABXu/0M5zPvaORmPsbhJYIHWHzs6xyWTIBueShhqN1ZanbqNx1t7M3a7+od/2zBJ7wRojYo6Jk5idL8/svq1WbgtGt8uKbmnozjzmds0i34rdwmy/yRYhyrRp44OIKjKsIw+mGQn3gbvas8SQxqYF8es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550763; c=relaxed/simple;
	bh=Oa2YIv4jT7MVju5UNokRoZX38+elx2PrQ7nNMpOU8hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvN6SkP59rw3powFbG68wQJLb2faVNJLsVVUJZ4TpkR/ieyj+03GXW1D1V90q/JrzrZeiLT3F4VXeEYE5iZMsj/KFSxky+9nLPHE4YzJIEU1iSX12jmxf6m8OriqvYVPt4OTzr5dxB0zF3FzS8eebaABJMApxcec2+oqAFr6nSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMMXNNIr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMMXNNIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740550763; x=1772086763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oa2YIv4jT7MVju5UNokRoZX38+elx2PrQ7nNMpOU8hA=;
  b=WMMXNNIrMy36qezdc2EGvfXvWeXjpt5CFqOngkWpyL/kp8CgM88W/fNc
   weH34LanmFTU51iqEBVyj/N1MUamL4I6xsAb3MlC//r3I97ZYGFTN5noS
   sfgRk1SiAPyGYg8hSxFnWzvEMDJDIIjLLA/7tz0z5S8yC+g2mEUT69F7W
   p1IlvzPp7ZfG+xR0HOd0ZSwTaLxueeJ1n9lRC5YYejbJtTl+UsQpxRZ3d
   62Lsp626JRXvEwpPnCF9aarsONlQbpFCXAE40k9Zf500PonTRNhChlTlT
   N2suDIrh6rn+O1ySARGnRQyOMCZxHrghaSHV2b8FHEYTr7AK4xw6P/Kwx
   g==;
X-CSE-ConnectionGUID: Goa++g7KQUqtADreIEbTeg==
X-CSE-MsgGUID: 9Edpz4QlR3O+W6oA2RzKqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="58805161"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="58805161"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:19:22 -0800
X-CSE-ConnectionGUID: XZPyJO19QXea6Q/geZ/vyA==
X-CSE-MsgGUID: DizwxAgrQJaOPiJk0X3zUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147524214"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:19:18 -0800
Message-ID: <000043b8-1284-46f3-b117-9ece905f218e@linux.intel.com>
Date: Wed, 26 Feb 2025 14:19:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 12/24] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-13-dapeng1.mi@linux.intel.com>
 <20250225112543.GM11590@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250225112543.GM11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/25/2025 7:25 PM, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 03:28:06PM +0000, Dapeng Mi wrote:
>> Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
>> buffer physical address. This patch allocates arch-PEBS buffer and then
>> initialize IA32_PEBS_BASE MSR with the buffer physical address.
> Just to clarify, parts with ARCH PEBS will not have BTS and thus not
> have DS?

No, DS and BTS still exist along with arch-PEBS, only the legacy DS based
PEBS is unavailable and replaced by arch-PEBS.

Here is output of CPUID.1:EDX[21] and IA32_MISC_ENABLE MSR on PTL.

sudo cpuid -l 0x1 | grep DS
      DS: debug store                        = true
      DS: debug store                        = true
      DS: debug store                        = true
      DS: debug store                        = true
      DS: debug store                        = true
      DS: debug store                        = true

sudo rdmsr 0x1a0 -a
851089
851089
851089
851089
851089
851089

We can see debug store is supported, BTS_UNAVAILABLE bit (bit[11] of
IA32_MISC_ENABLE) is cleared but PEBS_UNAVAILABLE bit (bit[12] of
IA32_MISC_ENABLE) is set.


