Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE603ACA6C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134427; cv=pass; b=ViLB+dRX6MPqxERabN+Sia3ZypOzQAjm0A7WqdOF732ofFKSTShMam0FI1oj9oa5iDBI5drfmOmmf32DuOGGQ+fRWHKEkStCUPadq9tX1rXEdh7L7ADcT7RQ90dk7C99DYp5hzNlvLIQ0pviDzsQLcFBkWpGqZCot8jsqMhJ+zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134427; c=relaxed/simple;
	bh=1rXl+iKvG31hPrkCt1juiT/NMM+N5YG90o7jiJUxLOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oX6gNE8AF4CS/fy4ZVUHegHbaGXiemmAdHbsmdxjH4uN8iINuGZT2rOhe4ivMvX9tYFU2whqMuXU343ZZVqyaVa0WLv4K+qqBRzMG8QRTsuOUOJkyDO/7TvQoyF4xyqSUFj1Px2COUCKxFWkMTQvRrFtfcQvus2MvPvD8XT1OD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk2fygiZ; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk2fygiZ"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fded6b087so460806d50.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 20:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790134421; cv=none;
        d=google.com; s=arc-20260327;
        b=M3ko0kahh/cHF/1lsGLurIdUsFqykYPeeQWzNk0ne4fBykJkuL7XjvlVT0VMcx2F+a
         kwAHNItwjFiuqrk0Q1UaVpoPwj5Ww2c6V53h3OI2wqfT1RCy5XtzjiVRfxfljA+7CoBC
         ZzPuHemGSJA2Od9IVznhuHd1VS6K020XJIYxAvYnMACe8TJxbbx2lUK8NHo5DY2YvfDM
         jH7bRhPNsdbQKu8IvqySEG8j6/RtnxGHNOxOBBy4AKDTkSNnU+vn+CEuMfWW45gGjgzT
         K6zxCEgrfai6HGz7xuJblesxCA5xS0wIe8a7tMzsB/EY1zvCOZTfBqxx/CIyZL+Qckkk
         mqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        fh=GUBoSBA74OLtLrl4thRS+HAODC6HKDPL4cyjo/p9EpE=;
        b=ZdoychEDMZGrohxe3IB6vNXEOjv9ufgYd+rQzHT49lgnNsj23VP9EPyRGt24zfAhda
         HWJLFFUBsdAnbVig3+UvS4n/Il4wHijDPZZFumVUTeTIh55Vgr4Ow8PrGxwbUQdQQ78S
         AWxareUrt0LrJfizZjNAtqm35j0ZDUEjUgU/VT9NzWzFIVRwP3vbFYErrVkevigVcr0K
         2HvM2M+AvVYbkGUKS740lWGL/S2aU4+++8kwvGVQqRpqpg9iL9Nhsm/ECqmapiriFwXj
         mkagrO3MOCnRtvr+1nHBvCpwt9aQzbaJhq6ZXGdjD+R2KK9zgqdMbpNEtcYcjgaP0rqY
         I5ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790134421; x=1790739221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        b=Vk2fygiZztDaLIk1AYzOzIIY4JFCZows1thJZzlKsJYfhU9d4Kpp1GiO2wGaqz/v/i
         uMx/xOfTmzbSgWQpvOyOd45DaSDUtHIx5vZ8WfjtPHeFA68c963WPkYFj93zAydRMCnj
         Vy/mGrWgXHVTLYPqkVDlOnS1GlxiB1vXVnUv0GeDW6NemS/9SGHKUMbngDPDAb4m6hTg
         ePIM8HBpJPHsdYfvaDvvmUTxNX4J6Zm0OS24tNd+PkJfSc28e/+zOKc2eqleOKzaXiFr
         toFNBYQHFt/jZXq1k7PY7usHJqtTEbolcJvuVZ2R4t0I3bcm2Ab+KOSWdZ1Te9y+5ghB
         H58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134421; x=1790739221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        b=ayLQCTRH9Rm6h2PMc4z//MdiyZG0PJw0Kdodr17tyjHy/fiVnGT/JoFZIwIH893Wuu
         kGfntNBrqf4T3vB5C97SfrPfO5zf8iatfNX0xVJJS1Z6l9qezuDTNJTRM3FrlV5UDWoJ
         7p5HaRptDfBFg6eLYLzD5fwkNcy6xFwJ9VaF6jAtQxCKqk4OlGvwBC9Kq7g0kqqUZYjI
         Obq2IOHT+UlIhuIZLde+EDLxThhLT7TpB6tQ3pM6Sx2jZWOsecttTwTZFhS6LqkNq73N
         NKLpDT3dzWK/3z6WGczYDoc6sH1TbaX88d15+iLuX2R7rtm0nowOm1p7fGGgpPA2d9zj
         Rl1g==
