Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA64B5126
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509626; cv=pass; b=BXPwA1sSA2dZyNZ8tautDgSUAjuG1YbjfEE6vfOS4sKmGzh7yn4OiD6EylG9MEuvPlxB+zilVInYNJHXgWYclUHVRSww0w0WRWeXhJFaS7UqdDEB05oC69xizGXh/GZrHC3RW7QavOG9aZkC3Q1RAIDdRkJtVSa8AEnUlRdqc2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509626; c=relaxed/simple;
	bh=wH5LJR6TlmCk+qbJi19YUi6enxT35UK1p41mfRG0Ut4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8zFpMH+xk8Y9hVQhJY4OMVIJwQI3sQ9QmJAJFsf86/iVvu9ApSSWBuc/TglQs6nbm4AM7yXoIdokdWHupipE2zGX8Y4+Ou/D/YZRB2HJCFABrHOIwc2U0wwrLbDOfoQ65P1cJh5in7oCQaTPoM7JHWw5Wm5F/bJsryPwXHH+x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3X1zZbh; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3X1zZbh"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so41431cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 15:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789509624; cv=none;
        d=google.com; s=arc-20260327;
        b=PSvxUQgtmT+iemK9NeCNZzsNSKzmieHn2Y7b8WITHJT2mpSv0/6oNMVSnyvjL9AFhP
         nFwbAAwLoKhyyzu+xzvOrCk0f0AZ/vcDDYXOBthypGxi6bsMmy0r3+7sbQwyh+dg/Juq
         WPJs4HMgV4sPcHZTGj4i2tqtLJhUROWQmuo5UTbgAWQpMYri5lBSVkFZEUYa5ut8w0dH
         AQhyZNipUWaz26okRYL3UtzBeuSzrMiQK5/j8OfrSHTkQev0Ux6Eti4eh+S8iBZ78qxc
         NF1y6prlnXc8LN+qqEoAVw5lvNMwJMwW4FkAONGXMLpslVGhZbapavKzJZtPakC5fbTT
         ZJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o2jc9OEJth/4OrOLjeAUE2KdsM1LqbT26U3xvMipXho=;
        fh=/+IcdfTVmj1rJUOYD/I2BJeV6PB6n2cRUGXKFWYCxWE=;
        b=X1iZqwWpukdxQ0ka9GFF1XGHOBlRjxoKVx8HH1efBkp24h4h4aGqWu7ghBlOMmIigg
         epj4brzS/kyJdqHLSHYa4/B44bCIHZWgJImIpWwiISPtRJI9gVUmkXbT4G9ERtbllhXU
         P14rRknazcVwmJSld9KMQ4Iub8/IvXwt4lvStbAfU1YUgQaqp0Ohkcq0JbH5YOirc/ip
         KmPYyTdqnNKo3OOmZWaRKyjOm3iWDAxOBM/CYy3jfRI5CU/7oJf/AZYREg7na6lo5gWb
         SlFWELO1r6766XdIuHMj3ISNxebtgSc/Rn4eLHK/pYBFzFhwkh2VPLesV7oOW6CbrkZ9
         lJLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789509624; x=1790114424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o2jc9OEJth/4OrOLjeAUE2KdsM1LqbT26U3xvMipXho=;
        b=n3X1zZbh+NYn2rFRaO9qq57FXUJJMss1Wk37r81d59op5elLMhUGr2V5T/XO/VueRU
         bri4VJd6MABGewy97qAXXDALowmhvNLoDycMzvr0YtmdY1qmn6X27ROD+jQaU25fUfoj
         Xb8XxOM9HIkqs08UzZDsq1rRZfaWG2gbvlQJX/cVrZIWvvt26BHgZYtZ+kivZ/zDRs2b
         gu5LoEKjlRIg6KkOUbuzpHLAMrMp2QLkofC5fB/3N1KpqnqY2y2aXy0xKkMCv+C2S/bf
         xHHQHzhoiN2Z/pHPTkdtHte/ljybhDtgtnoHL0ltFj/VLT4KvhJpox2CyPHLmjfZw3Ui
         r9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789509624; x=1790114424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2jc9OEJth/4OrOLjeAUE2KdsM1LqbT26U3xvMipXho=;
        b=kjujJPqvV1ta4/9tmB8DfY0iNWhlhFjjvQzrIkMHvzrLNJYsva2AtdZc25jO27AnBP
         lMifsrZAwqFrwFN2A0zjBcKGm2TqeqWK1h+vDvJkhqCAmn4lEqv4Edwn/5C8rXhQ1flf
         CqURtNbflUv+i0cl1HVw1UrrJnJ2DzVKOizHe2OrGoRwWaZQwqFGMHxa4NFB37zTUXIK
         iIktJ6IijFD9NZqoHRMSRZofr3CblqsFFfBMNSEWXnj6X8xFCYG37QVUKTAeXhZz/Fke
         tvg4cfEleyKPFzyonmPFd7Y7wsXMB7kbOI7+1akQUWgZr2WmHIBI0CNmqSRegXUmkMWI
         1LkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXEyQza6vdtBfklfK0qhMjiEAgpppVV5U2SOS5HsPCQoz1OeVpeF6Ienou/Y3aYaFpLW/sdqOExlguoWTxITTF@vger.kernel.org
