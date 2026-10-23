Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739599;
	b=NXbLGaXEN10W3lM/Oatb7iEfd4ADffItr6H7J0ZWsSoGiUJVWzN+gpPC/yGa4UtwSSCt
	 ORX2eAhU3yI3Zjx0Ri1MrOCFmBErC3AM/WdzpeDzX9SiApBNA3l5ORZkqoemBCa+4fUkZ
	 oc1o5jWpLUPwaDRlRzuqFWdaumoyArT0IVHUebfyKiWWxtgBLE7t6TKnOSdVKjdx2X/Z0
	 RfcwdUl03kWToZs4GL9fatcg6oh30e+OcPeYdysmdX7fnks+iidkUze0MP8aMKWOVSke6
	 8OISzuWCmq+djO8N/NxUBRK2/IKAIvuIhE2sHKJEsBJR6+Y1/RudqviHauTe3Qb7RsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XNgOedYkG+DZgIJoTAqem0cgXoeI7a/tKZ3psjHCVOM=;
	b=AdjAes37aLNMrsx48LCUGSqAg9/DVZJ7rYHgbfG0moHGPc1+Ym6LSQ7IfMHZEX15hBGu
	 NNBHpg/jqKHx5aOiq2UUrp0TO+Pk4+5U+ZyyIDp19vZ2bBmm/QjF21RIuw5Uz/4/VHY/h
	 lGHljko9ko7eXF4s4gLOYrJUVKWeFb8y6lZmyEEMbSwmuU+pRJ4j5JbhlAVb9FtatMFpg
	 5Vdwiu6974CHBdo+h0UsuIuRdNm5OZ1iU7N2pF+b69mwDGDAQbZy277dGIo+tF/u57AZs
	 /W57P/RclZsGaMqG3tYB0wED21k8M6AzkFpjd7zTETbo4eF0PdLxeZcejx868QXVDJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PgIl7hnN;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA64606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA64606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PgIl7hnN
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49d05d51553so3504455e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792739597; x=1793344397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XNgOedYkG+DZgIJoTAqem0cgXoeI7a/tKZ3psjHCVOM=;
        b=PgIl7hnNL2QdgYF8XRVPQYVuzZqRwz4qq5TwpsYKDRimBKA3LUYzBwLW/MzRYyLL+S
         s9859MsRRxRDpqxkJC6USW1Pl0y0uyUpOsi1iyEBgSNnVPt/AvNMDUSSjbM8ccW3psqY
         vfwV881aWZeC/xCoVJKiqXN+gzppdvWMuuutgf2al4Z4YGw0MQY8q0YaaZmiXIicPU05
         OEQ4yuF7oQSrxoT2uIkU9lUdY7FIHqHFUskdwzGcT4be7Zy13eH/kG2e0fRu36LIb/Tv
         TGERRy8ygGjhkALaEgJseD1JgBs8QoK4paB5TE1iNALXnxC7pPKEMEn4GHHqowJuKO2n
         kx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792739597; x=1793344397;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNgOedYkG+DZgIJoTAqem0cgXoeI7a/tKZ3psjHCVOM=;
        b=fIiWqIf9ZcvpEDblAHYCw91o1AC7bXHStzEP7FFa6I8F0+pHSzrI1IHKeR89Iq+Gb2
         91mJQs5L1p2wxEaql6s0fyG+gf7UQhtSbrtqUwM6pshDiMQGedwFa2z8p+/e9+M5+1rP
         EBjWu5V31mprIGMdb2CCr4N8BV7D8ykgPmrwGEfmC2nWiOl1RRbCep+iTqyEsqazcuuR
         QmwrNoESlSEGXMtShPoSX5TQVTK7ojm9IkbEo89ILq4/29h95I20yIOVl2IiDvNgWT23
         +b0wkKKcaGuK02NRWRmpV6Ry44QLMZkkssDssiJA4pbw1TH2KvMw/gcczT0hKicH8FMX
         7bRA==
