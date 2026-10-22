Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792691820;
	b=JswY0a5pBaBCXJceA9XNGApo3C0ZJxbVYWYw7NJHRoFW54GTU8WwgeU6bY77PMZrieVa
	 3Kmm8AASaLbbl4m6NTnu+bNDsBbWfKlbWZTYZIs/qjYCWtb3gxG1TyXd/eWxlDq1G/yGZ
	 jekHBJLVC4bw7pynC9NFhIweJnAwVHZgk0cJJ3QRetnxXZimQInhWx6w8NdXs+w+frOHa
	 QoM99mR79HIM6LLgn+WseGYzVV3xNR/23T7zAOnVHMFkp8Ne45pMo3jAw+Sx8lqwKftQe
	 xvKH93kcNm+PMuuAiX+ARM1Yee5z3gk93IUgLDnzKAnGYpahncYKai9e+PCPj+sFtLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
	b=vTQjVJdFnORcN8IX9JV3cu8z1gG+KbbhV4XY7/fMSeKxzN6PvhEYMvMgQ+AosUmFPBcE
	 mgaSANKx+Q/ph6vacRnzeEcg29EsBP1hXQrkZYtDk11ur5AYGHpw9zRcOuUg3a8iePNlv
	 IUjvWkm8gbrwhyV+zSqHPJoikD7/xm08ReGdO7BSN4g+TlFIa8jA0rQ0CS6iG8CEYK/ur
	 23f0pjXqfLjmFjzNb3ZB0cJhT1b2Y8L6s4g+R5sFn0aMiHNlGCslkQ7UCeq9ax6Ke5PRi
	 Z6e0HwaCvj/qXZdFNr4xLMgixPRaMTQdTh8OjTOlyK82UdNzRGCLUd90IYbDjliW8jQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YFdp+eNt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EE606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 17:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 247EE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YFdp+eNt
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8623790f8so6895ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 10:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691819; cv=none;
        d=google.com; s=arc-20260327;
        b=Mf5SYZFKa85m+j7EJV3DkvSGslsZyWQ9sDb5uAi2ny2mApYnVCij+XYxDZIgjD61kw
         7CtjImSW0Q2h8H3ww2Gv9iiU9ZAqXBD8Mvcz6TYD/ga8Hj2qRjYhOC1zk51Reivhc58K
         pmcrJIwkJio8YAQtPBcHnCuyDr5S7qdcPqh5UvSaEqvdbtFuEb+WE5yEBjTSgifVaLpY
         LlQQDmgFthSe/Culk8RZH11TagbvCZlOjedxMfRy2OTU05UqXnbYo4W+UqRjRhSUK76t
         0g/vWLin4EinEQqNRiiVPuW8y5XEy6jW3HRLjPSG2DVje4i5kpo67IAUt3k2tQhg457v
         KL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
        fh=0BXgFrglmgldCm/TJHfvgkPVK3A5BJ0t8dvGk4qXobI=;
        b=Q5nlXeCOUkY8cKjaDvGy9SZ0FRUZhU7q4yokHuCUdTdxUPuYm2oXaY2GsUA11OATfC
         QyOowF2eWQhqUBF5zACZkYDet9PPeBnl/DlkdOZR87yl3vQIevT3x/jGRfdgj7OVnNm6
         im1RlBEhYFds37QbN/nthdnf+15mfGlaPDDpWA4cioUZv0EMzlNXYzkB30eAd6PvVzfN
         kicrAmOPofJiu3WJvKxJ/AQ9JAxWc2sOdv8bu2i+d+fUQ9gp4Wt/RoTI4RvyQDYSiysj
         UFFxQvIE1RNJZuXBrjqfukES8yKXy3RFBtWVyoUGfsCxHtGNEhMTZHWmNCl4b70Rl5+n
         ZrwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792691819; x=1793296619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
        b=YFdp+eNtUuEUTvr6WJyWDSWbgr6375Hv/W+rTk2td6itbHuLtatk8TV3FBePVM7v0W
         +q+UbeyAt0FTXceQoOBjMY/Ttfd7dUv8kQJ8yreK2BjsATGe11z1rwVU5iXiMvJ3Dqg+
         9CVMbQvVQ+s09u+L4/Qu3i27gNo0YA03TQrfaezeGuyKv2F88/DFShOTND6gd0rdAtjo
         9OgISODKkk6HDUFhd6tONLgbIZKHIQ/LSOJPxFqDhy86TBHzPOEa0QWqIRCc/4wp5rla
         DJdBFgmSiM6TL4oYHtefgccGo7BRzxU0mdcGk/pGx1FgArFziiCHYZrSeVpxvNTcWRgI
         g6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691819; x=1793296619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
        b=001uz1V8fsZA0fKDdAiVWw/sZTrP2aa8pbsywd+K/SK2ocmcREa5CY3kdD3xSGBVBx
         7b2G2jfBNIueWHyjgPrlv11PruKj8zUzAxC0jhrJBXKEYnDCsaUTdwuv6MySDc5XdAn2
         P9AgODLGUACaNIyp4/7ZMRcTqmt18nTMIWAMfEt8XE39iuN9hz2mSnGXkdEprO2NRVnP
         2K/OW3G96fovJduoc7in9dNOXHiqDQpZZbe5nZHe0DNVCHOTUNUwviy3FyMQn8iBTx/v
         c/5RO9Z1JVSKy3H4tz1XostjEpeunXNCDWovqxlElAPw7ZZ0x67LOqap9/U5j4CcIzRe
         FrHw==
