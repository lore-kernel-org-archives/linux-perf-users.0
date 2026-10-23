Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792765970;
	b=u6toOAp9NtfZBJpjrgmgMArkHv92Q1/ZT4pkjGNRdvfu6jzGB95+6DPGDb/19hgr2Od3
	 6RFFQj/tjkFKLnVZlwnXSGTMLFRkGUOfKu3ImkdGKqmxQTMcahOoyN+FPiryVnZmQtX2T
	 M9jbRF2batQdbmFVvDljI8aVf233A3hD3lyE9tzOSJjsYE3xRtDZDE0VE9GPC+z1oBn1p
	 6zzKOidgJRS9Nx9JZ8Tn6lYSBClRrmyPYHAG/JH1leUlD7R09+QmlGIMuspKRCq4qi4/Y
	 VeoJD2eRJa+Ur9qzMbEo2TXZRdHW5IDVvdE/o/GUw1U2nLEhHgShvkXBG3ocBGg3X0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TW65mbXqWZmqBGg9YKq6hDH16N5mBPAA1Vl05PFK9vE=;
	b=mnUwT3AnrbcoP+eg5zCTruvxbEwhz0ZGQZDBOkJwTc1e7aJ5UdIbT0am2LMX5C35ceGi
	 ubmijXo1/mHveGVmhhEocHMVR7bdEGpCG61kC6POzmexxFd6nVKi9A7JveE2w2KAHmxLx
	 /kH4rJRzizdbGiSVLp5Jans3BDaVdE9ye/TtChgBKzQE79Ip5g/07ZCF4RUlhH4+EXWhw
	 3zQ5LowqdsKkNFzIV2bMpD4yXQcTWvKcfSK6r2vihG4wtI9OikfBxc6W+U46D4btnjTP6
	 HESh6Qzk28csCuoESu+SmBg63EbaHXQMBIlsqo8x20fGrrwgGUyPbIF/PERqpy+Z5wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=CW5cyxUg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFD606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 14:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CFFD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=CW5cyxUg
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso594090f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792765969; cv=none;
        d=google.com; s=arc-20260327;
        b=cMW4s3Xz2ZYNANsBIDsmBCua+WkM5atr3xrLjILcRAGjEq9zNXh99nGqcDPbZjmHjo
         NwlWOfgpjWhXO4KDAgi/jXv8Yjl6rWXng/CXOu+PL5SRkItGwQh7Z+gK962GRQVea/+B
         ZMrRZvhwnY/EtRILNygWf7tRgZVyzJMhC5sfJg70qLraBBw+gODiJ/wAqAveqXnUcETQ
         ygeACY4yXwXQfNJPyns0MAoIginAPC6GHV8/HRqDyqdhNuoNv8adqFMV14RlAEvUFT38
         28rkVZY/ud5XeBAqtFFvh4JtDZYpxDM/woZiska++/4kBvaaMuofo3xgdRjC+YmrLZBf
         pILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TW65mbXqWZmqBGg9YKq6hDH16N5mBPAA1Vl05PFK9vE=;
        fh=yu7BIuP+vE7F+YiJgPEMpO+hiwxFmUM9cp07eB6/MHg=;
        b=hNRglgnVz1rxyohxNEAGdBegzkaHWPLJaiUAf0DxZcXUZp4oNq3pGyYDhbsDcGFguG
         90FRYkpM5iemW/Hc0cgShLM0mBjstdS9iVwje0PIM7EbYuAR5NRq89rCSY6ehxkFAHNk
         rcPc5rRtRdDZMitrSlNlAOx1nTQLDydhOhk8wWqdD6GKT7N74uFN/fSN2AKgYQ87jGnL
         0rip298gLEi07cSbtXmij6YlvV7QoRvlI0htjVBBxeH9kplxz0nMed6FaoAP2c7m1U5d
         uLryJqqpoEVvXoI+sQ6fmBmWqRecEqBPJSfn8gs7ppNtVtjs5m3zAacNdGjsg/FGK7zv
         EnAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792765969; x=1793370769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TW65mbXqWZmqBGg9YKq6hDH16N5mBPAA1Vl05PFK9vE=;
        b=CW5cyxUg+YzOfqAB771Axxc/ZQTVjSG578tVeQcnVRNQ09Iq5D8wRMk7XCBbNqwTze
         c+GqhhqYmVr9O4rh5ahzaDLEE91O7LNidSYja0dIH5rDXm4I7hqiGPMpNq2Pud3fqVYH
         P04LsRuk8YYsDq12j5+3GeL86cfglQwa8N+pz6a7xVT5p7hXuWRtoPf9TjwNrlqOsPNq
         4td8UbhcXNL8xXvaa+8mMdESrk9uX3rAvoPoDES/4ClvkDRXwJn8qzC2K4zuHJyV2Mcf
         351b/JhZFi8ikhC9OIyYwFwbpwzqIeI0M+enYHZn+BtqHQokd6q7Jg4r3Q12rw/50iVi
         vC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765969; x=1793370769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TW65mbXqWZmqBGg9YKq6hDH16N5mBPAA1Vl05PFK9vE=;
        b=ckr8HtsDwHgWAUvkmZo5mEAt1QUTkLLVf4xvSAeHRPd+VX/HEDCmBZERJ3YhGyViLV
         38hVpmuVVrH+AaGOfVr5fKAel1hacIQ6YPOzfMl4+GqDdedwfansqn9Axmw9gjC8+ghQ
         q/OqXAI7rdVKHh6WXcpQIFQ8yJa3mwyJ3+Las4BzK07tBpo1GFNtl6SrhbtHR3XdGX3i
         9AA6AD98un720ZdgK75vS/ucOk2EpbmpTbDZb7P+peNuPGASFGpvKjgOHHazlbnmdgSC
         JNdipJPbTb2HKswHub5rqftXMOeGdTwE8CZyg6hp3SWZsAtpPatkTNfx9LrAv3jhtFX+
         +gmw==
