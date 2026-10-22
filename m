Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637852;
	b=HWuI1jvtty2OvzNZjk2aJQN88qNUS/RD48owv4avsWpe8cYHvD//G8c4IoTLk01iB3Lj
	 IS8/ulvC99d3+MS71u4HFBNVPitHbaiOhqjV/+tg4SsldzZfVZ+JnOoJNe3mYWNEuvRJO
	 NVqLG1geUTEvL4H+lc0Zxt4CB3vWgfXdJ19ntjnsrZ8SkEVfIgfD0+8K6yr5R/5V1w4Bb
	 cIVtnoXUsCi4FmRLJS5nce6deT3xDbv5UYkW611e7LoAGNlpXD/OdMLuj8oh3Dr1yumaL
	 IDxbuiNjAqpfYQIfRja6KPNUIY+uD//JasbmFTIVCGNAqV4ZTLLbCl0TBnERikjM90A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=jbCDllRU5wYbKPFOhnGrl1xB/avA24qTnso9VdtaQCs=;
	b=pUnB9SognJEViBFIXVIAMjvo+A6cU2aYVoNv19Y9A3dicRrR1NU+NZYlMODSdsnCpC0Y
	 Lz4r4iUWbiDOgJGoG6sR57QHjR+m0bWyCzBNVq9NS/OPjpLY4Evvu6xnlASfjQ92z1IAq
	 sNKjkfl8oMa/iWzzlkguRb04y5+crfhn8nPEqvdMXRiQX7thmYhr4O9D7dgSDBitO+ysA
	 4eFyvfEcP0B75sUFAf1u2lL+YvL5pqQMepgQypqMlT9IDET64x5393R+VbTojnIwv3gKz
	 DiO1SUcB08KPOF+vvqbEI9u2c97+wNWbLNiNF5fXFuT1nIZfhEphxW9EOJTPWLA9hPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="koa/V6Uj";
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31C606A31D
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A31C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=koa/V6Uj
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e4c00d71aso153181685a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 19:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792637850; x=1793242650; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jbCDllRU5wYbKPFOhnGrl1xB/avA24qTnso9VdtaQCs=;
        b=koa/V6UjBswa4FuSyaK1aj7mCWWDpckd3P8cm34TWWyRP4wzh2NLGZFSH6Q4M4DXu3
         qzvnXX9HeaVR6rcKzXOZbL4uzEnVmqZL+MMzzyWUGBG2X6ItbpmKYvjiIE7ZPOD6pDdX
         PykgPTns0Qtfo8nduMQ1sHSyApXHEviCMbeUO00ZvHROPMI86Ykmx6SQl+abfVMyiKWf
         CvkbnJxDfiv3XJxFjZ82pcIdZyeNVZqTP/ETC6T9H+76M973HmqPv2qbgfT+YBQjViJJ
         TAOrklU+ENqV10WidZ/pbmFlwYkvtftj2K/YJxpRPZem9Bu3acDn5HeG7eCd8A/aUPfS
         BT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637850; x=1793242650;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbCDllRU5wYbKPFOhnGrl1xB/avA24qTnso9VdtaQCs=;
        b=CHwvKjrBPaXcFsrwFogQFKg5Dj9Pk7Mk8bDym9t+9lPrVntw22QVPUZbow4GZxNDGi
         Zqm3z9cAPL/qTeXWmGs/WHgCjnnxEmLaXxpwylDsPxHrU+U8IJpLzqh8wHC+oY+O/WNh
         uzGBPfxhr86rO5ifYGZ7D0aIKoPh/7Q4mmR0OIJoBD0VFIBLJIk+gQ4fVeOCOY1qkZ97
         mqSZu2lnX9HTSbC2w9XTZ9UC0uBSRjTJOqGX48vxr4MIQLZAbd5b/pv/L6ghdf1c+Umj
         ICQ3itD5Qo403QL4PH2Bt38+amRIyALC1FmoQX8PEzl6AH6x45m7TnqO1mt4nG6G/+Hn
         p9NA==
