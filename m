Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635743;
	b=BBB8t/mti5sFNFfZTNySOEVGrUjvJ1VZdKweXRn5NQMLPiEX+31noninz1TREbdlLLDI
	 wVfhbVOJ7fL/F+SUOEPQsC+WVex4gOUYoHhAwX7kscFPo/eRO1ccoTg8VG2SieLEPbo82
	 yKs3UMSJ8yLCFNhvnKhUJZs8UyfUg2a9QMxAhpgJk+tfmrlOQm0GSbdt2S8Dgwv1LQkvx
	 H3SQ680vEvdd9xPRbL5L40Cet82t6+VhbjGB8AIS+Lr9vI7Pe/WL84Vg317MVX1PJQyhB
	 K67rUnjwPqn+o3PixSS4KxNL45DfiIXXkh/QDFsIGZ0qPobQuENLo7Ciqq9SuMGZe2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=XxjX1g1mQUEUPhKLrpLxYSgZ8S+x7GSgwLX7BwyjX7g=;
	b=S/bRzdJe688YrLEgRs8srM7cXN8i/5O9zrXzwaiTBi3GW5fhj8x0JwyJbhxkC7R+g1zk
	 urbk5M/vDZ8GE/l/JnD4pBXbzkLmhRlmFN5ghHcZkU6AfaG2o9Ac5vf7ejfz5EpPVWWyf
	 B7qGe1TrXg1bu0FlL14mG3QMuYSBh+y6IhiuEOnbQctuuRUFuzWCdue7hwxB56oYKtCQi
	 w0nt4UvcYZ8j0VhIRUBlWeiFhBAwg4OgnrHZiLwJPBawMaBNGLa35UBJRn25rQq5KuuTB
	 55a4h6av92OC4FTVd4+C5OXRwf5/fH1XSbXekaugMvbTEpr/2rL2JJZnhqRTf8PKdKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sS0MesHX;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C87606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3C87606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sS0MesHX
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso491139b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 19:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792635742; x=1793240542; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XxjX1g1mQUEUPhKLrpLxYSgZ8S+x7GSgwLX7BwyjX7g=;
        b=sS0MesHX2nvWA2URY0k8Cne+sfJOI5PDPY0/f9zuTS95LHs/n/U9E8Pa4fzDUDcan+
         Y9rcsec7bezD6Guv7ewLXhN25+qbv8/QYe+Nt37G/XwT4gtFsAw4dBx/scmdeSeprx8F
         yyYmOQOxj61oR9X1k4gckGNgfuwxjCdGgyxCQFj1M4GVJ4knVIsYp4O+Vpxpl2Ncu06y
         c78So+Vegffz8XffqmKkG/C++ukW6P3hjj0QtBPdRBMEZ3yxU/7oayY14RY5Y/KYxQ1q
         zYqw5lr40dCQEe9v04A1K2soetRjLIKPH5jCosRLRnOIYPu5etD6U75ESDrikvZjJQvJ
         nS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635742; x=1793240542;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxjX1g1mQUEUPhKLrpLxYSgZ8S+x7GSgwLX7BwyjX7g=;
        b=awuZGZEPK1F/gE8HDH/XIyY3QiVD+W+Z5Tgj9NelBq6n+2mD2iucKnuTc/5slsazk1
         sUTfhLAWumrC3yd38OlSCGJuuOrXdD1lRkPb0atrvNjjnQ8YRGEcM2BX/292gW45cyUs
         P5AMHyW0iWMEC2gf7AOls6aG1oMKKjGzo2GU0mKAz6LQcQXJemRO4Fc+gdt2lVd40bqD
         aaseJO7QBqrVxbsx8EOlVJUbK0yeosznxlF2y47qMi58ki52/Dg00C5DKyxJ6liQCV0X
         wZJ6gOWSYiQGpmSTPmJ7fY3VPaTp0VtR2HNG6PuxIkzI8vn2ViMkhuVwjsVOzFQowPoR
         jnZg==
