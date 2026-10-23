Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792765965;
	b=hQNEe/wUMSIXQXxdsKbGUFNLWRvvYyLSuj2SX1wQM6v/1H9kUsJThgbZwVSgcB2ZfEGf
	 ZvqPm6Id4eAUNRMUZjiJd/55isOFQtUspygnTpQjdWIRmd30WlI2TGMiiI3UKjxiqsHnW
	 WIsxZuC2tEfweKCrQYFUUnKiU4YENquWaruRWBPdM/GfTp93ygjQodM7GeYNKD+22TqGl
	 3C/gob48+kJlZeI9V0I0ahnEKHgGIcICIfbzf+CwQV33if77DsxAqBF1Y80i2x97fQvCR
	 t2qkyCzbtIzptDTaiCH8aAbGlTyFuoL3nKzxlvSdi1wNczoJRAocUTg//tk+7S3yotg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hRGGWRPBVtDZAA4r/kbSByT0vap6yffQdK6YCq0N6Tk=;
	b=eYd1k9SOLFrCM2Q0m9GA2y+R2jR7FbyUk4PwqDw6r4F6+IgnbYoNHzQRXzSzZmSF3WPb
	 auhD0WdYvQGCAlHFQP/MOEdfcfB2KfbsBJ2ZhrW0lnwMxSsg6sDSbF7GB4RwasnPp7zFf
	 5WLR5hfcgJUICt2ezNQu8tJ9HQQtE/N9nCVL8xf6izgcSvH1EbF5z23Yoo9GTYkAXgc37
	 e9zpLMBw53mNcu77Bvx36Rj14J1vLCZs/08ojdKlaJWnSvCNytOqh9cUUMsXHYA9x2Hr/
	 WI+5e8tdM+ZIHDjsZBErIwJV1xJ8luyI5Gqe1vw7brJ1T6uRVZu+jDNZDmeefvU78MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=fMoP0H2Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C4606A31D
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 14:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 810C4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=fMoP0H2Q
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df8fe8513so861149f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792765964; cv=none;
        d=google.com; s=arc-20260327;
        b=YuleBJsQgy6tA+dWo6swGyTBygljBvticMg1njp1rZIy40aqHGKEpg95VhMLOCzzzE
         5ZSOKwAQRWHIUsivxCraj30ZLufX7UCEOkjck8BvSiPLjfhDbtWUnz0MulyCfvSkipRN
         gdzfCv9TlTGJ6LGQRf873+puhfzMH+OzG144NnY6po3zk6c6vReapFz1J+knoUXUztd5
         U3f9xSweFhoEhvm4vZ7SheqWHrLiy+oxWUHcJb5aUsLlpjBcShS7aNKncw9Nzanvkxx2
         hn3aSRf30tvaKpAgEakjgZfwrjJvvDdJNlHaZE88ci6HhJpar8KHpKp9Y9dhZO1nlpGh
         zPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hRGGWRPBVtDZAA4r/kbSByT0vap6yffQdK6YCq0N6Tk=;
        fh=cIprfkwn7YrHIwb4w2JhAapMZjwNuwC/DSTEw9/Y1DQ=;
        b=rXQMpqpBvMjAvI6LURszvMKJ0pkbL1FPuEklsVb3j+iW7GSQM0cG0mvu3dpTGlQwBo
         gynJvips3XH3WeobT91fsfAim1lwTTY4duOeNfasyTRo0v1WB9EG4g+Yr2l4ONUfDe/R
         i1+yqKR74la2Q4jOTkm+B6v7SXDPgcVx7hkBN3B3yNctkUTjFL7uBoqMG5LLCiRnit+J
         2bV4E2a9I7EdjcB3CasAYM5EKYO8xA3uoKRfzFRY4osfz4l3+pQTlZXbeNPxItz/dHFM
         el2HKjhQEfmmvIO4xPDZJq5C6RXAS8IYowsVpFvjyUKpodngVP1k+4213OUGAQuA+cjz
         wRQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792765964; x=1793370764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hRGGWRPBVtDZAA4r/kbSByT0vap6yffQdK6YCq0N6Tk=;
        b=fMoP0H2QKNpHGwuXAjxXuJcMZCnKegravDJQMVUHj9yyTWYdJWfi9RH5cgT/8IHBbw
         JH6R9bCShRqKMC1Xob78FUMdD9csZTPK3lnGW0TYplitrpeiH7/KMMf9vfaqtnrvs8HP
         mPxghVDeslu8gQ2L2t/dCSC1zClcjLn43t+UAGSS6/08juUKCRru7PnXvfVrJS9h2ggx
         5ZOmrbd6bsKgliAl/0viwgvGzIdQcYsLGb46QDW/UW5MMdzxrh7KrLydWGLMitHj5kU/
         mCWWPdnrvcVolsZsFjnXRKXlBF1/dwvz3/vSJYMtJbPxvnZuz3NlmoiIO66VEPwmhFKf
         5+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765964; x=1793370764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRGGWRPBVtDZAA4r/kbSByT0vap6yffQdK6YCq0N6Tk=;
        b=wb6vpWXElQxzDauhuFVKaqYF2LWP/kKGZmRZZenaFFE7+I0ufnkKrIqquB78z3mzLx
         nF0JalPo8aC6WtQ+5dXvR9ZU/PTnJ1dlVP2acIb/F6c09cQ9+zRNZbDkXvi3Y4wFnd0j
         44EBGhiPRUOElkJfHAoUM1ciY9jA8PWXIQu37aFuxn2wAhKshCcDVhwO7gMbOa3wZGxX
         cla4JH8NA8loq9BYoFEYkaC4mC8hdt2x7jYQmTZ/UsbbTXVuRQS7kBXB6MGq8G5ajWTU
         tRZpWkmbsbS7dCvtLbeT2IlpKYGK5VxkiRAHtwEzN3S5IsT1FufQEfIlmyqPbuDeIJ1N
         2cdg==