X-Forwarded-Encrypted: i=1; AKwUvBw4BNVfRkIC4t2H2BXY2N7YEcN99w5sEugUQzJBrhhR3kLuJrp1+frGB4tYvtiMgFS/gjAFLrCueKoHE8MvCiZ0@vger.kernel.org
X-Gm-Message-State: AFq9FYLR+ir5XiI7P+zeZvOpTTdyaMCzpR9QYdrXeEK2TVEHbMXz3H+q
	8pZk1GFTn44A92P0hiRpNyvye8r6UhWzx45B8vf5VEwqnEpbiF634dNbeepw4gsyzYU=
X-Gm-Gg: AYBFou3V+TOMHRIv4SOFZaIq4UGxT+DwDWIhGnfa1nLlB/mbGs+6r0DiG+kTG1l0PYY
	f/QWCx2k65qW/KqcenMXa3wME/h6JStCieHyYu3CTsrJdSb6BvVkugmbl0cm3dTPzkxwJ5VTSE3
	b5vALthQpw9dyyCQVKmSNH//dHjQhDJ43jKuyjxuX5RXPJW48mZlXEOFeYvoGXkSvy6v3xl+v24
	t5gPVivU4P0A3/ySBiDePvD2Jpit3T1NX5/Wc8fu5+AGiyx655fZQOMd8ylAz4qOK0XwTEJ1vHB
	tWcvESaCT9j3/Dks4Oo+Y3rlVDsz5RVep5BvlLZXi2NbGkLlwUEl95xcu/9DXkRw3OgUPwdccLh
	xDkpTWMZTIBsovfExtiANiaIaDGaz09EvjW3gGib1sJBwyDjX/OLmAy1/itmkR2jEkc3i/Mhdlx
	s2VSLEJP6/hbajej99CsrZ17C4FEUAHpa+nUEsJKfo1n0iultk09zHelMQbwGVMK5N/SSuj7fIE
	VvjSWybVdd3gZbVhSiED0XyL5104eKw/LMFirUhAXOQ8BG2mGIHy8EsNN24XlgXylfjEDzg1tbX
	uHXxlAvYSAGS8dQw3455fERdMRY=
X-Received: by 2002:a05:620a:2415:10b0:93f:5cc0:5978 with SMTP id af79cd13be357-93f5cc05b2cmr353949485a.37.1792637850409;
        Wed, 21 Oct 2026 19:57:30 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e30610sm406637385a.43.2026.10.21.19.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:57:28 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next 3/9] uprobes/x86: Finish an unoptimization
 which failed half-way
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
 eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
 mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, 
 liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, 
 vbabka@kernel.org, jannh@google.com, hughd@google.com, kees@kernel.org, 
 mingo@redhat.com, tglx@kernel.org, x86@kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
Date: Wed, 21 Oct 2026 22:57:26 -0400
Message-Id: <179263784614.2549665.557126403507804820.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 01:57 +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> int3_update_unoptimize() restores optimized nop10 in three writes:
> 
>   48 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%rsp; call tramp
>   cc 8d 64 24 80 e8 d0 d1 d2 d3    1. trap new entries
>   cc 2e 0f 1f 84 e8 d0 d1 d2 d3    2. restore bytes 1..4
>   66 2e 0f 1f 84 e8 d0 d1 d2 d3    3. restore byte 0
> 
> uprobe_write() can fail with -ENOMEM, or with -EINTR when the task is being
> killed. When the 2nd write fails the result of the 1st one stays. Byte 0 is
> a breakpoint and it works. But the next set_orig_insn() doesn't find lea in
> byte 0, takes it for a plain breakpoint and restores one byte:
> 
>   66 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%sp; call tramp
> 
> Nothing recognizes these bytes anymore. The process keeps the call into
> uprobe trampoline, which can be unmapped already.
> 
> Teach is_optimized() to recognize the half-way state, and let the 1st write
> of int3_update_unoptimize() skip what is already done.
> 
> The failure wasn't reproduced, but the state can be made by hand. Attach to
> nop10, call it to get it optimized, write 0xcc over byte 0, detach.
> 
> "uprobes: Don't sleep on mmap_lock under dup_mmap_sem" needs this. There
> fork() removes the breakpoint from its mm. When fork() is killed in
> the middle register_for_each_vma() removes it for the second time.
> 
> Fixes: 554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop10")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This was a nice read.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
