Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23ED24169D
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 03:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348263; cv=none; b=W4EZu+tM7mTVYq9F/14t1ADWFU6SPUZO5MyWdTvB5Z4bvFCv8QXdii6RCtp7tcqg10VuFB4CxbBkplftQCLhv2GtQTv8nWY82Cr/XM/hCpn90TF85wHZ8ektCazmnb4D2IFKtpNd9NPlnJBmIA+/IXPzUYEJke8YdSGVfvFbkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348263; c=relaxed/simple;
	bh=G1a1o/nTQ48p1txPounVZt/V7RsVWpfUvP9iThXsVDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5BLmMce/ITYnX5XlszqSdeX+EUl+/kxg6vDJIurBsE9aEb3v0heONtg1uwGz+pRmOCBJ3sRRQSDwujD2jCoKxxA6LgtnCYGhQ4REH6xC0qC8nEKiBqQlEmRgIBd75ChsSZ/zt5u3UTPLC4ZG35GWHNTMXiEKiCMIfx3Lvk1VRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.128.169])
	by gateway (Coremail) with SMTP id _____8AxX+ueLvBpSZ8EAA--.15582S3;
	Tue, 28 Apr 2026 11:50:55 +0800 (CST)
Received: from mail-yw1-f169.google.com (unknown [209.85.128.169])
	by front1 (Coremail) with SMTP id qMiowJBxZcCdLvBpEkh2AA--.43359S2;
	Tue, 28 Apr 2026 11:50:54 +0800 (CST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-793fdbb8d3aso115541937b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 20:50:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9unKXCnnVSVYi55FSbaKQY0mY4cde8XXZUwClwETkd6fwWIrRxjTmHLXL6NHabsWQUE5/LR1Zs/UyQzEd4IzT0@vger.kernel.org
X-Gm-Message-State: AOJu0YyItjF/F+ZVADdnILSqU588kRh1IGwVXbVxBUaDZxbG325QKfy5
	/iCUJ24zNig35kJZnmEZtWNDitsElrJpWc4JkDy1wOiFKF8wH7NKOAs/jYZZ6nJbdHXc7wVg/h/
	t0fxIYCIIme5P9ZfBLk2yBqRo/zAFcacPMxjbMPbcsQ==
X-Received: by 2002:a05:690e:441c:b0:654:6ccc:69e9 with SMTP id
 956f58d0204a3-65beee9b8b9mr824243d50.51.1777348251997; Mon, 27 Apr 2026
 20:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423103530.3938202-1-frankljpliu@gmail.com>
In-Reply-To: <20260423103530.3938202-1-frankljpliu@gmail.com>
From: WANG Rui <wangrui@loongson.cn>
Date: Tue, 28 Apr 2026 11:50:41 +0800
X-Gmail-Original-Message-ID: <CAHirt9hJ5tTnWhYFZM6TvaTyDxGcRa=zeta8iv0DqqxgfKUQFA@mail.gmail.com>
X-Gm-Features: AVHnY4LNskmyUjODjQsEi38Q3wSyroi5G5f_R-KINhizv72UeIcou8FjuJ5rz2w
Message-ID: <CAHirt9hJ5tTnWhYFZM6TvaTyDxGcRa=zeta8iv0DqqxgfKUQFA@mail.gmail.com>
Subject: Re: [PATCH v2] perf annotate: Fix NULL pointer dereference in loongarch_call__parse
To: Jianping Liu <frankljpliu@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, wangming01@loongson.cn, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jianping Liu <frankjpliu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:qMiowJBxZcCdLvBpEkh2AA--.43359S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw4ktry5tFW7trWxJFyfKrX_yoW5Cw48p3
	4DC34UKr43GrWFka9xtFWrXr15Kr43WayxK3WSywn09Fs3ZF13JF97Kay2kF4DAFs5Gw1U
	ZFsYvrWUJFW5GacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==

On Thu, Apr 23, 2026 at 6:35=E2=80=AFPM Jianping Liu <frankljpliu@gmail.com=
> wrote:
>
> From: Jianping Liu <frankjpliu@tencent.com>
>
> loongarch_call__parse() dereferences the return value of strchr()
> without NULL check:
>
>   name =3D strchr(endptr, '<');
>   name++;
>
> When objdump output for a 'bl' (branch-and-link) instruction does not
> contain a symbol name delimited by '<' and '>' (e.g., when the call
> target has no associated symbol), strchr() returns NULL, and the
> subsequent name++ produces a wild pointer (0x1). This leads to a
> segmentation fault when strchr() is later called with this invalid
> pointer:
>
>   #0  __strchr_lasx () from /lib64/libc.so.6
>   #1  loongarch_call__parse () at arch/loongarch/annotate/instructions.c:=
29
>   #2  disasm_line__init_ins () at util/annotate.c:1205
>   ...
>
> The objdump line triggering the crash looks like:
>
>   bl              98824   # 0x9000000000641ea0
>
> Note the absence of "<function_name>" after the address.
>
> Rather than aborting parse with -1 (which would clear dl->ins.ops and
> lose the is_call attribute, preventing the TUI from drawing branch
> arrows and navigating the call), follow the same pattern as the generic
> call__parse() in util/disasm.c: when the symbol name is absent, jump to
> the address-based symbol lookup so that ops->target.sym can still be
> resolved via maps__find_ams() using the already-parsed target address.
> This preserves is_call semantics and keeps TUI navigation working.
>
> ---
> Changes from v1:
> - Instead of returning -1 when the '<sym>' token is absent jump to the
>   address-based symbol lookup so that maps__find_ams() can still resolve
>   ops->target.sym from the already parsed target address.
>
> - Link to v1: https://lore.kernel.org/all/20260423053102.3717015-1-frankl=
jpliu@gmail.com/
> ---
>
> Fixes: 4ca0d340ce20 ("perf annotate: Fix instruction association and pars=
ing for LoongArch")
> Signed-off-by: Jianping Liu <frankjpliu@tencent.com>
> Reviewed-by: Ming Wang <wangming01@loongson.cn>

Tested-by: WANG Rui <wangrui@loongson.cn>

Thanks,
Rui

> ---
>  tools/perf/util/annotate-arch/annotate-loongarch.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/p=
erf/util/annotate-arch/annotate-loongarch.c
> index c2addca77320..a949b4392dd4 100644
> --- a/tools/perf/util/annotate-arch/annotate-loongarch.c
> +++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
> @@ -29,6 +29,9 @@ static int loongarch_call__parse(const struct arch *arc=
h, struct ins_operands *o
>         ops->target.addr =3D strtoull(c, &endptr, 16);
>
>         name =3D strchr(endptr, '<');
> +       if (name =3D=3D NULL)
> +               goto find_target;
> +
>         name++;
>
>         if (arch->objdump.skip_functions_char &&
> @@ -46,6 +49,7 @@ static int loongarch_call__parse(const struct arch *arc=
h, struct ins_operands *o
>         if (ops->target.name =3D=3D NULL)
>                 return -1;
>
> +find_target:
>         target =3D (struct addr_map_symbol) {
>                 .ms =3D { .map =3D map__get(map), },
>                 .addr =3D map__objdump_2mem(map, ops->target.addr),
> --
> 2.43.7