X-Forwarded-Encrypted: i=1; AKwUvBwDgYdPMIcF5e/ekKZWFDQ64kw85FMKAeda87VGDLgUfV3CP+5IpIwLcBcBqIEyWzTML2+liJnZdWMdyCVFox2j@vger.kernel.org
X-Gm-Message-State: AFq9FYJb9MDCFY7No1aKZ2F+6r+qNWCLoYc/6sJGvueC+YgDPChSqzeF
	HQFE4YXRkAbemHj9i39f5q04WCacBh+RzmxuG5C3Z+gUA9KQH6oPaxA8
X-Gm-Gg: AYBFou3fJakHtikHqP1pX+PxsZoJy/M4i63DawFdeuxaHoUroNI/fFCSA+tRkWjF2xC
	Ysj6L5tSEXpQRW16dQyb9pvexbS47JFrsg/MAxoQLySw3KXX+2oTiylMX6pnH+r1jk1nqjJOnkR
	kTP46+D8QHlvjs7ddujx3aOoRastI3APlEccX8ivOImuyTuikKJRsIp+yny8X/0m/t+f4QYa7iB
	NRqrVyDEW38u37IweX/vwQHIs9OnF0yUdZrB6AJnLjzW7QT7zBra2uxJvJnD13P66+rc1ZIceXH
	3tbbTu69Rh/NObZPkkMfgRo0SHwsB3HgWJfWPeQeeaZoJBNx7eHngZ/f+tIL+48U0p2lQHC6lNM
	3crRn5c/TqbeF4FmwFcP93Nrc1RtziqQFgJ084xX82eY32eQ3a2/9AauSFaDccIKH3LIdND4EPI
	z5qwYFXkqkxxaf2806gLQ6RaMvVSICqQrKOT1aXgfNpTQP9ToQxJfJVDNaoxwm7i7LO9jEVOGxa
	k7beWJoDgKhoTLF/AeozPBbkHj6mZWB1Ybg+CVLEDGuUIrRM4OmKXJ1VtlnePGJ22T+MEpKaEev
	lnWeJEiYC369frG4JDW4mI1/RQDsh6YWvSaHPjc8VZzGREyzqAxd5f9DiVOa
X-Received: by 2002:a05:6a00:b49:b0:89f:37a0:b2cb with SMTP id d2e1a72fcca58-8a089eba62amr2905819b3a.49.1792635742236;
        Wed, 21 Oct 2026 19:22:22 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b4206sm1450303b3a.18.2026.10.21.19.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 19:22:21 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 02:22:20 +0000
Message-Id: <DMB0C24NTIST.YQZ2Y3E0I1I1@gmail.com>
Subject: Re: [PATCH bpf-next 9/9] selftests/bpf: Test uprobes and fork()
 with busy mmap_lock
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <oleg@redhat.com>, <peterz@infradead.org>,
 <mhiramat@kernel.org>, <jolsa@kernel.org>, <akpm@linux-foundation.org>,
 <liam@infradead.org>, <ljs@kernel.org>, <surenb@google.com>,
 <david@kernel.org>, <vbabka@kernel.org>, <jannh@google.com>,
 <hughd@google.com>, <kees@kernel.org>, <mingo@redhat.com>,
 <tglx@kernel.org>, <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>
In-Reply-To: <sashiko-outbox-180860@kernel.org>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-10-alexei.starovoitov@gmail.com> <sashiko-outbox-180860@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 07:10 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +#define AREA_MAX	(64UL << 30)
>
> [ ... ]
>
>> +	area = mmap(NULL, AREA_MAX, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
>> +	if (area == MAP_FAILED)
>> +		goto err;
>
> [Severity: Medium]
> In tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c, does AREA_MAX
> overflow on 32-bit architectures when passed to mmap() in hold_mmap_lock()?
>
> Should AREA_MAX be sized appropriately for 32-bit architectures as well?

No. uprobe_multi link is 64-bit only.
bpf_uprobe_multi_link_attach() returns -EOPNOTSUPP on 32-bit and
three of four subtests attach with it.
