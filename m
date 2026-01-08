Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F8496F5F
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880461; cv=none; b=Jb3XB3hhdsmXEjLZnu2yK1Psk1WAz1fhFgNqxscXOR+hyCWu30kZSHAA1VxEvztB1tvVilmn7p+emBnq2hguwHVKb1gir1faVS6XjjeOys2WG4+ubGe65VWoguN5sYkIsOMz1bNYT0IPys9oK33QIAuhbAqo5Ketlc7PQ+PfZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880461; c=relaxed/simple;
	bh=cuQ2dPAO2JBpXVAxUbPVmACLuq/If4emBH+mP+jKAQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bhy9UOszKN4ZnWHcgya1MsGFoSg5YBi328Le4KCdz5GACUZY6WHV3kVXCJTQ/HIUHEruQzEj8Jc0fWx7i0IZoM64wqTp9BeX16kaB2vn5z6AbIxT+R/G5p6sfbAEbNeT0mbjyRvptiL6lP7OkKvm+7htTlAzxduxSqFoV7d+qYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YvxsTmol; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YvxsTmol"
Message-ID: <72a635cb-05c7-47d2-84aa-4d82d1e0aebd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767880444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh/13QNGjy5fh8wgOgf8HymnWSbTi33cjlQA9koC/94=;
	b=YvxsTmolbA5Wh006Ic/eDgN5Y8b8wMd+GNxCbgYGADxMD56bjxULHCu+vf6mXH4k2YLauU
	NVET58bUTHjTlxu+mGw7H0XewJd3EQNea4b2nJ9pE7OcATnbwHJOe+h7Bq6x9O1V71iJ0N
	6Ywbx67nFoyJaggMc0o18MxQpqeQAqw=
Date: Thu, 8 Jan 2026 21:53:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.6.y 0/4] perf/x86/amd: add LBR capture support outside
 of hardware events
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260102090320.32843-1-leon.hwang@linux.dev>
 <2026010809-matchless-reporter-3129@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <2026010809-matchless-reporter-3129@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/8 19:11, Greg KH wrote:
> On Fri, Jan 02, 2026 at 05:03:16PM +0800, Leon Hwang wrote:
>> Hi all,
>>
>> This backport wires up AMD perfmon v2 so BPF and other software clients
>> can snapshot LBR stacks on demand, similar to the Intel support
>> upstream. The series keeps the LBR-freeze path branchless, adds the
>> perf_snapshot_branch_stack callback for AMD, and drops the
>> sampling-only restriction now that snapshots can be taken from software
>> contexts.
>>
>> Leon Hwang (4):
>>   perf/x86/amd: Ensure amd_pmu_core_disable_all() is always inlined
>>   perf/x86/amd: Avoid taking branches before disabling LBR
>>   perf/x86/amd: Support capturing LBR from software events
>>   perf/x86/amd: Don't reject non-sampling events with configured LBR
> 
> 
> Why is this for a stable kernel?  Isn't it a new feature?  If you need
> this feature, why not use a newer kernel tree?
> 

This series enables LBR snapshot support on AMD CPUs.

You are right that this is not a bug fix but a feature enablement.
If backporting this to the stable tree is not appropriate, that is
totally fine. In that case, I will carry these changes in our in-house
stable kernel instead.

Thanks for the clarification.

Thanks,
Leon


> thanks,
> 
> greg k-h