X-Forwarded-Encrypted: i=1; AKwUvBw02q+Y2qyFpWRj5ecFkFZwTLpcSlrGZukTYQ0n3JNnJUyVX346c5OVhpJpLePqC7+G30jFzJToAVc2j2exckpO@vger.kernel.org
X-Gm-Message-State: AFq9FYKcfeqnABKr1sGGshiQH6dnDIj0tGyv1EI2RnNOjZtB/ag2P9Fm
	3MNpZmxkpiR2C+6gUSa3fJUV/CkMsFCFohsEVIzMswWQAMNh1+Mv1lukd2CVjsb4DoC+tAQdhEL
	foBq5ezmiq7X4GiXGON+Y2jTlZmlIBzEwWSMBIA+xbg==
X-Gm-Gg: AYBFou06RRW/S15WQ+krJSWbDJ/KF9zLKQ/PHCi8yfe4X+2TNBeghuHFJd8jKzb16w4
	tOuVX2XTbLC7vRHl4hqdHQKHYRnOf38JWkw/9pKp5XcrSCPPXe/Ivc2JkjqKT0vKUiN7sOZSyoJ
	a3L5Vr7grSW9JQSE2Z6hoUSnwUl0yVOUSBKA0MyKqHFVlxj28oGw2HNuoaIpcV2dwA+VPX2qn8k
	7Dt1srowq5MRRIySo/zm1phsHXV6PcZKNzfnAyubmZRTM8gQzRTpfsNcX2hQ6Nmd9n7sOIcw9lT
	k1kwnuOJRbaYSfIgI8oSieBMPs1e7mnYlbZA8yxCdryV4/dilw4UIUweqZnWxjuFSn4NlaUDMz+
	KN0j412LU4Y7gZCNwXIHxko29Q6O3ZDf9SdHiEhRMTUOdEy8Mka8+lxd4AW0oLXrIEG+m7f14Ad
	DXFxXTgwWJrzaSOHkM8S1Yp+/OzpoaUXRHh8q/f8oyjY/FGiJJMJqAdREn
