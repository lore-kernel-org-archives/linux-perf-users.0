Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794261545;
	b=dyZcEV+D1A/hosSi546MHlnrkXlt0rxDsPzSghbkNPYt1A2Mo1qOAmfrOOuchUzDc8xd
	 Uc1uXo57fvGLSYHmtJPAOgGfkHUTN4gZArHLDDwPSaDGgnlo7h2Z/cXUihDE99WedXWlX
	 bZoiS5Z+CEtA2DQuer3QQlDOYMU9wYLJv0OFF3t2fB6fIRDmUEpFtatIIMp0FF2I8OQAb
	 3KGnJP6anv3qVoueYabVoQOj1765UadkmC7h9zsalKU02p5luR5EXt9rM5xaWJt8D2+1S
	 rDQ3GcFauvR0LCQq+JzwobHX+XoeclITkLoiyJ1K4f7g2ovWczBgYiYTpjrBeFmzA/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cvV1+x6egeZIOS6mY7nPlFsWTpahpD9QoPA6e3DqkZE=;
	b=nEKO2A8wetiee3nayKqM2mMXEyTmYwHUqY45y/YyXtbQXYmYGCed42T2iGpfkR8c30Yh
	 vaOZHkkqaf4gEczC+mtcDjrf0ashFUe7co1mvm7WBHSoZ2kvW8zG9wgjZ7UqOWtWgkc98
	 QtBHFyoOHtVfLE4UExYgPtL/ZZJG1TMcTNKmYmK5sEH98hoCWIxt4lKug+BGITy7QkZlJ
	 +3PfQEuWxy4BCNPGc8CKIWvVl/0oLdm8nbnitAyqHLfEoZ1bfF1PXJcWoyUL5wg6KZsmj
	 DlxgUyL8/78RXdYjtG3+V6dhbaYG8yMLPumOyicxLCX7+lHBUmHLCXdgb40QrdDrS+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jVkI7ClZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC8606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 21:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49AC8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jVkI7ClZ
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5383c97c8cfso24921cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 13:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794261544; cv=none;
        d=google.com; s=arc-20260327;
        b=niHq1KHNo1vePndxyXXbqOmL60V+BK7VFq2F4c/YZ9wqBlecbHa7KW34tY0qL85Q9X
         lOSpYoHc9VrE/mPcmMTFaYYktmi3EOgI6tPi+sDQD8e/ZBRoRxh2ozkkWJ78EechpLuL
         ZD332blkEH0wdcTvq/2jY/xAIHHtT1PM06AoIJRacnBVaN/X0gpjmO+2/TmV8iu3TcGR
         A7uYiG2yFGcymoFRYXnFdP53S4LYKDQuf2PTKroHozCUw7Newy00fnPnbwsvlq2XDlJx
         Nzkc8jR4DPWyTT0d6Ixyd1A+qyHhDDw210piMFVSVx+aR092C9x4THwkzxfbxbMyb5im
         9eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cvV1+x6egeZIOS6mY7nPlFsWTpahpD9QoPA6e3DqkZE=;
        fh=mIblokmdrHpo6AF+Pg5CV25W267GDPhGf+yZvEETtRQ=;
        b=CpKbNhWaNmtMf/jJhHIbLFw6XhFeMzQLzeI/qiIA7XgDW9DSX43kEo+aUsFfwKi+3/
         0eSgxLqji7zCIkELmigF/L0V8nFfXCy/YLZIOtty71ow/B76olu57a5Mzs+Xm7rW5cYJ
         VG4wUxmmxMlX3LQOBMDd1WjqN/dhpOBEIXhPOEpFnjPnUo1fYg8Oal6RYHFE8KHQfQwz
         LJIcnnBgj6XVLSI6q8B+pUYAW+f+PU7pEaNd1aC1iyE8X66XglAcN+LyNfj+kpykNFez
         ME5kwl4wG/BOGA9WRR4nFSDWM1psRIjbg1xEFGSBvLEm9w+7bxWyf91o+zPER35uJE+s
         vkMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794261544; x=1794866344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cvV1+x6egeZIOS6mY7nPlFsWTpahpD9QoPA6e3DqkZE=;
        b=jVkI7ClZXWzRolTRJvb3/jiz8GXDNAi+Y51HAKVmPxjpEr4DLkMY2pC3v8pW9QvTPs
         MQ4cDApZpO8kRYa+teKED5Whuhh5R+kE842e8ggpcT0V3wBqOQPrTRfGD5CBlq+QzOzm
         acJ/V3/Ch1f+Yq1NiFIhnD6GoQbZx0gL5ikGtAfFkHqLH0fhEaOkWEX+3LcHNm55DJLM
         tvG4zsT83FWpKqnD1J31VDVGO2HuXTwXiBRIOlclJFPXXjuaFae8Z9D0ueUpNgWNnEtD
         AU26LzgZk7sKb36su4b3HhVW7ZsnS4QRDD41AlkhsbXG7LgesizMD3HGqgcOGaESVn7U
         Aa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794261544; x=1794866344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvV1+x6egeZIOS6mY7nPlFsWTpahpD9QoPA6e3DqkZE=;
        b=o9yATm8lUqOh6CtUYFxRSaM3WdzvKd4UIupCDb37FHSD+TUbD9qIbez1NM22076b7T
         tGYgOUz26cRot8y+S6jEN58AiYh232e0O9OdaSAGLbEKIBUqo8Kytv+PQd079UNEKZbl
         DjOoOGDLlEf6KOljc5OwTb+HacwrgkvYyjXN2UVZAliH9EOQXwfWzjquL5w/k7XvWCVB
         Df8vqaYHVbBgyNcRFeYdwjLgu1yl+oVU07zhludIdPyfbc+KsY7T1ybEFioZckUcOy15
         Kx2t2mqH0eL1AsO/8cijs3jDhhjAD5+XBKygVjWiNQ8Iq853Csej/OGl4nm+S1FPo1Ti
         i3hw==
