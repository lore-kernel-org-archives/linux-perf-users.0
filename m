Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739606;
	b=s5NDVaxrjnPpuM/7nOxbXev7DISlUtes3d+U+1UwJk89IUGP92jsw0VAncFWBwjW20TB
	 lVGTBYbnkTYgO6Hlbqz//kV+mXlGYgNivQ6oi/tbwHUyHkPjkkx0l3KQOfhlmobNvllGL
	 sC6/XeNAAuUp2g/2kGgdVQsR4o3Iblo2IQwPcufAB95KvU0izgewY/ibDhwh5Tfr6uHOY
	 CIqhKzozanKUVdNr/tdGfd2EzXuaotZxKpp4Hm7n6AA0V05/8nLGuGC7nYHnUzV8baQPA
	 WR7lULUDpSXvVBguBPgZTPninVpn2swFiVFgBqKmL/64qV6yDlyrT8HtID51bfReEMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wq7uJPFcmgA9r58RX9y8WD41guFgFXDdj9tzjsOmuN4=;
	b=yKnorjqe6BxGF/yyMqdgyhBDDChjbr6HCUaWX3WqnmMhu7U6TIxttt11jXveMf3yr+Ou
	 zy7N0C3FsjDDO+glDCVCQRrwWoMKl2lE6MrCtjTWVEyrUqKNoN2ziPKmR3HKt0cywPLdu
	 wCBWQknZrNPJ1GW5ez4+RPD/8GHksNOo9SZvtIr5rxYpvAjp/w5RxpPxHzs8E6cYsIfI7
	 aC4Mt7MhkbxpiVa7PjiepxYVDFw/U8tT5oJ8pVRIYykuW7KDTwqaf6lOlcg5SG7YJXpNm
	 pY35e57YcfRTf6IRxHi/yAPEIRm8z2dneBqZ/MWr/hN9kFHw9003iSu0tEpgNTHsbFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P+OLg24T;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB9606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17CB9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P+OLg24T
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso270865f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792739604; x=1793344404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wq7uJPFcmgA9r58RX9y8WD41guFgFXDdj9tzjsOmuN4=;
        b=P+OLg24T2DE6IMHyEqMBpfaLZ19LKpR99sGMlJRmiYlyCBdb0kxRQwF4u/Uew8jBoE
         Kd967OujE2M3LR224GaT+vNY7a6ZVHhrYJaukdiTOprNNmrWe53mJkSvCILgqLFmUbFR
         xAKVDBE62GKFuNc4XlUB0vJSlY8sWaBxty6dB2u00s2qirUGX8n35La49WgHBOgYh7wn
         o5YV8/MG448i6CwxxFKntlyeREqUinFv328e9m465xH8Mu84saZRUnUVglkRJmqlz5bA
         uPmq6WOxIxjriPMmY9rWdzTIfjkHiONHvkGU/mtHlDPEfQiHG1ckLYBc+S6X/Fbln8qO
         yQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792739604; x=1793344404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wq7uJPFcmgA9r58RX9y8WD41guFgFXDdj9tzjsOmuN4=;
        b=tgGrNHlwq99XCIh/+Fx8VrxuNySmtaOd7ujY5nwIqmzUy0ELaQ6LaBWVO7vhu9ZU1g
         Sy1wAaa/nzDm6duxP+JWa2ejwYPMUFRoVjXq2iKph9BOCPjuCSHOuUXY3jlewCdb11Pq
         4dp0EE6WJdIakuUJs0+ploAOrGyZPes+LZaG1o3L8uqqjLGo1KRQrCzS00N9nEGVbXWd
         Fz6fcNVw5uIq9anvUjrK3r1Gp/dwOBEWClj0KYMFKFPOZYxkVoRpvCh6euAa6a3/e30s
         vtSKuJJs5W8wrXnQqC9GUxB6fxWQ2cd76cgHLaxMnLBWhJfeYfvg5mDhGlPEs2V9s9cB
         CTJw==
X-Forwarded-Encrypted: i=1; AKwUvByp1vJbZBTTaGhLtXd+IX5hyPQ4pJ7bl6jlLHhRY/bX5OCRmgUtPOHI2a0VFQ2tRa610oO4cAppNzbEGnpJks7U@vger.kernel.org
X-Gm-Message-State: AFq9FYLJMi6d1MA8utu/14ZAMyq6spthGUwAUAlaPlRBSsch30FxYrGj
	8HGWKnkMg3hM/YX0rKSNqefywFMk05jj6W4ETm56Gik9fUSHMQ+3vEGI