X-Received: by 2002:a5d:5f86:0:b0:48c:6f3a:fe30 with SMTP id
 ffacd0b85a97d-48e3859dda4mr4501759f8f.15.1792765968503; Fri, 23 Oct 2026
 07:32:48 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com> <20260807-counter_delegation-v9-10-58658104e487@meta.com>
In-Reply-To: <20260807-counter_delegation-v9-10-58658104e487@meta.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 23 Oct 2026 20:02:35 +0530
X-Gm-Features: AclHuK-ELQwc782e_gNWzhlyxMyHtzq3L9uZbtZpWmLCC250qaSxVHzfJurC7sQ
Message-ID: <CAAhSdy0uq6AjzigiLSjTZEZ4JTOphcupx88Sf24kjBVDWB4new@mail.gmail.com>
Subject: Re: [PATCH v9 10/20] dt-bindings: riscv: add Counter delegation ISA
 extensions description
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
> Add description for the Smcdeleg/Ssccfg extension.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://patch.msgid.link/20260701-counter_delegation-v8-10-7909f863=
a645@meta.com
> Signed-off-by: Paul Walmsley <pjw@kernel.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  .../devicetree/bindings/riscv/extensions.yaml      | 41 ++++++++++++++++=
++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index eee65cf73d6c..24efd3e1cf8e 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -181,6 +181,13 @@ properties:
>              changes to interrupts as frozen at commit ccbddab ("Merge pu=
ll
>              request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
>
> +        - const: smcdeleg
> +          description: |
> +            The standard Smcdeleg machine-level extension for the machin=
e mode
> +            to delegate the hpmcounters to supervisor mode so that they =
are
> +            directly accessible in the supervisor mode as ratified in th=
e
> +            20240213 version of the privileged ISA specification.
> +
>          - const: smcntrpmf
>            description: |
>              The standard Smcntrpmf machine-level extension for the machi=
ne mode
> @@ -220,6 +227,14 @@ properties:
>              behavioural changes to interrupts as frozen at commit ccbdda=
b
>              ("Merge pull request #42 from riscv/jhauser-2023-RC4") of ri=
scv-aia.
>
> +        - const: ssccfg
> +          description: |
> +            The standard Ssccfg supervisor-level extension for configuri=
ng
> +            the delegated hpmcounters to be accessible directly in super=
visor
> +            mode as ratified in the 20240213 version of the privileged I=
SA
> +            specification. This extension depends on Sscsrind, Smcdeleg,=
 Zihpm,
> +            Zicntr extensions.
> +
>          - const: ssccptr
>            description: |
>              The standard Ssccptr extension for main memory (cacheability=
 and
> @@ -1135,6 +1150,32 @@ properties:
>              allOf:
>                - const: zilsd
>                - const: zca
> +      # Smcdeleg depends on Sscsrind, Zihpm, Zicntr
> +      - if:
> +          contains:
> +            const: smcdeleg
> +        then:
> +          allOf:
> +            - contains:
> +                const: sscsrind
> +            - contains:
> +                const: zihpm
> +            - contains:
> +                const: zicntr
> +      # Ssccfg depends on Smcdeleg, Sscsrind, Zihpm, Zicntr
> +      - if:
> +          contains:
> +            const: ssccfg
> +        then:
> +          allOf:
> +            - contains:
> +                const: smcdeleg
> +            - contains:
> +                const: sscsrind
> +            - contains:
> +                const: zihpm
> +            - contains:
> +                const: zicntr
>
>  allOf:
>    # Zcf extension does not exist on rv64
>
> --
> 2.53.0-Meta
>