X-Forwarded-Encrypted: i=1; AKwUvBwVoi+JeBhxoLod/JNnkJWrj8ZQSk04a5fcsAIdptUW6gMpFYg8HZrYGdZ1Wsbc5KiGJLvVYaA8wy6C2q7AF1CZ@vger.kernel.org
X-Gm-Message-State: AFq9FYKxkpj6B0lXT5Tdnj8C8QwlKJjB8Yf8/Bd2vR9hWC9iXO+JZN2B
	m9lqQu2pJVwdvhhB6QBQ10mMWdWJHNm+T78EXpzLkih4Qp0AJpIoRlppUpYqQu2t1uYruj6+GDs
	Z+S3p2qkfshV0GX2sUoucgiofBzsJkESy0yteftCcNg==
X-Gm-Gg: AYBFou0irHKegUtr1VshwyqCk++9hkVXHjD0RX31QaNZlDuzE0mS6/lqYvxeCh0anUw
	/7nosghukyY2aq9f7+JtIpbgpE3HSmmdgfSHqEgIfiY+CdPOn6d9qZkkSpS1M/YKY3OSZeeH7Lt
	N1k1uqjdJn4UfGU7mDI2qGArvNQRUkym1U4dQQxBRBEPt6KEHO0NyRNGa/XnNr3mxmGbQLYEbYy
	zs84EnDUOa6wucUBnu12ImPGxxmiBpMLeuCQPmyMa39uuIZmH23smbust0/B53ajQuu755sTCbl
	wpgQDpmv8yeJTTnMpeOwyLpdEjkAtnXl1mNoCFuq3dItJ1nUaFT5LQ9PDSuk9wfF3ClsfZLTbY5
	/dS6hSMR38PEpdZ3Vr6nWe5t52xB3axBrhiHrzh7NlqNdTH2vqO5+bbCuvWNeZHj1M8ui5g8QNC
	rtjgaqUwSZr1a5on8AtvKmLi0k0ACKQZ/nPdvnIezS2FYqNgpdncqdwxZE
X-Received: by 2002:a05:6000:98d:b0:48c:7ee3:e07d with SMTP id
 ffacd0b85a97d-48e385bfc42mr3907352f8f.52.1792765963409; Fri, 23 Oct 2026
 07:32:43 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com> <20260807-counter_delegation-v9-4-58658104e487@meta.com>
In-Reply-To: <20260807-counter_delegation-v9-4-58658104e487@meta.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 23 Oct 2026 20:02:30 +0530
X-Gm-Features: AclHuK_j5l_mLkVqrJqA4yovkMFdDFBB6LDPnRF9bN2ny94R09y2JYZPHifdEPA
Message-ID: <CAAhSdy3rxvq4X=AFx8ps9dSwKR6Rw6M7m8ra9PEbV42tH9o8Vg@mail.gmail.com>
Subject: Re: [PATCH v9 04/20] dt-bindings: riscv: add Smcsrind and Sscsrind
 ISA extension descriptions
To: Atish Patra <atish.patra@linux.dev>
Cc: Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Rob Herring <robh@kernel.org>, Paul Walmsley <pjw@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 1:39=E2=80=AFPM Atish Patra <atish.patra@linux.dev> =
wrote:
>
> From: Atish Patra <atishp@rivosinc.com>
>
> Add the S[m|s]csrind ISA extension description.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Link: https://patch.msgid.link/20260701-counter_delegation-v8-4-7909f863a=
645@meta.com
> [pjw@kernel.org: use official extension names in the patch description]
> Signed-off-by: Paul Walmsley <pjw@kernel.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 16 +++++++++++=
+++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 5ffc40d599c0..ccff2be1224d 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -181,6 +181,14 @@ properties:
>              changes to interrupts as frozen at commit ccbddab ("Merge pu=
ll
>              request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
>
> +        - const: smcsrind
> +          description: |
> +            The standard Smcsrind machine-level extension extends the
> +            indirect CSR access mechanism defined by the Smaia extension=
. This
> +            extension allows other ISA extensions to use indirect CSR ac=
cess
> +            mechanism in M-mode as ratified in the 20240326 version of t=
he
> +            privileged ISA specification.
> +
>          - const: smmpm
>            description: |
>              The standard Smmpm extension for M-mode pointer masking as
> @@ -226,6 +234,14 @@ properties:
>              Profiles Version 1.0, with commit b1d806605f87 ("Updated to
>              ratified state.")
>
> +        - const: sscsrind
> +          description: |
> +            The standard Sscsrind supervisor-level extension extends the
> +            indirect CSR access mechanism defined by the Ssaia extension=
. This
> +            extension allows other ISA extensions to use indirect CSR ac=
cess
> +            mechanism in S-mode as ratified in the 20240326 version of t=
he
> +            privileged ISA specification.
> +
>          - const: ssnpm
>            description: |
>              The standard Ssnpm extension for next-mode pointer masking a=
s
>
> --
> 2.53.0-Meta
>
