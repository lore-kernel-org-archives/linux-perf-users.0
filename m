Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792528382;
	b=lwswTfZc884wUsV+w2DU82tpRuFPQORbBp6WNv2L5IEsxLUrsXpR3kY5jmbQQWuRMCXD
	 F7xKwTTZ0gOkdwR9qk6VFACS1c3pAnKZDjSAQ2Dey/3gQtF7aIfVrr892Ynudw2CVi6Os
	 w228Vy8uHh6LD9iqWyml5hsSr9MYPvmxZJ1NM3riY505BSa0Bcr3d6NFHAJS/frNRC1fW
	 X4RDXPrd9hjOR5l6Xne4+9q2Hh+kJN/YXw6TjAjy/faUdwPvwwdxKnJL+KLyG808ietnD
	 6UkyM9xIMVYNbqHnDM7ut/dqDAGNaLrS0iSfTJoDJwHyTVXHyR7r4OSxGMNIPqoOmfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QMefv3/6k9FkgL+3cbApnvKoEevqgboVZWdJy3KQ1RU=;
	b=y6Yx5Qh6BB9hqLqref3I/6a94itVHKi4T1lULpfSRAy4//cB/XBiTG/Hp4tampKGLLNp
	 opp5CK+poVnLws541rP9uCzxCWdqsx9D1Lnv1ruRZWRhIOJlc94O6xqsvUoxk8pYL5w2Q
	 kKRkUNlyFmasqeWFsiWpIjebQ5QR4rlSLL6Ho1MuWfPWhBL41yBiz0G2f3DeYLJ4ON/op
	 Lp9KXMGgMiqtVng3wGZP/KuwgUpDLOgC2BA2xSrdg9oNFI507YTUNZF3aMkUGT52FqN0L
	 icLKhdjcqWTAed5nouDuFK5HAC7ubcxICnC9jv8DvoDpC3ACVvGpj6uVLuY2X/1NpNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=INaSu8fI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78959606A31F
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 20:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78959606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=INaSu8fI
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337c7b9937so83521cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 13:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792528380; cv=none;
        d=google.com; s=arc-20260327;
        b=KBCSzxCeXjMZvuoHw5rxEhp7As/jSkEUTeK5get/9pb/111BlFo4o6qPzRFp+Pejd/
         fZ5z7VhfuVe/LAedazVQUo3tJoFtxF3PlazO98J+6IK8BFXhWNXsQij4Eos7gD7AxJsx
         P59DR7CtIA3KfvSF+rl67cZ9BB3WRU8ZT221HYN/SGBAUm7bnWLhSQPJiVjxFknFJng0
         suEZMG6Mew7f7qWkX3dbTBYq2m2lEwBMTTHlSC9OkZPRJel1b5NJND9pzgjGKKlBldKN
         TsKCo3KMLgScvbejhipqP12WjTG9ifazq/BKIo0DHn6UXAkF2lbdAamRyMSTRo6qUYBC
         mD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QMefv3/6k9FkgL+3cbApnvKoEevqgboVZWdJy3KQ1RU=;
        fh=1j4EqUCeo9u3uLBNXj2Y1vZrJzt0H8/inFX8s179Hxg=;
        b=lUYAqpSq+jYnmuHXWJgh1HNzlQdppghG/zTm0slNXR4svajXhCZWlWEUm2NiGJAxWo
         SbFopbfjsJ88XfMLqIqI0WdImgkXmqHuum7vyFxgLCjWnp6K5tDf0UhBYDXthXIWKZCo
         pZ1TzY/Y7Pa27+cQb47b9b8usGbB4tIBwzR0WvEPfb4hY+mauzzzpnaBTvwU8ku2GAhj
         BzhAp1M0817iF0pIrYZBNMcCbsiYJnK7JQYuUEoz8yMn0C+BiF4wChU6oV/0noIjeDSs
         Y1IrzJVvTvkVAaVsX10SR5scyu0vncGvUIbVS93g6nAwABBD+Gc/ZPXbkznaf0GqOeTg
         WJxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792528380; x=1793133180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QMefv3/6k9FkgL+3cbApnvKoEevqgboVZWdJy3KQ1RU=;
        b=INaSu8fI/7lJBJ0KTHaoc6xXLKw/+UVbNqMVNmC0u3YPecgPvG7my29CGG2Hf86BRl
         UohI/DvxwBADAiDrGI7Mo7R4ayl47O2Df2mGk2mBN3zupJ3q/D+Lwyqd/66bU8J0N1uy
         sr5QnQO4M+IwF6/P2lwJO31Xo6RDR+NNZMDcAL2ds0LuSZAj5Y034e/HUIGdO75taV18
         hcaxzj+JdGcisLATb70lncWRDsJkkjxRhhpWsejh2R5gQgzl6VTY2YKqdlPdMSHPd4Q9
         zFXbSfbj42NLZ8+s3WdSCUl5szgPNA0/UUKA26SntDhmhjTJwJXF+FicjSHwMHyXNPxN
         4ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528380; x=1793133180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMefv3/6k9FkgL+3cbApnvKoEevqgboVZWdJy3KQ1RU=;
        b=dZaw4xdy3Be3m7IkX7Jrvqd0/oaHysy50T49C0Fg8tg8dGz3XWZ+hAYR23sgaGMZXN
         s8qpE3uqbDZDgMlsxQrHrTZPsuEsQ/7a9ED3mmuL4/kKHhJdsbd65J1SSccilkuu+GZr
         R1VU/HpCTf2vD3pGNdLoGw6kH9KdgRs1UyrHt/2e4u71u2C+QJJYJ9hdYudCPqwmBfrq
         FhJapUbFWgnAEZyMDbleZwGTV+CtOo7tOgjE1HB3nrXx5onYSBYCT3zqJssfhRqHAl+0
         nHnBwbIv8gtZ0oc8Zz5Uyl8n1rLYeU1oa4w7KVLwsKVG+8E+/pVwBnJtshXuGldNtSKX
         otRQ==
