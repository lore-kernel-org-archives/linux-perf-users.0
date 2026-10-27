Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130756;
	b=A6nv7OR7QCfjMMGoh/lg0jab2X4Xx4Rj4Kk4HGGhgsU7BNYybXZpb7JV6r2X6RUyO14q
	 a+W8CfpNmeFTzsTKaAI5sYtxQSfrD0uPCqRnRC+a5dzsYNM9R03wj//sw+9N8CN/5aTjS
	 Ly8n6HwOfxRVLTeKEAfGESKLEkl6Tut8Gn9TmRM0CzmlAhiD9jgOIzQbIk2sTZyvqjVao
	 tMnI5p9ytf5sBWc4JPYoASoB8ULqO6EKirxQ9ZguQU0YpcaCB97dZ/aO3kAPB2QoMWgF7
	 EgEtQpEZy62f6RB6izGwcezvKJ9W6nuHQqXIb2vAchNS7n7CadbFdIs0QR9PJQDmKww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130756;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fj/41kyXVmvwyfVHkwSaPVRS80w5kPMmhzaFEoYT/ZQ=;
	b=Jr+VWYgF3iZ/FvJJ92beJkvtFH4Ctc75/ML4eoJfIE9wmAJU/quRk24R94rXLI3BUdYf
	 PA0/G77FPIE5ZJBggui44XSI9ed2/fmhwgPRE1bS9VllJLHbSq+dmkhlU4N7kX+q3AwTA
	 uY9j9xampiW2S7dfJQjyOdeXFxzft3BXP+NeGizzHCyxqHzG3v/jX34f9DClJMOuvvq1D
	 fetYHKolq/KnrKCb8hQ73ELoybGQ2qjx0iAisi9urGhu9KGrkNgWFDPBaZNKGOwdyjj0o
	 h2Fks+BYL9fCORXSqoym3M2tIC/hnZb6Lyca/8v4kPBRMfQiA+Zl8a6Hha+jvkAdtKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ETmjCydf;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JSAEve40;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56570606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 19:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56570606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ETmjCydf;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JSAEve40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793130755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj/41kyXVmvwyfVHkwSaPVRS80w5kPMmhzaFEoYT/ZQ=;
	b=ETmjCydfvdyy4pExGJNgjkBvNuhyLJZOVH8E5bZYJBaJW1y3Yax9kXwIeqFo+EyUQATyVP
	Ib+iasVEfsZ08YYADq1xbiZVI5c57jDYwjFB60N+9GlgLIODqgW3SyjIBJD7WlujTomRhj
	u1a+F3HRlqnN2g9+h7ohpwxPxNHi4Iw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-ERKEgcCxOYerSauGFQQ7cw-1; Tue, 27 Oct 2026 15:52:33 -0400
X-MC-Unique: ERKEgcCxOYerSauGFQQ7cw-1
X-Mimecast-MFC-AGG-ID: ERKEgcCxOYerSauGFQQ7cw_1793130752
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a4654add56so1455665e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 12:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793130752; cv=none;
        d=google.com; s=arc-20260327;
        b=IPNYLBYvOrx2wIDu0Mbil+ADpGsQBFjhVKeXJcpyuHcfdEriLFQyJGT3WseA/Dx8D5
         ZJAUvOzeCFVxYuD1qDn5f38dOPMQmbzQaCfDarYd/K9jds6p3LGj0uoXoXwgApdIrS2r
         QBwb2OYzFniCcyctOWFlNnVPLxLywddiCcdwP+SOERfdfwkwuyg+t+m424ghdfE9Rns9
         ihDPUdNksrK+wCsM1simMyLZIbi2XQB3Of3kyVQh84en63If+9uzKscM3hUKm+5LfpW9
         rNQHQj4K275LFJs6M4Tq/6sNmPIAowEyGs62l6mvV9dBRXXvsI3CBaOt2YaTP5n50St0
         9Phg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fj/41kyXVmvwyfVHkwSaPVRS80w5kPMmhzaFEoYT/ZQ=;
        fh=+AaKqoJmleBCGEZZPzPuEbYfN7Ht+ub/t1Nej2ohmGY=;
        b=Il4QQVlOytRDXf16wY7+wDXj4TiA0SYkiyhn3gKwy5o2ZhfBYnm7AO+lpd8tU0jiUe
         6lFiLWjP6+u7pS7D/hbmA74w7f2STmVVl6AIzGweun+tXAXHz+qf0UARNHMSNpjxAdjH
         vqyKRlRYeNKOsFWY0L09jjnJ4XXaHHK0jNHVE72Q6V5qPh7G5aVp1kmXELm1DqjjixeL
         FBl6IWpbc0OWsp3AG9DzcxT4DpWSd9mT5lZdULAvImTKw4e52b5bK9wt79gjgqDGnt2t
         MBMT2JT3eqAdgoGf7PTJ/T0OvV/DwCFdsUwKfD+HYCMEk7DFlOFI5XkC6h5hd5ddmOri
         OHww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793130752; x=1793735552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fj/41kyXVmvwyfVHkwSaPVRS80w5kPMmhzaFEoYT/ZQ=;
        b=JSAEve40tNCp1OgkTx0p1aGYMZkVty/Vg64c2AEuuH3IJ9A/9QT8zqfNTU3f21iXzZ
         ID510KAP3nk+La3t/D4e6X1LsLIyvHxlmvdoTAmExm1vSrmO1yHt+s4JF7RASdFul0LV
         cgjbZUJq3Ag5h9l8ZDo8f4GUA/McJ6FWVkXFA6Ehdvot5V7fCEdrqV1FhPcsNPVs3TST
         hgtAguQOdUVYw9wWj+UDsRYZbTW2HafsfkuyQJX8QATmLoQtU1jol6DYKfpjlyGV258w
         D5cblVPYMx/lcqsafE3jZQuODADCUijq4PFi3fRXgAg8bcGkqxk5IEs8gvuAFKbZAwEn
         8T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130752; x=1793735552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fj/41kyXVmvwyfVHkwSaPVRS80w5kPMmhzaFEoYT/ZQ=;
        b=BNCL9QLyEW7iV/hAnjhC3M5wnmX0DxvhsHHInFAiuMrBSPVInbdvZwLdP8P4jO6I0+
         LdcWEmB4tH9OSO3ffmLL2f48pUrZ/vHiPWfvApAtZBVbQe/8vwN6tkz4fSIarShCbLjB
         YuuUVXsW2HyAq1XBhmjlxAuL2Z/Y0XnagY31yo3IqHnBaN8YcOFVFEsZP1AGxmNaQ4B5
         SJF7qQRQb+o/Y1ckEC//Hcu4JmTyHxuv7dwBgaMtIYH95Zk+veoo91CLEjvUgPZrj7+H
         99/y4MNfslh5GVBgAQ1FUVodaOwR8Y99QwqTBRxVE29uuhIviBKuQkwgyXgLlN5pe02P
         Cc0w==