X-Forwarded-Encrypted: i=1; AKwUvBxKxwoFHsK00oN4j6dEqNENLURnpjozNr20WowkMT5aoF6DirYUiBcyeLZU1sfbb1lFwJ+tBT/cLZ4TimoN95I6@vger.kernel.org
X-Gm-Message-State: AFq9FYIkCTrSAmhWLGJ8XKNlkVlccGdQUQHXGPGoulCwNEQoGehLYJQ5
	GG+qNFD+RZuAqobd4jcymv7xeTzDA/yEfSs9zhUXnEyKE7WskJ35cKtc
X-Gm-Gg: AYBFou0k5lgNFEr89mCsWfi88Ozvb477i2fLVXNnWtH6v++LjkBESuDoV2LIiX7ULBZ
	v474kCGgd+e3svuURZkHbRRIFTFKmavJ1CqYqEXT6IADkzwEfQb6j8/wDtmSDKaXsu/3bwN7iZh
	u6j/e45zGaAHAa5ITtl6/+fwLFbMfw0UpVdPZ0OaNmCUJY1/3LwfEAaZB6il/cHp8p4zyzVFxXF
	lft6LcG/NEBUjUOUhjGoaLFIsiWqniIrNjBujhvlLzul3HumSyHizIcEgpUHmtvqbX2L+sPkOtq
	KEHQAwwe/Gl4fcSF7ELnBz4EOGNbV6x/S8b3ZIt5qgmmUw0UzxuB6YMpNbjVM1QErIzOZ9JMdD4
	L2XTnLeEOhI1ZXSlPUJs8y2UJQjWND3FyHBShjOegZol0zGQgZ8VImpDUyoaH1wnsAN4qYc0d8S
	HTZ4NK8u2K8Nh3B2+IqvVjJutQIPgVQ1rbOsEEZbMsQPLy1dgeD1rUq0jJZsTO9672H+9GQdxEm
	m5h8tRMsxvRF3dDwB1BRz7bfqAy
X-Received: by 2002:a05:600c:1c05:b0:4a1:6c79:fd31 with SMTP id 5b1f17b1804b1-4a211c9e009mr24676825e9.12.1792739596914;
        Fri, 23 Oct 2026 00:13:16 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2103622f0sm54943425e9.6.2026.10.23.00.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:13:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Oct 2026 09:13:13 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com,
	peterz@infradead.org, mhiramat@kernel.org,
	akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org,
	surenb@google.com, david@kernel.org, vbabka@kernel.org,
	jannh@google.com, hughd@google.com, kees@kernel.org,
	mingo@redhat.com, tglx@kernel.org, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/9] uprobes/x86: Finish an unoptimization which
 failed half-way
Message-ID: <atsJCamloi-SWUGh@krava>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022015712.1297331-4-alexei.starovoitov@gmail.com>

On Thu, Oct 22, 2026 at 01:57:06AM +0000, Alexei Starovoitov wrote:
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

nice, great there's simple fix for that

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  arch/x86/kernel/uprobes.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 65a2de82ecd2..62bbe41c6466 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -896,6 +896,9 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
>  	case EXPECT_OPTIMIZED:
>  		if (is_opt_insns(&old_opcode[0]))
>  			return 1;
> +		/* An earlier attempt got this far and failed, nothing to write. */
> +		if (is_swbp_opt_insns(&old_opcode[0]))
> +			return 0;
>  		break;
>  	case EXPECT_SWBP_OPTIMIZED:
>  		if (is_swbp_opt_insns(&old_opcode[0]))
> @@ -1109,6 +1112,17 @@ static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned
>  		s32 raddr;
>  	} *call = (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
>  
> +	/*
> +	 * INT3 followed by the rest of the optimized instructions is what is
> +	 * left if int3_update_optimize() or int3_update_unoptimize() failed
> +	 * half-way. It works as a breakpoint, but to restore the original
> +	 * instruction it has to be unoptimized like a completely optimized one.
> +	 * The same has to be done if a debugger has put its INT3 on top of an
> +	 * optimized uprobe. The trampoline can be gone already, so do not look
> +	 * at the target of the call.
> +	 */
> +	if (is_swbp_opt_insns(insn))
> +		return true;
>  	if (!is_opt_insns(insn))
>  		return false;
>  	return __in_uprobe_trampoline(mm, vaddr + OPT_INSN_SIZE + call->raddr);
> -- 
> 2.55.0
> 