X-Forwarded-Encrypted: i=1; AKwUvBzyQsZ1F10Ml7lYoX+g4FQ+6uIrwQ+/Wi598NhrIWIwqGZyzYFrG7rjwcQLwgu/OCsAbqnhNyZelXwtwoQ50OeH@vger.kernel.org
X-Gm-Message-State: AFq9FYIgIJXEW7Zxi/WSLA4E8DEqrhZOcsFfNsoS4lzJnl7UJbbZsG93
	AwoiMHwuPP0rxdlWkQ4H3CHZP0xCizwDZvnfHCpB0iAHFfaF4xZ0temipwUxui2hWKRYX0sCtbb
	9qnlPMa9t7bczpGzyLNFb0BIdB3U0kSM2c8MewqdD
X-Gm-Gg: AYBFou19S1iCns1bFWs5FhpqiAK69kIQlrwVDVJkS7S/uxQp+NkDDLOStbsmt0dtPY+
	P+cnOmsmWqlOxu8g/13md+M8egEFloeD1Epx+SI4P+9RvDVd7h4aWGepghiQJ6Cjf6scBgsklmX
	moKP4aTkOBtSyS3Rwxwpcu/f/NNCAGdMG4vAnvnDkj7R4qA/mowLxV3caWy9tMHOYOOtZEDZ0XW
	9n6GWZfYVAnqNV46fkioq4ewMFBqLL+PfUW66kwsYRKEUyXpNoMqtuolbBqKi/kWnODaebR5E1r
	MJKFgdAKsQtxUgpFxUqyQh9/ZWa+BFWKIXgpv8sXcBegISUDj4F/F9UfjmndMDDODHE4HBdw4mE
	89DoERKYXydTxatIWRwPXK3bYbnvDxwHDOFlSOWrtfBZTcpRhB1gOHOfoZ6P18EQdmzKsr8TtdM
	9OgJqAKhivt2h4bobJathRkw==
X-Received: by 2002:a17:902:cece:b0:2dd:3a08:d47b with SMTP id
 d9443c01a7336-2ea7c856829mr195125ad.13.1792691818910; Thu, 22 Oct 2026
 10:56:58 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Oct 2026 19:56:22 +0200
X-Gm-Features: AclHuK-YCNtnPegYnn9KvUKugGxObkR7MWrtu-3qSRj9_sjY2T5TwF4c4QpzRSk
Message-ID: <CAG48ez0cG532aaXZF_asCDk+fsnQmE9L5PA9T+JN6OGdx6yjGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized
 probe can't be written
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
	mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, 
	liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, 
	vbabka@kernel.org, hughd@google.com, kees@kernel.org, mingo@redhat.com, 
	tglx@kernel.org, x86@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> @@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprob=
e *auprobe, struct mm_struct
>         if (IS_ERR(tramp))
>                 return PTR_ERR(tramp);
>         ret =3D swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
> -       if (WARN_ON_ONCE(ret) && new_mapping)
> +       if (ret && new_mapping)
>                 WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NU=
LL));

Not an issue with your patch, just FYI regarding this preexisting
WARN_ON_ONCE():
A failing small GFP_KERNEL allocation could theoretically cause
do_munmap() to fail; the VMA tree has the ugly quirk that you can't
reliably _remove_ elements without memory allocation.
