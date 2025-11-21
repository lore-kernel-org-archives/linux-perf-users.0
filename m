Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96FC2F99B8
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713447; cv=none; b=QChv711O1CcrbKMyQu8cjYR/avCIj16m3OLD+7QgKUm7yO6PKHwjw6hXDoHQclV9JbVUwTidvuuR1pPHRgG6OfNzeHN9K4RWJzhkJxqOiO3uvmsJrOSBXeaprK4z+4IQE6tl5RvTxYaz5NharrhQBExnjKu+5oQWgAc+wLehpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713447; c=relaxed/simple;
	bh=HDm+cQ3E57Rw/aW22/2o/8DFD56OTcZLebchCcKA30k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWQsnC5eJ5NdrWteTeTPPMpQ+idIXXr6Rw9Lt7FlXaWXuCKTgwR55KJgsqCi8X52/PJwMxri90jYLZiOmMIZBiICM3M2eglhm4bvtP8Pi8fHlvEPuD4Lyr1JllrAnJrwu7mH39EayC+zcwi2+ZctkkpY+NLqWhTif/qkVEaAfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwfTg4N6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwfTg4N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B921C4AF0F
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 08:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763713446;
	bh=HDm+cQ3E57Rw/aW22/2o/8DFD56OTcZLebchCcKA30k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EwfTg4N66L5B8/nM+2BVV2mkYqrpKTvpzjVCrNXZsdKP4fIaAaxOQEC5mVNn5iUBF
	 kd69Z9TklSKdY4Rb3w+Wiohjp5m9aV3E6qX9UBRbMcVjGGnkjbxBfwpyHOJDQMdHvd
	 rp1nkMrJ/TIHEYrwTEkzDOCqDq5BogoP4ZwQB1O7EoMvRB0WdokHeD693br30F1fB/
	 I1Q8u1Yt+6hz8jsLqS59MY0mTOVLfAMlccV2ZqXuZT6IlnKkidYlF/VQhXODM8ujlo
	 RwOfeu0C4FL47dw7dgeFEFjCBYs1hepbUcnPtG0axIyL31Or4GjKYQXG4P1OXYg2LT
	 NqHJe05O01bUQ==
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso1407580f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 00:24:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEwHQ54jC1lR6nJG1dJ0zy9ht2/tyWCY6c7TD9pU9wsQbgGaCgYYZnDPnlNnJNo4hsAyXTPF7xyHIZ//X0/nSN@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdJeZ2XS/cP0EmQIE6aw+/rn3T+4MbnDyoT8S0OKRjSLNRL0w
	DfSkQfCQcKrkZNGNZEderk4nKznnRTIjOcZ5nU6NuT3eaDj/xhqnPUGyXSZiNeQvQNESTVJw9/0
	xagdHRFER9y0eg7IMy9xoDXv6ZnGV6wk=
X-Google-Smtp-Source: AGHT+IF50+ZT25khXCr5BWbB5f955K3EzGSR5+akTKTO8ruIBzLrBr5HyMTCxBOFOObMcHXPXDQuQGeq69WN85GtTKY=
X-Received: by 2002:a05:6000:144c:b0:42b:2f3d:2967 with SMTP id
 ffacd0b85a97d-42cc1d3a3cbmr1162815f8f.51.1763713445114; Fri, 21 Nov 2025
 00:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121063439.2545-1-cp0613@linux.alibaba.com> <20251121063439.2545-3-cp0613@linux.alibaba.com>
In-Reply-To: <20251121063439.2545-3-cp0613@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 21 Nov 2025 16:23:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ2SLj0hhQ0PXYECd+soKGN0TNmx38sVpO0iN_mHEXyRQ@mail.gmail.com>
X-Gm-Features: AWmQ_bn6YgxX0unEboOo_dGjgAu7Fy2rOtRVLHuIL5-VjcuP9Bd0OZCqE0sqPbE
Message-ID: <CAJF2gTQ2SLj0hhQ0PXYECd+soKGN0TNmx38sVpO0iN_mHEXyRQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: riscv: Add XuanTie C930 CPU compatible
To: cp0613@linux.alibaba.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:35=E2=80=AFPM <cp0613@linux.alibaba.com> wrote:
>
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> Update Documentation for supporting XuanTie C930.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 153d0dac57fb..581a95eba932 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -65,6 +65,7 @@ properties:
>                - thead,c908
>                - thead,c910
>                - thead,c920
> +              - xuantie,c930
Yes, c930 belongs to XuanTie, not T-HEAD.

Reviewed-by: Guo Ren (Alibaba Damo Academy) <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
