Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292513;
	b=e5L81S85meZ1BOIWjrmiR+tA8NraoZDZgVLI9eL2IvG2Mh2aTfWrRDsQpah81w5FdneE
	 ANdjcJBhGt54KnO5+e8B6H4q0f7b6lPSaD44ZFcXUGH0wyild46qwHUmHgH+Df1XH/ZQo
	 XO7IuHTet302g3+rIzLH758xAm/XxaedKqBwxNmDFt1TJ+yBmm7ikJRLhjMCg9tSwLpzk
	 ERhG4XQ164Ik/Z+fOp/v8tjaG1OHhjiq0d4APM8YftTvcRlke2tugV57B2V2oQYGhYKEK
	 7U6Vb1L8FOzsrjVhBob8AL8Irehb2lAKgGSnjExZMfTDDkeWLW/KZxbNF+Bwq2BVipw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SrAtUp9emSKSwdDhGVp75ycz8yJkKPQkr0AQDP+R5XY=;
	b=n2U9nfvCtDZ21OrK55ZQbRH8JvU/3BqH+N/1RAlHqAaQbuHVMJRt7QlCBVW8hOPfXawY
	 snr/9WPhRJTmaCQ4sgEDHKQ3iuj3Bv16R4K2p/6GdqZIx0qLr3BsSkIK/9VxaHIS59xWb
	 nvNd3cDEyZuWUHqFK7T7cE0P3vNYaaTGXSxvJeOzF+OnO0kEmrB5hY2/uFy3pBH7oEODq
	 tZHs4kEJWXzOe0H+CZJ1m9WQ1QWpXjFmRvIq63y5Ahzl7xOuUGCrVGROL14XL0KW0QVwB
	 R9VgiI9bT1h+yUEJPv07RSRXjWTgN4zoKayUyJzqVBu7aQYb4+8xUf9qdORt1cgkqMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvZh9KkF;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998BA60A2600
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 06:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 998BA60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvZh9KkF
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49465892f7bso1120908f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 22:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794292511; x=1794897311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SrAtUp9emSKSwdDhGVp75ycz8yJkKPQkr0AQDP+R5XY=;
        b=KvZh9KkFCB0l/6Bmr8nRlFNiNAYwTuU4bAbREFGDiprWKCca1D9gjGF60eGJA+3F1m
         /bv5d5Tc5eWM5D865wZT1/xR3NEMOOdRqy4g1KkEy4dNN0ai3E7ZEOXBKCO9AA5jrZON
         81noRzABdcThsTx/uPfWP2XKO8tbYcZNnqcldty/UzrmzSJt6LP+9II6IP/t+90m35A4
         cHdS20nAQY6nLpp4JCwaxwmfEkKJkszzwHAQ0RkC24pcwIC8g2itd/wYEPWH0RU5LloK
         +jxZ0egu/5nUvtzeuP+y0T3PHWti68rhJPt30aoXkp9b4h0G+AWEqtc8wek4WNU9qfaJ
         cryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794292511; x=1794897311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrAtUp9emSKSwdDhGVp75ycz8yJkKPQkr0AQDP+R5XY=;
        b=gr0OMN4SI6Tf+FG+ligmkI0iuZ1KcAMi/S/jvH+YMN9UmZcDdgD28HFH3gdbkP8NdL
         EzC0Iuc7mjSaPhtfD7W0u246qAL1wz+5vcZmy9benjwP1hz66bjJBkmtzTkwja/mzzeM
         0KCeBMrzbIeiPY4wI5o3yAhz8OOcos5QUhmPi+30bJ+pXjRL7a9FXz0bcnQ9W0xrvhM6
         miASRioVUxgrK3w85+X3fnzXoKQu5AlfzPtziJmPYn6lkCoa3+/V8bBmBhRgM0RgZq5I
         2eY6FtV+xc0Yc4UtUEyCg+3KvpS2rJXwcyRT9xRgI89hCXi5hNnQXrHDZwFa5JPAgVTV
         T7ew==
