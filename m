Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E21301709
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621919; cv=pass; b=hFw0Ove0vzpDoxI7JBy7vzJsrSSMchHt5EvyBHXWQZMfT9va3DS0lZPT5oYDa4PO4pmMnsQzOJXpQUlAVttECTg+uIKLuj+nIY0IJRrlaRNuFkVcZ0tbvSp5yMZQcO88wrsY6KUhHXXb5gX4i7x8aPY03Qho7aV7nek3exlMW+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621919; c=relaxed/simple;
	bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byM5bqRbSauwhs01AtwJWFkYMg0ksg4yKQa+xhGlALsa2GQHeuaM/RrQyvlo5JZPABz0/5a5CE/kcKky3r1rH/58yst3FWZrOd3ake1fVF/lIS5tzVoqohqd5jkDbeogb7WyAzQteqXsEjTVdvmx6g9PGeYy2/zBBaQ97y5O3bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcpWmiK8; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcpWmiK8"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66bd7857841so3428841d50.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 18:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787621917; cv=none;
        d=google.com; s=arc-20260327;
        b=oDSydGb8uGaUh8rZHIT7TXkesVoLSTca3HVEppGCBNd8nQgPmxAP1UhVs8FJhL2Rr8
         mAN7UmXvCzhjI9nZngNLzeWfYMDBA17ARyjZP3CpM3ghncR/ejf0Ja4ce5+R8e21NzPB
         MGVS1scQsq9Mo465jDbXCMtBsNO3eIzkSYX6XNdZor3MV44xM8TneYlcfSx9KXw5Xz46
         VNOzEag/zJJoKgoKEYvZpRUlyjZYd8x2K29kuLEZqPwCUvDz6IaoA3U/EODUkUsVSFHg
         fS5Ga7l7Di+KrTO8K7DIp6vAOncKtZn2vHRXAueM746ZizmS5dgYow0yCIVvhokSDnoU
         yFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
        fh=VV2E9CtC2D0orfkO8ZV0PqKEpxnE1ZBtfoABGAf4IOA=;
        b=BNoZujsXimiZW3FILDKWrYb/UAK6JB4V09yREiaOUZMeJUO3qGPJEDNR7WsgFpMsLe
         nIPxp3QQFKbjSee66/XWoUlzYuu94MVNHH0coKCEyNbPVvxJGkHi2uGBHFJMJ5U2kyb0
         rhv70Kw0GUjG5j4Fsb0Creve4eQBmj6ft9NoDWUHo8ZSpxrVs06jlsad4TgfqlKEsBNf
         9QnDo0UWUiFu7m1/7ywVhPI/djB5SEh2ztiy9iq7R3JM4k51MRUHYaK/qVm1mNbKCkmB
         NkMRZBbA3wI+Pisngq+ZZ+7pdjXOK7wbS5ntHL5QNE+dAsHV6v2glsdNIMJN5WsLG4Wr
         4scA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787621917; x=1788226717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
        b=RcpWmiK8D6TXy8SeKasN3A0DZYwOfxBRVcB8htDEIll1rHrnI6lELCV5zqfa7hqRIU
         rEtXhQwWzLhCxVjqmaqiPTZ5z0dJcxPhJuB+w/2g+ZIvxA9AA7wp1nCUmi/Lx3BT7V/D
         ix6ekhi8ZBI5IfxzW0LEJW0lhdkZsJx2MxnwWBni2MPKVcGdd8ABIe0GT3XfKGApfkV5
         94uglqgNOv4yjFi7HXESZnyitoC9C18fLhT4/Qfuilf4PgC3Dq1ZbPc5PRBpzoDcd/MI
         IZqnD5RIjFJMBR6ogU+eumXbmPPa8+C4epLSIHNwNtfwpjDlK2p3AxRoHpFvQWAoEL3b
         j4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621917; x=1788226717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
        b=gsvp2eCIVjn+ZGgLdY6znuXpSB/QouOVzUDlOF65kcd+vazBUQzwGYH4UN0E99r+BZ
         pPm6MeWnW+F8NGpQbuN8Ljc+l3MJPGlotalwsDFQXXJJW2UG6nDJmCZUxcKw9Fv0AU3v
         W45YHvezcDvPacRToGFGRuzoYWbQTJ+KFnCuVl6GFbL9ELWi1UTU64GvQRBlq6l3jb8u
         dMxHtmDGQj7sjYEu5nbhnJan2UJeh2oFDg5hd8Md+p1lJosn6WML9jj/CpaA7i9Z9CQP
         wApr2QldJ2y5gEBSg5iWP/aMg07/pQlVeDnMHx+xOK+D8X/r9XT8D8vu6eyedxmzW5ws
         cACg==