X-Gm-Message-State: APuU4Z/5bKrySKt4GLiW5lkuNC3LpiHjLhmimrEv/WJ5xfEyhgzASbBn
	suZVcDZXkIuzYic91+aJh0sd+GG1lxikftBQguj+U0z1rux8xix7P1GjrHh7ybEctqTbrMuIEQS
	5S/u8moCN3F9pGWCIQ/R96Wc43lkjrCImQw4NkUq5
X-Gm-Gg: AYBFou0sW8rPZDTSFhua3ST40BMStPEpEu1WjFSUKXefsbd10NetQwSqFy11vNG18Ya
	LR/qpIXqNu81U5il4M7JfmqeYxtznojETYNxGSIYJ8s1HCDn/obf/7Y2XVnNakKxLIlFxBfa0Ar
	FLMRik81AU2isruo+mlT84xXNR91MJszZ1LicR/CB+mg+5fnHxgI5Q/U9boDIuo53mjzmu/oBz4
	Se5jCJwJwdCEj1sFQc4u0WNH80D3AUErCORb9eTy3fXsu9IAZlxVT6Zyo2JcPxdbHzHoFIf7CGY
	B8JxQUFPBPmhmbUg203bjMRXhbSlCs3mKalVVWJPeToPTML7sKoiZ98e5qKQx293fdd0KIYXPTz
	CS7oa7boC6oj3keQI2jU/ZeYUJJxK+pxrYGfF4zJlGGl7IUMW0Ex6L7Mi2vhVkzz0XUs=
X-Received: by 2002:a05:622a:5a11:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-555294b5379mr5278851cf.0.1794261543291; Mon, 09 Nov 2026
 13:59:03 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109120320.75053-2-qirui.001@bytedance.com>
In-Reply-To: <20261109120320.75053-2-qirui.001@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 13:58:51 -0800
X-Gm-Features: AclHuK9ZqQj8qRR7GQExEW7WbgHpHS7TF-EO6qkNbhVRaleoN-uxmSQ4-CoXb4w
Message-ID: <CAP-5=fUf=MD72=wuSxem+j6S11J2SvOaxOEb+H+ifLV=Y2p03A@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: default data breakpoints to any size
 on RISC-V
