Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14308309EFA
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765567325; cv=none; b=mRF8Ymf66OxRwj29yRycGo9oSUgjo/1Qy6xj/+sz4AAmYQVlQcgxAL/lINRnc9BpKVqSLkzQFimakE2c8ASvUmNpFymG97pk8S7IcC+Ir99L8dCcyku1IFJw0E7f2eLA3vq3dyR6YpwNCxFZs7vmudYT0XRljvmISdUaBjDBwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765567325; c=relaxed/simple;
	bh=d3xY+Tt5F2lAixFNz0erCGqfYwIxB2/c8x9QCfBSFMk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=MEuA2w8QV1b/15kb/Z7yTJJr348BLLENSVosbHF7lX9k7LyG2xizyNR8j2iAHggUraZvXRFlXd1miRaijhLgRS7r+GZ5q5mmEcXkavuEzjHJ9cuHlA8wk/zubb+LafiNAH/dyEfcxkKILeXz07sF4Il+joL6JXV4R/5tJz4gz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmmYAWCd; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmmYAWCd"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-3ec7ae153faso1210393fac.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 11:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765567323; x=1766172123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d3xY+Tt5F2lAixFNz0erCGqfYwIxB2/c8x9QCfBSFMk=;
        b=JmmYAWCdFQD6/8IWEfycH1cp3NlAxj6pn4RMlvFzYLY+ifb+sgZpxAaXHaD36odD2J
         QahRxKnOdovz0UUzEezQO1nJZOUBXpaFUM+Ts1sL86RoOpnvjcUJJABUXB9l+F9un/ao
         TB/PoJw2zL0H9tZLNpLoUE/Q8fLic5Mu3FrWxGtpjZKa4sdwMHECCsXsb9ZT46lwJEuz
         5YxZLRcup96IBF5wt0UVghZs3zH5ewumbdC69rUCH6kynavZlvLbTN87bUr3859zYMZY
         yvmXz2ZV5uD9i1yDn08zAPuIG0X2s9JAD1OCOmfHNXEBtx2L6vYZx+eOVWJGZ7xF2kFv
         GjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765567323; x=1766172123;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3xY+Tt5F2lAixFNz0erCGqfYwIxB2/c8x9QCfBSFMk=;
        b=E4RiKCJLye2lhrKbIWNBXdvIGKs1K87WzgPmXKBTU4Kscyq+NRow8+lxUaiKjIaQcS
         7KYPsjnvRFBGsOeawkNKfwucqsIYNu/Wm9q2pMNtLmF4umhfb7yabL90NPOKyYD5n9Na
         OKADVvafubTvG9RszArBATrauaRxyRh+U0YurQJlDyVYqfwb0WGBeMiZn+8hucIh7xSJ
         Y95mvQ986OvyjpEl4U0hJjoVq/UUNxPOztMZAZlog5slIyvN5i3aZdn1/Vw3QUnU5o3J
         w9ahxx+ptRnTKYdg9sHqFrxKoTmpzv/C/xRfZ1W7CzvIlzOrn9UUof71Zw0Nk9lXBj47
         Glxw==
X-Forwarded-Encrypted: i=1; AJvYcCXWS/+z+i86q2HobWXfqGruWHVoitYHOwrp6onfF/RQW3ZCgpeWeJNyjOUrn3OHDXoATUtfFtUfdpK3wvj4Z7Lq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh0vtIWwviUqFSmA1x6+GHVUstQOv7mLZf0+3V/5Dj8kt0ZDmF
	a/KVKpcZazfkyVLrkKr3oPPpoBpNhLZYOpSqxAbRFNRqlk7RYbZOffoTiLWXDj/SKt5IqT/T48a
	m+OZuxbibWhoyCqBjMk46mpU7tw==
X-Google-Smtp-Source: AGHT+IHUbVv4Jy2gEZEkXkuyNos7MiNpoCrDqCxYPzir5lZi9qw+P8UnFJM3AYzANnUq+aZp9M70/ycADG43mzjJoA==
X-Received: from ilbeb21.prod.google.com ([2002:a05:6e02:4615:b0:438:317f:a956])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:290e:b0:659:9a49:90d4 with SMTP id 006d021491bc7-65b4523a33dmr1491761eaf.83.1765567323163;
 Fri, 12 Dec 2025 11:22:03 -0800 (PST)
Date: Fri, 12 Dec 2025 19:22:02 +0000
In-Reply-To: <d3e946ec-787a-424a-9a7a-f04aeb490ba6@arm.com> (message from
 Suzuki K Poulose on Wed, 10 Dec 2025 10:54:10 +0000)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt7bur4iat.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 01/24] arm64: cpufeature: Add cpucap for HPMN0
From: Colton Lewis <coltonlewis@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 09/12/2025 20:50, Colton Lewis wrote:
>> Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
>> counters reserved for the guest.

>> This required changing HPMN0 to an UnsignedEnum in tools/sysreg
>> because otherwise not all the appropriate macros are generated to add
>> it to arm64_cpu_capabilities_arm64_features.

>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Colton Lewis <coltonlewis@google.com>

> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks Suzuki!
