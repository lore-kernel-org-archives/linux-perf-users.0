Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793367616;
	b=rO2zMPwK1JDok67+UkYrJto0OJsETE2juXiCSFcvrhDSAPdxl24pQEstisxqClddgx0P
	 XbQ216j3220pwVn2FH5/SW9QbJQ8XuCP+wN/AOhsTF0o2kAH+y62jkY62QS9UBfUXHk9w
	 2RiqtaXD2utbXu5BpZboHDM0SXY8DvlPTuz5jSSU2Q89XgHtgiBNDIx0bZUHHK4fMrs01
	 +C0cPayTTGXDdDiwZGvKdU8rvoBWuvK0k/WWZ4mkLlXgK8GbIQhxT5hSI4ygRgxsdWDTG
	 Nk5zmv0o7NKiWNV9LT8RuICmMMmqvJVHtIh3i/SKoiri1zfUSEcLd23dg8YtHBQF56Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6P2Cg7Q5nhb2mHUAtpDsvhVTITuBoNrw60dH9NrDDVE=;
	b=E9s4fk+tEQU7LeylPKBMkXVMosMNe2Y+1WM025w6BB9dfCACufussD9ZXjESdu3VVo1y
	 mg4ZofEys8KTqae4eoTWfpL+V3q/wMD40BWkccsKIPnMaT59GEQjYXKeyEg8oFztL4Y9E
	 +p52D+dRlcPo+cfrkGtkCp5f6BjUYxnmKCn4SJY+ywYQU2DvgdMlChhQTHTmPxBfWIedx
	 8W79eoFI1lLzUmVT6VsGy2DhpYzMzv/aHjVl3BeLjtQdR8CNCV3j0xm/yK7JoBh9bG3Va
	 fJ5gV2oHO+uHn6T14SuC8muiv/OfJHd107gK3wWq/jGU0ZSU4tuOH1fjBDKEokXLzvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=IT0sPHNq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0A606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 13:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10D0A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=IT0sPHNq
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67a79750749so423283d50.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 06:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793367615; cv=none;
        d=google.com; s=arc-20260327;
        b=aWU0w3cK7Qk9gMV0Js6ihrkB1HbrtQof+/GHH9zXLAFMLw5PBlxgEGEBbKZ3lDCy7Q
         KylVcxfJm40aV+6B5owUPHTju8b0TxWa/+vv+KfebWP7+catsY4tHxAYhRIYM+r4GsVC
         u8s3i0Hln2BadEhiM7rcGbuh/jfx8gpe+o3o8FFebNcmhAJo6UtouI3rUgLN0Fy5miW0
         mj6tBPAfQpeKkDQ8e0I7swq1mptxaso6kYCqyOMnZKrHMyFbE4BApCEUVMkUwOU6oT0z
         NOxvQ57lY0YR+lnF0TwrQdFTTThJdqA7PSaHNCvxSIqRUqI9ixvXgkI5hA+8HzkXJHdU
         Zl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6P2Cg7Q5nhb2mHUAtpDsvhVTITuBoNrw60dH9NrDDVE=;
        fh=rUts17fe/0fcKI46rQe/Ewo6QLOuT7hmhat9WGMRnM0=;
        b=aM1hJ7hSWaiaTNlRZllE71vJnDzx39WO+GyBOaMSLkEF9Vm2H0ThjJwGreGKlwv8AI
         Q3kMmnBVLb2p+zdmlixrwMIWutScE81/Tb8bKEsOo1DIgllGjvmI94awR37QHE/BJNPV
         n5niL/Mp4HNAnPLHPqqSjcXWoGQMjtu4sim76EcKY8f0e6bZ58Vy85dXCukaQ310BUrb
         yey7ufxcM1sMJTconf28JowHHzaEAAl7gX02GFp3nhmkGvXPlHQClhptQ9t9aCPRXxjX
         fYDqPv8IJs6fyBjqrh3LZfzjcVDAUX2u648woQ6/Zq5VZQC8x8OXmIA28o8M5XKTCkYK
         APiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793367615; x=1793972415; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6P2Cg7Q5nhb2mHUAtpDsvhVTITuBoNrw60dH9NrDDVE=;
        b=IT0sPHNq7fRL0aNWhR4ZxMbhlVMvdlJJO6ojtXrLIAFX4EhX0+g18RN47Bi7NKi5hD
         pLMxSIfEBygAWLacWenGfLX5i9hBXA7koHRnjJxb4igfLGqODhepu8UYvSRQYZA6vqaj
         kIED4xIt7dPXdU9iGzfaGRHaQjriH1lKEW1dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793367615; x=1793972415;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6P2Cg7Q5nhb2mHUAtpDsvhVTITuBoNrw60dH9NrDDVE=;
        b=JOjkQ/lJ6UPPlvBMf1D2TbKlfE4eIOvD4F8phcukdTGoGmQYk3Xq8PmK+DAmdB8CII
         9SnFOx5/87CrGO/83xLhSakCi/Xpljep8Fihfyb7kKSrnhbsj6R7AEAZCrvl7iDylezM
         Jjs475pbRwr+8yYFbO7WQgpHIXxyqe/w1sEw7x1E5JIyJpxfSnjZDqDaubHT3MU2TE8u
         4vWxz5hk0xESG7D0zKhwDehODPdtox55eAk45X6jtk8Tf+UhYmb/6OBt/+p6VIqlDgyT
         sg5sfBZJ+INCU2kyDtAv82iMgaofmHmSHVzPuJUxo+VmjIpGhVLm9AX+oEz3+j3CyHzd
         c4bw==
