Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B36F077
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835001; cv=none; b=Y7NA21PC/X6cwyrpRJbjuswqTONGT5leIzDfmQCWYVddiv0fLvza55HbN9+nIW2ugnccd6e3abuxH6u636TTEKQUSrG+zPXoAL4ZMtZxZXBvN9aizZ9tLvTwYPmMsp0U1k7lW6/Fe+4QGcwf6Z6ESBnZBHePPVuMJnRdHc/+w6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835001; c=relaxed/simple;
	bh=Jpl22aqYGSxIo+qDQFAsqVJLvtdunm/X7rOU7kbj6Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gmo7R7U6ZD5+AoLOJ+T9w4Cf/OUekEyw2gL29cdrqFEPBqn8+PXKwdT8Cg3WNY1p8cpvBiT5O8yj+v6Z1hIzr9ItrywWZawS5HtU1ADMZNEYEXBnEZwgcjE7KYFxs738hFx73t1JqZF/4dvVSSC7MhIUVD4Y7NnDQOTxUYW7BLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R6/TngPm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R6/TngPm"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4256aee6e4dso21631905e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Jul 2024 04:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719834997; x=1720439797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2+exavIfejK38TBkftpQIKDnT/YCEYLfkFpQAOqMrA=;
        b=R6/TngPmQnl30Ku6Rc1iyNvQZEc1Gz1WNCrAE3m13ju5+QnzybSYZIMbC4kBgnEfik
         SPCLcY88gTcntYaB4IgT1ctPlCcXrEBvx5KkCfiU0QyRSfI3aNtO8SqZxujcNfqpujrm
         U2vc+Yr/52g5+KQnr5D8FQZv/Ge3MBJfUpQN3iCR/fagjvRtQ9H7yt60f2v2viOM/IfM
         clwtOQfLc6kul40ttpG42S/ksUJWOrCRFz3q+Sr8IXrV0yG/3YNOYvFJqa6Iys319S2O
         eHR0/oC4OUEdY7ScXg4aJtQ+BYoS15O9TqmNU6+bREgaC5RjrLHOvZXO1z8jdNwxTb+y
         8zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834997; x=1720439797;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2+exavIfejK38TBkftpQIKDnT/YCEYLfkFpQAOqMrA=;
        b=eP++Wk5L9IGrn82mR3Kj3IFHVRW3Z1ZsRiuKpPx0NMeFXFlKdiknZJIsnFVHhiMm3+
         BC4vit62aM4n5YkPf4GV++3AJZMhGFclEUfWknglSbHYuaWo4iPQ6B/L4E7NpUgOjShL
         tCDamUn4xuvgPJX1ZxYZAtH6HZbXQBCjVhF+vdDDg9qMYI7G+aSMFWDQWbskoI14zuC8
         wAVD7znwUFCkSosTj1zF3cnq/fACXaTl34D/OhJgZ5Bbau4SrYoNdzCiy8N9Dx6OK75o
         jqPp+eMnOo1WTvT3PPzaVmipWFNDyTKcd7pH2AisASQIj33jpntylGaYvhwNgkNv13oH
         PK1g==
X-Forwarded-Encrypted: i=1; AJvYcCXuNoaf/md7CpCZBy5ss1vff2/IvL5CBcqCQAitKrb6gQxxDcebQc2pVlAqKFXgL7gYKmeP7VRcF2uDdBSRiB/Lh1Qyj3TkmZ48yEJSSHuVPw==
X-Gm-Message-State: AOJu0YzxDP0Yy8MJT1AoRMtKGSTRaTM011/4ToMM4N8pdVNuynKSzUCz
	TtqAE4uC8Bm2AUoTHUfyy49vSWmKzuuE/54pP7vWELZf9udEm8o1MEQNv7yn7eI=
X-Google-Smtp-Source: AGHT+IFpMs+kMYQhye2xH/ffra8GqlPW6v2h0K68WUFUlcoi1nV6+1EteASUbtPqnC+84XbNqh3VqA==
X-Received: by 2002:a5d:410f:0:b0:364:d5af:3460 with SMTP id ffacd0b85a97d-36775728ddemr3086296f8f.61.1719834996788;
        Mon, 01 Jul 2024 04:56:36 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb? ([2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb836sm9852925f8f.81.2024.07.01.04.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 04:56:36 -0700 (PDT)
Message-ID: <b6289862-48e4-41fc-a6e8-0e21c90dacd9@suse.com>
Date: Mon, 1 Jul 2024 14:56:34 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] x86/cpufeatures: Use AWK to generate
 {REQUIRED|DISABLED}_MASK_BIT_SET
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
References: <20240628174544.3118826-1-xin@zytor.com>
 <20240628174544.3118826-5-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240628174544.3118826-5-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.06.24 г. 20:45 ч., Xin Li (Intel) wrote:
> Generate macros {REQUIRED|DISABLED}_MASK_BIT_SET in the newly added AWK
> script that generates the required and disabled feature mask header.
> 
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Reviewed-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