X-Gm-Message-State: AFuF++npExcssWnTioKslm4qz5uaRl8OTn2uFBN+xmNiC0iV9zPGccu8
	oQq0ErRkdZm5oFpfaW4Z9pkBuE/U/hiufPjTGJprh1umos/p2x2UJ1fgX8q919WDCTmMGIehwP8
	p0SGmsK4xFvXVDyTXMoqGa7f9Zr2dcbfak6rvpkLU
X-Gm-Gg: AYBFou3V4ems/CJfrwCo/ZfSTquqGwmOklgF2u1pBh5sJe6yrFxFgMB8E3lIjqKyAIx
	icumR8hIxZ5JVv7UfI0oUlTXi7ayUt9iAV46gpmS0eBjnUmwCFtNtxqj+LdxVS2HfTwiZyd3OQp
	HH49q5B9eZv4r8cDttcunpPgQMLQ9ANcAXRULSDynG+kCZF6K5VDlN8XSm7VL0Bs7uJ6MPqVzfJ
	VHaL9GgxGFp8xV1fMK+9sxkafljfZF4bhOqpd9CfD+WhZ00kWzHZJXVg3QCaZOvGyJfbbUd+HB9
	e7q67ux6cRK0U9vruRfQBVyzOUc0O7O/hqK4+K5TwM8TOgDyLz20tWpFC3AVcSV5wzv5uj7xsiH
	EOYuoMrmzAA==
X-Received: by 2002:a05:622a:1212:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-5325083be4cmr5274861cf.8.1789509623046; Tue, 15 Sep 2026
 15:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022184230.124113-1-i.shihao.999@gmail.com>
In-Reply-To: <20251022184230.124113-1-i.shihao.999@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:00:11 -0700
X-Gm-Features: AcwNN1VZJ1Hfhs1GOqIzTibv54fw42fzGNLX_brDRt-V--PnBc7MUgUUDwbsBsc
Message-ID: <CAP-5=fU8NcQKS=aMVDg8KoRbdeqwkrp=r_WncUkCf3PWYWcYDw@mail.gmail.com>
Subject: Re: [PATCH] _x86: intel: pt: fix potential null dereferences
To: Shi Hao <i.shihao.999@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, x86@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hpa@zytor.com, 
	Smatch static checker <smatch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:45=E2=80=AFAM Shi Hao <i.shihao.999@gmail.com> w=
rote:
>
> Add checks to prevent potential null dereferences of buf->stop_te
> and buf->intr_te in pt_buffer_reset_markers function.
>
> Smatch reported possible null dereferences of buf->stop_te and
> buf->intr_te in the pt_buffer_reset_markers() and when i checked
> both pointers were checked for null dereferences in earlier lines
> however,after calling pt_topa_entry_for_page() where its return
> value is NULL in certain conditions there were no checks for further
> buf->stop_te and buf->intr_te uses which could potentially be null
> dereferenced.
>
> To avoid null dereference add checks after each pt_topa_entry_for_page()
> call to safely handle null returns and also add checks where there was
> direct dereference of the pointers.
>
> Reported-by: Smatch static checker <smatch@kernel.org>
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>

The addition of null checks to make smatch happy lgtm. Dapeng, could
you take a look?

Thanks,
Ian

> ---
>  arch/x86/events/intel/pt.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index e8cf29d2b10c..2b7d5d118b48 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -1148,7 +1148,8 @@ static int pt_buffer_reset_markers(struct pt_buffer=
 *buf,
>         if (idx !=3D buf->stop_pos) {
>                 buf->stop_pos =3D idx;
>                 buf->stop_te =3D pt_topa_entry_for_page(buf, idx);
> -               buf->stop_te =3D pt_topa_prev_entry(buf, buf->stop_te);
> +               if (buf->stop_te)
> +                       buf->stop_te =3D pt_topa_prev_entry(buf, buf->sto=
p_te);
>         }
>
>         wakeup =3D handle->wakeup >> PAGE_SHIFT;
> @@ -1162,12 +1163,16 @@ static int pt_buffer_reset_markers(struct pt_buff=
er *buf,
>         if (idx !=3D buf->intr_pos) {
>                 buf->intr_pos =3D idx;
>                 buf->intr_te =3D pt_topa_entry_for_page(buf, idx);
> -               buf->intr_te =3D pt_topa_prev_entry(buf, buf->intr_te);
> +               if (buf->intr_te)
> +                       buf->intr_te =3D pt_topa_prev_entry(buf, buf->int=
r_te);
>         }
>
> -       buf->stop_te->stop =3D 1;
> -       buf->stop_te->intr =3D 1;
> -       buf->intr_te->intr =3D 1;
> +       if (buf->stop_te) {
> +               buf->stop_te->stop =3D 1;
> +               buf->stop_te->intr =3D 1;
> +       }
> +       if (buf->intr_te)
> +               buf->intr_te->intr =3D 1;
>
>         return 0;
>  }
> --
> 2.51.0
>
>