X-Gm-Message-State: AFuF++kN80cnimxqSrHP3fVpdDBTH5K6Ym2khAI4iIiPFs4yntJfXeSh
	tc60N2YIep1jbiyP+9Ro6Uy46RYXK7nzek9izxuwjkWrCZj7B3mwNn03sTsSfljo7f7HDv08VNV
	Zzc8KQAcnHgo/PqdU3P4RrAs7Tn7e+P21lbxo
X-Gm-Gg: AYBFou3c5mnZm2gW2t1Y1KsSrQaHXWj8cGVrtAZxtRatFkExbGMIB+xg1srE95YpMUK
	Q+reO2W+cm0R5Zr3lntBZqNgxuPERgVzrG44b6P6JkOWMgIVQXQDR5B14/hqdbEBmWlSTbxSyHl
	7RnqdYBg8+LW0InSoGsIocZ2JKfJyQUhT8LLbS8Q9T4HknTV7t40BbPvJ4dOwjEQWtT0R3VqI79
	YvnQf1TRrj9kknbtzc4N9TlOgKmX+uo6o6n2D/c1j6qt42LhfyszqlyvIJ/4a/Nvyac+l9O/7K/
	78atckkN2gsPsCOPmK3GnuNDBNuV/jcE9RXk+Teh8KNDLMbutoQb2DP1T9xh/yXaeT5V7zqrBoe
	4EVz6kMad6xsiMu2/Skiuq5x4rollDTNjLIGot3Fi5+Y=
X-Received: by 2002:a05:690e:4803:b0:671:1a7f:f74b with SMTP id
 956f58d0204a3-672d589763dmr497929d50.63.1790134420858; Tue, 22 Sep 2026
 20:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825044507.15217-1-kartikey406@gmail.com>
In-Reply-To: <20260825044507.15217-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 23 Sep 2026 09:03:29 +0530
X-Gm-Features: AcwNN1XofXYRTMqU_1H_lyfP_vGoaxCV2g_bNzhl8WkGKlgr3IVJFhwF945oSaA
Message-ID: <CADhLXY6uRUsNCiPdwd0q38_4jumdK0SdwpCjYewCRJq8QzwbkA@mail.gmail.com>
Subject: Re: [PATCH v2] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, daniel@iogearbox.net, andriin@fb.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:15=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> During fork(), perf_event_alloc() reads parent_event->prog locklessly
> which can race with concurrent detach clearing and freeing the prog via
> perf_event_free_bpf_handler() or perf_event_detach_bpf_prog(). This
> can result in a NULL pointer dereference or use-after-free in
> bpf_prog_inc().
>
> Fix by using READ_ONCE() to atomically read parent_event->prog into a
> local variable and bpf_prog_inc_not_zero() to safely increment the
> reference count only if the program is still alive. This handles both
> tracing and non-tracing event types without requiring any additional
> locking.
>
> Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2:
> - Drop bpf_event_mutex approach which was wrong for non-tracing events
>   as perf_event_free_bpf_handler() operates locklessly
> - Use READ_ONCE() + bpf_prog_inc_not_zero() instead which handles both
>   tracing and non-tracing event types safely without any lock
> - Remove extern bpf_event_mutex from perf_event.h (no longer needed)
> - Remove static removal from bpf_trace.c (no longer needed)
> ---
>  kernel/events/core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7..39755bfacc55 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13433,11 +13433,13 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>                 overflow_handler =3D parent_event->overflow_handler;
>                 context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -               if (parent_event->prog) {
> -                       struct bpf_prog *prog =3D parent_event->prog;
> -
> -                       bpf_prog_inc(prog);
> -                       event->prog =3D prog;
> +               struct bpf_prog *prog;
> +
> +               prog =3D READ_ONCE(parent_event->prog);
> +               if (prog) {
> +                       prog =3D bpf_prog_inc_not_zero(prog);
> +                       if (!IS_ERR(prog))
> +                               event->prog =3D prog;
>                 }
>  #endif
>         }
> --
> 2.43.0
>

Gentle Reminder. Please let me know the status of  this patch.

Thanks

Deepanshu
