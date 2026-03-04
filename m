Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2C34FF4F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595310; cv=none; b=XNHYBO4r/5GYoZX36qAOwX8bYRBuP2LqGfNXW2WGM5nqQ2HjLKLlFQ/l3KVt/wGoCg1EtVAqhUC7Rw/EiIMn+spk7GZr5X1jEYbJ/kT6VPo2e0RvmU6UNPQotsDXtM5nRsobslk+DdX2zC5GDWrkH8KZlulflF0+iKtn1Gz7jmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595310; c=relaxed/simple;
	bh=XLiJ2nD8DJIVsSYbftRzQJ/qqbqmFgul82tptWrTWOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLYgtUtzgQw/Cy6q3zLT5Q8xAcePEW+vJ0VwrnJwlqgD+zdGma6Ov6s+6otTpNvAuE9U6XbzTsiCSKSLnsmVPw+sb4OstljY9QZgnxjLWPuOK6SbbO5j86SyRVHfyYR95v0KX23Y3vqaBlyvPNRkGSI7sn2EI4pCbbe9PyhJ79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=V/RVqeIg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V/RVqeIg"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c383f2fcso4377065a34.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 19:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772595307; x=1773200107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
        b=V/RVqeIgbll4o4ue74s/NYWOyn6ZZujuTFopUtqhjail3GEAE5/viHb45qoLBheA0C
         FjThpB0c+lktkioT8cLcDCupPIwr6ZtFjugZdaWmjPYCZvExg28dp2j5GNZKC+dwFIRT
         nMYTLvuq7I98ei43l1fO8SZa0kkKx926Q5k3OSaMudvEhiEEeEmS0+UTFtTKWPCx5BtH
         jppJ7leZ920nl2rr1NSxO3EsCbm7kJQgCQktDg8tjxpMgjzbh601eaHfku+ZFLcNfn/I
         i2IKtcx8h6KQ7DdzF6qyt1xEaUJ+G7gmzB4DX6DIGKuctT6KVr0ZXVqee2uy5eeWmU1x
         Tdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595307; x=1773200107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
        b=bIzck08qA3R3clU9LtGam8bOXifRwz7RIrXJFVn3Inw5N/I1+nkoTm4C2cvQGjro7U
         Kv7dSshLyUHFdF2Po4YmR2eWN4PuuzRJR3LHebK/FF1AyVKqgPAVsfiDldhI9ysS5aIy
         4A8lTnszuEydH/VGxAL0dY5DmrT4aQ0n2PDQ8ekjuHKcoWhtShArXGbJAURmg1gE8sTE
         Lfuvi4L2eV19QLoERkCPCV82GamL+XMhI54jiHLIVfu6dYQjDf2PyaY4yE2m81dbINSJ
         uxKJH5AYXikInTi5KsyDInLoFulYt1M4OZBiOdMal19Vj5lKxgDa7/IvH3aHFkiqmD7e
         LMjg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Ks+ys6tOPp4/Pr2BsQc4FK9Xe6KQQH1WRGLbcPo4Mc8P0NXcP4v/1i85vSTZxe+3CNqFdsNMUGOBexs8NvnF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9oM2apFBFRJl2ZHlBKFP80q0utk8m1Xc8Lghf54LWFwL80KE2
	Anxg3iWD6eWx0uzpXMCjACtKSmalViVGCeY6Lfz5eZjK75rETXurELpog6DaLdDD9Nc=
X-Gm-Gg: ATEYQzw4kNcejgRaGbPUkPiDCMj2usRHuTWaJHH0puCRhNuwOqorN/zjubjEF8IQN6n
	Htl3/Gv4TDCcwyiMKVyGXC+dwmbKxFucj6Av+dESa+4udF7E5kBKIGBMoKT2ohftfhJ5i3q9BfG
	viFFFiPqpL23Pk9NM2DYV3lLvEd3vmpCZbh701zmxawD7GtIkvuHeeuN0897VgEbhY2RIbm/v+j
	ex3RhB6dBaLrvyxebhhW8it5A7RlTV2aDay02Xyyv4rzW996IQiqa3FfKq8pdb50EUS1z8fVXyn
	ONSRD404jc6reFBb2yQf+O5jHWp+IzeUbamuzRm9iUgBOuXlSnZA4rU8RAKHw70elOq/vLN3bxa
	Peqxv/uLlDYjE/i14+V8E2XKLr9peHrkFNZ/sRc5B1DmMgWkT3Zon8xZac6hrSUCIgr8VsRTQBK
	DCj+5LfFSSoxu+4Zc/MKGhdYkKlbNDz9cXPYCvXlk6i0DIP8r6gN4u7Cp3FxlJOcWHQQguQIrza
	85vB3J7Ow==
X-Received: by 2002:a05:6830:6185:b0:7c7:6977:17cb with SMTP id 46e09a7af769-7d6d139f788mr450044a34.21.1772595307034;
        Tue, 03 Mar 2026 19:35:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586653f6asm15202012a34.19.2026.03.03.19.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 19:35:06 -0800 (PST)
Message-ID: <e96e851a-9050-4d8c-b1e5-bc3b5d91a84c@kernel.dk>
Date: Tue, 3 Mar 2026 20:35:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
To: Yury Norov <ynorov@nvidia.com>, Sean Christopherson <seanjc@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck <alexanderduyck@fb.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Carlos Maiolino <cem@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Yu <chao@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Latchesar Ionkov <lucho@ionkov.net>, Linus Walleij <linusw@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>,
 Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zheng Gu <cengku@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 dm-devel@lists.linux.dev, netdev@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev,
 virtualization@lists.linux.dev, linux-sound@vger.kernel.org
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260303182845.250bb2de@kernel.org>
 <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
 <aaedwFwXh9QXS3Ju@google.com> <aaen2pGs0UeiJqz1@yury>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aaen2pGs0UeiJqz1@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 8:32 PM, Yury Norov wrote:
> My motivation is that it helps to simplify constructions like this:
> 
> -               loff_t cmp_len = min(PAGE_SIZE - offset_in_page(srcoff),
> -                                    PAGE_SIZE - offset_in_page(dstoff));
> +               loff_t cmp_len = min(rest_of_page(srcoff), rest_of_page(dstoff));
> 
> Or this:
> 
> -               if (folio_test_highmem(dst_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(dst_off))
> -                       chunk = PAGE_SIZE - offset_in_page(dst_off);
> -               if (folio_test_highmem(src_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(src_off))
> -                       chunk = PAGE_SIZE - offset_in_page(src_off);
> +               if (folio_test_highmem(dst_folio) && chunk > rest_of_page(dst_off))
> +                       chunk = rest_of_page(dst_off);
> +               if (folio_test_highmem(src_folio) && chunk > rest_of_page(src_off))
> +                       chunk = rest_of_page(src_off);
> 
> To a point where I don't have to use my brains to decode them. I agree
> it's an easy math. It's just too bulky to my (and 9p guys too) taste.

The thing is, now I have to go lookup what on earth rest_of_page() does,
whereas PAGE_SIZE - offset_in_page(page) is immediately obvious. It's a
classic case of "oh let's add this helper to simplify things" which
really just makes it worse, because now you have to jump to the
definition of rest_of_page().

IOW, just no.

-- 
Jens Axboe
