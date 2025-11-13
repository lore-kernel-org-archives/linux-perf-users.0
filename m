Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056E26E708;
	Thu, 13 Nov 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061041; cv=none; b=QdQYBq1mGbFyj9S+HD6eh0jC96QDs3gawQpMhlVCxrTXzDAcPUDAVFGWmJWo10qzMBVAdJGAF0xnWejZwKMujdb+Zv2TqOOdYeqMR6HxBQpSZisx+bI2JjTHNbm2YoreV7jGa3uWV/66l0r0nJYYldkZY3pL+5/Ldlgoqk3NQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061041; c=relaxed/simple;
	bh=44TFkluQ8NjYkM/UonfvdyIjixH2154CCmS8Jt4lT68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ihb6OrtLAvR1Xjap2RXIbNjtVuBp8tGZQvdidlWGv61ocFC7nXq/EjRUaSkOYrw4WYera7p4CnrK2feLqRjrV5uCHIR4Mmkmk/m2TRdaIWXJMJsOPSYN2FBkOnW4mafZphDDzGH5kkN/RdNj5TKIGUBSs0f/tGGhp2gOYV8c9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3toaTeL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3toaTeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2347CC4CEF1;
	Thu, 13 Nov 2025 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763061040;
	bh=44TFkluQ8NjYkM/UonfvdyIjixH2154CCmS8Jt4lT68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R3toaTeLMEp1d+NiFs6A+mAY1QvXx6w8f3DWOLVS/1Maj4RyEyaI5L5hN7YTyPF1r
	 h9/gJnDm459DS/Gtg/XeJaLhWgMeRLqXpKO4Am6wfK3HgR4bQiPeky/lIH+Etx/T2g
	 /AflA7CydDfqNxJv1TsKtJV4AQE/KWXmEUEeXlgPv4q4qa+5pxYXsBGRu8S9RnKhNU
	 A2RqgauhajKhHy6HUToubqfxEOYUdPdK8CwTC2hVKKG5+XtBC5WvBmwudvJyoIL0VM
	 sRQi9XZ8z9NLL1aDBRjzrOW3qboZSkFNBjF/E8SmOAg9BjFBoU8h51AoHQNur3kYlo
	 aYtC+RKaddxSQ==
Message-ID: <0898b3ab-ae9a-49c8-a026-b9dac50e38c9@kernel.org>
Date: Thu, 13 Nov 2025 20:10:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/22] perf/events: replace READ_ONCE() with standard
 page table accessors
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Cc: devicetree@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Conor Dooley <conor@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
 <20251113014656.2605447-5-samuel.holland@sifive.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251113014656.2605447-5-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.25 02:45, Samuel Holland wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
> anyways default into READ_ONCE() in cases where platform does not override.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Link: https://lore.kernel.org/r/20251006042622.1743675-1-anshuman.khandual@arm.com/
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