X-Gm-Gg: AYBFou3Sm2iqakNTJy+t/Dx720kjO3xjBzZO62n3wkvPXwrkh3yctxf7CfLqJfXD9SG
	LMzk3SU9soT72KhlDXEnfjz/p4HCrr9gEFdLnZv52sWpUPiUynmlIwATjNnihGjM+3eCDJprniD
	ePt5C1lqpe4Pu5oV04o0B76atPk0vLpXi18BovXR2J/+ClpSDSDndNKJgYQyMrSnpAkXiKApUt8
	EoZMFEAElSV+zfUTA18Vz+UFxoZ2co8TwzlCxd6AgTUeNVXSkOp11/bJdSUJWDC4GX+4PfeDUyU
	xRHhkYiMKy3UPs2BjnG7PQmHjYCZ5a19JvwW/fxbwxVU7ckUJypR3o1nafvvQnqyID6jqXKd+/0
	hp5jlu/67A7RdLrG6nNZeU6E82QCiNEHpFQWL4/Q2ssfEo5NVNir6AMBtiivcHCiwSWV5evTCTg
	bmjHGDtJFc4xTzPpxHLYQWMGy00Vn+H+QCa+pU8lE6MUq1tu8bUVSqlzvXVwoJYQQLDOBfP0ED+
	hVh1WASTpNDsfBqTd3vMwLx/KbS
X-Received: by 2002:a5d:5d03:0:b0:48e:3b48:6f1 with SMTP id ffacd0b85a97d-48e3b480974mr340715f8f.54.1792739604164;
        Fri, 23 Oct 2026 00:13:24 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025d76sm3155877f8f.13.2026.10.23.00.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:13:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Oct 2026 09:13:21 +0200
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
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized
 probe can't be written
Message-ID: <atsJEWXk04C4oz4R@krava>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>

On Thu, Oct 22, 2026 at 01:57:07AM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> __arch_uprobe_optimize() and set_orig_insn() do WARN_ON_ONCE() when
> uprobe_write() fails, and user space can make it fail:
> - -EINTR from get_user_pages_remote() when current is being killed.
> - -ENOMEM when COW can't be broken, since memcg is at its limit.
> - -EINVAL from __update_ref_ctr() when the process cleared the semaphore
>   of SDT probe.
> 
> Kill the processes that call probed nop10. It warns in 8 of 8 runs:
> 
>   WARNING: arch/x86/kernel/uprobes.c:1186 at arch_uprobe_optimize+0x291/0x3a0
>    uprobe_notify_resume+0x1c3/0x4c0
>    exit_to_user_mode_loop+0x63/0x4e0
>    exc_int3+0x1f3/0x250
> 
> The next patch calls set_orig_insn() from fork(). Kill the processes that
> fork and keep mmap_lock busy, while a trace event on nop10 is enabled and
> disabled. The kernel with the next two patches and without this one warns
> in 3 of 3 runs. The whole series in 0 of 3:
> 
>   WARNING: arch/x86/kernel/uprobes.c:1161 at set_orig_insn+0x161/0x170
>    register_one_mm+0x154/0x180
>    uprobe_dup_mmap+0x61/0xb0
>    dup_mmap+0x149/0x9f0
> 
> The callers handle the error. arch_uprobe_optimize() marks uprobe as not
> optimizable and byte 0 stays a breakpoint. set_orig_insn() returns
> the error. Drop both WARNs.
> 
> This depends on the previous patch. Without it WARN was the only sign of
> the bytes that set_orig_insn() cannot restore. Hence no Fixes tag.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  arch/x86/kernel/uprobes.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 62bbe41c6466..33c35bf07801 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1170,11 +1170,8 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		int ret = is_optimized(vma->vm_mm, vaddr);
>  		if (ret < 0)
>  			return ret;
> -		if (ret) {
> -			ret = swbp_unoptimize(auprobe, vma, vaddr);
> -			WARN_ON_ONCE(ret);
> -			return ret;
> -		}
> +		if (ret)
> +			return swbp_unoptimize(auprobe, vma, vaddr);
>  	}
>  	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
>  				   false /* is_register */);
> @@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
>  	if (IS_ERR(tramp))
>  		return PTR_ERR(tramp);
>  	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
> -	if (WARN_ON_ONCE(ret) && new_mapping)
> +	if (ret && new_mapping)
>  		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
>  	return ret;
>  }
> -- 
> 2.55.0
> 