X-Forwarded-Encrypted: i=1; AKwUvByZgifFM1I4ykO8QWenG2mnE/MKJibEvurtGNAZ+cEpTyB2PrXPFeqiUbjlqoLYZy33aZ1bT5al9hWveH+/s4pp@vger.kernel.org
X-Gm-Message-State: AFq9FYIvccnGQ8iqb41lgleX2z5Zyj9GOBnqY4KDHUc1HvIY0gMSmLB0
	mgJKIMe6F2OW9bUGpfOzsxXsAXvBmTTBQUPJ9Oj5Lil4zk/ARNW7xA+0Uan3Yu42WthJ8JmvXtQ
	JGE77hqoWeUNgpY/fMujGIyqVegZFcWcYWwWKYPM6
X-Gm-Gg: AYBFou3Tb/6dWe/aLC73t+9zsn2JjIuPyErhA6ZoZCyhwGN+b/9Qx7ctKEJ2H25ukw3
	/pEfVm0PC17KUeoAC64lurIGAH16zL+K/xfn3RzGcK6+KvcGs2XuAIr5f4Qj5jRuB6XUCHk9pPj
	h6JpifVRWIisbm4+c6oC9cCsV0fwyek9kFLQkGU56UOYt3DP/TYfusmRc6beiVXJONJMlEMZ3rk
	nfrxx+wbD+OTTMVv5/L9s9Bti3CF/mwhPZQzQdreDJd5O2S7588por3lx6atDn7vZx8MuKBfHUF
	hWplKFGvG2Vi49ruwpVJOyr7d9OviOspwGSBvIPSkWDwcM4WKydemKuLBTMweI5bZxmQgNZhbpl
	zZ5KGc2m8kg==
X-Received: by 2002:a05:622a:1b9f:b0:535:9aa3:5ebb with SMTP id
 d75a77b69052e-536882804d2mr9529261cf.8.1792528379608; Tue, 20 Oct 2026
 13:32:59 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <21f58af0-fa3f-41c5-ab03-216c60fbe2f1@linaro.org> <ate93zQFkfAecIv2@x2>
In-Reply-To: <ate93zQFkfAecIv2@x2>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Oct 2026 13:32:48 -0700
X-Gm-Features: AclHuK9CSuFZK-b6UAodiXJykR-dvBn1qDmPctgNXXAV69jhyRNTIACuSsADFoU
Message-ID: <CAP-5=fXUMVJwtAp+8dA8V=hBD9q4x6J4YiUufwXAOXcAJoAKTg@mail.gmail.com>
Subject: Re: [PATCH 0/6] perf jevents: Add NVIDIA Tegra410 uncore PMU events
 and metrics
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>, namhyung@kernel.org, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com, mochs@nvidia.com, 
	rajjoshi@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com, 
	john.garry@linux.dev, will@kernel.org, mike.leach@arm.com, leo.yan@linux.dev, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, ctshao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:15=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Oct 19, 2026 at 06:23:16PM +0100, James Clark wrote:
> > On 19/10/2026 17:42, Besar Wicaksono wrote:
> > > Add event aliases and derived metrics for the NVIDIA Tegra410 uncore
> > > PMUs.
>
> > Reviewed-by: James Clark <james.clark@linaro.org>
>
> Thanks, applied to perf-tools-next, for v7.4.

Hi Arnaldo,

can we not take these in v7.4 as there is unaddressed feedback:
https://lore.kernel.org/linux-perf-users/CAP-5=3DfWucvdYefDOL3Vn=3DO=3DYUPE=
XE+tngDDfPLv-T5i3WkCJVA@mail.gmail.com/

The specific problem is that the NVidia PMUs have adopted a convention
not supported by the perf tool of 'pmu_name_<socket>_rc_<num>'. rc
stands for root complex. What ends up happening is that aggregation is
broken as the json is claiming that pmu_name is the PMU's name while
the suffix perf_pmus code thinks pmu_name_<socket>_rc is the pmu name.
They've wrangled support via the json by claiming these are sys
events.

We can either:
1) support a new suffix convention of <num>_rc_<num>
2) push back and ask the driver writers to name their PMU correctly as
defined in the ABI:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/ABI/testing/sysfs-bus-event_source-devices

If we do (1) then it would be nice if the support for that could be
contained in this patch series. In any case these events don't belong
in sys.

Thanks,
Ian

> - Arnaldo
