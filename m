Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1755F3624C2;
	Thu,  9 Apr 2026 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699980; cv=none; b=RDJcJG2g18J0dNpCUro1dtgPmnGU87uBS9oFuJClG5bbIMNZvODLhAv7uiJwXAQ68ZHWAVYQSn4F2gPv4x4wU9lqAJZeaykbnBnN+uhluccypIhblSwKnH97VNJcdC6UnTWNpH4NjTPV71dHmSWcvOw73i+saoLTk4+tbm8G5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699980; c=relaxed/simple;
	bh=2HrOp37fQxdFB47qXVdNlgwS0HuWdAv82BC0SjBQfS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S60A4ySg3Do+gaUfBobQ01L/W531ZFnRKCTVlD9IZDmGV6jFlfPcqC8es1NMfmld8qxXMVF2KQ6bw1thctLV0qXlk6rH/2TeY+fFOWqxh7zQARoxNo6+GBNJ09AJpGkX2rlIMtZEQdtcqSXIRXSUeThawIShao1cUOLBpD7za7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RVC+g/My; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RVC+g/My"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35B8135C7;
	Wed,  8 Apr 2026 18:59:31 -0700 (PDT)
Received: from [10.164.18.48] (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD8F3F632;
	Wed,  8 Apr 2026 18:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775699976; bh=2HrOp37fQxdFB47qXVdNlgwS0HuWdAv82BC0SjBQfS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RVC+g/MypPGtgpKFXu94wOCcPJ3eIBmkEiXHw/lax/gsDseqBbNEtZmJDeS33+zkh
	 wC+Cd92i4lyXqS6rZg9iJMBRJLOEAm+f1YWFMUscBpFSIFDG1QDDxq+6Eoq/SApNkh
	 1NngORXJi74geLZMY+dO5MZP+ze4M+ooDU/mmax0=
Message-ID: <0a466a66-e9a3-4789-a144-8e938df30010@arm.com>
Date: Thu, 9 Apr 2026 07:29:30 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable
 accessors
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, David Hildenbrand <david@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260227062744.2215491-1-anshuman.khandual@arm.com>
 <1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
 <20260408134923.3a44a703@pumpkin>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260408134923.3a44a703@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/26 6:19 PM, David Laight wrote:
> On Tue, 7 Apr 2026 08:58:46 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> On 27/02/26 11:57 AM, Anshuman Khandual wrote:
>>> Replace raw READ_ONCE() dereferences of pgtable entries with corresponding
>>> standard page table accessors pxdp_get() in perf_get_pgtable_size(). These
>>> accessors default to READ_ONCE() on platforms that don't override them. So
>>> there is no functional change on such platforms.
>>>
>>> However arm64 platform is being extended to support 128 bit page tables via
>>> a new architecture feature i.e FEAT_D128 in which case READ_ONCE() will not
>>> provide required single copy atomic access for 128 bit page table entries.
>>> Although pxdp_get() accessors can later be overridden on arm64 platform to
>>> extend required single copy atomicity support on 128 bit entries.
>>
> 
> Did you consider enhancing READ_ONCE() to support 128bit accesses on arm64?

Yes although it does not really meet all requirements for 128 bit page table access.