To: Rui Qi <qirui.001@bytedance.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 4:06=E2=80=AFAM Rui Qi <qirui.001@bytedance.com> wro=
te:
>
> When the length of a data breakpoint is not specified on the command
> line, perf defaults it to HW_BREAKPOINT_LEN_4:
>
>   $ perf record -e mem:0x30020:w ./prog
>
> That assumes the length describes a byte range that is compared
> against the address of the access, which is how the x86 debug
> registers and most other architectures work.
>
> RISC-V debug triggers behave differently.  An Sdtrig mcontrol6
> trigger encodes the width of the memory access it should match, and
> it only fires for accesses of exactly that width.  Watching an 8-byte
> variable with the implicit 4-byte length therefore never triggers:
> the perf event is created and enabled, but no event is ever
> delivered:
>
>   $ perf stat -e mem:0x30020:w ./prog          # 8-byte stores
>   0       mem:0x30020:w
>   $ perf stat -e mem:0x30020/8:w ./prog
>   10      mem:0x30020:w
>
> The failure is silent and easily mistaken for a broken hardware
> breakpoint implementation.  Tracing hw_breakpoint_exceptions_notify()
> while the event is active confirms the trigger never fires.
>
> Zero is a valid length for RISC-V data breakpoints: the kernel
> encodes it as size 0, which means "match any size".  That is what a
> user leaving out the length asks for, so use it as the default on
> RISC-V and keep the existing 4-byte default elsewhere.
>
> Tested on a riscv64 kernel with hardware breakpoint support.  With the
> default length, watching an 8-byte and a 4-byte variable both count
> 10 stores, while explicit lengths keep their exact-width behaviour:
> /8 only matches the 8-byte access and /4 only the 4-byte one.
>
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>

The change makes sense to me, and I may have been the last person to
tweak how this parsing runs. Could you address at least the test
failure issue with something like:

- TEST_ASSERT_EVSEL("wrong bp_len", HW_BREAKPOINT_LEN_4 =3D=3D
evsel->core.attr.bp_len, evsel);
+ TEST_ASSERT_EVSEL("wrong bp_len", default_data_breakpoint_len() =3D=3D
evsel->core.attr.bp_len, evsel);

and then I'll add my tag.

Thanks,
Ian

> ---
>  tools/perf/util/parse-events.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index f3ba70d4f76b..b72e4b0da8a1 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -598,6 +598,27 @@ size_t default_breakpoint_len(void)
>  #endif
>  }
>
> +/*
> + * Default length for data breakpoints when the user did not specify one=
.
> + *
> + * Most architectures treat the length as a byte range that is compared
> + * against the address of the access, so 4 bytes is a reasonable default
> + * that matches most accesses.  RISC-V debug triggers (Sdtrig mcontrol6)
> + * encode the width of the access in the trigger instead, and a trigger
> + * only fires when the access has exactly that width.  This holds for
> + * both RV32 and RV64.  With a fixed default, an access of a different
> + * width silently never matches, so pass 0 on RISC-V, which the kernel
> + * translates to "match any size".
> + */
> +static size_t default_data_breakpoint_len(void)
> +{
> +#if defined(__riscv)
> +       return 0;
> +#else
> +       return HW_BREAKPOINT_LEN_4;
> +#endif
> +}
> +
>  static int
>  parse_breakpoint_type(const char *type, struct perf_event_attr *attr)
>  {
> @@ -658,7 +679,7 @@ int parse_events_add_breakpoint(struct parse_events_s=
tate *parse_state,
>                 if (attr.bp_type =3D=3D HW_BREAKPOINT_X)
>                         len =3D default_breakpoint_len();
>                 else
> -                       len =3D HW_BREAKPOINT_LEN_4;
> +                       len =3D default_data_breakpoint_len();
>         }
>
>         attr.bp_len =3D len;
> --
> 2.52.0
>
