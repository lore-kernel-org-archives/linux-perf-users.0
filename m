Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233A2D7DE5
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395260; cv=none; b=t67m/3ZGS2xIlnJuBFdQsjOxbuuiePwRxLsPTNX1LFoJdKeYM4fIHvMvelMWNIw8188Tz/Ou/YrEFJYwcXcXbHFtP5oYmLct/g2xTlUyKkeEkrnu0oaTwIlOdYRV2+NrWEoZOgqgAIJTihi1bqCPrrfHL2xnkeyMAzqiur7ena4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395260; c=relaxed/simple;
	bh=6B3K1VEohuDa2fuwXUpyKZdV1UfNnP+FFNPVNqcF+uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaUZxqzZ2cHh3YvX8CIobJ/MeyBtJFP53H1yqyoNClk96MLe+irfcYYZX1yht+W1Dd8KdpDgzoWAdgbSpRUh9XrCIUfGIu8nDhWe7swrAhoyByMLl3tOlvYLKnmxHae7+QIw0v0T9XDHMlQ8zvXgJ28W4Dm4Gjn5Gc84joFxKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EbyTRqax; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EbyTRqax"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8599c274188so561405385a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760395257; x=1761000057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtxL+uYHTrxBSaf2VJ6n4z+smdSSDd5JBl8pS6dLFSc=;
        b=EbyTRqaxXYXOeYcoL6PLX+PswC1EZSX1EjYdPpM2aWZQQkXb1pl8EQPBuDIdFl92D9
         cUTkhCpeMgx4wPt6eOIUZ7/1mL75Loi7DS+eEY+C+uTrTkdtEsmT0yaqVxyde5afBvAu
         zJkUbrwMVKpnOCly3mauzAPZ6ivk4sKHNVbqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760395257; x=1761000057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtxL+uYHTrxBSaf2VJ6n4z+smdSSDd5JBl8pS6dLFSc=;
        b=JVBoSpVBjas1a9ov28b5XRLzvUqNBzdegxueodqxWRD5i7olAuvi9F+mDw8kP0lATX
         lWTWZLqFDyiFGJHK8OReccjAzw6pPahfLspFn/JTRW3ztYggBQovncniHMEi+5lFkzz4
         I4cL/4qGvS0AVtNh5XHCh7iQKQhFTsWCLfJB7FxSOGEu3S1FEDDY7nMgIamBJJV/h53o
         NDneOJDan0fgemc2FSeboL3pHno49SfTs0huuOSlPOdqllCQLwl6mSeKqknAvaH7ksWu
         vNoSxMd6e2pj2hBIPJn6ncdBGO1ijxpi/H25UEXyrLYA1YOC84pLl65YE9rBTczIcEJI
         q/rg==
X-Forwarded-Encrypted: i=1; AJvYcCWFgIhANYfRl8UAxwPr13XjOzNRcuhXow4wp9xmQKakWuyFGhONCIIZV3ajQ3Sm7NPiw1odYQwZ9elhnWIuVqMe@vger.kernel.org
X-Gm-Message-State: AOJu0YzR2ie3WNlcbAOgm+Y+fx0Z8G/dQIbveRydUZ2D3hvET3/qxm2Y
	X0eaUR/RHXbldX6FmSvi0/piDS0pn9Qyu6kzHoOe4OAfLIAWHXg9nDfUO4MOFPfKfj0n7zrPp0X
	Egb4=
X-Gm-Gg: ASbGncuB1ILanHwNmbkf+5UX1vchdv7poxFOcZv8/ioCMfYC/K7oSODzMhR8uMtlTXQ
	ZJaMehHBwW+zmiK5xcnYzGmesaeT49gcP80QaiTl7Gj2QUCv/+8bzK/ijh9sGkZUpAxP9GrmObh
	tq+6Q4OSZ8ef/9uz9a0F1ncRznUFJtroDwv/AIPWshfoQpkY2H7S3KL29xFMIFiBmMDybvcvH9i
	bSOyBP0BpDjWVLnV2VoEmlr5sZ6JiHAS4X6JNUXiLfD2DEfNnB1U/+/PmzEm8RLmpc84boTZoh/
	fP0v0rGVlv7Wd8BgRSbu+kZZh5aSTlDRJrigA07nfx+GW/QoeucJlkW+FRGpIjfV1hMDGmxsoBL
	pyE7dw+XgWtL5Uhfl6j/GzgcjiGZWYgw/dhtlcxHcJ79dExVJvu7qc5WQzwYJSbczRwCY2ojU+S
	PaIReX
X-Google-Smtp-Source: AGHT+IEECYucFq8Oqc+nTmtOAXn2oSaAoYtSQSoR6xGDShYUb5Uds+mwNhtE4mzFXUlrFjowqMJOXA==
X-Received: by 2002:a05:622a:1f0b:b0:4cf:8fa2:ccd2 with SMTP id d75a77b69052e-4e6eacb3b68mr355621091cf.13.1760395256886;
        Mon, 13 Oct 2025 15:40:56 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706dad3c3sm83566801cf.35.2025.10.13.15.40.54
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:40:55 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-799572d92b0so61539236d6.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 15:40:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsu6UjZqb9Yyjop1vV2s1B+jWzpZ8vSvIQPFph6XBt47Dxl6YUDUieyxc9M4mTaw4AP6Y5WYmzpVSRXryGzDiT@vger.kernel.org
X-Received: by 2002:a17:902:ebc5:b0:267:bd8d:19e with SMTP id
 d9443c01a7336-290273799f8mr248133945ad.22.1760394928761; Mon, 13 Oct 2025
 15:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009032838.63060-1-cuiyunhui@bytedance.com> <20251009032838.63060-3-cuiyunhui@bytedance.com>
In-Reply-To: <20251009032838.63060-3-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 Oct 2025 15:35:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRp9=5yxR3Q1UhJhBS-wm59yssozKi55W7HGk+S94AjQ@mail.gmail.com>
X-Gm-Features: AS18NWD-PlH4jDf4beOYtPWdSx7chQ77jPK1vKggaxR4OltLXyHgtJF5jyN2qPw
Message-ID: <CAD=FV=XRp9=5yxR3Q1UhJhBS-wm59yssozKi55W7HGk+S94AjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	johannes@sipsolutions.net, lihuafei1@huawei.com, mark.rutland@arm.com, 
	masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 8, 2025 at 8:29=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/Kconfig           |  4 ++++
>  drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
