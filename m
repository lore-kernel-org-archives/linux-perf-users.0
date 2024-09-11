Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419D145B2C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092102; cv=none; b=IwWOpPmzC5zqAMDGPXRoDlMfefO6JzDFeH/NRXyNFt5bfccL1W49fIFvwqTxrAPG+pgBrEhohoayRWCV4D/Bbq4g7QQKoXqpahLt/YhsqgjjSUEJZc1yLM9r+vAHThg1++DOYqWZiec/+YuDcZiNchg9Oi/evtdGZZHjWZhrlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092102; c=relaxed/simple;
	bh=Agciipw5hWkC4EpzVmCjBUgtbk1AQ5kWWqM/SSA0exk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=J7s2jnWH+nwH1K4Zb/GszXfanqjODVo+zTY/zBBO7drhmnGfrsvZvHhfHpF3o7w/8TedtRCSYHCxvreDGR9mZxFdnntGAmlTYa+H19XWHlQp2rgk/hnLIU2qqQ2TEeIYkFWhgqvxQmfkl8JI7d4afWpmPnJ8nTibKKCMeuBbWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tE2eLl+H; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tE2eLl+H"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d7124938d1so14257647b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726092100; x=1726696900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q13JQ4aJstpTY70GjrenWYuGyd1pnSkxKkLl8Jd4LLI=;
        b=tE2eLl+HXo3H6oZbJnL998LFc8kJQ8Iyhs6fxaXP7Wy4z+bq87DM7WD21u/O3arYql
         yGM1u+QACFLyRzgEZ3UvSCe650KX7q1PEh4JwSkUWwiaAWt72e6hZgfbSJvyNwp40QST
         dp9wXVmyUmd7SdJviNN0orJKif009zsbl1ka2OzDyGXU7ZaL2dgvV8MFg2Y2p5mC2kLo
         1WZIDYHGPD2gMxfzUNy1+jmnnoKPS0olJx9KBDqONpNxqELCabNXseHlH/tA3ALywS8y
         tqydpkhwSkWgSpsH3SwZZPZ4hPr6FI/D0LghwRnBRPBmf5IrGYyOH55LkfHGxwMq+nX+
         zWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726092100; x=1726696900;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q13JQ4aJstpTY70GjrenWYuGyd1pnSkxKkLl8Jd4LLI=;
        b=R3IZxql46RbK5c4NbII6eqsua8CuWRxLsauvxs8ysLHoLcMD4tAJlEJUeKtT8Eek+/
         s7q1cE1mqoOxV0C6hxhWXA9povLI2M3Pohv1dk+AEfP/ZrQkMRDXic2R0y/46uoPRM1Q
         taI9Tu1LJkvioLNZeAYgkWN4grIRaUs/nO3kUcXUKjtacPPjLMp2EZ1m2cw5potNGguI
         jsi0k1us0ijoriUA7vaIpBZlG1eIEmBD4nIZFL/3mTXBN3o2v6Bt9UkAt4S+2mGgSDAD
         SBcCs6UR/zf5DhSBN3I2pF3BZ8/+in6S3qT9hJqZOccbo7bomYhnBFpHx1n+PwlZrMu3
         jzig==
X-Forwarded-Encrypted: i=1; AJvYcCVT6QetG4zqrlRquaWWLEuDGcyGkRRzepfyo5m+DO50aeR4ti8kz+aZgkxAXPd6swgxN3LCIIJ6zodJ21m+YIN5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hL1Zr+7aI11b7/Er7Q6M8+JeiPAIhJPh73658C+EzG/rkrRM
	iq760yw881dW0PC2QkN6k/QSboOyDVeG+zpjiwQGmjxe/VwTDob6Nt+pKdZTyz4+/josCVSxoO2
	wxt1gS2+flFXHetGLT+HgQA==
X-Google-Smtp-Source: AGHT+IEh6F4b46/1LwAS/WUGX/NAwM3UP2BxZSsRe7RROOaYU54OCz40zI1kT+hftf0HBDiAU78eGBwhCC/X5Gc0CA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:1743:b0:e03:3cfa:1aa7 with
 SMTP id 3f1490d57ef6-e1d9db9e1b8mr1014276.1.1726092099527; Wed, 11 Sep 2024
 15:01:39 -0700 (PDT)
Date: Wed, 11 Sep 2024 22:01:38 +0000
In-Reply-To: <Ztl-AjEEbIbX4lnm@gmail.com> (message from Ingo Molnar on Thu, 5
 Sep 2024 11:46:42 +0200)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntr09pdf3x.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 2/5] perf: Hoist perf_instruction_pointer() and perf_misc_flags()
From: Colton Lewis <coltonlewis@google.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: kvm@vger.kernel.org, oliver.upton@linux.dev, seanjc@google.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	will@kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	naveen@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Ingo Molnar <mingo@kernel.org> writes:

> * Colton Lewis <coltonlewis@google.com> wrote:

>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -6915,6 +6915,16 @@ void perf_unregister_guest_info_callbacks(struct  
>> perf_guest_info_callbacks *cbs)
>>   EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
>>   #endif

>> +unsigned long perf_misc_flags(unsigned long pt_regs *regs)
>> +{
>> +	return perf_arch_misc_flags(regs);
>> +}
>> +
>> +unsigned long perf_instruction_pointer(unsigned long pt_regs *regs)
>> +{
>> +	return perf_arch_instruction_pointer(regs);
>> +}

> What's an 'unsigned long pt_regs' ??

That is fixed in a later commit. I will correct this one also.

> Thanks,

> 	Ingo