X-Forwarded-Encrypted: i=1; AL+hErGJHu5rfslTSWdDNcD70UGha5gM7kRToAJfPBQ0CONjDp7CmGWH+hXyU2xXUYDKZXuFVfWXOMXTRhhWZDDP0dz3@vger.kernel.org
X-Gm-Message-State: APuU4Z9vawycGfH/DxDBE92YqQTCfRtIcija3xEFuskIHBNuuqe4H+9P
	w45/h15qtIjSM1izolx/V2/Y/lNXS64KU+jHzqQhjb0D0Y77wbooQtoA
X-Gm-Gg: AYBFou06BPbpngrKI35eTzneOqS8y6pVmckDvgufcToCXbt+q9J3gR3rZoqJkyi6grP
	y3qMRMAS8d4MhnKUGIaDxfDJ0JEKuRJR0FaHm0nB9LLgSyWR3AvSbzP2o7s3TQlWOE9FdDZrlhb
	giZWYDYjNm43+fhULQplhdJHUOEfRDziDlVWXNJMa9wiYWVKZEVMR5JB8Xk6mFSXWkiLxnubJ1+
	dvf3gD8ovTVVvC99SupIHV4VQfptEs1z7V+NQD9sd0p75iFzSzM2yA9Odp4Yuz0QzCPj2fPUtwA
	Tkq0/3hiVrQT+nj2LWLl1ThEVmQTkAmRTt0aB0HK2sqTDg33AHPRNB5QLq0yz3TdeSatWGlx8OV
	ZzshdtIatMuxbeDhReCnWXtTRoXBP7LouS4N8ZR/TEmW8MMYi0L7OnoTFfOT7oJdrPT8nszZX6t
	6UbFycSRvzne/lqOigaLjWllKdykKUrGh3a+h7gfaLndmcuQnt0MFH8mFwKkIVT+u+IfBn3TGHb
	rov9nHBaB+ZM+sUDj8fK6w7UK/WDl1J3ywBJRTLTqPmBp83IxINfn5x/1bFRoU6FLsvrCP6U2yK
	cVdcrQat2dqFVhfIfv82r7ECoDrwpC3Wxsuojf1qHIIYHlxHo0ONQt4hVwCtBta796m16fBpGiB
	evdvWcRLAYWqvplyqCsLXx3w3ItehPQ4i/qndoWHB99eXkuuwm85JG4fWF+2CEsdLe3+qm9TO5h
	TcUs41ffBlWYMW3fQzoWY/uRCTtF5kg04=
X-Received: by 2002:a05:6000:288f:b0:48e:3cec:b852 with SMTP id ffacd0b85a97d-498306d02e3mr2957082f8f.40.1794292510590;
        Mon, 09 Nov 2026 22:35:10 -0800 (PST)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-a0e9-dc01-c402-36c1-c306-953c.310.pool.telefonica.de. [2a02:3100:a0e9:dc01:c402:36c1:c306:953c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c500asm3241156f8f.48.2026.11.09.22.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:35:09 -0800 (PST)
Date: Tue, 10 Nov 2026 07:35:07 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-riscv@lists.infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org, mpdesouza@suse.com, 
	martin@kaiser.cx, oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com, 
	jkchen@linux.alibaba.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 00/10] riscv: Add reliable stack unwinding for
 livepatch
Message-ID: <avK6oydgmtsa_Sjg@gmail.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
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
In-Reply-To: <20261110013750.36800-1-xueshuai@linux.alibaba.com>

On Tue, Nov 10, 2026 at 09:37:40AM +0100, Shuai Xue wrote:
> Changes since v6:
> 
> * Rebase onto the current riscv/for-next (based on 7.4-rc1).
> 
> * Fold in Karl Mehltretter's two patches [1] as 1/10 and 2/10. Patch
>   1/10 stops arch_stack_walk() from reporting the walker's own frame as
>   the first entry, which corrupts the skip-frame accounting of
>   stack_trace_save() users (page_owner, perf), and adjusts
>   return_address() level accounting accordingly. Patch 2/10 adds a KUnit
>   test for the start frames. Both patches keep their original authorship;
>   I added my Reviewed-by/Tested-by and sign-off. I asked Karl on
>   3 November whether he would like to see his patches folded into this
>   series; he has not replied so far. Since 8/10 reuses the walker
>   extraction from 1/10 for its !CONFIG_FRAME_POINTER fallback, his
>   patches are included here to keep the series self-contained.
> 

Thank you for folding those patches in. I'm fine with that.

Regards,
Karl
