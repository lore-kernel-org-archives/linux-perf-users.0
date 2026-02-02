Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE325393B
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Feb 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047505; cv=pass; b=qPSlbcYOl4wXSSlFJyGeugfx8ov+prVBIQq3jHkE4ACtfIaqsaLwjvtpVlHFGP7Yzkt8DlkKuX3PrZJjUMR9cULgfols2X+f93nJRW1ecYHCveWJ92DBYVFSdAaBtvJ6G7kp8v/PhhD75NIDOuTo7FR7UXcpaypu1zqiyFzH7j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047505; c=relaxed/simple;
	bh=g1GWPxgtuKJF4IiBLJwATd6WJcxMsLhFFc+t5L9Rfi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNH60++YS48LcRityMktLzr3xXpTOLPyY8yjkmnIh2bSvjgJmuU3M6EdvIeqoaH87d3B7b+9QLphdx86LCuupLeUyMuhAvias8OwAD/jQorCvtkLRYG0dfRPfnfsN5vAMvXEdAf1KzrAIHsGvEgm6aau3Ob73poq+BL/IkW1Jdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeiw776A; arc=pass smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeiw776A"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c07bc2ad13so345782985a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Feb 2026 07:51:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770047502; cv=none;
        d=google.com; s=arc-20240605;
        b=YRgtAZHH4RNI7wnoejJ8fBTSg32IaDVcpsZBZF8zeDuwmMN8lLV7rsSJyCiw+1zM3/
         i4/L3p9O836+jheGFytjysHtMEPbF+wlJUKvM+6Xn+EzrwsloYV7ubDS/At/aE8Qio9y
         2GHKGBfHFyV4zXoFMvROq+gvfMYNZPM1DcJS+0sECasTM227UmhsMfeCzjG8V430+KwZ
         O3vEjBFP8h3AGiTwS7wEOpiJM/N4ZVKE1Ci1KHy8fRyZ8+SaJW5WKtptwImTgMnoJDLC
         Ajs2vn1N00O18W6ii3xoVOb3RqpD2IsnAm10H7K3PwcIzbhi5MW27tcQpSzvc/jdz6JX
         9wsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g1GWPxgtuKJF4IiBLJwATd6WJcxMsLhFFc+t5L9Rfi0=;
        fh=K6GzsIhe1i8oZWL8cpFpfcrv1OD67dycCEaOQ9CJrwo=;
        b=Gj3VFWygGKVQj67Z3HePsYufKUN4lLqZcBeU7LhhzIAVEbJsPKjug4Bq+m4jQU47CU
         EWUYyhwu/u4ieWyfPkwO9kq1+09FgBdXwx/MJl4Q0Cgejl5O7TryM5Cr0/BgxYA7R9s7
         jnXamC6BlDGV07ChWqu9j+NdrSAu7QlHC6VCMVVwW/xxCBM8OIlBGPt5OClVsbOlilpG
         S+i6ovscaZUUH1+/FS8Hb5Ci4iwnshgDNT20tEqj8xdJyX4xxlkBhXFEqvqC/2JYH6UC
         ym+xH0kjia/Ka8n54SakTLyoEjMXti+HzimeWDOc+uG3qMMsGqSC2Ujrq+X+GK66Yksc
         Jq0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770047502; x=1770652302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g1GWPxgtuKJF4IiBLJwATd6WJcxMsLhFFc+t5L9Rfi0=;
        b=aeiw776AgC/G6ETVlFnutCJQHFnt3IJ1DE0Ri3db13hCB3YW7FBofbYuUgvcoTEMar
         F/I5eTZYcRUcbmUGI5l8T2W4rHROlXRCeqNWWVYgs1E0o9dr0LBsFrk2np59GdUmVfow
         6I5CJO65jj9UQAccnCNCvoBWCl58i7YoQWMBUz88VcloVGk9rq0xsgFPEAllFP1EAjAe
         q1iUOXVb1uxOSP9zOIMFPhfp2eDjQLwU6L4mPdcG/YWPgKRdXi+HIUtbpVpHI11zVnhh
         BkJGNtbwFs7N44Hm4RCH+clN5/DMoHkd3/P66NxKk6Ww1ooZDMEDheFlzQLQfY3DPjEk
         R+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770047502; x=1770652302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1GWPxgtuKJF4IiBLJwATd6WJcxMsLhFFc+t5L9Rfi0=;
        b=Q3CIENCvfRPLUqu9lJfsu895CUY+57GhYO2TDi8lsIyLMdrtcw9wJrJUqgJsKrAxEo
         lB2zZAlZazflbpcSyl9Sb8ciQ/HVH/foV+saxW9W/ZwW7WAwR+SNtNWQ7cE58okZEU6u
         SEVKzqXOkP3ibGwenWS0dXDKcEeV/0gRTLFlLMrDq/9DV/k9eGhvHC5J5uirAeMyrySn
         dwyrukYpGFW5kyEtIPakF0Olrv3wwPdbtBbE8mrvLfqG6jl5MdmSZhs9rX5C761mr+gP
         UegGT3AQkUESUrRqL7eOjhj19unpoS6H51TJUEQg1LfxdzibeNOpylNK22m2OC/PQoek
         zBzg==
