Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41437E5E9
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508110; cv=pass; b=noVXLbRnYv9d2BmmMq9prCjWv+x8TLDGNbL5tZouxRv6OArddeJcJJ66e1iPQbZ8c5ohtkKe5ui/twyhTP4JxC+OYtWtR/8QHsYnJLOO1N/yDxUuoAWsLl84gi6AKSGcd2TMos0hla9zQ8WpHvunWgqB1Ld2H5XjReNFnhNE7Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508110; c=relaxed/simple;
	bh=qwm8xvEzb26ppkRe9QBMLt7pnvuAMNHHsZ659RfGK4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUjups9DMuyUV4UxsYO9gO65qhTV9iVJRw/e3Cmm0Pogzvz9TmmDI3R0TeFDIATrMuLcAD+sbNZObr3B3sON6aW/doY6r8xLMTnakweXIUpx1Eu0FYGSr+5iIy4a3Q1tmXr8AvTFsVI/iH71oKAjYk27RdEG+ecC6EnRUqz2bDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjI82/cy; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjI82/cy"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so34881cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 14:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789508108; cv=none;
        d=google.com; s=arc-20260327;
        b=WNxKcYvhimWtsRIXT3qBm2iW3o+78HcX/6GsW/A/bjMUT8BQCoN4mr4Kph8f9KB1Iv
         FrwREb4wKdpJIWTJOrv+xL5E3/jWH+scxWNRKBrW/AZwYDWKm68ZzIYLjV385EkgPS/B
         BoKg+SD2RDr2RIm+yIdRKXuvbOjuhUEduYl+4IOgr6JswKCR2RMvqFBt+KxPHwUiXZT4
         Y8RCPLqa4R/Wwsunt5mR4MClr+KCAMi8RKk56TKCBeEvW37yNpHvIEOk8z7VWHeSywFC
         IMRyli1ZXIcuzZnvcTaBn+9rWrdPOySkFwb+5SDPjzxaXmUJ0MwgkLDjcjopSvA8d4ED
         T2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SpXfdh2jhqwmQcbad0mkWft0VDZsHJgeyC3fadWXMGM=;
        fh=yBDbb5FMX9YTSKZcWmgEcthqpzq7xj1DXObbM43GJyY=;
        b=axdQsoTKLY/Hx9lOOGDJ7jht3bSk0FUax3Uny3O67b0PKsF1RlbPjLAA3rnu7um7iv
         SJdNo4E92SPakXjGuAkZD6EOQBzzH2hKAVxwtlTcoh8+j8R6qVNaoBhwnnLrTdjzx7Kv
         lXaIF67Qh1t3cm3Y95Pbpocgd9jCqHjmLzC5WDRosMAqTfvDlR2l3t2TZO7AXDybfOSv
         KpGnBWMUIzP+6KBJ4a8UdQGbT/EggQ4yyV3yBUDhTK8NaA+abwCisSnGegwIvStWycnG
         MEmnMo9KG8JPkl1J0uHVnvBJisYg3K91GXFccfG4z4q/quMV8AP8daeHR2V43deu704L
         TweA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789508108; x=1790112908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SpXfdh2jhqwmQcbad0mkWft0VDZsHJgeyC3fadWXMGM=;
        b=hjI82/cyD0+NlhW8BSwLgDcQIF5ROgF1FQ5a3hvQhDnOxeNaaqMsjLfEL525HgvlOk
         Dvhy5vjXBWAJp32e9NF+SEas5+t8oyCCuvQbnykh0gfgWi5XaekNVZFvGQ7CECYl9Swk
         8c2nr0stss7IGsXuJGCBa+OsBFR3TZ81Wtkb6PcHfV6ghDBC+bSIcpsf3emfG4akGmYZ
         ofjYYqEAgGbVMHBE6oXR/Nls9y6vUPZzS0/75nE0x0kZ5RfYCb+uO9WUNamF6qtOWhoE
         mX87t8XfsftJcGjMSQGKV/CpjMnhcCAGIuaNGQc+Dzn333t+ktNGq6N+J6+aueg1YqpF
         1/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508108; x=1790112908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SpXfdh2jhqwmQcbad0mkWft0VDZsHJgeyC3fadWXMGM=;
        b=LmN1c4umBAwkN8FwW27T2sPHFEjJ2Xvmy9Ax6fKDL3v8uQdAqbuBq0WOkZoaTzgoYy
         yzlk66AegyPQVynJxc4o6MvXk/+pYt6Jxlu2Ujx27WXaHRpnKXKeH8kMlR+ldl8ZIS/z
         I7B4Dfymhl5tm+w2eUngGhstgrgaZkFIFuq3nLtr08acbOQGDz2uaj4xbK9CswK6ed/r
         CH5kkVUnPNPX4sTj1IjACVpOAgFsrwyoa5k4FWnyB2YmtPwXKZJRQ7k78kLyKUbwYqHZ
         ue55H3euSAdQYWjLQ2Dnz+LV0/1cbaDGtapU3pBKTUjbGIRZZX9jWAXx7lfKqX/SXxEy
         YWnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBKXrAbc2dEv+u9SFO+wsTPVFvMtPPL60CMJB0MQun9NCHFhSZ/7yfPXcdAprwRXXrX2XsBUBp5TMFVY76XmZ5@vger.kernel.org
