Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555486324;
	Wed,  5 Mar 2025 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159893; cv=none; b=EWxVMi5rPCu2i6/OzdYASNoM+hCqBF76DUSk7EQhkAcrdU+uEheEvd9HpfoZzJDewcZmzNBXCso7RZfULSunp6tjvL30sgKW0buNbOMrHaqI4q1tYBuJHEUQhwCMZYqhCAiaKoUQ7PReE4rHfZurJ1X51QzONlbFykt/TLWBP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159893; c=relaxed/simple;
	bh=95hQjzkQgPmB6GdlaDjrGS1l1Wn4Kbw4p82WGKXM0+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlmhFOzXDkqcKDYCzltj+IHv/tPLF21C/i2uZZINFCMuQVYuh0TY2h95d0WhgKY/xUg8+whzByfLdQemxVXa5dGJMRfa9Yk1t3TgixTcV5PiOxzAg0PmY+BDcqGpxLPJUdasSadAWC+eIXnDloFChtZrwKDQkBjLM+9Y7OumOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hnNoddCi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hnNoddCi"
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5257Uhoh3004301
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 4 Mar 2025 23:30:44 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5257Uhoh3004301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741159845;
	bh=liVnbeunrklLqTSuhTlsju+GyrmoYRAVBsQLrw1di6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hnNoddCijzVWKzG3yqXdiFrIxKCdqI7oL+LIKCz9EzVmRRTdRvt4wXkECr9quuvEs
	 ZhAIEsw4meAKUi0luhn6X8SGwu+ottMwRKwakZodxuAVmn8cp7MRxPDxXHBzPOmDOw
	 XGlLD7qD7M1342G+PNtZJqK3tX3VEbKD1u3/sxtbgF3oR4HMMNciwRiwFgGAfcbeln
	 UcX43u6k+F+B5/8D5ewKZlNzT6RjOIzT/Cro26X1hhwlAZ0ro7t0Fz8YpuGNe4QYw7
	 0I8J7wcDPk5tfhdNQQF+eNYn3dHn7Te+pda5URX9cBotHmxfNmLtivYFXWmCyMkHPB
	 lVcL9YKDFXh8Q==
Message-ID: <81677e85-ff7f-4986-8e0a-6bf54a63ba49@zytor.com>
Date: Tue, 4 Mar 2025 23:30:43 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] x86/cpufeatures: Generate a feature mask header
 based on build config
To: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Aithal, Srikanth" <sraithal@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, will@kernel.org, peterz@infradead.org,
        yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com,
        nik.borisov@suse.com
References: <20250228082338.73859-1-xin@zytor.com>
 <20250228082338.73859-4-xin@zytor.com>
 <7c3b4623-45ea-4340-ac47-334071c1d15f@amd.com>
 <D03DAFD2-5EC9-4D16-BA66-FDA4B51F45DD@zytor.com>
 <20250303132505.GEZ8WtsXqFpuMOpDjT@fat_crate.local>
 <8e4e1723-321a-4e8e-bbac-e2e5d8b08bfc@zytor.com>
 <20250304102910.GAZ8bV9hXqVb5tA9rs@fat_crate.local>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250304102910.GAZ8bV9hXqVb5tA9rs@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/2025 2:29 AM, Borislav Petkov wrote:
> On Tue, Mar 04, 2025 at 02:18:51AM -0800, Xin Li wrote:
>> It seems that 'archprepare' works, however I'm not sure if it's the best
>> choice.  Any suggestion?
> 
> Why do you even need featuremasks_hdr as a prereq?

I'm not sure I'm calling it a prereq; it needs to be generated after we
have a build config and before any kernel source file is built.

"perpare" is defined as a post config build target used before starting
building the kernel or the modules, and "archprepare" is used in arch
Makefiles.  E.g., on x86, "archprepare" is already used for ORC header
generation:

ifdef CONFIG_UNWINDER_ORC
orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
orc_hash_sh := $(srctree)/scripts/orc_hash.sh
targets += $(orc_hash_h)
quiet_cmd_orc_hash = GEN     $@
	cmd_orc_hash = mkdir -p $(dir $@); \
                      $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
$(orc_hash_h): $(srctree)/arch/x86/include/asm/orc_types.h 
$(orc_hash_sh) FORCE
	$(call if_changed,orc_hash)
archprepare: $(orc_hash_h)
endif

> 
> In any case, you'd have to redo your patches - we've zapped them from tip.

Sorry for the build noise.  Ofc they should be zapped.

BTW, I'm asking if this build check could be added to Intel-LKP.

> 
>> Want me to add it btw?
> 
> Yes pls.

Sure.

However it needs to change Makefile in the root directory, which is not
maintained in tip, so I will send a separate patch to KERNEL BUILD
maintainers and list.  Make sense?

Thanks!
     Xin