X-Forwarded-Encrypted: i=1; AJvYcCWheDrTVIAinreCQNjZE/rU5iDE8r41LRgp1Au8S2/p53KdjX+7sZ3zX1q/K9vx0GhRBT2tO44CUH0prrF9IjrR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeddt79MBV0+W6032dTks7gSJw+cpPejB4PW8CXfEtRmnLswrd
	D0c/U/B2wmBVNuIhW0IFjYlxqIiW106BhcA5sljrvkLdiLYcWLioujwGZDMuAfDBtlCuzjFa9pa
	ViNZjUDynYEEq7WD2NFd9WMRyNEukPnE=
X-Gm-Gg: AZuq6aKGr6CZtYzRNiy04l0mb3kTFTdRCTiNNd2KFXBFDpMHrG/pzFU+b18VfCb2BVb
	jzCKajmvABLzwcepPw3ZUY/4LG+KUVgQBTNlUsOv2UBdpu309PPxZ2FQECg4PFJluiOepoGjS/K
	e2xtUxHaV6iO9Jvm9NVofC5EmlZRKsCTVzepS8XZfXi80ka5MtlJVwiFX3SK+GgbIq9V/6CQ0eT
	hNmBU+30ZJkyAEQF4fnOO55suXCb2af8asdXS+Y51gkWZye/UZh7nG64A9MAkmvBszengrh
X-Received: by 2002:a05:620a:4687:b0:8b1:1585:225d with SMTP id
 af79cd13be357-8c9eb34f5b6mr1375844785a.82.1770047502282; Mon, 02 Feb 2026
 07:51:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026020157-crayfish-distract-7da1@gregkh> <20260202075120.4005-1-yuhaocheng035@gmail.com>
 <20260202135859.GH1395266@noisy.programming.kicks-ass.net> <20260202143615.GC1395416@noisy.programming.kicks-ass.net>
In-Reply-To: <20260202143615.GC1395416@noisy.programming.kicks-ass.net>
From: =?UTF-8?B?5L2Z5piK6ZOW?= <yuhaocheng035@gmail.com>
Date: Mon, 2 Feb 2026 23:51:28 +0800
X-Gm-Features: AZwV_QgJcC37HkR8OHdDPNIaUCrKjsVF_voH0W9NBaNSA9nKYLXWGF6OMDVYCrk
Message-ID: <CAAoXzSqHuQd7k9rp878YBG5gbChgOaProPQ6XBzKpy81JF5sKg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Fix refcount bug and potential UAF in perf_mmap
To: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org, security@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

Thanks for the review. You are right, my previous explanation was
inaccurate. The actual race condition occurs between a failing
mmap() on one event and a concurrent mmap() on a second event
that shares the ring buffer (e.g., via output redirection).

Detailed scenario is as follows, for example:
1. Thread A calls mmap(event_A). It allocates the ring buffer, sets
event_A->rb, and initializes refcount to 1. It then drops mmap_mutex.
2. Thread A calls map_range(). Suppose this fails. Thread A then
proceeds to the error path and calls perf_mmap_close().
3. Thread B concurrently calls mmap(event_B), where event_B is
configured to share event_A's buffer. Thread B acquires
event_A->mmap_mutex and sees the valid event_A->rb pointer.
4. The race triggers here: If Thread A's perf_mmap_close() logic
decrements the ring buffer's refcount to 0 (releasing it) but the pointer
event_A->rb is still visible to Thread B (or was read by Thread B before
it was cleared), Thread B triggers the "refcount_t: addition on 0" warning
when it attempts to increment the refcount in perf_mmap_rb().

The fix extends the scope of mmap_mutex to cover map_range() and the
potential error handling path. This ensures that event->rb is only exposed
to other threads after it is fully successfully mapped, or it is cleaned up
atomically inside the lock if mapping fails.

I have updated the commit message accordingly.

Thanks,
Haocheng