X-Forwarded-Encrypted: i=1; AKwUvBzfhr/wlXbM1gTgReoA7DJHsMp3jga/GTMTHInBQKwxXY4RU4tvY4dAGaqtuo51XHjAOmYS/VtwPJe0gOIkB0jz@vger.kernel.org
X-Gm-Message-State: AFq9FYIq2IK4iLvgG5qsLwLU6SSzbNpbM8FunIW9OZSGOSrSziwPVqaR
	IfeUq9ln7Z8xzEjYWFZofj2AT76ubPgEqcV5NcT5GM9o2ceepRdkEOnOZ+BXZx7dJZpkA+/h7Ek
	PyBdEgHUTB1Be6VFpIPAV8VIj3+G2AMo6mQFPmgJiVw==
X-Gm-Gg: AYBFou3cz6Zjuuk9aCZjg5sFBeuservPrTk2Lp52xiVsOvb6EpFXu13euLxswTalWxX
	MH3Fk5iQN95/8xpSt5PQrT1sl09/eH7MjG7xMcgnVN3bTTKEvJiirxiDbv4/MUQQpGvT+6qX8tr
	uBNZazj17vFYgjogxJHmRP5QerP1dz9WmQGmZuSItCOSDfRx/eXoVV+6LS7LQeBCYwqljmsgWmQ
	fp3H1ZQQ+AKfk+hEzAH17u4oA+lG/04LjdE/uZoeP1ssl+Og5BCIpGuE952G9FkXPaIC4SmnzgI
	vYtOfo0KSsdcmlDB5TX2U1YWuX2wXYbnd7cLin7fJX5tzgEEQ6vU1+5tHvq94nBXM1rgnKGTUF+
	Sz1581rYcBDpZHMtVoqGNCo+S+Xqq/EMi6CPjFCs4xFTY5nSV/l7+GNaOU3ffj7y1Vy+tGP4=
X-Received: by 2002:a05:690e:138e:b0:679:b1f8:72da with SMTP id
 956f58d0204a3-67ba4fa145fmr1497948d50.18.1793367614684; Fri, 30 Oct 2026
 06:40:14 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
 <20261027231513.816148-13-irogers@google.com>
In-Reply-To: <20261027231513.816148-13-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 30 Oct 2026 06:39:58 -0700
X-Gm-Features: AclHuK8TIkJu85y66B8E48uqjOcf7KiuNWY3s7VN3LSwj2nbT1cFJPXYBWv-78U
Message-ID: <CA+w=M=SKSJdrehMFouJG7ir5MinOgeWqhunS2jyNWmjtSSW+8g@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] perf rwsem: Add down_read_trylock() and down_write_trylock()
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:15 PM Ian Rogers <irogers@google.com> wrote:
> symbols->lock, dsos->lock, or machines->lock). Non-blocking trylock
> primitives are needed so shrinking paths can safely skip any locked
> container without deadlocking.
[...]
> + return perf_singlethreaded ? true : pthread_rwlock_trywrlock(&sem->lock) == 0;

Could the single-threaded trylock path detect when the current thread
already holds the lock, rather than unconditionally succeeding? One
option would be to track lock ownership or nesting depth. Otherwise,
the shrink path needs to avoid any container that is currently being
changed. In the full series, the unconditional success can make
shrinking free an array that its caller is about to pass back to
realloc().

perf_singlethreaded remains true in perf report, perf script, and most
commands. perf top, multi-threaded synthesis in perf record, and perf
bench synthesize explicitly switch it. In report and script these
trylocks therefore always succeed, even on a lock the current thread
already holds. The shrink paths can't skip a locked container there.

The case I hit: __symbols__insert_sorted(), reached through
dso__insert_symbol() outside dso__load() (for example from
db_ids_from_al()), holds symbols->lock for writing and calls

perf_session__realloc(session, symbols->symbols, ...)

This path combines 12/18 with the shrink and allocator plumbing in
15-17/18.

If that realloc fails, perf_session__shrink() reaches symbols__shrink()
on the same container. The write trylock succeeds and, with every
symbol at refcount 1, it frees symbols->symbols (or reallocs it
smaller). perf_session__realloc() then retries realloc() with the old
pointer. With an LD_PRELOAD shim that fails one realloc, ASan reports
realloc() on freed memory from perf_session__realloc() <-
__symbols__insert_sorted() <- dso__insert_symbol(). After
perf_set_multithreaded() the trylock fails and the insert returns
-ENOMEM, as intended.

Thanks,
Alireza
