Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EF202C45
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582129; cv=none; b=M4fH1bo0YjuDqBeX+yzhxhyDu76RMNnqh5F8dRcP+wWTNCLHc6CfhY3vlIZw8we0sXkE9yk1Qeo4Z32yfgsC8Mp+0ks2oZVqcFghkXl+ltckUjJ0r4zY14kMX+hrLL8+AxmIdNYQEJvZTJmM0M/an0WcOoesoZdptxcEap1niZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582129; c=relaxed/simple;
	bh=/K5N3VJS4zbstl2ynRET37Jk72zu8/TikndeVhgoKOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwFa9psFlwO2SnitG9QedMJ4YcoM6Dt8CsdAwPwNQQq9TkKUj2QeV0qBPWu/2bUqiW2pF1iM3McyI4fc/g1NpDOSkdwry8z4K/MQUZZOiQr29KYJi5nJGwFDI3GMutGxl2SQu639+DN4MlkzLvLIX7uoExg2cApcHn1+SrG77LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+wz0x9K; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+wz0x9K"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso25871155e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 03:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738582126; x=1739186926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03gUTOPYMxUMcZhmVIjGAOR45IAzZBtmIXb7cPKWi+Y=;
        b=u+wz0x9KvcUUUBwqnXMdO7FesLQyf/niFr/EiDUhTYKudUod7KiWSsIkfms7rD+w2B
         YxRdUVp6Z1E1jq6WGbLO+BCV3+qz31Hai1ILRjF4sdqaLMVGhFWk/g8Jo8yxR05CC/SP
         lUusisefWIa9flIx/Blhlg95MY7jtRj7b4m5RNnzM2TMBohpMO6Gavk9N3C+EPBU7ZIW
         h8l9shy4PlFUsSX4KRtbhKkUXf5BwRhEcI+ckSuPjhir4CGUJxowiZrvLhyMqnLiexqA
         s2ku1CGiuaXCoF+uuww0VOEK/2ZNGHMuazxBTqBiaukFjwYFBAq2T/l7fyOgi3sopKk2
         rT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738582126; x=1739186926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03gUTOPYMxUMcZhmVIjGAOR45IAzZBtmIXb7cPKWi+Y=;
        b=PAmdC+h0xCe09PL/jclzQtjiVBgMfJVsV3kubGm5sIZBk/uTVLsfJsxCbmXlo4iJxS
         YVMPPSRKaN0bZOerok84+iwnsEgQ+N8XQq1CZc7o4085iNjvti8MYKW5Z7MgMgPkdTvU
         0EJucC98gskgzEYMGEieeNZ9d0n7qyQhnxjnjsnHLp+4cA19KvNB2vKv8FBtyEa58mkM
         e3WNYEWEOW27gbHqdiK3uspT5amx+9xTwZz/PbGuLBqA20aVQWrqR0nOFh9qw5TOzhNG
         2hZLD6FbtCi7YvKFF1n0wnJbEvWQ+W8PRnnSclNq4gJJ4/BHkHUB0B3oNjSwJFZXjuvG
         MZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+E0qcmKujqjGAxOm9q/nYyOfDqqpimEc194pTvAHHmWQ2q9ySWMZqDBXb+AAR2p6uMIlZ7e1dQ7Up2t8sh5ck@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHgmYPnhQsnXXbniiTxkqUhLaAPXepT6UR0V8dpQxQjJfmo/1
	y8SQadxEEuW/+pIcMSd+5h99iVRsikLMklqTHRQ25zx3OkxCAtHg0BZ6SI9Xc94=
X-Gm-Gg: ASbGnctBd90V9ewTmyZg2CZB5nhKDb43mtkFtNvwe5Jy4Uui36YyoV/bsNJXnV5aaDV
	/C65v8q+XU8iGkyoecBJ9+Zqu+xgKwvsf50yiKRglOatW4Xqi5RsabXRbX/poV8cY89duhd1II/
	Pax/LyOZHX+2mjo/DTbOD0ZTBXZkoE6N+eoxjaFQ00AaBQ+0kAqHspj6zcXSya9+8HKrF1WhzlP
	aIY62yjJ7iJxIAEPD1aEuDOQlirYR86K7hXNRZ3K0XpTqTJfzBCWnrBnrCQDY+Z4YSEzIifu10R
	wU3bB/irZpTpmt3etODXSQLRDg==
X-Google-Smtp-Source: AGHT+IGzdk+Sqe63Mv9Bm/BPmdRTVGijSJCqG2+aE5exrBjEFpqR+uegx/hrDwI77yjfzrbFRZf6LQ==
X-Received: by 2002:a05:600c:1e08:b0:438:e521:1a4d with SMTP id 5b1f17b1804b1-438e52122eamr113014465e9.5.1738582126037;
        Mon, 03 Feb 2025 03:28:46 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc81911sm185351695e9.38.2025.02.03.03.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 03:28:45 -0800 (PST)
Message-ID: <4aaaa1de-ec5d-433b-96c2-3b28a8cffe7e@linaro.org>
Date: Mon, 3 Feb 2025 11:28:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 10/11] KVM: arm64: nvhe: Disable branch generation in
 nVHE guests
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
References: <20250202-arm-brbe-v19-v19-0-1c1300802385@kernel.org>
 <20250202-arm-brbe-v19-v19-10-1c1300802385@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250202-arm-brbe-v19-v19-10-1c1300802385@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/02/2025 12:43 am, Rob Herring (Arm) wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> While BRBE can record branches within guests, the host recording
> branches in guests is not supported by perf. Therefore, BRBE needs to be
> disabled on guest entry and restored on exit.

I don't think this is strictly true. You only need a Perf session in the 
guest to records sideband events. That allows you to make sense of the 
userspace addresses, but by then you might as well record BRBE in the 
guest in the first place. See [1] for an example.

With kernel addresses it might be even easier as all you need is 
--guestvmlinux, --guestkallsyms etc and no sideband events.

[1]: 
https://lore.kernel.org/all/20220711093218.10967-25-adrian.hunter@intel.com/

> 
> For nVHE, this requires explicit handling for guests. Before
> entering a guest, save the BRBE state and disable the it. When
> returning to the host, restore the state.
> 
> For VHE, it is not necessary. We initialize
> BRBCR_EL1.{E1BRE,E0BRE}=={0,0} at boot time, and HCR_EL2.TGE==1 while
> running in the host. We configure BRBCR_EL2.{E2BRE,E0HBRE} to enable
> branch recording in the host. When entering the guest, we set
> HCR_EL2.TGE==0 which means BRBCR_EL1 is used instead of BRBCR_EL2.
> Consequently for VHE, BRBE recording is disabled at EL1 and EL0 when
> running a guest.
> 
> Should recording in guests (by the host) ever be desired, the perf ABI
> will need to be extended to distinguish guest addresses (struct
> perf_branch_entry.priv) for starters. 

There's already this which would be enough (if every entry in the branch 
buffer matches it):

   sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL
   sample->cpumode == PERF_RECORD_MISC_GUEST_USER

But I don't think we need all the extra complexity. Just let the guest 
use all of BRBE and then there isn't really a use case that's not 
supported. I assume a lot of these workflows were added for trace 
because it's not supported in guests, but I don't think that applies to 
BRBE so we can skip them and go straight to full BRBE in guest support. 
As a later change obviously, these comments are more about the commit 
message.

James