X-Forwarded-Encrypted: i=1; AKwUvBy24s+V7cJALesfl8UEBnk54YpukIPCSNzUDi03vTUNHs388iaUBgzsDwPYaNXudpbSK0Qh2EJIE2Nvxx1EBMDK@vger.kernel.org
X-Gm-Message-State: AFq9FYJyH0ecZR2N691rKbaQqoUFKjGALpMOowQDeWIRL3utBow7Axah
	jB4d/ufb2tkUF9N6eUylf1BZYvEMiXAVUM3t6nTWdAGboFVMWDVO6/U6JRxeEaGRFfa0QuYkfkj
	sC8kyJ8WA6dUDikyiBZBpvKCGoaz5uI0ojd6w2UYyEneUmHuehTrExYdV68lBjV++EqXhr+gxhA
	UZ5B73FuTclKy9o7lfZuyzLp0vdhw8t5j3aDY7oBE5usX01g==
X-Gm-Gg: AYBFou0+h5DvrXveStGZFU++6pUrnxde2gfEwYn8zzfZo4jfqSaPqdCoRmrWPz/+40k
	raoeKt+7q34XFePJgpc+h4kCL6/yjft12SGDcsIkJ8JhVamuTCHQc62tI/FyxdAlLOWYNe5Xly4
	Xb2/NbFzdWzxtx2E+IjTBuyzzGgOpK2MgL+7b4MWmCu6MHtuy+NidULTLCCK+H6qB7asM63B7JO
	vlC83EjcBNxhIZqBg==
X-Received: by 2002:a05:600c:c16b:b0:4a7:b304:253e with SMTP id 5b1f17b1804b1-4a7b30425cbmr77123865e9.22.1793130752199;
        Tue, 27 Oct 2026 12:52:32 -0700 (PDT)
X-Received: by 2002:a05:600c:c16b:b0:4a7:b304:253e with SMTP id
 5b1f17b1804b1-4a7b30425cbmr77123575e9.22.1793130751844; Tue, 27 Oct 2026
 12:52:31 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com> <20260930063919.608911-8-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260930063919.608911-8-himanshu.chauhan@oss.qualcomm.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 27 Oct 2026 15:52:20 -0400
X-Gm-Features: AclHuK8-hXL_DfAWcv7wadq_C65si-Ml2WAgbzPdgrocvKidGZ5VkAc-qEqFxfA
Message-ID: <CADRr4bctCf-7xBER1G2vqtQm2Nda+h222UzYShMQXw+rtBwPzA@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] perf tests: add noinline to __test_function
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	alex@ghiti.fr, aou@eecs.berkeley.edu, palmer@dabbelt.com, pjw@kernel.org, 
	qingfang.deng@linux.dev, shuah@kernel.org, thecharlesjenkins@gmail.com, 
	cp0613@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:40=E2=80=AFAM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> In the breakpoint signal handler test, a breakpoint is set on
> __test_function. Compiler may optimize and inline __test_function.
> This causes failure in the test.
>
> Add noinline to __test_function so that it is not inlined.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Reviewed-by: Jesse Taube <jtaubepe@redhat.com>

I would resend this to the perf list and not in a patch set as it is a
separate fix.

There is also another fix to data_breakpoint.c=E2=80=8E that i have been
meaning to send here:
https://github.com/Mr-Bossman/linux/commit/db4faa52a66f6b7265cd397a2d44d7d3=
8c3fdfb7

Thanks,
Jesse Taube
> ---
>  tools/perf/tests/bp_signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index f580ba7486b1..cc4a27224884 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -54,7 +54,7 @@ asm (
>         "ret\n"
>         ".popsection\n");
>  #else
> -static void __test_function(volatile long *ptr)
> +static noinline void __test_function(volatile long *ptr)
>  {
>         *ptr =3D 0x1234;
>  }
> --
> 2.43.0
>