X-Gm-Message-State: AFuF++nceet2hZW7JJXv/NwPeLLmZldx18mkVB09s1yRlcJrptd+jqIR
	0Frd4IBKq9I3LFJJZtOUSez3Dr9uwbcGtU6On58imUWOVI9Gv+hQiK8Tt+kTQoQdNceEcjKfVl4
	gNgtr4ogKieyG+9u8IUAOgyqJVp4XpdQEhbd+tVy7
X-Gm-Gg: AYBFou0kJ/a5Jxf/EKwrJeIekB/bf09d/3s7CW5uyU82BEZ6N2HTQunBQwMJ6rGCvDj
	ZplscyudS5v5fbEOlpJpQroi4ZDIITTn/42G+rMQRyjyoCVKW/EEN0nqofKTifXKwFhUfQbQ4W7
	Ih3SshL5IUVm41f+bPvOgiKIcFlJyfPeF4NtxAYc81sNy6uknfP33FZ3EuxiJK8TvTIEPPMSl8P
	8Vj2S4mjRp/10Kg/zlr3gOzB3FWWm2rdwziliVa0hGBiGJVOsrPyU9TFZ/LcZP31cT8hD8wQSjr
	jDoMMTXa0nnyaTC3DjjyQDBgpLGxEWXrSBJR7b6SHgZ4p0BYDvk21suuzKv2eY0D//QKIwP5YFb
	s/2/dTjXFL1IzHkXBsRdk
X-Received: by 2002:ac8:7f09:0:b0:531:282:6560 with SMTP id
 d75a77b69052e-5327e6f2a86mr1357381cf.15.1789508107569; Tue, 15 Sep 2026
 14:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416033443.1492483-1-luogengkun2@huawei.com>
In-Reply-To: <20260416033443.1492483-1-luogengkun2@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 14:34:54 -0700
X-Gm-Features: AcwNN1VWQ_fBBO32cuN9KRTr9glrB65WLyXt9xYuBdvsxdhPnaCYHicmNMRbw34
Message-ID: <CAP-5=fW3yFPj2HuSZHntUNgze3UdY3eSsMditKMw4yWRCfg_CA@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Fix race between perf_event_exit_task and perf_pending_task
To: Luo Gengkun <luogengkun2@huawei.com>, dvyukov@google.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, elver@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 8:08=E2=80=AFPM Luo Gengkun <luogengkun2@huawei.com=
> wrote:
>
> A race condition exists between perf_event_exit_task() and perf_pending_t=
ask().
>
> During begin_new_exec(), perf_event_exit_task() may be called, and the
> PF_EXITING flag is not set on task. so perf_sigtrap() continues to execut=
e
> and triggers WARN_ON_ONCE(event->ctx->task !=3D current).
>
> To fix this problem, also check if the event->ctx->task is TASK_TOMBSTONE=
.
>
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>

Dmitry, the description and patch look sensible. Could you take a look?

Thanks,
Ian

> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1f5699b339ec..3422900263fa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7543,7 +7543,7 @@ static void perf_sigtrap(struct perf_event *event)
>          * Both perf_pending_task() and perf_pending_irq() can race with =
the
>          * task exiting.
>          */
> -       if (current->flags & PF_EXITING)
> +       if (current->flags & PF_EXITING || event->ctx->task =3D=3D TASK_T=
OMBSTONE)
>                 return;
>
>         /*
> --
> 2.34.1
>
