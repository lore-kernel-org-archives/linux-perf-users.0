Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015C29DB64
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503048; cv=none; b=t4UZMsOD01UlcHrQW73fKFjuUDc7n5Tna3FxActHLAH2XY83AJJy2lM8+pkOIM4ivRRLEbBrMFxf2ymrI+YPKHfMZ4R/DcmndZB8XWAKIknHJt01G9CXKmP/fg9k1UnUfdrGeEftFO8vjOUJYqZogD4OZnzCK1ikZL8VSCOceCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503048; c=relaxed/simple;
	bh=EN8LQhQ4SB02cPQ1sAHmD9S1xugW6nZoTKguYgtaz6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RhsNQfC+NlB9eFgLL+edrccA/oW6U1smcoQBp1p8x4340jhOaMoWdqXtUPCy64EQDwr8PSuAr2rZDjtjYzyAAmzYvfZGOXqNc+MM+6Lbn3JhgYd7zhoCh456VoWWfQ/ygRJBoADPb7tAFvXqtmSXF36vGvh5POZYedxqfhBgFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvszBp21; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvszBp21"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c634c20be90so1828316a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 00:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769503047; x=1770107847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aWTkLg5s0roF/4TK8/gpl4CHoV4JJS03x+ej1nCEpk=;
        b=FvszBp21AOcAwnlhnrQtCtFPOxx7+tyDwLFlWr1rroJ4s0rHyJx0/5PFG30xwT3Kjz
         1bqcJRwYgrdewJ0qjlbbvQvlkA5s4hmRREIh9HbCZjBeFy5E/bptrwpOzV69m6EdyXat
         5lCsO/WfUyxNNSYTaSv4TVijoa7jNQBIclNA21HWO7msFfQ1+AAneNjIcHNsjNxaq51+
         rm/qMcNtIeJmGILnmCuI/H2L+fLK9Agth7i6HrGoyRIPFyRF0hbAwGmSYmBrSQphi2SL
         IH/2yQOjBI38EwcBZk8Bcy8CT8hC7+x9uWwpKyygRDwxKVOnlcWqPd/Cse3xUNFeMdsZ
         i0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769503047; x=1770107847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aWTkLg5s0roF/4TK8/gpl4CHoV4JJS03x+ej1nCEpk=;
        b=wOnF99PUc6wx7XNclh8m1hZIfC3fSxJH/bKXCM8qVEoKz9U5Swk77r27WuNUT+MbGv
         H2T/Ii0StpbA160/dn5ELHTFZ739ANmc1OpDtJiEBR5AOKLh+hUSY39GFrU7hj5OFl4v
         9r7D3JgBqMpJp/J973JN0EIq+P0w0m3J9MF1nWxAU4heSwbB6xYHxmo+CUCT+T7WWMwD
         Vo8J7QgppM/57dHaxMpJb0HCxf8rGGAYZHTsI12HtpvkT/oGH+u949ibEz5c3lIAXkRc
         8GFEPCjgOZCpxd4quGtT9RLIxGLPwfUfnRmjguBfdfwPhuQlP3+aAke2KZjy1WA/LGkY
         83YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhTxGZElMg6T5rf7ExngLz/LJkvfodovF0i9G6qGRBpY/e2wZ4HfoqrO1eYAM6eEQf8rG3gnJr7wgin462ShPr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfo7pJRv3PGvmJ5JcKbTsJ0PHYfZOcVBRJWupgD1rG1b0Kwzfu
	rFw2m7NCl4Pd0SKEjt+XC/JqaWRvTVmP+1MUXnCjMBwI1onwlmIKxTF0WIaCfMtO
X-Gm-Gg: AZuq6aKP9gyp1Gr4NVziMTkP3eEfDMN5nCl9JOkqXSaprADwaGJDdA7UOoxIECjCuhR
	vcDgWZilO7jNJeUKse9J32B61AnvE7ONT2A3BFOwCBTmW9bjCnZtZd1StO4MnMo57KudP9kyDXn
	RypthEY2aOf802RMY6ez0WQzEoSRyXzWx5YpMXeXVwjcy4wyHCmWz7rdUdTRf4LB4gc3rsF8Edu
	vaAeszOMpqb8lfQ3CeEZpKnNAhJlaXZQY59ivoSoAFw7t1Ee1OIRlZFtMFL5trzoUE5eph2P0QP
	BUIE+QlmA2jtVcbenx71GALecj3LNsIgnykV/6IepJoZSOVGPTHSuPBJWwzxtJ8UrrE5cvyh86O
	gXOV6ip59IfS0nLf4NSXz1yYjpeIWIPeBN1PP/bVVyEs5omL5kTqct7UscB2OQXgEDGT6koVjfg
	W2bQxDr0L0oBv5SgBBvp6T3fCyctHYX3jd5cnUTw==
X-Received: by 2002:a17:90b:3c11:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-353fecdb3c1mr1081611a91.15.1769503046699;
        Tue, 27 Jan 2026 00:37:26 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f610266esm1779346a91.4.2026.01.27.00.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 00:37:26 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: henryzhangjcle@gmail.com
Cc: acme@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	zeri@umich.edu
Subject: Re: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
Date: Tue, 27 Jan 2026 16:37:19 +0800
Message-Id: <20260127083719.1347209-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127023618.1469937-1-zeri@umich.edu>
References: <20260127023618.1469937-1-zeri@umich.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Jan 2026 at 10:36, Henry Zhang <henryzhangjcle@gmail.com> wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a0fa488bce84..1f3ed9e87507 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
>  		return -EPROTO;
>  	}
>  
> -	event->prog = prog;
> +	WRITE_ONCE(event->prog, prog);
>  	event->bpf_cookie = bpf_cookie;
>  	return 0;
>  }
> @@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_event *event,
>  	if (event->attr.aux_pause)
>  		perf_event_aux_pause(event->aux_event, true);
>  
> -	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> +	struct bpf_prog *prog = READ_ONCE(event->prog);
> +
> +	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
>  	    !bpf_overflow_handler(event, data, regs))
>  		goto out;

Looking at this code, I guess there may be an serious issue: a potential
use-after-free (UAF) risk when accessing event->prog in __perf_event_overflow.

CPU 0 (interrupt context)               CPU 1 (process context)
read event->prog
                                        perf_event_free_bpf_handler()
                                            put(prog)
                                                free(prog)
access memory pointed to by prog

This scenario need to be more analysis.

--
Qing
