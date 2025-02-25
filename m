Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749861547F8;
	Tue, 25 Feb 2025 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508671; cv=none; b=NTcEHcX0hoMqSAVg5DvO2m1EIqZJwhTj3rvqihZmwj3p7jIMQopDEw/TfPILX6pMhnIn/Z+MdFPNs2yt7GC0aJQBIRzhwflV0AtWRmol0DxDG//NiPJaqkBaZZ7MxBy+1nyKkel8giq0ulswUC3yrl9Y317iAhVZuRKeuJhzMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508671; c=relaxed/simple;
	bh=CsSGSVGXsnciqtuDEb3cszJGFCrc+MFrRp1hTePhSTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2b2gOcrMzb3t4c3jzCvKm7uNtnTcBDey2+IIkw52UbHh6uv3CVXrjk/BpApDVQHxZGQnj/ErI/qWOMdYNnqzOav/z/Gwjh5ZHAPe7G4lV30WScNvDfyCb58hPj1rFj8ZZbf5B4+XTcdEpm8UhZV4vJhSwZQillc1L5axYdgSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=W7O2mrU0; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="W7O2mrU0"
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PIbG3E1389220
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 10:37:16 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PIbG3E1389220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740508637;
	bh=dkfdbSx4K5wIzJ3wkX3JyGWfmpSr/8cCPf1XHcNuo5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W7O2mrU0v/J4mjlkLE9h/pRehGeQGwkrNHhh8Xg0C/KUBC1PZwG3elflHCYF85BZ3
	 q/vqw9KmF1uK/BihEQhcilgIxsCL5sBjbW/vaxnRWKPmj8NxhHL+Bl8pd+oj7j9s4t
	 V4nq70V5VbDKpijYBta8QWyrtpG6vdrkJHRiSMaUEt+y9iu2AuBqwvLyjIoO9cJKR9
	 6lkTSL4icKOQUJDYmc4+S8xWpPcXQ9kq9JqxGuxlBBZDriAQVj9ucSOvk4Ooa9HNEJ
	 278ZXyhGQhZtNBtAmPekc3LeqKWPfZLy/mhZD8BNaBSx733fZ9rBdX1gbnbbs+3EYE
	 N54DH8ETgDCqg==
Message-ID: <e9c17975-dea8-4cf9-9b1b-f44fab203ae9@zytor.com>
Date: Tue, 25 Feb 2025 10:37:15 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] x86/cpufeatures: Automatically generate required
 and disabled feature masks
To: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, will@kernel.org,
        peterz@infradead.org, yury.norov@gmail.com, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local>
 <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com>
 <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local>
 <8973bfd4-d8b2-4dd7-ae1a-3f685dff769f@suse.com>
 <20250225180051.GCZ74FU-PrcosEHZb1@fat_crate.local>
 <A8B4322F-F298-406F-8F84-9151FD3CEA5F@zytor.com>
 <20250225181551.GDZ74I1we9xqM_oj-b@fat_crate.local>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250225181551.GDZ74I1we9xqM_oj-b@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/2025 10:15 AM, Borislav Petkov wrote:
> On Tue, Feb 25, 2025 at 10:10:03AM -0800, H. Peter Anvin wrote:
>> Yeah we had that debate back and forth. Although I personally feel that any
>> sensible build host would have or be able to have Perl, the consensus
>> opinion seems to be that if it can be done with POSIX standard tools or
>> host-side C it should be unless there is a very strong justification to the
>> contrary.
> 
> Right, Xin, please make sure you put this rationale in the commit message so
> that people can read it.

Oh, I'm thinking to stick to awk with rewriting the part that a standard
POSIX awk doesn't support...