X-Forwarded-Encrypted: i=1; AHgh+RoKE0ZM63+Nea3/lNUIyc+ZVtvE9QkGFzK0Ec8da8tSlA1JyCyYMWBmGOJD2YUFRa4i8Q+iTI99nT9C4mrdj0j5@vger.kernel.org
X-Gm-Message-State: AFuF++kJN66XfUT5Pkfs+qkyR810hCTmxODGUDu1zm6hh0Drrj+Mjo5m
	uOF1gRO86x8ozZJhQ0W3xjhU3HlvgTNFeEAw2MzSkY9rD0h+UMowF9GUQkWKHesgbwR8bxlbam7
	zFiOz5E5D/SuHmfiPOLfnk6UF+iZbTUk=
X-Gm-Gg: AR+sD124VW371Jj1kKGAmAwZyj1JkLg3MwLCeQkRiZc1uurNzVgPS7kK5QcqSn+mrmT
	y8zhIRDAQ8VuddyNi6LR3PD/8yun6RED+dSgm0S9GT537UqG0CBo1E13on0EOGAsSRfpEznnMrf
	dJUWGQtQEyh2gS4qoQW09BIAhYAAAc1AGxYwB7mJqXxT1l2R+B57YCvGIrf4HZc96uR26GE6e07
	gRFKJbNeXjE7J7R25BKUd4lzEMCm292NoKcwmhAu0mmP2o5Dl8wpkb3hmT+K1fmbJIJ7D8BglR3
	KeZIJF+Jugq7Rr2WKVqtCqxe1N/BAssKwJ0Drs8VKSzMiShs1Zx3aCombsSSDcwOEzOuvBpjoPc
	mS/2qsl4n8acjv3gXPCcAdYJXeDqkToMqkEk0oeqoniI=
X-Received: by 2002:a53:a5d1:0:b0:66c:76e6:2d01 with SMTP id
 956f58d0204a3-66d14a21801mr845428d50.9.1787621916851; Mon, 24 Aug 2026
 18:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821014210.18681-1-kartikey406@gmail.com> <CAEf4BzazKkRiOCAAERt6YueeVYnnYeNEPmxH+EW3F4CR_YVjsQ@mail.gmail.com>
In-Reply-To: <CAEf4BzazKkRiOCAAERt6YueeVYnnYeNEPmxH+EW3F4CR_YVjsQ@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 25 Aug 2026 07:08:25 +0530
X-Gm-Features: AcwNN1U0LHGolhM0a7k05nKFQh1Imv-RibXkGJMcsIUuJJbyEfcSMIuHp8mjcg0
Message-ID: <CADhLXY7_Dpzwuqdq84scYObut=DTTqfZgG_U9f-fP6GFeRVT-Q@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, olsajiri@gmail.com, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, kpsingh@kernel.org, 
	matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 12:04=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>

> exposing this mutex like that is definitely a smell.
>
> AI tells me that this perf event inheritance case can happen for
> non-tracing (i.e., BPF_PROG_TYPE_PERF_EVENT) events, which are
> attached while holding perf_event_ctx_lock, not the bpf_event_mutex
> (this one is held for tracepoint/kprobe/uprobe programs).
>
> Please validate and adjust the fix.
>

Thank you! You are correct.

perf_event_set_bpf_handler() is called
via two paths:
1. perf_event_set_bpf_prog() with ctx_lock
2. _perf_ioctl() with no lock

I will investigate the correct fix.

Thanks

Deepanshu
